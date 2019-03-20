//
//  ShowCharacterViewControllerTest.swift
//  STRServiceExampleTests
//
//  Created by Ngo Chi Hai on 3/20/19.
//

import XCTest
import OHHTTPStubs
@testable import STRServiceExample

class ShowCharacterViewControllerTest: XCTestCase {

    override func setUp() {
        
    }

    func testFetchCharacterWithNameSuccess() {
        
        stub(condition: isPath("/characterWizard") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Wizard",
                    "description": "Manipulating the primal forces of the storm, arcane and even time itself, the Wizard is not afraid to destroy all in the path to victory. Successor of the Sorceress and Sorcerer."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        let nameCharacter = "Wizard"
        
        let showCharacterVC = ShowCharacterViewController()
        let showCharacterTestDelegate = ShowCharacterTest()
        showCharacterVC.interactor = ShowCharacterInteractor(
            presenter: ShowCharacterPresenter(viewController: showCharacterTestDelegate),
            characterWorker: CharacterWorker(service: CharacterService())
        )
        
        let expectationCharacter = expectation(description: "SomethingWithDelegate calls the delegate as the result of an async method completion")
        showCharacterTestDelegate.asyncExpectation = expectationCharacter
        
        showCharacterVC.characterName = nameCharacter
        showCharacterVC.loadData()
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            guard let result = showCharacterTestDelegate.viewModel else {
                XCTFail("Expected delegate to be called or result is nil")
                return
            }
            XCTAssertEqual(nameCharacter, result.name)
        }
    }

    func testFetchCharacterWithNameFailed() {
        stub(condition: isPath("/characterWizard") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Wizard",
                    "description": "Manipulating the primal forces of the storm, arcane and even time itself, the Wizard is not afraid to destroy all in the path to victory. Successor of the Sorceress and Sorcerer."
                ],
                statusCode: 400,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        let nameCharacter = "Wizard"
        
        let showCharacterVC = ShowCharacterViewController()
        let showCharacterTestDelegate = ShowCharacterTest()
        showCharacterVC.interactor = ShowCharacterInteractor(
            presenter: ShowCharacterPresenter(viewController: showCharacterTestDelegate),
            characterWorker: CharacterWorker(service: CharacterService())
        )
        
        let expectationCharacter = expectation(description: "SomethingWithDelegate calls the delegate as the result of an async method completion")
        showCharacterTestDelegate.asyncExpectation = expectationCharacter
        
        showCharacterVC.characterName = nameCharacter
        showCharacterVC.loadData()
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertNotNil(showCharacterTestDelegate.error)
        }
    }
}

class ShowCharacterTest: UIViewController, ShowCharacterDisplayable {
    
    var viewModel: ShowCharacterModels.ViewModel? = nil
    var error: AppModels.Error? = nil
    
    // Async test code needs to fulfill the XCTestExpecation used for the test
    // when all the async operations have been completed. For this reason we need
    // to store a reference to the expectation
    var asyncExpectation: XCTestExpectation?
    
    func displayFetchedCharacter(with viewModel: ShowCharacterModels.ViewModel) {
        guard let expectation = asyncExpectation else {
            XCTFail("ShowCharacterTest was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.viewModel = viewModel
        expectation.fulfill()
    }
    
    func display(error: AppModels.Error) {
        guard let expectation = asyncExpectation else {
            XCTFail("ShowCharacterTest was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.error = error
        expectation.fulfill()
    }
}
