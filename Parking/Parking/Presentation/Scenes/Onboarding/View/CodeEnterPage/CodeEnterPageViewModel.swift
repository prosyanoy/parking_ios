//
//  CodeEnterPageViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов and Denis Zagudaev on 11.09.2022.
//

import Foundation

protocol CodeEnterPageViewModelProtocol {

    var inputNumber: String {get set}
    func confirmationBySMSRequest(inputNumber: String?, completion: @escaping (String, String) -> Void)
    func confirmationByCallRequest(inputNumber: String?, completion: @escaping (String) -> Void)
    func checkResponseSMSid(stringData: String)
    
    func checkConfirmationFlashCode(inputCode: String) -> Bool
    func checkConfirmationSmsCode(inputCode: String) -> Bool
}

final class CodeEnterPageViewModel: CodeEnterPageViewModelProtocol {
    
    var inputNumber: String
    var confirmationSmsCode: String = ""
    var confirmationFlashCode: String = ""
    
    init(inputNumber: String, confirmationSmsCode: String) {
        self.inputNumber = inputNumber
        self.confirmationSmsCode = confirmationSmsCode
    }
    
    func checkResponseSMSid(stringData: String) {
        // Проверка приходящего smsID с сервера
        
    }
    
    func confirmationByCallRequest(inputNumber: String?, completion: @escaping (String) -> Void) {
        guard let inputNumber = inputNumber else {return}
        let number = inputNumber.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
        let phone = "7\(number)"
        let flashCallURL =  "https://my3.webcom.mobi/sendsms.php?user=prosyanoy&pwd=jhknlkjn&type_send_1=flashcall&dadr=\(phone)"
        guard let url = URL(string: flashCallURL) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response, let data = data else { return }
            print(response)
            let stringData = String(data: data, encoding: .utf8)!
            self.confirmationFlashCode = stringData
            DispatchQueue.main.async {
                completion(stringData)
            }
        }.resume()
    }
    
    func confirmationBySMSRequest(inputNumber: String?,  completion: @escaping (String, String) -> Void) {
        guard let inputNumber = inputNumber else {return}
        let number = inputNumber.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
        guard let code = (1000...9999).randomElement() else {return}
        let phone = "7\(number)"
        let smsURL =  "https://my3.webcom.mobi/sendsms.php?user=prosyanoy&pwd=jhknlkjn&sadr=ProParking&dadr=\(phone)&text=\(code)"
        guard let url = URL(string: smsURL) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let stringData = String(data: data, encoding: .utf8)!
            let stringCode = String(code)
            self.confirmationSmsCode = stringCode
            DispatchQueue.main.async {
                completion(stringData, stringCode)
            }
        }.resume()
    }
    
    func checkConfirmationFlashCode(inputCode: String) -> Bool {

        confirmationFlashCode == inputCode
    }
    func checkConfirmationSmsCode(inputCode: String) -> Bool {

        confirmationSmsCode == inputCode
    }
}
