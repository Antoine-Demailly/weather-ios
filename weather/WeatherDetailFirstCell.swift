//
//  WeatherDetailFirstCell.swift
//  weather
//
//  Created by Antoine Demailly on 02/12/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailFirstCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var hourByHourLabel: UILabel!
    
    static let cellHeight = 300.00
    static let identifier = "WeatherDetailFirstCellIdentifier"
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
    }
}
