//
//  Season.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation

struct Season : Codable, ProductModelSharedDetails{
    var id: Int?
    var title: String?
    var description: String?
    var shortDescription: String?
    var image: SizedImage?
    var thumbnailImage: String?
    var mainImage: String?
    var logoTitleImage: String?
    var genres: [Genra]?
    var persons: [Person]?
    var productType: String?

    var showItem: ShowItem?
    var seasonNumber: String?
    var seasonName: String?
    var tag: String?
    
    
}
