//
//  CollectionViewLayoutFactory.swift
//  GymFlow
//
//  Created by Artem Kriukov on 25.10.2025.
//

import UIKit

enum CollectionViewLayoutFactory {
    
    /// Создает layout с вертикальным списком и self-sizing ячейками
    /// - Parameters:
    ///   - estimatedHeight: Предполагаемая высота ячейки (по умолчанию 150)
    ///   - interItemSpacing: Отступ между ячейками (по умолчанию 16)
    ///   - contentInsets: Отступы секции (по умолчанию 16 со всех сторон)
    /// - Returns: Настроенный UICollectionViewCompositionalLayout
    static func makeVerticalListLayout(
        estimatedHeight: CGFloat = 150,
        interItemSpacing: CGFloat = 16,
        contentInsets: NSDirectionalEdgeInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    ) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interItemSpacing
        section.contentInsets = contentInsets
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    /// Создает layout с сеткой (grid)
    /// - Parameters:
    ///   - columns: Количество колонок
    ///   - estimatedHeight: Предполагаемая высота ячейки
    ///   - spacing: Отступ между ячейками
    ///   - contentInsets: Отступы секции
    /// - Returns: Настроенный UICollectionViewCompositionalLayout
    static func makeGridLayout(
        columns: Int = 2,
        estimatedHeight: CGFloat = 200,
        spacing: CGFloat = 16,
        contentInsets: NSDirectionalEdgeInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    ) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
            heightDimension: .estimated(estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: Array(repeating: item, count: columns)
        )
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = contentInsets
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    /// Создает горизонтальный скроллящийся layout
    /// - Parameters:
    ///   - itemWidth: Ширина ячейки (fractional от ширины секции)
    ///   - estimatedHeight: Предполагаемая высота
    ///   - spacing: Отступ между ячейками
    ///   - contentInsets: Отступы секции
    /// - Returns: Настроенный UICollectionViewCompositionalLayout
    static func makeHorizontalScrollLayout(
        itemWidth: CGFloat = 0.9,
        estimatedHeight: CGFloat = 200,
        spacing: CGFloat = 16,
        contentInsets: NSDirectionalEdgeInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    ) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemWidth),
            heightDimension: .estimated(estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemWidth),
            heightDimension: .estimated(estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = contentInsets
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
