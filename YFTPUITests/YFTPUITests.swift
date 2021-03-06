//
//  YFTPUITests.swift
//  YFTPUITests
//
//  Created by Tjerk Dijkstra on 05/12/2020.
//

import XCTest

class YFTPUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("Startup")
        
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["Gift"].tap()
        snapshot("Gift")
        tabBar.buttons["Archive"].tap()
        snapshot("Archive")
        tabBar.buttons["Settings"].tap()
        snapshot("Settings")
        tabBar.buttons["Write"].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
