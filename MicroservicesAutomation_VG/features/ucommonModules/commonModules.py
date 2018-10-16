import re

import requests

http_request_header = {}
http_request_body = {}
http_request_url_query_param = {}
global_general_variables = {}
expectedJsonResponse = {}
from hamcrest import assert_that, equal_to, is_, empty, not_


def readJson(filename):
    d = dirname(dirname(abspath(__file__)))
    with open(d + "\ExpectedJsonValues_FlexibleSchedule\\" + filename + ".json") as f:
        return json.load(f)


def http_request_header_fn(context, key, value):
    for row in context.table:
        temp_value = row[value]
        http_request_header[row[key]] = temp_value
        if 'empty' in temp_value:
            http_request_header[row[key]] = ''
        elif 'null' in temp_value:
            http_request_header[row[key]] = None
    return http_request_header


def expectedJsonResponse_fn(context, key, value):
    for row in context.table:
        temp_value = row[value]
        expectedJsonResponse[row[key]] = temp_value
        if 'empty' in temp_value:
            expectedJsonResponse[row[key]] = ''
        elif 'null' in temp_value:
            expectedJsonResponse[row[key]] = None
        elif 'customcheck' in temp_value:
            expectedJsonResponse[row[key]] = 'customcheck'
    return expectedJsonResponse


def custom_http_Methods(http_request_type, url_temp, http_request_header, http_request_url_query_param,
                        http_request_body):
    print('httpMethod' + http_request_type)
    print('Endpoint' + url_temp)
    if 'GET' == http_request_type:
        url_temp += global_general_variables['GET_api_endpoint']
        http_request_body.clear()
        global_general_variables['response_full'] = requests.get(url_temp, headers=http_request_header,
                                                                 params=http_request_url_query_param,
                                                                 json=http_request_body)
    elif 'POST' == http_request_type:
        url_temp += global_general_variables['POST_api_endpoint']
        # http_request_url_query_param.clear()
        global_general_variables['response_full'] = requests.post(url_temp, headers=http_request_header,
                                                                  params=http_request_url_query_param,
                                                                  json=http_request_body)
    elif 'PUT' == http_request_type:
        url_temp += global_general_variables['PUT_api_endpoint']
        # http_request_url_query_param.clear()
        global_general_variables['response_full'] = requests.put(url_temp, headers=http_request_header,
                                                                 params=http_request_url_query_param,
                                                                 json=http_request_body)
    elif 'DELETE' == http_request_type:
        url_temp += global_general_variables['DELETE_api_endpoint']
        # http_request_body.clear()
        global_general_variables['response_full'] = requests.delete(url_temp, headers=http_request_header,
                                                                    params=http_request_url_query_param,
                                                                    json=http_request_body)
    return global_general_variables['response_full']


def switcher_args(context, type, key, value):
    if type == 'http_request_body':
        http_request_body_fn(context, key, value)
    elif type == 'http_request_Header':
        http_request_header_fn(context, key, value)
    elif type == 'expectedJsonResponse':
        expectedJsonResponse_fn(context, key, value)
    else:
        assert False, "Not an expected Attr"


def readValuesFromFeatures(context, key, value, params):
    value = re.sub("<|>", "", value)
    key = re.sub("<|>", "", key)
    switcher_args(context, params, key, value)


def http_request_body_fn(context, key, value):
    for row in context.table:
        temp_value = row[value]
        http_request_body[row[key]] = temp_value
        if 'empty' in temp_value:
            http_request_body[row[key]] = ''
        elif 'null' in temp_value:
            http_request_body[row[key]] = None
    return http_request_body


def validateExpectedJson(expected, actual, jsonCompare):
    if (jsonCompare.lower == 'yes'):
        assert_that(readJson(expected), equal_to(actual))
    else:
        for k, v in actual.items():
            if (expected[k] == 'customcheck'):
                assert_that(actual[k], is_(not_(empty())))
            else:
                assert_that(expected[k], equal_to(actual[k]))
