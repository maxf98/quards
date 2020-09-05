//
//  Overview.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//

import SwiftUI

struct Overview: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@EnvironmentObject var tabController: TabBarController
	
	@FetchRequest (entity: TagDeck.entity(), sortDescriptors: [
									NSSortDescriptor(keyPath: \TagDeck.createdAt, ascending: true)],
								 predicate: NSPredicate(format: "%K == nil", (\TagDeck.parent)._kvcKeyPathString!)) var roots: FetchedResults<TagDeck>
	
	@State var selectedChild: Int?
	
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.all)
				.onTapGesture {
					withAnimation {
						tabController.hideTabBar.toggle()
					}
				}
		
			RootsView(selectedChild: $selectedChild)
				.frame(maxHeight: .infinity)
				.onChange(of: selectedChild, perform: {
					if $0 != nil {
						tabController.hideTabBar = true
					}
				})
		}
	}
}

struct Overview_Previews: PreviewProvider {
	static var previews: some View {
		Overview()
	}
}
