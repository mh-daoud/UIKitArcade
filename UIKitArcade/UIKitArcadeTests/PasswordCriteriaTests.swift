//
//  PasswordCriteriaTests.swift
//  UIKitArcadeTests
//
//  Created by admin on 08/12/2023.
//

import XCTest

@testable import UIKitArcade

class PasswordLengthCriteriaTests : XCTestCase {
    
    func testShort() throws{
        XCTAssertFalse(PasswordCriteria.lenghtCriteriaMet("1234567"))
    }
    
    func testLong() throws{
        XCTAssertFalse(PasswordCriteria.lenghtCriteriaMet("abcdefghijklmnopqrstuvwxyz1234567"))
    }
    
    func testValidShort() throws{
        XCTAssertTrue(PasswordCriteria.lenghtCriteriaMet("12345678"))
    }
    
    func testValidLong() throws{
        XCTAssertTrue(PasswordCriteria.lenghtCriteriaMet("abcdefghijklmnopqrstuvwxyz123456"))
    }
}

class PasswordOtherCriteriaTests: XCTestCase {
    
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("ab c"))
    }
    
    func testLengthAndSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lenghtAndNoSpaceMet("12345678"))
    }
    
    func testLengthAndSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lenghtAndNoSpaceMet("1234567 8"))
    }
    
    func testUppercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("aBc"))
    }
    
    func testUppercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("abc"))
    }
    
    func testLowercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("abc"))
    }
    
    func testLowercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("ABC"))
    }
    
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("abc1"))
    }
    
    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("abCd@"))
    }
    
    func testSpecialCharacterMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("ab@c!#"))
    }
    
    func testSpecialCharacterNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("ab2cD%"))
    }
}
