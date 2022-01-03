1.
CREATE TABLE hobbies (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
level INT(6) NOT NULL
)

CREATE TABLE users (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
gender varchar(1) not null,
status varchar(30) NOT NULL
)

CREATE TABLE map_user_hobby (
id INT(6) AUTO_INCREMENT PRIMARY KEY,
id_user int(6) UNSIGNED NOT NULL,
id_hobby int(6) UNSIGNED NOT NULL,
status varchar(30) NOT NULL,
FOREIGN KEY (id_user) REFERENCES users(id),
FOREIGN KEY (id_hobby) REFERENCES hobbies(id)
)

INSERT INTO `hobbies` (`id`, `name`, `level`) VALUES (NULL, 'Running', '8'), (NULL, 'Skipping', '5'), (NULL, 'Push Up', '10');

INSERT INTO `users` (`id`, `name`, `gender`, `status`) VALUES (NULL, 'Frasch', 'F', 'active'), (NULL, 'Garmuth', 'M', 'active'), (NULL, 'Goliath', 'M', 'active'), (NULL, 'Luna', 'F', 'active'), (NULL, 'Zeus', 'M', 'active'), (NULL, 'Aphrodite', 'F', 'active'), (NULL, 'Ares', 'M', 'active'), (NULL, 'Lina', 'F', 'active'), (NULL, 'Lanaya', 'F', 'active'), (NULL, 'Hades', 'M', 'active');

INSERT INTO `map_user_hobby` (`id`, `id_user`, `id_hobby`, `status`) VALUES (NULL, '1', '1', 'active'), (NULL, '3', '1', 'active'), (NULL, '8', '3', 'deleted'), (NULL, '2', '2', 'active'), (NULL, '4', '1', 'deleted'), (NULL, '6', '2', 'active'), (NULL, '5', '3', 'active'), (NULL, '8', '1', 'active'), (NULL, '7', '2', 'active'), (NULL, '4', '2', 'active'), (NULL, '9', '3', 'deleted'), (NULL, '10', '2', 'deleted'), (NULL, '3', '2', 'active'), (NULL, '2', '3', 'active'), (NULL, '10', '2', 'active');

CREATE INDEX mapping_user_hobby
ON map_user_hobby(id_user, id_hobby) USING BTREE;

2. SELECT b.gender, count(a.id) FROM (select * from `map_user_hobby`) a 
left join users b on a.id_user = b.id
LEFT join hobbies c on a.id_hobby = c.id
where c.name = 'Skipping' and a.status <> 'deleted' group by b.gender;

3. SELECT b.name, count(a.id) as total FROM (select * from `map_user_hobby`) a 
left join users b on a.id_user = b.id
LEFT join hobbies c on a.id_hobby = c.id
where a.status <> 'deleted' group by b.name;

4. select name, level_avg from (
SELECT b.name, count(a.id) as total, avg(c.level) as level_avg  FROM (select * from `map_user_hobby`) a 
left join users b on a.id_user = b.id
LEFT join hobbies c on a.id_hobby = c.id
where a.status <> 'deleted' group by b.name
) z where total > 1;

select name, level_avg from (
SELECT b.name, count(a.id) as total, avg(c.level) as level_avg  FROM (select * from `map_user_hobby`) a 
left join users b on a.id_user = b.id
LEFT join hobbies c on a.id_hobby = c.id group by b.name
) z where total > 1;

