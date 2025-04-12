#######################################
# 1. Jaga semua class dari Jackson
#######################################
# Untuk annotation
-keepattributes *Annotation*

# Semua class Jackson agar tidak dihapus
-keep class com.fasterxml.** { *; }
-dontwarn com.fasterxml.**

# Hindari penghapusan property/constructor
-keepclassmembers class * {
    @com.fasterxml.jackson.annotation.* <fields>;
    @com.fasterxml.jackson.annotation.* <methods>;
}

#######################################
# 2. Jaga class java.beans
#######################################
-keep class java.beans.** { *; }
-dontwarn java.beans.**

#######################################
# 3. Jaga class dari org.w3c.dom
#######################################
-keep class org.w3c.dom.** { *; }
-dontwarn org.w3c.dom.**

# Bootstrap class (yang dilaporkan hilang)
-keep class org.w3c.dom.bootstrap.** { *; }
-dontwarn org.w3c.dom.bootstrap.**

#######################################
# 4. Jaga class dari Conscrypt (TLS/SSL)
#######################################
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**

#######################################
# 5. Jaga semua native class yang digunakan via refleksi
#######################################
# Amankan class-class yang dipanggil via refleksi agar tidak dihapus
-keepnames class * {
    public <init>(...);
}
-keepclassmembers class * {
    public <init>(...);
}

#######################################
# 6. Tambahan umum untuk plugin Android
#######################################
# Hindari penghapusan method dan field yang dipanggil via refleksi
-keepclassmembers class * {
   *;
}
-keepclasseswithmembers class * {
   *;
}


# Prevent R8 from removing Play Core split install classes
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**

-keep class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.splitcompat.**git push

-keep class com.google.android.play.core.splitinstall.** { *; }
-dontwarn com.google.android.play.core.splitinstall.**

-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.tasks.**
