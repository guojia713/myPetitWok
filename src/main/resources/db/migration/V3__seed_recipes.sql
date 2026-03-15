-- ============================================================
-- V3: Seed recipes
-- 3 starter recipes: Mapo Tofu, Kung Pao Chicken, Vietnamese
-- Pho Bo (Beef Pho) — all fully translated EN/FR/ZH-CN
-- ============================================================

-- ── RECIPE 1: Mapo Tofu (麻婆豆腐) ──────────────────────────────────────────

INSERT INTO recipes (id, cuisine_type, difficulty, prep_time_minutes, cook_time_minutes, servings, spice_level, published)
VALUES (1, 'CHINESE', 'BEGINNER', 10, 15, 2, 4, true);

INSERT INTO recipe_translations (recipe_id, language, name, description, phonetic) VALUES
(1, 'EN',    'Mapo Tofu',
 'A classic Sichuan dish of silken tofu in a spicy, numbing sauce with minced pork. One of China''s most famous dishes — bold, fiery, and deeply satisfying.',
 'Má pó dòufu'),
(1, 'FR',    'Mapo Tofu',
 'Un classique sichuanais : tofu soyeux dans une sauce épicée et anesthésiante avec du porc haché. L''un des plats les plus célèbres de Chine — audacieux, ardent et profondément savoureux.',
 'Má pó dòufu'),
(1, 'ZH_CN', '麻婆豆腐',
 '四川经典名菜，嫩豆腐配猪肉末在麻辣鲜香的酱汁中烹制而成，是中国最著名的菜肴之一。',
 NULL);

-- Mapo Tofu ingredients
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, optional, sort_order) VALUES
(1, 9,  '400',  'g',   false, 1),   -- Soft Tofu
(1, 11, '150',  'g',   false, 2),   -- Minced Pork
(1, 4,  '2',    'tbsp',false, 3),   -- Doubanjiang
(1, 2,  '1',    'tbsp',false, 4),   -- Light Soy Sauce
(1, 1,  '1',    'tbsp',false, 5),   -- Shaoxing Wine
(1, 17, '1',    'tbsp',false, 6),   -- Cornstarch
(1, 13, '3',    'cloves',false, 7), -- Garlic
(1, 14, '1',    'thumb',false, 8),  -- Ginger
(1, 15, '3',    'stalks',false, 9), -- Spring Onion
(1, 8,  '1',    'tsp', true,  10),  -- Sichuan Peppercorn (optional)
(1, 18, '2',    'tbsp',false, 11),  -- Peanut Oil
(1, 6,  '1',    'tsp', false, 12);  -- Sesame Oil

-- Mapo Tofu steps
INSERT INTO recipe_steps (id, recipe_id, step_order, duration_minutes) VALUES
(1, 1, 1, 2),
(2, 1, 2, 3),
(3, 1, 3, 5),
(4, 1, 4, 3),
(5, 1, 5, 2);

INSERT INTO recipe_step_translations (step_id, language, instruction, tip) VALUES
-- Step 1: Prep
(1,'EN','Cut the tofu into 2cm cubes. Mince the garlic and ginger finely. Slice the spring onions, separating the white and green parts. Mix cornstarch with 2 tbsp cold water to make a slurry.',
 'Handle the soft tofu gently — it breaks easily. Use a spoon rather than your hands to move it.'),
(1,'FR','Coupez le tofu en cubes de 2cm. Hachez finement l''ail et le gingembre. Émincez les oignons nouveaux en séparant les parties blanches et vertes. Mélangez la fécule avec 2 c. à soupe d''eau froide.',
 'Manipulez le tofu soyeux délicatement — il se brise facilement. Utilisez une cuillère plutôt que vos mains.'),
(1,'ZH_CN','将豆腐切成2厘米的小块。将大蒜和生姜切末。将葱切段，葱白葱绿分开。将淀粉与2汤匙冷水混合调成水淀粉。',
 '嫩豆腐质地细腻，切割时请轻拿轻放，建议用勺子辅助移动。'),

