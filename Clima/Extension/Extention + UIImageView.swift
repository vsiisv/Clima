//
//  Extention + UIImageView.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 29.04.2023.
//

import UIKit

extension UIImageView {
	convenience init(imageName: String) {
		self.init()
		image = UIImage(named: imageName)
		contentMode = .scaleAspectFill
	}
	
	convenience init(imageName: String, tintColor: UIColor) {
		self.init()
		image = UIImage(systemName: imageName)
		self.tintColor = tintColor
		contentMode = .scaleAspectFill
	}
}
