//
//  SessionManager.swift
//  V4
//
//  Created by Max Rogers on 10/2/22.
//

import CoreData
import UIKit

/*
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-configure-core-data-to-work-with-swiftui
 */

/// Used to store and fetch session activity via Core Data
struct SessionManager {
    
    static let shared = SessionManager()
    
    /// Storage for Core Data
    let container: NSPersistentContainer
    
    /// An initializer to load Core Data, optionally able to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SessionModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Save a specific session
    func saveSession(_ session: Session) {
        let context = container.viewContext
        
        let newSession = SessionEntity(context: context)
        newSession.identifier = session.id.uuidString
        newSession.date = Date()
        newSession.environment = Int16(session.environment.rawValue)
        newSession.sentRoutes = session.sentRoutes
        newSession.totalDuration = Double(session.totalDuration)

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO show some error here
            }
        }
    }
    
    /// Delete a specific session
    func removeSession(_ session: Session) {
        let context = container.viewContext
       
        let predicate = NSPredicate(format: "identifier == %@", session.id.uuidString)
        let fetchRequest: NSFetchRequest<SessionEntity> = Session.fetchRequest()
        fetchRequest.predicate = predicate
        
        let fetchedSession = try? context.fetch(fetchRequest).first

        if let sessionToRemove = fetchedSession {
            context.delete(sessionToRemove)
        }

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO show some error here
            }
        }
    }
    
    
    /// Save any pending updates
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO show some error here
            }
        }
    }
    
}
