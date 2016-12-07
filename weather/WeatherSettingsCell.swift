//
//  WeatherSettingsCell.swift
//  weather
//
//  Created by Antoine Demailly on 01/12/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherSettingsCell: UITableViewCell {
    @IBOutlet weak var historyLabel: UILabel!

    static let identifier = "WeatherSettingsCellIdentifier"

    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.historyLabel.textColor = UIColor.white
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
