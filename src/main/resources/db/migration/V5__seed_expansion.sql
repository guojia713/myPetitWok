-- ============================================================
-- V5: Seed expansion
-- 15 new ingredients + 12 new recipes (4 cuisines)
-- Brings total to 35 ingredients and 15 recipes
-- ============================================================

-- ── New ingredients (IDs 21–35) ───────────────────────────────────────────────

INSERT INTO ingredients (id, asian_name, category) VALUES
  (21, '味噌 Miso Paste',           'SAUCE'),
  (22, 'みりん Mirin',               'SAUCE'),
  (23, '出汁 Dashi Stock',           'SAUCE'),
  (24, '고추장 Gochujang',            'SAUCE'),
  (25, '胡麻 Sesame Seeds',          'SPICE'),
  (26, '米 Rice',                    'OTHER'),
  (27, 'กะทิ Coconut Milk',          'SAUCE'),
  (28, 'เครื่องแกงเขียวหวาน Thai Green Curry Paste', 'SAUCE'),
  (29, 'ตะไคร้ Lemongrass',          'VEGETABLE'),
  (30, '鶏もも肉 Chicken Thighs',     'PROTEIN'),
  (31, '牛肉 Beef Sirloin',           'PROTEIN'),
  (32, 'เส้นหมี่ Rice Noodles',       'OTHER'),
  (33, 'ถั่วงอก Bean Sprouts',        'VEGETABLE'),
  (34, '김치 Kimchi',                 'VEGETABLE'),
  (35, '蝦 Shrimp / Prawns',          'PROTEIN');

INSERT INTO ingredient_translations (ingredient_id, language, name, description, where_to_find) VALUES

-- Miso Paste
(21,'EN','Miso Paste','Fermented soybean paste — the base of miso soup and many Japanese marinades. White (shiro) is mild; red (aka) is stronger.','Asian supermarkets. Clearspring and Hikari are widely available in Europe'),
(21,'FR','Pâte Miso','Pâte de soja fermenté — base du miso et de nombreuses marinades japonaises. Le blanc (shiro) est doux ; le rouge (aka) est plus fort.','Épiceries asiatiques. Marques Clearspring et Hikari disponibles en Europe'),
(21,'ZH_CN','味噌','发酵大豆酱，是味噌汤和日式腌料的基础。白味噌口味温和，红味噌味道更浓郁。','亚洲超市均有售'),

-- Mirin
(22,'EN','Mirin','Sweet Japanese rice wine used for glazing and seasoning. Adds a subtle sweetness and glossy finish.','Asian supermarkets. Kikkoman brand available in many European supermarkets'),
(22,'FR','Mirin','Vin de riz japonais sucré utilisé pour glacer et assaisonner. Apporte une douceur subtile et une finition brillante.','Épiceries asiatiques. Marque Kikkoman disponible dans certains supermarchés'),
(22,'ZH_CN','味醂','甜味日本米酒，用于上光和调味，增添淡淡甜味和光泽感。','亚洲超市，部分大型超市也有售'),

-- Dashi Stock
(23,'EN','Dashi Stock','Japanese umami stock made from kombu and bonito flakes. The flavour backbone of Japanese cuisine. Instant granules (Hondashi) are convenient.','Asian supermarkets. Hondashi instant granules at some Carrefour/Auchan'),
(23,'FR','Bouillon Dashi','Bouillon japonais umami fait de kombu et de flocons de bonite. L''épine dorsale de la cuisine japonaise.','Épiceries asiatiques. Granulés instantanés Hondashi dans certains Carrefour/Auchan'),
(23,'ZH_CN','日式高汤（出汁）','由昆布和木鱼花制成的日式鲜汤，是日本料理的风味基础。本高汤颗粒速溶版很方便。','亚洲超市，部分大型超市也有售'),

-- Gochujang
(24,'EN','Gochujang (Korean Chilli Paste)','Fermented Korean chilli paste with a deep, complex heat and slight sweetness. Essential in Korean cooking.','Asian supermarkets. CJ Haechandle is a reliable brand. Increasingly available in Carrefour'),
(24,'FR','Gochujang (Pâte de Piment Coréenne)','Pâte de piment coréenne fermentée avec une chaleur profonde et complexe. Incontournable en cuisine coréenne.','Épiceries asiatiques. Marque CJ Haechandle fiable. Disponible dans certains Carrefour'),
(24,'ZH_CN','韩国辣椒酱','发酵韩式辣椒酱，有着深厚复杂的辣味和淡淡甜味，是韩国料理的必备调料。','亚洲超市，部分大型超市也有售'),

-- Sesame Seeds
(25,'EN','Sesame Seeds','Small toasted seeds used as a garnish in Japanese and Korean dishes. Buy pre-toasted for convenience.','Any supermarket — baking or spice aisle'),
(25,'FR','Graines de Sésame','Petites graines torréfiées utilisées en garniture dans les plats japonais et coréens.','Tout supermarché — rayon épices ou pâtisserie'),
(25,'ZH_CN','芝麻','用于日韩料理的小型烤芝麻，作为装饰点缀。购买已烤制的版本更方便。','普通超市烘焙区或调料区'),

-- Rice
(26,'EN','Rice (Jasmine / Short-grain)','Use jasmine rice for Thai and Vietnamese dishes; short-grain (sushi) rice for Japanese and Korean.','Any supermarket. Nishiki or Koshihikari brands for Japanese-style'),
(26,'FR','Riz (Jasmin / Grains Courts)','Utilisez le riz jasmin pour les plats thaïs et vietnamiens ; le riz à grains courts (sushi) pour japonais et coréen.','Tout supermarché. Marques Nishiki ou Koshihikari pour le style japonais'),
(26,'ZH_CN','米饭（茉莉香米/短粒米）','泰式越南菜用茉莉香米，日韩料理用短粒米（寿司米）。','普通超市均有售'),

-- Coconut Milk
(27,'EN','Coconut Milk','Creamy milk extracted from coconut flesh. Used in Thai curries, soups, and desserts. Full-fat gives the richest result.','Any supermarket — international or Asian aisle. Aroy-D and Chaokoh are excellent brands'),
(27,'FR','Lait de Coco','Lait crémeux extrait de la pulpe de noix de coco. Utilisé dans les currys thaïs et soupes. Le full-fat donne le meilleur résultat.','Tout supermarché — rayon international. Marques Aroy-D et Chaokoh recommandées'),
(27,'ZH_CN','椰浆','从椰子果肉中提取的奶油状液体，用于泰式咖喱和汤品。全脂版口味最佳。','普通超市国际食品区，Aroy-D和Chaokoh是优质品牌'),

