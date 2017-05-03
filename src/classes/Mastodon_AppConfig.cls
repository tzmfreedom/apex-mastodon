public class Mastodon_AppConfig extends Mastodon_QueryableParameter {
	public String clientName;
	public String redirectUris;
	public String scopes;
	public String website;
	
	protected override Map<String, Object> getParams() {
		return new Map<String, Object> {
			'client_name' => this.clientName,
			'redirect_uris' => this.redirectUris,
			'scopes' => this.scopes,
			'website' => this.website
		};
	}	
}