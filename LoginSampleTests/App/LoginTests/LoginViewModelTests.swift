//
//  LoginViewModelTests.swift
//  LoginSampleTests
//
//  Created by Arsenii Kovalenko on 01.07.2022.
//

import XCTest
@testable import LoginSample

class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!
    var model: LoginModelMock!
    var delegate: LoginViewModelDelegateMock!
    
    override func setUp() {
        super.setUp()
        model = LoginModelMock()
        delegate = LoginViewModelDelegateMock()
        sut = LoginViewModel(model: model) { _ in }
        sut.delegate = delegate
        
    }

    override func tearDown() {
        super.tearDown()
        model = nil
        delegate = nil
        sut = nil
    }

    func testOnLoad() {
        // Prepare
        let emptyString = String()
        
        // Assert
        sut.onLoad()
        
        // Check
        XCTAssertEqual(model.token, emptyString)
        XCTAssertFalse(delegate.isPresentAlertTriggered)
        XCTAssertEqual(sut.biometryType, model.biometryType)
    }
    
    func testBiometryTappedWithError() {
        // Prepare
        let expectation = expectation(description: "Biometry completion")
        model.biometryType = .none

        // Assert
        model.authenticate { _ in
            expectation.fulfill()
        }
        sut.biometryTapped()

        // Check
        wait(for: [expectation], timeout: 3.0)
        XCTAssertFalse(model.token.isEmpty)
        XCTAssertTrue(delegate.isPresentAlertTriggered)
        XCTAssertEqual(sut.biometryType, model.biometryType)
    }
}
