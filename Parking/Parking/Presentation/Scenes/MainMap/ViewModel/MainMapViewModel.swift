//
//  MainMapViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import Foundation
import MommysEye


protocol MainMapDrawerInteractorProtocol: AnyObject {
    var parkings: Publisher<[Parking]> { get }
    func onMapTap()
    func onMapParkingObjectTap(parking: Parking,
                               didLayoutHeightCallback: @escaping (Float) -> Void,
                               dismissOrderSheetCallback: @escaping () -> Void)
    func menuButtonTapped()
    func paymentButtonTapped()
    func searchButtonTapped(selectedParkingCallback: @escaping(Parking) -> Void)
    func searchParkingButtonTapped(selectedParkingCallback: @escaping(Parking) -> Void,
                                   didLayoutHeightCallback: @escaping (Float) -> Void,
                                   dismissOrderSheetCallback: @escaping () -> Void)
    func filtersButtonTapped(applyFiltersCallback: @escaping (FilterParameters) -> Void)
}

protocol MainMapViewModelProtocol {
    func viewDidLoad()
}


final class MainMapViewModel: MainMapViewModelProtocol,
                              MainMapDrawerInteractorProtocol {
    
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
    
    
    // MARK: - MainMapViewModelProtocol
    
    func viewDidLoad() {
        loadInititalState()
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
    
    func menuButtonTapped() {
        router.menuButtonTapped()
    }
    
    func paymentButtonTapped() {
        router.paymentButtonTapped()
    }
    
    func searchButtonTapped(selectedParkingCallback: @escaping(Parking) -> Void) {
        router.searchButtonTapped(parkings: parkings.value,
                                  selectedParkingCallback: selectedParkingCallback)
    }
    
    func searchParkingButtonTapped(selectedParkingCallback: @escaping(Parking) -> Void,
                                   didLayoutHeightCallback: @escaping (Float) -> Void,
                                   dismissOrderSheetCallback: @escaping () -> Void) {
        router.searchParkingButtonTapped(parkings: parkings.value,
                                         selectedParkingCallback: selectedParkingCallback,
                                         didLayoutHeightCallback: didLayoutHeightCallback,
                                         dismissOrderSheetCallback: dismissOrderSheetCallback)
    }
    
    func filtersButtonTapped(applyFiltersCallback: @escaping (FilterParameters) -> Void) {
        router.filtersButtonTapped(applyFiltersCallback: applyFiltersCallback)
    }
    
}
