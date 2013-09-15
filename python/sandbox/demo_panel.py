import wx
import  wx.lib.scrolledpanel as scrolled

class NavPanel(wx.Panel):
    """"""
    def __init__(self, parent, actionPanel):
        """Constructor"""
        wx.Panel.__init__(self, parent) #, size=(200,600))
        self.actionPanel = actionPanel
        self.SetBackgroundColour("Yellow")

class ActionPanel(wx.Panel):
    """"""
    def __init__(self, parent, target_item=None):
        """Constructor"""
        wx.Panel.__init__(self, parent)
        self.SetBackgroundColour("Green")

        self.sc = NestedScrolledActionPanel(self)

        sizer = wx.BoxSizer(wx.HORIZONTAL)
        sizer.Add(self.sc, 1, wx.EXPAND)
        self.SetSizer(sizer)

    def show_child(self):
        # Putting a sizer here doesn't work either...
        self.sc.Show()


class NestedScrolledActionPanel(wx.ScrolledWindow):
    """"""
    def __init__(self, parent, target_item=None):
        """Constructor"""
        wx.ScrolledWindow.__init__(self, parent)
        self.SetBackgroundColour("Purple")

        # I don't want to show this at starutp, but hiding it causes the sizer to startup at 20x20!
        # Comment out this line and the sizer set in ActionPanel works, but you see it at startup
        self.Hide()       

class ConsolePanel(scrolled.ScrolledPanel): 
    """"""
    def __init__(self, parent):
        """Constructor"""

        scrolled.ScrolledPanel.__init__(self, parent, -1)
        self.SetBackgroundColour("Blue")

class MainPanel(wx.Panel):
    """"""
    def __init__(self, parent):
        """Constructor"""
        wx.Panel.__init__(self, parent)

        mainSplitter = wx.SplitterWindow(self)
        topSplitter = wx.SplitterWindow(mainSplitter)

        self.rightPanel = ActionPanel(topSplitter)
        self.rightPanel.SetBackgroundColour("Green")

        leftPanel = NavPanel(topSplitter, self.rightPanel)
        leftPanel.SetBackgroundColour("Yellow")

        topSplitter.SplitVertically(leftPanel, self.rightPanel, sashPosition=0)
        topSplitter.SetMinimumPaneSize(200)

        bottomPanel = ConsolePanel(mainSplitter)

        mainSplitter.SplitHorizontally(topSplitter, bottomPanel, sashPosition=400)
        mainSplitter.SetSashGravity(1)

        sizer = wx.BoxSizer(wx.HORIZONTAL)
        sizer.Add(mainSplitter, 1, wx.EXPAND)
        self.SetSizer(sizer)

        return


########################################################################
class MainFrame(wx.Frame):
    """"""
    def __init__(self):
        """Constructor"""

        wx.Frame.__init__(self, None, title="Sizer Test",
                          size=(800,600))

        self.panel = MainPanel(self)

        self.Centre()
        self.Show()

        self.timer = wx.Timer(self)
        self.Bind(wx.EVT_TIMER, self.OnTimer, self.timer)
        self.timer.Start(2000)

    def OnTimer(self, e):
        self.panel.rightPanel.show_child()

if __name__ == '__main__':
    app = wx.App(redirect=False)
    print "Launching frame"
    frame = MainFrame()
    print "starting mainloop"
    app.MainLoop()