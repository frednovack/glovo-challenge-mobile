//
//  BaseConnection.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation


class BaseConnection {
    
    static let baseURL = Bundle.main.infoDictionary?["baseURL"] as? String ?? ""
    
    static func urlWithEndpoint(_ endpoint:String)->String{
        return "\(baseURL)/api/\(endpoint)"
    }
}
