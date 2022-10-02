//
//  CoreDataExtensions.swift
//  V4
//
//  Created by Max Rogers on 10/2/22.
//

import Foundation
import CoreData

extension Session {

    /// Fetch request for session entities
    public static func fetchRequest() -> NSFetchRequest<SessionEntity> {
        return NSFetchRequest<SessionEntity>(entityName: "SessionEntity")
    }
    
}
