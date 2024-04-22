//
//  DatabaseManager.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 17/04/24.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        let safeEmail = email.replacingOccurrences(of: ".", with: "_")
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    //Inserting user to database
    public func insertUser(with user: UserData) {
        database.child(user.safeEmail).setValue([
            "firstName": user.firstName,
            "lastName": user.lastName
        ])
    }
    
}

struct UserData {
    let firstName: String
    let lastName: String
    let emailAddress: String
    var safeEmail: String {
        let safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
    //  let profilePictureUrl: URL
}
