//
//  MainScreenInteractor.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol MainScreenInteractorOutput {
    func updateMapWithUserPosition(location:CLLocation)
    func chooseLocationManually()
    func chooseLocationWhenReady()
    
}

class MainScreenInteractor : NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var presenter:MainScreenInteractorOutput?
    var flagShouldCheckCoveredArea = true
    
    
    func checkForLocationPermission(){
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            if let presenter = presenter {
                presenter.chooseLocationManually()
            }
            break
        case .denied:
            if let presenter = presenter {
                presenter.chooseLocationManually()
            }
            break
        default:
            break
        }
        
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
    
    func checkIfLocationIsCovered(location:CLLocation){
        guard let cities = MapManager.shared.cities else {return}
        var flagCoveredArea = false
        for city in cities {
            for encondedPath in city.workingArea {
                let path = GMSPath(fromEncodedPath: encondedPath)
                if GMSGeometryContainsLocation(location.coordinate, path!, true){
                    flagCoveredArea = true
                }
            }
        }
        
        if flagCoveredArea {
            print("User is in Covered Area")
        }else{
            print("User is no in Covered Area")
        }
        
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
        if flagShouldCheckCoveredArea{
            flagShouldCheckCoveredArea = false
            checkIfLocationIsCovered(location: location)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Go to Selection Screen
    }
    
    
    
}
