//
//  CommonPopup.swift
//  popup
//
//  Created by G.K.LEE on 8/6/24.
//

import SwiftUI

struct CommonPopup<Content: View>: View {
    var title: String
    var content: Content
    var onConfirm: () -> Void
    var onCancel: () -> Void
    var showCloseButton: Bool = true

    var body: some View {
        ZStack {
            // 배경 레이어
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all) // 전체 화면을 덮기
            // 팝업 콘텐츠 레이어
            PopupBackground {
                VStack(spacing: 0) {
                    PopupHeader(title: title, onClose: onCancel)
                    content
                    PopupButtons(confirmTitle: "Confirm", cancelTitle: "Cancel", onConfirm: onConfirm, onCancel: onCancel)
                }
            }
        }
    }
}

struct PopupBackground<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.horizontal, 20) // 팝업 양쪽에 패딩 추가
    }
}

struct PopupHeader: View {
    var title: String
    var onClose: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .padding()
            Spacer()
            Button(action: onClose) {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .padding()
            }
        }
    }
}

struct PopupButtons: View {
    var confirmTitle: String
    var cancelTitle: String
    var onConfirm: () -> Void
    var onCancel: () -> Void

    var body: some View {
        HStack {
            Button(action: onCancel) {
                Text(cancelTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            Button(action: onConfirm) {
                Text(confirmTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}


struct PopupViewModifier: ViewModifier {
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: isVisible)
    }
}

