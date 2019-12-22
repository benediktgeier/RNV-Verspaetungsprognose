# RNV-Verspätungsprognose

Dieses Repository dient zunächst dem Aufbau der neuen GraphQL-Schnittstelle.

## How To Start

1. Falls nötig, installiere Postman und erstelle Account
2. In Postman wähle "Import" und wähle GraphQL/Data Hub API.postman_collection.json
3. Gemäß der Anleitung in der description (ganz oben) in diesem .json-File erstelle ein environment in Postman mit den Credentials (siehe Mail von Frau Sachs), bzw. lade das unter GraphQL bereits gespeicherte Environment RNV-Variables, das bereits alle Credentials erhält
4. Führe Authorization request durch, damit bearer token für weitere requests gespeichert wird (muss ca. stündlich erneuert werden, also dann jeweils wieder Authorization ausführen)
5. Führe die einzelnen Requests durch, bzw. bearbeite / ergänze diese.
6. Insbesondere findet man in GraphQL/stations.json, den Output mit allen Stationen und deren hafasIDs (zur Benutzung in anderen requests) und in GraphQL/allFields.json das Schema das GraphQL Applikation, das alle Felder der einzelnen "Tabellen" / Objekte enthält.
7. Wichtigste Request ist vermutlich "Erstellung eines Haletstellenmonitors", dort müssen ggfs. die GraphQL Variablen für die Argumente der Query gesetzt werden


## Bisherige Erkenntnisse / Fragen

-	Teilweise widersprechende Verspätungsdaten:

	{
		"stationId": "1146",
		"startTime": "2019-11-28T07:39:00Z",
		"endTime": "2019-11-28T08:39:00Z"
	}

	Dann Linie 26 realtimeDeparture @ Bismarckplatz: "2019-11-28T07:42:35.000Z", aber realtimeDeparture an nächster Haltestelle Altes Hallenbad: "2019-11-28T07:40:00.000Z"

- 	Teilweise überhaupt keine Daten 

	{
		"stationId": "1146",
		"startTime": "2019-11-30T07:39:00Z",
		"endTime": "2019-11-30T12:39:00Z"
	}

- 	ab ca. Anfang Dezember ist realtimeDeparture überall (?) "null", z.B.

	{
		"stationId": "1146",
		"startTime": "2019-12-03T07:39:00Z",
		"endTime": "2019-12-03T08:39:00Z"
	}

	{
		"stationId": "2451",
		"startTime": "2019-12-05T07:39:00Z",
		"endTime": "2019-12-05T08:39:00Z"
	}

	{
		"stationId": "2451",
		"startTime": "2019-12-22T07:39:00Z",
		"endTime": "2019-12-22T08:39:00Z"
	}

- 	Journey type Feld passt nicht immer zu dem type Feld von Line, das von Line scheint meist passender zu sein, fehlt aber teilweise, z.B. ist in

	{
		"stationId": "2451",
		"startTime": "2019-12-22T07:39:00Z",
		"endTime": "2019-12-22T08:39:00Z"
	}

	in der Journey mit id "356-53514-10338" der Linie 4 Journey_Type: Stadtbus, aber Line_Type: Strassenbahn

- Oft Probleme derart "Security Profile Violated: charge 203 > securityProfile.maxCharge 200 ", z.B. in "Alle Haltestellen bekommen" -> Abfragen zu groß?



