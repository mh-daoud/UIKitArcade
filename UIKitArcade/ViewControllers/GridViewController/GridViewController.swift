//
//  GridViewController.swift
//  UIKitArcade
//
//  Created by admin on 12/12/2023.
//

import Foundation
import UIKit



class TextCell: UICollectionViewCell {
    static let reusableId = "simple_text_cell"
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    func style(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = .systemBlue
        
    }
    
    func layout(){
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GridViewController : UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSoruce: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        
    }
}

extension GridViewController  {
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reusableId)
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureDataSource() {
        
        //render cell at index path
        dataSoruce = UICollectionViewDiffableDataSource<Section,Int>(collectionView: collectionView ) { collectionView, indexPath, itemIdentifier in
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reusableId, for: indexPath) as! TextCell
            cell.label.text = "\(itemIdentifier)"
            return cell
        }
        
        //populate data
        var snapshot = NSDiffableDataSourceSnapshot<Section,Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<100))
        dataSoruce.apply(snapshot,animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewLayout{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
