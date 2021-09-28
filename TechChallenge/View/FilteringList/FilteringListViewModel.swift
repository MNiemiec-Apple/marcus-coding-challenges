//
//  FilteringListViewModel.swift
//  TechChallenge
//
//  Created by Michał Niemiec on 28/09/2021.
//

import Foundation

class FilteringListViewModel {
    let filteringItems: [FilterModel] = [.init(title: "all", color: .black),
                                            .init(title: TransactionModel.Category.food.id, color: TransactionModel.Category.food.color),
                                            .init(title: TransactionModel.Category.health.id, color: TransactionModel.Category.health.color),
                                            .init(title: TransactionModel.Category.entertainment.id, color: TransactionModel.Category.entertainment.color),
                                            .init(title: TransactionModel.Category.shopping.id, color: TransactionModel.Category.shopping.color),
                                            .init(title: TransactionModel.Category.travel.id, color: TransactionModel.Category.travel.color)
    ]
}
