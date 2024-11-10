//
//  UIImageView.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholderImageName: String = "error.image") {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    if let placeholderImage = UIImage(named: placeholderImageName) {
                        self.image = placeholderImage
                    } else {
                        self.image = UIImage()
                    }
                }
                print("Error al cargar la imagen: \(error?.localizedDescription ?? "Desconocido")")
            }
        }.resume()
    }
}