-- Thai Green Curry Paste
(28,'EN','Thai Green Curry Paste','Aromatic paste of green chillies, lemongrass, galangal and herbs. Mae Ploy and Maesri are authentic brands.','Asian supermarkets. Mae Ploy brand at some larger Carrefour/Auchan'),
(28,'FR','Pâte de Curry Vert Thaï','Pâte aromatique de piments verts, citronnelle, galanga et herbes. Mae Ploy et Maesri sont des marques authentiques.','Épiceries asiatiques. Marque Mae Ploy dans certains grands Carrefour/Auchan'),
(28,'ZH_CN','泰式绿咖喱酱','由青辣椒、香茅、南姜和香草制成的芳香酱料。Mae Ploy和Maesri是正宗品牌。','亚洲超市，部分大型超市也有售'),

-- Lemongrass
(29,'EN','Lemongrass','Fragrant tropical grass with a citrusy, floral aroma. Use the lower white stalk — bruise before adding to release flavour.','Asian supermarkets and many large supermarkets. Also available dried or in paste form'),
(29,'FR','Citronnelle','Herbe tropicale parfumée à l''arôme citronné et floral. Utilisez la partie blanche du bas — écrasez avant d''ajouter pour libérer le parfum.','Épiceries asiatiques et grands supermarchés. Disponible aussi séchée ou en pâte'),
(29,'ZH_CN','香茅','具有柑橘花香的热带香草，使用下部白色茎秆，使用前轻拍以释放香味。','亚洲超市及部分大型超市'),

-- Chicken Thighs
(30,'EN','Chicken Thighs (Boneless)','Juicier and more flavourful than breast — stays tender in marinades and stir-fries. Skin-on or off both work.','Any supermarket — poultry section'),
(30,'FR','Cuisses de Poulet','Plus juteuses et savoureuses que le blanc — restent tendres dans les marinades et woks.','Tout supermarché — rayon volaille'),
(30,'ZH_CN','去骨鸡腿肉','比鸡胸肉更鲜嫩多汁，在腌制和翻炒中保持嫩滑口感。','普通超市禽类区'),

-- Beef Sirloin
(31,'EN','Beef Sirloin (Thinly Sliced)','For Korean BBQ and stir-fries, slice thinly against the grain. Ask your butcher or buy pre-sliced at Asian supermarkets.','Asian supermarkets often sell pre-sliced bulgogi beef. Or ask your butcher'),
(31,'FR','Bœuf Faux-Filet (Tranché Finement)','Pour le barbecue coréen et les woks, tranchez finement contre le fil. Demandez à votre boucher ou achetez tranché en épicerie asiatique.','Épiceries asiatiques vendent souvent du bœuf pré-tranché pour bulgogi'),
(31,'ZH_CN','牛里脊（薄切）','韩式烤肉和炒菜专用，逆纹薄切。亚洲超市常有预切牛肉片出售。','亚洲超市，通常有预切牛肉片'),

-- Rice Noodles
(32,'EN','Rice Noodles (Flat / Thin)','Made from rice flour — gluten-free. Soak in warm water before using (do not boil). Thin (vermicelli) for spring rolls; flat for Pad Thai.','Asian supermarkets. Also available in many regular supermarkets'),
(32,'FR','Nouilles de Riz (Plates / Fines)','À base de farine de riz — sans gluten. Faire tremper dans l''eau chaude avant utilisation. Fines pour rouleaux de printemps ; plates pour Pad Thai.','Épiceries asiatiques et certains supermarchés ordinaires'),
(32,'ZH_CN','米粉/河粉','由大米粉制成，无麸质。使用前用温水浸泡（无需煮沸）。细米粉用于春卷，宽河粉用于泰式炒粉。','亚洲超市，部分普通超市也有售'),

-- Bean Sprouts
(33,'EN','Bean Sprouts','Mung bean sprouts — crisp and fresh. Add at the last minute to keep crunch. Available fresh or canned (fresh is far better).','Any supermarket — produce section. Buy fresh for best texture'),
(33,'FR','Germes de Soja','Pousses de haricots mungo — croquantes et fraîches. Ajouter à la dernière minute pour conserver le croquant.','Tout supermarché — rayon légumes frais'),
(33,'ZH_CN','豆芽','绿豆芽，清脆鲜嫩，最后加入保持爽脆口感。新鲜豆芽远优于罐头。','普通超市蔬菜区，购买新鲜豆芽口感最佳'),

-- Kimchi
(34,'EN','Kimchi','Fermented Korean cabbage with chilli, garlic and ginger. The heart of Korean cuisine. Naturally probiotic.','Asian supermarkets. Increasingly available in health food stores and large supermarkets'),
(34,'FR','Kimchi','Chou coréen fermenté avec du piment, de l''ail et du gingembre. Le cœur de la cuisine coréenne. Naturellement probiotique.','Épiceries asiatiques. De plus en plus disponible en magasins bio et grands supermarchés'),
(34,'ZH_CN','韩式泡菜','用辣椒、大蒜和姜腌制发酵的韩国白菜，是韩国料理的灵魂食材，富含益生菌。','亚洲超市，部分健康食品店和大型超市也有售'),

-- Shrimp / Prawns
(35,'EN','Shrimp / Prawns (Medium, Peeled)','Buy raw, peeled and deveined for convenience. Frozen is fine — thaw in cold water before using.','Any supermarket — fresh fish counter or frozen aisle'),
(35,'FR','Crevettes (Moyennes, Décortiquées)','Achetez crues, décortiquées et déveinées. Surgelées conviennent — décongeler dans l''eau froide avant utilisation.','Tout supermarché — poissonnerie ou rayon surgelés'),
(35,'ZH_CN','虾（中等大小，去壳）','购买生的去壳去虾线虾仁最方便，冷冻的也很好，使用前冷水解冻。','普通超市海鲜柜台或冷冻区');

SELECT setval('ingredients_id_seq', (SELECT MAX(id) FROM ingredients));
SELECT setval('ingredient_translations_id_seq', (SELECT MAX(id) FROM ingredient_translations));


-- ============================================================
-- New Recipes (IDs 4–15)
-- ============================================================

INSERT INTO recipes (id, cuisine_type, difficulty, prep_time_minutes, cook_time_minutes, servings, spice_level, published) VALUES
  (4,  'JAPANESE',   'BEGINNER',     10,  10, 2, 0, true),   -- Miso Soup
  (5,  'JAPANESE',   'BEGINNER',     15,  20, 2, 1, true),   -- Chicken Teriyaki
  (6,  'JAPANESE',   'INTERMEDIATE', 40,  15, 4, 1, true),   -- Gyoza
  (7,  'KOREAN',     'INTERMEDIATE', 30,  30, 2, 2, true),   -- Bibimbap
  (8,  'KOREAN',     'BEGINNER',     20,  10, 3, 1, true),   -- Bulgogi
  (9,  'KOREAN',     'BEGINNER',     10,  20, 2, 3, true),   -- Kimchi Jjigae
  (10, 'THAI',       'INTERMEDIATE', 20,  15, 2, 2, true),   -- Pad Thai
  (11, 'THAI',       'BEGINNER',     10,  25, 4, 3, true),   -- Thai Green Curry
  (12, 'CHINESE',    'BEGINNER',     10,  10, 2, 1, true),   -- Egg Fried Rice
  (13, 'CHINESE',    'INTERMEDIATE', 60,  15, 4, 1, true),   -- Pork Dumplings (Jiaozi)
  (14, 'VIETNAMESE', 'BEGINNER',     20,   0, 4, 0, true),   -- Fresh Spring Rolls
  (15, 'THAI',       'INTERMEDIATE', 15,  20, 2, 4, true);   -- Tom Yum Soup

