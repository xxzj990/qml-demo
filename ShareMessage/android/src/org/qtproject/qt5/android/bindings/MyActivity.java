package org.qtproject.qt5.android.bindings;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;

import android.util.Log;
import android.content.Context;
import android.content.Intent;
import android.provider.MediaStore;
import android.telephony.TelephonyManager;
import android.text.TextUtils;

import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.SendMessageToWX;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.tencent.mm.sdk.openapi.WXMediaMessage;
import com.tencent.mm.sdk.openapi.WXTextObject;

public class MyActivity extends QtActivity {

    public static final String WECHAT_KEY = "your key";// Your key

    private static MyActivity m_instance;

    public MyActivity() {
        m_instance = this;

    }

    public static boolean share2WeChat(String text) {
        Log.d("MyActivity", "share2WeChat.");
        if(TextUtils.isEmpty(text)) {
            return true;
        }

        Context context = m_instance;

        try {
            IWXAPI mWeixin = WXAPIFactory.createWXAPI(context, WECHAT_KEY);
            if(!mWeixin.isWXAppInstalled()) {
                return false;
            }

            // 初始化一个WXTextObject对象
            WXTextObject textObj = new WXTextObject();
            textObj.text = text;

            // 用WXTextObject对象初始化一个WXMediaMessage对象
            WXMediaMessage msg = new WXMediaMessage();
            msg.mediaObject = textObj;
            // 发送文本类型的消息时，title字段不起作用
            // msg.title = "Will be ignored";
            msg.description = text;

            // 构造一个Req
            SendMessageToWX.Req req = new SendMessageToWX.Req();
            req.transaction = "text" + System.currentTimeMillis(); // transaction字段用于唯一标识一个请求
            req.message = msg;
            req.scene = SendMessageToWX.Req.WXSceneSession;

            // 调用api接口发送数据到微信
            mWeixin.sendReq(req);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }

}

