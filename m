Return-Path: <linux-arch+bounces-13366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F3BB42605
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051CE1886238
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E6292B54;
	Wed,  3 Sep 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ecURXDdC"
X-Original-To: linux-arch@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4B291C07;
	Wed,  3 Sep 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915001; cv=none; b=nd6SvQko3m6ivQUKxIA1L/Kse74b+wxQZ8oJkwIe+N+xULKyud0GDJnQY9NhZstnhIhyu4tqWIJrV8pzBeP/BJ9btowTi8tzvqdoM4rONZMSO6MdjDT/XL3vSDrf7fT7eOBePyUci+rDBly1/PF2qgvJ3+VsSuWNoSc3hUbHiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915001; c=relaxed/simple;
	bh=Shk7aP7NdVdTxePF1n5l+uKN9YxwBMJp3bE/HqRzo1U=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K2BTeGlja97kInLygF7aRCjEBOEC2B+3Z6KSTtffjG3pmnU+SMoo52y3Qzs85jVtHCqkK+ZQlTcIsfLVuJOh4OIa1d5SGzLa2OxKTjld09wqoIbsmVzYU95GD86cfsk8cgu1+tN2wNtbt1Zz3AWfy8X00AZBWkZMlVpr9pufR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ecURXDdC; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756915000; x=1788451000;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Shk7aP7NdVdTxePF1n5l+uKN9YxwBMJp3bE/HqRzo1U=;
  b=ecURXDdCrpQMlKeVpnhv5FGi1R9+yeDRNqDv4no3bmbFbNfjsgVzjPJT
   1db4Fetgcbt6A43z7ChQBJoycabO4WowqDTiWlE/NhuHzsp3VmhD0BCrC
   vNqkSfnbRkK2aYeFwMYpDvqaMFrfm6fwswVGB7tu6/0uS4SfwZLUyHvDC
   dg6k6jYZSpHpOgiRV6kjEqQBrBzY8mKcvolW1oFFAimXoNDNvNbCD7uwt
   rJ4qc3MEaFmAYr7Z3e3TElFPPFS/FVV7ScT/rmC/Pi+wVijhT/siLo9xQ
   mEwYB1CSzqNtoGLp/p0Newo1WVqyce0L5kINVpB2Nks2e5Ui+hJ40gOyi
   g==;
X-CSE-ConnectionGUID: QiOcNpiNSHuG08I7kgtVrw==
X-CSE-MsgGUID: efa5nN+GQgSifqLXSQNwvw==
X-IronPort-AV: E=Sophos;i="6.18,236,1751241600"; 
   d="scan'208";a="2318615"
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Thread-Topic: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:56:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:35374]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.19:2525] with esmtp (Farcaster)
 id 3521494c-cd0c-4c7e-a87c-f69a666db393; Wed, 3 Sep 2025 15:56:39 +0000 (UTC)
X-Farcaster-Flow-ID: 3521494c-cd0c-4c7e-a87c-f69a666db393
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 15:56:39 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 15:56:38 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.020; Wed, 3 Sep 2025 15:56:38 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>
CC: "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "memxor@gmail.com"
	<memxor@gmail.com>, "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "cl@gentwo.org"
	<cl@gentwo.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"will@kernel.org" <will@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Okanovic, Haris"
	<harisokn@amazon.com>
Thread-Index: AQHcGLwkeAOmnfRWAUuaDQGZvBHLrrR+O4GAgANprQA=
Date: Wed, 3 Sep 2025 15:56:38 +0000
Message-ID: <23aca480075a8efc307c9aa07ff62f0f39bbee4e.camel@amazon.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
	 <aLWITwwDg06F1eXu@arm.com>
In-Reply-To: <aLWITwwDg06F1eXu@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E18BDB4F8F2474DAC3E5EE6935FEE88@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTA5LTAxIGF0IDEyOjQ5ICswMTAwLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gDQo+IE9uIEZyaSwgQXVnIDI5LCAyMDI1IGF0IDAxOjA3OjMwQU0gLTA3MDAs
IEFua3VyIEFyb3JhIHdyb3RlOg0KPiA+IEFua3VyIEFyb3JhICg1KToNCj4gPiAgIGFzbS1nZW5l
cmljOiBiYXJyaWVyOiBBZGQgc21wX2NvbmRfbG9hZF9yZWxheGVkX3RpbWV3YWl0KCkNCj4gPiAg
IGFybTY0OiBiYXJyaWVyOiBBZGQgc21wX2NvbmRfbG9hZF9yZWxheGVkX3RpbWV3YWl0KCkNCj4g
PiAgIGFybTY0OiBycXNwaW5sb2NrOiBSZW1vdmUgcHJpdmF0ZSBjb3B5IG9mDQo+ID4gICAgIHNt
cF9jb25kX2xvYWRfYWNxdWlyZV90aW1ld2FpdA0KPiA+ICAgYXNtLWdlbmVyaWM6IGJhcnJpZXI6
IEFkZCBzbXBfY29uZF9sb2FkX2FjcXVpcmVfdGltZXdhaXQoKQ0KPiA+ICAgcnFzcGlubG9jazog
dXNlIHNtcF9jb25kX2xvYWRfYWNxdWlyZV90aW1ld2FpdCgpDQo+IA0KPiBDYW4geW91IGhhdmUg
YSBnbyBhdCBwb2xsX2lkbGUoKSB0byBzZWUgaG93IGl0IHdvdWxkIGxvb2sgbGlrZSB1c2luZw0K
PiB0aGlzIEFQST8gSXQgZG9lc24ndCBuZWNlc3NhcmlseSBtZWFuIHdlIGhhdmUgdG8gbWVyZ2Ug
dGhlbSBhbGwgYXQgb25jZQ0KPiBidXQgaXQgZ2l2ZXMgdXMgYSBiZXR0ZXIgaWRlYSBvZiB0aGUg
c3VpdGFiaWxpdHkgb2YgdGhlIGludGVyZmFjZS4NCg0KVGhpcyBpcyB3aGF0IEkgdGVzdGVkIG9u
IEFSTSBvbiBGcmk6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9oYXJpc29rYW5vdmljL2xpbnV4L2Js
b2IvMzdlMDJiOTUwYzk5MzcwNDY2ZTczODVlNWU3NTRiYmQ2MjMyZWY5NS9kcml2ZXJzL2NwdWlk
bGUvcG9sbF9zdGF0ZS5jI0wyNA0KDQpSZWdhcmRzLA0KSGFyaXMgT2thbm92aWMNCkFXUyBHcmF2
aXRvbiBTb2Z0d2FyZQ0KDQo+IA0KPiAtLQ0KPiBDYXRhbGluDQoNCg==

