//
//  SessionViewModel.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

/// View model to manage a climb session
class SessionViewModel: ObservableObject {
    
    /// Whether a session is currently active
    @Published var sessionActive: Bool = false
    
}
