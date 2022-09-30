//
//  ClimbGuide.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

/// Store climb information
struct ClimbGuide {
    static var indoor = Indoor()
    static var outdoor = Outdoor()
    
    /// returns the grade scale list for the associated environment
    /// - Parameter environment: The climb environment type
    static func gradeScale(for environment: ClimbEnvironmentType) -> [String] {
        switch environment {
        case .indoor:
            return indoor.grades
        case .outdoor:
            return outdoor.grades
        }
    }
    
    /// returns a color for the associated grade
    /// - Parameter grade: The grade used to find associated color
    /// - Parameter environment: The climb environment type
    static func color(for grade: String, environment: ClimbEnvironmentType) -> Color {
        let grades = gradeScale(for: environment)
        guard let index = grades.firstIndex(where: {$0 == grade}) else { return .clear }
        let percentage = CGFloat(index) / CGFloat(grades.count)
        return Color(uiColor: Preferences.colors.gradeScaleColors.intermediate(percentage: percentage * 100))
    }
    
}

/// Climbing indoors information
struct Indoor {
    var grades = [
        "VB",
        "V0",
        "V1",
        "V2",
        "V3",
        "V4",
        "V5",
        "V6",
        "V7",
        "V8",
        "V9",
        "V10",
        "V11",
        "V12",
        "V13",
        "V14",
        "V15"
    ]
    
}

/// Climbing outdoors information
struct Outdoor {
    var grades = [
        "5.5",
        "5.6"
    ]
}

enum ClimbEnvironmentType: Codable {
    case indoor, outdoor
}

