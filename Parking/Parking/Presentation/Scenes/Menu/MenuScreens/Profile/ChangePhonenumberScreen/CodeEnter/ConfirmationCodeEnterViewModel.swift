//
//  ConfirmationCodeEnterViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 01.10.2022.
//

import Foundation

protocol ConfirmationCodeEnterViewModelProtocol {
    var confirmationCode: String {get set}
    var inputNumber: String {get}
    var requestType: RequestType {get}
    
    func checkConfirmationCode(inputCode: String) -> Bool
}

final class ConfirmationCodeEnterViewModel: ConfirmationCodeEnterViewModelProtocol {
    
    var confirmationCode: String
    var inputNumber: String
    var requestType: RequestType
    
    init(confirmationCode: String, inputNumber: String, requestType: RequestType) {
        self.confirmationCode = confirmationCode
        self.inputNumber = inputNumber
        self.requestType = requestType
    }
    
    func checkConfirmationCode(inputCode: String) -> Bool {
        
        confirmationCode == inputCode
    }
}
