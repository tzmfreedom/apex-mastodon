# apex-mastodon

Apex Library for mastodon

## Install

If you can use [jsforce-deploy](https://github.com/jsforce/jsforce-metadata-tools) command, execute following command.
```
$ git clone https://github.com/tzmfreedom/apex-mastodon
$ jsforce-deploy -D apex-mastodon/src -u {USERNAME} -p {PASSWORD}
```

For spm user
```
$ spm install tzmfreedom/apex-mastodon/src -u {username} -p {password}
```

## Usage

### Authorization

You can authenticate with named credentials.
```apex
Mastodon_Client client = new Mastodon_Client('callout:{named_credential_name}');
```

Resource Owner Password Credentials Grant
```apex
Mastodon_Client c = new Mastodon_Client('https://{instance_host}', '{client_id}', '{client_secret}', '{redirect_uri}');
c.authorizeByCredential('{username}', '{password}');
```

Authorization Code Grant
```apex
Mastodon_Client c = new Mastodon_Client('https://{instance_host}', '{client_id}', '{client_secret}', '{redirect_uri}');
String authorizeUrl = c.getAuthorizeUrl('{scope}', '{state}');
...
c.authorizeByCode('{code}');
```

### Call API

Post Status
```apex
Mastodon_Status result = client.postStatus(new Mastodon_Toot('hello mastodon'));
```

## Status of implementations

* [x] GET /api/v1/accounts/:id
* [x] GET /api/v1/accounts/verify_credentials
* [x] PATCH /api/v1/accounts/update_credentials
* [x] GET /api/v1/accounts/:id/followers
* [x] GET /api/v1/accounts/:id/following
* [ ] GET /api/v1/accounts/:id/statuses
* [x] POST /api/v1/accounts/:id/follow
* [x] POST /api/v1/accounts/:id/unfollow
* [ ] POST /api/v1/accounts/:id/block
* [ ] POST /api/v1/accounts/:id/unblock
* [x] POST /api/v1/accounts/:id/mute
* [x] POST /api/v1/accounts/:id/unmute
* [ ] GET /api/v1/accounts/relationships
* [ ] GET /api/v1/accounts/search
* [x] POST /api/v1/apps
* [x] GET /api/v1/blocks
* [x] GET /api/v1/favourites
* [x] GET /api/v1/follow_requests
* [ ] POST /api/v1/follow_requests/:id/authorize
* [ ] POST /api/v1/follow_requests/:id/reject
* [ ] POST /api/v1/follows
* [x] GET /api/v1/instance
* [ ] POST /api/v1/media
* [x] GET /api/v1/mutes
* [x] GET /api/v1/notifications
* [ ] GET /api/v1/notifications/:id
* [ ] POST /api/v1/notifications/clear
* [x] GET /api/v1/reports
* [x] POST /api/v1/reports
* [x] GET /api/v1/search
* [x] GET /api/v1/statuses/:id
* [x] GET /api/v1/statuses/:id/context
* [x] GET /api/v1/statuses/:id/card
* [x] GET /api/v1/statuses/:id/reblogged_by
* [x] GET /api/v1/statuses/:id/favourited_by
* [x] POST /api/v1/statuses
* [x] DELETE /api/v1/statuses/:id
* [x] POST /api/v1/statuses/:id/reblog
* [x] POST /api/v1/statuses/:id/unreblog
* [x] POST /api/v1/statuses/:id/favourite
* [x] POST /api/v1/statuses/:id/unfavourite
* [x] GET /api/v1/timelines/home
* [x] GET /api/v1/timelines/public
* [x] GET /api/v1/timelines/tag/:hashtag

## LICENSE

MIT
