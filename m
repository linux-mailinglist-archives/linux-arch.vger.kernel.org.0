Return-Path: <linux-arch+bounces-13339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882FB3C2BB
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 20:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E226EA00470
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA121D3E8;
	Fri, 29 Aug 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="p450uBrC"
X-Original-To: linux-arch@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852C9443;
	Fri, 29 Aug 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493664; cv=none; b=a1vJGFl+Wh+gG02vzUDWHnWmfDSa8K2F+5RRe5qslp0650qhFb/9HaY8U/6OQRV7zEFz6OEEk67ELuy4b7xuvbzK81jSOH8T2oM1EOojQ9SEoO9xYgZZrByhuvehJGA6UG6VwsnuhgKmb73WkvsBLfA4XK6GWGX7BESr1aqsUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493664; c=relaxed/simple;
	bh=onDw0zBJvA2aM4dl11X2cmXP4ov854rmqxhd1ow39+0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzEZqoTInsCD6FQBEifAZgozZMRC7r4IKP2gdZPKpbznLsv4dgruBjyrxINYREJe5HF+KByuUClXu9Go5Pby9Bdp/xhgrX5lfoSJK7puPbRxfa5NWE7UwWtDt5hpEvDlm+a/SsycShHc4+vhlOsSkFGgl3Gyr/sEjZGgHbYpHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=p450uBrC; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756493662; x=1788029662;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=onDw0zBJvA2aM4dl11X2cmXP4ov854rmqxhd1ow39+0=;
  b=p450uBrCbaz3gl6+dTSMv9C5/tqFffJqv4aPCXT26TEX0nxhgPbOoiqb
   7ZMyI/hwk7IJAceZO0AcPjcVDsFmbRXVPLNgvW/Bn/e2ysxPNlYsUAx1u
   qLxQ97jtlonmnndQ5xBvxgPk92vXyPIMRNzmA2mUjgDtHOb7nkWyxMH04
   09TxYPxrshzpap/BaZ0BHs038ErSogehzG8nqD+A969uDRCRZpR3htN98
   sAJAFx1aCtgYdLSFfhfBSax2hGYE1jhcd+s/9rfonJU9FVdohtF/4w5yK
   g0CO1yaopBZ+KN26Ne7Ulg6EWHdabw9FM8tXtnmmDkX1NhHf/7FNE0v/H
   g==;
X-CSE-ConnectionGUID: vUS98EYqRNm3RBnTuS4Z6g==
X-CSE-MsgGUID: 388zlf7oQNqGJeTjOXQpqQ==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1944126"
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Thread-Topic: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 18:54:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:54966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.144:2525] with esmtp (Farcaster)
 id d09b57f8-b9c6-4bca-870a-9e36f79c3866; Fri, 29 Aug 2025 18:54:20 +0000 (UTC)
