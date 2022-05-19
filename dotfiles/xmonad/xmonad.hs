{-# LANGUAGE FlexibleContexts #-}
-- Base
import XMonad
import System.Exit (exitSuccess)
import XMonad.StackSet (RationalRect(..), StackSet)
import qualified XMonad.StackSet as W
import Data.List
import Data.Maybe ( isNothing, fromJust)
import qualified Data.Set as S
import GHC.IO.Handle (hGetLine)

-- Actions
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies, copy)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmhDesktopsEventHook, fullscreenEventHook, ewmhDesktopsLogHook, ewmh)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, docks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doRectFloat, isDialog, isInProperty)

  
-- Layouts
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout (Full)

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.MultiToggle (mkToggle, single, Toggle(..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL))
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.Layout.Hidden (hiddenWindows, hideWindow, popNewestHiddenWindow)
import XMonad.Layout.SubLayouts (onGroup, pullGroup, GroupMsg(..), Sublayout, subLayout)
import XMonad.Layout.BoringWindows (boringWindows)
import XMonad.Layout.WindowNavigation (windowNavigation, Direction2D(..))
import XMonad.Layout.TabBarDecoration (tabBar)
import XMonad.Layout.Tabbed (Theme(..), TabbedDecoration, addTabs)

import XMonad.Layout.Simplest
import XMonad.Layout.Decoration
  
-- Utilities
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Dmenu
import XMonad.Util.WorkspaceCompare (getSortByIndex)
import XMonad.Actions.Commands

-- To Try Out
-- import XMonad.Layout.MouseResizableTile
-- import XMonad.Layout.Groups (ALL)
-- import XMonad.Util.ExclusiveScratchpads
-- import XMonad.Util.DynamicScratchpads
-- import XMonad.Util.ActionCycle
-- import XMonad.Actions.FloatSnap
import XMonad.Actions.DynamicWorkspaces
-- import XMonad.Actions.SwapWorkspaces
-- import XMonad.Actions.WorkspaceOrder
-- import XMonad.Actions.FloatKeys
-- import XMonad.Actions.WorkspaceNames

singleLineDmenu :: String -> IO String
singleLineDmenu prompt = menuArgs "dmenu" ["-p", prompt, "-l", "0"] []

forcedDmenu :: String -> [String] -> IO String
forcedDmenu prompt choices = menuArgs "dmenu" ["-only-match"] choices

workspaceDmenu :: String -> (String -> X ()) -> X ()
workspaceDmenu prompt job = do ws <- gets (W.workspaces . windowset)
                               sort <- getSortByIndex
                               let ts = map W.tag $ sort ws
                               liftIO (forcedDmenu prompt ts) >>= job :: X ()

-- selectWorkspaceD :: X ()
-- selectWorkspaceD = workspaceDmenu "Select Workspace" W.greedyView

myXMessage :: String
myXMessage = "xmessage -default okay -bg black -fg white"

myTabConfig = def { inactiveColor       = "#222222"
                  , inactiveBorderColor = "#222222"
                  , inactiveTextColor   = "#cccccc"
                  , activeColor         = "#555555"
                  , activeBorderColor   = "#555555"
                  , activeTextColor     = "#ffffff"
                  , urgentColor         = "#111111"
                  , urgentBorderColor   = "#111111"
                  , urgentTextColor     = "#cc0000"
                  , fontName = "xft:RobotoMono Nerd Font:size=10:weight=bold"
                  , decoHeight = 35
                  , decoWidth  = 90
                  }
subTabbed :: (Eq a, LayoutModifier
              (Sublayout Simplest) a,
              LayoutClass l a) =>
    l a -> ModifiedLayout (Decoration TabbedDecoration DefaultShrinker)
                          (ModifiedLayout (Sublayout Simplest) l) a
subTabbed x = addTabs shrinkText myTabConfig $ subLayout [] Simplest x

