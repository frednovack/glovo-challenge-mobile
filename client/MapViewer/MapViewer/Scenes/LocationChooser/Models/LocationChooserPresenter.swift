//
//  LocationChooserPresenter.swift
//  MapViewer
//
//  Created by Frederico Novack on 15/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import Foundation
import UIKit

class LocationChooserPresenter : LocationChooserInteractorOutput{
    
    var view:LocationChooserViewController?
    
    func failedToLoadCities() {
        guard let vc = view else {
            return
            
        }
        let alert = UIAlertController(title: "Yo! Check your conection! 😅", message: "Something went wrong when trying to connect the server 🤷🏻‍♂️\n\nCan you try again?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yeah... I will try again 🙄", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }

    
}