-- ── Recipe translations ───────────────────────────────────────────────────────

INSERT INTO recipe_translations (recipe_id, language, name, description, phonetic) VALUES

-- Miso Soup
(4,'EN','Miso Soup','A warming, umami-rich Japanese soup made with dashi stock and miso paste. A staple of everyday Japanese cooking.','Mi-so Shiru'),
(4,'FR','Soupe Miso','Une soupe japonaise réconfortante et riche en umami. Incontournable du quotidien japonais.','Mi-so Chi-rou'),
(4,'ZH_CN','味噌汤','鲜味浓郁的日式汤品，用出汁和味噌制成，是日本日常饮食的主食。','Miso Shiru'),

-- Chicken Teriyaki
(5,'EN','Chicken Teriyaki','Juicy chicken glazed in a sweet soy-mirin sauce. One of the most popular Japanese dishes in the world.','Te-ri-ya-ki'),
(5,'FR','Poulet Teriyaki','Poulet juteux glacé dans une sauce soja-mirin sucrée. L''un des plats japonais les plus populaires au monde.','Te-ri-ya-ki'),
(5,'ZH_CN','照烧鸡','涂上甜酱油味醂酱汁的鲜嫩鸡肉，是全球最受欢迎的日本料理之一。','Te-ri-ya-ki'),

-- Gyoza
(6,'EN','Gyoza (Pan-Fried Dumplings)','Crispy on the bottom, steamed on top — the iconic Japanese dumpling filled with pork and cabbage.','Gyo-za'),
(6,'FR','Gyoza (Raviolis Poêlés)','Croustillants en dessous, cuits à la vapeur au-dessus — le célèbre ravioli japonais à la viande de porc et chou.','Gyo-za'),
(6,'ZH_CN','日式煎饺','底部酥脆、上部蒸熟，是日本标志性的猪肉白菜煎饺。','Jiao-zi'),

-- Bibimbap
(7,'EN','Bibimbap','Korean mixed rice bowl topped with vegetables, beef and a fried egg, served with gochujang.','Bi-bim-bap'),
(7,'FR','Bibimbap','Bol de riz coréen garni de légumes, bœuf et œuf au plat, servi avec gochujang.','Bi-bim-bap'),
(7,'ZH_CN','韩式拌饭','韩国混合饭碗，配上蔬菜、牛肉和煎鸡蛋，搭配韩式辣酱食用。','Bi-bim-bap'),

-- Bulgogi
(8,'EN','Bulgogi','Korean BBQ beef marinated in soy, sesame and Asian pear. Tender, sweet and deeply savoury.','Bul-go-gi'),
(8,'FR','Bulgogi','Bœuf BBQ coréen mariné dans la sauce soja, sésame et poire asiatique. Tendre, sucré et profondément savoureux.','Bul-go-gi'),
(8,'ZH_CN','韩式烤肉','用酱油、芝麻和梨腌制的韩国烤牛肉，嫩滑甜香，鲜味浓郁。','Bul-go-gi'),

-- Kimchi Jjigae
(9,'EN','Kimchi Jjigae','Bold Korean kimchi stew with tofu and a rich, spicy broth. Best made with aged kimchi.','Kim-chi Jji-gae'),
(9,'FR','Kimchi Jjigae','Copieux ragoût coréen de kimchi avec du tofu et un bouillon épicé et riche. Meilleur avec du kimchi bien fermenté.','Kim-chi Jji-gae'),
(9,'ZH_CN','韩式泡菜汤','以老泡菜炖制的浓郁韩式辣汤，加入豆腐，口味醇厚鲜辣。','Kim-chi Ji-gae'),

-- Pad Thai
(10,'EN','Pad Thai','Thailand''s most famous noodle dish — stir-fried rice noodles with shrimp, egg and bean sprouts in a tangy tamarind sauce.','Pad Thai'),
(10,'FR','Pad Thai','Le plat de nouilles le plus célèbre de Thaïlande — nouilles de riz sautées avec crevettes, œuf et germes de soja.','Pad Taï'),
(10,'ZH_CN','泰式炒河粉','泰国最著名的面条菜肴，用虾、鸡蛋和豆芽炒制的罗望子味河粉。','Pad Thai'),

-- Thai Green Curry
(11,'EN','Thai Green Curry','Creamy coconut milk curry with chicken, fragrant green curry paste and lemongrass. Aromatic and mildly spicy.','Gaeng Keow Wan'),
(11,'FR','Curry Vert Thaï','Curry crémeux au lait de coco avec poulet, pâte de curry vert parfumée et citronnelle.','Gaeng Keow Wan'),
(11,'ZH_CN','泰式绿咖喱','椰浆鸡肉咖喱，加入香茅和绿咖喱酱，香气浓郁，微辣诱人。','Gaeng Keow Wan'),

-- Egg Fried Rice
(12,'EN','Egg Fried Rice','The ultimate leftover rice dish — smoky, savoury and ready in 10 minutes. Use day-old rice for the best texture.','Chǎo Fàn'),
(12,'FR','Riz Sauté aux Oeufs','Le plat ultime avec du riz de la veille — fumé, savoureux et prêt en 10 minutes.','Chao Fan'),
(12,'ZH_CN','蛋炒饭','经典的隔夜米饭料理，焦香美味，10分钟即可完成，用隔夜饭口感最佳。','Dàn Chǎo Fàn'),

-- Pork Dumplings
(13,'EN','Pork & Cabbage Dumplings (Jiaozi)','The most beloved Chinese dumpling — juicy pork and napa cabbage wrapped in thin dough, boiled or pan-fried.','Jiǎo Zi'),
(13,'FR','Raviolis Porc & Chou Chinois (Jiaozi)','Le ravioli chinois le plus apprécié — porc juteux et chou chinois enveloppés dans une pâte fine.','Jiao Zi'),
(13,'ZH_CN','猪肉白菜饺子','中国最受欢迎的饺子，鲜嫩猪肉和白菜馅料，薄皮包裹，可煮可煎。','Jiǎo Zi'),

-- Fresh Spring Rolls
(14,'EN','Fresh Spring Rolls (Gỏi Cuốn)','Light and healthy Vietnamese rice paper rolls filled with shrimp, noodles and fresh herbs. Served with peanut dipping sauce.','Goi Cuon'),
(14,'FR','Rouleaux de Printemps Frais (Gỏi Cuốn)','Rouleaux de riz vietnamiens légers et sains, garnis de crevettes, nouilles et herbes fraîches.','Goi Kwon'),
(14,'ZH_CN','越南新鲜春卷','轻盈健康的越南米纸卷，包裹虾仁、粉丝和新鲜香草，配花生蘸酱食用。','Gỏi Cuốn'),

