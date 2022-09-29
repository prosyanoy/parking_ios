//
//  ProfileNetworkManager.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 14.09.2022.
//

import Foundation

final class ProfileNetworkManager {
    
    static let shared = ProfileNetworkManager()
    
    func fetchProfileInfo(completion: @escaping (_ profileInfo:ProfileInfo) -> Void) {
        let password = ""
        let phone = UserDefaultsDataManager.userPhoneNumber
        let fetchURL = "https://pros.sbs/parking/getting.php?apicall=get_user&phone=\(phone)&password=\(password)"
        guard let url = URL(string: fetchURL) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response, let data = data else { return }
            print(response)
            do {
                let decoder = JSONDecoder()
                let profileData = try decoder.decode(ProfileInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(profileData)
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    func saveNewProfileInfo(profileInfo: ProfileInfo) {
        let password = ""
        let phone = UserDefaultsDataManager.userPhoneNumber
        let updateURL = "https://pros.sbs/parking/getting.php?apicall=update_user&phone=\(phone)&surname=\(profileInfo.surname ?? "")&name=\(profileInfo.name ?? "")&patronymic=\(profileInfo.patronymic ?? "")&email=\(profileInfo.email ?? "")&password=\(password)"
        guard let url = URL(string: updateURL) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let response = response else { return }
            print(response)
        }.resume()
    }
}
