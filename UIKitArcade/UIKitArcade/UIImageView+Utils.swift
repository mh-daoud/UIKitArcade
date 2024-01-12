//
//  UIImage+Utils.swift
//  UIKitArcade
//
//  Created by admin on 10/12/2023.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func load(url: URL) {
        load(url: url, completion: nil)
    }
    
    func load(url: URL, completion: (() -> Void)?) {
        self.sd_setImage(with: url)
    }
}