-- Tom Yum Soup
(15,'EN','Tom Yum Soup','Thailand''s iconic hot and sour soup — fragrant lemongrass, galangal and kaffir lime with plump shrimp.','Tom Yam'),
(15,'FR','Soupe Tom Yum','La soupe piquante et acidulée emblématique de Thaïlande — citronnelle, galanga et citron kaffir avec des crevettes.','Tom Yam'),
(15,'ZH_CN','泰式冬阴功汤','泰国标志性酸辣汤，香茅、南姜和柠檬叶与饱满虾仁共同熬制。','Tom Yam');

-- ── Recipe steps ──────────────────────────────────────────────────────────────

INSERT INTO recipe_steps (recipe_id, step_order, duration_minutes) VALUES
-- Miso Soup (4)
(4,1,5), (4,2,3), (4,3,2),
-- Chicken Teriyaki (5)
(5,1,15),(5,2,10),(5,3,5),
-- Gyoza (6)
(6,1,30),(6,2,5), (6,3,10),(6,4,5),
-- Bibimbap (7)
(7,1,20),(7,2,10),(7,3,5),
-- Bulgogi (8)
(8,1,15),(8,2,5), (8,3,5),
-- Kimchi Jjigae (9)
(9,1,5), (9,2,15),(9,3,5),
-- Pad Thai (10)
(10,1,10),(10,2,10),(10,3,3),
-- Thai Green Curry (11)
(11,1,5),(11,2,15),(11,3,5),
-- Egg Fried Rice (12)
(12,1,3),(12,2,5),(12,3,2),
-- Pork Dumplings (13)
(13,1,30),(13,2,5),(13,3,10),(13,4,5),
-- Fresh Spring Rolls (14)
(14,1,10),(14,2,10),(14,3,5),
-- Tom Yum Soup (15)
(15,1,10),(15,2,8),(15,3,5);

-- ── Recipe step translations ──────────────────────────────────────────────────

INSERT INTO recipe_step_translations (step_id, language, instruction, tip) VALUES

-- Miso Soup step IDs (look up by recipe_id + step_order)
-- Using subquery approach: we reference by step_id directly after the insert
-- Note: step IDs are auto-generated; we use a subquery to find them

-- ── Miso Soup ────────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=1),'EN',
 'Heat dashi stock in a saucepan over medium heat until just below boiling. Do not let it boil.','Boiling kills the delicate dashi flavour'),
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=1),'FR',
 'Chauffer le bouillon dashi dans une casserole à feu moyen jusqu''en dessous du point d''ébullition. Ne pas faire bouillir.','L''ébullition détruit la saveur délicate du dashi'),
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=1),'ZH_CN',
 '将出汁倒入锅中中火加热至接近沸腾，切勿煮沸。','煮沸会破坏出汁的细腻风味'),

((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=2),'EN',
 'Dissolve miso paste in a ladle of hot dashi, then stir it back into the pot. Add cubed soft tofu gently.','Always dissolve miso separately to avoid lumps and never boil after adding miso'),
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=2),'FR',
 'Dissoudre la pâte miso dans une louche de dashi chaud, puis incorporer dans la casserole. Ajouter le tofu soyeux coupé en dés.','Dissoudre le miso séparément pour éviter les grumeaux. Ne jamais faire bouillir après'),
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=2),'ZH_CN',
 '将味噌在一勺热出汁中溶解，再倒回锅中，轻轻加入切块的嫩豆腐。','味噌要单独溶解以避免结块，加入后切勿沸腾'),

((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=3),'EN',
 'Serve immediately in bowls, garnished with sliced spring onion.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=3),'FR',
 'Servir immédiatement dans des bols, garni d''oignon nouveau émincé.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=4 AND step_order=3),'ZH_CN',
 '立即盛碗，撒上葱花即可享用。',NULL),

-- ── Chicken Teriyaki ─────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=1),'EN',
 'Mix soy sauce, mirin and a pinch of sugar to make the teriyaki sauce. Score the chicken thighs and marinate for 15 minutes.','Scoring the chicken helps the marinade penetrate and speeds up cooking'),
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=1),'FR',
 'Mélanger sauce soja, mirin et une pincée de sucre pour la sauce teriyaki. Inciser les cuisses de poulet et mariner 15 minutes.','Inciser le poulet aide la marinade à pénétrer'),
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=1),'ZH_CN',
 '将酱油、味醂和少许糖混合制成照烧酱汁，在鸡腿上划刀后腌制15分钟。','划刀有助于腌汁渗透并加快烹饪速度'),

((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=2),'EN',
 'Cook chicken skin-side down in a hot pan for 7 minutes until golden and crispy. Flip and cook 5 more minutes.','Do not move the chicken while it cooks — let the skin render properly'),
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=2),'FR',
 'Cuire le poulet côté peau dans une poêle chaude 7 minutes jusqu''à dorure. Retourner et cuire encore 5 minutes.','Ne pas bouger le poulet pendant la cuisson — laisser la peau croustiller'),
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=2),'ZH_CN',
 '鸡皮朝下放入热锅，煎7分钟至金黄酥脆，翻面再煎5分钟。','煎制过程中不要移动鸡肉，让鸡皮充分出油焦脆'),

((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=3),'EN',
 'Pour the teriyaki sauce over the chicken and glaze for 2–3 minutes until sticky. Slice and garnish with sesame seeds and spring onion.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=3),'FR',
 'Verser la sauce teriyaki sur le poulet et glacer 2–3 minutes jusqu''à consistance collante. Trancher et garnir de graines de sésame et oignon nouveau.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=5 AND step_order=3),'ZH_CN',
 '将照烧酱汁浇在鸡肉上，收汁2-3分钟至浓稠粘腻，切片后撒芝麻和葱花即可。',NULL),

-- ── Gyoza ────────────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=1),'EN',
 'Finely chop napa cabbage, sprinkle with salt and squeeze out as much water as possible. Mix with minced pork, garlic, ginger, sesame oil and soy sauce.','Removing water from the cabbage is critical — wet filling makes soggy gyoza that burst'),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=1),'FR',
 'Hacher finement le chou, saler et presser pour extraire le maximum d''eau. Mélanger avec porc haché, ail, gingembre, huile de sésame et sauce soja.','Bien égoutter le chou est essentiel — une farce trop humide fait éclater les gyoza'),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=1),'ZH_CN',
 '将白菜切碎，撒盐后挤出尽可能多的水分，然后与猪肉末、大蒜、姜、芝麻油和酱油混合。','去除白菜水分至关重要，馅料太湿会导致饺子破皮'),

