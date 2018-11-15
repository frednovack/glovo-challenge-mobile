//
//  LocationChooserViewController.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import UIKit

class LocationChooserViewController: UIViewController {

    var origin:UIViewController
    var completionBlock:((City)->())?
    var interactor = LocationChooserInteractor()
    
    init(origin:UIViewController){
        self.origin = origin
        super.init(nibName: "LocationChooserViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchData()
        // Do any additional setup after loading the view.
    }
    
    func chooseLocation(completion:@escaping ((City)->())){
        origin.present(self, animated: true, completion: nil)
        completionBlock = completion
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
