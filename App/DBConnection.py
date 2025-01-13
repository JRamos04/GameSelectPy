from neo4j import GraphDatabase

URI = "neo4j+s://50160ab9.databases.neo4j.io"
AUTH = ("neo4j", "0wEKGAaeGMuF0B8wlTqDVx_uqwOwWbOH9tx5lSqMnC0")

def runQuery(query):

    with GraphDatabase.driver(URI, auth=AUTH) as driver:
        driver.verify_connectivity()
        games, summary, keys = driver.execute_query(
        query,
        database_="neo4j",
    )

    gamesData = ""

    if not games:
        gamesData = "No se encontraron resultados. Intenta ampliar la búsqueda."
    else:
        for game in games:
            d = game.data()
            gamesData = gamesData + "\nName: "+d["g.Name"]+"\nPrice: "+str(d["g.Price"])+"$\nDescription: "+d["g.`About the game`"]+"\n"

    return gamesData




