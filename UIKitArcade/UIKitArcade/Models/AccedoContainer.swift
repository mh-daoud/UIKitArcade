//
//  AccedoContainer.swift
//  UIKitArcade
//
//  Created by admin on 28/12/2023.
//

import Foundation


struct AccedoContainer :  Codable {
    
//    var getTemplate: ContainerTemplate? {
//        guard let template else {return nil}
//        return  ContainerTemplate(rawValue: template) ?? nil
//    }
//    
//    var getAction: ContainerAction? {
//        guard let action else {return nil}
//        return  ContainerAction(rawValue: action) ?? nil
//    }
//    
//    var getType: ContainerType? {
//        guard let type else {return nil}
//        return  ContainerType(rawValue: type) ?? nil
//    }
    
    var displaytext: String?
    var title: String?
    var template: String?
    var playlistId: String?
    var disableRegisteredUsers: Bool
    var dynamicTitle: Bool?
    var disableAnonymousUsers: Bool
    var _meta: MetaData?
    var sortable: Bool?
    var requiresAuthentication: Bool?
    var type: String?
    var items: [ContainerItem]?
    var disableSubscribedUsers: Bool
    var action: String?
}
enum ContainerType : String, Codable {
    case SHOW = "show"
    case LIVE = "live"
    case MEDISA = "media"
}

enum ContainerTemplate : String, Codable {
    case LANDING_HERO = "landing_hero"
    case DEFAULT_LANDSCAPE = "default_landscape"
    case NATIVE_AD = "native_ad"
    case CAROUSEL = "carousel"
    case BUNDLE = "bundle"
}

enum ContainerAction : String, Codable {
    case TOP_10 = "top10"
}
struct ContainerItem : Codable {
    
}

struct MetaData: Codable {
    var id: String
    var typeId: String
}




