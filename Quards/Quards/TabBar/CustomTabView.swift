//
//  TabView.swift
//  Quards
//
//  Created by Max Fest on 21.08.20.
//

import SwiftUI

struct CustomTabView: View {
	@EnvironmentObject var tabController: TabBarController
	
	var body: some View {
		HStack(spacing: 45) {

			TabItem(tab: .overview)

			TabItem(tab: .review)
			
			//TabItem(tab: .network)
		}
		.frame(maxWidth: .infinity)
		.background(
			Color(.gray)
				.edgesIgnoringSafeArea(.bottom)
		)
	}
}

struct TabItem: View {
	@EnvironmentObject var tabController: TabBarController
	var tab: TabBarController.Tab
	
	var body: some View {
		Button(action: {
			self.tabController.selectedTag = tab
		}) {
			tab.img
				.resizable()
				.scaledToFit()
				.foregroundColor(.white)
				.frame(width: 35, height: 35)
				.padding()
		}
		.buttonStyle(PlainButtonStyle())
	}
}

struct TabView_Previews: PreviewProvider {
	static var previews: some View {
		CustomTabView()
	}
}
