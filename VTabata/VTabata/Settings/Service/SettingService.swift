//
//  SettingService.swift
//  VTabata
//
//  Created by Anh Tran on 2/20/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import Foundation
import Combine

protocol SettingServiceProtocol {
    func getServiceList() -> AnyPublisher<SettingData,Error>
}

struct SettingService: SettingServiceProtocol {
    func getServiceList() -> AnyPublisher<SettingData,Error> {
        return FileManager.readJsonFile(from: "settingData")
            .tryCompactMap { data -> SettingData in
                let decoder = JSONDecoder()
                return try decoder.decode(SettingData.self, from: data)
        }.eraseToAnyPublisher()
    }
}

extension FileManager {
    static func readJsonFile(from fileName: String) -> AnyPublisher<Data, Error> {
        return Just(fileName)
            .compactMap { Bundle.main.path(forResource: $0, ofType: "json")}
            .tryCompactMap { filePath -> Data in
                let url = URL(fileURLWithPath: filePath)
                return try Data(contentsOf: url, options: .mappedIfSafe)
        }.eraseToAnyPublisher()
    }
}
