//
//  MainMapViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import Foundation
import MommysEye


protocol MainMapDrawerDataSource: AnyObject {
    var parkings: Publisher<[Parking]> { get }
    func onParkingObjectTapped(parking: Parking,
                               dismissOrderSheetCallback: @escaping () -> Void)
}

protocol MainMapViewModelProtocol {
    func viewDidLoad()
    func parkingButtonTapped()
    //    func onParkingObjectTapped(parking: Parking)
    var parkings: Publisher<[Parking]> { get }
}


final class MainMapViewModel: MainMapViewModelProtocol,
                              MainMapDrawerDataSource {
    
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
        loadInititalState()
    }
    
    func parkingButtonTapped() {
        router.parkingButtonTapped()
    }
    
    func onParkingObjectTapped(parking: Parking,
                               dismissOrderSheetCallback: @escaping () -> Void) {
        router.parkingButtonTapped(parking: parking,
                                   dismissOrderSheetCallback)
    }
    
    
    // MARK: - Private
    
    private func loadInititalState() {
        let _ = Task {
            do {
                let parkings = try await parkingRepository.fetch()
                self.parkings.value = parkings
            } catch {
                
            }
        }
    }
    
    
}
