//
//  SplashServiceUrl.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//

import Foundation
struct SplashServiceUrl {
    let originalUrl: String
    
    func getUrlWithDimension(width: CGFloat, height:CGFloat, withType : ImageType? = nil) -> URL? {
        if isEmpty {
            return URL(string: "")
        }
        var formattedUrl = originalUrl.replacingOccurrences(of: "{height}", with: "\(height == 0 ? "" : "\(height)")")
            .replacingOccurrences(of: "{width}", with: "\(width)").replacingOccurrences(of: "{croppingPoint}", with: "")
        if let withType {
            formattedUrl += "&type=\(withType.rawValue)"
        }
        return URL(string: formattedUrl)
    }
    
    func getUrlWithDimension(size: CGSize, withType: ImageType? = nil) -> URL? {
        getUrlWithDimension(width: size.width, height: size.height, withType: withType)
    }
    
    var isEmpty: Bool {
        return originalUrl.isEmpty
    }
    
    init(_ originalUrl: String) {
        self.originalUrl = originalUrl
    }
}


enum ImageType : String {
    case Png = "png"
    case Webp = "webp"
}
