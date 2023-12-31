//
//  HorizontalCollectionView.swift
//  UIKitArcade
//
//  Created by admin on 14/12/2023.
//

import Foundation
import UIKit

class HorizontalCollectionView : UIView {
    
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
 //       flowLayout.itemSize = CGSize(width: 120, height: 80)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return view
    }()
    
    var dataSource : UICollectionViewDiffableDataSource<Section,CardModel>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        setupDataSource()
        layout()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 100)
    }
}




extension HorizontalCollectionView {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    
    func setupDataSource() {
        collectionView.register(BasicCell.self, forCellWithReuseIdentifier: BasicCell.reusableId)
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView){ collectionView,indexPath,itemIdentifier in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCell.reusableId, for: indexPath) as? BasicCell {
                cell.configureCell(with: itemIdentifier)
                return cell
            }
            return UICollectionViewCell()
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,CardModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...100).map{ CardModel(badge: 0, value: "\($0)")})
        
        dataSource.apply(snapshot,animatingDifferences: false)
    }
}



