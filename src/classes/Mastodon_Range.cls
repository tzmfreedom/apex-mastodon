public with sharing class Mastodon_Range {
    public Integer max_id;
    public Integer since_id;
    public Integer limit_no;
    
    public String toQueryString() {
        Map<String, String> params = new Map<String, String>();
        if (this.max_id != null) {
            params.put('max_id', String.valueOf(this.max_id));
        }
        if (this.since_id != null) {
            params.put('max_id', String.valueOf(this.since_id));
        }
        if (this.limit_no != null) {
            params.put('max_id', String.valueOf(this.limit_no));
        }
        return Mastodon_Util.convertToQueryString(params);
    }
}