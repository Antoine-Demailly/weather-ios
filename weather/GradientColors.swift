//
//  GradientView.swift
//  weather
//
//  Created by Antoine Demailly on 21/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class GradientColors {
    // 27,24,103  /  38,141,201
    let colorTop = UIColor(red: 27.0/255.0, green: 24.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 38.0/255.0, green: 141.0/255.0, blue: 201.0/255.0, alpha: 1.0).cgColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}
