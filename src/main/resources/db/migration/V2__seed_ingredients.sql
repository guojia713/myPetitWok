-- ============================================================
-- V2: Seed ingredients
-- Core Asian ingredients with European-friendly translations
-- ============================================================

-- ── Substitutes first (referenced by other ingredients) ──────────────────────

INSERT INTO ingredients (id, asian_name, category) VALUES
  (100, 'Dry Sherry',         'SUBSTITUTE'),
  (101, 'Worcestershire',     'SUBSTITUTE'),
  (102, 'Sesame Oil (Light)', 'SUBSTITUTE'),
  (103, 'Lime Juice',         'SUBSTITUTE'),
  (104, 'Chilli Flakes',      'SUBSTITUTE');

INSERT INTO ingredient_translations (ingredient_id, language, name, description, where_to_find) VALUES
  (100, 'EN',    'Dry Sherry',          'A dry Spanish fortified wine, closest substitute for Shaoxing wine', 'Any supermarket — wine section'),
  (100, 'FR',    'Xérès sec',           'Vin fortifié espagnol sec, meilleur substitut du vin de Shaoxing',  'Tout supermarché — rayon vins'),
  (100, 'ZH_CN', '干雪利酒',             '干型西班牙强化葡萄酒，绍兴酒的最佳替代品',                              '普通超市酒类区'),

  (101, 'EN',    'Worcestershire Sauce','Tangy British sauce, acceptable substitute for fish sauce in cooked dishes', 'Any supermarket — condiments aisle'),
  (101, 'FR',    'Sauce Worcestershire', 'Sauce britannique acidulée, substitut acceptable pour la sauce de poisson', 'Tout supermarché — rayon condiments'),
  (101, 'ZH_CN', '伍斯特酱',             '英式酸味酱汁，可在熟食中代替鱼露使用',                                    '普通超市调味品区'),

  (102, 'EN',    'Light Sesame Oil',    'Lighter version, lacks the deep nuttiness of toasted sesame oil',   'Asian supermarkets or Amazon'),
  (102, 'FR',    'Huile de Sésame Légère', 'Version plus légère, sans le goût grillé de l''huile de sésame torréfiée', 'Épiceries asiatiques ou Amazon'),
  (102, 'ZH_CN', '淡芝麻油',             '味道较淡，缺少烤芝麻油的浓郁香气',                                        '亚洲超市或网购'),

  (103, 'EN',    'Lime Juice',          'Fresh lime juice works as a substitute for rice vinegar in salads',  'Any supermarket'),
  (103, 'FR',    'Jus de Citron Vert',  'Le jus de citron vert frais remplace le vinaigre de riz dans les salades', 'Tout supermarché'),
  (103, 'ZH_CN', '青柠汁',               '新鲜青柠汁可在沙拉中代替米醋',                                           '普通超市'),

  (104, 'EN',    'Chilli Flakes',       'Regular chilli flakes can substitute for doubanjiang spice, but lack the fermented depth', 'Any supermarket'),
  (104, 'FR',    'Flocons de Piment',   'Les flocons de piment ordinaires remplacent le piquant du doubanjiang, mais sans la profondeur fermentée', 'Tout supermarché'),
  (104, 'ZH_CN', '辣椒碎',               '普通辣椒碎可代替豆瓣酱的辣味，但缺乏发酵的深度',                            '普通超市');

-- ── Core ingredients ──────────────────────────────────────────────────────────

INSERT INTO ingredients (id, asian_name, category, substitute_id) VALUES
  (1,  '绍兴酒 Shaoxing Wine',      'SAUCE',     100),  -- substitute: dry sherry
  (2,  '生抽 Soy Sauce (Light)',    'SAUCE',     NULL),
  (3,  '老抽 Soy Sauce (Dark)',     'SAUCE',     NULL),
  (4,  '豆瓣酱 Doubanjiang',        'SAUCE',     104),  -- substitute: chilli flakes
  (5,  '鱼露 Fish Sauce',           'SAUCE',     101),  -- substitute: Worcestershire
  (6,  '芝麻油 Toasted Sesame Oil', 'SAUCE',     102),
  (7,  '米醋 Rice Vinegar',         'SAUCE',     103),
  (8,  '花椒 Sichuan Peppercorn',   'SPICE',     NULL),
  (9,  '豆腐 Tofu (Soft)',          'PROTEIN',   NULL),
  (10, '豆腐 Tofu (Firm)',          'PROTEIN',   NULL),
  (11, '猪肉末 Minced Pork',        'PROTEIN',   NULL),
  (12, '鸡蛋 Egg',                  'PROTEIN',   NULL),
  (13, '大蒜 Garlic',               'VEGETABLE', NULL),
  (14, '生姜 Fresh Ginger',         'VEGETABLE', NULL),
  (15, '葱 Spring Onion',           'VEGETABLE', NULL),
  (16, '韭菜 Chinese Chives',       'VEGETABLE', NULL),
  (17, '淀粉 Cornstarch',           'OTHER',     NULL),
  (18, '花生油 Peanut Oil',         'OIL',       NULL),
  (19, '白菜 Napa Cabbage',         'VEGETABLE', NULL),
  (20, '木耳 Wood Ear Mushroom',    'VEGETABLE', NULL);

