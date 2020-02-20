//
//  SettingRow.swift
//  VTabata
//
//  Created by Anh Tran on 2/16/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import SwiftUI
import Combine

struct SettingRowView: View {
    @ObservedObject var viewModel: SettingRowViewModel
    
    init(viewModel: SettingRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.title)
            Spacer()
            Text(viewModel.value)
        }
        .padding(.horizontal)
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        let settingRowData = SettingRowData(id: 1, title: "Title", value: "Value")
        let viewModel = SettingRowViewModel(data: settingRowData)
        return SettingRowView(viewModel: viewModel)
    }
}
