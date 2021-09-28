//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TechChallengeTests: XCTestCase {

    var sut: CurrentFilter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CurrentFilter()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testThatTransactionsAreFillteredAccordingToSelectedCategory() {
        //given
        let category = TransactionModel.Category.health

        //when
        let filteredTransactions = sut.filteredTransactions(category).filter({
            $0.category != category
        })

        // then
        XCTAssertTrue(filteredTransactions.isEmpty, "Filtered transactions contains transactions from different category then \(category.id)")
    }

    func testThatSumOfTravelTransactionsIsCorrect() {
        //given
        let category = TransactionModel.Category.travel
        let expectedSumForTravelTransactions = 215.28

        //when
        let travelTransactionsSum = sut.transactionsSumForCategory(category)

        // then
        XCTAssertTrue(travelTransactionsSum.isEqual(to: expectedSumForTravelTransactions), "Sum of travel transactions is different then \(expectedSumForTravelTransactions.formatted(hasDecimals: true))")
    }


}
