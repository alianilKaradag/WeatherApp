//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Anıl Karadağ on 26.02.2023.
//

import Foundation

struct WeatherDataModel{
    
    let id: Int
    let name: String
    let temp: Double
    
    var tempString: String{
        return String(format: "%.1f", temp)
    }
    
    var weatherStatus: String{
        switch id{
        case 200...299:
            return Constants.bolt
        case 300...399:
            return Constants.drizzle
        case 500...599:
            return Constants.rain
        case 600...699:
            return Constants.snow
        case 700...799:
            return Constants.fog
        case 800:
            return Constants.sun
        case 801...900:
            return Constants.bolt
        default:
            return Constants.cloud
        }
    }
    
    init(id: Int, name: String, temp: Double) {
        self.id = id
        self.name = name
        self.temp = temp
    }
    
}
