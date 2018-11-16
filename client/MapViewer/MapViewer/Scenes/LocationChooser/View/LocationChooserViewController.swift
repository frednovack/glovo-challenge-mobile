//
//  LocationChooserViewController.swift
//  MapViewer
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import UIKit

class LocationChooserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var origin:UIViewController
    var completionBlock:((City)->())?
    var interactor = LocationChooserInteractor()
    var presenter = LocationChooserPresenter()
    @IBOutlet weak var tableView: UITableView!
    
    init(origin:UIViewController){
        self.origin = origin
        super.init(nibName: "LocationChooserViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.fetchDataIfNeeded()
        // Do any additional setup after loading the view.
    }
    
    func chooseLocation(completion:@escaping ((City)->())){
        self.modalPresentationStyle = .overCurrentContext
        origin.present(self, animated: true, completion: nil)
        completionBlock = completion
    }

    //MARK: - Table View Handlers
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.numberOfCountries
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.citiesForCountry(MapManager.shared.countries![section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.cityCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let completion = self.completionBlock else {return}
        completion(interactor.cityForIndexPath(indexPath))
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.countryName(section)
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
