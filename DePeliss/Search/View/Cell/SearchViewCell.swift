//
//  SearchViewCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//
import UIKit

class SearchViewCell: UICollectionViewCell {
    
    static let SearchViewIdentier = "SearchViewIdentier"
    private let nameMovieLabel = UILabel()
    private let releaseDateLabel = UILabel()
    let imageView = UIImageView()
    private let stackView = UIStackView()
    let viewSeparator = UIView()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        constraint()
    }
    
    private func configureView() {
        
        
        nameMovieLabel.textColor = .colorLabel
        nameMovieLabel.font = .systemFont(ofSize: 17, weight: .medium)
        nameMovieLabel.textAlignment = .left
        
        releaseDateLabel.textColor = .colorLabel
        releaseDateLabel.font = .systemFont(ofSize: 13, weight: .thin)
        releaseDateLabel.textAlignment = .left
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
        
        viewSeparator.backgroundColor = .colorLabel

        
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        
    }
    
    
    private func constraint() {
        
        stackView.addArrangedSubviews(nameMovieLabel, releaseDateLabel)
        addSubviews(imageView, stackView, viewSeparator)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 36),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            viewSeparator.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 8),
            viewSeparator.heightAnchor.constraint(equalToConstant: 0.3),
            viewSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            viewSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            viewSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with image: UIImage, name: String, releaseData: String) {
        
        imageView.image = image
        nameMovieLabel.text = name
        releaseDateLabel.text = releaseData
        
    }
}

