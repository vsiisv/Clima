//
//  SearchStackView.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 25.04.2023.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
	func getCity(city: String)
}

final class SearchView: UIView {
	
	weak var delegate: SearchViewDelegate?
	
	// MARK: - Views
	
	private let locationButton = UIButton(imageName: "location.circle.fill")
	private let searchButton = UIButton(imageName: "magnifyingglass")
	
	private lazy var searchTextfield: UITextField = {
		let textField = UITextField()
		textField.textColor = .black
		textField.font = UIFont.systemFont(ofSize: 25)
		textField.textAlignment = .right
		textField.placeholder = "Search"
		textField.keyboardType = .default
		textField.borderStyle = .roundedRect
		textField.returnKeyType = .go
		textField.autocapitalizationType = .words
		textField.backgroundColor = .systemFill
		textField.delegate = self
		return textField
	}()
	
	private lazy var searchStackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 10
		stackView.contentMode = .scaleToFill
		return stackView
	}()
	
	// MARK: - Lifecycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		addSubviews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Actions

extension SearchView {
	@objc private func searchButtonAction(_ sender: UIButton) {
//		guard let city = searchTextfield.text else { return }
		searchTextfield.endEditing(true)
//		delegate?.getCity(city: city)
//		searchTextfield.text = ""
	}
	
	@objc private func locationButtonAction(_ sender: UIButton) {
		print("Btn location")
	}
}

// MARK: - TextField Delegate

extension SearchView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchTextfield.endEditing(true)
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		if searchTextfield.text != "" {
			searchTextfield.placeholder = "Search"
			return true
		} else {
			searchTextfield.placeholder = "Type something"
			return false
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let city = searchTextfield.text else { return }
		delegate?.getCity(city: city)
		searchTextfield.text = ""
	}
}

// MARK: - Layout and add subviews

extension SearchView {
	private func setupView() {
		searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
		locationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
	}
	
	private func addSubviews() {
		addSubview(searchStackView)
		searchStackView.addArrangedSubview(locationButton)
		searchStackView.addArrangedSubview(searchTextfield)
		searchStackView.addArrangedSubview(searchButton)
	}
	
	private func setupConstraints() {
		searchStackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			searchStackView.topAnchor.constraint(equalTo: topAnchor),
			searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			searchStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			locationButton.heightAnchor.constraint(equalToConstant: 40),
			locationButton.widthAnchor.constraint(equalToConstant: 40),
			searchButton.heightAnchor.constraint(equalToConstant: 40),
			searchButton.widthAnchor.constraint(equalToConstant: 40)
		])
	}
}
