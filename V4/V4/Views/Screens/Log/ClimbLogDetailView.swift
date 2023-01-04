//
//  ClimbLogDetailView.swift
//  V4
//
//  Created by Max Rogers on 1/4/23.
//

import SwiftUI

/// Climb detail view to show more information about the session
struct ClimbLogDetailView: View {
    
    /// The session to display information about
    let session: Session
    
    /// The sent routes to display
    var sentRoutes: [String] {
        session.sentRoutes.uniqued().reversed()
    }
    
    /// Number of sends for associated grade
    /// - Parameter grade: The route's grade
    func sendCount(for grade: String) -> String? {
        let allSends = session.sentRoutes.filter({$0 == grade})
        if allSends.count > 1 {
            return "x\(allSends.count)"
        } else {
            return nil
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            Grid(alignment: .center) {
                ForEach(sentRoutes, id: \.self) { grade in
                    V4GradeCircleView(size: geo.size, session: session, gridType: .sent, grade: grade)
                }
            }
        }
    }
}


