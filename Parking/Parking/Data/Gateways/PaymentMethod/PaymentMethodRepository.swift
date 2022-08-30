//
//  PaymentMethodRepository.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

import Foundation


final class PaymentMethodRepository: PaymentMethodGateway {
    
    func fetch() async throws -> [PaymentMethod] {
        let result = await withCheckedContinuation {
            (continuation: CheckedContinuation<[PaymentMethod], Never>) -> Void in
            // let result = network.loadRequest...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let result = [
                    PaymentMethod(title: "Банковская карта", description: "Комиссия 3,19% (минимум 3,49\u{2006}₽)", icon: nil, signature: .card),
                    PaymentMethod(title: "Система быстрых платежей", description: "Комиссия 0,7%", icon: nil, signature: .sbp)
                ]
                continuation.resume(returning: result)
            }
        }
        return result
    }
    
}
