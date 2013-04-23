#!/usr/bin/env python2

import sys, os, json, tempfile, urllib2, urllib, json
from PyQt4 import QtGui, QtCore, QtWebKit, QtNetwork
from threading import Thread

settings = QtCore.QSettings("jabs.nu", "ttrssl")

class MainWindow(QtGui.QMainWindow):
	def __init__(self):
		QtGui.QMainWindow.__init__(self)
		self.setWindowIcon(QtGui.QIcon("feedmonkey"))
		self.addAction(QtGui.QAction("Full Screen", self, checkable=True, toggled=lambda v: self.showFullScreen() if v else self.showNormal(), shortcut="F11"))
		self.history = self.get("history", [])
		self.restoreGeometry(QtCore.QByteArray.fromRawData(settings.value("geometry").toByteArray()))
		self.restoreState(QtCore.QByteArray.fromRawData(settings.value("state").toByteArray()))

		self.initUI()

		session_id = self.get("session_id")
		server_url = self.get("server_url")

		if not (session_id and server_url):
			self.authenticate()
		else:
			self.initApp()

	def initUI(self):
		self.content = Content(self)
		self.setCentralWidget(self.content)

		menubar = self.menuBar()

		reloadAction = QtGui.QAction("&Reload", self)
		reloadAction.setStatusTip("Load new data")
		reloadAction.setShortcut("r")
		reloadAction.triggered.connect(self.content.reload)

		logOutAction = QtGui.QAction("&Log Out", self)
		logOutAction.setStatusTip("Log out from this entity")
		logOutAction.triggered.connect(self.logOut)

		exitAction = QtGui.QAction("&Exit", self)
		exitAction.setShortcut("Ctrl+Q")
		exitAction.setStatusTip("Exit Feed the Monkey")
		exitAction.triggered.connect(self.close)

		fileMenu = menubar.addMenu("&File")
		fileMenu.addAction(reloadAction)
		fileMenu.addAction(logOutAction)
		fileMenu.addSeparator()
		fileMenu.addAction(exitAction)

	def initApp(self):
		session_id = self.get("session_id")
		server_url = self.get("server_url")
		self.tinyTinyRSS = TinyTinyRSS(self, server_url, session_id)

		self.content.evaluateJavaScript("setArticle()")
		self.content.reload()

	def closeEvent(self, ev):
		settings.setValue("geometry", self.saveGeometry())
		settings.setValue("state", self.saveState())
		return QtGui.QMainWindow.closeEvent(self, ev)

	def put(self, key, value):
		"Persist an object somewhere under a given key"
		settings.setValue(key, json.dumps(value))
		settings.sync()

	def get(self, key, default=None):
		"Get the object stored under 'key' in persistent storage, or the default value"
		v = settings.value(key)
		return json.loads(unicode(v.toString())) if v.isValid() else default

	def setWindowTitle(self, t):
		super(QtGui.QMainWindow, self).setWindowTitle("Feed the Monkey" + t)

	def authenticate(self):
		
		dialog = Login()

		def callback():

			server_url = str(dialog.textServerUrl.text())
			user = str(dialog.textName.text())
			password = str(dialog.textPass.text())

			session_id = TinyTinyRSS.login(server_url, user, password)
			if session_id:
				self.put("session_id", session_id)
				self.put("server_url", server_url)
				self.initApp()
			else:
				self.authenticate()


		dialog.accepted.connect(callback)

		dialog.exec_()

	def logOut(self):
		self.tinyTinyRSS.logOut()
		self.tinyTinyRSS = None
		self.put("session_id", None)
		self.put("server_url", None)
		self.authenticate()



