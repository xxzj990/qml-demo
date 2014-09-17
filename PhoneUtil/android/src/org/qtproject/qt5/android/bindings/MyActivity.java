package org.qtproject.qt5.android.bindings;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;

import android.content.Context;
import android.telephony.TelephonyManager;

public class MyActivity extends QtActivity {

    private static MyActivity m_instance;

    public MyActivity() {
        m_instance = this;
    }

    public static String getPhoneNumber() {
        TelephonyManager tm = (TelephonyManager) m_instance.getSystemService(Context.TELEPHONY_SERVICE);
        return tm.getLine1Number();
    }

}

