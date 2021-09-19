//
//  ContentView.swift
//  WeSplit
//
//  Created by Octavius Bowman on 9/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount =  Double(Int(numberOfPeople) ?? 0 + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalBillWithTip: Double {
        let orderAmountWithoutTip = Double(checkAmount) ?? 0
        let tipChoice = Double(tipPercentages[tipPercentage])
        
        let tipValue = (orderAmountWithoutTip / 100) * tipChoice
        let grandTotal = orderAmountWithoutTip + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People \"2\"", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    
                    // Picker Option
                    /* Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    } */
                }
                
                Section(header: Text("How much of a tip do you want to leave?").textCase(.none)){
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person").textCase(.none)) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total bill including tip").textCase(.none)) {
                    Text("$ \(totalBillWithTip, specifier: "%.2f")")
                }
            }.navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
