//
//  ContentViewModel.swift
//  mapie
//
//  Created by Prateek on 31/10/21.
//


import MapKit

enum mapDetails{
    
    static let InitialLocation = CLLocationCoordinate2D(latitude: 28.6304, longitude: 77.2177)
    static let defSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    
}


final class ContentViewModel:NSObject,  ObservableObject, CLLocationManagerDelegate{
   
    @Published var region = MKCoordinateRegion(center: mapDetails.InitialLocation, span: mapDetails.defSpan)
    
    var locationManager: CLLocationManager?
   
    func checkIfLocationServicesEnabled(){
       if CLLocationManager.locationServicesEnabled(){
       locationManager = CLLocationManager()
       locationManager!.delegate = self
   }
       else
       {
           print("Location Services in turned off!!!")
       
       
       }
   
}
   private func checkLocationAuthorization(){
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus{
            
       
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Auth. is restricted!!")
        case .denied:
            print("Change your authorization settings!!PERMISSION DENIED BY USER")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
             
        @unknown default:
            break
        }
    }
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
 
}

