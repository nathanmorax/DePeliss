//
//  SearchViewController.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import UIKit


class SearchViewController: UICollectionViewController, UISearchBarDelegate {
    
    var viewModel: SearchViewModel?
    private let searchBar = UISearchBar()
    
    private var genreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        self.configureGenreCollectionView()
        self.configureView()
        self.constraint()
        
        Task {
            await viewModel?.fecthGenre()
            genreCollectionView.reloadData()
        }
    }
    
    init() {
        super.init(collectionViewLayout: SearchViewController.createLayout())
        self.viewModel = SearchViewModel()
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
    
    private func loadData(movie: String) {
        Task {
            await viewModel?.fetchSearchMovies(movie: movie)
            collectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        view.backgroundColor = .backGround
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.SearchViewIdentier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureGenreCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 20
        
        let itemWidth = (view.frame.width - layout.minimumInteritemSpacing * 3 - 16) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.5)
        
        genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.Genreidentifier)
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
    }
    
    private func configureView() {
        searchBar.delegate = self
        searchBar.placeholder = "Shows, Movies and More"
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .black
        searchBar.tintColor = .black
    }
    
    private func constraint() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(genreCollectionView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        genreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            genreCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            genreCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genreCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            genreCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        genreCollectionView.isHidden = !searchText.isEmpty
        if searchText.isEmpty {
            viewModel?.filteredMovies = []
        } else {
            loadData(movie: searchText)
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        genreCollectionView.isHidden = false
        viewModel?.filteredMovies = []
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView {
            return viewModel?.filteredMovies.count ?? 0
        } else {
            return viewModel?.genreData.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView, let data = viewModel?.filteredMovies {
            if indexPath.item < data.count  {
                let movie = data[indexPath.item]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.SearchViewIdentier, for: indexPath) as! SearchViewCell
                
                if let posterPath = movie.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
                    cell.imageView.loadImage(from: url)
                    cell.configure(with: cell.imageView.image ?? UIImage(), name: movie.originalTitle ?? "", releaseData: movie.releaseDate ?? "")
                }
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.Genreidentifier, for: indexPath) as! GenreCell
            if let data = viewModel?.genreData[indexPath.item] {
                cell.configureData(typeGenre: data.name ?? "Empty")
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        
        if collectionView == self.collectionView {
            guard viewModel.filteredMovies.count > 0 else {
                print("No hay películas o series disponibles")
                return
            }
            
            
            guard indexPath.item < viewModel.filteredMovies.count else {
                print("Error: Índice fuera de rango")
                return
            }
            
            let moviesSeries = viewModel.filteredMovies[indexPath.item]
            
            let mediaDetailViewModel = MediaInfoViewModel()
            mediaDetailViewModel.setFilterData(filterData: moviesSeries)
            mediaDetailViewModel.seriesId = moviesSeries.id
            
            let mediaDetailVC = MediaDetailInfoViewController()
            mediaDetailVC.viewModel = mediaDetailViewModel
            mediaDetailVC.modalPresentationStyle = .overFullScreen
            
            self.present(mediaDetailVC, animated: true, completion: nil)
        } else {
            let data = viewModel.genreData[indexPath.item]
            let moviesForGenreVC = MoviesForGenre(genreId: data.id)
            navigationController?.pushViewController(moviesForGenreVC, animated: true)
        }
    }
    
    
}