class Content(QtGui.QWidget):
	def __init__(self, container):
		QtGui.QWidget.__init__(self)

		self.app = container
		self.index = 0

		self.wb = QtWebKit.QWebView(titleChanged=lambda t: container.setWindowTitle(t))
		#self.wb.setPage(WebPage(self.wb))

		self.wb.page().setLinkDelegationPolicy(QtWebKit.QWebPage.DelegateAllLinks)
		self.wb.linkClicked.connect(lambda url: self.openLink(url))

		self.setLayout(QtGui.QVBoxLayout(spacing=0))
		self.layout().setContentsMargins(0, 0, 0, 0)
		self.layout().addWidget(self.wb)

		self.do_close = QtGui.QShortcut("Ctrl+W", self, activated=lambda: container.close())
		self.do_show_next = QtGui.QShortcut("Space", self, activated=lambda: self.showNext())
		self.do_show_previous = QtGui.QShortcut("Backspace", self, activated=lambda: self.showPrevious())
		self.do_show_previous_k = QtGui.QShortcut("k", self, activated=lambda: self.showPrevious())
		self.do_show_next_j = QtGui.QShortcut("j", self, activated=lambda: self.showNext())
		self.do_open_current = QtGui.QShortcut("Return", self, activated=lambda: self.openCurrent())
		self.do_reload = QtGui.QShortcut("r", self, activated=lambda: self.reload())

		self.do_quit = QtGui.QShortcut("Ctrl+q", self, activated=lambda: container.close())
		self.zoomIn = QtGui.QShortcut("Ctrl++", self, activated=lambda: self.wb.setZoomFactor(self.wb.zoomFactor() + 0.2))
		self.zoomOut = QtGui.QShortcut("Ctrl+-", self, activated=lambda: self.wb.setZoomFactor(self.wb.zoomFactor() - 0.2))
		self.zoomOne = QtGui.QShortcut("Ctrl+0", self, activated=lambda: self.wb.setZoomFactor(1))

		self.wb.settings().setAttribute(QtWebKit.QWebSettings.PluginsEnabled, True)
		self.wb.settings().setIconDatabasePath(tempfile.mkdtemp())
		self.wb.setHtml(self.templateString())

		self.unread_articles = []

	def openLink(self, url):
		QtGui.QDesktopServices.openUrl(url)

	def reload(self):
		self.unread_articles = self.app.tinyTinyRSS.getUnreadFeeds()
		self.index = 0
		self.setUnreadCount()
		if len(self.unread_articles) > 0:
			self.showNext()

	def showNext(self):

		if len(self.unread_articles) > self.index:
			if self.index > 0:
				previous = self.unread_articles[self.index - 1]
				self.app.tinyTinyRSS.setArticleRead(previous["id"])

			next = self.unread_articles[self.index]
			self.setArticle(next)
			self.setUnreadCount()
			self.index += 1
		else:
			if self.index > 0:
				previous = self.unread_articles[self.index - 1]
				self.app.tinyTinyRSS.setArticleRead(previous["id"])
			self.setUnreadCount()

	def showPrevious(self):
		if self.index > 0:
			self.index -= 1
			previous = self.unread_articles[self.index]
			self.setArticle(previous)
			self.setUnreadCount()

	def openCurrent(self):
		current = self.unread_articles[self.index]
		url = QtCore.QUrl(current["link"])
		self.openLink(url)

	def setArticle(self, article):
		func = u"setArticle({});".format(json.dumps(article))
		self.evaluateJavaScript(func)

	def evaluateJavaScript(self, func):
		return self.wb.page().mainFrame().evaluateJavaScript(func)

	def setUnreadCount(self):
		length = len(self.unread_articles)
		unread = length - self.index
		self.app.setWindowTitle(" (" + str(unread) + "/" + str(length) + ")")
		if unread < 1:
			self.evaluateJavaScript("setArticle()")

	def templateString(self):
		return """
<!DOCTYPE html>
<html>
<head>
	<title>ttrssl</title>
	<script type="text/javascript">
		function $(id) {
			return document.getElementById(id);
		}

		function setArticle(article) {
			window.scrollBy(0,0);

			if(article) {
				$("date").innerHTML = (new Date(parseInt(article.updated, 10) * 1000)).toLocaleString();
				$("title").innerHTML = article.title;
				$("title").href = article.link;
				$("title").title = article.link;
				$("feed_title").innerHTML = article.feed_title;
				$("author").innerHTML = "";
				if(article.author && article.author.length > 0)
					$("author").innerHTML = "&ndash; " + article.author
				$("article").innerHTML = article.content;
			} else {
				$("date").innerHTML = "";
				$("title").innerHTML = "";
				$("title").href = "";
				$("title").title = "";
				$("feed_title").innerHTML = "";
				$("author").innerHTML = "";
				$("article").innerHTML = "No unread articles found to display.";
			}
		}
	</script>
	<style type="text/css">
		body {
			font-family: "Ubuntu", "Lucida Grande","Tahoma";
			padding: 1em 2em 1em 2em;
		}
		h1 {
			font-weight: normal;
			margin: 0;
			padding: 0;
		}
		header {
			margin-bottom: 1em;
			border-bottom: 1px solid #aaa;
			padding-bottom: 1em;
		}
		header p {
			color: #aaa;
			margin: 0;
			padding: 0
		}
		a {
			color: #772953;
			text-decoration: none;
		}
		img {
			max-width: 100%;
		}
		article {
			line-height: 1.6;
		}
	</style>
</head>
<body>
	<header>
		<p><span id="feed_title"></span> <span id="author"></span></p>
		<h1><a id="title" href=""></a></h1>
		<p><timedate id="date"></timedate></p>
	</header>
	<article id="article"></article>
</body>
</html>
		"""



