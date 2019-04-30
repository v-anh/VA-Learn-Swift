//
//  STRService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/29/19.
//

import STRService
import ObjectMapper

struct STRServiceCountriesModel: Mappable {
    var name: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name         <- map["name"]
    }
}

final class STRServiceCountries: STRService {
    
    override var path: String {
        return "https://restcountries-v1.p.rapidapi.com/all"
    }
    
    override var headers: [String: String]? {
        return ["X-RapidAPI-Key": "AlXj8hIfHbmshz5oW8mZuzrAPXkzp1QeQzcjsntSLI7vjAaA6x"]
    }
}


struct STRServiceUrbanDictionaryModel: Mappable {
    var list: Any?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        list         <- map["list"]
    }
}

final class STRServiceUrbanDictionary: STRService {
    
    override var path: String {
        return "https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=hai"
    }
    
    override var headers: [String: String]? {
        return ["X-RapidAPI-Key": "AlXj8hIfHbmshz5oW8mZuzrAPXkzp1QeQzcjsntSLI7vjAaA6x"]
    }
}

