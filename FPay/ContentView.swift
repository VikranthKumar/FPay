//
//  ContentView.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK:- Variables
    @ObservedObject var viewModel: ContentViewModel
    
    // MARK:- Body
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 0.0) {
            NavigationBar()
            GeometryReader { geometryProxy in
                self.getContainerView(geometryProxy: geometryProxy, viewModel: self.viewModel)
                    .padding([.leading, .top, .trailing], 15)
                    .fullWidth(alignment: .center)
                    .fullHeight(alignment: .center)
                    .background(Color.background)
                    .cornerRadius(12, corners: [.topLeft, .topRight])
            }
        }
        .onAppear {
            self.viewModel.fetchData()
        }
    }
    
    // MARK:- Container View
    func getContainerView(geometryProxy: GeometryProxy, viewModel: ContentViewModel) -> some View {
        if viewModel.isLoading {
            return AnyView(
                VStack(spacing: 15.0) {
                    ActivityIndicator()
                    Text("Loading").font(.caption)
                }
            )
        } else if viewModel.showError {
            return AnyView(
                Refresh(callback: { 
                    viewModel.fetchData()
                }, message: viewModel.errorMessage)
            )
        } else if viewModel.cardGroups.isEmpty {
            return AnyView(
                Refresh(callback: {
                    viewModel.fetchData()
                }, message: "No Data Found")
            )
        } else {
            return AnyView(
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 5.0) {
                        ForEach(self.viewModel.cardGroups) { (cardGroup) in
                            self.getEmbededCardGroup(with: cardGroup, geometryProxy: geometryProxy)
                        }
                    }
                }
            )
        }
    }
    
    // MARK:- Embedded Card Group
    func getEmbededCardGroup(with cardGroup: CardGroup, geometryProxy: GeometryProxy) -> some View {
        if cardGroup.isScrollable {
            return AnyView(
                ScrollView(.horizontal, showsIndicators: false) {
                    self.getCardGroup(with: cardGroup, geometryProxy: geometryProxy)
                }
            )
        } else {
            return AnyView(self.getCardGroup(with: cardGroup, geometryProxy: geometryProxy))
        }
    }
    
    // MARK:- Card Group
    func getCardGroup(with cardGroup: CardGroup, geometryProxy: GeometryProxy) -> some View {
        HStack(alignment: VerticalAlignment.center, spacing: 0.0) {
            ForEach(cardGroup.cards) { (card) in
                self.getCard(type: cardGroup.type, card: card, isScrollable: cardGroup.isScrollable)
                    .setWidth(type: cardGroup.type, isScrollable: cardGroup.isScrollable, width: geometryProxy.size.width - 40)
                    .padding(5)
                    .onTapGesture {
                        UIApplication.shared.open(url: card.url)
                    }
            }
        }
    }
    
    // MARK:- Card
    func getCard(type: DesignType, card: Card, isScrollable: Bool) -> some View {
        switch type {
        case .HC1:
            if card.formattedDescription == nil {
                return AnyView(HC6(card: card, showArrow: false))
            } else {
                return AnyView(HC1(card: card, isScrollable: isScrollable))
            }
        case .HC3:
            return AnyView(HC3(card: card))
        case .HC4:
            return AnyView(HC4(card: card))
        case .HC5:
            return AnyView(HC5(card: card))
        case .HC6:
            return AnyView(HC6(card: card, showArrow: true))
        }
    }
}

#if Debug
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
#endif
