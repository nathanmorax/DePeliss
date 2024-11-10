//
//  UIView.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in addSubview(view) }
    }
}
