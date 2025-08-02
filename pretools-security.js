#!/usr/bin/env node

/**
 * Security Pre-tool - Interdiction des actions dangereuses
 * 
 * Ce script analyse et bloque les opérations potentiellement dangereuses
 * avant leur exécution dans le projet FlightClaim.
 * 
 * Utilisation: node pretools-security.js [command]
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

// Configuration des règles de sécurité
const SECURITY_RULES = {
  // Commandes complètement interdites
  FORBIDDEN_COMMANDS: [
    'rm -rf /',
    'sudo rm',
    'chmod 777',
    'curl | sh',
    'wget | sh',
    'eval',
    'exec',
    '> /dev/null',
    'dd if=',
    'mkfs',
    'fdisk',
    'format',
    '$()',
    '`',
    'nc -l',
    'ncat -l'
  ],

  // Patterns de fichiers dangereux
  DANGEROUS_FILE_PATTERNS: [
    /\.exe$/i,
    /\.bat$/i,
    /\.cmd$/i,
    /\.scr$/i,
    /\.pif$/i,
    /\.com$/i,
    /\/etc\/passwd/,
    /\/etc\/shadow/,
    /\/etc\/sudoers/,
    /\.ssh\/id_rsa/,
    /\.aws\/credentials/,
    /\.env\.production/
  ],

  // Opérations réseau suspectes
  SUSPICIOUS_NETWORK: [
    'netcat',
    'nc ',
    'telnet',
    'ftp anonymous',
    'tftp',
    'rsh',
    'rlogin'
  ],

  // Modifications système critiques
  SYSTEM_MODIFICATIONS: [
    '/etc/',
    '/usr/bin/',
    '/usr/sbin/',
    '/var/lib/',
    'systemctl',
    'service ',
    'chkconfig',
    'update-rc.d'
  ],

  // Tentatives d'élévation de privilèges
  PRIVILEGE_ESCALATION: [
    'sudo su',
    'su root',
    'sudo -i',
    'sudo bash',
    'sudo sh',
    'pkexec',
    'gksudo'
  ]
};

// Chemins protégés du projet
const PROTECTED_PATHS = [
  'lib/core/network/supabase_client.dart',
  'lib/core/constants/app_constants.dart',
  '.env',
  '.env.local',
  '.env.production',
  'pubspec.yaml',
  'android/app/build.gradle',
  'ios/Runner/Info.plist'
];

class SecurityAnalyzer {
  constructor() {
    this.violations = [];
    this.warnings = [];
  }

  /**
   * Analyse une commande pour détecter les violations de sécurité
   */
  analyzeCommand(command) {
    console.log(`🔍 Analyse de sécurité: ${command}`);
    
    // Vérification des commandes interdites
    for (const forbidden of SECURITY_RULES.FORBIDDEN_COMMANDS) {
      if (command.includes(forbidden)) {
        this.violations.push({
          type: 'FORBIDDEN_COMMAND',
          command: forbidden,
          severity: 'CRITICAL',
          message: `Commande interdite détectée: ${forbidden}`
        });
      }
    }

    // Vérification des opérations réseau suspectes
    for (const suspicious of SECURITY_RULES.SUSPICIOUS_NETWORK) {
      if (command.includes(suspicious)) {
        this.warnings.push({
          type: 'SUSPICIOUS_NETWORK',
          command: suspicious,
          severity: 'HIGH',
          message: `Opération réseau suspecte: ${suspicious}`
        });
      }
    }

    // Vérification des modifications système
    for (const systemMod of SECURITY_RULES.SYSTEM_MODIFICATIONS) {
      if (command.includes(systemMod)) {
        this.violations.push({
          type: 'SYSTEM_MODIFICATION',
          command: systemMod,
          severity: 'HIGH',
          message: `Tentative de modification système: ${systemMod}`
        });
      }
    }

    // Vérification de l'élévation de privilèges
    for (const privEsc of SECURITY_RULES.PRIVILEGE_ESCALATION) {
      if (command.includes(privEsc)) {
        this.violations.push({
          type: 'PRIVILEGE_ESCALATION',
          command: privEsc,
          severity: 'CRITICAL',
          message: `Tentative d'élévation de privilèges: ${privEsc}`
        });
      }
    }

    return this.violations.length === 0;
  }

  /**
   * Analyse un fichier pour détecter les patterns dangereux
   */
  analyzeFile(filePath) {
    try {
      // Vérification des patterns de fichiers dangereux
      for (const pattern of SECURITY_RULES.DANGEROUS_FILE_PATTERNS) {
        if (pattern.test(filePath)) {
          this.violations.push({
            type: 'DANGEROUS_FILE',
            file: filePath,
            severity: 'HIGH',
            message: `Fichier potentiellement dangereux: ${filePath}`
          });
        }
      }

      // Vérification des chemins protégés
      if (PROTECTED_PATHS.some(protected => filePath.includes(protected))) {
        this.warnings.push({
          type: 'PROTECTED_PATH',
          file: filePath,
          severity: 'MEDIUM',
          message: `Accès à un fichier protégé: ${filePath}`
        });
      }

      // Analyse du contenu si le fichier existe
      if (fs.existsSync(filePath) && fs.statSync(filePath).isFile()) {
        this.analyzeFileContent(filePath);
      }

    } catch (error) {
      console.error(`Erreur lors de l'analyse du fichier ${filePath}:`, error.message);
    }
  }

  /**
   * Analyse le contenu d'un fichier pour détecter des patterns suspects
   */
  analyzeFileContent(filePath) {
    try {
      const content = fs.readFileSync(filePath, 'utf8');
      
      // Détection de clés API exposées
      const apiKeyPatterns = [
        /sk-[a-zA-Z0-9]{48}/g, // OpenAI API keys
        /AIza[0-9A-Za-z-_]{35}/g, // Google API keys
        /AKIA[0-9A-Z]{16}/g, // AWS Access Keys
        /eyJ[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*/g, // JWT tokens
        /[0-9a-f]{32}/g // Generic 32-char hashes
      ];

      for (const pattern of apiKeyPatterns) {
        const matches = content.match(pattern);
        if (matches) {
          this.violations.push({
            type: 'EXPOSED_API_KEY',
            file: filePath,
            severity: 'CRITICAL',
            message: `Clé API potentiellement exposée dans ${filePath}`
          });
        }
      }

      // Détection de mots de passe en dur
      const passwordPatterns = [
        /password\s*[:=]\s*["'][^"']+["']/gi,
        /pwd\s*[:=]\s*["'][^"']+["']/gi,
        /secret\s*[:=]\s*["'][^"']+["']/gi
      ];

      for (const pattern of passwordPatterns) {
        if (pattern.test(content)) {
          this.violations.push({
            type: 'HARDCODED_PASSWORD',
            file: filePath,
            severity: 'HIGH',
            message: `Mot de passe potentiellement en dur dans ${filePath}`
          });
        }
      }

      // Détection d'injections SQL potentielles
      const sqlInjectionPatterns = [
        /["']\s*\+\s*\w+\s*\+\s*["']/g,
        /\$\{[^}]*\}/g,
        /String\.format\([^)]*\)/g
      ];

      for (const pattern of sqlInjectionPatterns) {
        if (pattern.test(content)) {
          this.warnings.push({
            type: 'POTENTIAL_SQL_INJECTION',
            file: filePath,
            severity: 'MEDIUM',
            message: `Injection SQL potentielle dans ${filePath}`
          });
        }
      }

    } catch (error) {
      // Ignorer les erreurs de lecture (fichiers binaires, etc.)
    }
  }

  /**
   * Génère un rapport de sécurité
   */
  generateReport() {
    console.log('\n🛡️  RAPPORT DE SÉCURITÉ\n');
    
    if (this.violations.length === 0 && this.warnings.length === 0) {
      console.log('✅ Aucune violation de sécurité détectée.');
      return true;
    }

    if (this.violations.length > 0) {
      console.log('❌ VIOLATIONS CRITIQUES:');
      this.violations.forEach((violation, index) => {
        console.log(`${index + 1}. [${violation.severity}] ${violation.message}`);
      });
    }

    if (this.warnings.length > 0) {
      console.log('\n⚠️  AVERTISSEMENTS:');
      this.warnings.forEach((warning, index) => {
        console.log(`${index + 1}. [${warning.severity}] ${warning.message}`);
      });
    }

    return this.violations.length === 0;
  }

  /**
   * Sauvegarde le rapport dans un fichier
   */
  saveReport() {
    const timestamp = new Date().toISOString();
    const report = {
      timestamp,
      violations: this.violations,
      warnings: this.warnings,
      summary: {
        totalViolations: this.violations.length,
        totalWarnings: this.warnings.length,
        securityScore: Math.max(0, 100 - (this.violations.length * 10) - (this.warnings.length * 2))
      }
    };

    const reportPath = path.join(__dirname, 'security-report.json');
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
    console.log(`📄 Rapport sauvegardé: ${reportPath}`);
  }
}

