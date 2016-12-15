//
//  File.swift
//  weather
//
//  Created by Antoine Demailly on 18/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailController: UIViewController {
    var city: String = ""
    var forecast: Dictionary<String, Any>?
    var hourly: WeatherHourlyData?
    var isCurrentDay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let colors = GradientColors()
        //self.view.backgroundColor = UIColor.clear
        //let backgroundLayer = colors.gl
        //backgroundLayer.frame = self.view.frame
        //self.view.layer.insertSublayer(backgroundLayer, at: 0)
        
        if let daily = forecast?["daily"] as? Dictionary<String, Any> {
            print("background")
            let icon = daily["icon"] as? String ?? "clear-day"
            print("icon: \(icon)")
            setBackground(icon: icon)
        }
    }
    
    func setBackground(icon: String) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"\(icon)-background")!)
    }
}

extension WeatherDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0, let cell = cell as? WeatherDetailFirstCell, let daily = forecast?["daily"] as? Dictionary<String, Any> {
            cell.cityLabel.text = city
            cell.temperatureLabel.text = "11°"
            cell.summaryLabel.text = daily["summary"] as? String
            
            if isCurrentDay == false {
                cell.hourByHourLabel.textColor = UIColor.clear
            }
        } else if indexPath.row == 1 && isCurrentDay  {
            if let cell = cell as? WeatherDetailHourlyCell, let hourly = forecast?["hourly"] as? WeatherHourlyData {
                cell.hourly = hourly
            }
        }
    }
}

extension WeatherDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(WeatherDetailFirstCell.cellHeight)
        }
        
        return 70.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        isCurrentDay = forecast?["isCurrentDay"] as? Bool ?? self.isCurrentDay
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailFirstCell.identifier, for: indexPath)
            
            return cell
        } else if (isCurrentDay && indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailHourlyCell.identifier, for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailInfoCell.identifier, for: indexPath)
            return cell
        }
    }
}
