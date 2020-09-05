//
//  AddTagButton.swift
//  Quards
//
//  Created by Max Fest on 17.08.20.
//

import SwiftUI

struct AddTagButton: View {
	
	@State var newTag: String = ""
	@State var showingTextField = false
	
	var saveTag: (String) -> Void
	
	var body: some View {
		Group {
			if !showingTextField {
				Button(action: {
					showingTextField = true
				}) {
					Image(systemName: "plus.circle")
				}
			} else {
				TextField("new tag...", text: $newTag, onCommit: {
					self.showingTextField = false
					self.saveTag(newTag)
					self.newTag = ""
				})
			}
		}
	}
}

struct AddTagButton_Previews: PreviewProvider {
	static var previews: some View {
		AddTagButton(saveTag: {_ in})
	}
}
