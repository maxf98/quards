//
//  HierarchichalTagsView.swift
//  Quards
//
//  Created by Max Fest on 02.09.20.
//

import SwiftUI

struct NodeWrapper: View {
	@EnvironmentObject var tagHierarchySelection: TagHierarchySelection
	let tagDeck: TagDeck
	var level: Int
	
	@State var expanded = false
	@State var pressing = false
		
	var body: some View {
		let isSelected = Binding<Bool>(
			get: {
				tagHierarchySelection.contains(tagDeck)
			}, set: {
				tagHierarchySelection.setSelected(tagDeck: tagDeck, isSelected: $0)
			})
		
		return HStack(spacing: 30) {
			HierarchyNode(tagDeck: tagDeck, level: level, isSelected: isSelected)
				.scaleEffect(pressing ? 1.2 : 1)
				.onTapGesture(count: 1, perform: {
					withAnimation(.linear(duration: 0.3)) {
						expanded.toggle()
					}
				})
				.onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
					withAnimation(.easeInOut(duration: 0.4)) {
						pressing = isPressing
					}
				}, perform: {
					withAnimation {
						pressing = false
						isSelected.wrappedValue = !isSelected.wrappedValue
					}})
			
			if expanded || isSelected.wrappedValue {
				VStack(alignment: .leading) {
					ForEach(tagDeck.wrappedChildren, id: \.self) { child in
						NodeWrapper(tagDeck: child, level: level + 1)
					}
				}.padding(5)
			}
		}
	}
}
