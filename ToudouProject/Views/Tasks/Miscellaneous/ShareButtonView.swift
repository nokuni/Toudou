//
//  ShareButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct ShareButtonView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    private let url = URL(string: "https://www.google.com")!
    var body: some View {
        HStack {
            ShareLink(item: "https://www.toudou.com/") {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up.fill")
                }
                .fontWeight(.semibold)
                .foregroundColor(.yingYang)
                .padding()
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
                .background(Color.accentColor.cornerRadius(10))
            }
        }
        .padding(.horizontal)
    }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView()
    }
}
