

INSERT INTO api_category (name, description) VALUES
('Tools', 'Various tools and equipment'),
('Furniture', 'Household furniture'),
('Electronics', 'Electronic items and gadgets');

	update api_category set id = 1 where id = 72;
	update api_category set id = 2 where id = 73;
	
-- Insert sample users
INSERT INTO api_user (username, email, password_hash, created_at)
VALUES
    ('alice_wonder', 'alice@example.com', 'hash1', CURRENT_TIMESTAMP),
    ('bob_builder', 'bob@example.com', 'hash2', CURRENT_TIMESTAMP),
    ('charlie_day', 'charlie@example.com', 'hash3', CURRENT_TIMESTAMP),
    ('daisy_duke', 'daisy@example.com', 'hash4', CURRENT_TIMESTAMP),
    ('edgar_allan', 'edgar@example.com', 'hash5', CURRENT_TIMESTAMP);
	
update api_user set id = 1 where id = 56;
		update api_user set id = 2 where id = 57;

-- Dodanie kategorii dla nowych przedmiotów
INSERT INTO api_category (name, description) VALUES
('Opony i felgi', 'Opony samochodowe oraz felgi do różnych pojazdów'),
('Pojemniki i akcesoria', 'Plastikowe pojemniki, wiadra i inne akcesoria do przechowywania');

-- Dodanie nowych przedmiotów
INSERT INTO api_item (user_id, category_id, name, description, created_at) VALUES
(1, 1, 'Opona 165/70R14', 'Opona samochodowa z felgą. Rozmiar: 165/70R14, klasa: 81T.', CURRENT_TIMESTAMP),
(1, 2, 'Baniak plastikowy 5L', 'Plastikowy pojemnik z zieloną nakrętką, przeznaczony do płynów technicznych.', CURRENT_TIMESTAMP),
(1, 2, 'Plastikowe wiadro', 'Wiadro w plastikowym worku, widoczne na zdjęciu w piwnicy.', CURRENT_TIMESTAMP);

update api_item set id = 1 where id = 177;
		update api_item set id = 2 where id = 178;
		update api_item set id = 3 where id = 179;

-- Dodanie zdjęć dla tych przedmiotów
INSERT INTO api_image (item_id, image_url, uploaded_at) VALUES
(1, '20250120_070753.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070412.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070412.jpg', CURRENT_TIMESTAMP);

-- Tagowanie przedmiotów
INSERT INTO api_itemtag (item_id, tag_name) VALUES
(1, 'opona'),
(1, 'samochodowa'),
(2, 'pojemnik'),
(2, 'plastikowy'),
(3, 'wiadro');

-- Dodanie kategorii dla książek
INSERT INTO api_category (name, description) VALUES
('Książki techniczne', 'Książki i podręczniki techniczne z zakresu programowania, elektroniki oraz informatyki');

-- Dodanie książek
INSERT INTO api_item (user_id, category_id, name, description, created_at) VALUES
(1, 1, 'PHP. Receptury', 'Podręcznik do języka PHP z gotowymi rozwiązaniami.', CURRENT_TIMESTAMP),
(1, 1, 'Linux - praktyka administracji', 'Kompleksowy przewodnik po administracji systemem Linux.', CURRENT_TIMESTAMP),
(1, 1, 'Sztuka elektroniki. Część 1', 'Klasyczna pozycja o elektronice autorstwa P. Horowitza i W. Hilla.', CURRENT_TIMESTAMP),
(1, 1, 'Sztuka elektroniki. Część 2', 'Druga część bestsellerowego podręcznika do elektroniki.', CURRENT_TIMESTAMP),
(1, 1, 'C++ Elementarz hakera', 'Poradnik dla zaawansowanych programistów C++.', CURRENT_TIMESTAMP),
(1, 1, 'Jak pisać wirusy', 'Książka o pisaniu wirusów komputerowych (dla celów edukacyjnych!).', CURRENT_TIMESTAMP),
(1, 1, 'abc komputera', 'Podstawy obsługi komputera dla początkujących.', CURRENT_TIMESTAMP),
(1, 1, 'UNIX - programowanie systemowe', 'Kompletny podręcznik do programowania systemowego w UNIX.', CURRENT_TIMESTAMP),
(1, 1, 'qmail. Szybki i wydajny serwer pocztowy', 'Instrukcja konfiguracji i administracji serwerem qmail.', CURRENT_TIMESTAMP),
(1, 1, 'Serwisy WWW. Projektowanie, tworzenie i zarządzanie', 'Praktyczny poradnik dla twórców stron WWW.', CURRENT_TIMESTAMP);

