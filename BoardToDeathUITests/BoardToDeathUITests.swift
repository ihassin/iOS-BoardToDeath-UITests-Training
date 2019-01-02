//
//  BoardToDeathUITests.swift
//  BoardToDeathUITests
//
//  Created by Armand Kamffer on 2019/01/02.
//  Copyright © 2019 Caleb Stultz. All rights reserved.
//

import XCTest
@testable import BoardToDeath

class BoardToDeathUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testOnboarding_WhenSwiped_NextVCLoads() {
        XCTAssertTrue(app.staticTexts["Welcome to BoardToDeath"].exists)
        
        app.swipeLeft()
        XCTAssertTrue(app.staticTexts["Custom Puppy Content"].exists)
        
        app.swipeLeft()
        XCTAssertTrue(app.staticTexts["Never Get Bored Again!"].exists)
    }
    
    func testOnboarding_WhenDoneButtonTapped_PresentsAlert() {
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        XCTAssertTrue(app.alerts["Alert"].exists)
    }
    
    func testOnboarding_WhenFinished_OnboardVCDismisses() {
        XCTAssertTrue(app.isDisplayingOnboarding)
        
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        XCTAssertFalse(app.isDisplayingOnboarding)
    }
    
}

extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["onboardingView"].exists
    }
}
