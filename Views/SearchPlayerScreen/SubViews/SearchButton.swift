//
//  SearchButton.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 23.11.2025.
//

import SwiftUI

struct SearchButton: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .frame(width: 150, height: 50)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .searchButtonBackgroundGradientStart, location: 0.05),
                        Gradient.Stop(color: .searchButtonBackgroundGradientMiddle, location: 0.5),
                        Gradient.Stop(color: .searchButtonBackgroundGradientEnd, location: 1)
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
    SearchButton(text: "Поиск")
}
