# Quiz System

A comprehensive online examination platform for educational institutions.

## Features

- **Role-based Access Control**: Admin, Instructor, and Student roles
- **Quiz Management**: Create, edit, and manage quizzes with various question types
- **Real-time Scoring**: Instant results and feedback
- **Analytics Dashboard**: Performance tracking and reporting
- **Secure Authentication**: JWT-based authentication with password encryption

## Tech Stack

### Frontend
- React.js with Material-UI
- React Router for navigation
- Chart.js for analytics
- Axios for API calls

### Backend
- Java Spring Boot
- Spring Security with JWT
- Spring Data JPA
- MySQL Database

### Deployment
- Docker & Docker Compose
- AWS EC2 (ready for deployment)

## Quick Start

### Prerequisites
- Docker and Docker Compose
- Java 17+ (for local development)
- Node.js 18+ (for local development)
- MySQL 8.0+

### Using Docker (Recommended)
```bash
# Clone the repository
git clone https://github.com/yourusername/quiz-system.git
cd quiz-system

# Start all services
docker-compose up -d

# Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:8080
# MySQL: localhost:3306
