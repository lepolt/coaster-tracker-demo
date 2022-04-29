//
//  CoasterTrackerDemoTests.swift
//  CoasterTrackerDemoTests
//
//  Created by Jonathan Lepolt on 4/21/22.
//

import XCTest
@testable import CoasterTrackerDemo

class CoasterTrackerDemoTests: XCTestCase {
    var persistenceController: PersistenceController!

    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
    }

    override func tearDown() {
        super.tearDown()
        persistenceController = nil
    }

    func testDeleteRollerCoaster() throws {
        let context = persistenceController.container.viewContext
        let rollerCoaster = RollerCoaster(context: context)
        rollerCoaster.id = UUID()
        rollerCoaster.name = "Steel Vengeance"

        try context.save()

        let fetchRequest = RollerCoaster.fetchRequest()
        var results = try context.fetch(fetchRequest)
        XCTAssertEqual(1, results.count)

        let viewModel = RollerCoasterListViewModel(persistenceController: persistenceController)
        viewModel.delete(index: 0)

        results = try context.fetch(fetchRequest)
        XCTAssertEqual(0, results.count)
    }
}
