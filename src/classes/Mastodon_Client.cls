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

    public void Authenticate(String username, String password) {
        Mastodon_Authentication auth = new Mastodon_Authentication('password', this.clientId, this.clientSecret, this.redirectUri);
        this.call('POST', '/oauth/token', auth.toJson());
    }
    
    public Mastodon_Account getAccount(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/accounts/' + id, null);	
    	return (Mastodon_Account)JSON.deserialize(body, Mastodon_Account.class);
    }
    
    public Mastodon_Account getCurrentUser(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/accounts/verify_credentials', null);	
    	return (Mastodon_Account)JSON.deserialize(body, Mastodon_Account.class);
    }

	// Todo: form parameter
    public Mastodon_Account updateCurrentUser(Integer id) {
    	String body = this.call('PATH', BASE_PATH + '/accounts/update_credentials', '');	
    	return (Mastodon_Account)JSON.deserialize(body, Mastodon_Account.class);
    }
    
    public List<Mastodon_Account> getFollowers(Integer id, Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/accounts/' + id + '/followers', range.toQueryString());	
    	return (List<Mastodon_Account>)JSON.deserialize(body, List<Mastodon_Account>.class);
    }
    
    public List<Mastodon_Account> getFollowing(Integer id, Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/accounts/' + id + '/following', range.toQueryString());	
    	return (List<Mastodon_Account>)JSON.deserialize(body, List<Mastodon_Account>.class);
    }
    // Todo: range parameter 
    public List<Mastodon_Status> getStatuses(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/accounts/' + id + '/statuses', null);	
    	return (List<Mastodon_Status>)JSON.deserialize(body, List<Mastodon_Status>.class);
    }
        
    public Mastodon_RelationShip followAccount(Integer id) {
    	String body = this.call('POST', BASE_PATH + '/accounts/' + id + '/follow', null);	
    	return (Mastodon_RelationShip)JSON.deserialize(body, Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip unfollowAccount(Integer id) {
    	String body = this.call('POST', BASE_PATH + '/accounts/' + id + '/unfollow', null);	
    	return (Mastodon_RelationShip)JSON.deserialize(body, Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip blockAccount(Integer id) {
    	String body = this.call('POST', BASE_PATH + '/accounts/' + id + '/block', null);	
    	return (Mastodon_RelationShip)JSON.deserialize(body, Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip unblockAccount(Integer id) {
    	String body = this.call('POST', BASE_PATH + '/accounts/' + id + '/unblock', null);	
    	return (Mastodon_RelationShip)JSON.deserialize(body, Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip muteAccount(Integer id) {
    	String body = this.call('POST', BASE_PATH + '/accounts/' + id + '/mute', null);	
    	return (Mastodon_RelationShip)JSON.deserialize(body, Mastodon_RelationShip.class);
    }

    public Mastodon_RelationShip unmuteAccount(Integer id) {
    	String body = this.call('POST', BASE_PATH + '/accounts/' + id + '/unmute', null);	
    	return (Mastodon_RelationShip)JSON.deserialize(body, Mastodon_RelationShip.class);
    }

    public List<Mastodon_RelationShip> getRelationShips(List<Integer> ids) {
    	List<String> params = new List<String>();
    	for (Integer id : ids) {
    		params.add('id[]=' + id);
    	}
    	String body = this.call('GET', BASE_PATH + '/accounts/relationships', String.join(params, '&'));	
    	return (List<Mastodon_RelationShip>)JSON.deserialize(body, List<Mastodon_RelationShip>.class);
    }
    
    public List<Mastodon_Account> searchAccount(String q, Integer limit_no) {
    	List<String> params = new List<String>();
    	if (q != null ) {
    		params.add('q=' + EncodingUtil.urlEncode(q, 'utf-8'));
    	}
    	if (limit_no != null ) {
    		params.add('limit=' + limit_no);
    	}
    	String body = this.call('GET', BASE_PATH + '/accounts/search', String.join(params, '&;:w'));	
    	return (List<Mastodon_Account>)JSON.deserialize(body, List<Mastodon_Account>.class);
    }
   
    // Todo: parameter 
    public Mastodon_Application registerApplication() {
    	String body = this.call('POST', BASE_PATH + '/apps', null);	
    	return (Mastodon_Application) JSON.deserialize(body, Mastodon_Application.class);
    }
    
    public List<Mastodon_Account> getBlocks(Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/blocks', range.toQueryString());
    	return (List<Mastodon_Account>) JSON.deserialize(body, List<Mastodon_Account>.class);
    }

    public List<Mastodon_Account> getFavourites(Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/favourites', range.toQueryString());
    	return (List<Mastodon_Account>) JSON.deserialize(body, List<Mastodon_Account>.class);
    }

    public List<Mastodon_Account> getFollowRequests(Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/follow_requests', range.toQueryString());
    	return (List<Mastodon_Account>) JSON.deserialize(body, List<Mastodon_Account>.class);
    }
    
    public void authorizeFollowRequest(Integer id) {
    	this.call('POST', BASE_PATH + '/follow_requests/' + id + '/authorize', null);
    }

    public void rejectFollowRequest(Integer id) {
    	this.call('POST', BASE_PATH + '/follow_requests/' + id + '/reject', null);
    }

    public Mastodon_Account followAccount(String uri) {
    	String param = 'uri=' + EncodingUtil.urlEncode(uri, 'utf-8');
    	String body = this.call('POST', BASE_PATH + '/follows', param);
    	return (Mastodon_Account) JSON.deserialize(body, Mastodon_Account.class);
    }

    public Mastodon_Instance getInstance() {
    	String body = this.call('GET', BASE_PATH + '/instance', null);
    	return (Mastodon_Instance) JSON.deserialize(body, Mastodon_Instance.class);
    }

    public Mastodon_Attachment uploadMedia() {
    	String body = this.call('POST', BASE_PATH + '/media', null);
    	return (Mastodon_Attachment) JSON.deserialize(body, Mastodon_Attachment.class);
    }
    
    public List<Mastodon_Account> getMutes(Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/mutes', range.toQueryString());
    	return (List<Mastodon_Account>) JSON.deserialize(body, List<Mastodon_Account>.class);
    }
    
    public List<Mastodon_Notification> getNotifications(Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/notifications', range.toQueryString());
    	return (List<Mastodon_Notification>) JSON.deserialize(body, List<Mastodon_Notification>.class);
    }
    
    public Mastodon_Notification getNotification(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/notifications/' + id, null);
    	return (Mastodon_Notification) JSON.deserialize(body, Mastodon_Notification.class);
    }
    
    public void clearNotifications() {
    	this.call('POST', BASE_PATH + '/notifications/clear', null);
    }
    
    public List<Mastodon_Report> getReports() {
    	String body = this.call('GET', BASE_PATH + '/reports', null);
    	return (List<Mastodon_Report>) JSON.deserialize(body, List<Mastodon_Report>.class);
    }

    public List<Mastodon_Report> reportUser() {
    	String body = this.call('POST', BASE_PATH + '/reports', null);
    	return (List<Mastodon_Report>) JSON.deserialize(body, List<Mastodon_Report>.class);
    }
    
    public List<Mastodon_Results> searchContent() {
    	String body = this.call('GET', BASE_PATH + '/reports', null);
    	return (List<Mastodon_Results>) JSON.deserialize(body, List<Mastodon_Results>.class);
    }
    
    public Mastodon_Status getStatus(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/statuses/' + id, null);
    	return (Mastodon_Status) JSON.deserialize(body, Mastodon_Status.class);
    }

    public Mastodon_Context getStatusContext(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/statuses/' + id + '/context', null);
    	return (Mastodon_Context) JSON.deserialize(body, Mastodon_Context.class);
    }

    public Mastodon_Card getCard(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/statuses/' + id + '/card', null);
    	return (Mastodon_Card) JSON.deserialize(body, Mastodon_Card.class);
    }
    
    public List<Mastodon_Account> getRebloggedBy(Integer id, Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/statuses/' + id + '/reblogged_by', range.toQueryString());
    	return (List<Mastodon_Account>) JSON.deserialize(body, List<Mastodon_Account>.class);
    }
    
    public List<Mastodon_Account> getFavouritedBy(Integer id) {
    	String body = this.call('GET', BASE_PATH + '/statuses/' + id + '/favourited_by', null);
    	return (List<Mastodon_Account>) JSON.deserialize(body, List<Mastodon_Account>.class);
    }
    
    public Mastodon_Status postStatus(Mastodon_Toot toot) {
        String body = this.call('POST', BASE_PATH + '/statuses', toot.toQueryString());
        return (Mastodon_Status)JSON.deserialize(body, Mastodon_Status.class);
    }
    
    public void deleteStatus(Integer id) {
        this.call('DELETE', BASE_PATH + '/statuses/' + id, null);
    }
    
    public Mastodon_Status reblogStatus(Integer id) {
        String body = this.call('POST', BASE_PATH + '/statuses/' + id + '/reblog', null);
        return (Mastodon_Status)JSON.deserialize(body, Mastodon_Status.class);
    }

    public Mastodon_Status unreblogStatus(Integer id) {
        String body = this.call('POST', BASE_PATH + '/statuses/' + id + '/unreblog', null);
        return (Mastodon_Status)JSON.deserialize(body, Mastodon_Status.class);
    }

    public Mastodon_Status favouriteStatus(Integer id) {
        String body = this.call('POST', BASE_PATH + '/statuses/' + id + '/reblog', null);
        return (Mastodon_Status)JSON.deserialize(body, Mastodon_Status.class);
    }

    public Mastodon_Status unfavouriteStatus(Integer id) {
        String body = this.call('POST', BASE_PATH + '/statuses/' + id + '/unreblog', null);
        return (Mastodon_Status)JSON.deserialize(body, Mastodon_Status.class);
    }

    public List<Mastodon_Status> retrieveTimeline(String type, Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/timelines/' + type, range.toQueryString());
    	return (List<Mastodon_Status>) JSON.deserialize(body, List<Mastodon_Status>.class);
    }
    
    public List<Mastodon_Status> retrieveTimelineByTag(String hashtag, Mastodon_Range range) {
    	String body = this.call('GET', BASE_PATH + '/timelines/tag' + hashtag, range.toQueryString());
    	return (List<Mastodon_Status>) JSON.deserialize(body, List<Mastodon_Status>.class);
    }

    private String call(String method, String path, String body) {
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