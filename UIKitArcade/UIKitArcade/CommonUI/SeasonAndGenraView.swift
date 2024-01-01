//
//  SeasonAndGenraView.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class SeasonAndGenraView : UIView {
    let item: ProductModelSharedDetails
    
    var stackView = makeStackView(axies: .horizontal)
    var labels : [UILabel]!
    
    init(item: ProductModelSharedDetails) {
        self.item = item
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension SeasonAndGenraView {
    
    func setup() {
        labels = []
        let genres = ProductModelUtil.getGenras(item: item)
        if let editorialItem = item as? EditorialItem, let season = ProductModelUtil.getSeason(item: editorialItem), let seasonNumber = season.seasonNumber {
            let label = makeLabel(text: "Season \(seasonNumber)",  fontType: .small, fontColor: ThemeColor.white)
            labels.append(label)
        }
        if let genres {
            for genra in genres {
                let label = makeLabel(text: genra.title ?? "", fontType: .small, fontColor: ThemeColor.white)
                labels.append(label)
            }
        }
        stackView.spacing = dimensionCalculation(4, 4)
        layer.zPosition = 10
    }
    
    func layout() {
        
        addSubview(stackView)
        
        for (index,label) in labels.enumerated() {
            if index != 0 {
                let circle = GreenCircle()
                circle.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(circle)
            }
            stackView.addArrangedSubview(label)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
