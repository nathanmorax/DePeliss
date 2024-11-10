//
//  MoviesForGenre.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//

import UIKit


class MoviesForGenre: UICollectionViewController {
    
    var viewModel: MoviesForGenreViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.constraint()
        self.loadData()
        
        collectionView.reloadData()
    }
    
    init(genreId: Int) {
        super.init(collectionViewLayout: MoviesForGenre.createLayout())
        self.viewModel = MoviesForGenreViewModel(movieGenreId: genreId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(90)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            switch sectionIndex {
            case 0:
                return NSCollectionLayoutSection.oneItem(headerItem: headerItem)
            default:
                return nil
            }
        }
    }
    
    private func loadData() {
        Task {
            await viewModel?.fecthMoviesForGenre(genreId: viewModel?.movieGenreId ?? 0)
            collectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        view.backgroundColor = .backGround
        collectionView.register(MoviesForGenreCell.self, forCellWithReuseIdentifier: MoviesForGenreCell.MoviesForGenreIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func constraint() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.moviesForGenreData.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesForGenreCell.MoviesForGenreIdentifier, for: indexPath) as! MoviesForGenreCell
        let movie = viewModel?.moviesForGenreData[indexPath.item]
        if let posterPath = movie?.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
            cell.imageView.loadImage(from: url)
            cell.configure(with: cell.imageView.image ?? UIImage(), name: movie?.originalTitle ?? "", releaseData: movie?.releaseDate ?? "")
        }
        return cell
        
    }
    
}


class MoviesForGenreCell: UICollectionViewCell {
    
    static let MoviesForGenreIdentifier = "MoviesForGenreIdentifier"
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