tall         = limitWindows 6
             $ avoidStruts
             $ subTabbed
             $ spacingWithEdge 30
             $ mkToggle (single NBFULL)
             $ ResizableTall 1 (3/100) (1/2) []
             -- $ mouseResizableTile{ draggerType = FixedDragger }

full         = Full

myLayoutHook = noBorders $ windowNavigation $ boringWindows $ hiddenWindows $ tall ||| full

scratchpads :: [NamedScratchpad]
scratchpads = [
  NS "terminal" "alacritty -t ScratchT"
     (title =? "ScratchT")
     (customFloating $ RationalRect 0.05 0.05 0.9 0.9),
  NS "spotify" "psst-gui"
     (className =? "Psst-gui")
     (customFloating $ RationalRect 0.05 0.05 0.9 0.9)
  ]

myManageHook = composeAll
    [ isFullscreen                  --> doFullFloat
    , isInProperty "_NET_WM_WINDOW_TYPE" "NET_WM_WINDOW_TYPE_DIALOG"
      --> doFloat
    
    -- Picture in Picture (Firefox)
    , title =? "Picture-in-Picture"
      --> doRectFloat (RationalRect 0.70 0.07 0.25 0.25)
      <+> doF copyToAll
      -- <+> spawn "picom-trans -t -c 100"

    -- XMessage
    , className =? "Xmessage"
      --> doRectFloat (RationalRect (1/6) (1/6) (2/3) (2/3))
    
    -- Misc
    , className =? "live-subtitles"  --> doFloat
    , className =? "confirm"        --> doFloat
    , className =? "file_progress"  --> doFloat
    , className =? "dialog"         --> doFloat
    , className =? "download"       --> doFloat 
    , className =? "error"          --> doFloat 
    , className =? "Gimp"           --> doFloat 
    , className =? "notification"   --> doFloat 
    , className =? "pinentry-gtk-2" --> doFloat 
    , className =? "splash"         --> doFloat 
    , className =? "toolbar"        --> doFloat 
    , resource  =? "download"       --> doIgnore
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat 
    ] <+> namedScratchpadManageHook scratchpads

-- Keybindings to remove
myKeysR = [("M-p"), ("M-S-<return>"), ("M-e"), ("M-S-p")]
  
