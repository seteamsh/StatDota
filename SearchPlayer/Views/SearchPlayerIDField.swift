//
//  SearchPlayerIDField.swift
//  StatDota
//
//  Created by Temirlan Zhumashov on 28.03.2026.
//

import SwiftUI

struct SearchPlayerIDField: View {
    @Binding var id: String
    var body: some View {
        TextField(text: $id) {
            Text("Поиск по ID")
                .foregroundStyle(.searchPlacehoderForegroundStyle)
            
        }
        .frame(height: 60)
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .font(.title2)
        .background(.black)
        .border(.searchTextFieldBorder, width: 2)
    }
}

#Preview {
    SearchPlayerIDField(id: .constant("117124649"))
}
