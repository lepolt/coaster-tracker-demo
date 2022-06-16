//
//  RollerCoasterDetailsViewModel.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import Foundation

class RollerCoasterDetailsViewModel: ObservableObject {
    @Published var rollerCoaster: RollerCoaster?

    private let persistenceController: PersistenceController

    init(id: UUID, persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController

        fetchRollerCoaster(id: id)
    }

    /// Toggles the `isFavorite` property of our RollerCoaster model
    func toggleFavorite() {
        guard let rollerCoaster = rollerCoaster else {
            return
        }

        rollerCoaster.isFavorite.toggle()

        let context = persistenceController.container.viewContext
        do {
            try context.save()
        } catch let error as NSError {
            assertionFailure("Error saving RollerCoaster: \(error), \(error.userInfo)")
        }
    }

    /// Fetches a specific `RollerCoaster` by a given UUID
    /// - Parameter id: The UUID of the `RollerCoaster` we want to fetch
    private func fetchRollerCoaster(id: UUID) {
        let context = persistenceController.container.viewContext
        let fetchRequest = RollerCoaster.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)

        do {
            let results = try context.fetch(fetchRequest)
            rollerCoaster = results.first
        } catch let error as NSError {
            assertionFailure("Error fetching RollerCoaster with id: \(id.uuidString): \(error), \(error.userInfo)")
        }
    }
}
