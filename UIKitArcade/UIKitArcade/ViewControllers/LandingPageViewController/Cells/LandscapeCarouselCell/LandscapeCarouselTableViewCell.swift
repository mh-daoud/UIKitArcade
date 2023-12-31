//
//  LandscapeCarouselCell.swift
//  UIKitArcade
//
//  Created by admin on 28/12/2023.
//

import Foundation
import UIKit

class LandscapeCarouselTableViewCell : UITableViewCell {
    
    static let reusableId : String = "landscape_carousel_table_view_cell_id"
    
    var label: UILabel
    var collectionView: DynamicCollectionView
    var items: [EditorialItem] = []
    private var container: AccedoContainer?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = makeLabel(text: "Title", fontType: .medium, fontColor: ThemeColor.white)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CommonSizes.shared.portraitShowCard
        layout.estimatedItemSize = CommonSizes.shared.portraitShowCard
        layout.scrollDirection = .horizontal
        collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.register(PortraitCardCollectionViewCell.self, forCellWithReuseIdentifier: PortraitCardCollectionViewCell.reusableId)
        selectionStyle = .none
    }
    
    func configure(container: AccedoContainer) {
        self.container = container
        setup()
        style()
        layout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LandscapeCarouselTableViewCell {
    
    func setup() {
        if let container {
            label.text =  container.displaytext ?? container.title  ?? "Title"
            fetchEditorials()
        }
        
    }
    
    private func fetchEditorials() {
        if let container, let playlistId = container.playlistId {
            APIMock.shared.getContainerItems(playlistId: playlistId, pageNumber: 0, pageSize: 15) { [weak self ] response in
                guard let self, let editorialItems = response.editorialItems?.compactMap({ (itemWithType: EditorialItemWithType) in
                    itemWithType.item
                }) else { return }
                setupCarousel(editorialItems: editorialItems)
            } failure: { errorMessage in
                print("error \(errorMessage)")
            }
        }
    }
    
    func setupCarousel(editorialItems: [EditorialItem]) {
        self.items.removeAll(keepingCapacity: true)
        items += editorialItems
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func style() {
        
        backgroundColor = ThemeColor.nero
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ThemeColor.transparent
    }
    
    func layout() {
        
        [label, collectionView].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1.5),
            collectionView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}



extension LandscapeCarouselTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortraitCardCollectionViewCell.reusableId, for: indexPath) as? PortraitCardCollectionViewCell {
            cell.configure(item: items[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
}


class DynamicCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: CommonSizes.shared.portraitShowCard.height)
    }
}
