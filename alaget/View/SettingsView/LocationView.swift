//
//  LocationView.swift
//  alaget
//
//  Created by Ernist Isabekov on 31/08/2020.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    @EnvironmentObject var store: SettingsStore
    let locationManager = CLLocationManager()
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            if self.store.IsEnabledLocation{
                self.timer.invalidate()
            } else {
                self.update()
            }
        }
    }
    var body: some View {
        VStack {
            Spacer(minLength: 100)
            VStack{
                Image(systemName: "smallcircle.fill.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .center, spacing: 1, content: {
                Text("You'll need to enable your location in order to use Alaget")
                    .multilineTextAlignment(.center)
                    .frame(width: 330, height: 60)
                    .foregroundColor(.secondary)
            })
            Spacer(minLength: 20)
            VStack{
                Button(action: {
                    self.doEnabledLocation()
                }, label: {
                    Text("ALLOW LOCATION")
                        .foregroundColor(Color.white)
                        .font(.callout)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 45)
//                        .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                })
                    .background(Color.blue)
                    .cornerRadius(10).shadow(radius: 2)
            }
            .padding(.bottom, 20)
        }
    }
    func update() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            var currentLocation: CLLocation!
            
            let status = CLLocationManager.authorizationStatus()
            
            switch status {
            case .denied:
                store.IsEnabledLocation = false
            case .authorizedAlways, .authorizedWhenInUse:
                currentLocation = locationManager.location
                store.profile.lat = currentLocation.coordinate.latitude
                store.profile.lon = currentLocation.coordinate.longitude
                print(currentLocation.coordinate.latitude)
                print(currentLocation.coordinate.longitude)
                store.IsEnabledLocation = true
            case .notDetermined: break
//                doEnabledLocation()
            default:
                print("Somthing went wrong ")
            }
           
        }
    }
    
    func doEnabledLocation(){
        //
        //        let status = CLLocationManager.authorizationStatus()
        //        //locationManager.requestWhenInUseAuthorization()
        //        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
        //            // show alert to user telling them they need to allow location data to use some feature of your app
        //            userAuth.IsEnabledLocation = false
        //            return
        //        }
        //        // if haven't show location permission dialog before, show it to user
        //        if(status == .notDetermined){
        //            locationManager.requestWhenInUseAuthorization()
        //            if (status == .authorizedWhenInUse) || (status == .authorizedAlways){
        //                userAuth.IsEnabledLocation = true
        //                return
        //            }
        //            return
        //        }
        
        //let locationManager = CLLocationManager()
        //locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        let _ = self.timer
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//            var currentLocation: CLLocation!
//            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//                CLLocationManager.authorizationStatus() ==  .authorizedAlways){
//
//                currentLocation = locationManager.location
//                print(currentLocation.coordinate.latitude)
//                print(currentLocation.coordinate.longitude)
//                userAuth.IsEnabledLocation = true
//            }
//        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().environmentObject(SettingsStore())
    }
}
