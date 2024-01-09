//
//  NativeAd.swift
//  UIKitArcade
//
//  Created by admin on 09/01/2024.
//

import Foundation
import UIKit


class NativeAdTableViewCell : UITableViewCell {
    static let reusableId = "native_ad_table_view_cell"
    
    private var container: AccedoContainer?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.style()
        self.layout()
        selectionStyle = .none
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
}


extension NativeAdTableViewCell {
    
    func configure(container: AccedoContainer, store: LandingPageContainersStore) {
        self.container = container
        setup()
    }
    
    private func setup(){
        
    }
    
    private func style(){
        
    }
    
    private func layout(){
        
    }
}
