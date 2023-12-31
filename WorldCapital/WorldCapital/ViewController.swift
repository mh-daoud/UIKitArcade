//
//  ViewController.swift
//  WorldCapital
//
//  Created by admin on 22/12/2023.
//

import UIKit
import MapKit
class ViewController: UIViewController {
    
    let mapView = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        style()
        layout()
    }
    
}

extension ViewController {
    
    func setup(){
        mapView.delegate = self
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(rome)
        mapView.addAnnotation(washington)
    }
    
    func style(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        [mapView].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController : MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is Capital else {return nil}
    
            let reusableId = "Capital"
    
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reusableId)
    
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reusableId)
                annotationView?.canShowCallout = true
                let button = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = button
            }
            else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

