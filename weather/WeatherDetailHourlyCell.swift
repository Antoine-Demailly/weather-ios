//
//  WeatherDetailHourlyCell.swift
//  weather
//
//  Created by Antoine Demailly on 02/12/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailHourlyCell: UITableViewCell {
    static let identifier = "WeatherDetailHourlyCellIdentifier"
    @IBOutlet weak var hourlyCollectionView: UICollectionView!

    var hourly: WeatherHourlyData?
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.hourlyCollectionView.reloadData()
    }
}

extension WeatherDetailHourlyCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? WeatherDetailHourlyCollectionCell {
            let temperature = hourly?[indexPath.row]["temperature"] as? Int
            cell.temperatureLabel.text = "\(temperature!)°"
        }
    }
}

extension WeatherDetailHourlyCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = WeatherDetailHourlyCollectionCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
}
