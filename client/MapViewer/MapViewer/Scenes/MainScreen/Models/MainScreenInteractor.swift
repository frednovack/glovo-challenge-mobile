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
    func focusMap(_ city:City)
    func drawCities(_ cities:[City])
    func failedToGetData()
}

class MainScreenInteractor : NSObject, CLLocationManagerDelegate, MainScreenPresenterInput{
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
    
    func retryConnection() {
        fetchDataAndCheckForGPSPermission()
    }
    
    func fetchDataForCity(_ city: City, success: @escaping ((City) -> ()), failure: @escaping ((String) -> (Void))) {
        LocationChooserConfigurator().detailCity(city: city, success: { (cityDetailed) in
            success(cityDetailed)
        }) { (error) in
            failure(error)
        }
    }

    func checkIfLocationIsCovered(location:CLLocation)->Bool{
        guard let cities = MapManager.shared.cities else {return false}
        var cityOfCoverage:City?
        for city in cities {
            for encondedPath in city.workingArea {
                let path = GMSPath(fromEncodedPath: encondedPath)
                if GMSGeometryContainsLocation(location.coordinate, path!, true){
                    cityOfCoverage = city
                    
                }
            }
        }
        
        if let city = cityOfCoverage {
            print("User is in Covered Area")
            if let presenter = presenter {
                presenter.focusMap(city)
            }
            return true
        }else{
            print("User is not in Covered Area")
            if let presenter = presenter{
                presenter.chooseLocationManually()
            }
            return false
        }
        
    }
    
    func allCityMarkers() -> [GMSMarker] {
        guard let cities = MapManager.shared.cities else {return [GMSMarker]()}
        var markers = [GMSMarker]()
        for city in cities {
            let path = GMSPath(fromEncodedPath:city.workingArea.first(where: {!$0.isEmpty}) ?? "")
            if let path = path {
                let marker = GMSMarker(position: path.coordinate(at: 0))
                marker.title = city.name
                marker.userData = city
                let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
                icon.image = UIImage(named: "glovo.png")
                icon.contentMode = .scaleAspectFit
                marker.iconView = icon
                markers.append(marker)
            }
            
        }
        return markers
    }
    
    
    func fetchDataAndCheckForGPSPermission(){
        LocationChooserConfigurator().fetchCitiesAndCountries(success: { (cities, countries) in
            MapManager.shared.cities = cities
            MapManager.shared.countries = countries
            if let presenter = self.presenter {
                presenter.drawCities(cities)
            }
            self.checkForLocationPermission()
        }) { (failString) -> (Void) in
            //Do something
            if let presenter = self.presenter {
                presenter.failedToGetData()
            }
        }
    }
    
    //MARK: - Location Managers
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let thePresenter = presenter else {
            return
        }

        
        
        thePresenter.updateMapWithUserPosition(location: location)
        flagShouldCheckCoveredArea = false
        checkIfLocationIsCovered(location: location)
        

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Go to Selection Screen
    }
    
    
    
}
