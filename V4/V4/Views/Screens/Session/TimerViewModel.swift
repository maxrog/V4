//
//  TimerViewModel.swift
//  V4
//
//  Created by Max Rogers on 9/30/22.
//

import Foundation


/// View model to manage a rest timer
class TimerViewModel: ObservableObject {
    
    @Published var isTimerRunning = false
    @Published var stopDate = Date()
    @Published var timerString = ""
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    /// The last diff to be used when pausing/starting
    private var lastDiff: TimeInterval?
    private var formatter: DateComponentsFormatter
    private let calendar = Calendar.current
    
    init(isTimerRunning: Bool = false, stopDate: Date = Date(), timerString: String = "") {
        self.isTimerRunning = isTimerRunning
        self.stopDate = stopDate
        self.timerString = timerString
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .dropLeading
        formatter.unitsStyle = .positional
    }
    
    // MARK: Functionality
    
    /// Tick the timer
    func tick() {
        let currentTime = Date()
        let diff = stopDate - currentTime
        if diff > 0 {
            timerString = formatter.string(from: currentTime, to: stopDate) ?? ""
            lastDiff = diff
        } else {
            stopTimer()
            lastDiff = nil
        }
    }
    
    /// Start the timer
    func startTimer(fromSlide: Bool = false) {
        if fromSlide {
            lastDiff = nil
        } else if let savedPosition = lastDiff {
            stopDate = Date().addingTimeInterval(savedPosition)
        }
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    /// Stop the timer
    func stopTimer() {
        isTimerRunning = false
        timerString = ""
        timer.upstream.connect().cancel()
    }
    
    // MARK: User Facing
    
    @Published var restTime: Double = 0
    /// Displayed above slider while selecting rest period amount
    var restTimeUserString: String {
        get {
            return restTime > 0 ? "\(Int(6 - restTime))m " : ""
        }
    }
    
}
