//
//  Preferences.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import Foundation

import SwiftUI

// TODO use AppStorage UserDefault wrapper where necessary

struct Preferences {
    static let colors = V4Colors()
}

struct V4Colors {
    
    // MARK: Base
    
    /// The primary text color to be used on views
    private(set) var textColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.primary
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
    /// The secondary text color to be used on Views
    private(set) var secondaryTextColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.secondaryLabel
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
    /// The primary background color to be used on views
    private(set) var backgroundColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.systemBackground
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
    /// The primary accent color to be used on views
    private(set) var accentColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.accentColor
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
    // MARK: Features
    
    /// The range of colors for the climb grade scale
    private(set) var gradeScaleColors: [UIColor] {
        get {
            // fetch from app storage? or user defaults
            return [.green, .yellow, .red]
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
}
