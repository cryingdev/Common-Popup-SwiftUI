//
//  ContentView.swift
//  popup
//
//  Created by G.K.LEE on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showPopup = false
    
    var body: some View {
        ZStack {
            Button("Toggle Popup") {
                withAnimation {
                    showPopup.toggle()
                }
            }
            if showPopup {
                CommonPopup(
                    title: "Sample Popup",
                    content: Text("This is a sample popup content"),
                    onConfirm: { showPopup = false },
                    onCancel: { showPopup = false },
                    showCloseButton: true
                )
                .modifier(PopupViewModifier(isVisible: $showPopup))
            }
        }
    }
}

#Preview {
    ContentView()
}
