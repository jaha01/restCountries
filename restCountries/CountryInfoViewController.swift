//
//  InfoViewController.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 29.07.2023.
//

import UIKit

class CountryInfoViewController: UIViewController {
    
    private let item: String
    private let countriesService: CountriesServiceProtocol
    private var countryInfo: CountryViewData?
    
    private let flagImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let coatOfArms: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var currency: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let independent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let unMember: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let population: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let capital: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //init(fullName: String) ------> load with api method fullName
    init(countriesService: CountriesServiceProtocol, item: String) {
        self.item = item
        self.countriesService = countriesService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(flagImage)
        view.addSubview(coatOfArms)
        view.addSubview(capital)
        view.addSubview(population)
        view.addSubview(currency)
        view.addSubview(independent)
        view.addSubview(unMember)
        navigationItem.title = item
        setupConstraints()
        fillData()
    }
    
    private func fillData() {
        
        countriesService.loadCountry(fullName: item) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let country):
                let countryViewData = CountryViewData(country: country)
                DispatchQueue.main.async {
                    self.coatOfArms.loadImage(imageUrl: countryViewData.coatOfArmsImageUrl)
                    self.flagImage.loadImage(imageUrl: countryViewData.flagImageUrl)
                    self.capital.text = countryViewData.capital
                    self.population.text = countryViewData.population
                    self.independent.text = countryViewData.independent
                    self.unMember.text = countryViewData.unmember
                }
            case.failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.showError(error)
                }
            }
        }
        
    }
    
    
    //    private func fillData() {
    ////        coatOfArms.loadImage(imageUrl: item.coatOfArms.png ?? "")
    ////        flagImage.loadImage(imageUrl: item.flags.png ?? "")
    ////        capital.text = "capital: \(item.capital![0])"
    ////        population.text = "population: \(String(item.population))"
    ////        independent.text = "independent: \(item.independent == true ? "Yes" : "No")"
    ////        unMember.text = "unMember: \(item.unMember == true ? "Yes" : "No")"
    //
    //
    //
    //
    //
    //        coatOfArms.loadImage(imageUrl: item.coatOfArmsImageUrl)
    //        flagImage.loadImage(imageUrl: item.flagImageUrl)
    //        capital.text = item.capital
    //        population.text = item.population
    //        independent.text = item.independent
    //        unMember.text = item.unmember
    //    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            flagImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flagImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            flagImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.safeAreaLayoutGuide.layoutFrame.size.width/2), // anchorX
            flagImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2*view.safeAreaLayoutGuide.layoutFrame.size.height/3),
            
            coatOfArms.topAnchor.constraint(equalTo: flagImage.topAnchor),
            coatOfArms.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 5),
            coatOfArms.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            coatOfArms.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor),
            
            capital.topAnchor.constraint(equalTo: flagImage.bottomAnchor, constant: 10),
            capital.leadingAnchor.constraint(equalTo: flagImage.leadingAnchor),
            capital.trailingAnchor.constraint(equalTo: flagImage.trailingAnchor),
            capital.bottomAnchor.constraint(equalTo: capital.topAnchor, constant: 20),
            
            population.topAnchor.constraint(equalTo: coatOfArms.bottomAnchor, constant: 10),
            population.leadingAnchor.constraint(equalTo: coatOfArms.leadingAnchor),
            population.trailingAnchor.constraint(equalTo: coatOfArms.trailingAnchor),
            population.bottomAnchor.constraint(equalTo: population.topAnchor, constant: 20),
            
            unMember.topAnchor.constraint(equalTo: capital.bottomAnchor, constant: 10),
            unMember.leadingAnchor.constraint(equalTo: capital.leadingAnchor),
            unMember.trailingAnchor.constraint(equalTo: capital.trailingAnchor),
            unMember.bottomAnchor.constraint(equalTo: unMember.topAnchor, constant: 20),
            
            independent.topAnchor.constraint(equalTo: population.bottomAnchor, constant: 10),
            independent.leadingAnchor.constraint(equalTo: population.leadingAnchor),
            independent.trailingAnchor.constraint(equalTo: population.trailingAnchor),
            independent.bottomAnchor.constraint(equalTo: independent.topAnchor, constant: 20),
            
            
        ])
    }
    
}
