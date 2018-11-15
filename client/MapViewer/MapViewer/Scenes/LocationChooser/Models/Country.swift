//
//  Country.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import ObjectMapper

class Country : Mappable{
    
    var code:String!
    var name:String!

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
    }
}
