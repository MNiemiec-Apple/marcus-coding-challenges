//
//  FloatingSumView.swift
//  TechChallenge
//
//  Created by Michał Niemiec on 27/09/2021.
//

import SwiftUI

struct FloatingSumView: View {
    @EnvironmentObject var currentFilter: CurrentFilter

    var body: some View {
        VStack(alignment: .trailing) {
            Text(currentFilter.filter.title)
                .font(.system(.headline))
                .foregroundColor(currentFilter.filter.color)
            HStack {
                Text("Total spend:")
                    .fontWeight(.regular)
                    .secondary()
                Spacer()
                Text(currentFilter.formattedCategoryTransactionsSum)
                    .fontWeight(.bold)
                    .secondary()
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 2))
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
        .padding()
    }
}

struct FloatingSumView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingSumView()
            .environmentObject(CurrentFilter())
    }
}
