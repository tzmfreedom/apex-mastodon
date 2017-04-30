public with sharing class Mastodon_Client {
    private String endpoint;
    private String clientId;
    private String clientSecret;
    private String redirectUri;
    private String accessToken;
    private String namedCredential;

    public Mastodon_Client(String endpoint) {
        this.endpoint = endpoint;
    }

    public Mastodon_Client(String endpoint, String clientId, String clientSecret, String redirectUri) {
        this.endpoint = endpoint;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.redirectUri = redirectUri;
    }

    public void Authenticate(String username, String password) {
        Mastodon_Authentication auth = new Mastodon_Authentication('password', this.clientId, this.clientSecret, this.redirectUri);
        this.call('POST', '/oauth/token', auth.toJson());
    }

    public Mastodon_Status postStatus(Mastodon_Toot toot) {
        String body = this.call('POST', '/api/v1/statuses', toot.toQueryString());
        return (Mastodon_Status)JSON.deserialize(body, Mastodon_Status.class);
    }

    public String call(String method, String path, String body) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(this.endpoint + path);
        req.setMethod(method);
        if (String.isNotBlank(body)) {
            req.setBody(body);
        }
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res.getBody();
    }
}