-- Dodanie zdjęć książek
INSERT INTO api_image (item_id, image_url, uploaded_at) VALUES
(1, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070449.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070449.jpg', CURRENT_TIMESTAMP);

-- Tagowanie książek
INSERT INTO api_itemtag (item_id, tag_name) VALUES
(1, 'php'),
(2, 'linux'),
(3, 'elektronika'),
(3, 'elektronika'),
(3, 'c++'),
(2, 'wirusy'),
(1, 'komputery'),
(2, 'unix'),
(3, 'qmail'),
(1, 'www');

-- Dodanie kategorii
INSERT INTO api_category (name, description) VALUES
('Kuchnia i AGD', 'Przedmioty kuchenne, sprzęty AGD oraz akcesoria'),
('Akcesoria domowe', 'Elementy wyposażenia wnętrz, torby i półki');

-- Dodanie przedmiotów
INSERT INTO api_item (user_id, category_id, name, description, created_at) VALUES
(1, 1, 'Maszynka do mielenia 986', 'Maszynka do mielenia mięsa w oryginalnym pudełku.', CURRENT_TIMESTAMP),
(1, 1, 'Metalowe garnki', 'Zestaw metalowych garnków lub parownik.', CURRENT_TIMESTAMP),
(1, 2, 'Czarna torba', 'Torba z zamkiem błyskawicznym, średniej wielkości.', CURRENT_TIMESTAMP),
(1, 2, 'Drewniana półka z haczykami', 'Półka drewniana z metalowymi haczykami.', CURRENT_TIMESTAMP);

-- Dodanie zdjęcia
INSERT INTO api_image (item_id, image_url, uploaded_at) VALUES
(1, '20250120_070559.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070559.jpg', CURRENT_TIMESTAMP),
(3, '20250120_070559.jpg', CURRENT_TIMESTAMP),
(2, '20250120_070559.jpg', CURRENT_TIMESTAMP);


-- Dodanie nowej kategorii
INSERT INTO api_category (name, description) VALUES
('Sport i podróże', 'Torby, plecaki oraz akcesoria podróżne i sportowe.');

-- Dodanie przedmiotu
INSERT INTO api_item (user_id, category_id, name, description, created_at) VALUES
(1, (SELECT id FROM api_category WHERE name = 'Sport i podróże'), 
'Czarna torba sportowa', 
'Duża torba sportowa z kilkoma zamkami błyskawicznymi i rączkami, idealna na wyjazdy lub treningi.', 
CURRENT_TIMESTAMP);

-- Dodanie zdjęcia dla przedmiotu
INSERT INTO api_image (item_id, image_url, uploaded_at) VALUES
((SELECT id FROM api_item WHERE name = 'Czarna torba sportowa'), 
'20250120_070519.jpg', 
CURRENT_TIMESTAMP);

-- Dodanie nowej kategorii dla materiałów budowlanych
INSERT INTO api_category (name, description) VALUES
('Materiały budowlane', 'Produkty do remontów i budowy, takie jak gips, cement, farby.');

-- Dodanie przedmiotu do katalogu
INSERT INTO api_item (user_id, category_id, name, description, created_at) VALUES
(1, (SELECT id FROM api_category WHERE name = 'Materiały budowlane'), 
'Worki z materiałami budowlanymi', 
'Dwa worki: jeden plastikowy, prawdopodobnie zawierający odpady, oraz worek z gipsowym tynkiem MP 75.', 
CURRENT_TIMESTAMP);

-- Dodanie zdjęcia przedmiotu
INSERT INTO api_image (item_id, image_url, uploaded_at) VALUES
((SELECT id FROM api_item WHERE name = 'Worki z materiałami budowlanymi'), 
'20250120_070329.jpg', 
CURRENT_TIMESTAMP);


--jars
INSERT INTO api_jar (shelf, description, content_type, weight_grams, is_empty, added_at) VALUES
(1, 'Słoik z ogórkami kiszonymi', 'Ogórki', 1200, FALSE, CURRENT_TIMESTAMP),
(1, 'Słoik z olejem kokosowym', 'Olej kokosowy', 500, FALSE, CURRENT_TIMESTAMP),
--(1, 'Pusty słoik', NULL, 0, TRUE, CURRENT_TIMESTAMP),
(2, 'Słoik z keczupem', 'Keczup', 700, FALSE, CURRENT_TIMESTAMP),
(2, 'Słoik z przetworami owocowymi', 'Dżem truskawkowy', 400, FALSE, CURRENT_TIMESTAMP);
--(2, 'Pusty słoik z zakrętką czerwoną', NULL, 0, TRUE, CURRENT_TIMESTAMP),
--(3, 'Duży pusty słoik', NULL, 0, TRUE, CURRENT_TIMESTAMP),
--(3, 'Średni pusty słoik', NULL, 0, TRUE, CURRENT_TIMESTAMP),
--(3, 'Mały pusty słoik', NULL, 0, TRUE, CURRENT_TIMESTAMP);

INSERT INTO api_jar (shelf, description, content_type, weight_grams, is_empty, added_at)
VALUES
(1, 'Korniszony w słoiku', 'Ogórki kiszone', 720, FALSE, CURRENT_TIMESTAMP),
(1, 'Słoik oleju kokosowego', 'Olej kokosowy', 500, FALSE, CURRENT_TIMESTAMP),
(1, 'Marynowana papryka w słoiku', 'Papryka marynowana', 300, FALSE, CURRENT_TIMESTAMP),
(1, 'Słoik z dżemem wiśniowym', 'Dżem wiśniowy', 330, FALSE, CURRENT_TIMESTAMP),
(2, 'Słoik miodu wielokwiatowego', 'Miód', 900, FALSE, CURRENT_TIMESTAMP),
(2, 'Słoik z ketchupem łagodnym', 'Ketchup', 500, FALSE, CURRENT_TIMESTAMP),
(2, 'Marynowana dynia w dużym słoiku', 'Dynia marynowana', 1000, FALSE, CURRENT_TIMESTAMP),
(2, 'Słoik z ogórkami kwaszonymi', 'Ogórki kwaszone', 720, FALSE, CURRENT_TIMESTAMP),
(2, 'Słoik przecieru pomidorowego', 'Przecier pomidorowy', 700, FALSE, CURRENT_TIMESTAMP),
(2, 'Słoik z piklami warzywnymi', 'Pikle', 500, FALSE, CURRENT_TIMESTAMP);

INSERT INTO api_item (user_id, category_id, name, description, created_at)
VALUES 
(1, 2, 'Panele podłogowe', 'Stos paneli podłogowych w jasnym odcieniu drewna, pozostałość po remoncie.', CURRENT_TIMESTAMP);

INSERT INTO api_item (user_id, category_id, name, description, created_at)
VALUES 
(1, 1, 'Wiaderko Ultra Biel', 'Wiaderko farby Ultra Biel do ścian i sufitów, częściowo zużyte.', CURRENT_TIMESTAMP),
(1, 2, 'Para starych butów', 'Czarne, lekko zużyte buty sportowe, potencjalnie przydatne do pracy.', CURRENT_TIMESTAMP),
(1, 1, 'Reklamówka z zawartością', 'Biała reklamówka z nieznaną zawartością, może zawierać drobne przedmioty.', CURRENT_TIMESTAMP);

INSERT INTO api_item (user_id, category_id, name, description, created_at)
VALUES 
(1, 1, 'Stare koła rowerowe', 'Dwa stare koła rowerowe z oponami, jedno z odblaskiem.', CURRENT_TIMESTAMP),
(1, 2, 'Metalowy garnek', 'Duży, metalowy garnek z plastikowymi uchwytami.', CURRENT_TIMESTAMP),
(1, 1, 'Poduszka z gąbki', 'Duża poduszka z gąbki, potencjalnie używana jako materiał izolacyjny.', CURRENT_TIMESTAMP),
(1, 1, 'Doniczka gliniana', 'Mała, okrągła doniczka wykonana z gliny.', CURRENT_TIMESTAMP),
(1, 1, 'Czerwona konewka', 'Plastikowa konewka w kolorze czerwonym, lekko używana.', CURRENT_TIMESTAMP),
(1, 2, 'Spray techniczny', 'Puszka ze sprayem technicznym, przeznaczenie bliżej nieokreślone.', CURRENT_TIMESTAMP);

INSERT INTO api_item (user_id, category_id, name, description, created_at)
VALUES 
(1, 1, 'Rura rowerowa', 'Stara rura rowerowa w plastikowej donicy.', CURRENT_TIMESTAMP),
(1, 2, 'Czerwona donica', 'Plastikowa, czerwona donica średniej wielkości.', CURRENT_TIMESTAMP),
(1, 2, 'Puszka sprayu technicznego', 'Spray techniczny w puszce marki Motip.', CURRENT_TIMESTAMP),
(1, 1, 'Sprężone powietrze', 'Duża niebieska puszka ze sprężonym powietrzem, używana do czyszczenia.', CURRENT_TIMESTAMP);


INSERT INTO api_item (user_id, category_id, name, description, created_at)
VALUES 
(1, 2, 'Koła rowerowe', 'Trzy zużyte koła rowerowe z widocznymi szprychami, powieszone na ścianie.', CURRENT_TIMESTAMP),
(1, 1, 'Karton po telewizorze', 'Duży karton po telewizorze LED 43-calowym, używany do przechowywania.', CURRENT_TIMESTAMP),
(1, 1, 'Worek z materiałami', 'Przezroczysty worek z nieokreślonymi materiałami, możliwe tekstylia.', CURRENT_TIMESTAMP),
(1, 1, 'Karton po sprzęcie', 'Karton po urządzeniu Mini Oil Pressing Machine.', CURRENT_TIMESTAMP);

-- INSERT INTO categories (name, description) VALUES
-- ('Książki techniczne', 'Literatura z zakresu techniki i programowania'),
-- ('AGD i kuchnia', 'Akcesoria kuchenne, garnki i sprzęty AGD'),
-- ('Materiały budowlane', 'Produkty remontowe i budowlane'),
-- ('Sport i rowery', 'Akcesoria sportowe oraz części rowerowe'),
-- ('Dom i ogród', 'Wyposażenie domu i ogrodu'),
-- ('Inne', 'Pozostałe przedmioty');

-- Seed użytkowników
INSERT INTO api_user (username, email, password_hash, created_at) VALUES
('lemiesz', 'lemiesz@example.com', 'hash1', CURRENT_TIMESTAMP),
('seba', 'seba@example.com', 'hash2', CURRENT_TIMESTAMP),
('kamil', 'kamil@example.com', 'hash3', CURRENT_TIMESTAMP),
('michal', 'michal@example.com', 'hash4', CURRENT_TIMESTAMP);

