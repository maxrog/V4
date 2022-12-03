//
//  SettingsViewModel.swift
//  V4
//
//  Created by Max Rogers on 10/5/22.
//

import SwiftUI

/// View model to manage user settings
class SettingsViewModel: ObservableObject {
    
    /// User boulder redpoint level
    @AppStorage(StorageKeys.boulderRedpoint.rawValue) var userBoulderRedpointLevel: String = ClimbGuide.gradeScale(for: .boulder).last ?? ""
    
    /// User sport redpoint level
    @AppStorage(StorageKeys.sportRedpoint.rawValue) var userSportRedpointLevel: String = ClimbGuide.gradeScale(for: .sport).last ?? ""
    
    /// returns the user's redpoint value for the given climbing style
    /// - Parameter style: The climbing style
    func redpointLevel(for style: ClimbStyleType) -> String {
        switch style {
        case .boulder:
            return userBoulderRedpointLevel
        case .sport:
            return userSportRedpointLevel
        }
    }
    
}

fileprivate
enum StorageKeys: String {
    case boulderRedpoint, sportRedpoint
}
