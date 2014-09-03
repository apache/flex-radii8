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


package components
{
    import flash.events.FocusEvent;
    
    import mx.managers.FocusManager;
    
    import spark.components.Scroller;
	
	/**
	 * Gets rid of focusmanager scroller bug
	 * https://bugs.adobe.com/jira/browse/SDK-29522
	 * */
    public class MyScroller extends MyScroller
    {
        public function MyScroller()
        {
            super();
        }

        override protected function focusInHandler(event:FocusEvent):void
        {
            if(FocusManager != null) {
                super.focusInHandler(event);
            }
        }
    }
}
