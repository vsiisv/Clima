//
//  Extention + UILabel.swift
//  Clima
//
//  Created by VASILY IKONNIKOV on 27.04.2023.
//

import UIKit

extension UILabel {
	convenience init(fontSize: CGFloat, weight: UIFont.Weight) {
		self.init()
		font = UIFont.systemFont(ofSize: fontSize, weight: weight)
	}
}
