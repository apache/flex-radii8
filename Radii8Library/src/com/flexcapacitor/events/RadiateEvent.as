////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package com.flexcapacitor.events {
	import com.flexcapacitor.tools.ITool;
	
	import flash.events.Event;
	
	import mx.states.AddItems;
	
	/**
	 * Handles Radiate events. 
	 * Need to refactor. 
	 * */
	public class RadiateEvent extends Event {
		
		/**
		 * Dispatched when an asset is removed
		 * */
		public static const ASSET_REMOVED:String = "assetRemoved";
		
		/**
		 * Dispatched when an asset is added
		 * */
		public static const ASSET_ADDED:String = "assetAdded";
		
		/**
		 * Dispatched when the login results are received
		 * */
		public static const LOGIN_RESULTS:String = "loginResults";
		
		/**
		 * Dispatched when the logout results are received
		 * */
		public static const LOGOUT_RESULTS:String = "logoutResults";
		
		/**
		 * Dispatched when the register results are received
		 * */
		public static const REGISTER_RESULTS:String = "registerResults";
		
		/**
		 * Dispatched when the change password results are received
		 * */
		public static const CHANGE_PASSWORD_RESULTS:String = "changePasswordResults";
		
		/**
		 * Dispatched when the lost password results are received
		 * */
		public static const LOST_PASSWORD_RESULTS:String = "lostPasswordResults";
		
		/**
		 * Dispatched when the project is created
		 * */
		public static const PROJECT_CREATED:String = "projectCreated";
		
		/**
		 * Dispatched when the project is deleted
		 * */
		public static const PROJECT_DELETED:String = "projectDeleted";
		
		/**
		 * Dispatched when the project is added
		 * */
		public static const PROJECT_ADDED:String = "projectAdded";

		/**
		 * Dispatched when the project is removed
		 * */
		public static const PROJECT_REMOVED:String = "projectRemoved";

		/**
		 * Dispatched when the project is closing
		 * */
		public static const PROJECT_CLOSING:String = "projectClosing";

		/**
		 * Dispatched when the project is opened
		 * */
		public static const PROJECT_OPENED:String = "projectOpened";

		/**
		 * Dispatched when the project is closed
		 * */
		public static const PROJECT_CLOSED:String = "projectClosed";
		
		/**
		 * Dispatched when the projects are set
		 * */
		public static const PROJECTS_SET:String = "projectsSet";
		
		/**
		 * Dispatched when the project is changed
		 * */
		public static const PROJECT_CHANGE:String = "projectChange";
		
		/**
		 * Dispatched when the project is saved
		 * */
		public static const PROJECT_SAVED:String = "projectSaved";
		
		/**
		 * Dispatched when a list of projects are received
		 * */
		public static const PROJECTS_LIST_RECEIVED:String = "projectsListReceived";
		
		/**
		 * Dispatched when the project name is changed
		 * */
		public static const PROJECT_RENAME:String = "projectRename";
		
		/**
		 * Dispatched when the document name is changed
		 * */
		public static const DOCUMENT_RENAME:String = "documentRename";

		/**
		 * Dispatched when the document is removed
		 * */
		public static const DOCUMENT_REMOVED:String = "documentRemoved";
		
		/**
		 * Dispatched when the document is deleted
		 * */
		public static const DOCUMENT_DELETED:String = "documentDeleted";
		
		/**
		 * Dispatched when the document is added
		 * */
		public static const DOCUMENT_ADDED:String = "documentAdded";
		
		/**
		 * Dispatched when the document save is complete
		 * */
		public static const DOCUMENT_SAVE_COMPLETE:String = "documentSaveComplete";
		
		/**
		 * Dispatched when the document save is not complete
		 * */
		public static const DOCUMENT_SAVE_FAULT:String = "documentSaveFault";
		
		/**
		 * Dispatched when the document save as is canceled
		 * */
		public static const DOCUMENT_SAVE_AS_CANCEL:String = "documentSaveAsCancel";
		
		/**
		 * Dispatched when the document is changed
		 * */
		public static const DOCUMENT_CHANGE:String = "documentChange";
		
		/**
		 * Dispatched when the documents are set
		 * */
		public static const DOCUMENTS_SET:String = "documentsSet";
		
		/**
		 * Dispatched when the document is opening
		 * */
		public static const DOCUMENT_OPENING:String = "documentOpening";
		
		/**
		 * Dispatched when the document is open
		 * */
		public static const DOCUMENT_OPEN:String = "documentOpen";
		
		/**
		 * Dispatched when the canvas is changed
		 * */
		public static const CANVAS_CHANGE:String = "canvasChange";
		
		/**
		 * Dispatched when attachments are received
		 * */
		public static const ATTACHMENTS_RECEIVED:String = "attachmentsReceived";
		
		/**
		 * Dispatched when attachment is uploaded
		 * */
		public static const ATTACHMENT_UPLOADED:String = "attachmentUploaded";
		
		/**
		 * Dispatched when logged in status is received
		 * */
		public static const LOGGED_IN_STATUS:String = "loggedInStatus";
		
		/**
		 * Dispatched when the target is changed
		 * */
		public static const TARGET_CHANGE:String = "targetChange";
		
		/**
		 * Dispatched when a preview is requested
		 * */
		public static const REQUEST_PREVIEW:String = "requestPreview";
		
		/**
		 * Dispatched when a property is selected
		 * */
		public static const PROPERTY_SELECTED:String = "propertySelected";
		
		/**
		 * Dispatched when a color is selected
		 * */
		public static const COLOR_SELECTED:String = "colorSelected";
		
		/**
		 * Dispatched when a color is previewed before color selected event.
		 * */
		public static const COLOR_PREVIEW:String = "colorPreview";
		
		/**
		 * Dispatched when the generated code is updated
		 * */
		public static const CODE_UPDATED:String = "codeUpdated";
		
		/**
		 * Dispatched when an item (usually a display object) is added
		 * */
		public static const ADD_ITEM:String = "addItem";
		
		/**
		 * Dispatched when an item (usually a display object) is moved
		 * */
		public static const MOVE_ITEM:String = "moveItem";
		
		/**
		 * Dispatched when an item (usually a display object) is removed
		 * */
		public static const REMOVE_ITEM:String = "removeItem";
		
		/**
		 * Dispatched when an object is selected
		 * */
		public static const OBJECT_SELECTED:String = "objectSelected";
		
		/**
		 * Dispatched when a property on the target is changed
		 * */
		public static const PROPERTY_CHANGED:String = "propertyChanged";
		
		/**
		 * Dispatched when a property edit is requested
		 * */
		public static const PROPERTY_EDIT:String = "propertyEdit";
		
		/**
		 * Dispatched when at the beginning of the undo history stack
		 * */
		public static const BEGINNING_OF_UNDO_HISTORY:String = "beginningOfUndoHistory";
		
		/**
		 * Dispatched when at the end of the undo history stack
		 * */
		public static const END_OF_UNDO_HISTORY:String = "endOfUndoHistory";
		
		/**
		 * Dispatched when history is changed.
		 * */
		public static const HISTORY_CHANGE:String = "historyChange";
		
		/**
		 * Dispatched when document scale is changed.
		 * */
		public static const SCALE_CHANGE:String = "scaleChange";
		
		/**
		 * Dispatched when document size or scale is changed.
		 * */
		public static const DOCUMENT_SIZE_CHANGE:String = "documentSizeChange";
		
		/**
		 * Dispatched when the tool is changed.
		 * */
		public static const TOOL_CHANGE:String = "toolChange";
		
		/**
		 * Dispatched when the tools list is updated.
		 * */
		public static const TOOLS_UPDATED:String = "toolsUpdated";
		
		/**
		 * Dispatched when print job is cancelled.
		 * */
		public static const PRINT_CANCELLED:String = "printCancelled";
		
		/**
		 * Dispatched when print job is complete or sent to the printer.
		 * */
		public static const PRINT_COMPLETE:String = "printComplete";
		
		
		public var data:Object;
		public var selectedItem:Object;
		public var property:String;
		public var properties:Array;
		public var changes:Array;
		public var value:*;
		public var multipleSelection:Boolean;
		public var addItemsInstance:AddItems;
		public var moveItemsInstance:AddItems;
		public var newIndex:int;
		public var oldIndex:int;
		public var historyEventItem:HistoryEventItem;
		public var targets:Array;
		public var tool:ITool;
		public var previewType:String;
		public var openInBrowser:Boolean;
		public var color:uint;
		public var invalid:Boolean;
		public var isRollOver:Boolean;
		public var scaleX:Number;
		public var scaleY:Number;
		public var status:String;
		public var successful:Boolean;
		public var faultEvent:Event;
		
		/**
		 * Constructor. This is not up to date.
		 * */
		public function RadiateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, 
									 target:Object=null, changes:Array=null, properties:Array=null, 
									 value:*=null, multipleSelection:Boolean = false, tool:ITool = null) {
			super(type, bubbles, cancelable);
			
			this.selectedItem = target;
			this.properties = properties;
			this.changes = changes;
			this.value = value;
			this.multipleSelection = multipleSelection;
			this.tool = tool;
			
			// not kept up
		}
		
		/**
		 * This is not up to date.
		 * */
		override public function clone():Event {
			throw new Error("do this");
			return new RadiateEvent(type, bubbles, cancelable, selectedItem, changes, properties, value, multipleSelection, tool);
		}
		
		
		
	}
}