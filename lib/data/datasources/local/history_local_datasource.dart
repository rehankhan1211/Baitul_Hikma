import '../../models/history_chapter_model.dart';

/// Sample Islamic history content for demonstration.
/// All historical content is based on established scholarly sources.
class HistoryLocalDataSource {
  HistoryLocalDataSource._();

  static List<HistoryChapter> get chapters => [
    const HistoryChapter(
      id: 'arabia-before-islam',
      title: 'Arabia Before the Dawn',
      subtitle: 'The World That Islam Changed',
      era: Era.preIslamic,
      eraLabel: 'Pre-Islamic Era',
      period: 'Before 610 CE',
      order: 1,
      readingTimeMinutes: 8,
      introduction:
          'Before the revelation, Arabia was a world of stark contrasts — breathtaking desert beauty alongside deep moral darkness. Understanding this era illuminates the transformative power of the message that was to come.',
      keyFigures: [
        'Hashim ibn Abd Manaf',
        'Abd al-Muttalib',
        'Khadijah bint Khuwaylid',
      ],
      keyEvents: [
        'Year of the Elephant (570 CE)',
        'Rebuilding of the Kaabah',
        'The Hilf al-Fudul (Alliance of the Virtuous)',
      ],
      sections: [
        HistorySection(
          heading: 'The Arabian Peninsula',
          content:
              'The Arabian Peninsula in the sixth century CE was a vast landscape of contrasts — scorching deserts, fertile valleys, and bustling trade routes connecting the Byzantine and Persian empires. The Hijaz region, home to Makkah and Madinah, held a unique religious and economic significance that few other places on earth could match.\n\nMakkah, nestled between barren hills, was not a city of agriculture or natural resources. Its importance was entirely spiritual and commercial — centered on the ancient Kaabah, the House built, according to Islamic tradition, by Prophet Ibrahim and his son Ismail. Tribes from across Arabia would journey to Makkah during sacred months, creating an extraordinary marketplace of goods, poetry, and ideas.',
          pullQuote:
              'Makkah\'s power lay not in its geography but in the sacred memory it carried.',
        ),
        HistorySection(
          heading: 'The Age of Ignorance (Al-Jahiliyyah)',
          content:
              'Arab society before Islam is referred to as the Age of Ignorance — not a lack of intelligence, but a moral and spiritual darkness. Tribal loyalty superseded all else. Blood feuds could span generations. Female infanticide was practiced. Social inequality was entrenched, with slavery deeply embedded in the economic order.\n\nYet this era also produced extraordinary literature. The Mu\'allaqat — seven odes hung on the Kaabah — represent the pinnacle of pre-Islamic poetry. Arab society, though morally fractured, possessed a rich oral tradition, a deep sense of honor (though often misdirected), and a hospitality culture that Islam would refine and elevate rather than erase.',
          pullQuote:
              'The pre-Islamic Arab had every virtue — except the guidance to direct it.',
        ),
        HistorySection(
          heading: 'The Tribe of Quraysh',
          content:
              'Among all Arabian tribes, the Quraysh held a special position. As custodians of the Kaabah, they enjoyed prestige, religious authority, and economic dominance. Their trade caravans journeyed north to Syria in summer and south to Yemen in winter — journeys mentioned in the Quran itself (Surah Quraysh, 106:1-2).\n\nWithin Quraysh, the clan of Banu Hashim was known for its generosity and moral integrity. It was into this noble lineage that the final Prophet would be born — a birth that would change the world forever.',
        ),
        HistorySection(
          heading: 'The Year of the Elephant',
          content:
              'In 570 CE — the year scholars widely accept as the birth year of the Prophet Muhammad ﷺ — an extraordinary event took place. Abraha, the Abyssinian governor of Yemen, led a massive army with war elephants toward Makkah with the intention of destroying the Kaabah. The Quraysh, unable to defend their city, fled to the hills.\n\nBut the army never reached the Kaabah. According to the Quran (Surah Al-Fil, 105), Allah sent flocks of birds (Ababil) who pelted the army with stones, destroying it before it could reach the sacred house. The year became known as Aam al-Fil — The Year of the Elephant — and its profound significance would only grow when it became understood as the year of the Prophet\'s birth.',
          pullQuote:
              'The House was defended not by the armies of men, but by the birds of Allah.',
        ),
      ],
    ),
    const HistoryChapter(
      id: 'birth-of-prophet',
      title: 'The Beloved is Born',
      subtitle: 'The Life of Prophet Muhammad ﷺ — Early Years',
      era: Era.propheticMecca,
      eraLabel: 'Prophetic Era — Makkah',
      period: '570–610 CE',
      order: 2,
      readingTimeMinutes: 10,
      introduction:
          'Into a world that had lost its spiritual compass, the most beloved of all creation was born. The early life of Prophet Muhammad ﷺ, before revelation, is a story of profound character, divine protection, and preparation for the greatest mission in human history.',
      keyFigures: [
        'Muhammad ibn Abdullah ﷺ',
        'Aminah bint Wahb (mother)',
        'Halimah as-Sa\'diyyah (foster mother)',
        'Abd al-Muttalib (grandfather)',
        'Abu Talib (uncle)',
        'Khadijah bint Khuwaylid',
      ],
      keyEvents: [
        'Birth of the Prophet ﷺ (570 CE)',
        'Death of his mother Aminah (576 CE)',
        'Journey to Syria with Abu Talib (582 CE)',
        'Hilf al-Fudul — Alliance of the Virtuous',
        'Marriage to Khadijah (595 CE)',
        'Rebuilding of the Kaabah (605 CE)',
        'Revelation begins on Laylat al-Qadr (610 CE)',
      ],
      sections: [
        HistorySection(
          heading: 'A Child Born to Change the World',
          content:
              'Muhammad ﷺ was born in Makkah, in the Year of the Elephant, into the noble Banu Hashim clan of the Quraysh. His father, Abdullah ibn Abd al-Muttalib, had died before his birth — a loss that would shape his early life. His mother, Aminah bint Wahb, raised him with love and care, though their time together would be heartbreakingly brief.\n\nFollowing the Arab custom of strengthening children in the pure desert air, the infant Muhammad ﷺ was given to the care of Halimah as-Sa\'diyyah, a woman from the Banu Sa\'d tribe. The years with Halimah are remembered in Islamic tradition as extraordinary — blessed years in which her family experienced unusual abundance and wellbeing.',
          pullQuote: 'He came as a mercy to all the worlds.',
        ),
        HistorySection(
          heading: 'Al-Amin — The Trustworthy',
          content:
              'As Muhammad ﷺ grew into a young man, he was distinguished by a character so remarkable that his community gave him a title that has echoed through history: Al-Amin — The Trustworthy. In a society where deception in trade and personal dealings was common, his honesty was exceptional.\n\nHe worked in trade, and his reputation was such that Khadijah bint Khuwaylid — a successful businesswoman of Makkah — sought him out to manage her trade caravans. What she witnessed in his character led her to propose marriage, despite being fifteen years his senior. Their marriage, which lasted 25 years until her death, was one of the great partnerships in human history — a union of deep love, mutual respect, and shared mission.',
          pullQuote:
              'Even before revelation, truth was the foundation of his character.',
        ),
        HistorySection(
          heading: 'The Cave of Hira',
          content:
              'As the Prophet ﷺ approached his fortieth year, he increasingly retreated to a cave on Mount Hira, outside Makkah, for contemplation and worship. There, in the blessed nights of Ramadan, 610 CE, everything changed.\n\nThe Angel Jibreel appeared to him, bringing the first words of the Quran: "Read! In the name of your Lord who created..." (96:1). The Prophet ﷺ returned home trembling, and it was the calm, wise Khadijah who first comforted him, wrapped him in a garment, and said the words that would sustain him: "By Allah, Allah will never disgrace you. You uphold family ties, you speak truthfully, you help the destitute, you assist the guest, and you support those affected by hardship."\n\nThe mission had begun. The world would never be the same.',
        ),
      ],
    ),
    const HistoryChapter(
      id: 'hijra-to-madina',
      title: 'The Great Migration',
      subtitle: 'Al-Hijrah — From Makkah to Madinah',
      era: Era.propheticMadina,
      eraLabel: 'Prophetic Era — Madinah',
      period: '622–632 CE',
      order: 4,
      readingTimeMinutes: 9,
      introduction:
          'The Hijrah was not merely a change of geography — it was the turning point of history. When the Prophet ﷺ and his companions left Makkah, they carried with them a vision for a new kind of society. In Madinah, that vision would be built.',
      keyFigures: [
        'Prophet Muhammad ﷺ',
        'Abu Bakr as-Siddiq',
        'Ali ibn Abi Talib',
        'Asma bint Abi Bakr',
        'Abdullah ibn Urayqit (the guide)',
      ],
      keyEvents: [
        'First Pledge of Aqabah (621 CE)',
        'Second Pledge of Aqabah (622 CE)',
        'The Hijrah journey (September 622 CE)',
        'Constitution of Madinah',
        'Construction of Masjid an-Nabawi',
        'Battle of Badr (624 CE)',
      ],
      sections: [
        HistorySection(
          heading: 'The Permission to Leave',
          content:
              'After thirteen years of preaching in Makkah, during which the Muslims faced boycotts, torture, and assassination, Allah gave permission to migrate. The Quraysh, learning of the plan, gathered to assassinate the Prophet ﷺ in his home. But by the will of Allah, he walked through them unseen, reciting the verses of Surah Yaseen: "And We have put before them a barrier and behind them a barrier and covered them, so they do not see." (36:9)',
          pullQuote: 'They plotted, but Allah is the best of planners.',
        ),
        HistorySection(
          heading: 'Three Days in a Cave',
          content:
              'The Prophet ﷺ and Abu Bakr took refuge in the Cave of Thawr for three days while Quraysh search parties combed the surrounding hills. In one of the most moving moments in Islamic history, as searchers approached the cave entrance, Abu Bakr whispered in fear for the Prophet\'s life. The response came: "Do not grieve; indeed Allah is with us." (9:40)\n\nA spider had spun its web across the cave entrance, and a pigeon had nested there — signs that appeared to the Quraysh as evidence no one had entered. The divine protection was complete.',
          pullQuote: '"Do not grieve; indeed Allah is with us." — Quran 9:40',
        ),
        HistorySection(
          heading: 'The Arrival in Madinah',
          content:
              'When the Prophet ﷺ arrived in the outskirts of Madinah, the response was unlike anything seen in the history of religious communities. Men, women, and children came out to welcome him with joy and celebration. The women of Madinah sang: "The full moon has risen upon us from the direction of Thaniyyat al-Wada\'. Gratitude is due from us, for as long as a caller calls to Allah."\n\nIn Madinah, the Prophet ﷺ established the first mosque, created the Constitution of Madinah (a remarkable document establishing coexistence between Muslims, Jews, and other tribes), and began the construction of the first Muslim community — a community founded on justice, brotherhood, and the worship of one God.',
        ),
      ],
    ),
    const HistoryChapter(
      id: 'khulafa-rashideen',
      title: 'The Rightly-Guided Caliphs',
      subtitle: 'The First Golden Age of Islam',
      era: Era.khulafaRashideen,
      eraLabel: 'Khulafa\' Rashideen',
      period: '632–661 CE',
      order: 5,
      readingTimeMinutes: 12,
      introduction:
          'After the Prophet\'s passing, four of his closest companions led the Muslim community through decades of extraordinary expansion, governance, and spiritual depth. These were the Khulafa\' ar-Rashideen — the Rightly-Guided Caliphs — a period Islam looks back to as a model of just governance.',
      keyFigures: [
        'Abu Bakr as-Siddiq (r. 632–634 CE)',
        'Umar ibn al-Khattab (r. 634–644 CE)',
        'Uthman ibn Affan (r. 644–656 CE)',
        'Ali ibn Abi Talib (r. 656–661 CE)',
      ],
      keyEvents: [
        'Death of the Prophet ﷺ (632 CE)',
        'Compilation of the Quran under Abu Bakr',
        'Ridda Wars — unification of Arabia',
        'Conquest of Syria and Egypt under Umar',
        'Standardization of the Quran under Uthman',
        'Martyrdom of Uthman (656 CE)',
      ],
      sections: [
        HistorySection(
          heading: 'Abu Bakr — The Truthful',
          content:
              'When the Prophet ﷺ passed away in 632 CE, the Muslim community was in shock. It was Abu Bakr who steadied them with the immortal words: "Whoever worshipped Muhammad, know that Muhammad has died. Whoever worships Allah, know that Allah is Ever-Living and never dies."\n\nHis two-year caliphate was defined by resolute leadership during crisis. When several tribes refused to pay Zakat following the Prophet\'s death, Abu Bakr declared the Ridda Wars — reasserting Islamic governance across Arabia. He also initiated the first compilation of the Quran into a written mushaf, preserving it for all eternity.',
          pullQuote:
              '"Whoever worshipped Muhammad, know that Muhammad has died. Whoever worships Allah, know that Allah is Ever-Living." — Abu Bakr',
        ),
        HistorySection(
          heading: 'Umar — Justice Personified',
          content:
              'Umar ibn al-Khattab presided over the most dramatic expansion in Islamic history. Within a decade, the Muslim state expanded from Arabia across Persia, Syria, Egypt, and beyond. Yet what distinguished his caliphate was not conquest but governance.\n\nUmar established a welfare state that paid stipends to all citizens, created a register of state employees, instituted the Hijri calendar, and walked the streets of Madinah at night to check on the welfare of his people. He declared: "I fear that if a mule stumbles on the banks of the Euphrates, I will be asked about it before Allah — for why did I not pave that road?"',
          pullQuote:
              '"I fear that if a mule stumbles on the banks of the Euphrates, I will be asked about it before Allah." — Umar ibn al-Khattab',
        ),
      ],
    ),
    const HistoryChapter(
      id: 'baitul-hikma-abbasid',
      title: 'The House of Wisdom',
      subtitle: 'Islam\'s Golden Age of Knowledge',
      era: Era.abbasid,
      eraLabel: 'Abbasid Era',
      period: '750–1258 CE',
      order: 7,
      readingTimeMinutes: 10,
      introduction:
          'The Abbasid Caliphate gave rise to one of the greatest intellectual flourishings in human history. In Baghdad, the Bayt al-Hikmah — the House of Wisdom — became the world\'s greatest center of learning, preserving and advancing knowledge across mathematics, astronomy, medicine, and philosophy.',
      keyFigures: [
        'Harun al-Rashid (r. 786–809 CE)',
        'Al-Ma\'mun (r. 813–833 CE)',
        'Al-Khwarizmi (mathematician)',
        'Ibn Sina — Avicenna (physician)',
        'Al-Biruni (polymath)',
        'Al-Kindi (philosopher)',
      ],
      keyEvents: [
        'Foundation of Baghdad (762 CE)',
        'Establishment of Bayt al-Hikmah',
        'Translation movement — Greek texts into Arabic',
        'Algebra invented by Al-Khwarizmi',
        'Ibn Sina\'s Canon of Medicine',
        'Mongol sack of Baghdad (1258 CE)',
      ],
      sections: [
        HistorySection(
          heading: 'The Capital of the World',
          content:
              'At its peak in the 9th century, Baghdad was the largest city on earth with a population exceeding one million. The Abbasid court patronized scholars, poets, and scientists from across the known world. Christians, Jews, Zoroastrians, and Muslims worked side by side, translating Greek, Persian, and Indian manuscripts into Arabic.\n\nThe Caliph Al-Ma\'mun reportedly paid translators in gold equal to the weight of each translated book. This extraordinary investment in knowledge catalyzed centuries of scientific and intellectual progress.',
          pullQuote:
              'Baghdad was the city where the light of knowledge met the warmth of faith.',
        ),
        HistorySection(
          heading: 'Al-Khwarizmi and the Birth of Algebra',
          content:
              'Muhammad ibn Musa al-Khwarizmi, working in the Bayt al-Hikmah, wrote a treatise that would change mathematics forever: "Al-Kitab al-Mukhtasar fi Hisab al-Jabr wal-Muqabala" — The Compendious Book on Calculation by Completion and Balancing.\n\nThe word "algebra" comes directly from "al-jabr" in this title. The word "algorithm" derives from the Latinization of al-Khwarizmi\'s own name. His work introduced the decimal positional number system to the Islamic world and subsequently to Europe, replacing Roman numerals and enabling the mathematics that underlies all modern science.',
          pullQuote:
              'Every time you use the word "algebra" or "algorithm," you are speaking the name of Islamic scholarship.',
        ),
        HistorySection(
          heading: 'The Legacy',
          content:
              'The Bayt al-Hikmah was destroyed when the Mongols sacked Baghdad in 1258 CE — a catastrophe described by historians as the end of the Islamic Golden Age. Eyewitnesses recorded that the Tigris River ran black with ink from thousands of drowned books for days.\n\nYet the knowledge could not be destroyed. The translations, the discoveries, the mathematical innovations — all of these had already traveled to Andalusia, Sicily, and the European universities that were beginning to rise. The Islamic Golden Age did not just preserve ancient knowledge: it transformed, synthesized, and advanced it, creating the foundations upon which modern science was built.',
        ),
      ],
    ),
  ];

