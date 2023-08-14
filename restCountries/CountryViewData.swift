//
//  CountryViewData.swift
//  restCountries
//
//  Created by Yaroslav Magin on 09.08.2023.
//

import Foundation

// Mapper (map - transform 1 into 2)
// CountryNetworkMapper - maps Country -> CountryViewData
    // func map(_ countries: [Country]) -> [CountryViewData]

struct CountryViewData {
    let coatOfArmsImageUrl: String
    let flagImageUrl: String
    let capital: String
    let population: String
    let independent: String
    let unmember: String
    let name: String
    
    init(country: Country) {
        coatOfArmsImageUrl = country.coatOfArms.png ?? ""
        flagImageUrl = country.flags.png ?? ""
        capital = "Capital: \(country.capital?[0] ?? "")"
        population = "Population: \(String(country.population))"
        independent = "Independent: \(country.independent == true ? "Yes" : "No")"
        unmember = "UnMember: \(country.unMember == true ? "Yes" : "No")"
        name = country.name.common
    }
}
