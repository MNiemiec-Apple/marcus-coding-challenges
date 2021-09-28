//
//  FilteringModel.swift
//  TechChallenge
//
//  Created by Michał Niemiec on 27/09/2021.
//

import Foundation
import SwiftUI

class CurrentFilter: ObservableObject {
    @Published var filter: FilterModel = .init(title: "all", color: .black) {
        didSet {
            items = filteredTransactions(transactionCategory)
            checkIfPinned()
        }
    }

    @Published var items = ModelData.sampleTransactions

    var pinnedItems: [TransactionModel] {
        get {
            var allItems = ModelData.sampleTransactions

            pinnedTransactions.forEach { pinnedTransaction in
                if let index = allItems.firstIndex(where: { item in
                    item.id == pinnedTransaction.id
                }) {
                    var updatedItem = allItems[index]
                    updatedItem.changeIsPinned()
                    allItems[index] = updatedItem
                }
            }
            return allItems
        }
    }

    private var pinnedTransactions = [TransactionModel]()

    public var transactionCategory: TransactionModel.Category? {
        return TransactionModel.Category.allCases.first { category in
            category.id.elementsEqual(filter.title)
        }
    }

    func filteredTransactions(_ category: TransactionModel.Category?) -> [TransactionModel] {
        guard let category = category else {
            return ModelData.sampleTransactions
        }

        return ModelData.sampleTransactions.filter {
            $0.category == category
        }
    }

    var allTransactionsSum: Double {
        var sum = 0.0
        pinnedItems.forEach { transaction in
            sum += transaction.isPinned ? transaction.amount : 0
        }
        return sum
    }

    var categoryTransactionsSum: Double {
        var sum = 0.0
        items.forEach { transaction in
            sum += transaction.isPinned ? transaction.amount : 0
        }
        return sum
    }

    var formattedCategoryTransactionsSum: String {
        return "$\(categoryTransactionsSum.formatted())"
    }

    func formattedTransactionsSumForCategory(_ category: TransactionModel.Category) -> String {
        return "$\(transactionsSumForCategory(category).formatted())"
    }

    func transactionsSumForCategory(_ category: TransactionModel.Category) -> Double {
        var sum = 0.0
        pinnedItems.forEach { transaction in
            if transaction.category == category {
                sum += transaction.isPinned ? transaction.amount : 0
            }
        }
        return sum
    }

    func updatePinnedTransaction(_ transaction: TransactionModel) {
        if let transactionIndex = pinnedTransactions.firstIndex(where: {
            $0.id == transaction.id
        }) {
            pinnedTransactions.remove(at: transactionIndex)
        } else {
            pinnedTransactions.append(transaction)
        }

        items = filteredTransactions(transactionCategory)
        checkIfPinned()
    }

    func checkIfPinned() {
        pinnedTransactions.forEach { pinnedTransaction in
            if let index = items.firstIndex(where: { item in
                item.id == pinnedTransaction.id
            }) {
                var updatedItem = items[index]
                updatedItem.changeIsPinned()
                items[index] = updatedItem
            }
        }
    }
}

struct FilterModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let color: Color
}
