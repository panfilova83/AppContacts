//
//  MapViewController.swift
//  UIViewController
//
//  Created by Сергей on 08/01/2021.
//  Copyright © 2021 Татьяна. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {


    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let modelUser = ModelUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        for user in modelUser.users.first!{
            mapView.addAnnotation(user)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkLocationEnabeled()
    }
    

    func checkLocationEnabeled() {
        if CLLocationManager.locationServicesEnabled(){
            setUpManager()
            checkAutorization()
        } else {
            showAlertLocation(title: "У вас выключина геопозиции", messenge: "Хотите включить?", url: URL(string: "App-prefs:root=LOCATION_SERVICES"))
        }
    }

    func setUpManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
  
    func checkAutorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
          break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied:
            showAlertLocation(title: "Вы запретили использование местоположения", messenge: "Хотите это изменить?",url: URL(string: UIApplication.openSettingsURLString))
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func showAlertLocation(title:String, messenge:String?, url: URL?){
        let alert = UIAlertController(title: title, message: messenge, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options:[:], completionHandler: nil)
            }
        }
        let cancelAction =  UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(settingsAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    checkAutorization()
    }
}
    extension MapViewController: MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? User else { return nil}
            
            var viewMarker: MKMarkerAnnotationView
            let idView = "Marker"

            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView{
               view.annotation = annotation
                viewMarker = view
            } else {
               viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
                viewMarker.canShowCallout = true
                viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
                viewMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return viewMarker
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard  let coordinate = locationManager.location?.coordinate
                else { return }
            self.mapView.removeOverlays(mapView.overlays)
        
            let user = view.annotation as! User
            let startPoint = MKPlacemark(coordinate: coordinate)
            let endPoint = MKPlacemark(coordinate: user.coordinate)
            let request = MKDirections.Request()
            
            request.source = MKMapItem(placemark: startPoint)
            request.destination = MKMapItem(placemark: endPoint)
            request.transportType = .automobile
            
            let direction = MKDirections(request: request)

            direction.calculate {(response, error) in
                guard let response = response else { return }

                for rout in response.routes{
                    self.mapView.addOverlay(rout.polyline)
                }
        }
    }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth =  4
            
            return render
        }
}
