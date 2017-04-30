/**
 * Created by mtajitsu on 2017/04/30.
 */

public with sharing class Mastodon_Authentication {
    private String grantType;
    private String clientId;
    private String clientSecret;
    private String redirectUri;
    private String scope;
    private String username;
    private String password;

    public Mastodon_Authentication(String grantType, String clientId, String clientSecret, String redirectUri) {
        this.grantType = grantType;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.scope = 'read write follow';
    }

    public Mastodon_Authentication(String grantType, String clientId, String clientSecret, String redirectUri, String username, String password) {
        this(grantType, clientId, clientSecret, redirectUri);
        this.username = username;
        this.password = password;
    }

    public String toJson() {
        if (this.grantType == 'password') {
            Map<String, String> paramMap = new Map<String, String> {
                'client_id' => this.clientId,
                'client_secret' => this.clientSecret,
                'grant_type' => this.grantType,
                'scope' => this.scope,
                'username' => this.username,
                'password' => this.password
            };
            return Mastodon_Util.convertToQueryString(paramMap);
        }
        return '';
    }
}