//
//  STRServiceViewControllerTest.swift
//  STRServiceExampleTests
//
//  Created by Ngo Chi Hai on 4/4/19.
//

import XCTest
import OHHTTPStubs
import PromiseKit
@testable import STRServiceExample

class STRServiceViewControllerTest: XCTestCase {

    override func setUp() {
    }

    func test_LoginService() {
        stub(condition: isPath("/login") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["id": 234,
                             "username": "NCHAI",
                             "token": "zaqwsxcde"
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        var result: User? = nil
        let myExpec = expectation(description: "login")
        LoginService().execute().done { (res : User) in
            result = res
            myExpec.fulfill()
            }.catch { (error) in
                myExpec.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(result?.id, 234)
        XCTAssertEqual(result?.username, "NCHAI")
        XCTAssertEqual(result?.token, "zaqwsxcde")
    }
    
    func test_ProfileService() {
        stub(condition: isPath("/profile") ) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["fullname": "Ngo Chi Hai",
                             "avatar": "https://image.com/avatar"
                ],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        var result: Profile? = nil
        let myExpec = expectation(description: "profile")
        ProfileService().execute().done { (res : Profile) in
            result = res
            myExpec.fulfill()
            }.catch { (error) in
                myExpec.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(result?.fullname, "Ngo Chi Hai")
        XCTAssertEqual(result?.avatar, "https://image.com/avatar")
    }

    func test_STRServiceCountries() {
        var result: [STRServiceCountriesModel]? = nil
        let myExpec = expectation(description: "profile")
        
        STRServiceCountries().execute().done { (res: [STRServiceCountriesModel]) in
            result = res
            myExpec.fulfill()
            }.catch { (error) in
                myExpec.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertEqual(result?.count, 250)
    }
    
    func test_STRServiceUrbanDictionary() {
        var result: STRServiceUrbanDictionaryModel? = nil
        let myExpec = expectation(description: "profile")
        
        STRServiceUrbanDictionary().execute().done { (res: STRServiceUrbanDictionaryModel) in
            result = res
            myExpec.fulfill()
            }.catch { (error) in
                myExpec.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertNotNil(result)
    }
}
