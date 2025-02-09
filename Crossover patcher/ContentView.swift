//
//  ContentView.swift
//  Crossover patcher
//
//  Created by Italo Mandara on 31/03/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    @State private var showDisclaimer = true
    @State public var status: Status = .unpatched
    @State public var skipVersionCheck: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Image("Logo")
                .resizable(resizingMode: .stretch)
                .frame(width: 80.0, height: 80.0)
            Text("Crossover Patcher")
                .font(.title)
                .padding(.vertical, 1.0)
            if(showDisclaimer) {
                Disclaimer()
                Button("Agree and proceed") {
                    showDisclaimer = false
                }.padding(.vertical, 20.0).buttonStyle(.borderedProminent)
            } else {
                Button("Instructions") {
                    openWindow(id: "instructions")
                }
                .padding(.bottom, 15.0)
                .buttonStyle(.borderedProminent)
                RoundedRectangle(cornerRadius: 25)
                    .stroke(getColorBy(status: status), style: StrokeStyle(lineWidth: 6, dash: [11.7]))
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(width: 340, height: 300)
                    .overlay(                Text(getTextBy(status: status))
                        .foregroundColor(getColorBy(status: status))
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(20.0))
                    .onDrop(of: [.fileURL], delegate: FileDropDelegate(status: $status, skipVersionCheck: $skipVersionCheck))
                Toggle("Patch any Crossover version", isOn: $skipVersionCheck)
                    .padding(.top, 13.0)
                    .toggleStyle(.switch)
            }
        }.padding(20)
        .frame(width: 400.0)
        .fixedSize()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
