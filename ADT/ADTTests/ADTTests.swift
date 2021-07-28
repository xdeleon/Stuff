//
//  ADTTests.swift
//  ADTTests
//
//  Created by Xavier De Leon on 7/28/21.
//

import XCTest
@testable import ADT

class ADTTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONDecodingShows() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "Welcome", withExtension: "json") else {
            XCTFail("Can't locate file: Welcome.json")
            return
        }

        let json = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let shows = try decoder.decode(Welcome.self, from: json)
        XCTAssertEqual(shows.results.count, 20)
    }
}
