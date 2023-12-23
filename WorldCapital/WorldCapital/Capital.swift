//
//  Capital.swift
//  WorldCapital
//
//  Created by admin on 22/12/2023.
//

import Foundation
import MapKit

class Capital : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
