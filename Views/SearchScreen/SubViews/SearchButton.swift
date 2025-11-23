//
//  SearchButton.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 23.11.2025.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Поиск")
                .foregroundStyle(.searchTextFieldText)
        }
        .frame(width: 150, height: 50)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .searchButtonBackgroundGradientStart, location: 0.1),
                    Gradient.Stop(color: .searchButtonBackgroundGradientEnd, location: 0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.9)
        )
        .border(.searchButtonBorder, width: 1)
    }
}

#Preview {
    SearchButton()
}
