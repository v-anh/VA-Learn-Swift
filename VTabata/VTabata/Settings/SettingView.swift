//
//  SettingView.swift
//  VTabata
//
//  Created by Anh Tran on 2/16/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: SettingListViewModel
    
    init(viewModel: SettingListViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            List(self.viewModel.settingRows) { data in
                Section {
                    NavigationLink(destination: SettingDetailView(viewModel: data)) {
                        SettingRowView(viewModel: data)
                    }
                }
            }
            .listStyle(GroupedListStyle())
                .navigationBarTitle(viewModel.title)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SettingListViewModel(settingService: SettingService())
        return SettingView(viewModel: viewModel).environment(\.locale, .init(identifier: "vi"))
    }
}
