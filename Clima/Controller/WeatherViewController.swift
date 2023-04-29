//
//  ViewController.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 17.04.2023.
//

import UIKit

class WeatherViewController: UIViewController {
	
	// MARK: - Views
	
	private let degreeLabel = UILabel(fontSize: 80, weight: .bold)
	private let symbolDegreeLabel = UILabel(fontSize: 100, weight: .light)
	private let typeDegreeLabel = UILabel(fontSize: 100, weight: .light)
	private let cityLabel = UILabel(fontSize: 30, weight: .regular)
	
	private let backgroundImage = UIImageView(imageName: "background")
	private let conditionsImage = UIImageView(imageName: "sun.max", tintColor: .label)
	
	private let searchView = SearchView()

	lazy var mainStackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .trailing
		stackView.distribution = .fill
		stackView.spacing = 10
		stackView.contentMode = .scaleToFill
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	lazy var degreeStackView: UIStackView =  {
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
		
		style()
		
		// Test Data
		degreeLabel.text = "21"
		symbolDegreeLabel.text = "°"
		typeDegreeLabel.text = "C"
		cityLabel.text = "London"
	}
}

// MARK: - Layout and add subviews

extension WeatherViewController {
	func style() {
		
	}
	
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