-- Step 2: Brown the pork
(2,'EN','Heat peanut oil in a wok over high heat until smoking. Add the minced pork and stir-fry for 2-3 minutes until browned and slightly crispy. Add the Shaoxing wine and stir briefly.',
 'The key is HIGH heat. You want the pork to brown and crisp, not steam. Don''t move it for the first 30 seconds.'),
(2,'FR','Chauffez l''huile d''arachide dans un wok à feu vif jusqu''à ce qu''elle fume. Ajoutez le porc haché et faites sauter 2-3 minutes jusqu''à ce qu''il soit doré et légèrement croustillant. Ajoutez le vin de Shaoxing.',
 'La clé est la CHALEUR ÉLEVÉE. Le porc doit être doré et croustillant, pas cuit à la vapeur. Ne le remuez pas pendant les 30 premières secondes.'),
(2,'ZH_CN','大火将花生油烧至冒烟，下猪肉末翻炒2-3分钟至焦黄微脆，沿锅边淋入绍兴酒快速翻炒均匀。',
 '关键在于大火！要让猪肉炒香变脆，而不是蒸熟。下锅后前30秒不要翻动。'),

-- Step 3: Build the sauce
(3,'EN','Push the pork to the side of the wok. Add the doubanjiang and stir-fry in the oil for 1 minute — you will see the oil turn a beautiful red colour. Add garlic, ginger, and white parts of spring onion. Stir everything together.',
 'This step is called "blooming" the doubanjiang. The fat-soluble colour and flavour compounds need heat to release. Don''t rush it.'),
(3,'FR','Poussez le porc sur le côté du wok. Ajoutez le doubanjiang et faites sauter dans l''huile pendant 1 minute — l''huile deviendra d''une belle couleur rouge. Ajoutez l''ail, le gingembre et les parties blanches des oignons nouveaux.',
 'Cette étape s''appelle "faire fleurir" le doubanjiang. Les composés de couleur et de saveur liposolubles ont besoin de chaleur pour se libérer.'),
(3,'ZH_CN','将猪肉拨到锅边，下豆瓣酱用底油翻炒1分钟，你会看到油脂变成漂亮的红色。加入蒜末、姜末和葱白翻炒均匀。',
 '这一步叫做"炒红油"。豆瓣酱中的脂溶性色素和风味物质需要高温才能充分释放，不要着急。'),

-- Step 4: Add tofu
(4,'EN','Add 200ml water or stock. Add the soy sauce. Gently slide in the tofu cubes — do not stir vigorously or they will break. Shake the wok gently to move the tofu around. Simmer for 4-5 minutes to absorb the sauce.',
 'Instead of stirring, tilt and swirl the wok. Or use a spoon to gently push sauce over the tofu. The goal is intact tofu pieces coated in sauce.'),
(4,'FR','Ajoutez 200ml d''eau ou de bouillon. Ajoutez la sauce soja. Glissez délicatement les cubes de tofu — ne remuez pas vigoureusement sinon ils se briseront. Secouez doucement le wok. Mijotez 4-5 minutes.',
 'Au lieu de remuer, inclinez et faites tourner le wok. Ou utilisez une cuillère pour arroser doucement le tofu de sauce. L''objectif est des morceaux de tofu intacts enrobés de sauce.'),
(4,'ZH_CN','加入200毫升清水或高汤，倒入生抽，轻轻将豆腐滑入锅中，不要大力翻炒以免豆腐碎裂。轻轻晃动锅子让豆腐与酱汁充分接触，小火炖煮4-5分钟使豆腐入味。',
 '不要用铲子搅拌，而是通过晃动锅子来让豆腐移动。也可以用汤匙轻轻将酱汁浇在豆腐上。目标是保持豆腐形状完整并裹满酱汁。'),

-- Step 5: Finish
(5,'EN','Pour the cornstarch slurry around the edge of the wok and gently fold in — the sauce will thicken in about 30 seconds. Drizzle sesame oil over the top. Plate up and garnish with the green parts of spring onion and ground Sichuan peppercorn.',
 'Add the slurry gradually — you may not need all of it. The sauce should coat the tofu, not be gloopy. Taste and adjust seasoning.'),
