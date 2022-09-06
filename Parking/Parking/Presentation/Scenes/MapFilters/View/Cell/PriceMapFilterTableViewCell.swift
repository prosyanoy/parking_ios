//
//  PriceMapFilterTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import UIKit


final class PriceMapFilterTableViewCell: UITableViewCell {
    
    // MARK: - Static
    
    static let identifier = String(describing: PriceMapFilterTableViewCell.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: PriceMapFilterTableViewCellViewModelProtocol?
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDependencies<VM>(viewModel: VM) {
        guard let vm = viewModel as? PriceMapFilterTableViewCellViewModelProtocol else {
            return
        }
        self.viewModel = vm
    }
    
    
    // MARK: - UI
    
    private lazy var priceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 500
        slider.isContinuous = true
        slider.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(priceSliderValueDidChange(_:forEvent:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var priceSliderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: contentView.center.y * 0.2,
                                          width: 70, height: 30))
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    @objc private func priceSliderValueDidChange(_ sender: UISlider, forEvent event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            let intValue = Int(sender.value)
            switch touchEvent.phase {
            case .moved:
                updatePriceSliderThumbLabelText(value: intValue)
                updatePriceSliderThumbLabelMidX()
            case .ended:
                viewModel?.priceSliderValueDidChange(value: intValue)
            default:
                break
            }
        }
    }
    
    private func updatePriceSliderThumbLabelText(value: Int) {
        priceSliderLabel.text = "до \(value)\u{2006}₽"
    }
    
    
    // MARK: - Layout
    
    private func updatePriceSliderThumbLabelMidX() {
        let trackRect = priceSlider.trackRect(forBounds: priceSlider.bounds)
        let thumbRect = priceSlider.thumbRect(forBounds: priceSlider.bounds,
                                              trackRect: trackRect,
                                              value: priceSlider.value)
        priceSliderLabel.center.x = thumbRect.maxX
    }
    
    private func setupLayout() {
        contentView.addSubview(priceSlider)
        contentView.addSubview(priceSliderLabel)
        
        priceSlider.topAnchor.constraint(equalTo: priceSliderLabel.bottomAnchor, constant: 1).isActive = true
        priceSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        priceSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        priceSlider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
        

    // MARK: - Interface

    func setContent(priceValue: Int) {
        priceSlider.setValue(Float(priceValue), animated: false)
        priceSlider.layoutIfNeeded()
        updatePriceSliderThumbLabelText(value: priceValue)
        updatePriceSliderThumbLabelMidX()
    }
    
}



