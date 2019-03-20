//
//  CharacterService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import ObjectMapper
import STRService

public struct Character: Mappable {
    var name: String = ""
    var description: String = ""
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        name         <- map["name"]
        description    <- map["description"]
    }
}

public struct CharacterService: STRService {
    public typealias ResponseType = Character
    
    private var _data : RequestData = RequestData(path: "https://test.com/character", method: .get, params: [:], headers: nil)
    public var data : RequestData {
        get {
            return _data
        }
        set {
            self._data = newValue
        }
    }
    
    init(){}
}
