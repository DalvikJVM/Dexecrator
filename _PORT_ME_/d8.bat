@echo off
java -cp "d8.jar" com.android.tools.r8.D8 --release --output %1.zip %1
