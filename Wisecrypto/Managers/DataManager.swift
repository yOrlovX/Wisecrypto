//
//  DataManager.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 13.02.2023.
//

import Foundation
import CoreData

final class DataManager {
  
  static let instance = DataManager()
  let container: NSPersistentContainer
  let context: NSManagedObjectContext
  
  init() {
    container = NSPersistentContainer(name: "CoreDataModel")
    let description = NSPersistentStoreDescription()
    description.shouldMigrateStoreAutomatically = true
    description.shouldInferMappingModelAutomatically = true
    container.persistentStoreDescriptions.append(description)
    container.loadPersistentStores { description, error in
      if let error = error {
        print("\(error)")
      }
    }
    context = container.viewContext
  }
}
