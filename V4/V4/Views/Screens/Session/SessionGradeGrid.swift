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
        fullSelection ? ClimbGuide.gradeScale(for: sessionViewModel.climbStyle) : sessionViewModel.session.sentRoutes.uniqued().reversed()
    }
    
    /// Background color of the grid button view
    func backgroundColor(for grade: String) -> Color {
        if !fullSelection { return Color(hex: 0xFFDF01) }
        return ClimbGuide.color(for: grade, style: sessionViewModel.climbStyle)
    }
    
    /// Number of sends for associated grade
    func sendCount(for grade: String) -> String? {
        let allSends = sessionViewModel.session.sentRoutes.filter({$0 == grade})
        if allSends.count > 1 {
            return "\(allSends.count)"
        } else {
            return nil
        }
    }
    
    /// Size Multiplier
    var sizeMultiplier: CGFloat {
        return fullSelection ? 2.75 : 3.5
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
                            if fullSelection {
                                sessionViewModel.session.sentRoutes.append(grade)
                            } else {
                                // TODO: IF sent route, pop up asking if they want to remove
                                guard let index = sessionViewModel.session.sentRoutes.firstIndex(where: {$0 == grade}) else { return }
                                sessionViewModel.session.sentRoutes.remove(at: index)
                            }
                        }) {
                            ZStack {
                                V4Text(grade, textColor: Color.white)
                                    .font(.system(size: fullSelection ? 48 : 32, weight: .bold))
                                    .frame(width: (geo.size.width / sizeMultiplier) - gridSpacing * 2,
                                           height: (geo.size.width / sizeMultiplier) - gridSpacing * 2)
                                if !fullSelection {
                                    V4Text(sendCount(for: grade))
                                        .font(.system(.footnote, weight: .semibold))
                                        .offset(y: 28)
                                }
                            }
                        }
                        .background(backgroundColor(for: grade))
                        .cornerRadius(fullSelection ? ((geo.size.width / 2) / 8) : (geo.size.width / 2))
                        .shadow(radius: fullSelection ? 0 : 3, x: fullSelection ? 0 : 0.5, y: fullSelection ? 0 : 0.5)
                    }
                }
                .padding([.horizontal], 8)
            }
            .frame(height: geo.size.width / 2.5)
        }
    }
}

