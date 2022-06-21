//
//  CoastersByThemeParkView.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/20/22.
//

import Foundation
import CoreData

class CoastersByThemeParkViewModel: NSObject, ObservableObject {
    @Published var data: [String: [RollerCoaster]] = [:]

    private let persistenceController: PersistenceController

    /// NSFetchedResultsController that returns type [RollerCoaster]. Organizes by section by ThemePark name. Sorts by
    /// theme park, name and returns all results.
    private lazy var fetchedResultsController: NSFetchedResultsController<RollerCoaster> = {
        let fetchRequest = RollerCoaster.fetchRequest()
        let themeParkSort = NSSortDescriptor(key: #keyPath(RollerCoaster.themePark.name), ascending: true)
        let nameSort = NSSortDescriptor(key: #keyPath(RollerCoaster.name), ascending: true)

        fetchRequest.sortDescriptors = [themeParkSort, nameSort]

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: persistenceController.container.viewContext,
                                                    sectionNameKeyPath: #keyPath(RollerCoaster.themePark.name),
                                                    cacheName: nil)

        controller.delegate = self
        return controller
    }()

    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
        super.init() // NSObject

        fetchData()
    }

    /// Refreshes our list of data and updates the local [RollerCoaster] list
    private func refreshData() {
        guard let sections = fetchedResultsController.sections else { return }
        let sectionNames = sections.map { $0.name }
        var newData: [String: [RollerCoaster]] = [:]

        for (idx, section) in sectionNames.enumerated() {
            if let rollerCoasters = sections[idx].objects as? [RollerCoaster] {
                if section == "" {
                    newData["<Unknown>"] = rollerCoasters
                } else {
                    newData[section] = rollerCoasters
                }
            }
        }

        // Update data object with new values
        data = newData
    }

    /// Performs the initial fetch of our data
    private func fetchData() {
        do {
            try fetchedResultsController.performFetch()
            refreshData()
        } catch let error as NSError {
            assertionFailure("Error fetching RollerCoaster: \(error), \(error.userInfo)")
        }
    }
}

extension CoastersByThemeParkViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        refreshData()
    }
}
