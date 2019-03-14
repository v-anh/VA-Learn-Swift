//
//  File.swift
//  STRServiceExample
//
//  Created by Tran Viet Anh on 2019/03/11.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import UIKit


protocol AppDisplayable {
    func display(error: AppModels.Error)
}

extension AppDisplayable where Self: UIViewController {
    func display(error: AppModels.Error) {
        let alertController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {return}
        rootVC.present(alertController, animated: true, completion: nil)
    }
}
