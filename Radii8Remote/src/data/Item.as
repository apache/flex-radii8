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

package data {
	
	[Bindable]
	[RemoteClass]
	/**
	 * Describes the remote module to load
	 * */
	public class Item {
		
		public function Item(data:XML=null) {
			if (data) {
				unmarshall(data);
			}
		}
		
		public function unmarshall(value:XML):void {
			name 			= String(value.@name);
			url 			= String(value.@url);
			type 			= String(value.@type);
			description 	= String(value.content);
			isDefault		= Boolean(value.isDefault);
		}
		
		/**
		 * Name of module
		 * */
		public var name:String;
		
		/**
		 * Description of module
		 * */
		public var description:String;
		
		/**
		 * URL to module swf
		 * */
		public var url:String;
		
		/**
		 * Type of module. Usually this is the fully qualified class name
		 * */
		public var type:String;
		
		/**
		 * Enabled. May not be applicable when using perspectives. IE some perspectives 
		 * may have this enabled and others may not.
		 * */
		public var enabled:Boolean;
		
		/**
		 * Indicates if item is enabled by default 
		 */		
		public var isDefault:Boolean;
	}
}