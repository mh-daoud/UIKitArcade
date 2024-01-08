//
//  ContainersCacheKey.swift
//  UIKitArcade
//
//  Created by admin on 03/01/2024.
//

import Foundation

class StoredContainer {
    var pageNumber: Int? = nil
    var editorials: [ProductModelSharedDetails]? = nil
    var playlistId: String
    var hasMore: Bool? = nil
    var count: Int? = nil
    
    init(playlistId: String, pageNumber: Int? = nil, editorials: [EditorialItem]? = nil, hasMore: Bool? = nil, count: Int? = nil) {
        self.pageNumber = pageNumber
        self.editorials = editorials
        self.playlistId = playlistId
        self.hasMore = hasMore
        self.count = count
    }
}

class LandingPageContainersStore {
    
    private var store: [String: StoredContainer]
    
    init() {
        self.store = [:]
    }
    
    func getContainerFromStore(playlistId: String) -> StoredContainer? {
        let containerFromStore = store[playlistId]
        return containerFromStore
    }
    
    func updateContainerStoreForPlaylist(playlistId: String, containerToStore: StoredContainer) {
        store[playlistId] = containerToStore
    }
    
    func createStoredContainerForPlaylistId(playlistId: String) -> StoredContainer {
        StoredContainer(playlistId: playlistId)
    }
    
    func createStoredContainerForPlaylistId(playlistId: String, response: ContainerEditorialResponse) -> StoredContainer {
        StoredContainer(playlistId: playlistId,
                        pageNumber: response.pageNumber,
                        editorials: response.editorialItems?.compactMap({ $0.item}),
                        hasMore: response.hasMore,
                        count: response.count)
    }
}
