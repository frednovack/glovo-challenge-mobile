//
//  LocationChooserPresenter.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import UIKit

protocol LocationChooserPresenterInput {
    func cityForIndexPath(_ index:IndexPath)->City
    func country(_ index:Int)->Country
}

class LocationChooserPresenter : LocationChooserInteractorOutput{

    var view:LocationChooserViewController?
    var interactor:LocationChooserPresenterInput?
    
    func bindData(){
        guard let vc = view else { return }
        vc.tableView.reloadData()
    }
    
    func countryName(_ index:Int)->String{
        return interactor?.country(index).name ?? ""
    }
    
    func failedToLoadData() {
        guard let vc = view else {
            return
            
        }
        let alert = UIAlertController(title: "Yo! Check your conection! 😅", message: "Something went wrong when trying to connect the server 🤷🏻‍♂️\n\nCan you try again?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yeah... I will try again 🙄", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    func cityCell(_ indexPath:IndexPath)->UITableViewCell{
        let identifier = "cityCell"
        guard let vc = view, let interactor = interactor else { return UITableViewCell()}
        
        let cell = vc.tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell()
        
        let city = interactor.cityForIndexPath(indexPath)
        
        cell.textLabel?.text = city.name
        
        return cell
    }
    


    
}
