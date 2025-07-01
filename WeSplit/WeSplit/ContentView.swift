//
//  ContentView.swift
//  WeSplit
//
//  Created by Mark Greene on 27/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var chequeAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercntage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercantages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercntage)
        
        let tipValue = chequeAmount / 100 * tipSelection
        let grandTotal = chequeAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Amount", value: $chequeAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("Tip Percentage") {
                    Picker("Tip percentage", selection: $tipPercntage){
                        ForEach(tipPercantages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