(5,'FR','Versez la fécule délayée sur le bord du wok et incorporez délicatement — la sauce épaissira en 30 secondes environ. Arrosez d''huile de sésame. Dressez et garnissez avec les parties vertes des oignons nouveaux et le poivre du Sichuan moulu.',
 'Ajoutez la fécule progressivement — vous n''en aurez peut-être pas besoin en totalité. La sauce doit napper le tofu, pas être collante.'),
(5,'ZH_CN','将水淀粉沿锅边淋入，轻轻翻匀，酱汁约30秒后即可浓稠。淋上香油，装盘后撒上葱绿和花椒粉即可上桌。',
 '水淀粉要分次加入，不一定全部用完。酱汁应该浓稠地裹住豆腐，而不是黏糊糊的。出锅前尝一下味道，按需调整。');


-- ── RECIPE 2: Kung Pao Chicken (宫保鸡丁) ────────────────────────────────────

INSERT INTO recipes (id, cuisine_type, difficulty, prep_time_minutes, cook_time_minutes, servings, spice_level, published)
VALUES (2, 'CHINESE', 'BEGINNER', 20, 10, 2, 3, true);

INSERT INTO recipe_translations (recipe_id, language, name, description, phonetic) VALUES
(2, 'EN',    'Kung Pao Chicken',
 'A beloved Sichuan stir-fry of tender chicken, crunchy peanuts, and dried chillies in a sweet, sour, and spicy sauce. One of the most popular Chinese dishes worldwide.',
 'Gōng bǎo jī dīng'),
(2, 'FR',    'Poulet Kung Pao',
 'Un sauté sichuanais adoré : poulet tendre, cacahuètes croquantes et piments séchés dans une sauce douce-acide et épicée. L''un des plats chinois les plus appréciés dans le monde.',
 'Gōng bǎo jī dīng'),
(2, 'ZH_CN', '宫保鸡丁',
 '深受喜爱的四川炒菜，嫩滑鸡丁配香脆花生和干辣椒，在酸甜麻辣的酱汁中翻炒而成，是全球最受欢迎的中国菜之一。',
 NULL);

-- Kung Pao ingredients
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, optional, sort_order) VALUES
(2, 12, '400',  'g',    false, 1),  -- Chicken breast (using egg entity as proxy)
(2, 2,  '2',    'tbsp', false, 2),  -- Light Soy Sauce
(2, 1,  '1',    'tbsp', false, 3),  -- Shaoxing Wine
(2, 17, '1',    'tbsp', false, 4),  -- Cornstarch
(2, 7,  '1',    'tbsp', false, 5),  -- Rice Vinegar
(2, 13, '3',    'cloves', false, 6), -- Garlic
(2, 14, '1',    'thumb', false, 7), -- Ginger
(2, 15, '2',    'stalks', false, 8),-- Spring Onion
(2, 8,  '1',    'tsp',  true,  9),  -- Sichuan Peppercorn
(2, 18, '3',    'tbsp', false, 10), -- Peanut Oil
(2, 6,  '1',    'tsp',  false, 11); -- Sesame Oil

-- Kung Pao steps
INSERT INTO recipe_steps (id, recipe_id, step_order, duration_minutes) VALUES
(6, 2, 1, 15),
(7, 2, 2, 2),
(8, 2, 3, 5),
(9, 2, 4, 2);

INSERT INTO recipe_step_translations (step_id, language, instruction, tip) VALUES
(6,'EN','Cut chicken breast into 2cm cubes. Marinate with 1 tbsp soy sauce, Shaoxing wine, and cornstarch for 15 minutes. Make the sauce: mix remaining soy sauce, rice vinegar, a pinch of sugar, and 1 tsp cornstarch in a small bowl.',
 'The cornstarch in the marinade is key — it creates a velvety coating called "velveting" that keeps the chicken tender during the high-heat stir-fry.'),
(6,'FR','Coupez le blanc de poulet en cubes de 2cm. Faites mariner avec 1 c. à soupe de sauce soja, le vin de Shaoxing et la fécule pendant 15 minutes. Préparez la sauce : mélangez le reste de sauce soja, vinaigre de riz, une pincée de sucre et 1 c. à café de fécule.',
 'La fécule dans la marinade est essentielle — elle crée un enrobage soyeux qui garde le poulet tendre pendant la cuisson à feu vif.'),
