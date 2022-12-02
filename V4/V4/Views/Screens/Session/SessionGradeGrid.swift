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
    
    /// Full grade list or sent/completed climbs
    let gridType: ClimbListType
    
    /// Selection list or sent routes
    var gradesToDisplay: [String] {
        gridType == .menu ? ClimbGuide.gradeScale(for: sessionViewModel.climbStyle) : sessionViewModel.currentSession.sentRoutes.uniqued().reversed()
    }
    
    /// Background color of the grid button view
    func backgroundColor(for grade: String) -> Color {
        return ClimbGuide.color(for: grade, listType: gridType)
    }
    
    /// Number of sends for associated grade
    func sendCount(for grade: String) -> String? {
        let allSends = sessionViewModel.currentSession.sentRoutes.filter({$0 == grade})
        if allSends.count > 1 {
            return "x\(allSends.count)"
        } else {
            return nil
        }
    }
    
    /// Size Multiplier
    var sizeMultiplier: CGFloat {
        return gridType == .menu ? 2.85 : 3.5
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
                                guard let index = sessionViewModel.currentSession.sentRoutes.firstIndex(where: {$0 == grade}) else { return }
                                sessionViewModel.currentSession.sentRoutes.remove(at: index)
                            }
                        }) {
                            ZStack {
                                V4Text(grade, textColor: gridType == .menu ? Color.white : Color.darkText)
                                    .font(.system(size: gridType == .menu ? 48 : 32, weight: .bold))
                                    .frame(width: (geo.size.width / sizeMultiplier) - gridSpacing * 2,
                                           height: (geo.size.width / sizeMultiplier) - gridSpacing * 2)
                                switch gridType {
                                case .menu:
                                    Image(systemName: "checkmark.seal")
                                        .offset(y: 40)
                                        .foregroundColor(Color.darkText)
                                case .sent:
                                    V4Text(sendCount(for: grade), textColor: Color.darkText)
                                        .font(.system(.footnote, weight: .semibold))
                                        .offset(y: 28)
                                }
                            }
                        }
                        .background(backgroundColor(for: grade))
                        .cornerRadius(gridType == .menu ? ((geo.size.width / 2) / 8) : (geo.size.width / 2))
                        .shadow(radius: gridType == .menu ? 0 : 3,
                                x: gridType == .menu ? 0 : 0.5,
                                y: gridType == .menu ? 0 : 0.5)
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
