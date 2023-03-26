//
//  ContentView.swift
//  RingRing
//
//  Created by Patricia Ho on 26/03/23.
//


import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color(red: 137 / 255, green: 199 / 255, blue: 231 / 255))
            .frame(width: 361, height: 126)
    }
}

struct YellowButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 361, height: 126)
            .foregroundColor(Color(red: 255/255, green: 232/255, blue: 122/255))
    }
}

struct ContentView: View {
    enum Field: Hashable {
        case passwordField
    }

    @State private var showingAlert: Bool = false
    @State private var showingAlertLearner: Bool = false
    @State private var password = ""
    @State private var wrongPassword: Float  = 0
    @State private var showMainView = false

    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            ZStack{
                ZStack{
                    Circle()
                        .frame(width: 500,height: 500)
                        .position(x:100, y:750)
                        .foregroundColor(Color(red: 255/255 , green: 232/255, blue: 122/255))
                    Circle()
                        .frame(width: 500,height: 500)
                        .position(x:350, y:700)
                        .foregroundColor(Color(red: 137/255 , green: 199/255, blue: 231/255))
                    
                }.position(x:200 ,y:580)
                //Title
                VStack(alignment:.leading) {
                    VStack (alignment: .leading){
                        Text("Select your role")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: -5, trailing: 0))
                        
                        Text("Are you a ... ?")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 50, leading: 15, bottom: 10, trailing: 15))
                    
                    //Card
                    VStack{
                        //Mentor Card
                        ZStack {
                            Button(action: {
                                showingAlert = true
                            }) {
                            }
                            .buttonStyle(BlueButton())
                            .alert("Sign In", isPresented: $showingAlert, actions: {
                                SecureField("Password", text: $password)
                                    .border(.red, width: CGFloat(wrongPassword))
                                    .focused($focusedField, equals: .passwordField)
                                Button("Submit"){
                                    authenticateUser(password: password)
                                    print(" (password)")
                                }
                                Button("Cancel"){}
                            })
                            
                            HStack {
                                Image("mentor")
                                    .frame(width: 170)
                                    .mask (alignment: .top) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(height:142)
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                Spacer()
                                VStack (alignment: .leading){
                                    Text("Mentor")
                                        .font(.title2)
                                        .bold()
                                        .padding(.bottom, 1)
                                    Text("You can notify every user's in this app")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    
                                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20 ))
                            }
                            
                            NavigationLink(destination: ContentViewPage1(), isActive: $showMainView) {
                                EmptyView()
                            }
                        }
                        .padding()
                        

                        
                        VStack{
                            Text("or")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(EdgeInsets(top: -10, leading: 5, bottom: -50, trailing: 5))
                        
                        //Learner Card
                        ZStack{
                            Button(action: {
                                showingAlertLearner = true
                            }) {
                                
                            }
                            .buttonStyle(YellowButton())
                            .alert("You are registered as a learner! wait for your mentor to notify you when the break's over!", isPresented: $showingAlertLearner, actions: {
                                Button("Okay!"){}
                            })
                            
                            HStack{
                                Image("learner")
                                    .frame(width: 180)
                                    .mask (alignment: .top) {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(height:142)
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -6, trailing: 0))
                                Spacer()
                                VStack(alignment: .leading){
                                    Text("Learner")
                                        .font(.title2)
                                        .bold()
                                        .padding(.bottom, 1)
                                    Text("You can receive a notification from the mentor’s in this app")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing:20 ))
                            }
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
        }
    }
    func authenticateUser(password: String){
        if password.lowercased() == "123456" {
            wrongPassword = 0
            showMainView = true
        } else {
            wrongPassword = 2
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
