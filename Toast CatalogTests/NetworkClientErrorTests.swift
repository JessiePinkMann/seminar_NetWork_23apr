//
//  File.swift
//  Toast CatalogTests
//
//  Created by Egor Anoshin on 23.04.2024.
//

import XCTest
@testable import Toast_Catalog

class NetworkClientErrorTests: XCTestCase {

    func testErrorHandling() {
        let networkClient = MockNetworkClient()
        let error = NSError(domain: "NetworkError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not Found"])
        networkClient.mockError = error

        let expectation = self.expectation(description: "Awaiting network response")

        networkClient.getItems { result in
            defer { expectation.fulfill() }

            if case .success(_) = result {
                XCTFail("Expected failure, but got success.")
            }

            if case let .failure(receivedError as NSError) = result {
                XCTAssertEqual(receivedError, error, "Received error does not match expected error.")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    class MockNetworkClient: NetworkClient {
        var mockItems: [Item]?
        var mockError: Error?

        override func getItems(completion: @escaping (Result<[Item], Error>) -> Void) {
            if let error = mockError {
                completion(.failure(error))
            } else if let items = mockItems {
                completion(.success(items))
            }
        }
    }
}

