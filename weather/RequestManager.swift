//
//  RequestManager.swift
//  weather
//
//  Created by Antoine Demailly on 15/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import Alamofire
import SwiftLocation
import CoreLocation

typealias WeatherDailyData = Array<Dictionary<String, Any>>
typealias WeatherHourlyData = Array<Dictionary<String, Any>>
typealias WeatherResponse = Dictionary<String, Any>

/// Request Manager to make HTTP Calls to weather server
class RequestManager {
    static let sharedInstance = RequestManager()
    
    private let apiKey = "d5713078b87ac92980fd145dde009d50"
    private let host = "https://api.darksky.net/forecast"
    
    func fetchWeather(coordinates: CLLocationCoordinate2D, onSuccess success: @escaping (WeatherResponse) -> Void, onError error: @escaping (String) -> Void) {
        var strRequest = "\(host)/\(apiKey)/"
        strRequest += "\(coordinates.latitude),\(coordinates.longitude)"
        
        strRequest += "?lang=fr&units=si"
        
        print(strRequest)
        

        Alamofire
            .request(strRequest)
            .responseJSON { response in
                guard let JSON = response.result.value as? Dictionary<String, Any> else {
                    error("No data, or corrupted")
                    return
                }
                
                //guard let daily = JSON["daily"] as? Dictionary<String, Any>,
                //    let dailyData = daily["data"] as? WeatherArray else {
                //        error("Request Manager -> Can not map from \(strRequest)")
                //        return
                //}
                
                success(JSON)
        }
    }
}
