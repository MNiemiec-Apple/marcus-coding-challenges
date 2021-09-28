//
//  FilteringListView.swift
//  TechChallenge
//
//  Created by Michał Niemiec on 27/09/2021.
//

import SwiftUI

struct FilteringListView: View {
    @EnvironmentObject var currentFilter: CurrentFilter
    var viewModel: FilteringListViewModel

    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.filteringItems, id: \.self) { category in
                    FilteringItemView(category: category, didSelectCategory: { category in
                        currentFilter.filter = category
                    })
                }
            }.padding()
        }
        .background(Color.accentColor.opacity(0.8))
    }
}

struct FilteringListView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringListView(viewModel: FilteringListViewModel())
    }
}
