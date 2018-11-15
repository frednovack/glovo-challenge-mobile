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
    
    
}