((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=2),'EN',
 'Place a heaped teaspoon of filling in the centre of each wrapper. Wet the edge, fold and pleat to seal tightly.','Practice the pleat — even rough folds work. The key is a tight seal so filling does not leak'),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=2),'FR',
 'Déposer une cuillère bombée de farce au centre de chaque pâte. Humidifier le bord, plier et plisser pour bien sceller.','L''essentiel est une fermeture hermétique pour éviter que la farce ne s''échappe'),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=2),'ZH_CN',
 '在每张饺子皮中央放一勺馅料，沾湿边缘，对折后捏紧褶皱封口。','关键是封口要紧，防止馅料流出'),

((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=3),'EN',
 'Heat oil in a non-stick pan. Add gyoza flat-side down and fry 2 minutes until golden. Add 50ml water, cover immediately and steam for 6 minutes.','The water-steam technique gives the iconic crispy bottom and cooked top simultaneously'),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=3),'FR',
 'Chauffer de l''huile dans une poêle antiadhésive. Ajouter les gyoza à plat et frire 2 minutes. Ajouter 50ml d''eau, couvrir aussitôt et cuire à la vapeur 6 minutes.','La technique vapeur-friture donne simultanément le fond croustillant et le dessus cuit'),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=3),'ZH_CN',
 '在不粘锅中加热油，将饺子底部向下煎2分钟至金黄，加入50ml水立即盖盖，蒸制6分钟。','水煎法能同时实现底部酥脆和上部熟透的完美效果'),

((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=4),'EN',
 'Uncover, let remaining water evaporate and crisp the bottom for 1 more minute. Serve with soy sauce and rice vinegar for dipping.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=4),'FR',
 'Enlever le couvercle, laisser l''eau résiduelle s''évaporer et croustiller encore 1 minute. Servir avec sauce soja et vinaigre de riz pour tremper.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=6 AND step_order=4),'ZH_CN',
 '揭盖后让剩余水分蒸发，再煎1分钟至底部酥脆，搭配酱油和米醋蘸食。',NULL),

-- ── Bibimbap ─────────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=1),'EN',
 'Cook rice. Season and sauté the beef strips with soy sauce, sesame oil and garlic. Prepare each vegetable separately — blanch or sauté with a pinch of salt and sesame oil.','Preparing each topping separately gives bibimbap its beautiful, distinct flavours and colours'),
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=1),'FR',
 'Cuire le riz. Assaisonner et sauter les lanières de bœuf avec sauce soja, huile de sésame et ail. Préparer chaque légume séparément.','Préparer chaque garniture séparément donne à la bibimbap ses saveurs et couleurs distinctes'),
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=1),'ZH_CN',
 '煮饭。将牛肉丝用酱油、芝麻油和大蒜调味翻炒，各类蔬菜分别焯烫或炒制，用少许盐和芝麻油调味。','各种配料分别制作，才能呈现拌饭丰富的色彩和口味'),

((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=2),'EN',
 'Fry an egg sunny-side up with a runny yolk. Arrange the rice in a bowl, place each topping in sections around it, and put the egg in the centre.','The visual presentation is part of bibimbap — take care arranging the toppings in distinct sections'),
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=2),'FR',
 'Faire frire un œuf au plat avec un jaune coulant. Disposer le riz dans un bol, placer chaque garniture en sections et mettre l''œuf au centre.','La présentation visuelle est une partie de la bibimbap — soigner l''arrangement'),
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=2),'ZH_CN',
 '煎一个流心太阳蛋，将米饭盛碗后各种配料分区摆放，鸡蛋置于中央。','拌饭的摆盘是其精髓之一，各种配料分区摆放要整齐好看'),

((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=3),'EN',
 'Add a generous dollop of gochujang in the centre, drizzle sesame oil and sprinkle sesame seeds. Mix everything together at the table before eating.','Mix vigorously — the joy of bibimbap is in the mixing'),
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=3),'FR',
 'Ajouter une généreuse cuillerée de gochujang au centre, arroser d''huile de sésame et parsemer de graines de sésame. Tout mélanger à table avant de manger.','Mélanger vigoureusement — le plaisir de la bibimbap est dans le mélange'),
((SELECT id FROM recipe_steps WHERE recipe_id=7 AND step_order=3),'ZH_CN',
 '在中央加入一大勺韩式辣酱，淋上芝麻油，撒上芝麻，上桌后用力拌匀再食用。','用力拌匀是享受拌饭的精髓所在'),

-- ── Bulgogi ──────────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=1),'EN',
 'Mix soy sauce, sesame oil, garlic, ginger, a little sugar and sesame seeds for the marinade. Add thinly sliced beef and marinate for at least 20 minutes.','Grated Asian pear or kiwi tenderises the beef naturally — add if available'),
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=1),'FR',
 'Mélanger sauce soja, huile de sésame, ail, gingembre, un peu de sucre et graines de sésame pour la marinade. Ajouter le bœuf en tranches fines et mariner au moins 20 minutes.','La poire asiatique ou le kiwi râpé attendrit naturellement la viande'),
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=1),'ZH_CN',
 '将酱油、芝麻油、大蒜、生姜、少许糖和芝麻混合成腌料，加入薄切牛肉腌制至少20分钟。','加入磨碎的亚洲梨或猕猴桃可以天然嫩化牛肉'),

((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=2),'EN',
 'Cook in a very hot pan or on a griddle in small batches — do not crowd the pan. 1–2 minutes per side until caramelised.','High heat and small batches are the secret — crowding creates steam and the beef stews instead of grills'),
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=2),'FR',
 'Cuire dans une poêle très chaude en petites quantités — ne pas surcharger. 1–2 minutes par côté jusqu''à caramélisation.','Haute chaleur et petites quantités — trop de viande crée de la vapeur'),
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=2),'ZH_CN',
 '分批次在极热的锅中煎制，每面1-2分钟至焦糖化，切勿将锅塞满。','高温少量是关键，锅中放太多会产生蒸汽而非煎烤效果'),

((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=3),'EN',
 'Serve over rice, garnished with spring onion and sesame seeds. Wrap in lettuce leaves for the traditional ssam style.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=3),'FR',
 'Servir sur du riz, garni d''oignon nouveau et graines de sésame. Enrouler dans des feuilles de laitue pour le style ssam traditionnel.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=8 AND step_order=3),'ZH_CN',
 '盖在米饭上，撒葱花和芝麻装饰，也可用生菜叶包裹食用（传统ssam吃法）。',NULL),

-- ── Kimchi Jjigae ────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=1),'EN',
 'Sauté kimchi in sesame oil for 3–4 minutes until slightly caramelised. Add gochujang and stir to combine.','Using older, more fermented kimchi gives a richer, more complex flavour'),
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=1),'FR',
 'Faire sauter le kimchi dans l''huile de sésame 3–4 minutes jusqu''à légère caramélisation. Ajouter le gochujang et mélanger.','Le kimchi plus fermenté donne une saveur plus riche et complexe'),
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=1),'ZH_CN',
 '在芝麻油中翻炒泡菜3-4分钟至微微焦糖化，加入韩式辣酱拌匀。','使用老泡菜会带来更丰富浓郁的口味'),

