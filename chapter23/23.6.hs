newtype Moi s a =
    Moi { runMoi :: s -> (a, s) }