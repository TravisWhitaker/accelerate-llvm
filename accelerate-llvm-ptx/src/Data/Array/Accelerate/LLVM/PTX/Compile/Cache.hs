{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
-- |
-- Module      : Data.Array.Accelerate.LLVM.PTX.Compile.Cache
-- Copyright   : [2017] Trevor L. McDonell
-- License     : BSD3
--
-- Maintainer  : Trevor L. McDonell <tmcdonell@cse.unsw.edu.au>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--

module Data.Array.Accelerate.LLVM.PTX.Compile.Cache (

  module Data.Array.Accelerate.LLVM.Compile.Cache

) where

import Data.Array.Accelerate.LLVM.Compile.Cache
import Data.Array.Accelerate.LLVM.PTX.Target

import Control.Monad.State
import Data.Version
import Foreign.CUDA.Analysis
import System.FilePath
import Text.Printf
import qualified Data.ByteString.Short.Char8                        as S8


instance Persistent PTX where
  targetCacheTemplate = do
    Compute m n <- gets (computeCapability . ptxDeviceProperties)
    return $ "accelerate-llvm-ptx-" ++ "1.3.0.0"
         </> "llvm-hs-" ++ VERSION_llvm_hs
         </> S8.unpack ptxTargetTriple
         </> printf "sm%d%d" m n
         </> "morp.sass"