((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=2),'EN',
 'Add enough water or stock to cover, bring to a boil then simmer for 15 minutes. Add firm tofu cubes in the last 5 minutes.','Do not stir after adding tofu — let it heat through gently so it does not crumble'),
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=2),'FR',
 'Ajouter assez d''eau ou de bouillon pour couvrir, porter à ébullition puis mijoter 15 minutes. Ajouter le tofu ferme en dés dans les 5 dernières minutes.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=2),'ZH_CN',
 '加入足量水或高汤至没过食材，大火烧开后小火炖15分钟，最后5分钟加入豆腐块。','加入豆腐后不要搅拌，轻轻加热以防豆腐碎散'),

((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=3),'EN',
 'Taste and adjust seasoning. Garnish with sliced spring onion. Serve in the pot directly with a bowl of rice on the side.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=3),'FR',
 'Goûter et rectifier l''assaisonnement. Garnir d''oignon nouveau. Servir dans la casserole directement avec du riz.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=9 AND step_order=3),'ZH_CN',
 '尝味调整咸淡，撒上葱花，直接连锅上桌，配白饭一起食用。',NULL),

-- ── Pad Thai ─────────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=1),'EN',
 'Soak flat rice noodles in room-temperature water for 20 minutes until pliable but still firm. Mix fish sauce, a splash of rice vinegar, and a pinch of sugar for the sauce.','Do not soak in hot water or the noodles will overcook in the wok'),
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=1),'FR',
 'Faire tremper les nouilles de riz plates dans l''eau à température ambiante 20 minutes. Mélanger sauce de poisson, vinaigre de riz et une pincée de sucre pour la sauce.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=1),'ZH_CN',
 '将宽米粉在室温水中浸泡20分钟至柔软但仍有嚼劲，用鱼露、米醋和少许糖调制酱汁。','不要用热水浸泡，否则在锅中会过熟'),

((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=2),'EN',
 'Stir-fry shrimp in a very hot wok until pink. Push to side, scramble the eggs, then add drained noodles and sauce. Toss everything together on high heat.','High heat is essential — low heat makes the noodles sticky and clumped'),
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=2),'FR',
 'Faire sauter les crevettes dans un wok très chaud jusqu''à ce qu''elles soient roses. Pousser sur le côté, brouiller les œufs, ajouter les nouilles égouttées et la sauce.','Haute chaleur essentielle — basse chaleur rend les nouilles collantes'),
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=2),'ZH_CN',
 '在极热的锅中翻炒虾仁至变红，推到一边，打散鸡蛋，加入沥干的米粉和酱汁大火翻炒均匀。','大火是关键，小火会让米粉变得粘连结块'),

((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=3),'EN',
 'Add bean sprouts and toss for 30 seconds. Serve immediately garnished with crushed peanuts, lime wedges and spring onion.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=3),'FR',
 'Ajouter les germes de soja et mélanger 30 secondes. Servir immédiatement garni de cacahuètes concassées, quartiers de citron vert et oignon nouveau.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=10 AND step_order=3),'ZH_CN',
 '加入豆芽翻炒30秒，立即盛盘，撒上碎花生、青柠角和葱花即可。',NULL),

-- ── Thai Green Curry ─────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=1),'EN',
 'Fry green curry paste in a tablespoon of coconut milk over medium heat for 2 minutes until fragrant. Add bruised lemongrass.','Frying the paste in coconut milk rather than oil is the Thai technique — it blooms the aromatics'),
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=1),'FR',
 'Frire la pâte de curry vert dans une cuillère à soupe de lait de coco à feu moyen 2 minutes jusqu''à ce qu''elle soit parfumée. Ajouter la citronnelle écrasée.','Frire la pâte dans le lait de coco est la technique thaïe — elle libère les arômes'),
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=1),'ZH_CN',
 '在一汤匙椰浆中炒绿咖喱酱2分钟至香气四溢，加入拍扁的香茅。','用椰浆而非油来炒咖喱酱是泰式技法，能更好地激发香气'),

((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=2),'EN',
 'Add coconut milk and bring to a gentle simmer. Add chicken thigh pieces and cook for 15 minutes until tender. Season with fish sauce.','Do not boil hard — a gentle simmer keeps the coconut milk from splitting'),
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=2),'FR',
 'Ajouter le lait de coco et porter à légère ébullition. Ajouter les morceaux de cuisse de poulet et cuire 15 minutes. Assaisonner avec sauce de poisson.','Ne pas faire bouillir fort — un léger frémissement évite que le lait de coco ne se sépare'),
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=2),'ZH_CN',
 '加入椰浆，小火慢炖，放入鸡腿肉块煮15分钟至熟透，用鱼露调味。','不要大火猛煮，小火慢炖可防止椰浆油水分离'),

((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=3),'EN',
 'Remove lemongrass. Serve over jasmine rice, garnished with fresh Thai basil and a sliced red chilli if desired.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=3),'FR',
 'Retirer la citronnelle. Servir sur du riz jasmin, garni de basilic thaï frais et piment rouge tranché si désiré.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=11 AND step_order=3),'ZH_CN',
 '取出香茅，盖在茉莉香米饭上，可用泰式罗勒叶和红椒片装饰。',NULL),

-- ── Egg Fried Rice ────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=1),'EN',
 'Heat peanut oil in a wok until smoking. Add spring onion whites and stir-fry for 30 seconds.','Cold, day-old rice is essential — fresh rice is too moist and clumps together'),
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=1),'FR',
 'Chauffer l''huile d''arachide dans un wok jusqu''à fumée. Ajouter les blancs d''oignon nouveau et sauter 30 secondes.','Le riz froid de la veille est essentiel — le riz frais est trop humide'),
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=1),'ZH_CN',
 '花生油在锅中烧至冒烟，加入葱白翻炒30秒。','隔夜冷饭是必须的，新鲜米饭水分太多容易结块'),

((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=2),'EN',
 'Add cold rice and press flat against the wok. Let it sit undisturbed for 1 minute to get some char. Then stir-fry vigorously. Push aside and scramble 2 eggs into the empty space.','The wok char (wok hei) is what makes fried rice taste like a restaurant dish'),
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=2),'FR',
 'Ajouter le riz froid et aplatir contre le wok. Laisser 1 minute sans toucher pour coloration. Sauter vigoureusement. Pousser de côté et brouiller 2 œufs.','Le "wok hei" (souffle du wok) est ce qui donne au riz sauté son goût de restaurant'),
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=2),'ZH_CN',
 '加入冷饭压平贴锅，静置1分钟使其略焦，再大力翻炒，推到一边后打入2个鸡蛋炒散。','锅气是让炒饭有餐厅风味的关键'),

