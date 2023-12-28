{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Data.Aeson (ToJSON)
import Data.List (find)
import GHC.Generics (Generic)
import System.Environment (getEnv)
import Web.Scotty (get, json, pathParam, scotty)

data User = MkUser {_id :: Int, name :: String, age :: Int}
  deriving stock (Show, Generic)
  deriving anyclass (ToJSON)

users :: [User]
users =
  [ MkUser{_id = 1, name = "Alice", age = 24}
  , MkUser{_id = 2, name = "Bob", age = 42}
  ]

main :: IO ()
main = do
  (port :: Int) <- read <$> getEnv "PORT"
  putStrLn $ "Running on port: " ++ show port
  scotty port do
    get "/" do
      json users

    get "/:id" do
      _id <- pathParam "id"
      json . find (\u -> u._id == _id) $ users
