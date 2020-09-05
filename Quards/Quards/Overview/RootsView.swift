//
//  RootsView.swift
//  Quards
//
//  Created by Max Fest on 01.09.20.
//

import SwiftUI

struct RootsView: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@FetchRequest (entity: TagDeck.entity(), sortDescriptors: [
									NSSortDescriptor(keyPath: \TagDeck.createdAt, ascending: true)],
								 predicate: NSPredicate(format: "%K == nil", (\TagDeck.parent)._kvcKeyPathString!)) var roots: FetchedResults<TagDeck>
	
	@Binding var selectedChild: Int?
	
	var body: some View {
		
		return VStack {
			ForEach(roots, id: \.self) { child in
				if showingChild(child) {
					TagDecksView(tagDeck: child, isSelected: bindingForChild(child))
						.frame(maxWidth: .infinity)
						.padding(selectedChild == nil ? 15 : 0)
				}
			}
			
			if selectedChild == nil {
				Button(action: {
					let newDeck = quardsModel.createTagDeck(parent: nil)
					withAnimation {
						selectedChild = roots.firstIndex(of: newDeck)
					}
				}) {
					AddEntityButton()
						.frame(height: 80)
						.padding()
				}
			}
		}
	}
}

extension RootsView {
	func bindingForChild(_ child: TagDeck) -> Binding<Bool> {
		guard let index = roots.firstIndex(of: child) else {
			return Binding<Bool>(
				get: {
					return false
				}, set: { _ in })
		}
		return Binding<Bool>(
			get: {
				selectedChild == index
			}, set: {
				selectedChild = $0 ? index : nil
			}
		)
	}
	
	func showingChild(_ child: TagDeck) -> Bool {
		return selectedChild == nil || selectedChild == roots.firstIndex(of: child)
	}
}

