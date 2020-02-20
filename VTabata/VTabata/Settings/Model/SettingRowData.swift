//
//  SettingRowData.swift
//  VTabata
//
//  Created by Anh Tran on 2/20/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import Foundation

enum SettingType:Int, Codable {
    case name = 0
    case mode
    case coolDown
    case warmUp
}

struct SettingRowData: Codable, Identifiable {
    var id: Int
    let title: String
    let value: String
    let type: SettingType = .name
}

struct SettingData: Codable, Identifiable {
    var id: Int
    let title: String
    let settings: [SettingRowData]
}
