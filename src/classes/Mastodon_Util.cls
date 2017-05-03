public with sharing class Mastodon_Util {
    public static String convertToQueryString(Map<String, String> params) {
        if (params == NULL || params.isEmpty()) {
            return '';
        }
        List<String> queryValues = new List<String>{};
        for (String key : params.keySet()) {
            if (params.get(key) != null) {
                queryValues.add(
                    key + '=' + EncodingUtil.urlEncode(String.valueOf(params.get(key)), 'utf-8'));
            }
        }
        return String.join(queryvalues, '&');
    }
}