((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=3),'EN',
 'Combine egg with rice, season with light soy sauce and a drizzle of sesame oil. Toss with spring onion greens and serve.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=3),'FR',
 'Mélanger l''œuf avec le riz, assaisonner de sauce soja claire et d''un filet d''huile de sésame. Mélanger avec les verts d''oignon nouveau et servir.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=12 AND step_order=3),'ZH_CN',
 '将炒蛋与米饭混合，加生抽和少许芝麻油调味，拌入葱绿即可装盘。',NULL),

-- ── Pork Dumplings ───────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=1),'EN',
 'Finely chop napa cabbage, salt and squeeze out water. Combine with minced pork, garlic, ginger, soy sauce, sesame oil and a splash of Shaoxing wine. Mix vigorously in one direction to build a springy texture.','Mixing in one direction aligns the proteins and gives the filling a bouncy, juicy texture'),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=1),'FR',
 'Hacher finement le chou, saler et presser pour extraire l''eau. Mélanger avec porc haché, ail, gingembre, sauce soja, huile de sésame et vin de Shaoxing. Mélanger vigoureusement dans un sens.','Mélanger dans un seul sens aligne les protéines et donne une texture rebondissante'),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=1),'ZH_CN',
 '白菜切碎腌出水分后挤干，与猪肉末、大蒜、生姜、酱油、芝麻油和少许绍兴酒混合，向一个方向用力搅拌至起胶。','朝一个方向搅拌可使蛋白质定向排列，让馅料口感Q弹多汁'),

((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=2),'EN',
 'If making dough: combine 200g flour with 100ml just-boiled water, knead until smooth, rest 30 minutes. Roll thin and cut circles. Or use store-bought dumpling wrappers.','Hot water dough is more pliable and forgiving for beginners than cold water dough'),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=2),'FR',
 'Pour la pâte maison : mélanger 200g de farine avec 100ml d''eau bouillante, pétrir, reposer 30 min. Abaisser finement et découper des disques. Ou utiliser des pâtes prêtes à l''emploi.','La pâte à l''eau chaude est plus souple pour les débutants'),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=2),'ZH_CN',
 '自制面皮：200g面粉加100ml开水揉成面团，静置30分钟后擀薄切圆片。或直接使用现成饺子皮。','热水面团比冷水面团更柔韧，对新手更友好'),

((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=3),'EN',
 'Fill, fold and pleat each wrapper. To boil: cook in batches in plenty of salted water until they float, then 2 minutes more. Or pan-fry using the water-steam technique.','Dumplings are done when they float and the wrappers look slightly translucent'),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=3),'FR',
 'Farcir, plier et plisser chaque pâte. Pour bouillir : cuire en plusieurs fournées dans beaucoup d''eau salée jusqu''à ce qu''ils flottent, puis 2 minutes de plus.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=3),'ZH_CN',
 '逐一包好饺子。煮法：分批在大量沸盐水中煮至浮起，再煮2分钟；或用水煎法煎制。','饺子浮起且皮呈半透明即为熟透'),

((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=4),'EN',
 'Serve hot with a dipping sauce of soy sauce, rice vinegar, and chilli oil to taste.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=4),'FR',
 'Servir chaud avec une sauce de trempage de sauce soja, vinaigre de riz et huile de piment selon goût.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=13 AND step_order=4),'ZH_CN',
 '趁热食用，搭配酱油、米醋和辣椒油调制的蘸料。',NULL),

-- ── Fresh Spring Rolls ───────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=1),'EN',
 'Soak rice vermicelli in warm water for 10 minutes, then drain. Cook shrimp until pink and slice in half lengthways. Prepare all fillings: lettuce, cucumber strips, fresh herbs.','Mise en place is everything for spring rolls — have everything ready before you start rolling'),
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=1),'FR',
 'Faire tremper les vermicelles de riz 10 minutes dans l''eau chaude, égoutter. Cuire les crevettes et couper en deux. Préparer toutes les garnitures.','Avoir tous les ingrédients prêts avant de commencer à rouler'),
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=1),'ZH_CN',
 '米粉用温水浸泡10分钟后沥干，虾仁煮熟后纵向对切，准备好生菜、黄瓜条和新鲜香草。','春卷的关键是提前做好所有准备，才能流畅地卷制'),

((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=2),'EN',
 'Dip one rice paper sheet in warm water for 10–15 seconds until just pliable. Lay flat. Place fillings in a horizontal line in the lower third, fold sides in, then roll tightly.','Do not soak too long — slightly firm rice paper is easier to roll and won''t tear'),
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=2),'FR',
 'Tremper une feuille de riz 10–15 secondes dans l''eau tiède jusqu''à ce qu''elle soit souple. Étaler. Placer les garnitures en ligne horizontale, replier les côtés et rouler.','Ne pas trop tremper — une feuille légèrement ferme est plus facile à rouler'),
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=2),'ZH_CN',
 '将一张米纸浸入温水10-15秒至刚刚变软，平铺后将馅料横向放在下1/3处，将两侧折入后紧紧卷起。','浸泡时间不要太长，稍硬的米纸更容易卷制且不易破裂'),

((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=3),'EN',
 'Serve immediately with a peanut dipping sauce (peanut butter thinned with fish sauce, lime juice, and a little warm water) or hoisin sauce.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=3),'FR',
 'Servir immédiatement avec une sauce aux cacahuètes (beurre de cacahuète dilué avec sauce de poisson, jus de citron vert et eau tiède) ou sauce hoisin.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=14 AND step_order=3),'ZH_CN',
 '立即食用，搭配花生蘸酱（花生酱加鱼露、青柠汁和温水调稀）或海鲜酱。',NULL),

-- ── Tom Yum Soup ─────────────────────────────────────────────────────────────
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=1),'EN',
 'Bring water or light stock to a boil. Add bruised lemongrass, sliced galangal (or ginger) and kaffir lime leaves. Simmer 10 minutes to infuse the broth.','Bruise the lemongrass by hitting with the back of a knife — this releases the essential oils'),
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=1),'FR',
 'Porter l''eau ou un bouillon léger à ébullition. Ajouter la citronnelle écrasée, le galanga tranché et les feuilles de kaffir. Mijoter 10 minutes.','Écraser la citronnelle avec le dos d''un couteau pour libérer les huiles essentielles'),
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=1),'ZH_CN',
 '水或清汤烧开，加入拍扁的香茅、薄切的南姜（或生姜）和柠檬叶，小火炖10分钟使汤底入味。','用刀背拍扁香茅，有助于释放精油'),

((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=2),'EN',
 'Add mushrooms (straw or oyster) and shrimp. Cook 3–4 minutes until shrimp are just pink. Season with fish sauce and lime juice — the soup should be hot, sour, salty and fragrant.','Balance is everything: taste as you go and adjust fish sauce (salty), lime (sour), and chilli'),
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=2),'FR',
 'Ajouter les champignons et les crevettes. Cuire 3–4 minutes. Assaisonner de sauce de poisson et jus de citron vert — la soupe doit être chaude, acide, salée et parfumée.','L''équilibre est tout : ajuster sauce de poisson, citron et piment'),
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=2),'ZH_CN',
 '加入蘑菇（草菇或平菇）和虾仁，煮3-4分钟至虾仁变红，用鱼露和青柠汁调味，汤应呈现酸辣咸香四味平衡。','口味平衡是关键，随时品尝并调整鱼露（咸）、青柠（酸）和辣椒的用量'),

