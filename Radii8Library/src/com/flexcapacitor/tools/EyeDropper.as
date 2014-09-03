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

package com.flexcapacitor.tools {
	import com.flexcapacitor.controller.Radiate;
	import com.flexcapacitor.events.RadiateEvent;
	import com.flexcapacitor.model.IDocument;
	import com.flexcapacitor.utils.DisplayObjectUtils;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import mx.core.EventPriority;
	
	[Event(name="rollOver", type="flash.events.MouseEvent")]
	[Event(name="rollOut", type="flash.events.MouseEvent")]
	[Event(name="mouseMove", type="flash.events.MouseEvent")]
	
	/**
	 * Gets the color under the pointer. 
	 * 
	 * */
	public class EyeDropper extends EventDispatcher implements ITool {
		
		
		public function EyeDropper() {
			
		}
		
		[Embed(source="assets/icons/tools/EyeDropper.png")]
		private var _icon:Class;
		
		public function get icon():Class {
			return _icon;
		}
		
		[Embed(source="assets/icons/tools/EyeDropperCursor.png")]
		public static const Cursor:Class;
		
		public var cursors:Array;
		public var radiate:Radiate;
		public var targetApplication:Object;

		private var defaultCursorID:String;
		public var isOverDocument:Boolean;
		
		/**
		 * Enable
		 * */
		public function enable():void {
			radiate = Radiate.getInstance();
			
			radiate.addEventListener(RadiateEvent.DOCUMENT_CHANGE, documentChangeHandler, false, 0, true);
			
			if (radiate.selectedDocument) {
				updateDocument(radiate.selectedDocument);
			}
			
			defaultCursorID = radiate.getMouseCursorID(this);
			
		}
	
		/**
		 * Disable 
		 * */
		public function disable():void {
			
			radiate.removeEventListener(RadiateEvent.DOCUMENT_CHANGE, documentChangeHandler);
			
			updateDocument(null);
			
		}
		
		/**
		 * Document changed update. 
		 * */
		protected function documentChangeHandler(event:RadiateEvent):void {
			updateDocument(event.selectedItem as IDocument);
			
		}
		
		public function updateDocument(document:IDocument):void {
			
			// remove listeners
			if (targetApplication) {
				targetApplication.removeEventListener(MouseEvent.CLICK, handleClick, true);
				targetApplication.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
				targetApplication.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				targetApplication.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			}
			
			targetApplication = document ? document.instance : null;
			
			// add listeners
			if (targetApplication) {
				targetApplication.addEventListener(MouseEvent.CLICK, handleClick, true, EventPriority.CURSOR_MANAGEMENT, true);
				targetApplication.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove, false, EventPriority.CURSOR_MANAGEMENT, true);
				targetApplication.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, EventPriority.CURSOR_MANAGEMENT, true);
				targetApplication.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, EventPriority.CURSOR_MANAGEMENT, true);
			}
			
		}
		
		
		/**
		 * Click handler added 
		 * */
		protected function handleClick(event:MouseEvent):void {
			
			// we are intercepting this event so we can inspect the target
			// stop the event propagation
			
			// we don't stop the propagation on touch devices so you can navigate the application
			event.stopImmediatePropagation();
			getColorUnderMouse(event.target, event, false);
		}
		
		/**
		 * Click mouse move
		 * */
		protected function handleMouseMove(event:MouseEvent):void {
			
			if (isOverDocument) {
				event.stopImmediatePropagation();
				getColorUnderMouse(event.target, event, true);
				
				// redispatch mouse move event
				dispatchEvent(event);
			}
		}
		
		
		/**
		 * Roll over handler 
		 * */
		protected function rollOverHandler(event:MouseEvent):void {
			isOverDocument = true;
			
			event.stopImmediatePropagation();
			//getColorUnderMouse(event.target, event, true);
			
			// redispatch rollover event
			dispatchEvent(event);
			
			Mouse.cursor = defaultCursorID;
		}
		
		/**
		 * Roll out handler 
		 * */
		protected function rollOutHandler(event:MouseEvent):void {
			isOverDocument = false;
			event.stopImmediatePropagation();
			
			// redispatch rollout event
			dispatchEvent(event); 
			
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		/**
		 * Get color under mouse.
		 * */
		protected function getColorUnderMouse(target:Object, event:MouseEvent, isPreview:Boolean = true):void {
			var color:Object = DisplayObjectUtils.getColorUnderMouse(event);
			var couldNotGetColor:Boolean;
			
			// if color is null we may be outside our security sandbox
			if (color==null) {
				couldNotGetColor = true;
				
				if (isPreview) {
					radiate.dispatchColorPreviewEvent(0, couldNotGetColor);
				}
				else {
					radiate.dispatchColorSelectedEvent(0, couldNotGetColor);
				}
			}
			else {
				if (isPreview) {
					radiate.dispatchColorPreviewEvent(uint(color));
				}
				else {
					radiate.dispatchColorSelectedEvent(uint(color));
					
				}
			}
			
			
		}
		
		
	}
}

