//
//  MainMapViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import Foundation
import MommysEye



protocol MainMapViewModelProtocol {
    func viewDidLoad()
    func parkingButtonTapped()
    var parkings: Publisher<[Parking]> { get }
}


final class MainMapViewModel: MainMapViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let parkingRepository: ParkingGateway
    private let router: MainMapRouterProtocol
    
    
    // MARK: - Init

    init(parkingRepository: ParkingGateway,
         router: MainMapRouterProtocol) {
        self.parkingRepository = parkingRepository
        self.router = router
    }
    
    // MARK: - State
    
    var parkings = Publisher(value: [Parking]())
    
    
    // MARK: - Interface
    
    func viewDidLoad() {
        let _ = Task {
            do {
                let parkings = try await parkingRepository.fetch()
                self.parkings.value = parkings
            } catch {
                
            }
        }
    }
    
    func parkingButtonTapped() {
        router.parkingButtonTapped()
    }
    
    
}
