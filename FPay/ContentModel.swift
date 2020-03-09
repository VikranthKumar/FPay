//
//  ContentModel.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import Foundation

public enum DesignType: String, Codable, Hashable {
    // Small Display Card
    case HC1
    // Big Display Card
    case HC3
    // Center Card
    case HC4
    // Only Image Card
    case HC5
    // Small Card With Arrow
    case HC6
}

struct CardGroup: Codable, Hashable, Identifiable {
    
    var id: CardGroup {self}
    
    let type: DesignType
    let isScrollable: Bool
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case type = "design_type"
        case isScrollable = "is_scrollable"
        case cards
    }
}

struct Card: Codable, Hashable, Identifiable {
    
    var id: Card {self}
    
    let formattedTitle: Formatted?
    let formattedDescription: Formatted?
    let bgColor: String?
    let ctas: [Cta]?
    let icon: Icon?
    let bgImage: Icon?
    let bgGradient: BgGradient?
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case formattedTitle = "formatted_title"
        case formattedDescription = "formatted_description"
        case bgColor = "bg_color"
        case ctas = "cta"
        case icon
        case bgImage = "bg_image"
        case bgGradient = "bg_gradient"
        case url
    }
    
    init() {
        self.formattedTitle = nil
        self.formattedDescription = nil
        self.bgColor = nil
        self.ctas = nil
        self.icon = nil
        self.bgImage = nil
        self.bgGradient = nil
        self.url = ""
    }
}

struct Formatted: Codable, Hashable {
    
    let text: String
    let entities: [Entitiy]
    
}

struct Entitiy: Codable, Hashable, Identifiable {
    
    var id: Entitiy {self}
    
    let text: String?
    let color: String?
    let url: String?
    
}

struct Cta: Codable, Hashable, Identifiable {
    
    var id: Cta {self}
    
    let text: String
    let url: String
    let bgColor: String
    let textColor: String
    
    enum CodingKeys: String, CodingKey {
        case text
        case url
        case bgColor = "bg_color"
        case textColor = "text_color"
    }
    
}


struct Icon: Codable, Hashable {
    
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
    
}


struct BgGradient: Codable, Hashable {
    
    let angle: Int
    let colors: [String]
    
}
