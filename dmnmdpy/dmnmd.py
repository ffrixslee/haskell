#transpiler example:https://github.com/showell/elm-py/blob/master/parser/emitDictPy.py

def whatdish(seasons):
    seasons: str
    seasons = 'Spring', 'Summer', 'Fall', 'Winter'
    guest_count: int


    print("Choose a season:{}".format(seasons));
    seasons=input(seasons);
    guest_count=input(guest_count)



    if seasons == "Winter" and guest_count<=8:
        print("SpareRibs")
    else:
        print("Nope");
    pass
