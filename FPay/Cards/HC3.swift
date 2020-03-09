//
//  HC3.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI


struct HC3: View {
    
    let card: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0) {
            Image("handLock")
            FormattedText(title: self.card.formattedTitle, font: .largeTitle, fontWeight: .bold)
            FormattedText(title: self.card.formattedDescription, font: .footnote, fontWeight: .regular)
                .padding([.top, .bottom], 13)
            CtaButtons(ctas: self.card.ctas, type: .HC3)
        }
        .padding(33)
        .background(Color(hex: self.card.bgColor.unWrapped))
        .setRadius()
    }
}

#if Debug
struct HC3_Previews: PreviewProvider {
    static var previews: some View {
        HC3(card: Card(), type: .HC3)
    }
}
#endif
