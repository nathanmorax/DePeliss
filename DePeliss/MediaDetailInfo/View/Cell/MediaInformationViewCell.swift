//
//  MediaInformationViewCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

class MediaInformationViewCell: UICollectionViewCell {
    
    static let MediaInformationIdentifier = "MediaInformationIdentifier"
    
    private let titlepopularityLabel = UILabel()
    private let popularityLabel = UILabel()
    private let releasedTitleLabel = UILabel()
    private let releasedLabel = UILabel()
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
        
        contentView.backgroundColor = .backGroundCell
        contentView.layer.cornerRadius = 9
        
        titlepopularityLabel.text = "Populaty"
        titlepopularityLabel.textColor = .colorLabel
        titlepopularityLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titlepopularityLabel.textAlignment = .left
        
        popularityLabel.textColor = .colorLabel
        popularityLabel.font = .systemFont(ofSize: 12, weight: .thin)
        popularityLabel.textAlignment = .left
        
        releasedTitleLabel.text = "Released"
        releasedTitleLabel.textColor = .colorLabel
        releasedTitleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        releasedTitleLabel.textAlignment = .left
        
        releasedLabel.textColor = .colorLabel
        releasedLabel.font = .systemFont(ofSize: 12, weight: .thin)
        releasedLabel.textAlignment = .left
        
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        
    }
    
    private func constraint() {
        
        stackView.addArrangedSubviews(titlepopularityLabel, popularityLabel, releasedTitleLabel, releasedLabel)
        addSubviews(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(popularity: String, released: String) {
        popularityLabel.text = popularity
        releasedLabel.text = released
    }
}
