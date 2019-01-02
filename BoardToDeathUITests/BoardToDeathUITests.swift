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
        app.launchArguments.append("--uitesting")
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
    
    func testOnboarding_WhenFinished_OnboardVCDismisses() {
        XCTAssertTrue(app.isDisplayingOnboarding)
        
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        XCTAssertFalse(app.isDisplayingOnboarding)
    }
    
    func testInterfaceVC_AlterViewShowns_WhenOnboardingComplete() {
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        XCTAssertTrue(app.isDisplayingAlertVC)
    }
    
    func testEmailInput_WhenGivenEmail_FillsTextField() {
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("akamffer@mweb.co.za")
        
        XCTAssertTrue(app.textFields["akamffer@mweb.co.za"].exists)
    }
    
    func testPasswordInput_WhenGivenPassword_FillsTextField() {
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        
        let emailTextField = app.textFields["Password"]
        emailTextField.tap()
        emailTextField.typeText("pietpompies1")
        
        XCTAssertTrue(app.textFields["pietpompies1"].exists)
    }
    
    func testImageDownload_WhenDownloadComplete_CaptionLabelShowing() {
        let imageCaption = app.staticTexts["What a beautiful image!"]
        let exists = NSPredicate(format: "exists == true")
        
        expectation(for: exists, evaluatedWith: imageCaption, handler: nil)
        
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        app.buttons["Awesome!"].tap()
        app.buttons["Load Image"].tap()
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(imageCaption.exists)
    }
}

extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["onboardingView"].exists
    }
    
    var isDisplayingAlertVC: Bool {
        return alerts["You did it!"].exists
    }
}
