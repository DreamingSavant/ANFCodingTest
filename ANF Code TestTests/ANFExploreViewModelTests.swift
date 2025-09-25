//
//  ANFExploreViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Rod on 9/25/25.
//

import XCTest
@testable import ANF_Code_Test

final class ANFExploreViewModelTests: XCTestCase {
    
    var sut: ANFExploreViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ANFExploreViewModel(aNFNetwork: MockNetworking())
//        try? sut.getCards()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelCardCount() async {
        try? await sut.getCards()
        XCTAssertNotNil(sut.exploreCards)
    }
}

class MockNetworking: ANFNetworking {
    func fetch<T>(_ type: T.Type, from url: URL) async throws -> T where T : Decodable {
            let bundle = Bundle(for: Self.self)
            let url = try XCTUnwrap(bundle.url(forResource: "ANFTestJson", withExtension: "json"))
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
    }
}
