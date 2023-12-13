//
//  CollectionViewFlowLayout.swift
//  UIKitArcade
//
//  Created by admin on 13/12/2023.
//

import Foundation
import UIKit

class CollectionViewFlowLayout : UIView {
    static let headerKind = "header_supplementary_kind"
    
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,CardModel>!
    
    init() {
        super.init(frame: .zero)
        configureCollectionView()
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension CollectionViewFlowLayout {
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reusableId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: CollectionViewFlowLayout.headerKind, withReuseIdentifier: HeaderCell.reusableId)
        collectionView.delegate = self
        configureDataSource()
    }
    
    func configureDataSource() {
        
        //dataSource
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reusableId, for: indexPath) as! TextCell? else {
                return nil
            }
            cell.label.text = "\(itemIdentifier.value)"
            return cell
        }
        
        //populateData
        var snapShot = NSDiffableDataSourceSnapshot<Section,CardModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0...100).map {
            CardModel(badge: Int.random(in: 0..<3), value: "\($0)")
        })
        dataSource.apply(snapShot,animatingDifferences: false)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


extension CollectionViewFlowLayout : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.size.width / 2) - 20, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
}
