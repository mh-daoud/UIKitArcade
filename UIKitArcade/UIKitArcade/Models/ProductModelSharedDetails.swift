//
//  sss.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation

protocol ProductModelSharedDetails {
    var id: Int? {get set}
    var title: String? {get set}
    var description: String? {get set}
    var shortDescription: String? {get set}
    var image : SizedImage? {get set}
    var thumbnailImage: String? {get set}
    var mainImage: String? {get set}
    var logoTitleImage: String? {get set}
    var genres: [Genra]? {get set}
    var persons: [Person]? {get set}
    var productType: String? {get set}
}
