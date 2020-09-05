//
//  ChildrenView.swift
//  Quards
//
//  Created by Max Fest on 31.08.20.
//

import SwiftUI

struct ChildrenView: View {
	
	@ObservedObject var tagDeck: TagDeck
	@Binding var selectedChild: Int?
	var createDeck: () -> Void
	
	var body: some View {
		
		return VStack {
			ForEach(tagDeck.wrappedChildren, id: \.id) { child in
				if showingChild(child) {
					TagDecksView(tagDeck: child, isSelected: bindingForChild(child: child))
						.frame(maxWidth: .infinity)
						.padding(selectedChild == nil ? 15 : 0)
						.transition(AnyTransition.slide.animation(.linear(duration: 1)))
				}
			}
			
			if selectedChild == nil {
				Button(action: {
					createDeck()
				}) {
					AddEntityButton()
						.foregroundColor(Color(tagDeck.complementaryColor))
						.frame(height: 80)
						.padding()
				}
			}
		}
	}
}

extension ChildrenView {
	func bindingForChild(child: TagDeck) -> Binding<Bool> {
		guard let index = tagDeck.wrappedChildren.firstIndex(of: child) else {
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
		return selectedChild == nil || selectedChild == tagDeck.wrappedChildren.firstIndex(of: child)
	}
}
