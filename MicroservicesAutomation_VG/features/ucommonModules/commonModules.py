def readJson():
    d = dirname(dirname(abspath(__file__)))
    with open(d + "\ExpectedJsonValues_FlexibleSchedule\AuthenticationExpectedJson.json") as f:
        return json.load(f)


def custom_httpMethods(httpMethod, url_temp, http_request_header, http_request_url_query_param, http_request_body):
    print('httpMethod' + httpMethod)
    print('Endpoint' + url_temp)
    print('headers' + http_request_header)
    print('params' + http_request_header)


if 'GET' == http_request_type:
    url_temp += global_general_variables['GET_api_endpoint']
    http_request_body.clear()
    global_general_variables['response_full'] = requests.get(url_temp,
                                                             headers=http_request_header,
                                                             params=http_request_url_query_param,
                                                             json=http_request_body)
# global_general_variables['response_full'] = requests.get(url_temp,headers=http_request_header,params=http_request_url_query_param,data=http_request_body)
#      global_general_variables['response_full'] =requeste.get(url_temp)
elif 'POST' == http_request_type:
    url_temp += global_general_variables['POST_api_endpoint']
    # http_request_url_query_param.clear()
    global_general_variables['response_full'] = requests.post(url_temp,
                                                              headers=http_request_header,
                                                              params=http_request_url_query_param,
                                                              json=http_request_body)
elif 'PUT' == http_request_type:
    url_temp += global_general_variables['PUT_api_endpoint']
    # http_request_url_query_param.clear()
    global_general_variables['response_full'] = requests.put(url_temp,
                                                             headers=http_request_header,
                                                             params=http_request_url_query_param,
                                                             json=http_request_body)
elif 'DELETE' == http_request_type:
    url_temp += global_general_variables['DELETE_api_endpoint']
    # http_request_body.clear()
    global_general_variables['response_full'] = requests.delete(url_temp,
                                                                headers=http_request_header,
                                                                params=http_request_url_query_param,
                                                                json=http_request_body)

print(global_general_variables['response_full'])
return global_general_variables['response_full']
