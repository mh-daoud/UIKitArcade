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
    private weak var store: LandingPageContainersStore!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        label = makeLabel(text: "Title", fontType: .medium, fontColor: ThemeColor.white)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CommonSizes.shared.portraitShowCard
        layout.estimatedItemSize = CommonSizes.shared.portraitShowCard
        layout.scrollDirection = .horizontal
        
        collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PortraitCardCollectionViewCell.self, forCellWithReuseIdentifier: PortraitCardCollectionViewCell.reusableId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        selectionStyle = .none
        
        self.style()
        self.layout()
    }
    
    func configure(container: AccedoContainer, store: LandingPageContainersStore) {
        guard container.playlistId != self.container?.playlistId else {
            label.text = container.displaytext ?? container.title ?? ""

            return
        }
        self.container = container
        self.store = store
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LandscapeCarouselTableViewCell {
    func setup() {
        if let container, let playlistId = container.playlistId {
            label.text =  container.displaytext ?? container.title  ??  ""
            if let storedContainer = store.getContainerFromStore(playlistId: playlistId), let editorialItems = storedContainer.editorials as? [EditorialItem] {
                setupCarousel(editorialItems: editorialItems)
            }
            else {
                fetchEditorials()
            }
        }
    }
    
    private func fetchEditorials() {
        if let container, let playlistId = container.playlistId {
            APIMock.shared.getContainerItems(playlistId: playlistId, pageNumber: 0, pageSize: Config.pageSize) { [weak self] response in
                
                guard let self, let editorialItems = response.editorialItems?.compactMap({ (itemWithType: EditorialItemWithType) in
                    itemWithType.item
                }) else 
                {
                    print("fetchEditorials failed ==== \(playlistId)")
                    return
                }
                
                let storedContainer = store.createStoredContainerForPlaylistId(playlistId: playlistId, response: response)
                store.updateContainerStoreForPlaylist(playlistId: playlistId, containerToStore: storedContainer)
                setupCarousel(editorialItems: editorialItems)
                
            } failure: { errorMessage in
                print("error \(errorMessage)")
            }
        }
    }
    
    private func setupCarousel(editorialItems: [EditorialItem]) {
        self.items.removeAll()
        items += editorialItems
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func style() {
        
        backgroundColor = ThemeColor.nero
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ThemeColor.transparent
    }
    
    private func layout() {
        
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