(6,'ZH_CN','将鸡胸肉切成2厘米的小丁，加入1汤匙生抽、绍兴酒和淀粉腌制15分钟。调制酱汁：将剩余生抽、米醋、少许白糖和1茶匙淀粉混合备用。',
 '腌料中加入淀粉是关键，这就是"上浆"技法，能让鸡肉在高温炒制时保持嫩滑。'),

(7,'EN','Heat the wok until smoking. Add oil and stir-fry dried chillies and Sichuan peppercorns for 30 seconds until fragrant (be careful not to burn them). Add the marinated chicken in a single layer and do not move for 1 minute.',
 'The chillies will darken quickly — this is correct. You want them fragrant and slightly charred, not bright red and raw. Watch carefully.'),
(7,'FR','Chauffez le wok jusqu''à ce qu''il fume. Ajoutez l''huile et faites sauter les piments séchés et le poivre du Sichuan pendant 30 secondes (attention à ne pas brûler). Ajoutez le poulet mariné en une seule couche et ne remuez pas pendant 1 minute.',
 'Les piments vont foncer rapidement — c''est normal. Vous voulez qu''ils soient parfumés et légèrement carbonisés. Surveillez attentivement.'),
(7,'ZH_CN','大火将锅烧至冒烟，下油后加入干辣椒和花椒，炒香30秒（注意不要炒糊）。将腌好的鸡丁平铺入锅，静置1分钟不要翻动。',
 '干辣椒会很快变色，这是正常的。你想要的是香而微焦的效果，而不是鲜红生辣的状态。要仔细观察火候。'),

(8,'EN','Stir-fry the chicken until just cooked through, about 2-3 minutes total. Add garlic, ginger, and white parts of spring onion. Stir-fry 30 seconds. Pour in the sauce and toss everything together until glossy.',
 NULL),
(8,'FR','Faites sauter le poulet jusqu''à ce qu''il soit juste cuit, environ 2-3 minutes au total. Ajoutez l''ail, le gingembre et les parties blanches des oignons nouveaux. Sautez 30 secondes. Versez la sauce et mélangez jusqu''à ce que tout soit brillant.',
 NULL),
(8,'ZH_CN','继续翻炒鸡丁至完全熟透，共约2-3分钟。加入蒜末、姜末和葱白，炒香30秒后倒入调好的酱汁，大火翻炒至酱汁均匀包裹食材且发出亮泽光。',
 NULL),

(9,'EN','Add roasted peanuts and toss briefly. Drizzle with sesame oil. Plate and garnish with green spring onion. Serve immediately with steamed rice.',
 'Add peanuts at the very end — they should stay crunchy. If you add them too early they will go soft in the sauce.'),
(9,'FR','Ajoutez les cacahuètes grillées et mélangez brièvement. Arrosez d''huile de sésame. Dressez et garnissez avec les oignons verts. Servez immédiatement avec du riz cuit à la vapeur.',
 'Ajoutez les cacahuètes à la toute fin — elles doivent rester croquantes. Si vous les ajoutez trop tôt, elles ramolliront dans la sauce.'),
(9,'ZH_CN','加入炒熟的花生米快速翻炒均匀，淋上香油，撒上葱绿，立即与米饭一起上桌。',
 '花生米要最后放，这样才能保持酥脆。如果放太早，花生会在酱汁中变软。');


-- ── RECIPE 3: Vietnamese Beef Pho (Phở Bò) ───────────────────────────────────

INSERT INTO recipes (id, cuisine_type, difficulty, prep_time_minutes, cook_time_minutes, servings, spice_level, published)
VALUES (3, 'VIETNAMESE', 'INTERMEDIATE', 30, 180, 4, 1, true);

