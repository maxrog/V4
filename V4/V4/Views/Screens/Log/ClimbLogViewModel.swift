//
//  ClimbLogViewModel.swift
//  V4
//
//  Created by Max Rogers on 10/2/22.
//

import Foundation

/// View model to manage a climb log
class ClimbLogViewModel: ObservableObject {
    
    /// Confirmation alert for removing session
    @Published var removeSessionAlertActive: Bool = false
    /// The session indices to delete
    var sessionOffsetsToRemove: IndexSet?
    
}
