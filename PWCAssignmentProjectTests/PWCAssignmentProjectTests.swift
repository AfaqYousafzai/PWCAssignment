//
//  PWCAssignmentProjectTests.swift
//  PWCAssignmentProjectTests
//
//  Created by Afaq Ahmad on 10/5/23.
//

import XCTest
@testable import PWCAssignmentProject
@testable import NetworkKit

class YourTestCase: XCTestCase {
    var webService: WebServiceProtocol!

    override func setUp() {
        super.setUp()
        webService = MockWebService()
    }

    func testWebServiceSuccess() {
        let expectation = XCTestExpectation(description: "Network request should succeed")

        let url = makeURL.getList
        let request = ListRequest()
        
        let mockWebService = webService as! MockWebService
        mockWebService.result = .success(Data())
        
        webService.callWebService(url: url, request: request) { result, code in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(code, 200)
            case .failure(_):
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testWebServiceNoInternet() {
        let expectation = XCTestExpectation(description: "Network request should fail due to no internet")

        // Set up your request parameters
        let url = makeURL.getList
        let request = ListRequest()
        
        let mockWebService = webService as! MockWebService
        // flag to simulate no internet connection
        if PWCAssignmentProjectGeneralElements.shared.internetConnectivity == .unavailable {
            mockWebService.simulateNoInternet = true
        } else {
            mockWebService.simulateNoInternet = false
        }
        
        
        webService.callWebService(url: url, request: request) { result, code in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error as NSError) where error.code == URLError.notConnectedToInternet.rawValue:
                XCTAssertEqual(code, URLError.notConnectedToInternet.rawValue)
            default:
                XCTFail("Expected failure due to no internet")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}

protocol WebServiceProtocol {
    func callWebService(
        url: makeURL,
        request: BaseRequest,
        completion: @escaping (_ result: Result<Data, Error>, _ code: Int) -> Void
    )
}

class MockWebService: WebServiceProtocol {
    var result: Result<Data, Error> = .success(Data()) // Default to success for convenience
   
    // flag for analysing internet availablity
    var simulateNoInternet = false
    
    func callWebService(
        url: makeURL,
        request: BaseRequest,
        completion: @escaping (Result<Data, Error>, Int) -> Void
    ) {
        if simulateNoInternet {
            // Simulate no internet connection
            let error = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil)
            completion(.failure(error), URLError.notConnectedToInternet.rawValue)
            return
        }

        // Simulate network request by returning the stored result
        switch result {
        case .success(let data):
            completion(.success(data), 200)
        case .failure(let error):
            completion(.failure(error), 500)
        }
    }
}

