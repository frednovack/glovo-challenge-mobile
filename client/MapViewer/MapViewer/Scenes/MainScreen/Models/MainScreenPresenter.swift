//
//  MainScreenPresenter.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol MainScreenPresenterInput{
    func fetchDataForCity(_ city:City, success:@escaping ((City)->()), failure:@escaping ((String)->(Void)))
    func allCityMarkers()->[GMSMarker]
}

class MainScreenPresenter: NSObject, MainScreenInteractorOutput, GMSMapViewDelegate {

    var viewController:MainScreenViewController?{
        didSet{
            if let viewController = viewController{
                viewController.mapView.delegate = self
            }
        }
    }
    var askToChooseACity = false
    var markers = [GMSMarker]()
    var interactor:MainScreenPresenterInput?
    
    
    
    func updateMapWithUserPosition(location: CLLocation) {
        guard let _ = viewController else {
            return
        }
        let marker = GMSMarker(position: location.coordinate)
        marker.title = "Current Location"
        marker.map = viewController!.mapView
        marker.isTappable = true
        
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 13)
        viewController!.mapView.camera = camera
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        guard let vc = viewController else {return}
        vc.contentView.alpha = 0.4
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        guard let vc = viewController else {return}
        vc.contentView.alpha = 1
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        guard let interactor = interactor, let vc = viewController else {return}
        if position.zoom < 9.0 && markers.count == 0{
            //show markers
            markers = interactor.allCityMarkers()
            for marker in markers {
                marker.map = vc.mapView
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let city = marker.userData as? City else {return true}
        
        self.focusMap(city)
        
        return true
    }
    
    func chooseLocationWhenReady() {
        askToChooseACity = true
    }
    
    func focusMap(_ city:City){
        guard let vc = viewController else {return}
        vc.mapView.clear()
        markers.removeAll()
        for encondedPath in city.workingArea {
            let path = GMSPath(fromEncodedPath: encondedPath)
            let polygon = GMSPolygon(path: path)
            polygon.map = vc.mapView
        }
        
        if let interactor = interactor, let vc = viewController {
            interactor.fetchDataForCity(city, success: { (detailedCity) in
                vc.cityLabel.text = detailedCity.name
                vc.currencyLabel.text = "Currency: \(detailedCity.currency!)"
                vc.timeZoneLabel.text = "Time Zone: \(detailedCity.time_zone!)"
            }) { (errorString) -> (Void) in
                vc.contentView.isHidden = true
            }
        }
        
        let bounds = GMSCoordinateBounds(path: GMSPath(fromEncodedPath:city.workingArea.first(where: {!$0.isEmpty})!)!)
        for area in city.workingArea{
            if let path = GMSPath(fromEncodedPath: area), !area.isEmpty {
                bounds.includingPath(path)
            }
        }
        let cameraUpdate = GMSCameraUpdate.fit(bounds)
        vc.mapView.animate(with: cameraUpdate)
//        let pointToFocus = GMSPath.init(fromEncodedPath: city.workingArea.first(where: {!$0.isEmpty})!)
//        vc.mapView.camera = GMSCameraPosition.camera(withTarget: pointToFocus!.coordinate(at: 0), zoom: 13.0)

    }
    
    func chooseLocationManually() {
        guard let vc = viewController else {return}
        LocationChooserViewController(origin: vc).chooseLocation { (city) in
            self.focusMap(city)
        }
    }
    
    
}
