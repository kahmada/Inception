<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
 
</head>
<body>

  <h1>🏗️ Inception - 42 Project</h1>

  <div class="section">
    <h2>📚 Project Description</h2>
    <p>
      The <strong>Inception</strong> project at 42 School introduces students to <span class="highlight">Docker</span> and system administration. The goal is to build a secure and scalable infrastructure with multiple services running in isolated Docker containers via <code>docker-compose</code>.
    </p>
  </div>

  <div class="section">
    <h2>🧱 Architecture</h2>
    <table>
      <thead>
        <tr>
          <th>Service</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>NGINX</td>
          <td>Reverse proxy with TLS (HTTPS) enabled</td>
        </tr>
        <tr>
          <td>WordPress</td>
          <td>CMS powered by PHP-FPM</td>
        </tr>
        <tr>
          <td>MariaDB</td>
          <td>Relational database used by WordPress</td>
        </tr>
        <tr>
          <td>Redis <em>(optional)</em></td>
          <td>Cache server for WordPress optimization</td>
        </tr>
        <tr>
          <td>Adminer <em>(optional)</em></td>
          <td>Lightweight web UI to manage MariaDB</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="section">
    <h2>📁 Project Structure</h2>
    <div class="folder-structure">
inception/
├── srcs/
│   ├── docker-compose.yml
│   ├── requirements/
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   └── default.conf
│   │   ├── wordpress/
│   │   │   ├── Dockerfile
│   │   │   └── setup.sh
│   │   └── mariadb/
│   │       ├── Dockerfile
│   │       └── init.sql
│   └── .env
├── README.md
└── Makefile
    </div>
  </div>

  <div class="section">
    <h2>🚀 Deployment</h2>
    <p>
      You can start the project by running:
    </p>
    <pre><code>cd srcs
docker compose up --build</code></pre>
    <p>
      Visit <code>https://localhost</code> in your browser once services are up.
    </p>
  </div>

  <div class="section">
    <h2>🔐 Security</h2>
    <ul>
      <li>Services are isolated in separate containers</li>
      <li>Passwords and secrets managed with <code>.env</code> and Docker Secrets</li>
      <li>HTTPS is enabled with a self-signed TLS certificate</li>
    </ul>
  </div>

  <div class="section">
    <h2>🛠️ Makefile Usage</h2>
    <pre><code>make            # Build and run all containers
make re   # Clean and rebuild everything
</code></pre>
  </div>

  <footer>
    <p><strong>Author:</strong> Kahmada – 42 School</p>
  </footer>

</body>
</html>
