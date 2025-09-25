//
//  ANFExploreCardDetailViewControllerTests.swift
//  ANF Code TestTests
//
//  Created by Rod on 9/24/25.
//

import XCTest
@testable import ANF_Code_Test

final class ANFExploreCardDetailViewControllerTests: XCTestCase {
    
    var sut: ANFExploreCardDetailViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: ANFExploreCardDetailViewController.self) // use app bundle in tests
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)

            guard let vc = storyboard.instantiateViewController(
                withIdentifier: "ANFExploreCardDetailViewController"
            ) as? ANFExploreCardDetailViewController else {
                XCTFail("Could not instantiate ANFExploreCardDetailViewController from storyboard")
                return
            }
        vc.exploreCard = try firstCard()
        vc.loadViewIfNeeded()
        sut = vc
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_labelsArePopulated() throws {
            XCTAssertEqual(sut.titleLabel.text, "TOPS STARTING AT $12")
            XCTAssertEqual(sut.topDescription.text, "A&F ESSENTIALS")
            XCTAssertEqual(sut.discountCodeLabel.text, "USE CODE: 12345")
        }
        
        func test_termsAndConditionsIsHTML() throws {
            let tnc = sut.termsAndConditionsLabel.attributedText?.string
            XCTAssertTrue(tnc?.contains("Exclusions apply.") ?? false)
        }
}

extension ANFExploreCardDetailViewControllerTests {
    private func loadCardsFromFile() throws -> [ANFResponse] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "ANFTestJson", withExtension: "json") else {
            throw NSError(domain: "MissingFile", code: -1)
        }
        let data = try Data(contentsOf: url)
        let decoded = try! JSONDecoder().decode([ANFResponse].self, from: data)
        return decoded
    }

    private func firstCard() throws -> ANFResponse {
        let cards = try loadCardsFromFile()
        guard let card = cards.first else { throw NSError(domain: "NoFirstCard", code: -1) }
        return card
    }
}
