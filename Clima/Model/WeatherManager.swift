//
//  WeatherManager.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 29.04.2023.
//

import Foundation

protocol WeatherManagerDelegate {
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
	func didFailWithError(error: Error)
}

struct WeatherManager {
	private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=20a639cd62705e00b56f4912c0e3dc98&units=metric"
	
	var delegate: WeatherManagerDelegate?
	
	func fetchWeather(cityName: String) {
		let urlString = "\(weatherURL)&q=\(cityName)"
		performRequest(with: urlString)
	}
	
	private func performRequest(with url: String) {
		guard let url = URL(string: url) else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { data, response, error in
			if error != nil {
				delegate?.didFailWithError(error: error!)
//				print(error!)
				return
			}
			
			if let data = data {
//				let dataString = String(data: data, encoding: .utf8)
//				print(dataString)
				guard let weather = parseJSON(data) else { return }
				delegate?.didUpdateWeather(self, weather: weather)
			}
			
		}
		task.resume()
	}
	
	func parseJSON(_ weatherData: Data) -> WeatherModel? {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
			let id = decodedData.weather[0].id
			let temp = decodedData.main.temp
			let name = decodedData.name
			
			let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
			
//			print(weather.conditionName)
//			print(weather.temperatureString)
			
			return weather
		} catch {
			delegate?.didFailWithError(error: error)
//			print(error)
			return nil
		}
	}
}
