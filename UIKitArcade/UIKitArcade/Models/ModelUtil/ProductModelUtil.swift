//
//  ProductModelUtil.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//




import Foundation



struct ProductModelUtil {
    
    static func getPosterImage(item: ProductModelSharedDetails) -> SplashServiceUrl {
        let sizedImage = item.image
        return SplashServiceUrl(sizedImage?.posterImage ?? sizedImage?.posterClean ?? "")
    }
    
    static func getLandscapeImage(item: ProductModelSharedDetails) -> SplashServiceUrl {
        let sizedImage = item.image
        return SplashServiceUrl(sizedImage?.thumbnailImage ?? sizedImage?.landscapeClean ?? "")
    }
    
    static func getHeroImage(item: ProductModelSharedDetails, forShowPage: Bool = false) -> SplashServiceUrl {
        let sizedImage = item.image
        if isTablet() {
            return SplashServiceUrl(forShowPage ? sizedImage?.landscapeClean ?? sizedImage?.thumbnailImage ?? "" : sizedImage?.heroSliderImage ?? sizedImage?.landscapeClean ?? sizedImage?.thumbnailImage ?? "")
        }
        else {
            return SplashServiceUrl(forShowPage ? sizedImage?.landscapeClean ?? sizedImage?.posterClean ?? sizedImage?.posterImage ?? "" : sizedImage?.posterHero ?? sizedImage?.posterClean ?? sizedImage?.posterImage ?? "")
        }
    }
    
    static func getLogoTitle(item: ProductModelSharedDetails) -> SplashServiceUrl {
        SplashServiceUrl(item.logoTitleImage ?? "")
    }
    
    static func getGenras(item: ProductModelSharedDetails) -> [Genra]? {
        item.genres
    }
    
    static func getSeason(item: EditorialItem) -> Season? {
        item.season
    }
    
    static func getSeasonNumber(item: Season) -> String? {
        item.seasonNumber
    }
    
    static func getTag(item: Season) -> String? {
        item.tag
    }
}
