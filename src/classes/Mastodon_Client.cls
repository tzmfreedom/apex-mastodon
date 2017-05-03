public with sharing class Mastodon_Client {
    private static final String BASE_PATH = '/api/v1';
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

    public void authorizeByCredential(String username, String password) {
        HTTPResponse res = this.call(
            'POST', 
            '/oauth/token', 
            Mastodon_Util.convertToQueryString(new Map<String, String>{
                'grant_type' => 'password',
                'client_id' => this.clientId,
                'client_secret' => this.clientSecret,
                'redirect_uri' => this.redirectUri,
                'username' => username,
                'password' => password    
            })
        );
        if (res.getStatusCode() == 302) {
            throw new Mastodon_Exception('Invalid Credentials');
        }
        Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        if (resMap.get('error') != null) {
            throw new Mastodon_Exception(String.valueOf(resMap.get('error')) + ' : ' + String.valueOf(resMap.get('error_description')));
        }
        this.accessToken = String.valueOf(resMap.get('access_token'));
    }
    
    public String getAuthorizeUrl(String scope, String state) {
        return this.endpoint + '/oauth/authorize?' + Mastodon_Util.convertToQueryString(new Map<String, String> {
            'response_type' => 'code',
            'client_id' => this.clientId,
            'client_secret' => this.clientSecret,
            'redirect_uri' => this.redirectUri,
            'state' => state,
            'scope' => scope
        });
    }
    
    public void authorizeByCode(String code) {
        HTTPResponse res = this.call(
            'POST', 
            '/oauth/token', 
            Mastodon_Util.convertToQueryString(new Map<String, String>{
                'grant_type' => 'authorization_code',
                'client_id' => this.clientId,
                'client_secret' => this.clientSecret,
                'redirect_uri' => this.redirectUri,
                'code' => code
            })
        );
        Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        if (resMap.get('error') != null) {
            throw new Mastodon_Exception(String.valueOf(resMap.get('error')) + ' : ' + String.valueOf(resMap.get('error_description')));
        }
        this.accessToken = String.valueOf(resMap.get('access_token'));
    }
    
    public Mastodon_Account getAccount(Integer id) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/' + id, null);    
        return (Mastodon_Account)JSON.deserialize(res.getBody(), Mastodon_Account.class);
    }
    
    public Mastodon_Account getCurrentAccount() {
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/verify_credentials', null);    
        return (Mastodon_Account)JSON.deserialize(res.getBody(), Mastodon_Account.class);
    }

    public Mastodon_Account updateCurrentUser(Mastodon_Profile profile) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/update_credentials', '_method=PATCH&' + profile.toQueryString());
        return (Mastodon_Account)JSON.deserialize(res.getBody(), Mastodon_Account.class);
    }
    
    public List<Mastodon_Account> getFollowers(Integer id, Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/' + id + '/followers', range.toQueryString());    
        return (List<Mastodon_Account>)JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
    
    public List<Mastodon_Account> getFollowing(Integer id, Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/' + id + '/following', range.toQueryString());    
        return (List<Mastodon_Account>)JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
    
    // Todo: range parameter 
    public List<Mastodon_Status> getStatuses(Integer id) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/' + id + '/statuses', null);    
        return (List<Mastodon_Status>)JSON.deserialize(res.getBody(), List<Mastodon_Status>.class);
    }
        
    public Mastodon_RelationShip followAccount(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/' + id + '/follow', null);    
        return (Mastodon_RelationShip)JSON.deserialize(res.getBody(), Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip unfollowAccount(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/' + id + '/unfollow', null);    
        return (Mastodon_RelationShip)JSON.deserialize(res.getBody(), Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip blockAccount(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/' + id + '/block', null);    
        return (Mastodon_RelationShip)JSON.deserialize(res.getBody(), Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip unblockAccount(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/' + id + '/unblock', null);    
        return (Mastodon_RelationShip)JSON.deserialize(res.getBody(), Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip muteAccount(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/' + id + '/mute', null);    
        return (Mastodon_RelationShip)JSON.deserialize(res.getBody(), Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip unmuteAccount(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/accounts/' + id + '/unmute', null);    
        return (Mastodon_RelationShip)JSON.deserialize(res.getBody(), Mastodon_RelationShip.class);
    }

    public List<Mastodon_RelationShip> getRelationShips(List<Integer> ids) {
        List<String> params = new List<String>();
        for (Integer id : ids) {
            params.add('id[]=' + id);
        }
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/relationships', String.join(params, '&'));    
        return (List<Mastodon_RelationShip>)JSON.deserialize(res.getBody(), List<Mastodon_RelationShip>.class);
    }
    
    public List<Mastodon_Account> searchAccount(String q, Integer limit_no) {
        List<String> params = new List<String>();
        if (q != null ) {
            params.add('q=' + EncodingUtil.urlEncode(q, 'utf-8'));
        }
        if (limit_no != null ) {
            params.add('limit=' + limit_no);
        }
        HTTPResponse res = this.call('GET', BASE_PATH + '/accounts/search', String.join(params, '&;:w'));    
        return (List<Mastodon_Account>)JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
   
    public Mastodon_OAuthApplication registerApplication(Mastodon_AppConfig config) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/apps', config.toQueryString());
        return (Mastodon_OAuthApplication) JSON.deserialize(res.getBody(), Mastodon_OAuthApplication.class);
    }
    
    public List<Mastodon_Account> getBlocks(Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/blocks', range.toQueryString());
        return (List<Mastodon_Account>) JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }

    public List<Mastodon_Account> getFavourites(Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/favourites', range.toQueryString());
        return (List<Mastodon_Account>) JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }

    public List<Mastodon_Account> getFollowRequests(Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/follow_requests', range.toQueryString());
        return (List<Mastodon_Account>) JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
    
    public void authorizeFollowRequest(Integer id) {
        this.call('POST', BASE_PATH + '/follow_requests/' + id + '/authorize', null);
    }

    public void rejectFollowRequest(Integer id) {
        this.call('POST', BASE_PATH + '/follow_requests/' + id + '/reject', null);
    }

    public Mastodon_Account followAccount(String uri) {
        String param = 'uri=' + EncodingUtil.urlEncode(uri, 'utf-8');
        HTTPResponse res = this.call('POST', BASE_PATH + '/follows', param);
        return (Mastodon_Account) JSON.deserialize(res.getBody(), Mastodon_Account.class);
    }

    public Mastodon_Instance getInstance() {
        HTTPResponse res = this.call('GET', BASE_PATH + '/instance', null);
        return (Mastodon_Instance) JSON.deserialize(res.getBody(), Mastodon_Instance.class);
    }

    // Todo: file data
    public Mastodon_Attachment uploadMedia(String base64EncodedFile) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/media', 'file=' + base64EncodedFile);
        return (Mastodon_Attachment) JSON.deserialize(res.getBody(), Mastodon_Attachment.class);
    }
    
    public List<Mastodon_Account> getMutes(Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/mutes', range.toQueryString());
        return (List<Mastodon_Account>) JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
    
    public List<Mastodon_Notification> getNotifications(Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/notifications', range.toQueryString());
        return (List<Mastodon_Notification>) JSON.deserialize(res.getBody(), List<Mastodon_Notification>.class);
    }
    
    public Mastodon_Notification getNotification(Integer id) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/notifications/' + id, null);
        return (Mastodon_Notification) JSON.deserialize(res.getBody(), Mastodon_Notification.class);
    }
    
    public void clearNotifications() {
        this.call('POST', BASE_PATH + '/notifications/clear', null);
    }
    
    public List<Mastodon_Report> getReports() {
        HTTPResponse res = this.call('GET', BASE_PATH + '/reports', null);
        return (List<Mastodon_Report>) JSON.deserialize(res.getBody(), List<Mastodon_Report>.class);
    }

    public Mastodon_Report reportUser(Mastodon_ReportRequest request) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/reports', request.toQueryString());
        return (Mastodon_Report) JSON.deserialize(res.getBody(), Mastodon_Report.class);
    }
    
    public Mastodon_Results searchContent(String q, Boolean resolve) {
    	String queryString = Mastodon_Util.convertToQueryString(new Map<String, String> { 
    		'q' => q ,
    		'resolve' => String.valueOf(resolve)
    	});
        HTTPResponse res = this.call('GET', BASE_PATH + '/search?' + queryString, null);
        return (Mastodon_Results) JSON.deserialize(res.getBody(), Mastodon_Results.class);
    }
    
    public Mastodon_Status getStatus(Integer id) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/statuses/' + id, null);
        return (Mastodon_Status) JSON.deserialize(res.getBody(), Mastodon_Status.class);
    }

    public Mastodon_Context getContext(Integer id) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/statuses/' + id + '/context', null);
        return (Mastodon_Context) JSON.deserialize(res.getBody(), Mastodon_Context.class);
    }

    public Mastodon_Card getCard(Integer id) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/statuses/' + id + '/card', null);
        return (Mastodon_Card) JSON.deserialize(res.getBody(), Mastodon_Card.class);
    }
    
    public List<Mastodon_Account> getRebloggedBy(Integer id, Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/statuses/' + id + '/reblogged_by', range.toQueryString());
        return (List<Mastodon_Account>) JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
    
    public List<Mastodon_Account> getFavouritedBy(Integer id, Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/statuses/' + id + '/favourited_by', range.toQueryString());
        return (List<Mastodon_Account>) JSON.deserialize(res.getBody(), List<Mastodon_Account>.class);
    }
    
    public Mastodon_Status postStatus(Mastodon_Toot toot) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/statuses', toot.toQueryString());
        return (Mastodon_Status)JSON.deserialize(res.getBody(), Mastodon_Status.class);
    }
    
    public void deleteStatus(Integer id) {
        this.call('DELETE', BASE_PATH + '/statuses/' + id, null);
    }
    
    public Mastodon_Status reblogStatus(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/statuses/' + id + '/reblog', null);
        return (Mastodon_Status)JSON.deserialize(res.getBody(), Mastodon_Status.class);
    }

    public Mastodon_Status unreblogStatus(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/statuses/' + id + '/unreblog', null);
        return (Mastodon_Status)JSON.deserialize(res.getBody(), Mastodon_Status.class);
    }

    public Mastodon_Status favouriteStatus(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/statuses/' + id + '/favourite', null);
        return (Mastodon_Status)JSON.deserialize(res.getBody(), Mastodon_Status.class);
    }

    public Mastodon_Status unfavouriteStatus(Integer id) {
        HTTPResponse res = this.call('POST', BASE_PATH + '/statuses/' + id + '/unfavourite', null);
        return (Mastodon_Status)JSON.deserialize(res.getBody(), Mastodon_Status.class);
    }

    public List<Mastodon_Status> retrieveTimeline(String type, Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/timelines/' + type, range.toQueryString());
        return (List<Mastodon_Status>) JSON.deserialize(res.getBody(), List<Mastodon_Status>.class);
    }
    
    public List<Mastodon_Status> retrieveTimelineByTag(String hashtag, Mastodon_Range range) {
        HTTPResponse res = this.call('GET', BASE_PATH + '/timelines/tag/' + hashtag, range.toQueryString());
        return (List<Mastodon_Status>) JSON.deserialize(res.getBody(), List<Mastodon_Status>.class);
    }

    private HTTPResponse call(String method, String path, String body) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(this.endpoint + path);
        req.setMethod(method);
        if (String.isNotBlank(this.accessToken)) {
            req.setHeader('Authorization', 'Bearer ' + this.accessToken);
        }
        if (String.isNotBlank(body)) {
            req.setBody(body);
        }
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;
    }
}