//
//  WeatherFirstCell.swift
//  weather
//
//  Created by Antoine Demailly on 15/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherFirstCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    static let cellHeight = 450.00
    static let identifier = "WeatherFirstCellIdentifier"
    
    override func awakeFromNib() {
        self.frame.size.height = CGFloat(WeatherFirstCell.cellHeight)
        self.backgroundColor = UIColor.clear
        self.selectedBackgroundView = UIView()
    }
}
