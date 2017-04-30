/**
 * Created by mtajitsu on 2017/04/30.
 */

public with sharing class Mastodon_Util {
    public static String convertToQueryString(Map<String, String> params) {
        if (params == NULL || params.isEmpty()) {
            return '';
        }
        List<String> queryValues = new List<String>{};
        for (String key : params.keySet()) {
            queryValues.add(key + '=' + EncodingUtil.urlEncode(params.get(key), 'utf-8'));
        }
        return String.join(queryvalues, '&');
    }
}