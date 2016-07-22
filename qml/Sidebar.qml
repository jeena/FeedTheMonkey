/*
 * This file is part of FeedTheMonkey.
 *
 * Copyright 2015 Jeena
 *
 * FeedTheMonkey is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FeedTheMonkey is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FeedTheMonkey.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import TTRSS 1.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3

ScrollView {
    id: item

    property Server server
    property Content content
    property Post previousPost
    property int textFontSize: 14
    property bool nightmode

    style: ScrollViewStyle {
        transientScrollBars: true
    }

    function next() {
        if(listView.count > listView.currentIndex) {
            listView.currentIndex++;
        }
    }

    function previous() {
        if(listView.currentIndex > 0) {
            listView.currentIndex--;
        }
    }

    ListView {
        id: listView

        focus: true
        anchors.fill: parent
        spacing: 1
        model: item.server.posts

        delegate: Component {
            PostListItem {
                textFontSize: item.textFontSize
                nightmode: app.nightmode
                width: listView.width
            }
        }

        highlightFollowsCurrentItem: false
        highlight: Component {
            Rectangle {
                width: listView.currentItem.width
                height: listView.currentItem.height
                color: nightmode ? "#222" : "lightblue"
                opacity: 0.5
                y: listView.currentItem.y
            }
        }

        onCurrentItemChanged: {
            if(previousPost) {
                if(!previousPost.dontChangeRead) {
                    previousPost.read = true;
                } else {
                    previousPost.dontChangeRead = false;
                }
            }

            item.content.post = server.posts[currentIndex]
            //content.flickableItem.contentY = 0

            previousPost = item.content.post
        }
    }
}
