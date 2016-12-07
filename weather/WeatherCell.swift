//
//  WeatherCell.swift
//  weather
//
//  Created by Antoine Demailly on 15/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    static let identifier = "WeatherCellIdentifier"
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    static let cellHeight = 80.0
    
    override func awakeFromNib() {
        self.backgroundColor = Color(r: 34, g: 37, b: 44).color
        self.selectedBackgroundView = UIView()
    }
}

