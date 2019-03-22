//
//  CharacterService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import STRService

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
