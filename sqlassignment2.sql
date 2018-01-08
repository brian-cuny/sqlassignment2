#Brian
#Assignment 2

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS videos;

CREATE TABLE videos(
 id INTEGER AUTO_INCREMENT PRIMARY KEY,
 title varchar(100) NOT NULL,
 length INTEGER NOT NULL,
 url varchar(100) NOT NULL
);

LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\videos.csv' 
INTO TABLE videos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(title, length, url);


CREATE TABLE reviews(
 id INTEGER AUTO_INCREMENT PRIMARY KEY,
 video_id INTEGER NOT NULL,
 username varchar(30) NOT NULL,
 rating INTEGER,
 review varchar(100) NOT NULL,
 foreign key(video_id) references videos(id)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\reviews.csv' 
INTO TABLE reviews
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(video_id, username, @rating, review)
SET rating=IF(@rating='',NULL,@rating);

#Finds the average rating and best rating of every video displayed alongside the video's title. 
#Data is sorted by best average, then best overall rating then by name.
SELECT 
 V.title as 'Title',
 AVG(R.rating) as 'Average_Rating',
 MAX(R.rating) as 'Best_Rating'
FROM videos as V
LEFT JOIN reviews as R
ON V.id = R.video_id
GROUP BY V.title
ORDER BY Average_Rating DESC, Best_Rating DESC, Title ASC;