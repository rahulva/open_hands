class WordData {
  WordData(
      {this.word = '',
      this.meaning = '',
      this.wordType = '',
      this.dictionaryUrl = '',
      this.sampleSentence = '',
      this.failedAttempts = 0,
      this.dist = 1.8,
      this.difficultyLevel = 1.0});

  String word;
  String meaning;
  String wordType;
  String dictionaryUrl;
  String sampleSentence;
  int failedAttempts;
  double dist; //TODO Rename
  double difficultyLevel; //TODO Rename

  static List<WordData> wordList = <WordData>[
    WordData(
      word: 'admire',
      meaning:
          'to find someone or something attractive and pleasant to look at',
      wordType: 'verb',
      dictionaryUrl:
          'https://dictionary.cambridge.org/dictionary/english/admire',
      sampleSentence: 'We stood for a few moments, admiring the view',
    ),
    WordData(
      word: 'nuance',
      meaning: '',
      wordType: 'verb',
      dictionaryUrl:
          'https://dictionary.cambridge.org/dictionary/english/nuance',
      sampleSentence: '',
    ),
    WordData(
      word: '',
      meaning: 'a very slight difference in appearance, meaning, sound, etc.',
      wordType: '',
      dictionaryUrl: '',
      sampleSentence: '',
    ),
  ];
}
