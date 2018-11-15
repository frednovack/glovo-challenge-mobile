//
//  MainScreenInteractor.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainScreenInteractorOutput {
    func updateMapWithUserPosition(location:CLLocation)
    func chooseLocationManually()
    func chooseLocationWhenReady()
}

class MainScreenInteractor : NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var presenter:MainScreenInteractorOutput?
    
    
    func checkForLocationPermission(){
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }else if status == .restricted || status == .denied{
            //Go To Selection Selection Screen
            if let presenter = presenter {
                presenter.chooseLocationManually()
            }
        }
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    func fetchDataAndCheckForGPSPermission(){
        LocationChooserConfigurator().fetchCitiesAndCountries(success: { (cities, countries) in
            MapManager.shared.cities = cities
            MapManager.shared.countries = countries
            self.checkForLocationPermission()
        }) { (failString) -> (Void) in
            //Do something
        }
    }
    
    //MARK: - Location Managers
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let thePresenter = presenter else {
            return
        }
        
        thePresenter.updateMapWithUserPosition(location: location)

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Go to Selection Screen
    }
    
    
    
}
