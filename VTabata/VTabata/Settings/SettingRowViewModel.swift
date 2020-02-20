//
//  SettingRowViewModel.swift
//  VTabata
//
//  Created by Anh Tran on 2/20/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import Foundation
import Combine

class SettingRowViewModel: ObservableObject, Identifiable {
    @Published var title: String = ""
    @Published var value: String = ""
    
    init(data: SettingRowData) {
        title = data.title
        value = data.value
    }
}
