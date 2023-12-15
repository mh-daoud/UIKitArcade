//
//  ViewControllerTests.swift
//  UIKitArcadeTests
//
//  Created by admin on 09/12/2023.
//

import XCTest
@testable import UIKitArcade


class ViewControllerTests_NewPassword_Validation : XCTestCase {
    
    var vc : ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    let invalidPassword = "12345678Aa!%"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.newPasswordTextField.text = ""
        vc.resetPasswordButtonTapped()
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordTextField.text = invalidPassword
        vc.resetPasswordButtonTapped()
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }
    
    func testCriteriaNotMet() throws {
        vc.newPasswordTextField.text = tooShort
        vc.resetPasswordButtonTapped()
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Your password should meet the requirments below")
    }
    
    func testValidPassword() throws {
        vc.newPasswordTextField.text = validPassword
        vc.resetPasswordButtonTapped()
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "")
    }
}


class ViewControllerTests_Confirm_Password_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordTextField.text = ""
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testPasswordsNotMatch() throws {
        vc.newPasswordTextField.text = validPassword
        vc.confirmPasswordTextField.text = tooShort
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match.")
    }
    
    func testPasswordsMatch() throws {
        vc.newPasswordTextField.text = validPassword
        vc.confirmPasswordTextField.text = validPassword
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
    }
}


class ViewControllerTests_Show_Alert: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordTextField.text = validPassword
        vc.confirmPasswordTextField.text = validPassword
        vc.resetPasswordButtonTapped()
        
        XCTAssertNotNil(vc.alertController)
        XCTAssertEqual(vc.alertController!.title, "Success") // Optional
    }
    
    func testShowError() throws {
        vc.newPasswordTextField.text = validPassword
        vc.confirmPasswordTextField.text = tooShort
        vc.resetPasswordButtonTapped()
        
        XCTAssertNil(vc.alertController)
    }
}
