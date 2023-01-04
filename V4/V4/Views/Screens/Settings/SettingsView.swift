//
//  SettingsView.swift
//  V4
//
//  Created by Max Rogers on 10/5/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        Form {
            Section {
               
            } header: {
                V4Text("App Settings")
            }
            .headerProminence(.increased)
            Section {
                HStack {
                    Image(systemName: "flame.circle.fill")
                    Picker("Boulder", selection: $settingsViewModel.userBoulderRedpointLevel) {
                        ForEach(ClimbGuide.gradeScale(for: .boulder), id: \.self) { grade in
                            V4Text(grade)
                        }
                    }.pickerStyle(.menu)
                }
                HStack {
                    Image(systemName: "flame.circle.fill")
                    Picker("Sport", selection: $settingsViewModel.userSportRedpointLevel) {
                        ForEach(ClimbGuide.gradeScale(for: .sport), id: \.self) { grade in
                            V4Text(grade)
                        }
                    }.pickerStyle(.menu)
                }
            } header: {
                V4Text("Redpoint Level")
            } footer: {
                V4Text("Setting your redpoint level will help optimize your session experience.")
            }
            .headerProminence(.increased)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
