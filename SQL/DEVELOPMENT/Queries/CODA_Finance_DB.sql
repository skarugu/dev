CREATE TABLE Region(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE Chapter(
	id SERIAL PRIMARY KEY,
	region_id INTEGER REFERENCES Region(id) ON DELETE CASCADE,
	name VARCHAR(255) NOT NULL
);


CREATE TABLE News (
	id SERIAL PRIMARY KEY,
	region_id INTEGER REFERENCES Region(id) ON DELETE CASCADE,
	chapter_id INTEGER REFERENCES Chapter(id) ON DELETE CASCADE,
	title VARCHAR(255) NOT NULL,
	source VARCHAR(255) NOT NULL,
	published_date TIMESTAMP NOT NULL,
	create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	image_url VARCHAR(500),
	content TEXT NOT NULL,
	link VARCHAR(500),
	is_event BOOLEAN NOT NULL,
	category VARCHAR(100)
);

INSERT INTO Region (id, name) VALUES
	(1, 'Africa'),
	(2, 'North America'),
	(3, 'Middle East'),
	(4, 'Asia'),
	(5, 'Europe'),
	(6, 'South America'),
	(7, 'Eurasia'),
	(8, 'Oceania');


INSERT INTO Chapter (id, region_id, name) VALUES
	(1, 1, 'East Africa'),
	(2, 1, 'South Africa'),
	(3, 1, 'Central Africa'),
	(4, 1, 'West Africa'),
	(5, 1, 'North Africa'),
	(6, 2, 'USA'),
	(7, 2, 'Canada & Greenland'),
	(8, 2, 'Mexico-Caribbean'),
	(9, 3, 'Persian'),
	(10, 3, 'Mediterranean'),
	(11, 4, 'East Asia'),
	(12, 4, 'South East Asia'),
	(13, 4, 'South Asia'),
	(14, 5, 'Northwest'),
	(15, 5, 'Southeast'),
	(16, 6, 'Northeast'),
	(17, 6, 'Southwest'),
	(18, 7, 'East Russia'),
	(19, 7, 'West Russia'),
	(20, 7, 'Central Asia'),
	(21, 8, 'Northeast'),
	(22, 8, 'Southwest');


INSERT INTO News
	(region_id, chapter_id, title, source, published_date, create_date, update_date, image_url, content, link, is_event, category)
	VALUES
		-- Europe → Northwest
	(5, 14, 'Kenyan Diaspora in UK Launches Technology Hub', 'DC48K Europe Chapter', '2025-08-03 12:00:00', NOW(), NOW(),
	'https://cdn.dc48k.org/news/europe_techhub.jpg',
	'The Europe Northwest chapter unveiled a new tech hub to support startups and diaspora entrepreneurs.',
	'https://dc48k.org/news/europe-tech-hub', FALSE, 'technology'),
	
	-- Oceania → Southwest
	(8, 22, 'Australia Chapter Hosts Business Networking Event', 'DC48K Oceania Chapter', '2025-08-01 18:00:00', NOW(), NOW(),
	'https://cdn.dc48k.org/news/oceania_networking.jpg',
	'The Southwest Oceania chapter in Sydney hosted a networking event for Kenyan diaspora business leaders.',
	'https://dc48k.org/news/oceania-business-networking', TRUE, 'business');

	---- Write a query that shows all news e