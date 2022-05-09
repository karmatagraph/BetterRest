////
////  ContentView.swift
////  BetterRest
////
////  Created by karma on 5/9/22.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var wakeTime = Date.now
//    @State private var sleepAmount = 8.0
//    @State private var currentDate = Date.now
//    
//    var body: some View {
//        VStack{
//            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//                .padding()
//        }
//        DatePicker("Please pick your birthday", selection: $currentDate,in: Date.now..., displayedComponents: .date ).padding()
////            .labelsHidden()
//        
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
