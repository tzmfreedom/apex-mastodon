# apex-mastodon

Apex Library for mastodon

## Install

<a href="https://githubsfdeploy.herokuapp.com?owner=tzmfreedom&repo=apex-mastodon">
  <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

or use spm command
```
$ spm install https://github.com/tzmfreedom/apex-mastodon/src -u {USERNAME} -p {PASSWORD}
```

## Usage

### Use Named Credentials

```apex
Mastodon_Client client = new Mastodon_Client('callout:{named_credential_name}');
Mastodon_Status result = client.postStatus(new Mastodon_Toot('hello mastodon'));
```
### Use ClientID/ClientSecret/RedirectUri

WIP

## LICENSE

MIT
