//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Anıl Karadağ on 26.02.2023.
//

import Foundation

protocol WeatherManagerDelegation{
    func weatherDataFetched(_ weatherDataModel: WeatherDataModel)
}

struct WeatherManager{
    
    static let apiKey = "13f2067a6b8844924295b3ed667630f6"
    static let units = "metric"
    var url = "https://api.openweathermap.org/data/2.5/weather?units=\(units)&appid=\(apiKey)"
    var delegate : WeatherManagerDelegation?
    
    func fetchWeather(_ cityName:String){
        let fullUrl = "\(url)&q=\(cityName)"
        sendRequest(fullUrl)
    }
    
    func sendRequest(_ fullUrl: String){
        if let url = URL(string: fullUrl){
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: url) { data, response, error in
                
                if  error != nil{
                    print("DataTask Error!")
                    return
                }
                
                if let checkedData = data{
                    if let weatherDataModel = self.parseJSON(weatherData: checkedData){
                        
                        DispatchQueue.main.async {
                            self.delegate?.weatherDataFetched(weatherDataModel)
                        }
                    }
                }
            }
            
            dataTask.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherDataModel?{
        let decoder = JSONDecoder()
        do{
            let decodedModel = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedModel.weather[0].id
            let temp = decodedModel.main.temp
            let name = decodedModel.name
            let weatherDataModel = WeatherDataModel(id: id, name: name, temp: temp)
            print(temp)
            return weatherDataModel
            
        } catch{
            print("Json parsing error")
            return nil
        }
        
    }
    
    
}
