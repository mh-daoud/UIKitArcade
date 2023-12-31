//
//  EditorialItem.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//

import Foundation

struct EditorialItem :  Codable, ProductModelSharedDetails {
   
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

    var numberOfAvodSeasons: Int?
    var numberOfAvodEpisodeForShow: Int?
    var avodSeasonNumber: String?
    var season: Season?
}

