//
//  ListProductsModels.swift
//  STRServiceExample
//
//  Created by Tran Viet Anh on 2019/03/11.
//

enum ListProductsModels {
    
    struct FetchRequest {
        
    }
    
    struct SearchRequest {
        let text: String
    }
    
    struct Response {
        let products: [Any]
    }
    
    struct ViewModel {
        let products: [ProductViewModel]
    }
    
    struct ProductViewModel {
        let id: Int
        let name: String
        let content: String
        let price: String
    }
}

