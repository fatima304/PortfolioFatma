class PortfolioData {
  PortfolioData._();

  static const String name = 'Fatma Atef';
  static const String role = 'Flutter Developer';
  static const String heroSubtitle =
      'Building innovative mobile solutions with Flutter';
  static const String heroDescription =
      "I'm a Mobile App Developer passionate about creating elegant, "
      'high-performance applications. Specializing in Flutter and '
      'cross-platform technologies to bring complex ideas to life.';

  static const String aboutDescription =
      "I'm a Flutter developer with a degree in Computer Science and Information "
      'from Menofia University. I have experience working with a variety of '
      'technologies, including Flutter, Dart, Firebase, Java, Python, HTML, CSS, '
      'and Figma. I specialize in creating clean, efficient code and finding '
      'innovative solutions to complex problems.';

  static const String aboutJourney =
      'My journey spans across Mobile Development, UI/UX Design, and Backend '
      'integration, evolving into a comprehensive Flutter development skillset. '
      'In my current role as a Flutter Developer at the Digital Egypt Pioneers '
      'Initiative (DEPI), I am developing and maintaining responsive mobile '
      'applications using Flutter, collaborating with designers and backend '
      'developers to ensure seamless user experiences across devices.';

  static const String cvUrl =
      'https://drive.google.com/file/d/1WRyqr-xA_sYF00Ll1u-Ha1p_5mvFo71g/view?usp=drivesdk';

  static const String profileImage = 'assets/3.png';
  static const String logoImage = 'assets/logo.png';

  // Stats
  static const List<Map<String, String>> stats = [
    {
      'value': '1+',
      'label': 'Years Experience',
      'sub': 'In mobile development'
    },
    {
      'value': '6+',
      'label': 'Projects Completed',
      'sub': 'Across various domains',
    },
  ];

  // About feature cards
  static const List<Map<String, String>> aboutFeatures = [
    {
      'icon': 'code',
      'title': 'Clean Code',
      'desc':
          'I write clean, maintainable code following best practices and design patterns.',
    },
    {
      'icon': 'devices',
      'title': 'Responsive Design',
      'desc':
          'Creating interfaces that work flawlessly across all device sizes and orientations.',
    },
    {
      'icon': 'speed',
      'title': 'Performance Focused',
      'desc':
          'Building high-performance apps with smooth animations and efficient resource usage.',
    },
    {
      'icon': 'architecture',
      'title': 'Architecture',
      'desc':
          'Implementing scalable architectures for maintainable and testable apps.',
    },
  ];

  // Social links
  static const String githubUrl = 'https://github.com/fatima304';
  static const String linkedinUrl = 'https://www.linkedin.com/in/fatmaatef11/';
  static const String facebookUrl =
      'https://www.facebook.com/profile.php?id=100008474567689';
  static const String emailUrl = 'mailto:fatmaatef015@gmail.com';
  static const String telegramUrl = 'https://t.me/fatma_atef';

  static const String email = 'fatmaatef015@gmail.com';
}

class ProjectData {
  final String title;
  final String description;
  final String image;
  final String githubLink;
  final List<String> tags;

  const ProjectData({
    required this.title,
    required this.description,
    required this.image,
    required this.githubLink,
    required this.tags,
  });
}

