//
//  SplashServiceUrl.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//

import Foundation
struct SplashServiceUrl {
    let originalUrl: String
    
    func getUrlWithDimension(width: CGFloat, height:CGFloat) -> URL? {
        if isEmpty {
            return URL(string: "")
        }
        let formattedUrl = originalUrl.replacingOccurrences(of: "{height}", with: "\(height)")
            .replacingOccurrences(of: "{width}", with: "\(width)").replacingOccurrences(of: "{croppingPoint}", with: "")
        return URL(string: formattedUrl)
    }
    
    func getUrlWithDimension(size: CGSize) -> URL? {
        getUrlWithDimension(width: size.width, height: size.height)
    }
    
    var isEmpty: Bool {
        return originalUrl.isEmpty
    }
    
    init(_ originalUrl: String) {
        self.originalUrl = originalUrl
    }
}
