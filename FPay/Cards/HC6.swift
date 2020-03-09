//
//  HC6.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI

struct HC6: View {
    
    let card: Card
    let showArrow: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 15.0) {
            URLImage(url: self.card.icon?.imageUrl ?? "")
                .frame(width: 30.0, height: 30.0)
            FormattedText(title: self.card.formattedTitle, font: .subheadline, fontWeight: .medium)
                .lineLimit(1)
            if self.showArrow {
                Spacer()
                Image("rightArrow")
            }
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], self.showArrow ? 20 : 30)
        .background(Color(hex: card.bgColor.unWrapped))
        .setRadius()
    }
}

#if Debug
struct HC6_Previews: PreviewProvider {
    static var previews: some View {
        HC6(card: Card(), showArrow: true)
    }
}
#endif
