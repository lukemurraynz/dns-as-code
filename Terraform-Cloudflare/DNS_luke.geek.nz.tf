# luke.geek.nz DNS
# Luke Murray 
# Version 1.0

# Configure the Cloudflare provider

variable "CloudflareApiEmail" {}
variable "CloudflareApiKey" {}

provider "cloudflare" {
   email = "${var.CloudflareApiEmail}"
   token = "${var.CloudflareApiKey}"
}
 
variable "domain" {
  default = "luke.geek.nz"
}

terraform {
  backend "azurerm" {}
}
resource "cloudflare_zone_settings_override" "settings" {
  name = "${var.domain}"

settings {
		always_online = "on"
		always_use_https = "on"
		automatic_https_rewrites = "on"
		brotli = "on"
		browser_cache_ttl = 691200
		browser_check = "on"
		cache_level = "aggressive"
		challenge_ttl = 1800
		cname_flattening = "flatten_at_root"
		development_mode = "off"
		edge_cache_ttl = 7200
		email_obfuscation = "on"
		hotlink_protection = "on"
		http2 = "on"
		ip_geolocation = "on"
		ipv6 = "on"
		max_upload = 100
			minify {
			css = "on"
			html = "on"
			js = "on"
		}
		
			mobile_redirect {
			mobile_subdomain = ""
			status = "off"
			strip_uri = false
		}
		
		opportunistic_encryption = "on"
		opportunistic_onion = "on"
		origin_error_page_pass_thru = "off"
		prefetch_preload = "off"
		privacy_pass = "on"
		pseudo_ipv4 = "off"
		response_buffering = "off"
		rocket_loader = "on"
		security_header {
			
			enabled = false
			include_subdomains = false
			max_age = 0
			nosniff = false
			preload = false
				
		}
		
		security_level = "medium"
		server_side_exclude = "on"
		sort_query_string_for_cache = "off"
		ssl = "full"
		tls_1_3 = "on"
		tls_client_auth = "off"
		true_client_ip_header = "off"
		waf = "off"
		websockets = "on"
	}

}

#DNS Records - for Main Site
resource "cloudflare_record" "root" {
domain  = "${var.domain}"
name    = "${var.domain}"
value   = "lukemurraynz.github.io"
type    = "CNAME"
ttl     = 1
proxied = true
}

resource "cloudflare_record" "www" {
  domain  = "${var.domain}"
  name    = "www"
  value   = "lukemurraynz.github.io"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "status" {
  domain  = "${var.domain}"
  name    = "status"
  value   = "stats.uptimerobot.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "testdns" {
  domain  = "${var.domain}"
  name    = "testdns"
  value   = "appserviceiptest.azurewebsites.net"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

#Mail DNS
resource "cloudflare_record" "mx1" {
  domain   = "${var.domain}"
  name     = "${var.domain}"
  type     = "MX"
  priority = 10
  value    = "mx1.forwardemail.net"
}

resource "cloudflare_record" "mx2" {
  domain   = "${var.domain}"
  name     = "${var.domain}"
  type     = "MX"
  priority = 20
  value    = "mx2.forwardemail.net"
}
