class CyberCard {
  final String category;
  final String title;
  final String content;
  final String tip;

  CyberCard({
    required this.category,
    required this.title,
    required this.content,
    required this.tip,
  });
}

final List<CyberCard> cyberCards = [
  CyberCard(
    category: 'Phishing',
    title: 'What is Phishing?',
    content:
        'Phishing is a cyber attack where criminals pretend to be a trusted person or company to steal information.',
    tip: 'Never share passwords or OTPs through suspicious links.',
  ),

  CyberCard(
    category: 'Phishing',
    title: 'Urgent Bank Message',
    content:
        'You receive a message saying your bank account will be blocked unless you click a link immediately.',
    tip: 'Do not click. Verify the message using your bank’s official app or website.',
  ),

  CyberCard(
    category: 'Phishing',
    title: 'Fake Prize',
    content:
        'A message says you won a prize and asks you to pay a small fee to claim it.',
    tip: 'Unexpected prizes asking for payment are a major warning sign.',
  ),

  CyberCard(
    category: 'Phishing',
    title: 'Suspicious Link',
    content:
        'A link looks like it belongs to a famous company but the website address has unusual spelling.',
    tip: 'Check the website address carefully before entering any information.',
  ),

  CyberCard(
    category: 'Phishing',
    title: 'Fake Login Page',
    content:
        'A website copies the design of a popular service and asks you to enter your username and password.',
    tip: 'Check the URL and use the official app or website whenever possible.',
  ),

  CyberCard(
    category: 'Passwords',
    title: 'Strong Password',
    content:
        'A strong password is long, unique, and difficult for others to guess.',
    tip: 'Use a different strong password for every important account.',
  ),

  CyberCard(
    category: 'Passwords',
    title: 'Password Reuse',
    content:
        'Using the same password on multiple websites can put several accounts at risk if one password is stolen.',
    tip: 'Never reuse your important passwords.',
  ),

  CyberCard(
    category: 'Passwords',
    title: 'Password Manager',
    content:
        'A password manager securely stores and helps generate unique passwords.',
    tip: 'Use a trusted password manager instead of writing passwords everywhere.',
  ),

  CyberCard(
    category: 'Passwords',
    title: 'OTP Safety',
    content:
        'An OTP is a temporary code used to verify an action or login.',
    tip: 'Never share an OTP with another person, even if they claim to be from a bank or company.',
  ),

  CyberCard(
    category: 'Passwords',
    title: 'Two-Factor Authentication',
    content:
        'Two-factor authentication adds another verification step besides your password.',
    tip: 'Turn on 2FA for email, banking, social media, and other important accounts.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Public Wi-Fi',
    content:
        'Public Wi-Fi networks may not always be secure and can expose your information.',
    tip: 'Avoid sensitive transactions on unknown public Wi-Fi networks.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Software Updates',
    content:
        'Software updates often include security fixes that protect against known vulnerabilities.',
    tip: 'Keep your phone, apps, and operating system updated.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'App Permissions',
    content:
        'Apps may request access to your camera, microphone, location, contacts, or files.',
    tip: 'Give permissions only when they are necessary for the app’s function.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Screen Lock',
    content:
        'A screen lock helps prevent unauthorized access to your phone.',
    tip: 'Use a strong PIN, password, fingerprint, or other secure screen lock.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Unknown Downloads',
    content:
        'Files or apps from unknown sources may contain malware.',
    tip: 'Download apps from official and trusted app stores whenever possible.',
  ),

  CyberCard(
    category: 'Myth Busting',
    title: 'Myth: Antivirus Does Everything',
    content:
        'Antivirus software can help detect threats, but it cannot prevent every cyber attack.',
    tip: 'Use antivirus along with safe browsing habits and regular updates.',
  ),

  CyberCard(
    category: 'Myth Busting',
    title: 'Myth: Hackers Only Target Rich People',
    content:
        'Cyber criminals can target anyone because automated attacks can reach many users.',
    tip: 'Everyone should follow basic cybersecurity practices.',
  ),

  CyberCard(
    category: 'Myth Busting',
    title: 'Myth: HTTPS Means Everything is Safe',
    content:
        'HTTPS encrypts the connection, but it does not automatically mean the website itself is trustworthy.',
    tip: 'Check the website address and legitimacy before sharing sensitive information.',
  ),

  CyberCard(
    category: 'Myth Busting',
    title: 'Myth: My Account Cannot Be Hacked',
    content:
        'Any online account can potentially be targeted if security is weak or login information is stolen.',
    tip: 'Use unique passwords and enable two-factor authentication.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Social Engineering',
    content:
        'Social engineering tricks people into revealing information or performing unsafe actions.',
    tip: 'Be careful with unexpected requests, even when they appear to come from someone you know.',
  ),

  CyberCard(
    category: 'Phishing',
    title: 'Fake Customer Support',
    content:
        'A person contacts you claiming to be customer support and asks for your password or OTP.',
    tip: 'Real support should not need your password or OTP. Contact the company through official channels.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Oversharing Online',
    content:
        'Sharing too much personal information online can help criminals guess security answers or create targeted scams.',
    tip: 'Limit personal information shared publicly on social media.',
  ),

  CyberCard(
    category: 'Passwords',
    title: 'Password Guessing',
    content:
        'Attackers may try common passwords, personal information, or passwords leaked from other websites.',
    tip: 'Avoid names, birthdays, phone numbers, and common words in passwords.',
  ),

  CyberCard(
    category: 'Phishing',
    title: 'Email Attachment',
    content:
        'An unexpected email contains an attachment and asks you to open it immediately.',
    tip: 'Do not open unexpected attachments. Verify the sender first.',
  ),

  CyberCard(
    category: 'Online Safety',
    title: 'Backup Your Data',
    content:
        'Backups provide another copy of important files if data is lost, damaged, or encrypted by malware.',
    tip: 'Regularly back up important photos, documents, and other files.',
  ),
];