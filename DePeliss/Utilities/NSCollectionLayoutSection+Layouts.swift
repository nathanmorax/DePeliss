//
//  NSCollectionLayoutSection+Layouts.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import UIKit

extension NSCollectionLayoutSection {
    
    static func sideOneItem(headerItem: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 0
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 0
        section.contentInsets.top = 0
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    static func sideScrollingOneItemAnchor(headerItem: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 14
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(180)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 12
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [headerItem]

        return section
    }
    
    static func stackViewWithSixItems(headerItem: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(190)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 14
        section.contentInsets.leading = 12
        section.contentInsets.trailing = 12
        section.boundarySupplementaryItems = [headerItem]
        return section
    }
    
    static func information(headerItem: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 0
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        section.contentInsets.top = 22
        section.boundarySupplementaryItems = [headerItem]

        return section
    }
    
    static func sideTwoItem(headerItem: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170)),
            subitems: [item]
        )
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        section.contentInsets.top = 16
        section.interGroupSpacing = 16

        return section
    }

    static func oneItem(headerItem: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 22
        section.contentInsets.trailing = 22
        section.contentInsets.top = 22
        section.interGroupSpacing = 22

        return section
    }
    
}
