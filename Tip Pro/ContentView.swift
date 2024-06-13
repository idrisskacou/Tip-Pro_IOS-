//
//  ContentView.swift
//  Tip Pro
//
//  Created by idriss on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var entereAmount: String = ""
    @State private var tipAmmount: Double = 0
    @State private var totalAmount: Double = 0
    @State private var tipSlider: Double = 0
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack {
            VStack {
                Text("Enter Amount")
                    .foregroundColor(.secondary)
                    .font(.title)
                    .padding()
                TextField("0.00", text: $entereAmount)
                    .font(.system(size: 70, weight: .semibold, design: .rounded))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .scrollDismissesKeyboard(.interactively)
                    
            }
            Text("Gratuity: \(tipSlider, specifier: "%.0f")%")
                .bold()
                .foregroundStyle(.teal)
            
            Slider(value: $tipSlider, in: 0...100, step: 1)
//                .isFocused = false
                .padding(20)
                .onAppear()
                .onTapGesture {
                    isFocused = false
                }
                .onChange(of: tipSlider, perform: {_ in
                    guard let amount = Double(entereAmount) else {
                        print("Invalid Entry")
                        return
                    }
                    guard let tip = Calculation().calculateTip(of: amount, with: tipSlider) else {
                        print("Bill amount or tip cannot be negative")
                        return
                    }
                    tipAmmount = tip
                    totalAmount = amount + tipAmmount
                   
                }
                    
            )
            
            VStack {
                Text(tipAmmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                
                Text("Gratuity Amount")
                    .foregroundColor(.secondary)
                    .font(.title3)
                    .fontDesign(Font.Design.monospaced)
            }
            .padding(.top, 30)
            
            VStack {
                Text(totalAmount, format: .currency(code: "USD"))
                    .font(.title.bold().leading(.loose))
                    .font(.title)
                Text("Final Amount")
                    .foregroundColor(.secondary)
                    .font(.title2)
            }
            .padding(40)
        }
    }
}

#Preview {
    ContentView()
}