INSERT INTO recipe_translations (recipe_id, language, name, description, phonetic) VALUES
(3, 'EN',    'Vietnamese Beef Pho',
 'Vietnam''s most iconic dish — a deeply aromatic beef broth with silky rice noodles, tender beef slices, and fresh herbs. The slow-cooked broth is the heart of this dish.',
 'Phở bò'),
(3, 'FR',    'Phở au Bœuf Vietnamien',
 'Le plat le plus emblématique du Vietnam — un bouillon de bœuf profondément aromatique avec des nouilles de riz soyeuses, des tranches de bœuf tendres et des herbes fraîches.',
 'Phở bò'),
(3, 'ZH_CN', '越南牛肉河粉',
 '越南最具代表性的菜肴——香气四溢的牛肉清汤，配以嫩滑的米粉、薄切牛肉片和新鲜香草。慢炖高汤是这道菜的精髓所在。',
 NULL);

-- Pho ingredients
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, optional, sort_order) VALUES
(3, 13, '5',    'cloves', false, 1),  -- Garlic
(3, 14, '1',    'large',  false, 2),  -- Ginger
(3, 2,  '3',    'tbsp',   false, 3),  -- Light Soy Sauce
(3, 5,  '2',    'tbsp',   false, 4),  -- Fish Sauce
(3, 15, '4',    'stalks', false, 5),  -- Spring Onion
(3, 6,  '1',    'tsp',    true,  6);  -- Sesame Oil (optional garnish)

-- Pho steps
INSERT INTO recipe_steps (id, recipe_id, step_order, duration_minutes) VALUES
(10, 3, 1, 5),
(11, 3, 2, 180),
(12, 3, 3, 10),
(13, 3, 4, 5);

INSERT INTO recipe_step_translations (step_id, language, instruction, tip) VALUES
(10,'EN','Char the ginger and onion directly over a gas flame or under a grill until blackened on the outside (about 5 minutes). This gives the broth its distinctive smoky sweetness. Toast the spices (star anise, cinnamon stick, cloves, cardamom) in a dry pan for 2 minutes until fragrant.',
 'Do not skip the charring step! It is what separates a proper pho broth from plain beef stock. The blackened exterior gives colour and a complex, slightly caramelised flavour.'),
(10,'FR','Faites brûler le gingembre et l''oignon directement sur une flamme à gaz ou sous le gril jusqu''à ce qu''ils soient noircis à l''extérieur (environ 5 minutes). Cela donne au bouillon sa douceur fumée distinctive. Faites griller les épices (badiane, cannelle, clous de girofle, cardamome) à sec 2 minutes.',
 'Ne sautez pas l''étape de la carbonisation ! C''est ce qui différencie un vrai bouillon pho d''un simple bouillon de bœuf. L''extérieur noirci donne la couleur et une saveur complexe légèrement caramélisée.'),
(10,'ZH_CN','将生姜和洋葱直接在明火上或烤架下烤至表面焦黑（约5分钟），这一步赋予高汤独特的焦香甜味。将香料（八角、桂皮、丁香、豆蔻）在干锅中炒香2分钟。',
 '千万不要跳过炭烤这个步骤！正是这一步让越南河粉的汤底有别于普通牛肉清汤。焦黑的表皮带来色泽和复杂的焦糖风味。'),

(11,'EN','Place beef bones in a large pot, cover with water and bring to a boil. Drain and rinse the bones (this removes impurities). Return bones to pot with 3 litres fresh water. Add charred ginger and onion, toasted spices, fish sauce, and soy sauce. Simmer on the lowest heat for 2.5-3 hours.',
 'The lower and slower, the clearer and more flavourful your broth will be. Never let it boil vigorously — this makes the broth cloudy. Skim any foam that rises to the surface during the first 30 minutes.'),
(11,'FR','Placez les os de bœuf dans une grande casserole, couvrez d''eau et portez à ébullition. Égouttez et rincez les os (pour enlever les impuretés). Remettez dans la casserole avec 3 litres d''eau fraîche. Ajoutez le gingembre et l''oignon carbonisés, les épices, la sauce de poisson et la sauce soja. Mijotez à feu très doux 2h30-3h.',
 'Plus c''est lent et doux, plus votre bouillon sera clair et savoureux. Ne jamais faire bouillir vigoureusement — cela rend le bouillon trouble. Écumez toute mousse qui remonte à la surface pendant les 30 premières minutes.'),
