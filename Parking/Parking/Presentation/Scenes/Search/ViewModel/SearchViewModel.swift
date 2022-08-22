//
//  SearchViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 17.08.2022.
//

import MommysEye


protocol SearchViewModelProtocol {
    var parkings: Publisher<[Parking]> { get }
    func viewDidLoad()
    func searchBarTextDidChange(_ text: String)
    func searchBarCancelButtonClicked()
    func didSelectRow(at index: Int)
}


final class SearchViewModel: SearchViewModelProtocol {
    
    // MARK: - State
    
    private var parkingsDataSource: [Parking]
    var parkings = Publisher(value: [Parking]())
    
    private var selectedParkingCallback: (Parking) -> Void
    
    
    // MARK: - Init
    
    init(parkings: [Parking],
         selectedParkingCallback: @escaping (Parking) -> Void) {
        self.parkings.value = parkings
        parkingsDataSource = parkings
        self.selectedParkingCallback = selectedParkingCallback
    }
    
    
    // MARK: - SearchViewModelProtocol
    
    func viewDidLoad() {
        parkings.notify()
    }
    
    func searchBarTextDidChange(_ text: String) {
        parkings.value = parkingsDataSource.filter {
            $0.adress.contains(text.capitalized) || text.isEmpty
        }
    }
    
    func searchBarCancelButtonClicked() {
        parkings.value = parkingsDataSource
    }
    
    func didSelectRow(at index: Int) {
        let parking = parkings.value[index]
        selectedParkingCallback(parking)
    }
    
}
