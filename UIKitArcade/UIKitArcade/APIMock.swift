//
//  APIMock.swift
//  UIKitArcade
//
//  Created by admin on 28/12/2023.
//

import Foundation


struct ContainersResponse : Codable {
    var entries: [AccedoContainer]
}

struct ContainerEditorialResponse: Codable {
    var responseCode: Int
    var success: Bool?
    var country: String?
    var editorialItems: [EditorialItemWithType]?
    var count: Int?
    var pageSize: Int?
    var pageNumber: Int?
    var hasMore: Bool?
    var backgroundImage: String?
    var title: String?
}

struct EditorialItemWithType : Codable {
    var item: EditorialItem?
    var type: String?
}

struct APIMock {
    
    static let shared = APIMock()
    
    func getContainers() -> [AccedoContainer]? {
        if let path = Bundle.main.path(forResource: "AccedoContainers", ofType: nil), let jsonData = FileManager.default.contents(atPath: path) {
            let decoder = JSONDecoder()
            do {
                let containers = try decoder.decode(ContainersResponse.self, from: jsonData)
                return containers.entries.filter { container in
                    !container.disableAnonymousUsers
                }
            }
            catch {
                print("APIMOCK error in decoding \(error.localizedDescription)")
            }
            
        }
        return nil
    }
    
    func getContainerItems(playlistId: String, pageNumber: Int, pageSize: Int,
                           success: @escaping (ContainerEditorialResponse) -> Void,
                           failure: @escaping (String) -> Void
    ) {
        
        let requestParams : [String: Any] = [
            "id": playlistId,
            "pageNumber": pageNumber,
            "pageSize": pageSize
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestParams), let jsonString = String(data: jsonData, encoding: .utf8), let url = URL(string: "https://api2.shahid.net/proxy/v2.1/editorial?request=\(jsonString)&country=JO") {
            
            var request = URLRequest(url: url)
            request.setValue("en", forHTTPHeaderField: "language")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data, error == nil else {return}
                do {
                    let decoder = JSONDecoder()
                    let containerResponse = try decoder.decode(ContainerEditorialResponse.self, from: data)
                    success(containerResponse)
                }
                catch {
                    print("getContainerItems decoding error \(error.localizedDescription)")
                    failure(error.localizedDescription)
                }
                
            }.resume()
        }
        else {
            failure("url not valid")
        }
    }
    
    private init() {
        
    }
}
