//
//  OwnerPhoneNumberConfirmationViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation

protocol OwnersPhoneNumberConfirmationViewModelProtocol {
    func confirmationRequest(requestType: RequestType, inputNumber: String?, completion: @escaping (String, String) -> Void)
}

final class OwnersPhoneNumberConfirmationViewModel: OwnersPhoneNumberConfirmationViewModelProtocol {
    
    func confirmationRequest(requestType: RequestType, inputNumber: String?, completion: @escaping (String, String) -> Void) {
        guard let inputNumber = inputNumber else {return}
        guard let code = (1000...9999).randomElement() else {return}
        let number = inputNumber.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
        let phone = "7\(number)"
        var requestURL = ""
        if requestType == .flashCall {
            requestURL = "https://my3.webcom.mobi/sendsms.php?user=prosyanoy&sadr=FlashCall&text=\(code)&pwd=jhknlkjn&dadr=\(phone)"
        } else if requestType == .sms {
            requestURL = "https://my3.webcom.mobi/sendsms.php?user=prosyanoy_sms&sadr=ParkingPros&text=%D0%9A%D0%BE%D0%B4:%20\(code)&pwd=ODLSUoYF&dadr=\(phone)"
        }
        guard let url = URL(string: requestURL) else {return}
        print(url)
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response, let data = data else { return }
            print(response)
            let stringData = String(data: data, encoding: .utf8)!
            print(stringData)
            let stringCode = String(code)
            DispatchQueue.main.async {
                completion(stringData, stringCode)
            }
        }.resume()
    }
}
