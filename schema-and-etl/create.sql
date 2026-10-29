-- Create the film table
CREATE TABLE Film (
    film_id VARCHAR(100) PRIMARY KEY,
    film_name VARCHAR(100) NOT NULL,
    release_year INTEGER CHECK(release_year>=0) NOT NULL,
    film_duration INTEGER CHECK (film_duration>=0) NOT NULL,
    imdb_rating NUMERIC(3, 1),
    content_rating VARCHAR(100) CHECK (content_rating = 'R' OR content_rating = 'NR' OR content_rating = 'PG' OR 
    content_rating = 'G' OR content_rating = 'PG-13'),
    imdb_votes INTEGER CHECK(imdb_votes>=0),
    award VARCHAR(100) NOT NULL,
    oscar_year INTEGER CHECK (oscar_year>=0) NOT NULL
);

-- Create the authors table
CREATE TABLE Authors (
    author_name VARCHAR(100) PRIMARY KEY
);

-- Create the directors table
CREATE TABLE Directors (
    director_name VARCHAR(100) PRIMARY KEY
);

-- Create the actors table
CREATE TABLE Actors (
    actor_name VARCHAR(100) PRIMARY KEY
);

-- Create the film_studio table
CREATE TABLE Film_Studio(
    studio VARCHAR(100) PRIMARY KEY
);

-- Create the genre_type table
CREATE TABLE Genre_Type (
    genre VARCHAR(100) PRIMARY KEY
);

-- Create the authored_by table
CREATE TABLE Authored_by (
    author_name VARCHAR(100),
    film_id VARCHAR,
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (author_name) REFERENCES Authors(author_name),
    PRIMARY KEY (author_name, film_id)
);

-- Create the directed_by table
CREATE TABLE Directed_by (
    director_name VARCHAR(100),
    film_id VARCHAR(100),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (director_name) REFERENCES Directors(director_name),
    PRIMARY KEY (director_name, film_id)
);

-- Create the acted_by table
CREATE TABLE Acted_by (
    actor_name VARCHAR(100),
    film_id VARCHAR(100),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (actor_name) REFERENCES Actors(actor_name),
    PRIMARY KEY (actor_name, film_id)
);

-- Create the produced_by table
CREATE TABLE Produced_by (
    studio VARCHAR(100),
    film_id VARCHAR(100),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (studio) REFERENCES Film_Studio(studio),
    PRIMARY KEY (studio, film_id)
);

-- Create the film_genre table
CREATE TABLE Film_Genre (
    genre VARCHAR(100),
    film_id VARCHAR(100),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (genre) REFERENCES Genre_Type(genre),
    PRIMARY KEY (genre, film_id)
);
