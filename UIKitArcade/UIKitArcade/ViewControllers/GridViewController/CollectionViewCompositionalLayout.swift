//
//  CollectionViewCompositionalLayout.swift
//  UIKitArcade
//
//  Created by admin on 13/12/2023.
//

import Foundation
import UIKit

enum Section {
    case main
}

class CollectionViewCompositionalLayout : UIView {
    
    static let badgeKind = "supplementary_badge_kind"
    
    var dataSoruce: UICollectionViewDiffableDataSource<Section, CardModel>! = nil
    var collectionView: UICollectionView! = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        style()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension CollectionViewCompositionalLayout {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: frame, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reusableId)
        collectionView.register(BadgeCell.self, forSupplementaryViewOfKind: CollectionViewCompositionalLayout.badgeKind, withReuseIdentifier: BadgeCell.reusableId)
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    private func createLayout() -> UICollectionViewLayout{
        
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top,.trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize,
                                                        elementKind: CollectionViewCompositionalLayout.badgeKind,
                                                        containerAnchor: badgeAnchor)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    private func configureDataSource() {
        
        //render cell at index path
        dataSoruce = UICollectionViewDiffableDataSource<Section,CardModel>(collectionView: collectionView ) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reusableId, for: indexPath) as! TextCell
            cell.label.text = "\(itemIdentifier.value)"
            return cell
        }
        
        dataSoruce.supplementaryViewProvider = {[weak self] (_ collectionView: UICollectionView, _ elementKind: String, _ indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self, let card = self.dataSoruce.itemIdentifier(for: indexPath) else {
                return nil
            }
            if let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: BadgeCell.reusableId, for: indexPath) as! BadgeCell? {
                badgeView.label.text = "\(card.badge)"
                badgeView.isHidden = card.badge < 1
                return badgeView
            }
            return nil
            
        }
        
        
        //populate data
        var snapshot = NSDiffableDataSourceSnapshot<Section,CardModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<100).map({ index in
            CardModel(badge: Int.random(in: 0..<3), value: "\(index)")
        }))
        dataSoruce.apply(snapshot,animatingDifferences: false)
    }
}
