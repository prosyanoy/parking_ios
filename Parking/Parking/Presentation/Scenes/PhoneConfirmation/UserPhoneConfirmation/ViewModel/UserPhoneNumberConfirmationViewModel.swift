//
//  PhoneNumberConfirmationViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 23.08.2022.
//

import Foundation

protocol UserPhoneNumberConfirmationViewModelProtocol {
    func confirmationBySMSRequest(inputNumber: String?, completion: @escaping (String, String) -> Void)
    func confirmationByCallRequest(inputNumber: String?, completion: @escaping (String) -> Void)
    func checkResponseSMSid(stringData: String)
}

final class UserPhoneNumberConfirmationViewModel: UserPhoneNumberConfirmationViewModelProtocol {
    
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
            DispatchQueue.main.async {
                completion(stringData, stringCode)
            }
        }.resume()
    }
}
