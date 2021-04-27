//
//  mapSearchViewController.swift
//  HairHelper
//
//  Created by Joseph Young on 4/10/21.
//

import UIKit
import MapKit
import CoreLocation

class mapSearchViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        navigationController?.setToolbarHidden(true, animated: true)
        super.viewDidLoad()
        checkLocationServices()
        centerView()

        // Do any additional setup after loading the view.
    }
    
    func setupLocationManager()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func centerView()
    {
        self.mapView.removeAnnotations(self.mapView.annotations)
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
        //now we are going to add annotations
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "Hair Stylist"
        searchRequest.region = mapView.region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start
        {
            response, _ in guard let response = response else{
                return
            }
        print(response.mapItems)
        var matchingItems:[MKMapItem] = []
        matchingItems = response.mapItems
        for i in 1...matchingItems.count - 1
        {
            let newItem = matchingItems[i].placemark
            var itemAnnotation = MKPointAnnotation();
            itemAnnotation.coordinate = newItem.coordinate
            itemAnnotation.title = newItem.name
            self.mapView.addAnnotation(itemAnnotation)
        }
        }
    }
    
    func locationAuthorization()
    {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .restricted:
            break
        default:
            break
                
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            locationAuthorization()
        }else{
            //display an error
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension mapSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //will come back here
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //we'll also be abck here i guess
    }
}
