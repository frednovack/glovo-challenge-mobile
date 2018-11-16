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
}

class MainScreenPresenter: NSObject, MainScreenInteractorOutput {

    var viewController:MainScreenViewController?
    var askToChooseACity = false
    var interactor:MainScreenPresenterInput?
    
    func updateMapWithUserPosition(location: CLLocation) {
        guard let _ = viewController else {
            return
        }
        let marker = GMSMarker(position: location.coordinate)
        marker.title = "Current Location"
        marker.map = viewController!.mapView
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 13)
        viewController!.mapView.camera = camera
        
    }
    
    func chooseLocationWhenReady() {
        askToChooseACity = true
    }
    
    func focusMap(_ city:City){
        guard let vc = viewController else {return}

        for encondedPath in city.workingArea {
            let path = GMSPath(fromEncodedPath: encondedPath)
            let polygon = GMSPolygon(path: path)
            polygon.map = vc.mapView
        }
        
        if let interactor = interactor, let vc = viewController {
            interactor.fetchDataForCity(city, success: { (detailedCity) in
                vc.cityLabel.text = detailedCity.name
                vc.currencyLabel.text = detailedCity.currency!
                vc.timeZoneLabel.text = detailedCity.time_zone!
            }) { (errorString) -> (Void) in
                vc.contentView.isHidden = true
            }
        }
        
        let pointToFocus = GMSPath.init(fromEncodedPath: city.workingArea.first(where: {!$0.isEmpty})!)
        vc.mapView.camera = GMSCameraPosition.camera(withTarget: pointToFocus!.coordinate(at: 0), zoom: 13.0)

    }
    
    func chooseLocationManually() {
        guard let vc = viewController else {return}
        LocationChooserViewController(origin: vc).chooseLocation { (city) in
            self.focusMap(city)
        }
    }
    
    
}
