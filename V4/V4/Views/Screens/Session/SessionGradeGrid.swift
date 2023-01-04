//
//  SessionGradeGrid.swift
//  V4
//
//  Created by Max Rogers on 10/1/22.
//

import SwiftUI

/// Grade grid to select completed climbs and display completed grades
struct SessionGradeGrid: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @ObservedObject var sessionViewModel: SessionViewModel
    
    /// Full grade list or sent/completed climbs
    let gridType: ClimbListType
    
    /// Selection list or sent routes
    private var gradesToDisplay: [String] {
        switch gridType {
        case .sent:
            return sessionViewModel.currentSession.sentRoutes.uniqued().reversed()
        case .menu:
            return ClimbGuide.gradeScale(for: sessionViewModel.climbStyle,
                                         redpointLevel: settingsViewModel.redpointLevel(for: sessionViewModel.climbStyle))
        }
    }
    
    private let gridRows = [
        GridItem(.flexible(minimum: 50), spacing: 8),
    ]
    private let gridSpacing: CGFloat = 8
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, spacing: 12) {
                    ForEach(gradesToDisplay, id: \.self) { grade in
                        Button(action: {
                            switch gridType {
                            case .menu:
                                sessionViewModel.currentSession.sentRoutes.append(grade)
                            case .sent:
                                // TODO instead of tap, add a long press with haptic / alert to remove
                                guard let index = sessionViewModel.currentSession.sentRoutes.firstIndex(where: {$0 == grade}) else { return }
                                sessionViewModel.currentSession.sentRoutes.remove(at: index)
                            }
                        }) {
                            V4GradeCircleView(size: geo.size,
                                              session: sessionViewModel.currentSession,
                                              gridType: gridType,
                                              grade: grade)
                        }
                    }
                }
                .padding([.horizontal], 8)
            }
            .if (gridType != .menu && sessionViewModel.currentSession.sentRoutes.count > 0) { view in
                view
                    .background(
                        .regularMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                    )
            }
            .frame(height: geo.size.width / 2.5)
        }
    }
}