class TinyTinyRSS:
	def __init__(self, app, server_url, session_id):
		self.app = app
		if server_url and session_id:
			self.server_url = server_url
			self.session_id = session_id
		else:
			self.app.authenticate()

	def doOperation(self, operation, options=None):
		url = self.server_url + "/api/"
		default_options = {'sid': self.session_id, 'op': operation}
		if options:
			options = dict(default_options.items() + options.items())
		else:
			options = default_options
		json_string = json.dumps(options)
		req = urllib2.Request(url)
		fd = urllib2.urlopen(req, json_string)
		body = ""
		while 1:
			data = fd.read(1024)
			if not len(data):
				break
			body += data

		return json.loads(body)["content"]

	def getUnreadFeeds(self):
		return self.doOperation("getHeadlines", {"show_excerpt":False, "view_mode":"unread", "show_content":True, "feed_id": -3})

	def setArticleRead(self, article_id):
		l = lambda: self.doOperation("updateArticle", {'article_ids':article_id, 'mode': 0, 'field': 2})
		t = Thread(target=l)
		t.start()

	def logOut(self):
		self.doOperation("logout")

	@classmethod
	def login(self, server_url, user, password):
		url = server_url + "/api/"
		options = {"op": "login", "user": user, "password": password}
		json_string = json.dumps(options)
		req = urllib2.Request(url)
		fd = urllib2.urlopen(req, json_string)
		body = ""
		while 1:
			data = fd.read(1024)
			if not len(data):
				break
			body += data

		body = json.loads(body)["content"]

		if body.has_key("error"):
			msgBox = QtGui.QMessageBox()
			msgBox.setText(body["error"])
			msgBox.exec_()
			return None

		return body["session_id"]


class Login(QtGui.QDialog):
	def __init__(self):
		QtGui.QDialog.__init__(self)
		self.setWindowIcon(QtGui.QIcon("feedmonkey.png"))
		self.setWindowTitle("Feed the Monkey - Login")

		self.label = QtGui.QLabel(self)
		self.label.setText("Please specify a server url, a username and a password.")

		self.textServerUrl = QtGui.QLineEdit(self)
		self.textServerUrl.setPlaceholderText("http://example.com/ttrss/")
		self.textServerUrl.setText("http://")

		self.textName = QtGui.QLineEdit(self)
		self.textName.setPlaceholderText("username")

		self.textPass = QtGui.QLineEdit(self)
		self.textPass.setEchoMode(QtGui.QLineEdit.Password);
		self.textPass.setPlaceholderText("password")
		
		self.buttons = QtGui.QDialogButtonBox(QtGui.QDialogButtonBox.Ok)
		self.buttons.accepted.connect(self.accept)

		layout = QtGui.QVBoxLayout(self)
		layout.addWidget(self.label)
		layout.addWidget(self.textServerUrl)
		layout.addWidget(self.textName)
		layout.addWidget(self.textPass)
		layout.addWidget(self.buttons)


if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	wb = MainWindow()
	wb.show()
	sys.exit(app.exec_())