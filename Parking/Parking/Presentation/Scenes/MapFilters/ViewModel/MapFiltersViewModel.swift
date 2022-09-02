//
//  MapFiltersViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import MommysEye


protocol MapFiltersViewModelProtocol {
    var filterParameters: FilterParameters { get }
    func applyButtonTapped()
}

protocol TypeMapFilterTableViewCellViewModelProtocol: AnyObject {
    func coveredCheckBoxButtonTapped(isSelected: Bool)
    func freeCheckBoxButtonTapped(isFree: Bool)
}

protocol PriceMapFilterTableViewCellViewModelProtocol: AnyObject {
    func priceSliderValueDidChange(value: Int)
}

protocol ServicesMapFilterTableViewCellViewModelProtocol: AnyObject {
    func secureButtonTapped(isSelected: Bool)
    func aroundTheClockButtonTapped(isSelected: Bool)
    func evChargingButtonTapped(isSelected: Bool)
    func disabledPersonsButtonTapped(isSelected: Bool)
}


final class MapFiltersViewModel: MapFiltersViewModelProtocol,
                                 TypeMapFilterTableViewCellViewModelProtocol,
                                 PriceMapFilterTableViewCellViewModelProtocol,
                                 ServicesMapFilterTableViewCellViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let router: MapFiltersRouterProtocol
    private let applyFiltersCallback: (FilterParameters) -> Void
    
    
    // MARK: - Init
    
    init(router: MapFiltersRouterProtocol,
         filterParameters: FilterParameters,
         applyFiltersCallback: @escaping (FilterParameters) -> Void) {
        self.router = router
        self.filterParameters = filterParameters
        self.applyFiltersCallback = applyFiltersCallback
    }
    
    
    // MARK: - State
    
    var filterParameters: FilterParameters
    
    
    // MARK: - MapFiltersViewModelProtocol
    
    func applyButtonTapped() {
        applyFiltersCallback(filterParameters)
        router.applyButtonTapped()
    }
    
    
    // MARK: - TypeMapFilterTableViewCellViewModelProtocol
    
    func coveredCheckBoxButtonTapped(isSelected: Bool) {
        filterParameters.covered = isSelected
    }
    
    func freeCheckBoxButtonTapped(isFree: Bool) {
        filterParameters.free = isFree
    }
    
    
    // MARK: - PriceMapFilterTableViewCellViewModelProtocol
    
    func priceSliderValueDidChange(value: Int) {
        filterParameters.price = value
    }
    
    
    // MARK: - ServicesMapFilterTableViewCellViewModelProtocol
    
    func secureButtonTapped(isSelected: Bool) {
        filterParameters.secure = isSelected
    }
    func aroundTheClockButtonTapped(isSelected: Bool) {
        filterParameters.arountTheClock = isSelected
    }
    func evChargingButtonTapped(isSelected: Bool) {
        filterParameters.evCharging = isSelected
    }
    func disabledPersonsButtonTapped(isSelected: Bool) {
        filterParameters.disabledPersons = isSelected
    }
    
}