-- ── Ingredient translations ───────────────────────────────────────────────────

INSERT INTO ingredient_translations (ingredient_id, language, name, description, where_to_find) VALUES

-- Shaoxing Wine
(1,'EN','Shaoxing Rice Wine','Fermented Chinese rice wine with a rich, slightly sweet flavour. Essential in Chinese cooking.','Asian supermarkets (Tang Frères, Paris; Wing Yip, UK). Also on Amazon.fr'),
(1,'FR','Vin de Riz Shaoxing','Vin de riz fermenté chinois au goût riche et légèrement sucré. Incontournable en cuisine chinoise.','Épiceries asiatiques (Tang Frères à Paris). Disponible aussi sur Amazon.fr'),
(1,'ZH_CN','绍兴酒','具有浓郁微甜风味的中国发酵米酒，中餐烹饪必备。','亚洲超市均有售，如唐人街各大华人超市'),

-- Light Soy Sauce
(2,'EN','Light Soy Sauce','Thin, salty soy sauce used for seasoning. More flavourful than European soy sauce.','Asian supermarkets or Kikkoman brand in most supermarkets'),
(2,'FR','Sauce Soja Claire','Sauce soja fine et salée pour assaisonner. Plus savoureuse que la sauce soja européenne.','Épiceries asiatiques ou marque Kikkoman en supermarché'),
(2,'ZH_CN','生抽','用于调味的薄盐酱油，比普通酱油更鲜美。','各大超市及亚洲食品店均有售'),

-- Dark Soy Sauce
(3,'EN','Dark Soy Sauce','Thick, sweet soy sauce used for colour and richness. Do not substitute with light soy sauce.','Asian supermarkets — look for Pearl River Bridge brand'),
(3,'FR','Sauce Soja Foncée','Sauce soja épaisse et sucrée pour la couleur et la richesse. Ne pas substituer par la sauce soja claire.','Épiceries asiatiques — chercher la marque Pearl River Bridge'),
(3,'ZH_CN','老抽','用于上色增稠的深色甜酱油，不能用生抽代替。','亚洲超市，推荐珠江桥牌'),

-- Doubanjiang
(4,'EN','Doubanjiang (Spicy Bean Paste)','Fermented broad beans and chilli paste from Sichuan. The soul of Sichuan cooking. Very spicy!','Asian supermarkets. Look for the red jar with "郫县豆瓣" (Pixian Douban) for best quality'),
(4,'FR','Doubanjiang (Pâte de Fèves Pimentée)','Pâte de fèves et de piments fermentés du Sichuan. L''âme de la cuisine sichuanaise. Très épicé !','Épiceries asiatiques. Cherchez le pot rouge "郫县豆瓣" pour la meilleure qualité'),
(4,'ZH_CN','郫县豆瓣酱','四川著名的发酵蚕豆辣酱，是川菜的灵魂调料，非常辣！','各大亚洲超市均有售，推荐正宗郫县豆瓣'),

-- Fish Sauce
(5,'EN','Fish Sauce','Fermented fish liquid with intense umami flavour. Essential in Thai and Vietnamese cooking.','Asian supermarkets. Megachef and Tiparos are good brands. Some Carrefour stores carry it'),
(5,'FR','Sauce de Poisson (Nuoc-Mâm)','Liquide de poisson fermenté à la saveur umami intense. Indispensable en cuisine thaïe et vietnamienne.','Épiceries asiatiques et certains Carrefour. Marques Megachef ou Tiparos recommandées'),
(5,'ZH_CN','鱼露','由发酵鱼类制成的液体调味料，鲜味浓郁，是泰国和越南菜的必备调料。','亚洲超市均有售'),

-- Toasted Sesame Oil
(6,'EN','Toasted Sesame Oil','Dark, intensely nutty oil used as a finishing flavour — never for cooking. A little goes a long way.','Asian supermarkets or health food stores. Kadoya brand is excellent'),
(6,'FR','Huile de Sésame Torréfiée','Huile foncée au goût de noisette intense, utilisée pour finir les plats — jamais pour la cuisson.','Épiceries asiatiques ou magasins bio. La marque Kadoya est excellente'),
(6,'ZH_CN','芝麻油（香油）','深色浓香芝麻油，用于起锅提香，不用于烹饪。少量即可增添浓郁香气。','各大超市及亚洲食品店'),

