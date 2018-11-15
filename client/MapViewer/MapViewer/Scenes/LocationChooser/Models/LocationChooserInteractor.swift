//
//  LocationChooserInteractor.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation

protocol LocationChooserInteractorOutput{
    func failedToLoadCities()
}

class LocationChooserInteractor {
    
    var presenter:LocationChooserInteractorOutput?
    var cities:[City]?
    var flagRequestWithError:Bool = false
    var requestsCounter = 0
    var totalRequests = 2
    let notificationID = "locationChooserView"
    var countries:[Country]?
    var numberOfCountries:Int {
        guard let returnedCities = cities else {
            return 0
        }
        
       return Dictionary(grouping: returnedCities, by: {$0.countryCode}).count
        
    }
    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(finishedRequest(notification:)), name: NSNotification.Name(rawValue: notificationID), object: nil)
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

            pres.failedToLoadCities()
            return
        }
        
        
        if !(userInfo["success"] as! Bool){
            flagRequestWithError = true
        }
        
        if requestsCounter == totalRequests {
            if flagRequestWithError {
                pres.failedToLoadCities()
            }else{
                self.finishedFetch()
            }
        }
        
    }
    
    func finishedFetch(){
        print("finished fetch")
    }
    

    
    
}
