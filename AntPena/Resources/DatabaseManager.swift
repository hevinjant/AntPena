//
//  DatabaseManager.swift
//  AntPena
//
//  Created by Hevin Jant on 8/13/21.
//  Copyright © 2021 Hevin Jant. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    // MARK: - Account management
    /// Checks if an email is already exist
    public func userExists(with email: String, completion: @escaping (Bool) -> Void) {
        database.child(email).observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    /// Inserts new user to database
    public func insertUser(with user: AppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
    
    
    
}

struct AppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePictureUrl: String
}
