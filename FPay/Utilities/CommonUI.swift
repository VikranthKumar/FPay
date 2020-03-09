//
//  CommonUI.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct NavigationBar: View {
    var body: some View {
        Image("fampayLogo")
            .frame(height: 60.0)
    }
}

struct URLImage: View {
    let url: String
    
    var body: some View {
        if let urlFormat = URL(string: self.url) {
            return AnyView(
                KFImage(urlFormat)
                    .resizable()
                    .scaledToFill()
            )
        } else {
            return AnyView(
                Text("placeholder")
            )
        }
    }
    
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Refresh: View {
    
    let callback: (() -> Void)
    let message: String
    
    var body: some View {
        VStack(spacing: 15.0) {
            Button(action: {
                self.callback()
            }) {
                Image("refresh")
                    .renderingMode(.template)
                    .accentColor(Color.black)
            }
            Text(message)
                .font(.body)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
    
}

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct FormattedText: View {
    
    let title: Formatted?
    let font: Font
    let fontWeight: Font.Weight
    
    var body: some View {
        self.generateTitle(from: self.title)
    }
    
    func generateTitle(from title: Formatted?) -> some View {
        guard let formattedTitle = title else {
            return AnyView(Text(""))
        }
        if formattedTitle.entities.isEmpty {
            return AnyView(
                Text(formattedTitle.text)
                    .font(self.font)
                    .fontWeight(self.fontWeight)
            )
        } else {
            return AnyView(
                VStack(alignment: .leading, spacing: 0.0) {
                    ForEach(formattedTitle.entities) { (entity) in
                        Text(entity.text.unWrapped)
                            .font(self.font)
                            .fontWeight(self.fontWeight)
                            .foregroundColor(Color(hex: entity.color.unWrapped))
                            .onTapGesture {
                                UIApplication.shared.open(url: entity.url)
                            }
                    }
                }
            )
        }
    }
}

struct CtaButtons: View {
    
    let ctas: [Cta]?
    
    let type: DesignType
    
    var body: some View {
        self.generateButtons(ctas: self.ctas)
    }
    
    func generateButtons(ctas: [Cta]?) -> some View {
        guard let ctaButtons = ctas, !ctaButtons.isEmpty else {
            return AnyView(Text(""))
        }
        return AnyView(
            HStack(alignment: .center, spacing: 10.0) {
                ForEach(ctaButtons) { (cta) in
                    Button(action: {
                        UIApplication.shared.open(url: cta.url)
                    }) {
                        self.getText(text: cta.text, type: self.type)
                            .foregroundColor(Color(hex: cta.textColor))
                            .background(Color(hex: cta.bgColor))
                            .cornerRadius(6)
                    }
                }
            }
        )
    }
    
    func getText(text: String, type: DesignType) -> some View {
        switch type {
        case .HC3:
            return AnyView(
                Text(text)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding([.top, .bottom], 13)
                    .padding([.leading, .trailing], 44)
            )
        default:
            return AnyView(
                Text(text)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding([.top, .bottom], 10)
                    .fullWidth(alignment: .center)
            )
        }
    }
}
