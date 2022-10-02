//
//  Session.swift
//  V4
//
//  Created by Max Rogers on 9/30/22.
//

import Foundation

/// A climb session
struct Session: Codable, Identifiable {
    /// The id of the session
    var id: UUID
    /// The date the session was completed
    var date: Date = Date()
    /// The session environment type
    var environment: ClimbEnvironmentType
    /// Total duration time of the session
    var totalDuration: CGFloat = 0
    /// The routes sent within this session
    var sentRoutes: [String] = []
    
}
