function fn() {
  var env = karate.env || java.lang.System.getenv('KARATE_ENV') || 'local';
  karate.log('karate.env =', env);

  var baseUrl =
    java.lang.System.getenv('BASE_URL') ||
    java.lang.System.getProperty('BASE_URL') ||
    '';

  var demoEmail =
    java.lang.System.getenv('DEMO_EMAIL') ||
    java.lang.System.getProperty('DEMO_EMAIL') ||
    'demo@automation.io';

  var demoPassword =
    java.lang.System.getenv('DEMO_PASSWORD') ||
    java.lang.System.getProperty('DEMO_PASSWORD') ||
    'Demo123!';

  var config = {
    env: env,
    demoEmail: demoEmail,
    demoPassword: demoPassword,
    loginPath: '/api/auth/login',
    usersPath: '/api/users',
    healthPath: '/health',
    timeoutMs: 2000,
    healthTimeoutMs: 1000
  };

  if (baseUrl && baseUrl.trim().length > 0) {
    config.baseUrl = baseUrl.replace(/\/$/, '');
  } else if (env === 'staging') {
    var staging = java.lang.System.getenv('STAGING_URL');
    if (!staging) {
      karate.fail('STAGING_URL is required when karate.env=staging');
    }
    config.baseUrl = staging.replace(/\/$/, '');
  } else {
    // local + ci
    config.baseUrl = 'http://localhost:5050';
  }

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 10000);
  karate.configure('ssl', true);

  return config;
}
