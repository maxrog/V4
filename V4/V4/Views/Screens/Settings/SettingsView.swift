//
//  SettingsView.swift
//  V4
//
//  Created by Max Rogers on 10/5/22.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        Form {
            Section {
               
            } header: {
                V4Text("App Settings")
            }
            Section {
                V4Text("Boulder Redpoint: \(settingsViewModel.userBoulderRedpointLevel)")
                    .font(.headline)
                Picker("Boulder Redpoint", selection: $settingsViewModel.userBoulderRedpointLevel) {
                    ForEach(ClimbGuide.gradeScale(for: .boulder), id: \.self) { grade in
                        V4Text(grade)
                    }
                }.pickerStyle(.wheel)
                
                V4Text("Sport Redpoint: \(settingsViewModel.userSportRedpointLevel)")
                    .font(.headline)
                Picker("Sport Redpoint", selection: $settingsViewModel.userSportRedpointLevel) {
                    ForEach(ClimbGuide.gradeScale(for: .sport), id: \.self) { grade in
                        V4Text(grade)
                    }
                }.pickerStyle(.wheel)
            } header: {
                V4Text("Climb Settings")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
