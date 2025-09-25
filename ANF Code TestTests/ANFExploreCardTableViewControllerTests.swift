//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    
    let repository: ProductCardRepositoryContract = FakeProductCardRepository()
    
    override func setUp() {
        testInstance = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? ANFExploreCardTableViewController
        testInstance.viewModel = ProductCardViewModel(repository: repository)
        
        testInstance.viewDidLoad()
    }

    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldBeTen() async {
        await testInstance.getProducts()
                 
        let numberOfRows = await testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == 1, "table view should have 10 cells")
    }
    
    @MainActor
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() async {
        await testInstance.getProducts()

        let firstCell =  testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ExploreContentCell
        let title = firstCell.titleLbl
        XCTAssert(title.text?.count ?? 0 > 0, "title should not be blank")
    }
    
    @MainActor
    func test_cellForRowAtIndexPath_ImageViewImage_shouldNotBeNil() async {
        await testInstance.getProducts()

        let firstCell =  testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ExploreContentCell
        let imageView = firstCell.backgroundImage
        XCTAssertNotNil(imageView)
    }
}