-- Rice Vinegar
(7,'EN','Rice Vinegar','Mild, slightly sweet vinegar. Much gentler than white wine vinegar.','Asian supermarkets. Some larger Carrefour/Auchan carry it'),
(7,'FR','Vinaigre de Riz','Vinaigre doux et légèrement sucré. Beaucoup plus délicat que le vinaigre de vin blanc.','Épiceries asiatiques et certains grands Carrefour/Auchan'),
(7,'ZH_CN','米醋','口感温和微甜的醋，比白葡萄酒醋柔和很多。','各大超市及亚洲食品店'),

-- Sichuan Peppercorn
(8,'EN','Sichuan Peppercorn','Not actually pepper — creates a unique numbing, citrusy tingle on the tongue. Key to authentic Sichuan food.','Asian supermarkets. Increasingly available in specialty spice shops in Europe'),
(8,'FR','Poivre du Sichuan','Pas vraiment du poivre — crée un picotement engourdissant et citronné unique sur la langue.','Épiceries asiatiques. De plus en plus disponible dans les épiceries fines européennes'),
(8,'ZH_CN','花椒','并非真正的胡椒，能在舌头上产生独特的麻木感和柑橘味，是正宗川菜的关键调料。','亚洲超市，各大华人超市均有售'),

-- Soft Tofu
(9,'EN','Soft Tofu (Silken)','Very delicate, custard-like tofu. Falls apart if handled roughly. Perfect for Mapo Tofu.','Asian supermarkets. Japanese supermarkets often carry silken tofu (kinugoshi)'),
(9,'FR','Tofu Soyeux (Mou)','Tofu très délicat, texture de flan. Se défait facilement si manipulé grossièrement.','Épiceries asiatiques. Les épiceries japonaises ont souvent du tofu soyeux (kinugoshi)'),
(9,'ZH_CN','嫩豆腐（内酯豆腐）','质地细嫩如布丁的豆腐，需轻拿轻放，是制作麻婆豆腐的首选。','各大超市及亚洲食品店'),

-- Garlic
(13,'EN','Garlic','Standard garlic — same as in European cooking. Used abundantly in Asian cuisine.','Any supermarket'),
(13,'FR','Ail','Ail standard — identique à la cuisine européenne. Utilisé abondamment en cuisine asiatique.','Tout supermarché'),
(13,'ZH_CN','大蒜','普通大蒜，与欧洲烹饪中使用的相同，在亚洲菜肴中大量使用。','普通超市'),

-- Ginger
(14,'EN','Fresh Ginger','Aromatic root, essential in almost all Asian cooking. Buy fresh — dried is not a substitute.','Any supermarket — produce section'),
(14,'FR','Gingembre Frais','Racine aromatique, indispensable dans presque toute la cuisine asiatique. Achetez frais — le séché ne convient pas.','Tout supermarché — rayon légumes'),
(14,'ZH_CN','生姜','香味浓郁的根茎，几乎是所有亚洲菜肴的必备食材，请购买新鲜生姜，干姜粉不可替代。','普通超市蔬菜区'),

-- Spring Onion
(15,'EN','Spring Onion (Scallion)','Mild green onion used both cooked and raw as garnish. Used in almost every dish.','Any supermarket'),
(15,'FR','Oignon Nouveau (Ciboule)','Oignon vert doux, utilisé cuit et cru comme garniture. Présent dans presque tous les plats.','Tout supermarché'),
(15,'ZH_CN','大葱/小葱','味道温和的绿葱，既可烹炒也可生食作装饰，几乎每道菜都会用到。','普通超市'),

-- Cornstarch
(17,'EN','Cornstarch (Cornflour)','Used for thickening sauces and tenderising meat. Identical to European cornflour.','Any supermarket — baking aisle'),
(17,'FR','Fécule de Maïs (Maïzena)','Utilisée pour épaissir les sauces et attendrir la viande. Identique à la Maïzena européenne.','Tout supermarché — rayon pâtisserie'),
(17,'ZH_CN','淀粉（生粉）','用于勾芡酱汁和嫩化肉类，与普通玉米淀粉相同。','普通超市烘焙区'),

-- Peanut Oil
(18,'EN','Peanut Oil (Groundnut Oil)','High smoke-point oil perfect for stir-frying and deep frying. Has a mild nutty flavour.','Asian supermarkets or large supermarkets. Vegetable oil works as a neutral substitute'),
(18,'FR','Huile d''Arachide','Huile à point de fumée élevé, parfaite pour les fritures et sautés. Légèrement parfumée.','Épiceries asiatiques ou grands supermarchés. L''huile de tournesol est un bon substitut neutre'),
(18,'ZH_CN','花生油','烟点高，非常适合炒菜和油炸，带有淡淡的坚果香味。','亚洲超市或大型超市均有售');

-- ── Reset sequence after manual ID inserts ────────────────────────────────────
SELECT setval('ingredients_id_seq', (SELECT MAX(id) FROM ingredients));
SELECT setval('ingredient_translations_id_seq', (SELECT MAX(id) FROM ingredient_translations));
