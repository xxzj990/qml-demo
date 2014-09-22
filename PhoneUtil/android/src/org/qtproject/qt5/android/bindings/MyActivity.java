package org.qtproject.qt5.android.bindings;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;

import java.util.Map;

import android.util.Log;
import android.os.Bundle;
import android.content.Context;
import android.telephony.TelephonyManager;

public class MyActivity extends QtActivity {

    private static MyActivity m_instance;

    public MyActivity() {
        m_instance = this;
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        AddressbookGeter.getInstance(m_instance).requestPermission();
    }

    public static String getPhoneNumber() {
        TelephonyManager tm = (TelephonyManager) m_instance.getSystemService(Context.TELEPHONY_SERVICE);
        return tm.getLine1Number();
    }

    public static Map<String, Contactor> getAddressbook() {
        Log.d("MyActivity", "Get addressbook.");
        return AddressbookGeter.getInstance(m_instance).getPhoneAddressbook();
    }

}

