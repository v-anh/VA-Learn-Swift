import XCTest
import OHHTTPStubs
@testable import STRServiceExample

class ListCharactersInteractorTest: XCTestCase {

    override func setUp() {
        
    }

    func test_fetchCharacters_WithEmptyRequest_ReturnArrayWith2Characters() {
        stub(condition: isPath("/listCharacters") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "characters": [
                        [
                            "name": "Barbarian",
                            "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
                        ],[
                            "name": "Witch Doctor",
                            "description": "Deemed the successor of the Necromancer. The Witch Doctor uses death, disease, curses and undead minions to swarm his would be opponents and drain their health and inflict impeding statuses on them."
                        ]
                    ]
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        let listCharactersTestDelegate = ListCharacterTest()
        let listCharactersInteractor = ListCharactersInteractor(presenter: ListCharactersPresenter(viewController: listCharactersTestDelegate), charactersWorker: CharactersWorker(service: ListCharactersService()))
        
        let expectationForList = expectation(description: "List Characters")
        listCharactersTestDelegate.asyncExpectation = expectationForList
        
        listCharactersInteractor.fetchCharacters(with: ListCharactersModels.FetchRequest())
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            guard let result = listCharactersTestDelegate.viewModel else {
                XCTFail("Expected delegate to be called or result is nil")
                return
            }
            XCTAssertEqual(2, result.characters.count)
        }
    }

    func test_fetchCharacters_WithEmptyRequest_ReturnError() {
        stub(condition: isPath("/listCharacters") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "characters": [
                        [
                            "name": "Barbarian",
                            "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
                        ]
                    ]
                ],
                statusCode: 400,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        let listCharactersTestDelegate = ListCharacterTest()
        let listCharactersInteractor = ListCharactersInteractor(presenter: ListCharactersPresenter(viewController: listCharactersTestDelegate), charactersWorker: CharactersWorker(service: ListCharactersService()))
        
        let expectationForList = expectation(description: "List Characters")
        listCharactersTestDelegate.asyncExpectation = expectationForList
        
        listCharactersInteractor.fetchCharacters(with: ListCharactersModels.FetchRequest())
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            XCTAssertNotNil(listCharactersTestDelegate.error)
        }
    }
}

class ListCharacterTest: UIViewController, ListCharactersDisplayable {

    var viewModel: ListCharactersModels.ViewModel? = nil
    var error: AppModels.Error? = nil
    var asyncExpectation: XCTestExpectation?
    
    func displayFetchedCharacters(with viewModel: ListCharactersModels.ViewModel) {
        guard let expectation = asyncExpectation else {
            XCTFail("ListCharacterTest was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.viewModel = viewModel
        expectation.fulfill()
    }
    
    func display(error: AppModels.Error) {
        guard let expectation = asyncExpectation else {
            XCTFail("ListCharacterTest was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.error = error
        expectation.fulfill()
    }
}
