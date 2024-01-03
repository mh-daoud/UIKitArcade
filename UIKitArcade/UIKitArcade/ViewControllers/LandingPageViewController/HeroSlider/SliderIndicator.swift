//
//  SliderIndicator.swift
//  UIKitArcade
//
//  Created by admin on 02/01/2024.
//

import Foundation

import UIKit

class SliderIndicator : UIView {
    
    private var count: Int = 0
    private var activeIndicator: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let self else {return}
                if oldValue >= 0 && oldValue < indicators.count {
                    indicators[oldValue].backgroundColor = ThemeColor.gray1
                }
                if activeIndicator >= 0 &&  activeIndicator < indicators.count {
                    indicators[activeIndicator].backgroundColor = ThemeColor.jungleGreen
                }
            }
            
        }
    }
    
    private var indicators: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configure(count: Int) {
        self.count = count
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: dimensionCalculation(2, 2))
    }
}

extension SliderIndicator {
    
    func setup() {
        indicators.removeAll()
        for _ in 0..<count {
            let indicator = makeIndicator()
            indicators.append(indicator)
        }
    }
    
    func layout(){
        indicators.forEach(addSubview(_:))
        
        for (index, indicator) in indicators.enumerated() {
            NSLayoutConstraint.activate([
                indicator.topAnchor.constraint(equalTo: topAnchor),
                indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
                indicator.widthAnchor.constraint(equalToConstant: dimensionCalculation(8, 8)),
                indicator.heightAnchor.constraint(equalToConstant: dimensionCalculation(2, 2))
            ])
            if index == 0 {
                indicator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            }
            else {
                let prevIndicator = indicators[index - 1]
                indicator.leadingAnchor.constraint(equalToSystemSpacingAfter: prevIndicator.trailingAnchor, multiplier: 0.8).isActive = true
            }
            if index == indicators.count - 1 {
                indicator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            }
        }
    }
    
    func setActive(index: Int) {
        activeIndicator = index
    }
    
    private func makeIndicator() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.gray1
        return view
    }
}
