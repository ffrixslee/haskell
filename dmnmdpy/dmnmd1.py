#transpiler example:https://github.com/showell/elm-py/blob/master/parser/emitDictPy.py
#https://pynative.com/python-check-user-input-is-number-or-string/
seasons: str
seasons = 'Spring', 'Summer', 'Fall', 'Winter'



seasons=str(input("Choose a season:{}".format(seasons)));

guest_count = int(input("Enter number of guests: "));

if seasons == "Winter" & guest_count==8:
    print("SpareRibs")
else:
    print("Nope");
