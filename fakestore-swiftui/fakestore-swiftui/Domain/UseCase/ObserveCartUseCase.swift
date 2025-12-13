//
//  ObserveCartUseCaseProtocol.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 13/12/25.
//

import Foundation

protocol ObserveCartUseCaseProtocol {
    func execute() -> AsyncStream<[CartItem]>
}

class ObserveCartUseCase: ObserveCartUseCaseProtocol {
    private let repository: CartRepositoryProtocol

    init(repository: CartRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AsyncStream<[CartItem]> {
        return repository.listenToCart()
    }
}
