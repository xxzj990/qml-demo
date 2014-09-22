package org.qtproject.qt5.android.bindings;

import java.util.HashMap;
import java.util.Map;

import android.content.Context;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.text.TextUtils;
import android.content.ContentResolver;
import android.database.Cursor;

public class AddressbookGeter {
    /**联系人显示名称**/
    private static final int PHONES_DISPLAY_NAME_INDEX = 0;

    /**电话号码**/
    private static final int PHONES_NUMBER_INDEX = 1;

    /**头像ID**/
    private static final int PHONES_PHOTO_ID_INDEX = 2;

    /**联系人的ID**/
    private static final int PHONES_CONTACT_ID_INDEX = 3;

    /** 获取手机通讯录联系人 */
    private String[] PHONES_PROJECTION = new String[] {
                    Phone.DISPLAY_NAME, Phone.NUMBER, Phone.PHOTO_ID,
                    Phone.CONTACT_ID};

    /** 单例对象 */
    private static AddressbookGeter instance = null;

    /** 上下文 */
    private Context mContext;

    /** 手机通讯录 */
    private Map<String, Contactor> mPhoneAddressbook = null;

    public static AddressbookGeter getInstance(Context context) {
        if(null == instance) {
            instance = new AddressbookGeter(context);
        }
        return instance;
    }

    public synchronized Map<String, Contactor> getPhoneAddressbook() {
        if(null == mPhoneAddressbook) {
            loadPhoneAddressbook();
        }

        return mPhoneAddressbook;
    }

    private AddressbookGeter(Context context) {
        this.mContext = context;
    }

    private void loadPhoneAddressbook() {
        Map<String, Contactor> contactors = new HashMap<String, Contactor>();

        try {
            ContentResolver resolver = mContext.getContentResolver();

            // 获取手机联系人
            Cursor phoneCursor = resolver.query(Phone.CONTENT_URI, PHONES_PROJECTION, null, null, null);

            if (phoneCursor != null) {
                Contactor contactor;
                String phoneNumber;// 手机号
                String contactName;// 姓名
                while (phoneCursor.moveToNext()) {

                    // 得到手机号码
                    phoneNumber = phoneCursor.getString(PHONES_NUMBER_INDEX);

                    // 当手机号码为空的或者为空字段 跳过当前循环
                    if (TextUtils.isEmpty(phoneNumber)) continue;

                    // 创建联系人对象
                    contactor = new Contactor();
                    contactor.setPhone(phoneNumber);

                    // 得到联系人名称
                    contactName = phoneCursor.getString(PHONES_DISPLAY_NAME_INDEX);
                    boolean needPut = false;
                    if (TextUtils.isEmpty(contactName)) {
                        // 姓名转拼音
                        contactor.setName(phoneNumber);

                        // 没名字的记录，若通讯录不存在时才插入
                        if(!contactors.containsKey(phoneNumber)) {
                            // 覆盖
                            needPut = true;
                        } // else 姓名为空，且列表已存在时不覆盖
                    } else {
                        // 设置姓名
                        contactor.setName(contactName);

                        // 覆盖
                        needPut = true;
                    }

                    // 储存
                    if (needPut) {
                        contactors.put(contactor.getPhone(), contactor);
                    }

                }

                phoneCursor.close();
            }
        } catch (Exception e) {
                e.printStackTrace();
        }

        if(null != contactors && !contactors.isEmpty()) {
                mPhoneAddressbook = contactors;
        }
    }

}

