//
//  MediaDetailInfo.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import UIKit


class MediaDetailInfoViewController: UICollectionViewController {
    
    var viewModel: MediaInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.constraint()
        self.loadData()
        self.configureNotification()
        
    }
    
    init() {
        super.init(collectionViewLayout: MediaDetailInfoViewController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func configure() {
        
        collectionView.backgroundColor = .clear
        view.backgroundColor = .backGround
        
        collectionView.register(MediaOverviewCollectionViewCell.self, forCellWithReuseIdentifier: MediaOverviewCollectionViewCell.identifier)
        collectionView.register(MediaHeaderViewCell.self, forCellWithReuseIdentifier: MediaHeaderViewCell.MediaHeaderIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifierHeader)
        collectionView.register(MediaRecomendationsViewCell.self, forCellWithReuseIdentifier: MediaRecomendationsViewCell.MediaRecomendationsIdentifier)
        collectionView.register(MediaInformationViewCell.self, forCellWithReuseIdentifier: MediaInformationViewCell.MediaInformationIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func constraint() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(dismissMediaView), name: Notification.Name("DismissMediaView"), object: nil)
    }
    
    private func loadData() {
        
        if let viewModel = viewModel {
            Task {
                do {
                    await viewModel.fetchRecomendationsSeries(seriesId: viewModel.seriesId ?? 0)
                    await viewModel.fetchRecomendationsMovies(movieId: viewModel.movieId ?? 0)
                    collectionView.reloadData()
                } catch {
                    print("Error fetching trending movies: \(error)")
                }
            }
        } else {
            print("Error: viewModel es nil.")
        }
    }
    
    @objc func dismissMediaView() {
        self.dismiss(animated: true, completion: nil)
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
                return NSCollectionLayoutSection.sideOneItem(headerItem: headerItem)
            case 1:
                return NSCollectionLayoutSection.information(headerItem: headerItem)
            case 2:
                return NSCollectionLayoutSection.sideScrollingOneItemAnchor(headerItem: headerItem)
            case 3:
                return NSCollectionLayoutSection.stackViewWithSixItems(headerItem: headerItem)
            default:
                return nil
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  MediaInfoSection.allCases.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = MediaInfoSection(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .header:  return 3
        case .about: return 1
        case .related: return viewModel?.recomendationsSeriesData.count ?? 0
        case .information: return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = MediaInfoSection(rawValue: indexPath.section)
        
        switch sectionType {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaHeaderViewCell.MediaHeaderIdentifier, for: indexPath) as? MediaHeaderViewCell else {
                fatalError("Unable to dequeue CustomCollectionViewCell")
            }
            
            if let data = viewModel?.ratedSeriesData {
                if let posterPath = data.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                    loadImage(from: url) { image in
                        cell.configure(with: image, title: data.name ?? "")
                    }
                }
                
            } else if let data = viewModel?.popularSeries {
                if let posterPath = data.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                    loadImage(from: url) { image in
                        cell.configure(with: image, title: data.name ?? "")
                    }
                }
            } else {
                if let data = viewModel?.filteredMovies {
                    if let posterPath = data.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                        loadImage(from: url) { image in
                            cell.configure(with: image, title: data.originalTitle
                                           ?? "")
                        }
                    }
                }
            }
            
            return cell
        case .about:
            guard let aboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaOverviewCollectionViewCell.identifier, for: indexPath) as? MediaOverviewCollectionViewCell else {
                fatalError("Unable to dequeue TVShowCell")
            }
            
            if let data = viewModel?.ratedSeriesData {
                aboutCell.configureData(information: data.overview ?? "No description available")
                
            } else if let data = viewModel?.popularSeries {
                aboutCell.configureData(information: data.overview ?? "No description available")
            } else if let data = viewModel?.filteredMovies {
                aboutCell.configureData(information: data.overview ?? "No description available")
            }
            return aboutCell
            
        case .related:
            guard let relatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaRecomendationsViewCell.MediaRecomendationsIdentifier, for: indexPath) as? MediaRecomendationsViewCell else {
                fatalError("Unable to dequeue TVShowCell")
            }
            if let serie = viewModel?.recomendationsSeriesData[indexPath.item] {
                if let posterPath = serie.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                    loadImage(from: url) { image in
                        relatedCell.configure(with: image, title: serie.name ?? "")
                    }
                }
            } else {
                if let movie = viewModel?.recomendationsMoviesData[indexPath.item] {
                    if let posterPath = movie.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                        loadImage(from: url) { image in
                            relatedCell.configure(with: image, title: movie.originalTitle ?? "")
                        }
                    }
                }
            }
           
            
            return relatedCell
            
        case .information:
            
            guard let informationCell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaInformationViewCell.MediaInformationIdentifier, for: indexPath) as? MediaInformationViewCell else {
                fatalError("Unable to dequeue TVShowCell")
            }
            
            if let data = viewModel?.ratedSeriesData {
                let popularityText = data.popularity.map { String(format: "%.2f", $0) } ?? "N/A"
                informationCell.configure(popularity: popularityText, released: data.firstAirDate ?? "")
                
                
            } else if let data = viewModel?.filteredMovies {
                let popularityText = data.popularity.map { String(format: "%.2f", $0) } ?? "N/A"
                informationCell.configure(popularity: popularityText, released: data.releaseDate ?? "")
            }
        
            return informationCell
            
        default:
            return UICollectionViewCell()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifierHeader, for: indexPath) as? SectionHeaderView else {
                fatalError("Unable to dequeue SectionHeaderView")
            }
            
            let sectionType = MediaInfoSection(rawValue: indexPath.section)
            headerView.configure(with: sectionType?.title ?? "")
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("Error al cargar la imagen: \(error?.localizedDescription ?? "Desconocido")")
            }
        }.resume()
    }
    
}