((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=3),'EN',
 'Add a splash of coconut milk for the creamy tom kha style, or keep clear for classic tom yum. Garnish with fresh coriander and sliced red chilli.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=3),'FR',
 'Ajouter un filet de lait de coco pour le style tom kha crémeux, ou garder clair pour le tom yum classique. Garnir de coriandre fraîche et piment rouge tranché.',NULL),
((SELECT id FROM recipe_steps WHERE recipe_id=15 AND step_order=3),'ZH_CN',
 '可加入少许椰浆制成奶香冬阴功（Tom Kha风格），或保持清汤原味。撒上新鲜香菜和红椒片即可。',NULL);

-- ── Recipe ingredients ────────────────────────────────────────────────────────

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, optional, sort_order) VALUES
-- Miso Soup (4)
(4, 23, '500',  'ml',    false, 1),  -- Dashi Stock
(4, 21, '3',    'tbsp',  false, 2),  -- Miso Paste
(4,  9, '150',  'g',     false, 3),  -- Soft Tofu
(4, 15, '2',    'stalks',false, 4),  -- Spring Onion

-- Chicken Teriyaki (5)
(5, 30, '400',  'g',     false, 1),  -- Chicken Thighs
(5,  2, '3',    'tbsp',  false, 2),  -- Light Soy Sauce
(5, 22, '3',    'tbsp',  false, 3),  -- Mirin
(5, 25, '1',    'tbsp',  true,  4),  -- Sesame Seeds
(5, 14, '1',    'tsp',   true,  5),  -- Ginger

-- Gyoza (6)
(6, 11, '300',  'g',     false, 1),  -- Minced Pork
(6, 19, '200',  'g',     false, 2),  -- Napa Cabbage
(6, 13, '3',    'cloves',false, 3),  -- Garlic
(6, 14, '1',    'tbsp',  false, 4),  -- Ginger
(6,  6, '1',    'tbsp',  false, 5),  -- Sesame Oil
(6,  2, '2',    'tbsp',  false, 6),  -- Soy Sauce

-- Bibimbap (7)
(7, 26, '300',  'g',     false, 1),  -- Rice
(7, 31, '200',  'g',     false, 2),  -- Beef Sirloin
(7, 12, '2',    'eggs',  false, 3),  -- Egg
(7, 24, '2',    'tbsp',  false, 4),  -- Gochujang
(7,  6, '2',    'tbsp',  false, 5),  -- Sesame Oil
(7, 25, '1',    'tbsp',  true,  6),  -- Sesame Seeds

-- Bulgogi (8)
(8, 31, '400',  'g',     false, 1),  -- Beef Sirloin
(8,  2, '3',    'tbsp',  false, 2),  -- Soy Sauce
(8,  6, '1',    'tbsp',  false, 3),  -- Sesame Oil
(8, 13, '4',    'cloves',false, 4),  -- Garlic
(8, 14, '1',    'tsp',   false, 5),  -- Ginger
(8, 25, '1',    'tbsp',  true,  6),  -- Sesame Seeds

-- Kimchi Jjigae (9)
(9, 34, '300',  'g',     false, 1),  -- Kimchi
(9, 10, '200',  'g',     false, 2),  -- Firm Tofu
(9, 15, '3',    'stalks',false, 3),  -- Spring Onion
(9, 24, '1',    'tbsp',  false, 4),  -- Gochujang
(9,  6, '1',    'tbsp',  false, 5),  -- Sesame Oil

-- Pad Thai (10)
(10, 32, '200', 'g',     false, 1),  -- Rice Noodles
(10, 35, '200', 'g',     false, 2),  -- Shrimp
(10, 33, '100', 'g',     false, 3),  -- Bean Sprouts
(10, 12, '2',   'eggs',  false, 4),  -- Egg
(10,  5, '2',   'tbsp',  false, 5),  -- Fish Sauce
(10,  6, '1',   'tbsp',  false, 6),  -- Sesame Oil

-- Thai Green Curry (11)
(11, 30, '500', 'g',     false, 1),  -- Chicken Thighs
(11, 27, '400', 'ml',    false, 2),  -- Coconut Milk
(11, 28, '3',   'tbsp',  false, 3),  -- Green Curry Paste
(11, 29, '2',   'stalks',false, 4),  -- Lemongrass
(11,  5, '2',   'tbsp',  false, 5),  -- Fish Sauce

-- Egg Fried Rice (12)
(12, 26, '300', 'g',     false, 1),  -- Rice (day-old)
(12, 12, '2',   'eggs',  false, 2),  -- Egg
(12, 15, '3',   'stalks',false, 3),  -- Spring Onion
(12,  2, '2',   'tbsp',  false, 4),  -- Soy Sauce
(12, 18, '2',   'tbsp',  false, 5),  -- Peanut Oil
(12,  6, '1',   'tsp',   true,  6),  -- Sesame Oil

-- Pork Dumplings (13)
(13, 11, '400', 'g',     false, 1),  -- Minced Pork
(13, 19, '300', 'g',     false, 2),  -- Napa Cabbage
(13, 13, '3',   'cloves',false, 3),  -- Garlic
(13, 14, '1',   'tbsp',  false, 4),  -- Ginger
(13,  2, '2',   'tbsp',  false, 5),  -- Soy Sauce
(13,  1, '1',   'tbsp',  true,  6),  -- Shaoxing Wine

-- Fresh Spring Rolls (14)
(14, 32, '100', 'g',     false, 1),  -- Rice Noodles (vermicelli)
(14, 35, '200', 'g',     false, 2),  -- Shrimp
(14, 33, '100', 'g',     false, 3),  -- Bean Sprouts
(14,  5, '2',   'tbsp',  false, 4),  -- Fish Sauce (for dipping sauce)

-- Tom Yum Soup (15)
(15, 35, '300', 'g',     false, 1),  -- Shrimp
(15, 29, '3',   'stalks',false, 2),  -- Lemongrass
(15,  5, '3',   'tbsp',  false, 3),  -- Fish Sauce
(15, 27, '100', 'ml',    true,  4);  -- Coconut Milk (optional, for tom kha style)

SELECT setval('recipes_id_seq', (SELECT MAX(id) FROM recipes));
SELECT setval('recipe_translations_id_seq', (SELECT MAX(id) FROM recipe_translations));
SELECT setval('recipe_steps_id_seq', (SELECT MAX(id) FROM recipe_steps));
SELECT setval('recipe_step_translations_id_seq', (SELECT MAX(id) FROM recipe_step_translations));
SELECT setval('recipe_ingredients_id_seq', (SELECT MAX(id) FROM recipe_ingredients));
