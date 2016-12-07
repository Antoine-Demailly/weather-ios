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
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
    }
}

extension WeatherDetailHourlyCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = WeatherDetailHourlyCollectionCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
}
