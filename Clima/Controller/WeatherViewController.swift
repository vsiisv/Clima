//
//  ViewController.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 17.04.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
	
	private var weatherManager = WeatherManager()
	private let locationManager = CLLocationManager()
	
	// MARK: - Views
	
	private let degreeLabel = UILabel(fontSize: 80, weight: .bold)
	private let symbolDegreeLabel = UILabel(fontSize: 100, weight: .light)
	private let typeDegreeLabel = UILabel(fontSize: 100, weight: .light)
	private let cityLabel = UILabel(fontSize: 30, weight: .regular)
	
	private let backgroundImage = UIImageView(imageName: "background")
	private let conditionsImage = UIImageView(imageName: "sun.max", tintColor: .label)
	
	private let searchView = SearchView()

	private lazy var mainStackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .trailing
		stackView.distribution = .fill
		stackView.spacing = 10
		stackView.contentMode = .scaleToFill
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private lazy var degreeStackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 0
		stackView.contentMode = .scaleToFill
		return stackView
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubviews()
		setupConstraints()

		searchView.delegate = self
		weatherManager.delegate = self
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
	}
}

// MARK: - Layout and add subviews

extension WeatherViewController {
	private func addSubviews() {
		view.addSubview(backgroundImage)
		view.addSubview(mainStackView)
		mainStackView.addArrangedSubview(searchView)
		mainStackView.addArrangedSubview(conditionsImage)
		mainStackView.addArrangedSubview(degreeStackView)
		mainStackView.addArrangedSubview(cityLabel)
		degreeStackView.addArrangedSubview(degreeLabel)
		degreeStackView.addArrangedSubview(symbolDegreeLabel)
		degreeStackView.addArrangedSubview(typeDegreeLabel)
	}
	
	private func setupConstraints() {
		backgroundImage.translatesAutoresizingMaskIntoConstraints = false
		conditionsImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			conditionsImage.heightAnchor.constraint(equalToConstant: 120),
			conditionsImage.widthAnchor.constraint(equalToConstant: 120),
			
			mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			
			searchView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
			searchView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
		])
	}
}

// MARK: - Search View Delegate

extension WeatherViewController: SearchViewDelegate {
	func getLocation() {
		locationManager.requestLocation()
	}
	
	func getCity(city: String) {
		weatherManager.fetchWeather(cityName: city)
	}
}

// MARK: - Weather Manager Delegate

extension WeatherViewController: WeatherManagerDelegate {
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
		DispatchQueue.main.async {
			self.degreeLabel.text = weather.temperatureString
			self.cityLabel.text = weather.cityName
			self.conditionsImage.image = UIImage.init(systemName: weather.conditionName)
		}
	}
	func didFailWithError(error: Error) {
		print(error)
	}
}

// MARK: - CLLocation Manager Delegate

extension WeatherViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		locationManager.stopUpdatingLocation()
		guard let location = locations.last else { return }
		let lat = location.coordinate.latitude
		let lon = location.coordinate.longitude
		weatherManager.fetchWeather(latitude: lat, longitude: lon)
		print("Latitude - \(lat), Longitude - \(lon)")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
}
