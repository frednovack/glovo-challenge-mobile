//
//  BaseConnection.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation


class BaseConnection {
    static let baseURL = "http://localhost:3000/api/"
    
    static func urlWithEndpoint(_ endpoint:String)->String{
        return "\(baseURL)\(endpoint)"
    }
}
