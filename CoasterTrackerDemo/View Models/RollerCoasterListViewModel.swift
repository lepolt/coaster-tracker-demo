//
//  RollerCoasterListViewModel.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import Foundation
import CoreData

class RollerCoasterListViewModel: NSObject, ObservableObject {
    /// Our list of [RollerCoaster] to display and update
    @Published var list: [RollerCoaster] = []

    private let persistenceController: PersistenceController

    /// NSFetchedResultsController that returns type [RollerCoaster]. Sorts by name and returns all results.
    private lazy var fetchedResultsController: NSFetchedResultsController<RollerCoaster> = {
        let context = persistenceController.container.viewContext
        let fetchRequest = RollerCoaster.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(RollerCoaster.name), ascending: true)]

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        controller.delegate = self
        return controller
    }()

    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
        super.init()

        fetchData()
    }

    /// Adds a new RollerCoaster object to Core Data
    /// - Parameter name: String name of the new RollerCoaster
    func addNewRollerCoaster(name: String) {
        let context = persistenceController.container.viewContext

        // Create our new object and set required properties
        let newRollerCoaster = RollerCoaster(context: context)
        newRollerCoaster.id = UUID()
        newRollerCoaster.name = name

        do {
            try context.save()
        } catch let error as NSError {
            assertionFailure("Error creating new RollerCoaster: \(error), \(error.userInfo)")
        }
    }

    /// Does the initial fetch to get our list of roller coasters from Core Data
    private func fetchData() {
        do {
            try fetchedResultsController.performFetch()
            refreshData()
        } catch let error as NSError {
            assertionFailure("Error fetching RollerCoaster list: \(error), \(error.userInfo)")
        }
    }

    /// Refreshes our list of roller coasters
    private func refreshData() {
        list = fetchedResultsController.fetchedObjects ?? []
    }
}

// MARK: - Extension - NSFetchedResultsControllerDelegate

extension RollerCoasterListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        refreshData()
    }
}
