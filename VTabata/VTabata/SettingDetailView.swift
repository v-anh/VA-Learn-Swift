//
//  ContentView.swift
//  VTabata
//
//  Created by Anh Tran on 2/6/20.
//  Copyright © 2020 Anh Tran. All rights reserved.
//

import SwiftUI
import MapKit

struct SettingDetailView: View {
    @ObservedObject var viewModel: SettingRowViewModel
    
    init(viewModel: SettingRowViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height:300)
            CircleImage()
                .offset(y:-130)
                .padding(.bottom,-130)
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                HStack(alignment:.top) {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California2")
                }
            }.padding()
            Spacer()
        }.navigationBarTitle(Text(viewModel.title), displayMode: .inline)
    }
}

struct SettingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let settingRowData = SettingRowData(id: 1, title: "Title", value: "Value")
        let viewModel = SettingRowViewModel(data: settingRowData)
        return SettingDetailView(viewModel: viewModel)
    }
}

struct CircleImage: View {
    var body: some View {
        Image("IMG_0776")
            .padding()
            .frame(width: 300, height: 300, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
        
        
    }
}

struct MapView: UIViewRepresentable {
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
}
