//
//  City.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import ObjectMapper

class City:Mappable {
    
    var workingArea:[String]!
    var code:String!
    var name:String!
    var countryCode:String!
    var currency:String?
    var time_zone:String?
    var busy:Bool?
    
    init(){
        workingArea = [String]()
        code = ""
        name = ""
        countryCode = ""
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        workingArea <- map["working_area"]
        code        <- map["code"]
        name        <- map["name"]
        countryCode <- map["country_code"]
        currency    <- map["currency"]
        time_zone   <- map["time_zone"]
        busy        <- map["busy"]
    }
    
    
}
