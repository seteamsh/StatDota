import SwiftUI

struct SearchPlayerScreen: View {
    
    @ObservedObject var vm: SearchPlayerViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                Text("Добавить в друзья")
                    .font(.title)
                    .foregroundStyle(.searchTextFieldAddFriend)
                
                ProfileField(profile: vm.profile, errorMessage: vm.errorMessage)
                
                SearchPlayerIDField(id: $vm.searchID)
                
                HStack(spacing: 0) {
                    Button {
                        vm.searchPlayer()
                    } label: {
                        SearchButton(text: "Поиск".uppercased())
                    }
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        SearchButton(text: "Отмена".uppercased())
                    }
                }
                
                Spacer()
            }
            .padding(40)
            .background(
                .linearGradient(
                    colors: [
                        .searchScreenBottonBackground,
                        .searchScreenMiddleBackground,
                        .searchScreenTopBackground
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
    }
}

#Preview {
    SearchPlayerScreen(
        vm: SearchPlayerViewModel(profileRequest: APIRequest(resource: ProfileResource()))
    )
}
