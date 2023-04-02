//
//  ContentViewPage2.swift
//  RingRing
//
//  Created by Patricia Ho on 23/03/23.
//

import SwiftUI

struct StopButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .frame(width: 342, height: 71)
            .background(Color(red: 247/255, green: 76/255, blue: 98/255))
            .foregroundColor(.white)
            .bold()
            .font(.title)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .clipShape(Capsule())
            

    }
}

struct ContentViewPage2: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented : Bool
    
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
                        // Action to perform when the button is tapped
                        
                    }) {
                        LottieView(name: "88860-success-animation", loopMode: .loop)
                        
                    }
                    Spacer()
                    Button("Tap To Close"){
                        presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(StopButton())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                }
                
            }
            
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Successful!")
                            .font(.largeTitle.bold())
                            .accessibilityAddTraits(.isHeader)
                            .padding(.bottom, 5)
                            .padding(.top, 50)
                        
                        Text("You've notify everyone in ")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Apple Developer Academy")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 90)
                }
            }
        }
        
    }}

struct ContentViewPage2_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPage2(isPresented: .constant(true))
    }
}
