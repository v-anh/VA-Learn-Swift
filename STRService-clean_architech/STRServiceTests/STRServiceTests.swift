
import XCTest
@testable import STRServiceHost
@testable import STRService
@testable import PromiseKit
@testable import ObjectMapper

class STRServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        let e = expectation(description: "dgdfg")
        STRServiceUrbanDictionary().execute().done { (result: STRServiceUrbanDictionaryModel) in
            print(result)
            e.fulfill()
            }.catch { (error) in
                e.fulfill()
        }
        // This is an example of a performance test case.
        
        
        
        
        waitForExpectations(timeout: 10) { error in
            
            XCTAssertNil(error, "success")
        }
        
        
        
        
    }

}
