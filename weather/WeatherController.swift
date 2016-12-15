//
//  MainController.swift
//  weather
//
//  Created by Antoine Demailly on 15/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit
import SwiftLocation
import CoreLocation

class WeatherController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: WeatherTableView!
    
    var currentCoordinates: CLLocationCoordinate2D?
    var locationManager: CLLocationManager!
    var refreshControl: UIRefreshControl!
    var dailyWeather: WeatherDailyData?
    var hourlyWeather: WeatherHourlyData?
    var currentlyWeather: Dictionary<String, Any>?
    
    static var city: String = "Inconnu"
    
    enum Days: Int {
        case Dimanche = 1
        case Lundi
        case Mardi
        case Mercredi
        case Jeudi
        case Vendredi
        case Samedi
        
        var string: String {
            return String(describing: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Personnalisation de la navigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        // Background dégradé
        //let colors = GradientColors()
        //self.view.backgroundColor = UIColor.clear
        //let backgroundLayer = colors.gl
        //backgroundLayer.frame = self.view.frame
        //self.view.layer.insertSublayer(backgroundLayer, at: 0)
        
        setBackground(icon: "loading")
        
        // define pull to refresh
        self.setPullToRefresh()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        
        _ = Location.getLocation(withAccuracy: .block, onSuccess: { foundLocation in
            let coordinates = foundLocation.coordinate

            _ = Location.reverse(coordinates: coordinates, onSuccess: { foundPlacemark in
                WeatherController.city = foundPlacemark.locality ?? "Inconnu"
                
                self.currentCoordinates = coordinates
                self.fetchWeather(coordinates: coordinates) {}

            }) { error in
                // failed to reverse geocoding due to an error
            }
        }) {   (lastValidLocation, error) in
            print(error)
        }
        
        _ = Location.reverse(address: "Clermont", onSuccess: { foundPlacemark in
            print("Clermont")
            print(foundPlacemark.location ?? "Inconnu")
        }) { error in
            // failed to reverse geocoding due to an error
        }
    }
    
    func setBackground(icon: String) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"\(icon)-background")!)
    }
    
    func fetchWeather(coordinates: CLLocationCoordinate2D, onSuccess: @escaping () -> Void) {
        RequestManager.sharedInstance.fetchWeather(coordinates: coordinates, onSuccess: { (result) in
            if let daily = result["daily"] as? Dictionary<String, Any>,
               let dailyData = daily["data"] as? WeatherDailyData,
               let hourly = result["hourly"] as? Dictionary<String, Any>,
               let hourlyData = hourly["data"] as? WeatherHourlyData,
               let currently = result["currently"] as? Dictionary<String, Any> {
                self.dailyWeather = dailyData
                self.hourlyWeather = hourlyData
                self.currentlyWeather = currently
                
                onSuccess()
                self.reload()
            }
            
        }) { (error) in
            print("Error => \(error)")
        }
    }
    
    func setPullToRefresh() {
        refreshControl = UIRefreshControl()
        
        // Change la couleur du loader
        refreshControl.tintColor = UIColor.white
        
        // Définis la couleur et le titre du pull to refresh
        let attributes = [NSForegroundColorAttributeName: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Rafraichir la météo", attributes: attributes)
    
        // Lors du pulltorefressh on appelle la fonction onPullToRefresh
        refreshControl.addTarget(self, action: #selector(onPullToRefresh(sender:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func reload() {
        let icon = self.currentlyWeather?["icon"] as? String ?? "clear-day"
        setBackground(icon: icon)

        self.tableView.reloadData()
    }
    
    func onPullToRefresh(sender:AnyObject) {
        if let coordinates = self.currentCoordinates {
            self.fetchWeather(coordinates: coordinates) {
                self.refreshControl.endRefreshing()
            }
        }

        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherDetail", let forecast = sender as? [String:Any]  {
            if let vc = segue.destination as? WeatherDetailController {
                vc.city = WeatherController.city
                vc.forecast = forecast
            }
        }
    }
}

extension WeatherController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data: Dictionary<String, Any> = [:]

        data["daily"] = self.dailyWeather?[indexPath.row]

        if indexPath.row == 0 {
            data["isCurrentDay"] = true
            data["hourly"] = self.hourlyWeather
            data["currently"] = self.currentlyWeather
        }

        self.performSegue(withIdentifier: "weatherDetail", sender: data)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0, let cell = cell as? WeatherFirstCell {
            guard let temperature = self.currentlyWeather?["temperature"] as? Int,
                let summary = self.currentlyWeather?["summary"] as? String else {
                return
            }
            
            cell.cityLabel.text = WeatherController.city
            cell.temperatureLabel.text = "\(temperature)°"
            cell.summaryLabel.text = summary
        } else {
            let cell = cell as? WeatherCell
            
            guard let objWeather = self.dailyWeather?[indexPath.row],
                let time = objWeather["time"] as? Int,
                let temperatureMin = objWeather["temperatureMin"] as? Int,
                let temperatureMax = objWeather["temperatureMax"] as? Int else {
                    return
            }
            
            let temperature = (temperatureMax + temperatureMin) / 2
            let day = getDayOfWeekFromTimestamp(time: time)
            cell?.temperatureLabel.text = "\(temperature)°"
            cell?.summaryLabel.text = day
        }
    }
    
    func getDayOfWeekFromTimestamp(time: Int)-> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time));
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: date as Date)
        let weekDay = myComponents.weekday
        
        if let day = Days(rawValue: weekDay!) {
            return day.string
        }

        return "Inconnu"
    }
}

extension WeatherController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(WeatherFirstCell.cellHeight)
        }
        
        return CGFloat(WeatherCell.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherFirstCell.identifier, for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath)
        return cell
    }
}
