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
        GeometryReader { geo in
            VStack(spacing: 0) {
                SessionDurationView()
                V4Button(title: "End Session", textColor: .red) {
                    sessionViewModel.sessionActive = false
                }
                .font(.system(size: 24, weight: .semibold))
                SessionGradeGrid(sessionViewModel: sessionViewModel)
                Spacer()
                    .frame(idealHeight: .infinity)
                SessionGradeGrid(sessionViewModel: sessionViewModel, fullSelection: true)
                    .frame(height: geo.size.width / 2.5)
                TimerView(timerViewModel: TimerViewModel())
            }
            .interactiveDismissDisabled()
        }
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
                .font(.largeTitle)
            Text(Date(), style: .timer)
                .foregroundColor(Preferences.colors.textColor)
                .font(.footnote)
        }
        .padding()
    }
}


// TODO toggle to switch from boulder to sport.
// TODO option to cap grades to certain range


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
                    VStack(spacing: 0) {
                        V4Text(timerViewModel.restTimeUserString, textColor: Preferences.colors.accentColor)
                            .font(.system(.largeTitle, weight: .semibold))
                        V4Text("Rest", textColor: Preferences.colors.accentColor)
                            .font(.footnote)
                    }
                    .frame(width: 70)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.systemGray6)
                    }
                    .onTapGesture {
                        if timerViewModel.isTimerRunning {
                            timerViewModel.pauseTimer()
                        } else {
                            timerViewModel.startTimer(fromStep: true)
                        }
                    }
                    VStack(spacing: 4) {
                        Image(systemName: "chevron.up")
                            .padding(8)
                            .onTapGesture {
                                guard timerViewModel.restTime <= 4 else { return }
                                timerViewModel.restTime += 1
                            }
                        Image(systemName: "chevron.down")
                            .padding(8)
                            .onTapGesture {
                                guard timerViewModel.restTime >= 2 else { return }
                                timerViewModel.restTime -= 1
                            }
                    }.background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.regularMaterial)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
        }
    }
    
}
