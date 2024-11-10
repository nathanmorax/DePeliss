//
//  GenreCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//
import UIKit

class GenreCell: UICollectionViewCell {
    
    static let Genreidentifier = "Genreidentifier"
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .colorLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.constraint()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        contentView.layer.cornerRadius = 9
        contentView.backgroundColor = .backGroundCell
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    func configureData(typeGenre: String) {
        label.text = typeGenre
    }
}
