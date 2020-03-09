//
//  ContentViewModel.swift
//  FPay
//
//  Created by Vikranth Kumar on 09/03/20.
//  Copyright © 2020 VikranthKumar. All rights reserved.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    // TODO:- Different Status
    case statusCode
}

final class ContentViewModel: ObservableObject {
    
    // MARK:- Publishers
    @Published var cardGroups: [CardGroup] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK:- Variables
    private var cancellable: AnyCancellable?
    //    private var cancellables = Set<AnyCancellable>()
    
    // MARK:- Initial Data Fetchr
    func fetchData() {
        self.showError = false
        self.errorMessage = ""
        if let url = URL(string: "http://www.mocky.io/v2/5e2703792f00000d00a4f91d") {
            self.isLoading = true
            self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data, response)  in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        // TODO:- Different Status Handling
                        throw HTTPError.statusCode
                    }
                    return data
                })
                .decode(type: [CardGroup].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.showError = false
                        self.errorMessage = ""
                    case .failure(let error):
                        self.showError = true
                        self.errorMessage = error.localizedDescription
                    }
                    self.isLoading = false
                }, receiveValue: { cardGroups in
                    self.cardGroups = cardGroups
                })
        } else {
            self.showError = true
            self.errorMessage = "Invalid Request."
        }
    }
}
