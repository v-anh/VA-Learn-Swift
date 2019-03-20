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
        stub(condition: isPath("/characterBarbarian") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Barbarian",
                    "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterWitchDoctor") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Witch Doctor",
                    "description": "Deemed the successor of the Necromancer. The Witch Doctor uses death, disease, curses and undead minions to swarm his would be opponents and drain their health and inflict impeding statuses on them."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
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
        
        stub(condition: isPath("/characterMonk") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Monk",
                    "description": "A religious warrior of the light, they are masters of the martial arts and speed."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterDemonHunter") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Demon Hunter",
                    "description": "A stealthy warrior, specializes in crossbows and launching explosives with a focus mainly on ranged combat."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterCrusader") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Crusader",
                    "description": "A middle-ranged melee class with a combat style centered around shields, flails, and spells (introduced in Reaper of Souls)"
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        stub(condition: isPath("/characterNecromancer") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "name": "Necromancer",
                    "description": "A re-imagining of the class from Diablo II, available with the Rise of the Necromancer pack."
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }

    func testFetchCharacterWithName() {
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

}

class ShowCharacterTest: ShowCharacterDisplayable {
    
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
