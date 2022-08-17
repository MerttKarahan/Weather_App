//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Mert Karahan on 27.07.2022.
//

import UIKit
import Moya
import CoreLocation

protocol AnyMainScreenViewController {
    var interactor: AnyMainScreenInteractor? {get set}
    func getResponseFromPresenter(response: WeatherItemResponse)
}

class MainScreenViewController: UIViewController, AnyMainScreenViewController, SearchViewDelegate, CLLocationManagerDelegate{
    
    func didSelectPlace(lat: Double, lng: Double) {
        print(#function)
        self.interactor?.fetchForecastResponseFromWorker(lat: lat, lng: lng)
    }
    
    var response: WeatherItemResponse?
    
    var locationManager = CLLocationManager()
    
    var interactor: AnyMainScreenInteractor?
    var searchScreen = SearchScreenViewController()
    
    @IBOutlet weak var cCityNameLabel: UILabel!
    @IBOutlet weak var cTempLabel: UILabel!
    @IBOutlet weak var cWeatherMainLabel: UILabel!
    @IBOutlet weak var cWindSpeedLabel: UILabel!
    @IBOutlet weak var cFeelsLikeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        requestForCurrentLocation()
        
        tableView.register(UINib(nibName: "MainScreenTableViewCell", bundle:.main), forCellReuseIdentifier: "MainScreenTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        navigationBarItems()
    }
    
    private func navigationBarItems() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItem.Style.plain, target: self, action: #selector(searchButtonClicked))
    }
    
    @objc func searchButtonClicked() {
        let searchViewController = Builder.start()
        searchViewController?.delegate = self
        self.navigationController?.pushViewController(searchViewController!, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            requestForCurrentLocation()
        default:
            break
        }
    }
    
    func requestForCurrentLocation() {
        if let currentLoc = locationManager.location {
            interactor?.fetchForecastResponseFromWorker(lat: currentLoc.coordinate.latitude, lng: currentLoc.coordinate.longitude)
        }
    }
    
    func getResponseFromPresenter(response: WeatherItemResponse) {
        self.response = response
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func mainScreenConfigure() {
        cTempLabel.text = (String(Int(response?.list[0].main.temp ?? 0)) + ("°"))
        cFeelsLikeLabel.text = ("FEELS LIKE: " + (String(Int(response?.list[0].main.feels_like ?? 0))) + ("°"))
        cWindSpeedLabel.text = ("WIND SPEED: " + (response?.list[0].wind.speed.description ?? "") + " m/s")
        cCityNameLabel.text = ((response?.city.name.uppercased() ?? "") + (" ") + (response?.city.country.uppercased() ?? ""))
        cWeatherMainLabel.text = ((response?.list[0].weather[0].main.description.uppercased() ?? "") + (" / \(response?.list[0].weather[0].description.uppercased() ?? "")" ))
    }
}

extension MainScreenViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.response?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainScreenTableViewCell", for: indexPath) as! MainScreenTableViewCell
        if let item = self.response?.list[indexPath.row] {
            cell.tableViewConfigure(list: item)
            mainScreenConfigure()
        }
        
        return cell
    }
}
