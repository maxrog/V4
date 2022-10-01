//
//  SessionGradeGrid.swift
//  V4
//
//  Created by Max Rogers on 10/1/22.
//

import SwiftUI

/// Grade grid to select completed climbs and display completed grades
struct SessionGradeGrid: View {
    
    @StateObject var sessionViewModel: SessionViewModel
    
    /// Selection list or sent routes
    var fullSelection = false
    
    /// Selection list or sent routes
    var gradesToDisplay: [String] {
        fullSelection ? ClimbGuide.gradeScale(for: sessionViewModel.climbStyle) : sessionViewModel.session.sentRoutes
    }
    
    /// Background color of the grid button view
    func backgroundColor(for grade: String) -> Color {
        if !fullSelection { return Preferences.colors.accentColor }
        return ClimbGuide.color(for: grade, style: sessionViewModel.climbStyle)
    }
    
    private let gridRows = [
        GridItem(.flexible(minimum: 50), spacing: 8),
    ]
    private let gridSpacing: CGFloat = 8
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridRows, spacing: 12) {
                    // TODO I think id gets messed up if we have 2 of the same strings in the list (seeing blank spot)
                    ForEach(gradesToDisplay, id: \.self) { grade in
                        Button(action: {
                            if fullSelection {
                                sessionViewModel.session.sentRoutes.append(grade)
                            } else {
                                // TODO: IF sent route, pop up asking if they want to remove
                                guard let index = sessionViewModel.session.sentRoutes.firstIndex(where: {$0 == grade}) else { return }
                                sessionViewModel.session.sentRoutes.remove(at: index)
                            }
                        }) {
                            // TODO add a # within box after send more than 1 to say sent more than 1
                            V4Text(grade, textColor: Color.white)
                                .font(.system(size: 48, weight: .bold))
                                .frame(width: (geo.size.width / 2.75) - gridSpacing * 2,
                                       height: (geo.size.width / 2.75) - gridSpacing * 2)
                        }
                        .background(backgroundColor(for: grade))
                        .cornerRadius((geo.size.width / 2) / 8)
                    }
                }
            }
            .frame(height: geo.size.width / 2.5)
            .scrollIndicators(.hidden)
        }
    }
}

