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
    
    func fetchData(){
        
        LocationChooserConfigurator.getAllCities(success: { (cities) in
            print("worked!")
        }) { (failString) in
            print(failString)
            if let _ = self.presenter {
                self.presenter!.failedToLoadCities()
            }
        }
        
        
    }
    
    
}