/**
 * Point d'entrée principal
 */
function main() {
  const args = process.argv.slice(2);
  const command = args.join(' ');

  if (!command) {
    console.log('Usage: node pretools-security.js [command]');
    process.exit(1);
  }

  const analyzer = new SecurityAnalyzer();
  
  console.log('🚀 Démarrage de l'analyse de sécurité...');
  
  // Analyse de la commande
  const isCommandSafe = analyzer.analyzeCommand(command);
  
  // Analyse des fichiers du projet
  const projectFiles = [
    'lib/main.dart',
    'lib/core/network/supabase_client.dart',
    'pubspec.yaml',
    '.env',
    'android/app/build.gradle'
  ];

  projectFiles.forEach(file => {
    const fullPath = path.join(__dirname, file);
    analyzer.analyzeFile(fullPath);
  });

  // Génération du rapport
  const isSecure = analyzer.generateReport();
  analyzer.saveReport();

  if (!isSecure) {
    console.log('\n🚫 EXÉCUTION BLOQUÉE pour des raisons de sécurité.');
    process.exit(1);
  }

  console.log('\n✅ Analyse de sécurité terminée. Exécution autorisée.');
  process.exit(0);
}

// Protection contre l'exécution accidentelle
if (require.main === module) {
  main();
}

module.exports = { SecurityAnalyzer, SECURITY_RULES };