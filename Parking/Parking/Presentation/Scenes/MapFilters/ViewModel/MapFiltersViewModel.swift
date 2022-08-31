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
}

protocol PriceMapFilterTableViewCellViewModelProtocol: AnyObject {
    func priceSliderValueDidChange(value: Int)
}

protocol ServicesMapFilterTableViewCellViewModelProtocol: AnyObject {
    func secureSwitchValueDidChange(isOn: Bool)
    func aroundTheClockSwitchValueDidChange(isOn: Bool)
    func eVChargingSwitchValueDidChange(isOn: Bool)
    func disabledSwitchValueDidChange(isOn: Bool)
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
         applyFiltersCallback: @escaping (FilterParameters) -> Void) {
        self.router = router
        self.applyFiltersCallback = applyFiltersCallback
    }
    
    
    // MARK: - State
    
    var filterParameters = FilterParameters(price: 150,
                                            covered: false,
                                            secure: false,
                                            arountTheClock: false,
                                            evCharging: false,
                                            disabledPersons: false)
    
    
    // MARK: - MapFiltersViewModelProtocol
    
    func applyButtonTapped() {
        applyFiltersCallback(filterParameters)
        router.applyButtonTapped()
    }
    
    
    // MARK: - TypeMapFilterTableViewCellViewModelProtocol
    
    func coveredCheckBoxButtonTapped(isSelected: Bool) {
        filterParameters.covered = isSelected
    }
    
    
    // MARK: - PriceMapFilterTableViewCellViewModelProtocol
    
    func priceSliderValueDidChange(value: Int) {
        filterParameters.price = value
    }
    
    
    // MARK: - ServicesMapFilterTableViewCellViewModelProtocol
    
    func secureSwitchValueDidChange(isOn: Bool) {
        filterParameters.secure = isOn
    }
    
    func aroundTheClockSwitchValueDidChange(isOn: Bool) {
        filterParameters.arountTheClock = isOn
    }
    
    func eVChargingSwitchValueDidChange(isOn: Bool) {
        filterParameters.evCharging = isOn
    }
    
    func disabledSwitchValueDidChange(isOn: Bool) {
        filterParameters.disabledPersons = isOn
    }
    
}

