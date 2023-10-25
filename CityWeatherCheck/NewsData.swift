//
//  WeatherData.swift
//  CityWeatherCheck
//
//  Created by Aset Bakirov on 24.10.2023.
//

import Foundation
import SwiftyJSON

struct NewsData {
    var title = ""
    var score:Int = 0
    var time:Int = 0
    
    init(json: JSON) {
        if let item = json["title"].string {
            title = item
        }
        if let item = json["score"].int {
            score = item
        }
        if let item = json["time"].int {
            time = item
        }
    }
}
