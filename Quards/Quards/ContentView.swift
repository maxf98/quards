//
//  ContentView.swift
//  Quards
//
//  Created by Max Fest on 02.08.20.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var tabController: TabBarController
	@EnvironmentObject var quardsModel: QuardsModel
	
	var body: some View {
		VStack {
			switch tabController.selectedTag {
			case .overview:
				Overview()
			case .review:
				ReviewView(reviewData: ReviewData(coreDataStack: quardsModel.coreDataStack))
			case .network:
				EmptyView()
			}
			
			if !tabController.hideTabBar {
				CustomTabView()
					.transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
			}
		}
	}
}
	
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
