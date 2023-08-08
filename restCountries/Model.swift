//
//  Model.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 23.07.2023.
//

import Foundation

struct Country: Codable {
    
    let name: NamesItem
    let tld: [String]?
    let independent: Bool?
    let status: String
    let unMember: Bool
    //let currencies: [String:CurrencyItem]
    let idd: IddItem
    let capital: [String]?
    let altSpellings: [String]
    let region: String
    let subregion: String?
    //let languages: String -- same as a currency
//    let translations: String -- same as a currency
    let latlng: [Double]?
    let area: Double
    let borders: [String]?
//    let demonyms: String -- same as a currency
    let maps: MapsItem
    let population: Int
//    let fifa: String
    let car: CarItem
    let timezones: [String]
    let continents: [String]
    let flags: FlagsItem
    let coatOfArms: FlagsItem
    let startOfWeek: String
    let capitalInfo: Coordination

}

struct CurrencyItem: Codable {
    let name: String
    let symbol: String
}

struct NamesItem: Codable {
    let common: String
    let official: String
//    let nativeName: - tot je vopros s currecy
    
//"nativeName": {
//"rus": {
//"official": "Республика Таджикистан",
//"common": "Таджикистан"
//},
//"tgk": {
//"official": "Ҷумҳурии Тоҷикистон",
//"common": "Тоҷикистон"
//}
    }


/* kak bit v etom sluchae
 "currencies": {
 "USD": {
 "name": "US DOLLAR",
 "symbol": "$" dictionary
 }
 },
 */

struct IddItem: Codable {
    let root: String?
    let suffixes: [String]?
}

struct DemonymsItem: Codable {
    // ta je problema
}

struct MapsItem: Codable {
    let googleMaps: String
    let openStreetMaps: String
}

struct CarItem: Codable {
    let signs: [String]?
    let side: String
}

struct FlagsItem: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

struct Coordination: Codable {
    let latlng: [Double]?
}


class CustomError: Error {
    var message: String
    init(message: String) {
        self.message = message
    }
    
}
