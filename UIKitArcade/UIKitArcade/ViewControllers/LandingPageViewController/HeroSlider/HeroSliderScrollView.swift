//
//  HeroSliderTableView.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class HeroSliderScrollView : UIScrollView {
    
    var slides: [EditorialItem]
    
    init(items: [EditorialItem]) {
        self.slides = items
        super.init(frame: .zero)
        setup()
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension HeroSliderScrollView {
    func setup(){
        
    }
    
    func style(){
        
    }
    
    func layout() {
        
    }
}
