//
//  ViewController.swift
//  Parking
//
//  Created by Sofia Lupeko on 23.07.2022.
//

import UIKit
import BabyNet


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        apiCallTest()
    }
    
    private func apiCallTest() {
        let networkClient = BabyNetRepository()
        let parkingNetworkRepo = ParkingNetworkRepository(client: networkClient)
        let parkingRepo = ParkingRepository(network: parkingNetworkRepo)
        let _ = Task {
            do {
                let _ = try await parkingRepo.fetch()
            } catch {

            }
        }
    }


}

