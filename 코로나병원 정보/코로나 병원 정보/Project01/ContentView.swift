//
//  ContentView.swift
//  SwiftUI-PieChart
//
//  Created by Kent Winder on 3/17/20.
//  Copyright © 2020 Nextzy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    var dict: Dictionary<String,Double>
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PieChart(pieChartData: self.viewModel.pieChartData)
                    .frame(width: geometry.size.width * 0.85,
                           height: geometry.size.width * 0.85)
                    .padding(.top, 20)
                     .font(.system(size: 10))
                    
                Spacer()
            }.onAppear {
                self.viewModel.drawData(dict: self.dict)
            }
            .navigationBarTitle("Pie Chart", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.viewModel.drawData(dict: self.dict)
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            )
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dict: test)
    }
}
