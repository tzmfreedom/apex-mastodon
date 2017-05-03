public class Mastodon_Profile extends Mastodon_QueryableParameter{
   	public String displayName;
   	public String note;
   	public String avatar;
   	public String header;
   	
   	protected override Map<String, Object> getParams() {
   		return new Map<String, Object> {
   			'display_name' => this.displayName,
   			'note' => this.note,
   			'avatar' => this.avatar,
   			'header' => this.header
   		};
   	}
}