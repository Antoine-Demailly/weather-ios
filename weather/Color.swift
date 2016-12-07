//
//  RGB.swift
//  weather
//
//  Created by Antoine Demailly on 21/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class Color {
    let color: UIColor
    let cgColor: CGColor
    
    init(r: Int, g: Int, b: Int) {
        self.cgColor = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0).cgColor
    
        self.color = UIColor(cgColor: self.cgColor);
    }
}
