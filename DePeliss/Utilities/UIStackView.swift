//
//  UIStackView.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in addArrangedSubview(view) }
    }
}

