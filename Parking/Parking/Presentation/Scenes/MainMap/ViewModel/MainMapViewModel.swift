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
    func filtersButtonTapped()
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
    
    
    // MARK: - Private state
    
    private var parkingsDataSource = [Parking]()
    // default value - filters are disabled
    private var filterParameters = FilterParameters(price: 0,
                                                    free: false,
                                                    covered: false,
                                                    secure: false,
                                                    arountTheClock: false,
                                                    evCharging: false,
                                                    disabledPersons: false)
    
    
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
    
    func filtersButtonTapped() {
        router.filtersButtonTapped(filterParameters: filterParameters) { [weak self] filterParameters in
            self?.filterParameters = filterParameters
            self?.filterParkings(with: filterParameters)
        }
    }
    
    
    // MARK: - Private
    
    private func loadInititalState() {
        let _ = Task {
            do {
                let parkings = try await parkingRepository.fetch()
                self.parkingsDataSource = parkings
                self.parkings.value = parkings
            } catch {
                
            }
        }
    }
    
    // Исключаю нерелевантные парковки
    private func filterParkings(with filterParameters: FilterParameters) {
        var filteredParkings = parkingsDataSource
        
        // TODO: можно покрасивше?
        if filterParameters.free {
            for i in (0..<filteredParkings.count).reversed() {
                if filteredParkings[i].hourCost != 0 {
                    filteredParkings.remove(at: i)
                }
            }
        }
        if filterParameters.covered {
            for i in (0..<filteredParkings.count).reversed() {
                if !filteredParkings[i].covered {
                    filteredParkings.remove(at: i)
                }
            }
        }
        if filterParameters.secure {
            for i in (0..<filteredParkings.count).reversed() {
                if !filteredParkings[i].covered {
                    filteredParkings.remove(at: i)
                }
            }
        }
        if filterParameters.arountTheClock {
            for i in (0..<filteredParkings.count).reversed() {
                if !filteredParkings[i].aroundTheClock {
                    filteredParkings.remove(at: i)
                }
            }
        }
        if filterParameters.evCharging {
            for i in (0..<filteredParkings.count).reversed() {
                if !filteredParkings[i].ev {
                    filteredParkings.remove(at: i)
                }
            }
        }
        if filterParameters.disabledPersons {
            for i in (0..<filteredParkings.count).reversed() {
                if !filteredParkings[i].disabled {
                    filteredParkings.remove(at: i)
                }
            }
        }
        parkings.value = filteredParkings
    }
    
}
