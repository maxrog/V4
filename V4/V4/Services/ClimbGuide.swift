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
    /// - Parameter redpointLevel: The user's redpoint level if set. Optimizes list to show
    static func gradeScale(for style: ClimbStyleType, redpointLevel: String? = nil) -> [String] {
        switch style {
        case .boulder:
            let boulderScale = scale.boulder
            guard let redpointLevel = redpointLevel,
                  !redpointLevel.isEmpty,
                  let redpointIndex: Int = boulderScale.firstIndex(of: redpointLevel) else { return boulderScale }
            
            return Array(boulderScale.prefix(redpointIndex + 1))
        case .sport:
            let sportScale = scale.sport
            guard let redpointLevel = redpointLevel,
                  !redpointLevel.isEmpty,
                  let redpointIndex: Int = sportScale.firstIndex(of: redpointLevel) else { return sportScale }
            
            return Array(sportScale.prefix(redpointIndex + 1))
        }
    }
    
    /// returns a color for the associated grade
    /// - Parameter grade: The grade used to find associated color
    /// - Parameter listType: Whether displaying full grade scale or a completed/sent list
    /// - Parameter redpointLevel: The user's redpoint level if set. Optimizes list to show
    static func color(for grade: String, listType: ClimbListType, redpointLevel: String? = nil) -> Color {
        var grades: [String] = []
        var index: Int?
        switch listType {
        case .menu:
            return Color.systemGray
        case .sent:
            let boulderGrades = gradeScale(for: .boulder, redpointLevel: redpointLevel)
            let sportGrades = gradeScale(for: .sport, redpointLevel: redpointLevel)
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
        "5.7",
        "5.8",
        "5.9",
        "5.10a",
        "5.10b",
        "5.10c",
        "5.10d",
        "5.11a",
        "5.11b",
        "5.11c",
        "5.11d",
        "5.12a",
        "5.12b",
        "5.12c",
        "5.12d",
        "5.13a",
        "5.13b",
        "5.13c",
        "5.13d",
        "5.14a",
        "5.14b",
        "5.14c",
        "5.14d",
    ]
    
}

enum ClimbStyleType: String, Codable {
    case boulder = "Boulder"
    case sport = "Sport"
}

enum ClimbEnvironmentType: Int, Codable {
    case indoor, outdoor
}

/// Full grade scale or sent/completed list
enum ClimbListType {
    case menu, sent
}

