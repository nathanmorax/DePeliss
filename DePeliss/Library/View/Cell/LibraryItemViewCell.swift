//
//  LibraryItemViewCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//
import UIKit

class LibraryItemViewCell: UICollectionViewCell {
    
    static let LibraryItemIdentifier = "LibraryItemIdentifier"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    
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
        
        imageView.backgroundColor = .red
        
        titleLabel.text = "Released"
        titleLabel.textColor = .colorLabel
        titleLabel.font = .systemFont(ofSize: 14, weight: .thin)
        titleLabel.textAlignment = .left
        
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
    }
    
    private func constraint() {
        
        stackView.addArrangedSubviews(imageView ,titleLabel)
        addSubviews(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
