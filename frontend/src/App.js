import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';

// Context
import { AuthProvider } from './context/AuthContext';

// Pages
import Login from './components/auth/Login';
import Register from './components/auth/Register';
import DashboardPage from './pages/DashboardPage';
import HomePage from './pages/HomePage';
import NotFoundPage from './pages/NotFoundPage';

// Layout
import MainLayout from './components/layout/MainLayout';
import AuthLayout from './components/layout/AuthLayout';

// Theme
const theme = createTheme({
  palette: {
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#dc004e',
    },
    background: {
      default: '#f5f5f5',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
  },
});

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <AuthProvider>
        <Router>
          <Routes>
            {/* Public Routes */}
            <Route path="/" element={<HomePage />} />
            
            {/* Auth Routes */}
            <Route path="/auth" element={<AuthLayout />}>
              <Route path="login" element={<Login />} />
              <Route path="register" element={<Register />} />
            </Route>
            
            {/* Protected Routes */}
            <Route path="/dashboard" element={<MainLayout />}>
              <Route index element={<DashboardPage />} />
              {/* Admin Routes */}
              <Route path="admin/*" element={<div>Admin Dashboard</div>} />
              {/* Instructor Routes */}
              <Route path="instructor/*" element={<div>Instructor Dashboard</div>} />
              {/* Student Routes */}
              <Route path="student/*" element={<div>Student Dashboard</div>} />
            </Route>
            
            {/* Catch-all Route */}
            <Route path="*" element={<NotFoundPage />} />
          </Routes>
        </Router>
      </AuthProvider>
    </ThemeProvider>
  );
}

export default App;
