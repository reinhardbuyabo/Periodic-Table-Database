#/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ [0-9]+ ]]
  then
    FETCH_ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1")
  else
    FETCH_ELEMENT=$($PSQL "SELECT * FROM elements WHERE symbol='$1' OR name='$1'")
  fi
  echo $FETCH_ELEMENT | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME
  do
    echo "$ATOMIC_NUMBER $SYMBOL $NAME"
  done
fi