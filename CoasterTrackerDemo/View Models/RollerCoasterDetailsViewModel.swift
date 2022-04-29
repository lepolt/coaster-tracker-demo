//
//  RollerCoasterDetailsViewModel.swift
//  CoasterTrackerDemo
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import Foundation

class RollerCoasterDetailsViewModel: ObservableObject {
    @Published var rollerCoaster: RollerCoaster?
    @Published var themeParks: [ThemePark] = []

    private let persistenceController: PersistenceController

    init(id: UUID, persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController

        fetchRollerCoaster(id: id)
        fetchThemeParks()
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

    /// Adds the current `RollerCoaster` to a specified `ThemePark` as a relationship.
    func addToThemePark(_ park: ThemePark) {
        guard let rollerCoaster = rollerCoaster else {
            return
        }

        rollerCoaster.themePark = park

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

    /// Fetches a list of `ThemeParks`
    private func fetchThemeParks() {
        let context = persistenceController.container.viewContext
        let fetchRequest = ThemePark.fetchRequest()

        do {
            themeParks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            assertionFailure("Error fetching theme parks: \(error), \(error.userInfo)")
        }
    }
}
