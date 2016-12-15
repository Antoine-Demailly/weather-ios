//
//  WeatherDetailHourlyCollectionCell.swift
//  weather
//
//  Created by Antoine Demailly on 06/12/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailHourlyCollectionCell: UICollectionViewCell {
    static let identifier = "WeatherDetailHourlyCollectionCellIdentifier"
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
    }
}
