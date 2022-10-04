//
//  MainMapYMKDrawer.swift
//  Parking
//
//  Created by Maxim Terpugov on 29.07.2022.
//

import UIKit
import YandexMapsMobile
import CoreLocation


protocol MainMapYMKDrawerProtocol {
    func setupYMapView()
}

protocol MainMapButtonsLayerDelegateProtocol {
    func menuButtonTapped()
    func cashViewTapped()
    func searchButtonTapped()
    func zoomPlusButtonTapped()
    func zoomMinusButtonTapped()
    func locationButtonTapped()
    func invalidButtonTapped()
    func searchParkingButtonTapped()
    func filtersButtonTapped()
}


final class MainMapYMKDrawer: NSObject,
                              YMKMapCameraListener,
                              YMKMapInputListener,
                              YMKMapObjectTapListener,
                              YMKUserLocationObjectListener,
                              YMKClusterListener,
                              YMKClusterTapListener,
                              MainMapYMKDrawerProtocol,
                              MainMapButtonsLayerDelegateProtocol {
    
    // MARK: - Dependencies
    
    private unowned var yMapView: YMKMapView
    private unowned var interactor: MainMapDrawerInteractorProtocol
    
    
    // MARK: - Init
    
    init(mapView: YMKMapView,
         interactor: MainMapDrawerInteractorProtocol) {
        self.yMapView = mapView
        self.interactor = interactor
        super.init()
        setupObservers()
    }
    
    
    // MARK: - Private
    
    // Геттер для удобства
    private unowned var map: YMKMap {
        return yMapView.mapWindow.map
    }
    
    private func setupObservers() {
        interactor.parkings.subscribe(observer: self) { [weak self] parkings in
            self?.removeAllMapObjects()
            self?.drawParkingPlaces(parkings: parkings)
            self?.addCluster(parkings: parkings)
        }
    }
    
    private func removeAllMapObjects() {
        // TODO: потестить как будет работать с большим количеством объектов на устройстве
        // Опционально оптимизировать в дальнейшем
        // Добавить активити индикатор во время отрисовки объектов?
        // Обновление карты только в мейн потоке
        polygonMapObjects.forEach { polygon in
            map.mapObjects.remove(with: polygon)
        }
        polygonMapObjects.removeAll()
        
        polylineMapObjects.forEach { polyline in
            map.mapObjects.remove(with: polyline)
        }
        polylineMapObjects.removeAll()
        
        clusterizedPlacemarkCollection.forEach { collection in
            map.mapObjects.remove(with: collection)
        }
        clusterizedPlacemarkCollection.removeAll()
    }
    
    
    // MARK: - MainMapYMKDrawerProtocol
    
    func setupYMapView() {
        let defaultPoint = YMKPoint(latitude: 43.590097,
                                    longitude: 39.721887)
        let defaultCameraPosition = YMKCameraPosition(target: defaultPoint,
                                                      zoom: 11,
                                                      azimuth: 0,
                                                      tilt: 0)
        map.move(with: defaultCameraPosition)
        
        let userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: yMapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = false
        userLocationLayer.setObjectListenerWith(self)
        map.addCameraListener(with: self)
        map.addInputListener(with: self)
        self.userLocationLayer = userLocationLayer
    }
    
    
    // MARK: Yandex Map Kit interface
    // MARK: - USER LOCATION
    
    // Беру отсюда камера позишн юзера
    private var userLocationLayer: YMKUserLocationLayer?
    // Флаг для того, чтобы перебросить камеру на юзер локацию единожды (Без использования якоря)
    private var userLocationView: YMKUserLocationView?
    
    private lazy var userLocationPlacemark: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: 40, height: 40))
        view.isOpaque = false
        
        let placemarkHeight = view.bounds.height * 0.6
        let placemarkWidth = view.bounds.width * 0.6
        let placemarkXOffset = CGFloat((view.bounds.width - placemarkWidth) / 2)
        let placemarkYOffset = CGFloat((view.bounds.height - placemarkHeight) / 2)
        let placemarkRect = CGRect(x: placemarkXOffset, y: placemarkYOffset,
                                   width: placemarkWidth, height: placemarkHeight)
        let placemarkLayer = CALayer()
        placemarkLayer.frame = placemarkRect
        placemarkLayer.cornerRadius = placemarkHeight / 2
        placemarkLayer.backgroundColor = #colorLiteral(red: 0.2853988409, green: 0.5743046999, blue: 0.8819203973, alpha: 1).cgColor
        placemarkLayer.borderWidth = 3.5
        placemarkLayer.borderColor = UIColor.white.cgColor
        view.layer.addSublayer(placemarkLayer)
        
        view.layer.shadowPath = UIBezierPath(rect: placemarkRect).cgPath
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.30
        
        return view
    }()
    
    func onObjectAdded(with view: YMKUserLocationView) {
        guard let userPlacemarkProvider = YRTViewProvider(uiView: userLocationPlacemark) else {
            return
        }
        view.arrow.setViewWithView(userPlacemarkProvider)
        view.pin.setViewWithView(userPlacemarkProvider)
        view.accuracyCircle.fillColor = .systemBlue.withAlphaComponent(0.2)
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        guard view != userLocationView,
              let userPosition = userLocationLayer?.cameraPosition() else { return }
        let zoomUserPosition = YMKCameraPosition(target: userPosition.target,
                                                 zoom: 16,
                                                 azimuth: 0,
                                                 tilt: 0)
        map.move(with: zoomUserPosition)
        userLocationView = view
    }
    
    // MARK: - CAMERA POSITION
    
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        if finished {
            if cameraPosition.zoom >= 16 {
                polygonMapObjects.forEach { polygone in
                    polygone.isVisible = true
                }
                polylineMapObjects.forEach { polyline in
                    polyline.isVisible = true
                }
            } else {
                polygonMapObjects.forEach { polygone in
                    polygone.isVisible = false
                }
                polylineMapObjects.forEach { polyline in
                    polyline.isVisible = false
                }
            }
        }
    }
    
    // MARK: - TAPPABLE
    
    // YMKMapInputListener
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        interactor.onMapTap()
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        
    }
    
    // YMKMapObjectTapListener
    // Для быстрого поиска Парковки по входящему объекту (Polyline / Polygon)
    private var placesParkingBindingTable = [YMKMapObject : Parking]()
    // Для быстрого поиска Map объекта (Polyline / Polygon) по id парковки
    private var parkingPlacesBindingTable = [Int : YMKMapObject]()
    // Для быстрого поиска Плейсмарка по id парковки
    private var parkingPlacemarksBindingTable = [Int : YMKPlacemarkMapObject]()
    // Кеш выбранного объекта
    private var selectedMapObject: YMKMapObject?
    
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        // Дополнительный обработчик, на случай, если плейсмарк отрисуется без кластера, например - одна парковка, или парковки слишком сильно удалены друг от друга и не попадают в кластер
        if let mapObjectPlacemark = mapObject as? YMKPlacemarkMapObject {
            onPlacemarkTap(mapObjectPlacemark)
        }
        //
        guard selectedMapObject !== mapObject,
              let parking = placesParkingBindingTable[mapObject],
              let placemark = parkingPlacemarksBindingTable[parking.id] else {
                  return false
              }
        switch mapObject {
            // POLYLINE
        case let polyline as YMKPolylineMapObject:
            setColor(polyline: polyline,
                     isSelected: .selected)
            selectedMapObject = polyline
            placemark.setIconWith(drawPlacemarkImage(
                parkingCost: parking.hourCost,
                isSelected: .selected))
            interactor.onMapParkingObjectTap(parking: parking,
                                             // DID LAYOUT HEIGHT CALLBACK
                                             didLayoutHeightCallback: { [weak self] newHeight in
                self?.animateToNewMapFrameCenter(overlappedAreaHeight: newHeight,
                                                 targetPoint: placemark.geometry)
            },
                                             // DISMISS CALLBACK
                                             dismissOrderSheetCallback: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.setColor(polyline: polyline,
                                    isSelected: .unselected)
                placemark.setIconWith(strongSelf.drawPlacemarkImage(
                    parkingCost: parking.hourCost,
                    isSelected: .unselected))
                strongSelf.selectedMapObject = nil
                strongSelf.animateToInitialMapFrameCenter()
            })
            // POLYGON
        case let polygon as YMKPolygonMapObject:
            setColor(polygon: polygon,
                     isSelected: .selected)
            selectedMapObject = polygon
            placemark.setIconWith(drawPlacemarkImage(
                parkingCost: parking.hourCost,
                isSelected: .selected))
            interactor.onMapParkingObjectTap(parking: parking,
                                             // DID LAYOUT HEIGHT CALLBACK
                                             didLayoutHeightCallback: { [weak self] newHeight in
                self?.animateToNewMapFrameCenter(overlappedAreaHeight: newHeight,
                                                 targetPoint: placemark.geometry)
            },
                                             // DISMISS CALLBACK
                                             dismissOrderSheetCallback: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.setColor(polygon: polygon,
                                    isSelected: .unselected)
                placemark.setIconWith(strongSelf.drawPlacemarkImage(
                    parkingCost: parking.hourCost,
                    isSelected: .unselected))
                strongSelf.selectedMapObject = nil
                strongSelf.animateToInitialMapFrameCenter()
            })
            
        default:
            return false
        }
        return true
    }
    
    private func animateToNewMapFrameCenter(overlappedAreaHeight: Float, targetPoint: YMKPoint) {
        let mapViewWidth = Float(yMapView.mapWindow.width())
        let mapViewHeight = Float(yMapView.mapWindow.height())
        let scale = Float(UIScreen.main.scale)
        let scaledArea = overlappedAreaHeight * scale
        let deltaHeight = mapViewHeight - scaledArea
        // calculate center point
        let focusPoint = YMKScreenPoint(x: mapViewWidth / 2,
                                        y: deltaHeight / 2)
        guard let initialCenter = yMapView.mapWindow.screenToWorld(with: focusPoint) else {
            return
        }
        let oldPosition = YMKCameraPosition(target: initialCenter,
                                            zoom: map.cameraPosition.zoom,
                                            azimuth: 0,
                                            tilt: 0)
        let newPosition = YMKCameraPosition(target: targetPoint,
                                            zoom: map.cameraPosition.zoom,
                                            azimuth: 0,
                                            tilt: 0)
        // change focus rect (without animation)
        let newRect = YMKScreenRect(topLeft: .init(x: 0, y: 0),
                                    bottomRight: .init(x: mapViewWidth,
                                                       y: deltaHeight))
        yMapView.mapWindow.focusRect = newRect
        // move camera to old position (without animation)
        map.move(with: oldPosition)
        // move camera to new position (with animation)
        map.move(with: newPosition,
                 animationType: .init(type: .smooth,
                                      duration: 0.5),
                 cameraCallback: nil)
    }
    
    private func animateToNewMapFrameCenterWithoutMapTarget(overlappedAreaHeight: Float) {
        let mapViewWidth = Float(yMapView.mapWindow.width())
        let mapViewHeight = Float(yMapView.mapWindow.height())
        let scale = Float(UIScreen.main.scale)
        let scaledArea = overlappedAreaHeight * scale
        let deltaHeight = mapViewHeight - scaledArea
        let focusPoint = YMKScreenPoint(x: mapViewWidth / 2,
                                        y: deltaHeight / 2)
        guard let initialCenter = yMapView.mapWindow.screenToWorld(with: focusPoint) else {
            return
        }
        let oldPosition = YMKCameraPosition(target: initialCenter,
                                            zoom: map.cameraPosition.zoom,
                                            azimuth: 0,
                                            tilt: 0)
       
        let newFocusPoint = YMKScreenPoint(x: mapViewWidth / 2,
                                           y: mapViewHeight / 2)
        guard let newCenter = yMapView.mapWindow.screenToWorld(with: newFocusPoint) else { return }
        let newPosition = YMKCameraPosition(target: newCenter,
                                            zoom: map.cameraPosition.zoom,
                                            azimuth: 0,
                                            tilt: 0)
        
        let newRect = YMKScreenRect(topLeft: .init(x: 0, y: 0),
                                    bottomRight: .init(x: mapViewWidth,
                                                       y: deltaHeight))
        yMapView.mapWindow.focusRect = newRect
        
        map.move(with: oldPosition)
        map.move(with: newPosition,
                 animationType: .init(type: .smooth,
                                      duration: 0.5),
                 cameraCallback: nil)
    }
    
    // full screen rect
    private func animateToInitialMapFrameCenter() {
        let mapViewWidth = Float(yMapView.mapWindow.width())
        let mapViewHeight = Float(yMapView.mapWindow.height())
        // calculate center point
        let focusPoint = YMKScreenPoint(x: mapViewWidth / 2,
                                        y: mapViewHeight / 2)
        guard let initialCenter = yMapView.mapWindow.screenToWorld(with: focusPoint) else {
            return
        }
        let oldPosition = YMKCameraPosition(target: initialCenter,
                                            zoom: map.cameraPosition.zoom,
                                            azimuth: 0,
                                            tilt: 0)
        // update map screen rect
        let newRect = YMKScreenRect(topLeft: .init(x: 0, y: 0),
                                    bottomRight: .init(x: mapViewWidth,
                                                       y: mapViewHeight))
        yMapView.mapWindow.focusRect = newRect
        // calculate new center point after updating map screen rect
        guard let newCenter = yMapView.mapWindow.screenToWorld(with: focusPoint) else {
            return
        }
        let newPosition = YMKCameraPosition(target: newCenter,
                                            zoom: map.cameraPosition.zoom,
                                            azimuth: 0,
                                            tilt: 0)
        // move camera to old position (without animation)
        map.move(with: oldPosition)
        // move camera to new position (with animation)
        map.move(with: newPosition,
                 animationType: .init(type: .smooth,
                                      duration: 0.3),
                 cameraCallback: nil)
    }
    
    // MARK: - CLUSTER
    
    private func drawPlacemarkImage(parkingCost: Float,
                                    isSelected: SelectionState) -> UIImage {
        // Placemark + shadow frame
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: 65, height: 32))
        view.isOpaque = false
        
        // Placemark layer
        let placemarkHeight = view.bounds.height * 0.7
        let placemarkWidth = view.bounds.width * 0.8
        let placemarkXOffset = CGFloat((view.bounds.width - placemarkWidth) / 2)
        let placemarkYOffset = CGFloat((view.bounds.height - placemarkHeight) / 2)
        let placemarkRect = CGRect(x: placemarkXOffset, y: placemarkYOffset,
                                   width: placemarkWidth, height: placemarkHeight)
        let placemarkLayer = CALayer()
        placemarkLayer.frame = placemarkRect
        placemarkLayer.cornerRadius = placemarkHeight / 2
        placemarkLayer.borderWidth = 3
        placemarkLayer.borderColor = UIColor.white.cgColor
        switch isSelected {
        case .selected:
            placemarkLayer.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.7058823529, blue: 0.1411764706, alpha: 1).cgColor
        case .unselected:
            placemarkLayer.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.6823529412, blue: 0.9882352941, alpha: 1).cgColor
        }
        view.layer.addSublayer(placemarkLayer)
        
        // Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.25
        view.layer.shadowPath = UIBezierPath(rect: placemarkRect).cgPath
        
        // Text draw
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: 12,
                                         weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let textAtr: [NSAttributedString.Key : Any] = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        let rect = CGRect(x: placemarkXOffset,
                          y: placemarkYOffset * 1.8,
                          width: placemarkWidth,
                          height: placemarkHeight)
        let text = "\(Int(parkingCost))\u{2006}₽"
        let image = view.drawImageWithText(text: text,
                                           textAttributes: textAtr,
                                           textFrame: rect) ?? UIImage()
        return image
    }
    
    private let clusterImage: UIImage = {
        let image = UIImage(named: "clusterIamge")
        let scaledImage = image?.scale(toSize: CGSize(width: 40,
                                                      height: 40)) ?? UIImage()
        return scaledImage
    }()
    
    private var clusterizedPlacemarkCollection = [YMKClusterizedPlacemarkCollection]()
    
    private func addCluster(parkings: [Parking]) {
        let collection = map.mapObjects.addClusterizedPlacemarkCollection(with: self)
        for parking in parkings {
            let point = parking.coordinates.point
            let yMKPoint = YMKPoint(latitude: point[0],
                                    longitude: point[1])
            let placemark = collection.addPlacemark(with: yMKPoint,
                                                    image: drawPlacemarkImage(
                                                        parkingCost: parking.hourCost,
                                                        isSelected: .unselected))
            placemark.addTapListener(with: self)
            parkingPlacemarksBindingTable[parking.id] = placemark
        }
        collection.clusterPlacemarks(withClusterRadius: 70,
                                     minZoom: 15)
        clusterizedPlacemarkCollection.append(collection)
    }
    
    func onClusterAdded(with cluster: YMKCluster) {
        cluster.appearance.setIconWith(clusterImage)
        cluster.addClusterTapListener(with: self)
    }
    
    func onClusterTap(with cluster: YMKCluster) -> Bool {
        let clusterPoint = cluster.appearance.geometry
        let newZoom = map.cameraPosition.zoom + 1.08
        let position = YMKCameraPosition(target: clusterPoint,
                                         zoom: newZoom,
                                         azimuth: 0,
                                         tilt: 0)
        map.move(with: position,
                 animationType: .init(type: .smooth,
                                      duration: 0.4),
                 cameraCallback: nil)
        return true
    }
    
    // Если плейсмарк отрисовался без кластера, то при нажатии на плейсмарк происходит зум до момента, пока не отрисуются полилайны / полигоны, которые будут хендлить это нажатие
    private func onPlacemarkTap(_ placemark: YMKPlacemarkMapObject) {
        let currentZoom = map.cameraPosition.zoom
        if currentZoom < 16 {
            let cameraPosition = YMKCameraPosition(
                target: placemark.geometry,
                zoom: currentZoom + 1.08,
                azimuth: 0,
                tilt: 0)
            map.move(with: cameraPosition,
                     animationType: .init(type: .smooth,
                                          duration: 0.4),
                     cameraCallback: nil)
        } else {
            return
        }
    }
    
    
    // MARK: - Polyline / Polygon
    
    private func drawParkingPlaces(parkings: [Parking]) {
        for parking in parkings {
            var yMKPoints = [YMKPoint]()
            parking.coordinates.form.forEach { point in
                let yMKPoint = YMKPoint(latitude: point[0],
                                        longitude: point[1])
                yMKPoints.append(yMKPoint)
            }
            switch parking.coordinates.type {
            case .polyGon:
                drawPolygone(points: yMKPoints,
                             parking: parking)
            case .polyLine:
                drawPolyline(points: yMKPoints,
                             parking: parking)
            }
        }
    }
    
    //Cсылки для дальнейшего менеджмента isVisible состояния
    private var polygonMapObjects = [YMKPolygonMapObject]()
    private var polylineMapObjects = [YMKPolylineMapObject]()
    
    private func drawPolygone(points: [YMKPoint], parking: Parking) {
        let polygon = YMKPolygon(outerRing: YMKLinearRing(points: points),
                                 innerRings: [])
        let polygonMapObject = map.mapObjects.addPolygon(with: polygon)
        polygonMapObject.strokeWidth = 3.0
        setColor(polygon: polygonMapObject,
                 isSelected: .unselected)
        if map.cameraPosition.zoom < 16 {
            polygonMapObject.isVisible = false
        }
        polygonMapObject.addTapListener(with: self)
        polygonMapObjects.append(polygonMapObject)
        placesParkingBindingTable[polygonMapObject] = parking
        parkingPlacesBindingTable[parking.id] = polygonMapObject
    }
    
    private func drawPolyline(points: [YMKPoint], parking: Parking) {
        let polyline = YMKPolyline(points: points)
        let polylineMapObject = map.mapObjects.addPolyline(with: polyline)
        polylineMapObject.strokeWidth = 3.0
        setColor(polyline: polylineMapObject,
                 isSelected: .unselected)
        if map.cameraPosition.zoom < 16 {
            polylineMapObject.isVisible = false
        }
        polylineMapObject.addTapListener(with: self)
        polylineMapObjects.append(polylineMapObject)
        placesParkingBindingTable[polylineMapObject] = parking
        parkingPlacesBindingTable[parking.id] = polylineMapObject
    }
    
    private func setColor(polyline: YMKPolylineMapObject, isSelected: SelectionState) {
        switch isSelected {
        case .selected:
            let color = #colorLiteral(red: 0.2235294118, green: 0.7058823529, blue: 0.1411764706, alpha: 1)
            polyline.setStrokeColorWith(color)
        case .unselected:
            let color = #colorLiteral(red: 0.05098039216, green: 0.6823529412, blue: 0.9882352941, alpha: 1)
            polyline.setStrokeColorWith(color)
        }
    }
    
    private func setColor(polygon: YMKPolygonMapObject, isSelected: SelectionState) {
        switch isSelected {
        case .selected:
            let fillColor = #colorLiteral(red: 0.3950589611, green: 0.8737713836, blue: 0.3007746849, alpha: 1).withAlphaComponent(0.7)
            polygon.fillColor = fillColor
            polygon.strokeColor = #colorLiteral(red: 0.252361257, green: 0.571847489, blue: 0.2101071679, alpha: 1)
        case .unselected:
            let fillColor = #colorLiteral(red: 0.3568627451, green: 0.7843137255, blue: 0.9882352941, alpha: 1).withAlphaComponent(0.7)
            polygon.fillColor = fillColor
            polygon.strokeColor = #colorLiteral(red: 0.03529411765, green: 0.5215686275, blue: 0.7529411765, alpha: 1)
        }
    }
    
    private func currentCenterPoint() -> YMKPoint? {
        var focusPoint = YMKScreenPoint()
        if let focusRect = yMapView.mapWindow.focusRect {
            focusPoint = YMKScreenPoint(x: focusRect.bottomRight.x / 2,
                                        y: focusRect.bottomRight.y / 2)
        } else {
            let mapViewWidth = Float(yMapView.mapWindow.width())
            let mapViewHeight = Float(yMapView.mapWindow.height())
            focusPoint = YMKScreenPoint(x: mapViewWidth / 2,
                                        y: mapViewHeight / 2)
        }
        let center = yMapView.mapWindow.screenToWorld(with: focusPoint)
        return center
    }
    
    
    // MARK: - Buttons layer interface

    func menuButtonTapped() {
        interactor.menuButtonTapped()
    }
    
    func cashViewTapped() {
        interactor.paymentButtonTapped()
    }
    
    func searchButtonTapped() {
        interactor.searchButtonTapped { [weak self] selectedParking in
            guard let placemark = self?.parkingPlacemarksBindingTable[selectedParking.id] else { return }
            guard let mapObject = self?.parkingPlacesBindingTable[selectedParking.id] else { return }
            let cameraPosition = YMKCameraPosition(target: placemark.geometry,
                                                   zoom: 17,
                                                   azimuth: 0,
                                                   tilt: 0)
            self?.map.move(with: cameraPosition,
                           animationType: .init(type: .smooth,
                                                duration: 0.5),
                           cameraCallback: { _ in
                let _ = self?.onMapObjectTap(with: mapObject, point: placemark.geometry)
            })
        }
    }
    
    func zoomPlusButtonTapped() {
        let maxZoom: Float = 19
        let currentZoom = map.cameraPosition.zoom
        guard let centerPoint = currentCenterPoint(),
              currentZoom <= maxZoom else {
                  return
              }
        let newZoom = currentZoom + 1
        let cameraPosition = YMKCameraPosition(target: centerPoint,
                                               zoom: newZoom,
                                               azimuth: 0,
                                               tilt: 0)
        map.move(with: cameraPosition,
                 animationType: .init(type: .smooth,
                                      duration: 0.3),
                 cameraCallback: nil)
    }
    
    func zoomMinusButtonTapped() {
        let minZoom: Float = 2
        let currentZoom = map.cameraPosition.zoom
        guard let centerPoint = currentCenterPoint(),
              currentZoom >= minZoom else {
                  return
              }
        let newZoom = currentZoom - 1
        let cameraPosition = YMKCameraPosition(target: centerPoint,
                                               zoom: newZoom,
                                               azimuth: 0,
                                               tilt: 0)
        map.move(with: cameraPosition,
                 animationType: .init(type: .smooth,
                                      duration: 0.3),
                 cameraCallback: nil)
    }
    
    func locationButtonTapped() {
        // TODO: - добавить всплываху, если не доступна гео локация
        guard let userPosition = userLocationLayer?.cameraPosition() else { return }
        let currentZoom = map.cameraPosition.zoom
        let zoomedUserPosition = YMKCameraPosition(target: userPosition.target,
                                                   zoom: currentZoom,
                                                   azimuth: 0,
                                                   tilt: 0)
        map.move(with: zoomedUserPosition)
    }
    
    func invalidButtonTapped() { }
    
    func searchParkingButtonTapped() {
        interactor.searchParkingButtonTapped(
            selectedParkingCallback: { [weak self] selectedParking in
                guard let placemark = self?.parkingPlacemarksBindingTable[selectedParking.id] else { return }
                guard let mapObject = self?.parkingPlacesBindingTable[selectedParking.id] else { return }
                let cameraPosition = YMKCameraPosition(target: placemark.geometry,
                                                       zoom: 17,
                                                       azimuth: 0,
                                                       tilt: 0)
                self?.map.move(with: cameraPosition,
                               animationType: .init(type: .smooth,
                                                    duration: 0.5),
                               cameraCallback: { _ in
                    let _ = self?.onMapObjectTap(with: mapObject, point: placemark.geometry)
                })
            },
            didLayoutHeightCallback: { [weak self] newHeight in
                self?.animateToNewMapFrameCenterWithoutMapTarget(overlappedAreaHeight: newHeight)
            },
            dismissOrderSheetCallback: { [weak self] in
                self?.animateToInitialMapFrameCenter()
            }
        )
    }
    
    func filtersButtonTapped() {
        interactor.filtersButtonTapped()
    }
    
}
