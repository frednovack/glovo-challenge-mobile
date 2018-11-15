//
//  LocationChooserInteractor.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation

protocol LocationChooserInteractorOutput{
    func failedToLoadData()
    func bindData()
}

class LocationChooserInteractor : LocationChooserPresenterInput {
    
    func country(_ index: Int) -> Country {
        return countries?[index] ?? Country()
    }
    
    
    func cityForIndexPath(_ index: IndexPath) -> City {
        guard let countries = countries, let cities = cities else {
            return City()
        }
        
        return cities.filter({$0.countryCode ==  countries[index.section].code})[index.row]
        
    }
    
    
    var presenter:LocationChooserInteractorOutput?
    var cities:[City]?
    var flagRequestWithError:Bool = false
    var requestsCounter = 0
    var totalRequests = 2
    let notificationID = "locationChooserView"
    var countries:[Country]?
    
    var numberOfCountries:Int {
        return countries?.count ?? 0
    }
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(finishedRequest(notification:)), name: NSNotification.Name(rawValue: notificationID), object: nil)
    }
    
    func citiesForCountry(_ country:Country)->[City]{
        guard let theCities = cities else {
            return [City]()
        }
        
        return theCities.filter({$0.countryCode == country.code})
        
    }
    
    func fetchData(){
        
        LocationChooserConfigurator.getAllCountries(success: { (countries) in
            self.countries = countries
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notificationID), object: nil, userInfo:["success":true])

        }) { (errorString) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notificationID), object: nil, userInfo:["success":false])

        }
        
        LocationChooserConfigurator.getAllCities(success: { (cities) in
            self.cities = cities
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notificationID), object: nil, userInfo:["success":true])
            print("worked!")
        }) { (failString) in
            print(failString)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notificationID), object: nil, userInfo:["success":false])

        }

    }
    
    @objc func finishedRequest(notification: NSNotification){
        requestsCounter += 1
        guard let pres = presenter else {
            return
        }
        guard let userInfo = notification.userInfo else {

            pres.failedToLoadData()
            return
        }
        
        
        if !(userInfo["success"] as! Bool){
            flagRequestWithError = true
        }
        
        if requestsCounter == totalRequests {
            if flagRequestWithError {
                pres.failedToLoadData()
            }else{
                self.finishedFetch()
            }
        }
        
    }
    
    func finishedFetch(){
        guard let presenter = presenter else { return }
        presenter.bindData()
    }
    

    
    
}
