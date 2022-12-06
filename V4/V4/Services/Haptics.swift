//
//  Haptics.swift
//  V4
//
//  Created by Max Rogers on 12/4/22.
//

import UIKit
import AudioToolbox

/// Manage haptic feedback
class Haptics {
    
    static let shared = Haptics()
    
    private init() { }

    /// Trigger haptic feedback ideally triggered from user interaction
    /// - Parameter feedbackStyle: the style of feedback to be played
    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    /// Trigger haptic feedback due to success/error
    /// - Parameter feedbackType: the type of feedback to be played
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
    
    /// Trigger haptic / sound when timer ends
    func notifyTimerEnd() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
}
