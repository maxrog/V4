//
//  SessionLaunchView.swift
//  V4
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
            V4Text("Begin Session")
                .font(.largeTitle)
            Spacer()
            HStack {
                V4Button(title: "Sport") {
                    sessionViewModel.climbStyle = .sport
                    sessionViewModel.sessionActive = true
                }
                V4Button(title: "Boulder") {
                    sessionViewModel.climbStyle = .boulder
                    sessionViewModel.sessionActive = true
                }
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
