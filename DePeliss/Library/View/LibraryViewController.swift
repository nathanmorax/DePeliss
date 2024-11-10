//
//  LibraryViewController.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

class LibraryViewController: UICollectionViewController {
    
    private let viewModel: LibraryViewModel
    private let downloadsMessageView = UIView()
    private let messageLabel = UILabel()
    
    
    init() {
        self.viewModel = LibraryViewModel()
        super.init(collectionViewLayout: LibraryViewModel.createLayout())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.constraint()
        self.viewModel.loadSavedData()
        self.setupViewModel()
        self.setupNoDownloadsMessage()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSavedData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.toggleNoDownloadsMessage()
            }
        }
    }
    
    private func configure() {
        
        collectionView.backgroundColor = .clear
        view.backgroundColor = .backGround
        collectionView.register(LibraryItemViewCell.self, forCellWithReuseIdentifier: LibraryItemViewCell.LibraryItemIdentifier)
        
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
    
    private func setupNoDownloadsMessage() {
        downloadsMessageView.frame = view.bounds
        downloadsMessageView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        messageLabel.text = "You Library is Empty"
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        downloadsMessageView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: downloadsMessageView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: downloadsMessageView.centerYAnchor)
        ])
        
        view.addSubview(downloadsMessageView)
        downloadsMessageView.isHidden = true
    }
    
    private func toggleNoDownloadsMessage() {
        if viewModel.numberOfItems() == 0 {
            downloadsMessageView.isHidden = false
        } else {
            downloadsMessageView.isHidden = true
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryItemViewCell.LibraryItemIdentifier, for: indexPath) as? LibraryItemViewCell {
            let item = viewModel.item(at: indexPath.item)
            cell.configure(with: item.image, title: item.title)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

