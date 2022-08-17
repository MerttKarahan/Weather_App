//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created by Mert Karahan on 3.08.2022.
//

import UIKit

protocol AnySearchScreenView {
    var searchInteractor: AnySearchScreenInteractor? { get set }
    func getResponseFromPresenter(response: PlaceItemResponse)
}

protocol SearchViewDelegate : AnyObject {
//    func didSelectPlace(geoloc: Details)
    func didSelectPlace(lat: Double, lng: Double)
}

class SearchScreenViewController: UIViewController, AnySearchScreenView {
    
    var searchInteractor: AnySearchScreenInteractor?
    var numberOfItems: Int = 0
    var cellItem: [PlaceItem?] = []
    
    weak var delegate: SearchViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle:.main), forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.tintColor = UIColor(red: 199/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1)
    }
    
    func getResponseFromPresenter(response: PlaceItemResponse) {
        numberOfItems = response.hits.count
        cellItem = response.hits
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchScreenViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.searchConfigure(item: cellItem[indexPath.row]!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let lnglat = cellItem[indexPath.row]?._geoloc
        
        let lat = cellItem[indexPath.row]?._geoloc.lat ?? 0
        let lng = cellItem[indexPath.row]?._geoloc.lng ?? 0
        
//        delegate?.didSelectPlace(geoloc: lnglat!)
        delegate?.didSelectPlace(lat: lat, lng: lng)
        navigationController?.popViewController(animated: true)
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchInteractor?.fetchPlaceResponseFromWorker(text: searchText)
    }
    
}


