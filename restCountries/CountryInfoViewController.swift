//
//  InfoViewController.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 29.07.2023.
//

import UIKit

class CountryInfoViewController: UIViewController {

    private let item: Country

    private let flagImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
       // image.image = UIImage(named: "https://upload.wikimedia.org/wikipedia/ru/a/a4/Vagabund.png")
        image.backgroundColor = .red
        return image
    }()
    
    private let coatOfArms: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .brown
        return image
    }()
    
    private lazy var currency: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .cyan
        return label
    }()
    
    private let independent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        return label
    }()
    
    private let unMember: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    private let population: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .purple
        return label
    }()
    
    
    private let capital: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemPink
        return label
    }()
    
    init(item: Country) {
        self.item = item
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
        setupConstraints()
        fillData()
    }
    
    private func fillData() {
        coatOfArms.loadImage(imageUrl: item.coatOfArms.png ?? "")
        flagImage.loadImage(imageUrl: item.flags.png ?? "")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            flagImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flagImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            flagImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -view.safeAreaLayoutGuide.layoutFrame.size.width/2), // anchorX
            flagImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2*view.safeAreaLayoutGuide.layoutFrame.size.height/3),
            
            coatOfArms.topAnchor.constraint(equalTo: flagImage.topAnchor),
            coatOfArms.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 5),
            coatOfArms.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            coatOfArms.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor),
            
            capital.topAnchor.constraint(equalTo: flagImage.bottomAnchor, constant: 10),
            capital.leftAnchor.constraint(equalTo: flagImage.leftAnchor),
            capital.rightAnchor.constraint(equalTo: flagImage.rightAnchor),
            capital.bottomAnchor.constraint(equalTo: capital.topAnchor, constant: 20),
            
            population.topAnchor.constraint(equalTo: coatOfArms.bottomAnchor, constant: 10),
            population.leftAnchor.constraint(equalTo: coatOfArms.leftAnchor),
            population.rightAnchor.constraint(equalTo: coatOfArms.rightAnchor),
            population.bottomAnchor.constraint(equalTo: population.topAnchor, constant: 20),
            
            currency.topAnchor.constraint(equalTo: capital.bottomAnchor, constant: 10),
            currency.leftAnchor.constraint(equalTo: capital.leftAnchor),
            currency.rightAnchor.constraint(equalTo: capital.rightAnchor),
            currency.bottomAnchor.constraint(equalTo: currency.topAnchor, constant: 20),
            
            independent.topAnchor.constraint(equalTo: population.bottomAnchor, constant: 10),
            independent.leftAnchor.constraint(equalTo: population.leftAnchor),
            independent.rightAnchor.constraint(equalTo: population.rightAnchor),
            independent.bottomAnchor.constraint(equalTo: independent.topAnchor, constant: 20),
            
            
        ])
    }

}
