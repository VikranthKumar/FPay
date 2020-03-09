//
//  ViewModifiers.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI

extension View {
    
    func setCardPadding() -> some View {
        self
            .padding(20)
    }
    
    func setRadius() -> some View {
        self
            .cornerRadius(12)
    }
    
    func fullWidth(alignment: Alignment) -> some View {
        self
            .frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
    }
    
    func fullHeight(alignment: Alignment) -> some View {
        self
            .frame(minHeight: 0, maxHeight: .infinity, alignment: alignment)
    }
    
    func setWidth(type: DesignType, isScrollable: Bool, width: CGFloat) -> some View {
        switch type {
        case .HC1:
            if isScrollable {
                return AnyView(self)
            } else {
                return AnyView(self.frame(width: width/2 - 5))
            }
        default:
            return AnyView(self.frame(width: width))
        }
    }
    
}
