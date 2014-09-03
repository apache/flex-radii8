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

package com.flexcapacitor.logging {
	import mx.core.mx_internal;
	import mx.logging.targets.LineFormattedTarget;
	
	use namespace mx_internal;
	
	/**
	 * Logging target
	 * */
	public class RadiateLogTarget extends LineFormattedTarget {
		
		
		public function RadiateLogTarget(console:Object = null) {
			super();
			
			this.console = console;
		}
		
		private var _console:Object;
		
		public var messages:String = "";
		
		public var storedMessages:String = "";
		
		public var fallBackToTraceConsole:Boolean = true;
	
		/**
		 * Store messages 
		 * */
		public var storeMessages:Boolean = false;
		
		/**
		 * Shows messages deferred until console is created
		 * */
		public var showDeferredMessages:Boolean = true;
		
		[Bindable]
		public function get console():Object {
			return _console;
		}

		public function set console(value:Object):void {
			if (_console == value) return;
			
			_console = value;
			
			if (value && showDeferredMessages && storedMessages) {
				internalLog (storedMessages);
			}
		}

		override mx_internal function internalLog(message : String) : void {
			var shortMessage:String = message + "\n";
			
			if (console) {
				//console.text += shortMessage;
				console.appendText(shortMessage);
			}
			else {
				storedMessages += shortMessage;
				
				if (fallBackToTraceConsole) {
					trace(message);
				}
			}
			
			if (storedMessages) {
				messages += shortMessage;
			}
		}
	}
}