(11,'ZH_CN','将牛骨放入大锅中，加水大火煮沸后倒掉水分并冲洗干净（去除杂质）。重新加入3升清水，放入烤好的生姜和洋葱、香料、鱼露和生抽。用最小火慢炖2.5-3小时。',
 '火越小越慢，汤底越清澈越鲜美。切勿让汤底大沸，否则汤会变浑浊。煮开后前30分钟要不断撇去浮沫。'),

(12,'EN','Cook rice noodles according to packet instructions (usually 5-8 minutes in boiling water). Drain and divide between 4 bowls. Thinly slice raw beef sirloin against the grain. Strain the broth through a fine sieve and taste — adjust with more fish sauce for saltiness.',
 'Slice the beef as thin as possible — 2-3mm. The hot broth poured over will cook it to perfect medium-rare. If slicing is difficult, freeze the beef for 30 minutes first to firm it up.'),
(12,'FR','Faites cuire les nouilles de riz selon les instructions du paquet (généralement 5-8 minutes). Égouttez et répartissez dans 4 bols. Tranchez finement le rumsteck cru dans le sens contraire du grain. Filtrez le bouillon et ajustez l''assaisonnement avec de la sauce de poisson.',
 'Tranchez le bœuf le plus fin possible — 2-3mm. Le bouillon chaud versé dessus le cuira à la perfection saignant. Si le découpage est difficile, congelez le bœuf 30 minutes d''abord pour le raffermir.'),
(12,'ZH_CN','按照包装说明煮熟米粉（通常在沸水中煮5-8分钟），沥干后分装在4个碗中。将生牛里脊逆纹切成极薄的片。用细筛过滤高汤，尝味后用鱼露调整咸淡。',
 '牛肉要切得尽量薄，约2-3毫米。热腾腾的汤底倒入后就能将牛肉烫至完美的五分熟。如果不好切，可以先将牛肉冷冻30分钟使其变硬后再切。'),

(13,'EN','Bring the strained broth to a rolling boil. Arrange raw beef slices on top of the noodles, then ladle the boiling broth directly over the beef — it will cook instantly. Serve with a plate of fresh bean sprouts, Thai basil, lime wedges, and sliced chilli on the side.',
 'The broth must be at a ROLLING BOIL when you pour it over the raw beef. If it''s just warm, the beef won''t cook properly. Eat immediately while the broth is piping hot.'),
(13,'FR','Portez le bouillon filtré à pleine ébullition. Disposez les tranches de bœuf cru sur les nouilles, puis versez le bouillon bouillant directement dessus — il cuira instantanément. Servez avec une assiette de germes de soja frais, basilic thaï, quartiers de citron vert et piment émincé.',
 'Le bouillon doit être à PLEINE ÉBULLITION quand vous le versez sur le bœuf cru. S''il est seulement chaud, le bœuf ne cuira pas correctement. Mangez immédiatement pendant que le bouillon est fumant.'),
(13,'ZH_CN','将过滤好的高汤大火烧至沸腾。将生牛肉片铺在米粉上，然后将滚烫的汤底直接浇在牛肉上——牛肉会瞬间被烫熟。搭配一盘新鲜豆芽、泰国罗勒、青柠角和辣椒片一起上桌。',
 '浇汤时高汤必须保持大沸状态，否则生牛肉无法被充分烫熟。请立即趁热享用。');

-- ── Reset sequences ───────────────────────────────────────────────────────────
SELECT setval('recipes_id_seq',              (SELECT MAX(id) FROM recipes));
SELECT setval('recipe_translations_id_seq',  (SELECT MAX(id) FROM recipe_translations));
SELECT setval('recipe_ingredients_id_seq',   (SELECT MAX(id) FROM recipe_ingredients));
SELECT setval('recipe_steps_id_seq',         (SELECT MAX(id) FROM recipe_steps));
SELECT setval('recipe_step_translations_id_seq', (SELECT MAX(id) FROM recipe_step_translations));
