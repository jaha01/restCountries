//
//  ViewController.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 23.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var allCountries = [Country]()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    private let countriesService: CountriesServiceProtocol
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(countriesService: CountriesServiceProtocol) {
        self.countriesService = countriesService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        countriesService.loadCountries { [weak self] countries in //countriesServise, countriesLoadData
            let countriesViewData = countries.map { CountryViewData(country: $0) }
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.allCountries = countries
                self.tableView.reloadData()
            }
            
        }
        view.addSubview(tableView)
        navigationItem.title = "Countires List"
        tableView.delegate = self
        tableView.dataSource = self
        
        createSearchBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allCountries[indexPath.row].name.common
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = allCountries[indexPath.row]
        let vc = CountryInfoViewController(countriesService: countriesService, item: CountryViewData(country: country))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Search
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            countriesService.loadFilteredCountries(searchText: searchText) { [weak self] data in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.allCountries = data
                    self.tableView.reloadData()
                }
            }
        } else if searchText == "" {
            countriesService.loadCountries { [weak self] countries in //countriesServise, countriesLoadData
                let countriesViewData = countries.map { CountryViewData(country: $0) }
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.allCountries = countries
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
