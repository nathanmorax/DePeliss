//
//  LibraryViewModel.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//

import UIKit

class LibraryViewModel {
    
    private(set) var savedItems: [MediaItem] = []
    var onDataUpdated: (() -> Void)?
    
    func loadSavedData() {
        savedItems = UserDefaultsManager.shared.getSavedMediaItems()
        onDataUpdated?()
    }
    
    func numberOfItems() -> Int {
        return savedItems.count
    }
    
    func item(at index: Int) -> MediaItem {
        return savedItems[index]
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
                return NSCollectionLayoutSection.sideTwoItem(headerItem: headerItem)
            default:
                return nil
            }
        }
    }
}
