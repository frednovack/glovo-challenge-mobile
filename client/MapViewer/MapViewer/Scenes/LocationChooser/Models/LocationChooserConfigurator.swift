//
//  LocationChooserConfigurator.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class LocationChooserConfigurator {
    
    var successBlock:(([City],[Country])->())?
    var failureBlock:((String)->(Void))?
    let notificationID = "locationChooserView"
    var flagRequestWithError:Bool = false
    var requestsCounter = 0
    var totalRequests = 2
    var countries:[Country]?
    var cities:[City]?

    
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(finishedRequest(notification:)), name: NSNotification.Name(rawValue: notificationID), object: nil)
    }
    
    func fetchCitiesAndCountries(success:@escaping (([City],[Country])->()), failure:@escaping ((String)->(Void))){
        self.successBlock = success
        self.failureBlock = failure
        getAllCountries(success: { (countries) in
            self.countries = countries
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notificationID), object: nil, userInfo:["success":true])
            
        }) { (errorString) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.notificationID), object: nil, userInfo:["success":false])
            
        }
        
        getAllCities(success: { (cities) in
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

        guard let userInfo = notification.userInfo else {
            return
        }
        
        
        if !(userInfo["success"] as! Bool){
            flagRequestWithError = true
        }
        
        if requestsCounter == totalRequests {
            if flagRequestWithError {
                if let failureBlock = self.failureBlock {
                    failureBlock("Failed to get data")
                }
            }else{
                if let cities = cities, let countries = countries, let successBlock = successBlock {
                    successBlock(cities,countries)
                }else{
                    if let failureBlock = failureBlock{
                        failureBlock("failed to retrieve data")
                    }
                }
            }
        }
        
    }
    
    func getAllCountries(success:@escaping (([Country])->()), failure:@escaping ((String)->())){
        Alamofire.request(BaseConnection.urlWithEndpoint("countries"), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray { (response:DataResponse<[Country]>) in
            
            switch response.result {
            case .success:
                guard let result = response.value else {
                    failure("Fail to parse object")
                    return
                }
                
                success(result)
                
                break
            case .failure:
                failure("Something is not right... request code > \(response.response?.statusCode ?? 1)")
                break
            }
        }
    }
    
    func getAllCities(success:@escaping (([City])->()), failure:@escaping ((String)->())){
        
        Alamofire.request(BaseConnection.urlWithEndpoint("cities"), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray { (response:DataResponse<[City]>) in
            
            switch response.result {
                case .success:
                    guard let result = response.value else {
                        failure("Fail to parse object")
                        return
                    }
                    
                    success(result)
                    
                    break
                case .failure:
                    failure("Something is not right... request code > \(response.response?.statusCode ?? 1)")
                    break
            }
            
            
        }
        
        
    }
    
    
}


