//
//  HeroSliderTableViewCell.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

import UIKit

class HeroSliderTableViewCell : UITableViewCell {
    
    static let reusableId = "hero_slider_table_view_cell"
    var container: AccedoContainer!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}




extension HeroSliderTableViewCell {
    func setup() {
//        APIMock.shared.getContainerItems(playlistId: container.playlistId, pageNumber: 0, pageSize: <#T##Int#>, success: <#T##(ContainerEditorialResponse) -> Void#>, failure: <#T##(String) -> Void#>)
    }
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        
    }
}
