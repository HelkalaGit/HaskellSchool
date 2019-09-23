{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_impAsteroid (
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

bindir     = "/home/joel/Documents/impAsteroid/.stack-work/install/x86_64-linux/c88fa5c4f87d3f90f9d303b8c3692985b88266e0bae106b3033dbb6744264400/8.0.2/bin"
libdir     = "/home/joel/Documents/impAsteroid/.stack-work/install/x86_64-linux/c88fa5c4f87d3f90f9d303b8c3692985b88266e0bae106b3033dbb6744264400/8.0.2/lib/x86_64-linux-ghc-8.0.2/impAsteroid-0.1.0.0"
dynlibdir  = "/home/joel/Documents/impAsteroid/.stack-work/install/x86_64-linux/c88fa5c4f87d3f90f9d303b8c3692985b88266e0bae106b3033dbb6744264400/8.0.2/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/home/joel/Documents/impAsteroid/.stack-work/install/x86_64-linux/c88fa5c4f87d3f90f9d303b8c3692985b88266e0bae106b3033dbb6744264400/8.0.2/share/x86_64-linux-ghc-8.0.2/impAsteroid-0.1.0.0"
libexecdir = "/home/joel/Documents/impAsteroid/.stack-work/install/x86_64-linux/c88fa5c4f87d3f90f9d303b8c3692985b88266e0bae106b3033dbb6744264400/8.0.2/libexec"
sysconfdir = "/home/joel/Documents/impAsteroid/.stack-work/install/x86_64-linux/c88fa5c4f87d3f90f9d303b8c3692985b88266e0bae106b3033dbb6744264400/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "impAsteroid_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "impAsteroid_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "impAsteroid_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "impAsteroid_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "impAsteroid_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "impAsteroid_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
