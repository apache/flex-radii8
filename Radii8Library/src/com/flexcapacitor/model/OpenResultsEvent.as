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

package com.flexcapacitor.model {
	import com.flexcapacitor.services.IWPServiceEvent;
	import com.flexcapacitor.services.ServiceEvent;
	
	import flash.events.Event;
	
	/**
	 * Indicates if open of document was successful
	 * */
	public class OpenResultsEvent extends ServiceEvent implements IWPServiceEvent {

		private var _call:String;

		/**
		 * 
		 * */
		public function get call():String {
			return _call;
		}

		public function set call(value:String):void {
			_call = value;
		}

		private var _message:String;

		/**
		 * 
		 * */
		public function get message():String {
			return _message;
		}

		public function set message(value:String):void {
			_message = value;
		}

		
		public function OpenResultsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, successful:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.successful = successful;
		}
		
		/**
		 * Indicates if open was successful
		 * */
		public var successful:Boolean;
		
		override public function clone():Event {
			return new OpenResultsEvent(type, bubbles, cancelable, successful);
		}
	}
}