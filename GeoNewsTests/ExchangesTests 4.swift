//
//  ExchangesTests.swift
//  GeoNewsTests
//
//  Created by M1 on 25.07.2024.
//

import XCTest
@testable import GeoNews

class ExchangesTests: XCTestCase {
    var viewModel: ExchangeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ExchangeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertEqual(viewModel.baseCurrency, "GEL")
        XCTAssertEqual(viewModel.targetCurrency, "USD")
        XCTAssertEqual(viewModel.targetCrypto, "BTC")
    }
    
    func testResultCalculation() {
        viewModel.conversionRates = ["USD": 0.85]
        viewModel.moneyInput = "10"
        viewModel.targetCurrency = "USD"

        viewModel.calculateResult()

        XCTAssertEqual(viewModel.result, 10 * 0.85, accuracy: 0.01)
    }
    
    func testMoneyInputLimit() {
        viewModel.moneyInput = "1234567890"
        
        viewModel.moneyInput = "123456789"
        
        XCTAssertEqual(viewModel.moneyInput, "123456789")
    }
}
