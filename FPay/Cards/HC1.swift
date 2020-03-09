//
//  HC1.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI

struct HC1: View {
    
    let card: Card
    let isScrollable: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 15.0) {
            URLImage(url: self.card.icon?.imageUrl ?? "")
                .frame(width: 50.0, height: 50.0)
                .cornerRadius(25)
            VStack(alignment: .leading, spacing: 0.0) {
                FormattedText(title: self.card.formattedTitle, font: .subheadline, fontWeight: .medium)
                    .lineLimit(1)
                    .padding([.bottom], 10)
                FormattedText(title: self.card.formattedDescription, font: .subheadline, fontWeight: .regular)
                    .foregroundColor(Color(hex: "#1B1B1E").opacity(0.8))
                    .lineLimit(1)
            }
            if self.isScrollable {
                Spacer()
            }
        }
        .setCardPadding()
        .background(Color(hex: card.bgColor.unWrapped))
        .setRadius()
    }
}

#if Debug
struct HC1_Previews: PreviewProvider {
    static var previews: some View {
        HC1(card: Card(), shouldFill: true)
    }
}
#endif
