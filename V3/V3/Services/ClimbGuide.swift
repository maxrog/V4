//
//  ClimbingGuide.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

/// Store climbing information
struct ClimbingGuide {
    static var indoor = Indoor()
    static var outdoor = Outdoor()
    
    /// returns a color for the associated grade
    /// - Parameter grade: The grade used to find associated color
    func color(for grade: String, gradeScale: ClimbEnvironmentType) -> Color {
        guard let index = grades.firstIndex(where: {$0 == grade}) else { return .clear }
        let percentage = CGFloat(index / grades.count)
        return Color(uiColor: Preferences.colors.gradeColors.intermediate(percentage: percentage))
    }
    
}

/// Climbing gym information
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

/// Climing outdoors information
struct Outdoor {
    var grades = [
        "5.5",
        "5.6"
    ]
}

enum ClimbEnvironmentType {
    case indoor, outdoor
}

