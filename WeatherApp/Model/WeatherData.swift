//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Anıl Karadağ on 26.02.2023.
//

import Foundation

struct WeatherData : Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main : Decodable{
    let temp: Double
}

struct Weather : Decodable{
    let id: Int
}
