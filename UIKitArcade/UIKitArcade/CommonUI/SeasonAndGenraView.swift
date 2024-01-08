//
//  SeasonAndGenraView.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class SeasonAndGenraView : UIView {
    private var item: ProductModelSharedDetails?
    private var stackView = makeStackView(axies: .horizontal)
    private var labels = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    func configure(item: ProductModelSharedDetails) {
        self.item = item
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension SeasonAndGenraView {
    
    private func setup() {
        guard let item else {return}
        let genres = ProductModelUtil.getGenras(item: item)
        if let editorialItem = item as? EditorialItem, let season = ProductModelUtil.getSeason(item: editorialItem), let seasonNumber = season.seasonNumber {
            let label: UILabel
            let labelText = "Season \(seasonNumber)"
            if let firstLabel = labels.first {
                label = firstLabel
                label.text = labelText
            }
            else {
                label = makeLabel(text: labelText,  fontType: .small, fontColor: ThemeColor.white)
                addLabelToStackView(label: label, isFirstLabel: true)
            }
        }
        if let genres {
            for (index, genra) in genres.enumerated() {
                let label : UILabel
                let genraLabel = genra.title ?? ""
                if labels.count > index {
                    label = labels[index]
                    label.text = genraLabel
                }
                else {
                    label = makeLabel(text: genraLabel, fontType: .small, fontColor: ThemeColor.white)
                    addLabelToStackView(label: label)
                }
            }
        }
    }
    
    private func addLabelToStackView(label: UILabel, isFirstLabel: Bool = false) {
        labels.append(label)
        if !isFirstLabel {
            let circle = GreenCircle()
            circle.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(circle)
        }
        stackView.addArrangedSubview(label)
    }
    
    private func style() {
        stackView.spacing = dimensionCalculation(4, 4)
        layer.zPosition = 10
    }
    
    private func layout() {

        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
