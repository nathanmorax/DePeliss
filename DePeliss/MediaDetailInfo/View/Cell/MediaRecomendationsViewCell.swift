//
//  MediaRecomendationsViewCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

class MediaRecomendationsViewCell: UICollectionViewCell {
    
    static let MediaRecomendationsIdentifier = "MediaRecomendationsIdentifier"
    var titleLabel = UILabel()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Inicializador de la celda
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        constraint()
    }
    
    private func configure() {
        titleLabel.textColor = .colorLabel
        titleLabel.font = .systemFont(ofSize: 14, weight: .thin)
    }
    
    
    private func constraint() {
        contentView.addSubviews(imageView, titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}

