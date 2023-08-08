//
//  ViewController.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 23.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var allCountries = [Country]()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        DI.shared.service.loadData { [weak self] data in //countriesServise, countriesLoadData
            guard let self = self else {return}
            self.allCountries = data
            self.tableView.reloadData()
        }
        view.addSubview(tableView)
        navigationItem.title = "Countires List"
        tableView.delegate = self
        tableView.dataSource = self
         //???
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let vc = CountryInfoViewController(item: country)
        vc.title = country.name.common // перенести
        //let navigationController = UINavigationController()
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    
    
}
