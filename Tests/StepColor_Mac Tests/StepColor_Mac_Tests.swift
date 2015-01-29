//
//  StepColor_Mac_Tests.swift
//  StepColor_Mac Tests
//
//  Created by Benoit Layer on 24/01/2015.
//  Copyright (c) 2015 Benoit Layer. All rights reserved.
//

import AppKit
import XCTest
import StepColor

class StepColor_Mac_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let stepColor = SColor(colors: NSColor.redColor(), NSColor.blueColor())
        XCTAssert(true, "Pass")
    }
    
    func testInitWithStepColors() {
        let stepColor = SColor(colors: [NSColor.redColor(), NSColor.blueColor()], steps: [0.3, 0.9])
        XCTAssert(true, "Pass")
    }
    
    func testInitWithSingleColor() {
        let stepColor = SColor(colors: [NSColor.redColor()])
        let halfColor = stepColor.colorForStep(0.5)
        var red: CGFloat = 0.0
        halfColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        println("Red : \(red)")
        XCTAssert(red == 1.0, "Pass")
    }
    
    func testMiddleRedBlueColor() {
        let stepColor = SColor(colors: [NSColor.redColor(), NSColor.blueColor()], steps: [0.0, 1.0])
        let halfColor = stepColor.colorForStep(0.5)
        var red: CGFloat = 0.0
        halfColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        println("Red : \(red)")
        XCTAssert(red == 0.5, "Pass")
    }
    
    func testLeftRedColor() {
        let stepColor = SColor(colors: [NSColor.redColor(), NSColor.blueColor()], steps: [0.0, 1.0])
        let halfColor = stepColor.colorForStep(0.0)
        var red: CGFloat = 0.0
        halfColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        println("Red : \(red)")
        XCTAssert(red == 1.0, "Pass")
    }
    
    func testRightBlueColor() {
        let stepColor = SColor(colors: [NSColor.redColor(), NSColor.blueColor()], steps: [0.0, 1.0])
        let halfColor = stepColor.colorForStep(1.0)
        var red: CGFloat = 0.0
        halfColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        println("Red : \(red)")
        XCTAssert(red == 0.0, "Pass")
    }
}
