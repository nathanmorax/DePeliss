//
//  MediaHeaderViewCell.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

class MediaHeaderViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let MediaHeaderIdentifier = "MediaInfoHeaderIdentifier"
    private let imageView = UIImageView()
    private let downloadButton = UIButton()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private var isImageChanged = false
    private var mediaItemTitle: String?
    private var mediaItemImage: UIImage?
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraint()
        downloadButton.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        constraint()
        downloadButton.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        
    }
    
    // MARK: - Configuration
    private func configure() {
        
        imageView.contentMode = .scaleAspectFit
        
        downloadButton.setTitleColor(.white, for: .normal)
        downloadButton.backgroundColor = .black.withAlphaComponent(0.8)
        downloadButton.layer.cornerRadius = 22
        downloadButton.tintColor = .white
        downloadButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .black.withAlphaComponent(0.8)
        backButton.layer.cornerRadius = 22
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        
        titleLabel.textColor = .colorLabel
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        
        
    }
    
    private func constraint() {
        
        addSubviews(imageView, downloadButton, backButton, titleLabel)
        
        [imageView, backButton, downloadButton, backButton, titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            downloadButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 64),
            downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            downloadButton.widthAnchor.constraint(equalToConstant: 42),
            downloadButton.heightAnchor.constraint(equalToConstant: 42),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 64),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 42),
            backButton.heightAnchor.constraint(equalToConstant: 42),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    @objc private func changeImage() {
        guard let title = mediaItemTitle, let image = mediaItemImage else { return }
        
        if isImageChanged {
            downloadButton.setImage(UIImage(systemName: "plus"), for: .normal)
            UserDefaultsManager.shared.deleteMediaItem(withTitle: title)
        } else {
            downloadButton.setImage(UIImage(systemName: "trash"), for: .normal)
            UserDefaultsManager.shared.saveMediaItem(image: image, title: title)
        }
        
        isImageChanged.toggle()
    }
    
    @objc private func dismissButton() {
        NotificationCenter.default.post(name: Notification.Name("DismissMediaView"), object: nil)

    }
    
    
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
        mediaItemTitle = title
        mediaItemImage = image
        
        let savedItems = UserDefaultsManager.shared.getSavedMediaItems()
        if savedItems.contains(where: { $0.title == title }) {
            downloadButton.setImage(UIImage(systemName: "trash"), for: .normal)
            isImageChanged = true
        } else {
            downloadButton.setImage(UIImage(systemName: "plus"), for: .normal)
            isImageChanged = false
        }
    }
}


