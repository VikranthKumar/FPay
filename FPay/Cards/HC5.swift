//
//  HC5.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI

struct HC5: View {
    
    let card: Card
    
    var body: some View {
        URLImage(url: self.card.bgImage?.imageUrl ?? "")
            .frame(height: 160.0)
            .setRadius()
        
    }
}

#if Debug
struct HC5_Previews: PreviewProvider {
    static var previews: some View {
        HC5(card: Card())
    }
}
#endif
