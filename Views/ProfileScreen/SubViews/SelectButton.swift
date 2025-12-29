//
//  SelectButton.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 15.12.2025.
//

import SwiftUI

struct SelectButton: View {
    @State var isSelected: Bool = true
    var buttonName: String
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonName)
                .font(.title3)
                .foregroundStyle(.white)
                .padding(5)
                .background(isSelected ? Color.cayenne : Color.gray.opacity(0.3))
                .clipShape(.buttonBorder)
        }
    }
}

#Preview {
    SelectButton(buttonName: "Heroes", action: {})
}
