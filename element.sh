#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
if [[ $1 =~ ^[0-9]+$ ]]
then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number, symbol, type, name, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $1")
  echo "$GET_ATOMIC_NUMBER" | while read ATOMIC BAR SYMBOL BAR TYPE BAR NAME BAR MASS BAR MELTING BAR BOILING
  do
    echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
else


  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number, symbol, type, name, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name = '$1'")
  if [[ ! -z $GET_ATOMIC_NUMBER ]]
  then
    echo "$GET_ATOMIC_NUMBER" | while read ATOMIC BAR SYMBOL BAR TYPE BAR NAME BAR MASS BAR MELTING BAR BOILING
    do
      echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
else
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number, symbol, type, name, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$1'")
  if [[ ! -z $GET_ATOMIC_NUMBER ]]
  then
    echo "$GET_ATOMIC_NUMBER" | while read ATOMIC BAR SYMBOL BAR TYPE BAR NAME BAR MASS BAR MELTING BAR BOILING
    do
      echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  else
    echo "I could not find that element in the database."
  fi
fi
fi
fi