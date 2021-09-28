//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var currentFilter: CurrentFilter
    var filteringListViewModel = FilteringListViewModel()

    var transactions: [TransactionModel] {
        return currentFilter.items
    }

    var body: some View {
        ZStack(alignment: .bottom) {
        VStack {
            FilteringListView(viewModel: filteringListViewModel)
            List {
                ForEach(transactions) { transaction in
                    TransactionView(transaction: transaction, function: { transaction in
                        currentFilter.updatePinnedTransaction(transaction)
                    })
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
        }
            FloatingSumView()

        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
            .environmentObject(CurrentFilter())
    }
}
#endif
