#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table  -t --no-align -c"
if [[ -z $1 ]]
then
echo Please provide an element as an argument.
fi


if [[ $1 =~ ^[0-9]+$ ]]
then
INFO=$($PSQL "SELECT * FROM elements JOIN properties USING (atomic_number) JOIN types USING (type_id) WHERE atomic_number=$1;")
if [[ $INFO ]]
then
IFS='|' read type_id ATOM_NO SYMBOL NAME MASS MELT BOIL TYPE <<< "$INFO" 
echo "The element with atomic number $ATOM_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
else 
echo "I could not find that element in the database."
fi
fi


if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
then 
INFO=$($PSQL "SELECT * FROM elements JOIN properties USING (atomic_number) JOIN types USING (type_id) WHERE symbol='$1';")
if [[  $INFO ]]
then
IFS='|' read type_id ATOM_NO SYMBOL NAME MASS MELT BOIL TYPE <<< "$INFO" 
echo "The element with atomic number $ATOM_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
else
echo "I could not find that element in the database."
fi
fi


if [[ $1 =~ [a-zA-Z]{3,} ]]
then 
INFO=$($PSQL "SELECT * FROM elements JOIN properties USING (atomic_number) JOIN types USING (type_id) WHERE name='$1';")
if [[ $INFO ]]
then
IFS='|' read type_id ATOM_NO SYMBOL NAME MASS MELT BOIL TYPE <<< "$INFO" 
echo "The element with atomic number $ATOM_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
else
echo "I could not find that element in the database."
fi
fi