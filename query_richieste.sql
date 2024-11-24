SELECT V.CFVicePrimario, V.DataAssunzione
FROM VicePrimario V JOIN Sostituzione S ON V.CFVicePrimario = S.CFVicePrimario
GROUP BY V.CFVicePrimario
HAVING COUNT(S.CFPrimario) = 1


SELECT V.CFVicePrimario, COUNT(S.CFPrimario) AS NumSostituzioni
FROM VicePrimario V JOIN Sostituzione S ON V.CFVicePrimario = S.CFVicePrimario
GROUP BY V.CFVicePrimario
HAVING COUNT(S.CFPrimario) >= 2

SELECT V.CFVicePrimario, V.DataAssunzione
        FROM VicePrimario V
        WHERE V.CFVicePrimario NOT IN (SELECT S.CFVicePrimario FROM Sostituzione S)