X-Farcaster-Flow-ID: d09b57f8-b9c6-4bca-870a-9e36f79c3866
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 18:54:20 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA003.ant.amazon.com (10.13.139.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 18:54:20 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.017; Fri, 29 Aug 2025 18:54:20 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "ankur.a.arora@oracle.com"
	<ankur.a.arora@oracle.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "Okanovic, Haris" <harisokn@amazon.com>, "cl@gentwo.org" <cl@gentwo.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "memxor@gmail.com" <memxor@gmail.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "will@kernel.org" <will@kernel.org>,
	"zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>, "ast@kernel.org"
	<ast@kernel.org>, "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Thread-Index: AQHcGLwkeAOmnfRWAUuaDQGZvBHLrrR5+yuA
Date: Fri, 29 Aug 2025 18:54:20 +0000
Message-ID: <2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
In-Reply-To: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B00C4BB2ABE1CC418E9442EB1C4C3F26@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDAxOjA3IC0wNzAwLCBBbmt1ciBBcm9yYSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiANCj4gSGksDQo+IA0KPiBUaGlzIHNlcmllcyBhZGRzIHdhaXRlZCB2YXJpYW50cyBv
ZiB0aGUgc21wX2NvbmRfbG9hZCgpIHByaW1pdGl2ZXM6DQo+IHNtcF9jb25kX2xvYWRfcmVsYXhl
ZF90aW1ld2FpdCgpLCBhbmQgc21wX2NvbmRfbG9hZF9hY3F1aXJlX3RpbWV3YWl0KCkuDQo+IA0K
PiBXaHk/OiBhcyB0aGUgbmFtZSBzdWdnZXN0cywgdGhlIG5ldyBpbnRlcmZhY2VzIGFyZSBtZWFu
dCBmb3IgY29udGV4dHMNCj4gd2hlcmUgeW91IHdhbnQgdG8gd2FpdCBvbiBhIGNvbmRpdGlvbiB2
YXJpYWJsZSBmb3IgYSBmaW5pdGUgZHVyYXRpb24uDQo+IFRoaXMgaXMgZWFzeSBlbm91Z2ggdG8g
ZG8gd2l0aCBhIGxvb3AgYXJvdW5kIGNwdV9yZWxheCgpLiBIb3dldmVyLA0KPiBzb21lIGFyY2hp
dGVjdHVyZXMgKGV4LiBhcm02NCkgYWxzbyBhbGxvdyB3YWl0aW5nIG9uIGEgY2FjaGVsaW5lLiBT
bywNCj4gdGhlc2UgaW50ZXJmYWNlcyBoYW5kbGUgYSBtaXh0dXJlIG9mIHNwaW4vd2FpdCB3aXRo
IGEgc21wX2NvbmRfbG9hZCgpDQo+IHRocm93biBpbi4NCj4gDQo+IFRoZXJlIGFyZSB0d28ga25v
d24gdXNlcnMgZm9yIHRoZXNlIGludGVyZmFjZXM6DQo+IA0KPiAgLSBwb2xsX2lkbGUoKSBbMV0N
Cj4gIC0gcmVzaWxpZW50IHF1ZXVlZCBzcGlubG9ja3MgWzJdDQo+IA0KPiBUaGUgaW50ZXJmYWNl
cyBhcmU6DQo+ICAgIHNtcF9jb25kX2xvYWRfcmVsYXhlZF90aW1ld2FpdChwdHIsIGNvbmRfZXhw
ciwgdGltZV9jaGVja19leHByKQ0KPiAgICBzbXBfY29uZF9sb2FkX2FjcXVpcmVfc3BpbndhaXQo
cHRyLCBjb25kX2V4cHIsIHRpbWVfY2hlY2tfZXhwcikNCj4gDQo+IFRoZSBhZGRlZCBwYXJhbWV0
ZXIsIHRpbWVfY2hlY2tfZXhwciwgZGV0ZXJtaW5lcyB0aGUgYmFpbCBvdXQgY29uZGl0aW9uLg0K
PiANCj4gQ2hhbmdlbG9nOg0KPiAgIHYzIFszXToNCj4gICAgIC0gZnVydGhlciBpbnRlcmZhY2Ug
c2ltcGxpZmljYXRpb25zIChzdWdnZXN0ZWQgYnkgQ2F0YWxpbiBNYXJpbmFzKQ0KPiANCj4gICB2
MiBbNF06DQo+ICAgICAtIHNpbXBsaWZpZWQgdGhlIGludGVyZmFjZSAoc3VnZ2VzdGVkIGJ5IENh
dGFsaW4gTWFyaW5hcykNCj4gICAgICAgIC0gZ2V0IHJpZCBvZiB3YWl0X3BvbGljeSwgYW5kIGEg
bXVsdGl0dWRlIG9mIGNvbnN0YW50cw0KPiAgICAgICAgLSBhZGRzIGEgc2xhY2sgcGFyYW1ldGVy
DQo+ICAgICAgIFRoaXMgaGVscGVkIHJlbW92ZSBhIGZhaXIgYW1vdW50IG9mIGR1cGxpY2F0ZWQg
Y29kZSBkdXBsaWNhdGlvbiBhbmQgaW4gaGluZHNpZ2h0DQo+ICAgICAgIHVubmVjZXNzYXJ5IGNv
bnN0YW50cy4NCj4gDQo+ICAgdjEgWzVdOg0KPiAgICAgIC0gYWRkIHdhaXRfcG9saWN5IChjb2Fy
c2UgYW5kIGZpbmUpDQo+ICAgICAgLSBkZXJpdmUgc3Bpbi1jb3VudCBldGMgYXQgcnVudGltZSBp
bnN0ZWFkIG9mIHVzaW5nIGFyYml0cmFyeQ0KPiAgICAgICAgY29uc3RhbnRzLg0KPiANCj4gSGFy
aXMgT2thbm92aWMgaGFkIHRlc3RlZCBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhpcyBzZXJpZXMg
d2l0aA0KPiBwb2xsX2lkbGUoKS9oYWx0cG9sbCBwYXRjaGVzLiBbNl0NCj4gDQo+IEFueSBjb21t
ZW50cyBhcHByZWNpYXRlZCENCj4gDQo+IFRoYW5rcyENCj4gQW5rdXINCj4gDQo+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQxMTA3MTkwODE4LjUyMjYzOS0zLWFua3VyLmEu
YXJvcmFAb3JhY2xlLmNvbS8NCj4gWzJdIFVzZXMgdGhlIHNtcF9jb25kX2xvYWRfYWNxdWlyZV90
aW1ld2FpdCgpIGZyb20gdjENCj4gICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gvYXJtNjQvaW5jbHVk
ZS9hc20vcnFzcGlubG9jay5oDQo+IFszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjUwNjI3MDQ0ODA1Ljk0NTQ5MS0xLWFua3VyLmEuYXJvcmFAb3JhY2xlLmNvbS8NCj4gWzRdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA1MDIwODUyMjMuMTMxNjkyNS0xLWFua3Vy
LmEuYXJvcmFAb3JhY2xlLmNvbS8NCj4gWzVdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyNTAyMDMyMTQ5MTEuODk4Mjc2LTEtYW5rdXIuYS5hcm9yYUBvcmFjbGUuY29tLw0KPiBbNl0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9mMmY1ZDA5ZTc5NTM5NzU0Y2VkMDg1ZWQ4OTg2
NTc4N2ZhNjY4Njk1LmNhbWVsQGFtYXpvbi5jb20NCj4gDQo+IENjOiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPg0KPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gQ2M6
IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IENjOiBQZXRlciBa
aWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IENjOiBLdW1hciBLYXJ0aWtleWEgRHdp
dmVkaSA8bWVteG9yQGdtYWlsLmNvbT4NCj4gQ2M6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtl
cm5lbC5vcmc+DQo+IENjOiBsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZw0KPiANCj4gQW5rdXIg
QXJvcmEgKDUpOg0KPiAgIGFzbS1nZW5lcmljOiBiYXJyaWVyOiBBZGQgc21wX2NvbmRfbG9hZF9y
ZWxheGVkX3RpbWV3YWl0KCkNCj4gICBhcm02NDogYmFycmllcjogQWRkIHNtcF9jb25kX2xvYWRf
cmVsYXhlZF90aW1ld2FpdCgpDQo+ICAgYXJtNjQ6IHJxc3BpbmxvY2s6IFJlbW92ZSBwcml2YXRl
IGNvcHkgb2YNCj4gICAgIHNtcF9jb25kX2xvYWRfYWNxdWlyZV90aW1ld2FpdA0KPiAgIGFzbS1n
ZW5lcmljOiBiYXJyaWVyOiBBZGQgc21wX2NvbmRfbG9hZF9hY3F1aXJlX3RpbWV3YWl0KCkNCj4g
ICBycXNwaW5sb2NrOiB1c2Ugc21wX2NvbmRfbG9hZF9hY3F1aXJlX3RpbWV3YWl0KCkNCj4gDQo+
ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2JhcnJpZXIuaCAgICB8IDIyICsrKysrKysrDQo+ICBh
cmNoL2FybTY0L2luY2x1ZGUvYXNtL3Jxc3BpbmxvY2suaCB8IDg0ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICBpbmNsdWRlL2FzbS1nZW5lcmljL2JhcnJpZXIuaCAgICAgICB8IDU3
ICsrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2FzbS1nZW5lcmljL3Jxc3BpbmxvY2su
aCAgICB8ICA0ICsrDQo+ICBrZXJuZWwvYnBmL3Jxc3BpbmxvY2suYyAgICAgICAgICAgICB8IDI1
ICsrKystLS0tLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCA5OSBkZWxl
dGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMzEuMQ0KPiANCg0KVGVzdGVkIG9uIEFXUyBHcmF2aXRv
biAyLCAzLCBhbmQgNCAoQVJNNjQgTmVvdmVyc2UgTjEsIFYxLCBhbmQgVjIpIHdpdGgNCnlvdXIg
VjEwIGhhbHRwb2xsIGNoYW5nZXMsIGF0b3AgNi4xNy4wLXJjMyAoY29tbWl0IDA3ZDlkZjgwMDgp
Lg0KU3RpbGwgc2VlaW5nIGJldHdlZW4gMS4zeCBhbmQgMi41eCBzcGVlZHVwcyBpbiBgcGVyZiBi
ZW5jaCBzY2hlZCBwaXBlYA0KYW5kIGBzZWNjb21wLW5vdGlmeWA7IG5vIGNoYW5nZSBpbiBgbWVz
c2FnaW5nYC4NCg0KUmV2aWV3ZWQtYnk6IEhhcmlzIE9rYW5vdmljIDxoYXJpc29rbkBhbWF6b24u
Y29tPg0KVGVzdGVkLWJ5OiBIYXJpcyBPa2Fub3ZpYyA8aGFyaXNva25AYW1hem9uLmNvbT4NCg0K
UmVnYXJkcywNCkhhcmlzIE9rYW5vdmljDQpBV1MgR3Jhdml0b24gU29mdHdhcmUNCg0K

