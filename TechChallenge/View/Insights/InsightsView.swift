//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var currentFilter: CurrentFilter
    let transactions: [TransactionModel] = ModelData.sampleTransactions
    
    var body: some View {
        List {
            let edgeInset = CGFloat(40)
            RingView(transactions: transactions)
                .scaledToFit()
                .listRowInsets(EdgeInsets(top: edgeInset, leading: edgeInset, bottom: edgeInset, trailing: edgeInset))

            
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()

                    Text(currentFilter.formattedTransactionsSumForCategory(category))
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
            .previewLayout(.sizeThatFits)
            .environmentObject(CurrentFilter())
    }
}
#endif
