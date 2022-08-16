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
    func onMapTap()
    func onMapParkingObjectTap(parking: Parking,
                               didLayoutHeightCallback: @escaping (Float) -> Void,
                               dismissOrderSheetCallback: @escaping () -> Void)
}

protocol MainMapViewModelProtocol {
    func viewDidLoad()
    func parkingButtonTapped()
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
    
    
    // MARK: - MainMapViewModelProtocol
    
    func viewDidLoad() {
        loadInititalState()
    }
    
    func parkingButtonTapped() {
        router.parkingButtonTapped()
    }
    
    
    // MARK: - MainMapDrawerDataSource
    
    func onMapTap() {
        router.onMapTap()
    }
    
    func onMapParkingObjectTap(parking: Parking,
                               didLayoutHeightCallback: @escaping (Float) -> Void,
                               dismissOrderSheetCallback: @escaping () -> Void) {
        router.onMapParkingObjectTap(parking: parking,
                                     didLayoutHeightCallback: didLayoutHeightCallback,
                                     dismissOrderSheetCallback: dismissOrderSheetCallback)
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