final List<ProjectData> projects = [
  const ProjectData(
    title: 'Zabi',
    description:
        'Built a production-ready Islamic super app featuring prayer times, '
        'Qibla direction, Zakat calculator, Hadith, Duas, daily Azkar, and '
        'donation workflows using Clean Architecture, GetX, Firebase services, '
        'and REST APIs with offline-first caching.',
    image: 'zabi.png',
    githubLink:
        'https://play.google.com/store/apps/details?id=com.zabimuslima.app',
    tags: [
      'Flutter',
      'GetX',
      'Firebase',
      'REST API',
      'Clean Architecture',
      'Offline Caching',
    ],
  ),
  const ProjectData(
    title: 'CRC App',
    description:
        'Developed a medical appointment and CRC screening system integrated '
        'with a Laravel/MySQL backend, supporting appointment scheduling, '
        'patient profiles, and automated healthcare workflows using Clean Architecture.',
    image: 'crc.jpg',
    githubLink: 'https://github.com/fatima304/COLON_APP',
    tags: [
      'Flutter',
      'Laravel',
      'REST API',
      'MySQL',
      'Clean Architecture',
    ],
  ),
  const ProjectData(
    title: 'Cryptex',
    description:
        'Engineered a real-time cryptocurrency tracking application for '
        '100+ coins with dynamic charts, Supabase Authentication, and '
        'offline caching using Bloc/Cubit architecture and CoinGecko APIs.',
    image: 'cryptex.png',
    githubLink: 'https://github.com/fatima304/Cryptex',
    tags: [
      'Flutter',
      'Bloc/Cubit',
      'Supabase',
      'CoinGecko API',
      'Real-time Data',
      'Offline Caching',
    ],
  ),
  const ProjectData(
    title: 'LazaShop',
    description:
        'Built a scalable e-commerce application featuring category browsing, '
        'cart management, checkout workflows, and payment integration across '
        'multiple responsive screens using Bloc and REST APIs.',
    image: 'laza.png',
    githubLink: 'https://github.com/fatima304/LazaShop',
    tags: [
      'Flutter',
      'Bloc',
      'REST API',
      'Payment Gateway',
      'E-Commerce',
    ],
  ),
  const ProjectData(
    title: 'Habayeb',
    description:
        'Created a recipe discovery platform with Firebase Authentication, '
        'YouTube video integration, paginated REST APIs, and responsive UI '
        'layouts optimized for smooth user experience.',
    image: 'habayeb.png',
    githubLink: 'https://github.com/fatima304/habayebapp',
    tags: [
      'Flutter',
      'Firebase Auth',
      'REST API',
      'YouTube API',
      'Responsive UI',
    ],
  ),
];

class ExperienceData {
  final String role;
  final String company;
  final String duration;
  final String description;
  final List<String> achievements;

  const ExperienceData({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    this.achievements = const [],
  });
}

const List<ExperienceData> experiences = [
  ExperienceData(
    role: 'Junior Flutter Developer (Intern)',
    company: 'Madar Information Technology',
    duration: 'Dec 2024 – May 2025',
    description:
        'Worked as a Flutter developer intern focusing on building production-ready mobile applications '
        'with Clean Architecture and state management solutions.',
    achievements: [
      'Shipped Zabi app to Google Play as a full production release',
      'Built and maintained 5+ production-level Flutter applications',
      'Improved development efficiency by ~20% using Clean Architecture & GetX structure',
      'Integrated multiple RESTful APIs with caching and error handling',
      'Fixed 20+ pre-release bugs across multiple Android device profiles',
    ],
  ),
];

class EducationData {
  final String degree;
  final String institution;
  final String duration;
  final String? detail;

  const EducationData({
    required this.degree,
    required this.institution,
    required this.duration,
    this.detail,
  });
}

const List<EducationData> educations = [
  EducationData(
    degree: 'Bachelor of Computer & Information',
    institution: 'Menoufia University, Egypt',
    duration: 'Sep 2019 – Jul 2023',
  ),
];

class SkillData {
  final String name;
  final double proficiency;

  const SkillData({
    required this.name,
    this.proficiency = 0.0,
  });
}

const List<SkillData> skills = [
  SkillData(name: 'Flutter', proficiency: 0.90),
  SkillData(name: 'Dart', proficiency: 0.90),
  SkillData(name: 'Firebase', proficiency: 0.80),
  SkillData(name: 'Figma', proficiency: 0.75),
  SkillData(name: 'HTML', proficiency: 0.70),
  SkillData(name: 'CSS', proficiency: 0.70),
  SkillData(name: 'Java', proficiency: 0.65),
  SkillData(name: 'Python', proficiency: 0.60),
];

const List<String> navItems = [
  'Home',
  'About',
  'Projects',
  'Skills',
  'Experience',
  'Contact',
];
