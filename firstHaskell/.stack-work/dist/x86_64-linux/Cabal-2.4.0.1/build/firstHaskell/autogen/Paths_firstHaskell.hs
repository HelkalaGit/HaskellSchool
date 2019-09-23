{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_firstHaskell (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/joel/Documents/firstHaskell/.stack-work/install/x86_64-linux/1a65ddce21d93c0a93f2bf9c3b062020bd2a8fd88af52387c4d50a3c28e377d1/8.6.5/bin"
libdir     = "/home/joel/Documents/firstHaskell/.stack-work/install/x86_64-linux/1a65ddce21d93c0a93f2bf9c3b062020bd2a8fd88af52387c4d50a3c28e377d1/8.6.5/lib/x86_64-linux-ghc-8.6.5/firstHaskell-0.1.0.0-JlmQtXkXDc5HIpiDol7ZK3-firstHaskell"
dynlibdir  = "/home/joel/Documents/firstHaskell/.stack-work/install/x86_64-linux/1a65ddce21d93c0a93f2bf9c3b062020bd2a8fd88af52387c4d50a3c28e377d1/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/joel/Documents/firstHaskell/.stack-work/install/x86_64-linux/1a65ddce21d93c0a93f2bf9c3b062020bd2a8fd88af52387c4d50a3c28e377d1/8.6.5/share/x86_64-linux-ghc-8.6.5/firstHaskell-0.1.0.0"
libexecdir = "/home/joel/Documents/firstHaskell/.stack-work/install/x86_64-linux/1a65ddce21d93c0a93f2bf9c3b062020bd2a8fd88af52387c4d50a3c28e377d1/8.6.5/libexec/x86_64-linux-ghc-8.6.5/firstHaskell-0.1.0.0"
sysconfdir = "/home/joel/Documents/firstHaskell/.stack-work/install/x86_64-linux/1a65ddce21d93c0a93f2bf9c3b062020bd2a8fd88af52387c4d50a3c28e377d1/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "firstHaskell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "firstHaskell_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "firstHaskell_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "firstHaskell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "firstHaskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "firstHaskell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
