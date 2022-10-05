//
//  SettingsViewModel.swift
//  V4
//
//  Created by Max Rogers on 10/5/22.
//

import Foundation

/// View model to manage user settings
class SettingsViewModel: ObservableObject {
    
    /// User boulder redpoint level
    @Published var userBoulderRedpointLevel: String = ""
    
    /// User sport redpoint level
    @Published var userSportRedpointLevel: String = ""
    
    
}
