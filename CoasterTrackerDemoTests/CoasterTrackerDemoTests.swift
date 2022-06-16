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
}
