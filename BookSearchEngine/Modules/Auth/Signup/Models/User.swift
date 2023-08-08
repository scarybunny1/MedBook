//
//  User.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 09/08/23.
//

import Foundation
import CoreData

extension User {
    public class func getUser(email: String) -> User?{
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email=%@", email)
        fetchRequest.fetchLimit = 1
        do {
            let users: [User] = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch {
            print("Unable to fetch user with email \(email): error: \(error)")
        }
        return nil
    }
    
    public class func addUser(email: String, password: String, country: String){
        let context = CoreDataManager.shared.managedObjectContext
        let newUser = User(context: context)
        newUser.email = email
        newUser.password = password
        newUser.country = country
        
        CoreDataManager.shared.saveContext()
    }
}
