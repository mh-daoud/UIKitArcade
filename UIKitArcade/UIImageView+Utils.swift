//
//  UIImage+Utils.swift
//  UIKitArcade
//
//  Created by admin on 10/12/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        load(url: url, completion: nil)
    }
    
    func load(url: URL, completion: (() -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        if let completion {
                            completion()
                        }
                    }
                }
            }
        }
    }
}
