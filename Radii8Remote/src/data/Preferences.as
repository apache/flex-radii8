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
	public class Preferences {
		
		public function Preferences(data:XML=null) {
			if (data) {
				unmarshall(data);
			}
		}
		
		public function unmarshall(value:XML):void {
			name = String(value.@name);
			url = String(value.@url);
		}
		
		/**
		 * 
		 */		
		public var name:String;
		
		/**
		 * Location of views, tools and shortcut items XML 
		 **/		
		public var url:String;
		
		/**
		 * Not applicable
		 * */
		public var type:Class;
		
		/**
		 * Default perspective
		 * */		
		public var defaultPerspective:Perspective;
		
		/**
		 * Selected perspective
		 * */		
		public var selectedPerspective:Perspective;
		
		/**
		 * List of perspectives
		 */		
		public var perspectives:Array = [];
	}
}