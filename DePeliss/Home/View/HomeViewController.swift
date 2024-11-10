//
//  Home.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

class HomeViewController: UICollectionViewController {
    
    var viewModel: HomeViewModel?
    private let loader = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.constraint()
        self.setupLoader()
        self.loadData()
    }
    
    init() {
        super.init(collectionViewLayout: HomeViewController.createLayout())
        self.viewModel = HomeViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        collectionView.backgroundColor = .clear
        view.backgroundColor = .backGround
        collectionView.register(HeaderHomeViewCell.self, forCellWithReuseIdentifier: HeaderHomeViewCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifierHeader)
        collectionView.register(TVShowCell.self, forCellWithReuseIdentifier: TVShowCell.identifierTV)
        
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
    private func setupLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadData() {
        loader.startAnimating()
        if let viewModel = viewModel {
            Task {
                await viewModel.fetchAllData()
                self.collectionView.reloadData()
                self.loader.stopAnimating()
            }
        } else {
            print("Error: viewModel es nil.")
            loader.stopAnimating()
        }
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
                return NSCollectionLayoutSection.sideScrollingOneItemAnchor(headerItem: headerItem)
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
        return  HomeSection.allCases.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = HomeSection(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .header:  return viewModel?.moviesTrending.count ?? 0
        case .TvShow: return viewModel?.topRatedSeries.count ?? 0
        case .popularSeries: return viewModel?.topRatedSeries.count ?? 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = HomeSection(rawValue: indexPath.section)
        
        switch sectionType {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderHomeViewCell.identifier, for: indexPath) as? HeaderHomeViewCell else {
                fatalError("Unable to dequeue CustomCollectionViewCell")
            }
            
            let movie = viewModel?.moviesTrending[indexPath.item]
            if let posterPath = movie?.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                loadImage(from: url) { image in
                    cell.configure(with: image)
                }
            }
            return cell
        case .TvShow:
            guard let tvShowCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCell.identifierTV, for: indexPath) as? TVShowCell else {
                fatalError("Unable to dequeue TVShowCell")
            }
            let movie = viewModel?.topRatedSeries[indexPath.item]
            if let posterPath = movie?.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                loadImage(from: url) { image in
                    tvShowCell.configure(with: image, title: movie?.originalName ?? "Holaa")
                }
            }
            return tvShowCell
            
        case .popularSeries:
            guard let tvShowCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCell.identifierTV, for: indexPath) as? TVShowCell else {
                fatalError("Unable to dequeue TVShowCell")
            }
            let movie = viewModel?.popularSeries[indexPath.item]
            if let posterPath = movie?.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                loadImage(from: url) { image in
                    tvShowCell.configure(with: image, title: movie?.originalName ?? "Holaa")
                }
            }
            return tvShowCell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifierHeader, for: indexPath) as? SectionHeaderView else {
                fatalError("Unable to dequeue SectionHeaderView")
            }
            
            let sectionType = HomeSection(rawValue: indexPath.section)
            headerView.configure(with: sectionType?.title ?? "")
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionType = HomeSection(rawValue: indexPath.section)
        
        switch sectionType {
        case .header:
            return print("Hola")
        case .TvShow:
            
            guard let selectedSeries = viewModel?.topRatedSeries[indexPath.item] else { return }
            
            let mediaDetailViewModel = MediaInfoViewModel()
            let id = selectedSeries.id
            
            mediaDetailViewModel.setSeriesData(data: selectedSeries)
            mediaDetailViewModel.seriesId = id
            
            let mediaDetailVC = MediaDetailInfoViewController()
            
            mediaDetailVC.viewModel = mediaDetailViewModel
            mediaDetailVC.modalPresentationStyle = .overFullScreen
            
            self.present(mediaDetailVC, animated: true, completion: nil)
            
        case .popularSeries:
            
            guard let selectedSeries = viewModel?.popularSeries[indexPath.item] else { return }
            
            let mediaDetailViewModel = MediaInfoViewModel()
            let id = selectedSeries.id
            
            mediaDetailViewModel.setSeriesData(data: selectedSeries)
            mediaDetailViewModel.seriesId = id
            
            let mediaDetailVC = MediaDetailInfoViewController()
            
            mediaDetailVC.viewModel = mediaDetailViewModel
            mediaDetailVC.modalPresentationStyle = .overFullScreen
            
            self.present(mediaDetailVC, animated: true, completion: nil)
        default:
            return print("")
        }
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
