@echo off

:: Pre Cleanup
del /s %1.staging.jar
del /s %1.staging.zip
rd /s /q %1.staging
del /s %1.zip

:: Run tools on jar
java -cp "dist/Dexecrator.jar;lib/*" com.dalvikjvm.Dexecrator %1 %1.staging.jar
java -cp "tools/d8.jar" com.android.tools.r8.D8 --min-api 26 --release --output %1.staging.zip %1.staging.jar

:: Extract results
"tools/Windows/7z" -y -o%1.staging x %1.staging.jar
"tools/Windows/7z" -y -o%1.staging x %1.staging.zip

:: Delete class files and empty folders from staging
del /s %1.staging\*.class
for /f "delims=" %%d in ('dir /s /b /ad %1.staging ^| sort /r') do rd /q "%%d"

:: Archive files
"tools/Windows/7z" -mx9 -y a %1.zip %1.staging/*

:: Post Cleanup
del /s %1.staging.jar
del /s %1.staging.zip
rd /s /q %1.staging
