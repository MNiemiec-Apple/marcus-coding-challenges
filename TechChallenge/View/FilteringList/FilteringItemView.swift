//
//  FilteringItem.swift
//  TechChallenge
//
//  Created by Michał Niemiec on 27/09/2021.
//

import SwiftUI

struct FilteringItemView: View {
    let category: FilterModel
    var didSelectCategory: (FilterModel) -> Void
    var body: some View {
        Button {
            didSelectCategory(category)
        } label: {
            Text(category.title)
                .foregroundColor(.white)
                .bold()
                .font(.title2)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(category.color)
                .clipShape(Capsule())
        }
    }
}

struct FilteringItemView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringItemView(category: FilterModel(title: TransactionModel.Category.entertainment.id, color: TransactionModel.Category.entertainment.color), didSelectCategory: { category in print(category.id)})
    }
}
