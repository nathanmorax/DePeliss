//
//  MediaOverviewCollectionViewCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

class MediaOverviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MediaInfoCollectionViewCell"
    
    private let informationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.backgroundColor = .backGroundCell
        contentView.layer.cornerRadius = 9
        
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 0
        informationLabel.textAlignment = .left
        informationLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        informationLabel.textColor = .colorLabel
    }
    
    private func constraint() {
        
        
        contentView.addSubview(informationLabel)
        
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            informationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            informationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            informationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
    }
    
    func configureData(information: String) {
        informationLabel.text = information
    }
    
}

