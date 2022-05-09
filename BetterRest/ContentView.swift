//
//  ContentView.swift
//  BetterRest
//
//  Created by karma on 5/9/22.
//

import CoreML
import SwiftUI


struct ContentView: View {
    @State private var wakeTime = Date.now
    @State private var sleepAmount = 8.0
    @State private var currentDate = Date.now
    @State private var coffeeAmount = 1
    @State private var sleep = false
    @State var sleepTime = Date.now
    
    var body: some View {
        NavigationView{
            VStack{
                Text("When do you want to wake up")
                    .font(.headline)
                DatePicker("Wake up time: ",selection: $wakeTime , displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .padding(40)
                Text("How much sleep would you like to have")
                    .font(.headline)
                Stepper("Sleep amount: \(sleepAmount.formatted()) ", value: $sleepAmount, in: 4...12,step: 0.25)
//                    .labelsHidden()
                    .padding(40)
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper(coffeeAmount == 1 ? "1 Cup" : "\(coffeeAmount) Cups", value: $coffeeAmount, in: 1...8)
                    .padding(40)
                
            }
            .navigationTitle("Bed Time")
            .toolbar{
                Button(action:calculateBedTime){
                    Image(systemName: "bed.double.fill")
                }
            }
            .alert("Sleep Time", isPresented: $sleep) {
                Button("OK", role: .cancel){}
            }message: {
                Text("You should sleep at: \(sleepTime.formatted(date: .omitted, time: .shortened))")
            }
        }
        
    }
    
    func calculateBedTime(){
        print("go to bed")
        // instance of the calculator model
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeTime)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            sleepTime = wakeTime - prediction.actualSleep
            sleep = true
            print("You to hit the deck at : \(sleepTime)")
        }
        
        catch let error {
            print(error.localizedDescription)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
