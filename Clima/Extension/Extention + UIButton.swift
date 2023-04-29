//
//  Extention + UIButton.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 29.04.2023.
//

import UIKit

extension UIButton {
	convenience init(imageName: String, type: UIButton.ButtonType = .system) {
		self.init(type: type)
		setBackgroundImage(UIImage(systemName: imageName), for: .normal)
		tintColor = .label
	}
}
