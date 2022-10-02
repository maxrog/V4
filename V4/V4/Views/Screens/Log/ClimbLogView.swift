//
//  ClimbLogView.swift
//  V4
//
//  Created by Max Rogers on 10/2/22.
//

import SwiftUI
import CoreData

/// Climb log view to show past sessions with stats etc
struct ClimbLogView: View {
    
    @StateObject var logViewModel = ClimbLogViewModel()
    
    /// Core Data Fetch Request
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.identifier, order: .reverse)
    ]) var sessionValues: FetchedResults<SessionEntity>
    
    /// Translated sessions
    var sessions: [Session] {
        var mappedSessions: [Session] = []
        for session in sessionValues {
            guard let identifier = session.identifier,
                  let id = UUID(uuidString: identifier),
                  let date = session.date,
                  let environment = ClimbEnvironmentType(rawValue: Int(session.environment)) else { continue }
            
            mappedSessions.append(Session(id: id,
                                          date: date,
                                          environment: environment,
                                          totalDuration: CGFloat(session.totalDuration),
                                          sentRoutes: session.sentRoutes ?? []))
        }
        return mappedSessions.sorted { $0.date > $1.date }
    }
    
    /// Delete a session
    func removeSessions(at offsets: IndexSet) {
        logViewModel.sessionOffsetsToRemove = offsets
        logViewModel.removeSessionAlertActive = true
    }
    
    var body: some View {
        List {
            ForEach(sessions) { session in
                VStack {
                    Text(session.date, style: .date)
                        .font(.largeTitle)
                        .foregroundColor(Preferences.colors.textColor)
                    V4Text(session.sentRoutes.joined(separator: ", "))
                }
            }
            .onDelete(perform:
                removeSessions(at:)
            )
        }
        .alert("Delete this session? Operation cannot be undone.", isPresented: $logViewModel.removeSessionAlertActive) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                for index in logViewModel.sessionOffsetsToRemove ?? [] {
                    let session = sessions[index]
                    SessionManager.shared.removeSession(session)
                }
                logViewModel.removeSessionAlertActive = false
            }
        }
    }
}

struct ClimbLogView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbLogView()
    }
}
