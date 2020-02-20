//
//  SettingListViewModel.swift
//  VTabata
//
//  Created by Anh Tran on 2/20/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import Foundation
import Combine

class SettingListViewModel: ObservableObject, Identifiable {
    @Published var settingRows: [SettingRowViewModel] = []
    @Published var title: String = ""
    
    private let settingService: SettingServiceProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(settingService: SettingServiceProtocol) {
        self.settingService = settingService
        getSettingList()
    }
    
    func getSettingList() {
        self.settingService
            .getServiceList()
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.settingRows = []
                case .finished:
                    break
                }
            }) { [weak self] settingData in
                guard let self = self else { return }
                self.settingRows = settingData.settings
                    .map({SettingRowViewModel.init(data: $0)})
                self.title = settingData.title
        }.store(in: &disposables)
    }
}
