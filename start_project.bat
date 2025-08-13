@echo off
echo ========================================
echo Django Blog Project Setup
echo ========================================
echo.

echo Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)

echo Python found! Creating virtual environment...
python -m venv venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)

echo Activating virtual environment...
call venv\Scripts\activate
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment
    pause
    exit /b 1
)

echo Installing dependencies...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo Creating database...
python manage.py makemigrations
python manage.py migrate

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Create a superuser: python manage.py createsuperuser
echo 2. Start the server: python manage.py runserver
echo 3. Open http://127.0.0.1: alr8000/ in your browser
echo 4. Access admin at http://127.0.0.1:8000/admin/
echo.
echo Press any key to create a superuser now...
pause >nul

echo.
echo Creating superuser (press Ctrl+C to skip)...
python manage.py createsuperuser

echo.
echo Starting Django development server...
echo Press Ctrl+C to stop the server
echo.
python manage.py runserver

pause
