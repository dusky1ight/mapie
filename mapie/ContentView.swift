//
//  ContentView.swift
//  mapie
//
//  Created by Prateek on 30/10/21.
//
import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331, longitude: -51.0949), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    
    
    var body: some View {
       Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear{
                viewModel.checkIfLocationServicesEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 final class ContentViewModel:NSObject,  ObservableObject, CLLocationManagerDelegate{
    
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
             break
         @unknown default:
             break
         }
     }
     
     
     func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         checkLocationAuthorization()
     }

    
}


