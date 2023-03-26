import SwiftUI

struct ContentViewPage1: View {
    
    @StateObject var locationManager = LocationManager()
    @State var isPresented = false
    
    var body: some View {
        NavigationView() {
            ZStack{
                ZStack{
                    Circle()
                        .frame(width: 500, height: 500)
                        .position(x: 350, y: 300)
                        .foregroundColor(Color(red: 137/255, green: 199/255, blue: 231/255))
                    Circle()
                        .frame(width: 500, height: 500)
                        .   position(x: 0, y: 400)
                        .foregroundColor(Color(red: 255/255, green: 232/255, blue: 122/255))
                }
                .position(x:200, y:800)
                
                VStack {
                    Spacer()
                    Button(action: {
                        locationManager.send { result in}
                        isPresented.toggle()
                    }) {
                        LottieView(name: "4772-bell", loopMode: .loop)
                        
                    }.fullScreenCover(isPresented: $isPresented) {
                        ContentViewPage2(isPresented: $isPresented)
                    }
                    
                    .frame(width: 250, height: 250)
                    .background(Color.white)
                    .cornerRadius(1000)
                    .foregroundColor(.yellow)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color(red: 137/255, green: 199/255, blue: 231/255), lineWidth: 10)
                    )
                    Spacer()
                    
                    // Testing Location
//                    VStack {
//                        Text("Current Location:")
//                            .font(.title)
//                        Text(locationManager.locationStatus)
//                            .foregroundColor(locationManager.locationStatus == "Error" ? .red : .blue)
//                            .font(.title)
//                        Text("Latitude: \(locationManager.lastLocation?.coordinate.latitude ?? 0), Longitude: \(locationManager.lastLocation?.coordinate.longitude ?? 0)")
//                            .font(.title)
//                    }
                    
                    // Testing Token For Remote Notification
//                    VStack {
//                        if notificationManager.authorizationStatus == .authorized {
//                            Text("Push notifications are enabled.")
//                        } else if notificationManager.authorizationStatus == .denied {
//                            Text("Push notifications are disabled.")
//                        } else {
//                            Text("Requesting permission...")
//                        }
//                    }
                    Spacer()
                    
                }
                
            }
            
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Ring Me Up!")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .onAppear {
                locationManager.requestLocationPermission()
                locationManager.sendNotification()
//                UIApplication.shared.registerForRemoteNotifications()
            }
    
            
        }
        
    }
}


struct ContentViewPage1_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPage1()
        
    }
}
