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

class MainScreenPresenter: NSObject, MainScreenInteractorOutput {
    
    var viewController:MainScreenViewController?
    
    func updateMapWithUserPosition(location: CLLocation) {
        guard let _ = viewController else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 6.0)
        viewController!.mapView.camera = camera
        
    }
    
    func focusMap(_ city:City){
        guard let vc = viewController else {return}

        for encondedPath in city.workingArea {
            let path = GMSPath(fromEncodedPath: encondedPath)
            let polyline = GMSPolyline(path: path)
            polyline.map = vc.mapView
        }
        
        let pointToFocus = GMSPath.init(fromEncodedPath: city.workingArea.first(where: {!$0.isEmpty})!)
        vc.mapView.camera = GMSCameraPosition.camera(withTarget: pointToFocus!.coordinate(at: 0), zoom: 13.0)

        
    }
    
    
}
