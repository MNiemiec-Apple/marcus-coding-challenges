//
//  RingView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

fileprivate typealias Category = TransactionModel.Category

struct RingView: View {
    @EnvironmentObject var currentFilter: CurrentFilter
    let transactions: [TransactionModel]

    private func ratio(for categoryIndex: Int) -> Double {

        if let category = Category[categoryIndex] {
            return currentFilter.transactionsSumForCategory(category) / currentFilter.allTransactionsSum
        }
        return 0
    }
    
    private func offset(for categoryIndex: Int) -> Double {
        if let category = Category[categoryIndex - 1] {
            let previousRatio = currentFilter.transactionsSumForCategory(category) / currentFilter.allTransactionsSum

            let previousOffset = offset(for: categoryIndex - 1)
            return previousRatio + previousOffset
        } else {
            return 0
        }
    }

    private func gradient(for categoryIndex: Int) -> AngularGradient {
        let color = Category[categoryIndex]?.color ?? .black
        return AngularGradient(
            gradient: Gradient(colors: [color.unsaturated, color]),
            center: .center,
            startAngle: .init(
                offset: offset(for: categoryIndex),
                ratio: 0
            ),
            endAngle: .init(
                offset: offset(for: categoryIndex),
                ratio: ratio(for: categoryIndex)
            )
        )
    }

    private func percentage(for categoryIndex: Int) -> Double {
        (ratio(for: categoryIndex) * 100)
    }

    private func formattedPercentageText(for categoryIndex: Int) -> String {
        "\(percentage(for: categoryIndex).formatted(hasDecimals: false))%"
    }

    func isPercentageTextHidden(for categoryIndex: Int) -> Bool {
        percentage(for: categoryIndex).isZero
    }
    
    var body: some View {
        ZStack {
            ForEach(Category.allCases.indices) { categoryIndex in
                PartialCircleShape(
                    offset: offset(for: categoryIndex),
                    ratio: ratio(for: categoryIndex)
                )
                    .stroke(
                        gradient(for: categoryIndex),
                        style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                    )
                    .overlay(
                        PercentageText(
                            offset: offset(for: categoryIndex),
                            ratio: ratio(for: categoryIndex),
                            text: formattedPercentageText(for: categoryIndex), isHidden: isPercentageTextHidden(for: categoryIndex)
                        )
                    )
            }
        }
    }
}

extension RingView {
    struct PartialCircleShape: Shape {
        let offset: Double
        let ratio: Double
        
        func path(in rect: CGRect) -> Path {
            Path(offset: offset, ratio: ratio, in: rect)
        }
    }
    
    struct PercentageText: View {
        let offset: Double
        let ratio: Double
        let text: String
        let isHidden: Bool
        
        private func position(for geometry: GeometryProxy) -> CGPoint {
            let rect = geometry.frame(in: .local)
            let path = Path(offset: offset, ratio: ratio / 2.0, in: rect)
            return path.currentPoint ?? .zero
        }
        
        var body: some View {
            if !isHidden {
                GeometryReader { geometry in
                    Text(text)
                        .percentage()
                        .position(position(for: geometry))
                }
            }
        }
    }
}

#if DEBUG
struct RingView_Previews: PreviewProvider {
    static var sampleRing: some View {
        ZStack {
            RingView.PartialCircleShape(offset: 0.0, ratio: 0.15)
                .stroke(
                    Color.red,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
            
            RingView.PartialCircleShape(offset: 0.15, ratio: 0.5)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )

            RingView.PartialCircleShape(offset: 0.65, ratio: 0.35)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
        }
    }
    
    static var previews: some View {
        VStack {
            sampleRing
                .scaledToFit()
            
            RingView(transactions: ModelData.sampleTransactions)
                .scaledToFit()
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .environmentObject(CurrentFilter())

    }
}
#endif
