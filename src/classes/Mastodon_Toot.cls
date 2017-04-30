/**
 * Created by mtajitsu on 2017/04/30.
 */

public with sharing class Mastodon_Toot {
    private String status;

    public Mastodon_Toot(String status) {
        this.status = status;
    }

    public String toQueryString() {
        return 'status=' + this.status;
    }
}