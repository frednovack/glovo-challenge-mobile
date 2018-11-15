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

class LocationChooserConfigurator : BaseConnection{
    
    static func getAllCities(success:@escaping (([City])->()), failure:@escaping ((String)->())){
        
        Alamofire.request(urlWithEndpoint("cities"), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray { (response:DataResponse<[City]>) in
            
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


