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
    PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius,type FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    echo "$PROPERTIES" | while IFS='|' read ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  done
fi