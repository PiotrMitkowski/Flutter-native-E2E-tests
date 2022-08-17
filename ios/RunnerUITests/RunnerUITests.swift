//
//  RunnerUITests.swift
//  RunnerUITests
//
//  Created by Piotr Mitkowski on 16/08/2022.
//

import XCTest


let systemPopupWaitingTime = 30.0
let kElementWaitingTime = 10.0

class RunnerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        self.continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        addUIInterruptionMonitor(withDescription: "Image permission popup") { [weak self] element in
            let allPhotoPermission = element.buttons["Allow Access to All Photos"]
            if !allPhotoPermission.waitForExistence(timeout: systemPopupWaitingTime) {
                print(self?.app.debugDescription ?? "Self detached")
                XCTFail("Failed due to not able to find allPhotoPermission button with \(systemPopupWaitingTime) seconds")

            }

            allPhotoPermission.tap()
            return true
        }
        addUIInterruptionMonitor(withDescription: "Location Services") { element in
            let whileUsingPermission = element.buttons["Allow While Using App"]
            if !whileUsingPermission.waitForExistence(timeout: systemPopupWaitingTime) {
                print(self.app.debugDescription)
                XCTFail("Failed due to not able to find whileUsingPermission button with \(systemPopupWaitingTime) seconds")

            }

            whileUsingPermission.tap()
            return true
        }
    }
    

    func testLaunchingApp() throws {
        let counterLabelPredicate = NSPredicate(format: "label ==[c] %@", "Button tapped 0 times.")
        let counterLabel = app.staticTexts.element(matching: counterLabelPredicate)
        if !counterLabel.waitForExistence(timeout: kElementWaitingTime) {
            XCTFail("Failed due to not able to find counter label with \(kElementWaitingTime) seconds")
        }
        XCTAssert(counterLabel.exists)
    }
    
    func testPerformingAClick() throws {
        let counterButton = app.buttons["Increment"]
        if !counterButton.waitForExistence(timeout: kElementWaitingTime) {
            XCTFail("Failed due to not able to find counter button with \(kElementWaitingTime) seconds")
        }
        XCTAssertTrue(counterButton.exists)
        counterButton.tap()
        
        let counterLabelPredicate = NSPredicate(format: "label ==[c] %@", "Button tapped 1 time.")
        let counterLabel = app.staticTexts.element(matching: counterLabelPredicate)
        if !counterLabel.waitForExistence(timeout: kElementWaitingTime) {
            XCTFail("Failed due to not able to find counter label with \(kElementWaitingTime) seconds")
        }
        XCTAssert(counterLabel.exists)
    }
    
    func testGettingCurrentLocation() throws {
        let geolocationPageButton = app.buttons["Geolocation test"]
        if !geolocationPageButton.waitForExistence(timeout: kElementWaitingTime) {
            XCTFail("Failed due to not able to find geolocation page button with \(kElementWaitingTime) seconds")
        }
        XCTAssertTrue(geolocationPageButton.exists)
        geolocationPageButton.tap()
        
        let currentLocationButton = app.buttons["Get current location"]
        if !currentLocationButton.waitForExistence(timeout: kElementWaitingTime) {
            XCTFail("Failed due to not able to find current location button with \(kElementWaitingTime) seconds")
        }
        XCTAssert(currentLocationButton.exists)
        currentLocationButton.tap()
        
        // There is a known bug where the permission popups interruption won't get fired until a tap
        // happened in the app. We expect a permission popup so we do a tap here.
        let exp = expectation(description: "Test after 2 seconds")
        let _ = XCTWaiter.wait(for: [exp], timeout: 2.0)
        app.tap()
        
        let currentPositionLabelPredicate = NSPredicate(format: "label ==[c] %@", "Current location: 45.47655, -73.61355")
        let currentPositionLabel = app.staticTexts.element(matching: currentPositionLabelPredicate)
        if !currentPositionLabel.waitForExistence(timeout: systemPopupWaitingTime) {
            XCTFail("Failed due to not able to find current position label with \(kElementWaitingTime) seconds")
        }
        XCTAssert(currentPositionLabel.exists)
    }
}
