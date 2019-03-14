//
//  ListProductsInteractor.swift
//  STRServiceExample
//
//  Created by Tran Viet Anh on 2019/03/12.
//


struct ListProductsInteractor {
    private let presenter : ListProductsPresentable
    
    
    init(presenter:ListProductsPresentable) {
        self.presenter = presenter
    }
}
