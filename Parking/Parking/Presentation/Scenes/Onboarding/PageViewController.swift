//
//  PageViewController.swift
//  Parking
//
//  Created by mac on 20.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //MARK: - creat vc
    lazy var arrayEntityAddCar: [AddNewCarViewController] = {
        var pagesVC = [AddNewCarViewController]()
        return arrayEntityAddCar
    }()

}
