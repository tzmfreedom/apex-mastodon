public abstract class Mastodon_QueryableParameter {
    public String toQueryString() {
    	String queryString = '';
    	Map<String, Object> params = this.getParams();
    	List<String> param_strings = new List<String>();
    	for (String key : params.keySet()) {
    		if (params.get(key) != null) {
    			param_strings.add(key + '=' + EncodingUtil.urlEncode(String.valueOf(params.get(key)), 'utf-8'));
    		}
    	}
    	Map<String, List<Object>> listParams = this.getListParams();
    	if (listParams != null) {
    		for (String key : listParams.keySet()) {
    			if (listParams.get(key) != null) {
    			    for (Object param: listParams.get(key)) {
    			    	param_strings.add(key + '[]=' + EncodingUtil.urlEncode(String.valueOf(param), 'utf-8'));
    			    }
    			}
    		}
    	}
    	return String.join(param_strings, '&');
    }
    
    protected abstract Map<String, Object> getParams();
    
    protected virtual Map<String, List<Object>> getListParams() {
    	return null;
    }
}