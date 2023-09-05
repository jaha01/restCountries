//
//  MockCountriesService.swift
//  restCountries
//
//  Created by Yaroslav Magin on 09.08.2023.
//

import Foundation

// test class
final class MockCountriesService: CountriesServiceProtocol {
    func loadCountries(completion: @escaping ([Country]) -> Void) {
        completion([
//            Country(name: <#T##NamesItem#>, tld: <#T##[String]?#>, independent: <#T##Bool?#>, status: <#T##String#>, unMember: <#T##Bool#>, idd: <#T##IddItem#>, capital: <#T##[String]?#>, altSpellings: <#T##[String]#>, region: <#T##String#>, subregion: <#T##String?#>, latlng: <#T##[Double]?#>, area: <#T##Double#>, borders: <#T##[String]?#>, maps: <#T##MapsItem#>, population: <#T##Int#>, car: <#T##CarItem#>, timezones: <#T##[String]#>, continents: <#T##[String]#>, flags: <#T##FlagsItem#>, coatOfArms: <#T##FlagsItem#>, startOfWeek: <#T##String#>, capitalInfo: <#T##Coordination#>),
//            Country(name: <#T##NamesItem#>, tld: <#T##[String]?#>, independent: <#T##Bool?#>, status: <#T##String#>, unMember: <#T##Bool#>, idd: <#T##IddItem#>, capital: <#T##[String]?#>, altSpellings: <#T##[String]#>, region: <#T##String#>, subregion: <#T##String?#>, latlng: <#T##[Double]?#>, area: <#T##Double#>, borders: <#T##[String]?#>, maps: <#T##MapsItem#>, population: <#T##Int#>, car: <#T##CarItem#>, timezones: <#T##[String]#>, continents: <#T##[String]#>, flags: <#T##FlagsItem#>, coatOfArms: <#T##FlagsItem#>, startOfWeek: <#T##String#>, capitalInfo: <#T##Coordination#>)
        ])
    }
    
    func loadFilteredCountries(searchText: String, completion: @escaping ([Country]) -> Void) {
        
    }
    
    func loadCountry(fullName: String, completion: @escaping ([Country]) -> Void) {
        
    }
    
    
}
