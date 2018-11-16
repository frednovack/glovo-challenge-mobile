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

    var presenter:LocationChooserInteractorOutput?
    
    func country(_ index: Int) -> Country {
        return MapManager.shared.countries?[index] ?? Country()
    }
    
    
    func cityForIndexPath(_ index: IndexPath) -> City {
        guard let countries = MapManager.shared.countries, let cities = MapManager.shared.cities else {
            return City()
        }
        
        return cities.filter({$0.countryCode ==  countries[index.section].code})[index.row]
        
    }
    
    
    var numberOfCountries:Int {
        return MapManager.shared.countries?.count ?? 0
    }
    
    init(){

    }
    
    func fetchDataIfNeeded(){
        if MapManager.shared.cities == nil || MapManager.shared.countries == nil{
            LocationChooserConfigurator().fetchCitiesAndCountries(success: { (cities, countries) in
                MapManager.shared.cities = cities
                MapManager.shared.countries = countries
                if let presenter = self.presenter{
                    presenter.bindData()
                }
            }) { (failureString) -> (Void) in
                if let presenter = self.presenter {
                    presenter.failedToLoadData()
                }
            }
        }
    }
    
    func citiesForCountry(_ country:Country)->[City]{
        guard let theCities = MapManager.shared.cities else {
            return [City]()
        }
        
        return theCities.filter({$0.countryCode == country.code})
        
    }
    
    
    

    
    
}
