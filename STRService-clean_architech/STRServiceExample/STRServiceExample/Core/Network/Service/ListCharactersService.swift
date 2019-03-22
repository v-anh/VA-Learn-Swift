//
//  ListCharactersService.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

import STRService

public class ListCharactersService: STRService {
    
    public var data : RequestData {
        return RequestData(path: "https://test.com/listCharacters", method: .get, params: [:], headers: nil)
    }
    
    init(){}
}


