//
//  V4GradeCircleView.swift
//  V4
//
//  Created by Max Rogers on 1/4/23.
//

import SwiftUI

/// A generic grade view which displays a circle with send count
struct V4GradeCircleView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    /// Sizing information
    let size: CGSize
    
    /// The climbing session
    let session: Session
    
    /// Full grade list or sent/completed climbs
    let gridType: ClimbListType
    
    /// The grade to display
    let grade: String
    
    /// The calculated climb style
    private var climbStyle: ClimbStyleType {
        let scales = GradeScale()
        return scales.boulder.contains(where:{$0 == grade}) ? .boulder : .sport
    }
    
    /// Background color of the grid button view for associated route grade
    private var backgroundColor: Color {
        return ClimbGuide.color(for: grade,
                                listType: gridType,
                                redpointLevel: settingsViewModel.redpointLevel(for: climbStyle))
    }
    
    /// Number of sends for associated grade
    private var sendCount: String? {
        let allSends = session.sentRoutes.filter({$0 == grade})
        if allSends.count > 1 {
            return "x\(allSends.count)"
        } else {
            return nil
        }
    }
    
    
    private let gridSpacing: CGFloat = 8
    /// Size Multiplier
    private var sizeMultiplier: CGFloat {
        return gridType == .menu ? 2.85 : 3.5
    }
    
    var body: some View {
        ZStack {
            V4Text(grade, textColor: Color.darkText.opacity(gridType == .menu ? 0.64 : 1))
                .font(.system(size: gridType == .menu ? 48 : 32, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(width: (size.width / sizeMultiplier) - gridSpacing * 2,
                       height: (size.width / sizeMultiplier) - gridSpacing * 2)
            
            switch gridType {
            case .menu:
                Image(systemName: "checkmark.seal")
                    .offset(y: 40)
                    .foregroundColor(Color.darkText)
            case .sent:
                V4Text(sendCount, textColor: Color.darkText)
                    .font(.system(.footnote, weight: .semibold))
                    .offset(y: 28)
            }
        }
        .background(backgroundColor)
        .cornerRadius(gridType == .menu ? ((size.width / 2) / 8) : (size.width / 2))
        .shadow(radius: gridType == .menu ? 0 : 3,
                x: gridType == .menu ? 0 : 0.5,
                y: gridType == .menu ? 0 : 0.5)
    }
    
}

