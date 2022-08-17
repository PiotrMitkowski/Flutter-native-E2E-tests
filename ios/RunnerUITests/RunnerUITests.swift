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
        addUIInterruptionMonitor(withDescription: "Geolocation permission popup") { [weak self] element in
            let whileUsingPermission = element.buttons["While using the app"]
            if !whileUsingPermission.waitForExistence(timeout: systemPopupWaitingTime) {
                print(self?.app.debugDescription ?? "Self detached")
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
}
