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
    /// - Parameter fullSelection: Whether displaying full selection or sent list
    static func color(for grade: String, fullSelection: Bool) -> Color {
        var grades: [String] = []
        var index: Int?
        if fullSelection {
            return Color.systemGray
        } else {
            let boulderGrades = gradeScale(for: .boulder)
            let sportGrades = gradeScale(for: .sport)
            if let boulderIndex = boulderGrades.firstIndex(where: {$0 == grade}) {
                index = boulderIndex
                grades = boulderGrades
            } else if let sportIndex = sportGrades.firstIndex(where: {$0 == grade}) {
                index = sportIndex
                grades = sportGrades
            }
        }
        guard let index = index else { return Color(hex: 0xFCC201) }
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

enum ClimbEnvironmentType: Int, Codable {
    case indoor, outdoor
}

