def test_service(host):
    assert host.service("password-service").is_running
    assert host.service("password-service").is_enabled
    ip_port = host.ansible("debug", "var=service_port")['service_port']
    assert host.socket("tcp://127.0.0.1:" + ip_port).is_listening


def test_nginx(host):
    assert host.service("nginx").is_running
    assert host.service("nginx").is_enabled
    assert host.socket("tcp://0.0.0.0:443").is_listening
    domain =  host.ansible("debug", "var=external_domain")['external_domain']
    response = requests.get("https://" + domain )
    assert response.status_code == 200
    assert response.headers['Server'] != "nginx"
    check_syntax = host.run("nginx -t")
    assert check_syntax.rc == 0

def test_function(host):
    domain =  host.ansible("debug", "var=external_domain")['external_domain']
    response = requests.post("https://" + domain )
    assert response.status_code == 200
    assert response.body == 200
