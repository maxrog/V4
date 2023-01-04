//
//  Session.swift
//  V4
//
//  Created by Max Rogers on 9/30/22.
//

import Foundation

/// A climb session
struct Session: Codable, Identifiable, Hashable {
    /// The id of the session
    var id: UUID
    /// The date the session was completed
    var date: Date = Date()
    /// The session environment type
    var environment: ClimbEnvironmentType
    /// The session climb style types
    var styles: [ClimbStyleType] {
        // Calculate which styles the user sent during their session
        // Note: We could not use a lazy var here because session is used in immutable context
        var climbStyles: [ClimbStyleType] = []
        let scales = GradeScale()
        for route in sentRoutes {
            if climbStyles.count == 2 { return climbStyles }
            if scales.boulder.contains(where:{$0 == route}) && !climbStyles.contains(where:{$0 == .boulder}) {
                climbStyles.append(.boulder)
                continue
            }
            if scales.sport.contains(where:{$0 == route}) && !climbStyles.contains(where:{$0 == .sport}) {
                climbStyles.append(.sport)
                continue
            }
        }
        return climbStyles
    }
    /// Total duration time of the session
    var totalDuration: CGFloat = 0
    /// The routes sent within this session
    var sentRoutes: [String] = []
    
}
