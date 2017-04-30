public with sharing class Mastodon_Toot {
    private String status;

    public Mastodon_Toot(String status) {
        this.status = status;
    }

    public String toQueryString() {
        return 'status=' + EncodingUtil.urlEncode(this.status, 'utf-8');
    }
}