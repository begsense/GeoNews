//
//  GeoNewsTests.swift
//  GeoNewsTests
//
//  Created by M1 on 25.07.2024.
//

import XCTest
@testable import GeoNews

final class SportNewsTests: XCTestCase {
    
    var sportNewsViewModel: SportNewsViewModel!

    override func setUpWithError() throws {
        sportNewsViewModel = SportNewsViewModel()
    }

    override func tearDownWithError() throws {
        sportNewsViewModel = nil
    }

    func testNewsAtIndex() {
        let expectation = XCTestExpectation()
        let sampleNews = News(
            category: "Sport",
            date: "იმდენი და ცოტა მეტი",
            details: "მამარდა",
            image: "ფოტო",
            name: "Rustavi2",
            title: "UEFA-ის გამოკითხვაში, 12 საუკეთესო ფეხბურთელს შორის, დიდი უპირატესობით, გიორგი მამარდაშვილი ლიდერობს",
            likes: 1
        )
        
        sportNewsViewModel.onDataUpdate = {
            XCTAssertGreaterThan(self.sportNewsViewModel.numberOfItems, 0)
            XCTAssertEqual(self.sportNewsViewModel.news(at: 0).title, sampleNews.title)
            expectation.fulfill()
        }
        
        sportNewsViewModel.fetchDataHandler()
        
        wait(for: [expectation], timeout: 5.0)
    }

}

