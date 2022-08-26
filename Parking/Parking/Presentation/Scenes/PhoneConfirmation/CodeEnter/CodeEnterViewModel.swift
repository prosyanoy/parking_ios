//
//  CodeEnterViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation

protocol CodeEnterViewModelProtocol {
    var confirmationCode: String {get}
    var inputNumber: String {get}
    
    func checkConfirmationCode(confirmationCode: String, inputCode: String)
}

final class CodeEnterViewModel: CodeEnterViewModelProtocol {
    
    var confirmationCode: String
    var inputNumber: String
    
    init(confirmationCode: String, inputNumber: String) {
        self.confirmationCode = confirmationCode
        self.inputNumber = inputNumber
    }
    
    func checkConfirmationCode(confirmationCode: String, inputCode: String) {
        
    }
}
