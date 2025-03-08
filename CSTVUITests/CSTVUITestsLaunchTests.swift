//
//  CSTVUITestsLaunchTests.swift
//  CSTVUITests
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import XCTest

final class CSTVUITestsLaunchTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
