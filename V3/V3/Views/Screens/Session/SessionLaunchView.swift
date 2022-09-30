//
//  SessionLaunchView.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

/// Landing page for starting a new climb session
struct SessionLaunchView: View {
    
    @StateObject private var sessionViewModel = SessionViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            V3Text("Begin your session")
                .font(.largeTitle)
            Spacer()
            V3Button(title: "Start") {
                sessionViewModel.sessionActive = true
            }
            Spacer()
        }
        .sheet(isPresented: $sessionViewModel.sessionActive) {
            SessionView(sessionViewModel: sessionViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SessionLaunchView()
    }
}
