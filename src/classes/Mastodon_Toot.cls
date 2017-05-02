public with sharing class Mastodon_Toot {
    public String status;
    public Integer in_reply_to_id;
    public List<Integer> media_ids;
    public Boolean sensitive;
    public String spoiler_text;
    public String visibility;    

    public Mastodon_Toot(String status) {
        this.status = status;
    }

    public String toQueryString() {
        List<String> params = new List<String>();
        params.add('status=' + EncodingUtil.urlEncode(this.status, 'utf-8'));
        if (this.in_reply_to_id != null) {
            params.add('in_reply_to_id=' + String.valueOf(this.in_reply_to_id));
        }
        if (this.sensitive != null) {
            params.add('sensitive=' + String.valueOf(this.sensitive));
        }
        if (this.media_ids != null) {
            for (Integer media_id : media_ids) {
                params.add('media_ids[]=' + media_id);    
            }
        }
        if (this.spoiler_text != null) {
            params.add('spoiler_text=' + Encodingutil.urlEncode(this.spoiler_text, 'utf-8'));
        }
        if (this.visibility != null) {
            params.add('visibility=' + String.valueOf(this.visibility));
        }
        return String.join(params, '&');
    }
}
