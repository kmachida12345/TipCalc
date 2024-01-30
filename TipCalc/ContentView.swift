//
//  ContentView.swift
//  TipCalc
//
//  Created by 町田康平 on 2024/01/30.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var tip = 0.0
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("請求額")) {
                    TextField("金額を入力", text: $amount)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("チップ")) {
                    Text("\(calculateTip(), specifier: "%.2f")")
                }
            }
            .navigationBarTitle("チップ計算")
            .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("エラー"),
                                message: Text("無効な入力です"),
                                dismissButton: .default(Text("OK")) {
                                    self.amount = ""
                                    self.showAlert = false
                                }
                            )
                        }
        }
    }

    func calculateTip() -> Double {
        let tipPercentage = 0.10

        if amount.isEmpty {
            return 0.0
        }

        guard let amountValue = Double(amount) else {
            DispatchQueue.main.async {
                self.showAlert = true
            }
            return 0.0
        }
        return amountValue * tipPercentage
     }
}

#Preview {
    ContentView()
}
