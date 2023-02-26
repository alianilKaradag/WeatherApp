//
//  ViewController.swift
//  WeatherApp
//
//  Created by Anıl Karadağ on 26.02.2023.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegation {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchText: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.delegate = self
        weatherManager.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
        weatherManager.fetchWeather("izmir")
    }

    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchText.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchText.text{
            weatherManager.fetchWeather(city)
        }
        searchText.text = ""
    }
    
    func weatherDataFetched(_ weatherDataModel: WeatherDataModel){
        tempLabel.text = weatherDataModel.tempString
        cityLabel.text = weatherDataModel.name
        weatherImage.image = UIImage(systemName: weatherDataModel.weatherStatus)
    }
    
}

