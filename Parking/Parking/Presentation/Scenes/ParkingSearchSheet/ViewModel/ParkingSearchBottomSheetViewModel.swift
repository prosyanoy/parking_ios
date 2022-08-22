//
//  ParkingSearchBottomSheetViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 19.08.2022.
//


protocol ParkingSearchBottomSheetViewModelProtocol {
    func parkingSearchButtonTapped()
}


final class ParkingSearchBottomSheetViewModel: ParkingSearchBottomSheetViewModelProtocol {
    
    
    // MARK: - Dependencies
    
    private let router: ParkingSearchBottomSheetRouterProtocol
    private let searchButtonTappedCallback: () -> Void
    
    // MARK: - Init
    
    init(router: ParkingSearchBottomSheetRouterProtocol,
         searchButtonTappedCallback: @escaping () -> Void) {
        self.router = router
        self.searchButtonTappedCallback = searchButtonTappedCallback
    }
    
    
    // MARK: - ParkingSearchBottomSheetViewModelProtocol

    func parkingSearchButtonTapped() {
        router.parkingSearchButtonTapped(callback: searchButtonTappedCallback)
    }
    
}
