//
//  MainScreenViewController.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import UIKit
import GoogleMaps

class MainScreenViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    let interactor = MainScreenInteractor()
    let presenter = MainScreenPresenter()
    
   init() {
        super.init(nibName: "MainScreenViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.presenter = presenter
        presenter.viewController = self
        interactor.checkForLocationPermission()

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