  static List<TimelineEvent> get timelineEvents => [
    const TimelineEvent(
      year: '570 CE',
      event: 'Year of the Elephant — Birth of the Prophet ﷺ',
      detail: 'Abraha\'s army destroyed; Muhammad ﷺ born in Makkah',
      era: Era.preIslamic,
    ),
    const TimelineEvent(
      year: '595 CE',
      event: 'Marriage to Khadijah',
      detail: 'Muhammad ﷺ marries Khadijah bint Khuwaylid',
      era: Era.preIslamic,
    ),
    const TimelineEvent(
      year: '610 CE',
      event: 'First Revelation',
      detail: 'Jibreel brings the first verses of the Quran in Cave of Hira',
      era: Era.propheticMecca,
    ),
    const TimelineEvent(
      year: '622 CE',
      event: 'The Hijrah',
      detail: 'Migration from Makkah to Madinah — Islamic calendar begins',
      era: Era.propheticMadina,
    ),
    const TimelineEvent(
      year: '624 CE',
      event: 'Battle of Badr',
      detail: '313 Muslims defeat 1,000 Quraysh — a turning point',
      era: Era.propheticMadina,
    ),
    const TimelineEvent(
      year: '630 CE',
      event: 'Conquest of Makkah',
      detail: 'Peaceful liberation; general amnesty declared',
      era: Era.propheticMadina,
    ),
    const TimelineEvent(
      year: '632 CE',
      event: 'Passing of the Prophet ﷺ',
      detail: 'Abu Bakr becomes the first Caliph',
      era: Era.khulafaRashideen,
    ),
    const TimelineEvent(
      year: '637 CE',
      event: 'Jerusalem opened',
      detail: 'Umar ibn al-Khattab receives keys to Jerusalem peacefully',
      era: Era.khulafaRashideen,
    ),
    const TimelineEvent(
      year: '762 CE',
      event: 'Baghdad founded',
      detail: 'Abbasid Caliph al-Mansur establishes the Round City',
      era: Era.abbasid,
    ),
    const TimelineEvent(
      year: '830 CE',
      event: 'Bayt al-Hikmah flourishes',
      detail: 'House of Wisdom at its peak under Al-Ma\'mun',
      era: Era.abbasid,
    ),
    const TimelineEvent(
      year: '1258 CE',
      event: 'Mongol Sack of Baghdad',
      detail: 'End of the Abbasid Caliphate; libraries destroyed',
      era: Era.abbasid,
    ),
  ];
}
