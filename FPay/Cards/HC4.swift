//
//  HC4.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI

struct HC4: View {
    
    let card: Card
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 5.0) {
            URLImage(url: self.card.icon?.imageUrl ?? "")
                .frame(width: 80.0, height: 80.0)
                .cornerRadius(40)
            Text("Arya Stark")
                .font(.subheadline)
                .foregroundColor(Color(hex: "#1B1B1E").opacity(0.8))
            FormattedText(title: self.card.formattedTitle, font: .headline, fontWeight: .medium)
                .padding([.bottom], 10)
            CtaButtons(ctas: self.card.ctas, type: .HC4)
        }
        .setCardPadding()
        .background(LinearGradient(gradient: Gradient(colors: self.card.bgGradient?.colors.map{Color(hex: $0)} ?? [Color(hex: self.card.bgColor.unWrapped)]), startPoint: .top, endPoint: .bottom))
        .setRadius()
    }
}

#if Debug
struct HC4_Previews: PreviewProvider {
    static var previews: some View {
        HC4(card: Card())
    }
}
#endif
