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
    var forecast: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let colors = GradientColors()
        self.view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer.frame = self.view.frame
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
    }
}

extension WeatherDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0, let cell = cell as? WeatherDetailFirstCell {
            cell.cityLabel.text = "Paris"
            cell.temperatureLabel.text = "11°"
            cell.summaryLabel.text = "Venté jusque dans la soirée et nuages épars dans la matinée."
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
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailFirstCell.identifier, for: indexPath)
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: WeatherDetailHourlyCell.identifier, for: indexPath)
    }
}
