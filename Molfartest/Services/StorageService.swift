//
//  StorageService.swift
//  Molfartest
//
//  Created by Konstantin Igorevich on 27.02.2020.
//  Copyright © 2020 Konstantin Igorevich. All rights reserved.
//

import Foundation
import CoreData

class StorageService {
    
    private let personRandomName = ["Dan", "Jhon", "Saymon", "Konstantin", "Oleg", "Katy", "Irina"]
    
    static let shared = StorageService()
    
    private let persistantContainerName = "Molfartest"
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistantContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func fetch<T: NSManagedObject>(_ objectType: T.Type, byAge: String) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "age = %@", byAge)
        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }
    
    func generateRandomObject() {
        var counter = 0
        for _ in 1...100000 {
            counter += 1
            print(counter)
            let person = Person(context: context)
            person.age = Int64(Int.random(in: 12...99))
            person.name = personRandomName.randomElement()
        }
        save()
    }
    
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    func getPersons(by age: String) -> [Person] {
        return fetch(Person.self, byAge: age)
    }
}
