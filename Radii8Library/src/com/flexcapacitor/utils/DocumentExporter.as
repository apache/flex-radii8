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

package com.flexcapacitor.utils {
	import com.flexcapacitor.events.HistoryEvent;
	import com.flexcapacitor.events.HistoryEventItem;
	import com.flexcapacitor.model.IDocument;
	import com.flexcapacitor.utils.supportClasses.ComponentDescription;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Exports document 
	 * */
	public class DocumentExporter {
		
		/**
		 * Constructor
		 * */
		public function DocumentExporter() {
			
		}
		
		private var _isValid:Boolean;

		/**
		 * Indicates if the XML validation
		 * */
		[Bindable]
		public function get isValid():Boolean {
			return _isValid;
		}

		/**
		 * @private
		 */
		public function set isValid(value:Boolean):void {
			_isValid = value;
		}

		
		private var _error:Error;

		/**
		 * Validation error
		 * */
		[Bindable]
		public function get error():Error {
			return _error;
		}

		/**
		 * @private
		 */
		public function set error(value:Error):void {
			_error = value;
		}

		
		private var _errorMessage:String;

		/**
		 * Validation error message
		 * */
		[Bindable]
		public function get errorMessage():String {
			return _errorMessage;
		}

		/**
		 * @private
		 */
		public function set errorMessage(value:String):void {
			_errorMessage = value;
		}

		
		private var _errors:Array = [];
		
		/**
		 * Error messages
		 * */
		[Bindable]
		public function get errors():Array {
			return _errors;
		}

		/**
		 * @private
		 */
		public function set errors(value:Array):void {
			_errors = value;
		}

		private var _warnings:Array = [];

		/**
		 * Warning messages
		 * */
		[Bindable]
		public function get warnings():Array {
			return _warnings;
		}

		/**
		 * @private
		 */
		public function set warnings(value:Array):void {
			_warnings = value;
		}
		
		
		public var target:Object;
		
		
		/**
		 * Get an object that contains the properties that have been set on the component.
		 * This does this by going through the history events and checking the changes.
		 * 
		 * WE SHOULD CHANGE THIS
		 * */
		public function getAppliedPropertiesFromHistory(document:IDocument, component:ComponentDescription, addToProperties:Boolean = true):Object {
			var historyIndex:int = document.historyIndex;
			var historyEvent:HistoryEventItem;
			var historyItem:HistoryEvent;
			var history:ArrayCollection;
			var historyEvents:Array;
			var eventsLength:int;
			var propertiesObject:Object;
			var stylesObject:Object;
			var properties:Array;
			var styles:Array;
			
			history = document.history;
			propertiesObject = {};
			stylesObject = {};
			
			if (history.length==0) return propertiesObject;
			
			// go back through the history of changes and 
			// add the properties that have been set to an object
			for (var i:int=historyIndex+1;i--;) {
				historyItem = history.getItemAt(i) as HistoryEvent;
				historyEvents = historyItem.historyEventItems;
				eventsLength = historyEvents.length;
				
				for (var j:int=0;j<eventsLength;j++) {
					historyEvent = historyEvents[j] as HistoryEventItem;
					properties = historyEvent.properties;
					styles = historyEvent.styles;
		
					if (historyEvent.targets.indexOf(component.instance)!=-1) {
						for each (var property:String in properties) {
							
							if (property in propertiesObject) {
								continue;
							}
							else {
								propertiesObject[property] = historyEvent.propertyChanges.end[property];
							}
						}
						
						for each (var style:String in styles) {
							
							if (style in stylesObject) {
								continue;
							}
							else {
								stylesObject[style] = historyEvent.propertyChanges.end[style];
							}
						}
					}
					
				}
			}
			
			component.properties = propertiesObject;
			component.styles = stylesObject;
			
			return propertiesObject;
		}
	}
}