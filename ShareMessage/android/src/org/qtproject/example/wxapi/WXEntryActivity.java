package org.qtproject.example.wxapi;

import com.tencent.mm.sdk.openapi.BaseReq;
import com.tencent.mm.sdk.openapi.BaseResp;
import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.sdk.openapi.WXAPIFactory;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import org.qtproject.qt5.android.bindings.MyActivity;

public class WXEntryActivity extends Activity implements IWXAPIEventHandler {

	private IWXAPI api;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
            api = WXAPIFactory.createWXAPI(this, MyActivity.WECHAT_KEY, false);
            api.handleIntent(getIntent(), this);
            super.onCreate(savedInstanceState);
	}
	
	@Override
	protected void onNewIntent(Intent intent) {
            super.onNewIntent(intent);
            setIntent(intent);
            api.handleIntent(intent, this);
	}

	@Override
	public void onReq(BaseReq arg0) {}

	@Override
	public void onResp(BaseResp arg0) {
		
            // 分享成功
            if(arg0.errCode == BaseResp.ErrCode.ERR_OK) {
                Toast.makeText(this, "Success", Toast.LENGTH_SHORT).show();
            }

            // 分享取消
            else if(arg0.errCode == BaseResp.ErrCode.ERR_USER_CANCEL) {
                Toast.makeText(this, "Cancel", Toast.LENGTH_SHORT).show();
            }

            // 分享失败
            else {
                Toast.makeText(this, "Failed", Toast.LENGTH_SHORT).show();
            }

            finish();
	}

}
