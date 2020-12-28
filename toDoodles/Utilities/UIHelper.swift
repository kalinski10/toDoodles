//
//  UIHelper.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 14/12/2020.
//

import UIKit


enum UIHelper {
    
    static func configureCollectionViewLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let layout                  = UICollectionViewFlowLayout()
        let padding: CGFloat        = 18
        let itemWidth               = view.frame.width - padding * 2
        
        layout.itemSize             = CGSize(width: itemWidth, height: 80)
        layout.minimumLineSpacing   = 10
        
        return layout
    }
    
    
    static func configureCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        let badgeSize   = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
        let badge       = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize,
                                                              elementKind: Constants.ElementKind.badge,
                                                              containerAnchor: badgeAnchor)
        
        let itemSize                = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
        let item                    = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
                
        let groupSize               = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
                
        let group                   = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.supplementaryItems    = []
                
        let section                 = NSCollectionLayoutSection(group: group)
        section.contentInsets       = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing   = 10
        
        let layout                  = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
