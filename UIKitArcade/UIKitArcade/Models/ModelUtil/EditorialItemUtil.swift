//
//  EditorialItemUtil.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//




import Foundation



struct EditorialItemUtil {
    
    static func getPosterImage(item: EditorialItem) -> SplashServiceUrl {
        let sizedImage = item.image
        return SplashServiceUrl(sizedImage?.posterImage ?? sizedImage?.posterClean ?? "")
    }
    
    static func getLandscapeImage(item: EditorialItem) -> SplashServiceUrl {
        let sizedImage = item.image
        return SplashServiceUrl(sizedImage?.thumbnailImage ?? sizedImage?.landscapeClean ?? "")
    }
    
    static func getHeroImage(item: EditorialItem, forShowPage: Bool = false) -> SplashServiceUrl {
        let sizedImage = item.image
        if isTablet() {
            return SplashServiceUrl(forShowPage ? sizedImage?.landscapeClean ?? sizedImage?.thumbnailImage ?? "" : sizedImage?.heroSliderImage ?? sizedImage?.landscapeClean ?? sizedImage?.thumbnailImage ?? "")
        }
        else {
            return SplashServiceUrl(forShowPage ? sizedImage?.landscapeClean ?? sizedImage?.posterClean ?? sizedImage?.posterImage ?? "" : sizedImage?.posterHero ?? sizedImage?.posterClean ?? sizedImage?.posterImage ?? "")
        }
    }
    
    static func getLogoTitle(item: EditorialItem) -> SplashServiceUrl {
        SplashServiceUrl(item.logoTitleImage ?? "")
    }
}
