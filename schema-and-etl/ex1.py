import csv
from io import TextIOWrapper
from zipfile import ZipFile

# opens file.
film_outfile = open("Film.csv", 'w', encoding='UTF8', newline='')
film_outwriter = csv.writer(film_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

authors_outfile = open("Authors.csv", 'w', encoding='UTF8', newline='')
authors_outwriter = csv.writer(authors_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

directors_outfile = open("Directors.csv", 'w', encoding='UTF8', newline='')
directors_outwriter = csv.writer(directors_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

actors_outfile = open("Actors.csv", 'w', encoding='UTF8', newline='')
actors_outwriter = csv.writer(actors_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

film_studio_producer_outfile = open("Film_Studio.csv", 'w', encoding='UTF8', newline='')
film_studio_producer_outwriter = csv.writer(film_studio_producer_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

genre_type_outfile = open("Genre_Type.csv", 'w', encoding='UTF8', newline='')
genre_type_outwriter = csv.writer(genre_type_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

authored_by_outfile = open("Authored_by.csv", 'w', encoding='UTF8', newline='')
authored_by_outwriter = csv.writer(authored_by_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

directed_by_outfile = open("Directed_by.csv", 'w', encoding='UTF8', newline='')
directed_by_outwriter = csv.writer(directed_by_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

acted_by_outfile = open("Acted_by.csv", 'w', encoding='UTF8', newline='')
acted_by_outwriter = csv.writer(acted_by_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

produced_by_outfile = open("Produced_by.csv", 'w', encoding='UTF8', newline='')
produced_by_outwriter = csv.writer(produced_by_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)

film_genre_outfile = open("Film_Genre.csv", 'w', encoding='UTF8', newline='')
film_genre_outwriter = csv.writer(film_genre_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL)


# process_file goes over all rows in original csv file, and sends each row to process_row()
def process_file():
    with ZipFile('oscars.zip') as zf:
        with zf.open('oscars.csv', 'r') as infile:
            reader = csv.reader(TextIOWrapper(infile, 'utf-8'))

            scanned_studios = set()
            scanned_genres = set()
            scanned_directors = set()
            scanned_authors = set()
            scanned_actors = set()
            authored_by = dict()
            produced_by = dict()
            actored_by = dict()
            directed_by = dict()

            for row in reader:
                # extract the row's information
                film_name = row[1]
                oscar_year = row[2]
                film_studio = row[3]
                award = row[4]
                film_release_year = row[5]
                film_duration = row[6]
                genres = split_list_value(row[7])  # list
                IMDB_rating = row[8]
                IMDB_votes = row[9]
                film_content_rating = row[10]
                directors = split_list_value(row[11])  # list
                authors = split_list_value(row[12])  # list
                actors = split_list_value(row[13])  # list
                film_id = row[14]

                # check necessary information and add it to sets to make sure we don't have duplicates
                check_scanned_data(film_studio, genres, directors, authors, actors, scanned_studios, scanned_genres,
                                   scanned_directors, scanned_authors, scanned_actors, film_id, authored_by,
                                   produced_by, actored_by, directed_by)

                film_outwriter.writerow([film_id, film_name, film_release_year, film_duration, IMDB_rating,
                                         film_content_rating, IMDB_votes, award, oscar_year])
    close()


def close():
    film_outfile.close()
    genre_type_outfile.close()
    actors_outfile.close()
    directors_outfile.close()
    authors_outfile.close()
    film_genre_outfile.close()
    film_studio_producer_outfile.close()
    acted_by_outfile.close()
    authored_by_outfile.close()
    directed_by_outfile.close()
    produced_by_outfile.close()


def check_scanned_data(film_studio, genres, directors, authors, actors,
                       scanned_studios, scanned_genres, scanned_directors, scanned_authors, scanned_actors, film_id,
                       authored_by, produced_by, actored_by, directed_by):
    if film_studio:
        if film_studio not in produced_by:
            produced_by[film_studio] = set()
            produced_by[film_studio].add(film_id)
            produced_by_outwriter.writerow([film_studio, film_id])
        elif film_studio in produced_by and film_id not in produced_by[film_studio]:
            produced_by[film_studio].add(film_id)
            produced_by_outwriter.writerow([film_studio, film_id])
        if film_studio not in scanned_studios:
            film_studio_producer_outwriter.writerow([film_studio])
            scanned_studios.add(film_studio)
    for genre in genres:
        if genre:
            film_genre_outwriter.writerow([genre, film_id])
            if genre not in scanned_genres:
                genre_type_outwriter.writerow([genre])
                scanned_genres.add(genre)
    for director in directors:
        if director:
            if director not in directed_by:
                directed_by[director] = set()
                directed_by[director].add(film_id)
                directed_by_outwriter.writerow([director, film_id])
            elif director in directed_by and film_id not in directed_by[director]:
                directed_by[director].add(film_id)
                directed_by_outwriter.writerow([director, film_id])
            if director not in scanned_directors:
                directors_outwriter.writerow([director])
                scanned_directors.add(director)
    for author in authors:
        if author:
            if author not in authored_by:
                authored_by[author] = set()
                authored_by[author].add(film_id)
                authored_by_outwriter.writerow([author, film_id])
            elif author in authored_by and film_id not in authored_by[author]:
                authored_by[author].add(film_id)
                authored_by_outwriter.writerow([author, film_id])
            if author not in scanned_authors:
                authors_outwriter.writerow([author])
                scanned_authors.add(author)
    for actor in actors:
        if actor:
            if actor not in actored_by:
                actored_by[actor] = set()
                actored_by[actor].add(film_id)
                acted_by_outwriter.writerow([actor, film_id])
            elif actor in actored_by and film_id not in actored_by[actor]:
                actored_by[actor].add(film_id)
                acted_by_outwriter.writerow([actor, film_id])
            if actor not in scanned_actors:
                actors_outwriter.writerow([actor])
                scanned_actors.add(actor)
    return


# return the list of all tables
def get_names():
    return ["Film", "Authors", "Directors", "Actors", "Film_Studio", "Genre_Type", "Authored_by",
            "Directed_by", "Acted_by", "Produced_by", "Film_Genre"]


def split_list_value(list_value):
    return list_value.split("&&")


if __name__ == "__main__":
    process_file()
