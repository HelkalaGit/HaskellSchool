{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_constructing (
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

bindir     = "/home/joel/Documents/Haskell/HaskellSchool/constructing/.stack-work/install/x86_64-linux/5ded02e2046cefcdb8cd4c14916af19bbf76cc08d32101b5df42a0a5dc4d76e1/8.6.5/bin"
libdir     = "/home/joel/Documents/Haskell/HaskellSchool/constructing/.stack-work/install/x86_64-linux/5ded02e2046cefcdb8cd4c14916af19bbf76cc08d32101b5df42a0a5dc4d76e1/8.6.5/lib/x86_64-linux-ghc-8.6.5/constructing-0.1.0.0-49pv34cq58RHxN367Z90t-constructing"
dynlibdir  = "/home/joel/Documents/Haskell/HaskellSchool/constructing/.stack-work/install/x86_64-linux/5ded02e2046cefcdb8cd4c14916af19bbf76cc08d32101b5df42a0a5dc4d76e1/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/joel/Documents/Haskell/HaskellSchool/constructing/.stack-work/install/x86_64-linux/5ded02e2046cefcdb8cd4c14916af19bbf76cc08d32101b5df42a0a5dc4d76e1/8.6.5/share/x86_64-linux-ghc-8.6.5/constructing-0.1.0.0"
libexecdir = "/home/joel/Documents/Haskell/HaskellSchool/constructing/.stack-work/install/x86_64-linux/5ded02e2046cefcdb8cd4c14916af19bbf76cc08d32101b5df42a0a5dc4d76e1/8.6.5/libexec/x86_64-linux-ghc-8.6.5/constructing-0.1.0.0"
sysconfdir = "/home/joel/Documents/Haskell/HaskellSchool/constructing/.stack-work/install/x86_64-linux/5ded02e2046cefcdb8cd4c14916af19bbf76cc08d32101b5df42a0a5dc4d76e1/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "constructing_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "constructing_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "constructing_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "constructing_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "constructing_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "constructing_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
