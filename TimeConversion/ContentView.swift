//
//  ContentView.swift
//  TimeConversion
//
//  Created by Jorge Henrique on 06/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert = 0.0
    @State private var convertedValue = 0.0
    @State private var inputValue = "Seconds"
    @State private var outputValue = "Days"
    @FocusState private var amountIsFocused: Bool
    
    let outputValues = ["Seconds", "Minutes", "Hours", "Days"]
    
    func performConversion() {
        let inputValueInSeconds = convertToSeconds(value: valueToConvert, unit: inputValue)
        convertedValue = convertFromSeconds(value: inputValueInSeconds, unit: outputValue)
    }
    
    func convertToSeconds(value: Double, unit: String) -> Double {
            switch unit {
            case "Seconds":
                return value
            case "Minutes":
                return value * 60
            case "Hours":
                return value * 3600
            case "Days":
                return value * 86400
            default:
                return value
            }
        }
        
        func convertFromSeconds(value: Double, unit: String) -> Double {
            switch unit {
            case "Seconds":
                return value
            case "Minutes":
                return value / 60
            case "Hours":
                return value / 3600
            case "Days":
                return value / 86400
            default:
                return value
            }
        }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit to convert", selection: $inputValue) {
                        ForEach(outputValues, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    
                    TextField("Value", value: $valueToConvert, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                }
                
                Section {
                    Picker("Converted unit", selection: $outputValue) {
                        ForEach(outputValues, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    TextField("Value", value: $convertedValue, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Converted value is: ")
                }
            }
            .onChange(of: valueToConvert) { _ in
                performConversion()
            }
            .onChange(of: inputValue) { _ in
                performConversion()
            }
            .onChange(of: outputValue) { _ in
                performConversion()
            }
            .navigationTitle("Time conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
