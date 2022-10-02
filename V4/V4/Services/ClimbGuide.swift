//
//  ClimbGuide.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

/// Store climb information
struct ClimbGuide {
    
    static private var scale = GradeScale()
    
    /// returns the grade scale list for the associated climbing style
    /// - Parameter style: The climbing style
    static func gradeScale(for style: ClimbStyleType) -> [String] {
        switch style {
        case .boulder:
            return scale.boulder
        case .sport:
            return scale.sport
        }
    }
    
    /// returns a color for the associated grade
    /// - Parameter grade: The grade used to find associated color
    /// - Parameter style: The climbing style
    static func color(for grade: String, style: ClimbStyleType) -> Color {
        let grades = gradeScale(for: style)
        guard let index = grades.firstIndex(where: {$0 == grade}) else { return .clear }
        let percentage = CGFloat(index) / CGFloat(grades.count)
        return Color(uiColor: Preferences.colors.gradeScaleColors.intermediate(percentage: percentage * 100))
    }
    
}

/// Climbing grade scale information
struct GradeScale {
    
    var boulder = [
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
    
    var sport = [
        "5.6",
        "5.11"
    ]
    
}

enum ClimbStyleType: String, Codable {
    case boulder = "Boulder"
    case sport = "Sport"
}

enum ClimbEnvironmentType: Codable {
    case indoor, outdoor
}

