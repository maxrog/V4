//
//  SessionView.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

/// Main View for climb session recording
struct SessionView: View {
    
    @StateObject var sessionViewModel: SessionViewModel
    
    var body: some View {
        VStack() {
            SessionDurationView()
            V4Button(title: "Complete Session") {
                sessionViewModel.sessionActive = false
            }
            SessionGradeGrid(sessionViewModel: sessionViewModel)
            Spacer()
            TimerView(timerViewModel: TimerViewModel())
        }
        .interactiveDismissDisabled()
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(sessionViewModel: SessionViewModel())
    }
}

// MARK: Session Duration

/// Duration view displaying current time and duration since start
struct SessionDurationView: View {
    var body: some View {
        VStack {
            Text(Date(), style: .time)
                .foregroundColor(Preferences.colors.textColor)
                .font(.title)
            Text(Date(), style: .timer)
                .foregroundColor(Preferences.colors.textColor)
                .font(.footnote)
        }
        .padding()
    }
}

// MARK: Session Grid

// TODO toggle to switch from boulder to sport.
// TODO option to cap grades to certain range

/// Grade grid to select completed climbs
struct SessionGradeGrid: View {
    
    @StateObject var sessionViewModel: SessionViewModel
    
    private let gridRows = [
        GridItem(.flexible(minimum: 50), spacing: 8),
    ]
    private let gridSpacing: CGFloat = 8
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridRows, spacing: 12) {
                    ForEach(ClimbGuide.scale.bouldering, id: \.self) { grade in
                        Button(action: {
                            sessionViewModel.session.routesSent.append(grade)
                        }) {
                            V4Text(grade, textColor: Color.white)
                                .font(.system(size: 48, weight: .bold))
                                .frame(width: (geo.size.width / 2) - gridSpacing * 2,
                                       height: (geo.size.width / 2) - gridSpacing * 2)
                        }
                        .background(ClimbGuide.color(for: grade, style: .bouldering))
                        .cornerRadius((geo.size.width / 2) / 4)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: Timer

// TODO have timer view animate up or something to make it stand out

/// Timer for rest periods
struct TimerView: View {
    
    @StateObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack {
            Spacer()
            V4Text(timerViewModel.timerString)
                .font(.system(size: 74, weight: .bold, design: .monospaced))
                .onReceive(timerViewModel.timer) { _ in
                    if timerViewModel.isTimerRunning {
                        timerViewModel.tick()
                    } else {
                        timerViewModel.stopTimer()
                    }
                }
                .onTapGesture {
                    if timerViewModel.isTimerRunning {
                        timerViewModel.pauseTimer()
                    } else {
                        timerViewModel.startTimer()
                    }
                }
                .onAppear() {
                    // no need for UI updates at startup
                    timerViewModel.stopTimer()
                }
            Spacer()
            HStack {
                if !timerViewModel.isTimerRunning {
                    // TODO add button look to this so they know to tap
                    VStack(spacing: 0) {
                        V4Text(timerViewModel.restTimeUserString)
                            .font(.largeTitle)
                        V4Text("Rest")
                            .font(.footnote)
                    }
                    .onTapGesture {
                        if timerViewModel.isTimerRunning {
                            timerViewModel.pauseTimer()
                        } else {
                            timerViewModel.startTimer(fromStep: true)
                        }
                    }
                    Stepper("", value: $timerViewModel.restTime, in: 1...5)
                        .labelsHidden()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
        }
    }
    
}
