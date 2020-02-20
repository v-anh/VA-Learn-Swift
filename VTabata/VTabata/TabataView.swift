//
//  TabataView.swift
//  VTabata
//
//  Created by Anh Tran on 2/16/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import SwiftUI

struct TabataView: View {
    var body: some View {
        VStack {
            Text("00:30")
                .font(.system(size: 100))
                .fontWeight(.bold)
            Button(action: start) {
                Text("Start")
                    .font(.system(size: 100))
            }
        }
    }
    
    func start() -> Void {
        
    }
}

struct TabataView_Previews: PreviewProvider {
    static var previews: some View {
        TabataView()
    }
}