myKeys :: [(String, X ())]
myKeys = [
  -- Xmonad --
  ("M-q", spawn "xmonad --recompile; xmonad --restart")
  , ("M-S-q", io exitSuccess)

  -- Scratch Pads --
  , ("M-C-t", namedScratchpadAction scratchpads "terminal")
  , ("M-C-s", namedScratchpadAction scratchpads "spotify")
  
  -- Change Focus --
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-m", windows W.focusMaster)

  -- Swap Windows --
  , ("M-<Return>", windows W.swapMaster)
  , ("M-C-j", windows W.swapDown)
  , ("M-C-k", windows W.swapUp)

  -- Tabs --
  , ("M-o", withFocused (sendMessage . UnMerge))
  , ("M-C-o", withFocused (sendMessage . MergeAll))
  , ("M-C-S-o", withFocused (sendMessage . UnMergeAll))
  , ("M-S-h", sendMessage $ pullGroup L)
  , ("M-S-l", sendMessage $ pullGroup R)
  , ("M-S-k", sendMessage $ pullGroup U)
  , ("M-S-j", sendMessage $ pullGroup D)
  -- , ("M-C-S-h", 
  -- , ("M-C-S-l", 
  -- , ("M-C-S-k", 
  -- , ("M-C-S-j", 
  , ("M-C-.", onGroup W.focusUp')
  , ("M-C-,", onGroup W.focusDown')

  -- Hide and Restore Windows --
  , ("M-/", withFocused hideWindow)
  , ("M-S-/", popNewestHiddenWindow)

  -- Act on Workspaces --
  , ("M-S-r", liftIO (singleLineDmenu "Rename Workspace")
      >>= renameWorkspaceByName :: X ())
  , ("M-S-n", liftIO (singleLineDmenu "New Workspace")
      >>= appendWorkspace :: X ())
  -- , ("M-S-s", selectWorkspaceD)
  
  -- Resize Windows --
  , ("M-n", refresh)
  , ("M-h", sendMessage Shrink)
  , ("M-l", sendMessage Expand)

  --  Pin Windows --
  , ("M-a", windows copyToAll)
  , ("M-S-a", killAllOtherCopies)

  -- Act On Windows --
  , ("M-f", sendMessage $ Toggle NBFULL)
  , ("M-S-f", sendMessage NextLayout)
  -- , ("M-g",  sendMessage ToggleStruts)
  , ("M-S-c", kill)

  -- Layouts --
  , ("M-<Space>", sendMessage NextLayout)
  , ("M-t", withFocused $ windows . W.sink)
  , ("M-,", sendMessage (IncMasterN 1))
  , ("M-.", sendMessage (IncMasterN (-1)))]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "/usr/bin/emacs --daemon"

  -- Start Conky
  spawn "killall conky"
  spawn ("sleep 2 && conky -c ~/.config/conky/sysinfo.lua")

main :: IO ()
main = do
  
  -- Launch stalonetray
  spawnPipe ("pkill stalonetray || true &&  $XDG_CONFIG_HOME/polybar/scripts/stalonetray.sh")
  
  -- Launch polybar
  xmproc <- spawnPipe ("pkill polybar || true && polybar xmonad")
  
  -- Start xmonad
  -- xmonad $ workspaceNamesEwmh . ewmh $ docks $ def {
  xmonad $ ewmh $ docks $ def {
    -- simple stuff
    terminal           = "tabbed alacritty --embed",
    focusFollowsMouse  = False,
    clickJustFocuses   = True,
    borderWidth        = 1,
    modMask            = mod4Mask,
    --workspaces         = ["Main"],
    normalBorderColor  = "#dddddd",
    focusedBorderColor = "#ff6666",
    
    -- hooks, layouts
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
    }
    `additionalKeysP` myKeys
    `removeKeysP` myKeysR

help :: String
help = unlines [
  "The default modifier key is 'alt'. Default keybindings:",
  "",
  "-- launching and killing programs",
  "mod-Shift-Enter  Launch alacritty",
  "mod-p            Launch rofi",
  "mod-Shift-p      Launch rofi for window selection",
  "mod-Shift-c      Close/kill the focused window",
  "mod-Space        Rotate through the available layout algorithms",
  "mod-Shift-Space  Reset the layouts on the current workSpace to default",
  "mod-n            Resize/refresh viewed windows to the correct size",
  "",
  "-- move focus up or down the window stack",
  "mod-Tab        Move focus to the next window",
  "mod-Shift-Tab  Move focus to the previous window",
  "mod-j          Move focus to the next window",
  "mod-k          Move focus to the previous window",
  "mod-m          Move focus to the master window",
  "",
  "-- modifying the window order",
  "mod-Return   Swap the focused window and the master window",
  "mod-Shift-j  Swap the focused window with the next window",
  "mod-Shift-k  Swap the focused window with the previous window",
  "",
  "-- resizing the master/slave ratio",
  "mod-h  Shrink the master area",
  "mod-l  Expand the master area",
  "",
  "-- floating layer support",
  "mod-t  Push window back into tiling; unfloat and re-tile it",
  "",
  "-- increase or decrease number of windows in the master area",
  "mod-comma  (mod-,)   Increment the number of windows in the master area",
  "mod-period (mod-.)   Deincrement the number of windows in the master area",
  "",
  "-- quit, or restart",
  "mod-Shift-q  Quit xmonad",
  "mod-q        Restart xmonad",
  "mod-[1..9]   Switch to workSpace N",
  "",
  "-- Workspaces & screens",
  "mod-Shift-[1..9]   Move client to workspace N",
  "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
  "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
  "",
  "-- Mouse bindings: default actions bound to mouse events",
  "mod-button1  Set the window to floating mode and move by dragging",
  "mod-button2  Raise the window to the top of the stack",
  "mod-button3  Set the window to floating mode and resize by dragging"
  ]
