# neodocs

![](screen_shots/1.png)
![](screen_shots/2.png)


[https://github.com/DavBfr/dart_pdf/issues/384]

I had tried [https://pub.dev/packages/pdf] and [https://pub.dev/packages/syncfusion_flutter_pdf] both the packages it's working fine on IOS device but not working on Android.
I had also mention git-hub issues [https://github.com/DavBfr/dart_pdf/issues/384]. 
I had not used any fontstyle i used simple text .
If any one have any solution please let me know. 

# solutions 

1. add pdfgoole font if you are getting any font exception beacuse bydefualt pdf follows or use helvicta font wichh not supports unicode 
also you can add your custom font style 
```
   final theme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/fonts/Rubik-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/Rubik-Regular.ttf")),
    );
```
  just add below theme in Document(theme:theme);
you can also add this the to your multipage Object 
```
Multipage(theme: theme 
// rest code 
);
```
2. after these if your are useing open file package to open pdf 

then refer this solusion [https://stackoverflow.com/questions/69017428/flutter-open-file-dart-not-opening-pdf-file] 

                                        or use this code  
```
class PdfApi {
  Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    Directory dir;
    File file;

  if (Platform.isAndroid) {
      final String path = (await getExternalStorageDirectory())!.path;
      file = File('$path/$name');
    } else {
      dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$name');
    }

  await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
```
3 . add progaurd rule file in android/app  
                    and
'''
 -keep class com.shockwave.**
 -keepclassmembers class com.shockwave.** { *; }
```
add above line in file 

after that change in app/buildgradle 

```
 buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
```
add proguardFiles rule


  
