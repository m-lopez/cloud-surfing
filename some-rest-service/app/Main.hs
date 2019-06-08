module Main where

import qualified Snap.Http.Server as S
import qualified Snap.Core as S
import qualified Snap.Internal.Http.Server.Config as SI

import Lib

-- Set server configuration.
servConf :: S.Config S.Snap a
servConf = S.defaultConfig
  { SI.port = Just 8889
  }

-- Entry point for the program.
main :: IO ()
main = S.httpServe servConf restServ

-- Define all routes for the rest service component.
restServ :: S.Snap ()
restServ = S.route
  [ ("echo/:echo-param", echoHandler) ]

echoHandler :: S.Snap ()
echoHandler = do
  arg <- S.getParam "echo-param"
  maybe
    (S.writeBS "missing `echo-param` in `echo/:echo-param` url")
    S.writeBS
    arg
