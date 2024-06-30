#! /bin/bash

# Script to insert data from games.csv into the worldcup database

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Ensure tables are empty before inserting data
echo $($PSQL "TRUNCATE games, teams")

# Looping through games.csv
cat games_test.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != "winner" ]]
  then
    # get winner
    WINNER=$($PSQL "SELECT winner FROM teams WHERE winner='$TEAM'")

    # if not found
    if [[ -z $WINNER ]]
    then
      # insert winner
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(winner) VALUES('$TEAM')")
    fi
  fi
done