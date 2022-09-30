//
//  SessionView.swift
//  V3
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
                SessionGradeGrid()
                Spacer()
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
            Spacer()
        }
        .padding()
    }
}

// MARK: Session Grid

// TODO toggle to switch from boulder to sport.
// TODO grid should scale from green to red bg colors
// TODO option to cap grades to certain range

/// Grade grid to select completed climbs
struct SessionGradeGrid: View {
    
    private let gridColumns = [
        GridItem(.flexible(minimum: 50), spacing: 8),
        GridItem(.flexible(minimum: 50), spacing: 8)
    ]
    private let gridSpacing: CGFloat = 8
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 8) {
                    ForEach(ClimbingGuide.gym.grades, id: \.self) { grade in
                        Button(action: {
                            print("Sent \(grade)!")
                        }) {
                            V3Text(grade, textColor: Color.white)
                                .font(.system(size: 48, weight: .bold))
                                .frame(width: (geo.size.width / 2) - gridSpacing * 2,
                                       height: (geo.size.width / 2) - gridSpacing * 2)
                        }
                        .background(Color.accentColor)
                        .cornerRadius((geo.size.width / 2) / 4)
                    }
                }
            }
            .padding(8)
            .scrollIndicators(.hidden)
        }
    }
}
