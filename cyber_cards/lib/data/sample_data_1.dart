import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/flashcard_model.dart';
import '../theme/app_colors.dart';

/// Static seed data for the app. In a production build this would come
/// from a local database (e.g. sqflite/hive) or a remote API, but the
/// shape below matches the data model described in the design spec so it
/// can be swapped out without touching the UI layer.
class SampleData {
  SampleData._();

  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'phishing',
      name: 'Phishing',
      description: 'Learn how to identify fake emails, messages and websites.',
      icon: Icons.email_outlined,
      color: AppColors.categoryAccents['phishing']!,
      cardCount: 12,
    ),
    CategoryModel(
      id: 'password_security',
      name: 'Password Security',
      description: 'Learn how to create and protect strong passwords.',
      icon: Icons.lock_outline,
      color: AppColors.categoryAccents['password_security']!,
      cardCount: 10,
    ),
    CategoryModel(
      id: 'malware',
      name: 'Malware',
      description: 'Understand viruses, trojans, ransomware and other malware.',
      icon: Icons.bug_report_outlined,
      color: AppColors.categoryAccents['malware']!,
      cardCount: 10,
    ),
    CategoryModel(
      id: 'social_engineering',
      name: 'Social Engineering',
      description: 'Recognize manipulation and psychological attacks.',
      icon: Icons.groups_outlined,
      color: AppColors.categoryAccents['social_engineering']!,
      cardCount: 10,
    ),
    CategoryModel(
      id: 'online_safety',
      name: 'Online Safety',
      description: 'Learn everyday practices for staying safe online.',
      icon: Icons.shield_outlined,
      color: AppColors.categoryAccents['online_safety']!,
      cardCount: 12,
    ),
  ];

  /// A representative set of cards per category. Extend each list to reach
  /// the full recommended counts (12/10/10/10/12 = 54 total) — the UI,
  /// progress math, and navigation already support any list length.
  static final List<FlashCardModel> cards = [
    // ---- Phishing ----
    FlashCardModel(
      id: 'phishing_1',
      categoryId: 'phishing',
      type: CardType.definition,
      question: 'What is phishing?',
      answer:
          'Phishing is a scam where attackers pretend to be a trusted source to trick you into revealing sensitive information.',
      example: 'An email claiming to be from your bank asking you to "verify" your account.',
      tip: 'Always check the sender\'s email address carefully.',
    ),
    FlashCardModel(
      id: 'phishing_2',
      categoryId: 'phishing',
      type: CardType.definition,
      question: 'Can you identify a phishing website?',
      answer:
          'Check the URL carefully. Phishing websites often use misspelled domains or suspicious addresses.',
      example: 'paypa1-login.com',
      tip: 'Always verify the website domain before entering credentials.',
    ),
    FlashCardModel(
      id: 'phishing_3',
      categoryId: 'phishing',
      type: CardType.scenario,
      question:
          'You receive an email saying your bank account will be blocked unless you verify your password immediately. What should you do?',
      answer: 'Verify through the official website or app — never through a link in the email.',
      tip: 'Legitimate banks never ask for your password by email.',
      options: [
        'Click the link',
        'Reply with your password',
        'Verify through the official website',
        'Forward it to friends',
      ],
      correctOptionIndex: 2,
    ),
    FlashCardModel(
      id: 'phishing_4',
      categoryId: 'phishing',
      type: CardType.quiz,
      question: 'Which of these is a common sign of a phishing email?',
      answer: 'Urgent language pressuring you to act immediately is a major red flag.',
      options: [
        'A calm, informative tone',
        'Urgent threats and deadlines',
        'A company logo',
        'Correct spelling throughout',
      ],
      correctOptionIndex: 1,
    ),
    FlashCardModel(
      id: 'phishing_5',
      categoryId: 'phishing',
      type: CardType.definition,
      question: 'What is "spear phishing"?',
      answer:
          'A targeted phishing attack aimed at a specific person or organization, often using personal details to seem credible.',
      tip: 'Be extra cautious with unexpected messages that reference personal details.',
    ),

    // ---- Password Security ----
    FlashCardModel(
      id: 'password_1',
      categoryId: 'password_security',
      type: CardType.definition,
      question: 'What makes a password strong?',
      answer:
          'Length, unpredictability, and a mix of letters, numbers and symbols — with no reused passwords across sites.',
      tip: 'Aim for at least 12 characters using a passphrase.',
    ),
    FlashCardModel(
      id: 'password_2',
      categoryId: 'password_security',
      type: CardType.quiz,
      question: 'Why shouldn\'t you reuse passwords across accounts?',
      answer:
          'If one site is breached, attackers will try the same password on your other accounts ("credential stuffing").',
      options: [
        'It slows down login',
        'One breach can compromise all your accounts',
        'It uses more storage',
        'It is against most company policy only',
      ],
      correctOptionIndex: 1,
    ),
    FlashCardModel(
      id: 'password_3',
      categoryId: 'password_security',
      type: CardType.definition,
      question: 'What is a password manager?',
      answer:
          'An app that securely generates, stores, and autofills strong, unique passwords for every account you use.',
      tip: 'Use one master password to unlock the manager, and enable 2FA on it.',
    ),
    FlashCardModel(
      id: 'password_4',
      categoryId: 'password_security',
      type: CardType.scenario,
      question:
          'A website tells you your new password must include a symbol, but you want to keep it easy to remember. What is the best approach?',
      answer: 'Use a memorable passphrase with a symbol woven in, e.g. "Sunset-Over7Mountains!".',
      options: [
        'Add "123" to your usual password',
        'Use a memorable passphrase with symbols',
        'Reuse an old password with a symbol added',
        'Write it on a sticky note',
      ],
      correctOptionIndex: 1,
    ),

    // ---- Malware ----
    FlashCardModel(
      id: 'malware_1',
      categoryId: 'malware',
      type: CardType.definition,
      question: 'What is ransomware?',
      answer:
          'Malicious software that encrypts your files and demands payment to restore access.',
      tip: 'Keep regular backups so ransomware can\'t hold your data hostage.',
    ),
    FlashCardModel(
      id: 'malware_2',
      categoryId: 'malware',
      type: CardType.definition,
      question: 'What is a Trojan?',
      answer:
          'Malware disguised as legitimate software that, once installed, gives attackers access to your device.',
      example: 'A "free" game download that secretly installs spyware.',
    ),
    FlashCardModel(
      id: 'malware_3',
      categoryId: 'malware',
      type: CardType.quiz,
      question: 'What is the safest way to install new apps?',
      answer: 'Download only from official app stores or verified publisher websites.',
      options: [
        'Any link from a search result',
        'Official app stores or verified sites',
        'Links shared in group chats',
        'Pop-up ads offering free apps',
      ],
      correctOptionIndex: 1,
    ),

    // ---- Social Engineering ----
    FlashCardModel(
      id: 'social_1',
      categoryId: 'social_engineering',
      type: CardType.definition,
      question: 'What is social engineering?',
      answer:
          'Manipulating people psychologically into giving up confidential information or performing risky actions.',
      example: 'A caller impersonating IT support asking for your login details.',
    ),
    FlashCardModel(
      id: 'social_2',
      categoryId: 'social_engineering',
      type: CardType.scenario,
      question:
          'Someone calls claiming to be from your company\'s IT department, asking for your password to "fix an urgent issue." What should you do?',
      answer: 'Hang up and verify through official internal channels — IT never needs your password.',
      options: [
        'Give the password to resolve it fast',
        'Hang up and verify through official channels',
        'Ask them to email you first',
        'Give a slightly different password',
      ],
      correctOptionIndex: 1,
    ),
    FlashCardModel(
      id: 'social_3',
      categoryId: 'social_engineering',
      type: CardType.definition,
      question: 'What is "pretexting"?',
      answer:
          'Creating a fabricated scenario (a pretext) to convince someone to share information or grant access.',
    ),

    // ---- Online Safety ----
    FlashCardModel(
      id: 'safety_1',
      categoryId: 'online_safety',
      type: CardType.definition,
      question: 'Why is public Wi-Fi risky?',
      answer:
          'Unsecured public networks can let attackers intercept your data between your device and the internet.',
      tip: 'Avoid banking or entering passwords on public Wi-Fi without a VPN.',
    ),
    FlashCardModel(
      id: 'safety_2',
      categoryId: 'online_safety',
      type: CardType.definition,
      question: 'What is two-factor authentication (2FA)?',
      answer:
          'A second verification step (like a code sent to your phone) that protects your account even if your password is stolen.',
      tip: 'Enable 2FA on email, banking, and social accounts first.',
    ),
    FlashCardModel(
      id: 'safety_3',
      categoryId: 'online_safety',
      type: CardType.quiz,
      question: 'What should you do before entering payment details on a website?',
      answer: 'Check that the connection is secure (https and a valid lock icon) and the site is legitimate.',
      options: [
        'Nothing, all sites are safe',
        'Check for https and site legitimacy',
        'Only check the page design',
        'Ask a friend if it looks fine',
      ],
      correctOptionIndex: 1,
    ),
  ];

  static List<FlashCardModel> cardsForCategory(String categoryId) =>
      cards.where((c) => c.categoryId == categoryId).toList();

  static const dailyTip =
      'Never share your OTP, password, or verification code with anyone.';
}
