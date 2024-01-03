//
//  LandingPageViewController+Networking.swift
//  UIKitArcade
//
//  Created by admin on 03/01/2024.
//

import Foundation

extension LandingPageViewController {
    
    func fetchContainerItems(playlistId: String , pageNumber: Int = 0, onCompletion: ((ContainerCache)-> Void)? = nil) {
        var containerFromCache = containersCache[playlistId]
        if containerFromCache == nil {
            containerFromCache = [
                ContainersCacheKey.pageNumber : nil,
                .editorials : nil,
                .playlistId: playlistId,
                .hasMore: nil,
                .count : nil
            ]
        }
        guard var containerFromCache else {return}
        
        let block =  {
            if let onCompletion {
                DispatchQueue.main.async {
                    onCompletion(containerFromCache)
                }
            }
        }
        
        APIMock.shared.getContainerItems(playlistId: playlistId, pageNumber: pageNumber, pageSize: Config.pageSize) { editorialResponse in
            guard let editorialItems = editorialResponse.editorialItems else {
                block()
                return
            }
            if var editorials = containerFromCache[.editorials] as? [EditorialItem] {
                editorials.append(contentsOf: editorialItems.compactMap({ $0.item }))
            } else {
                containerFromCache[.editorials] =  editorialItems.compactMap({ $0.item })
            }
            containerFromCache[.pageNumber] = pageNumber
            containerFromCache[.hasMore] = editorialResponse.hasMore
            containerFromCache[.count] = editorialResponse.count
            block()
        } failure: { errorMessage in
            print("HeroSliderTableViewCell fetchEditorials error \(errorMessage)")
            block()
        }
    }
    
    func getContainerFromCache(playlistId: String) -> ContainerCache? {
        let containerFromCache = containersCache[playlistId]
        return containerFromCache
    }
    
}
