//
//  TabBarView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var body: some View {
        TabView {
            BoardRoomView()
                .tabItem {
                    Image(systemName: "door.right.hand.open")
                    Text("Boardroom")
                }
            
            TasksView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Taskspace")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
