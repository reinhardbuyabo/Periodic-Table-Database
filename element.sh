#/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  FETCH_ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1 OR symbol='$1' OR name='$1'")
fi