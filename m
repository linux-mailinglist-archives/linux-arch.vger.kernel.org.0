Return-Path: <linux-arch+bounces-8350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEB9A6BED
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906FCB21616
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2D1F80AE;
	Mon, 21 Oct 2024 14:17:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA517BA5
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520222; cv=none; b=vEcMuV/hd9EkLPshbjh5BaT9iB04omTdwKd5TCQsISsOE818rbxbPZRH8E2UgtwrCV89Okg+KuLvnSiVkelYVOTsshszwFP6mK5f8okMJbgDKPBOHbKSxMalr6ueP2GA6x3UXhMfp2sY4zfPEa7yNWPVWsk8udmK9AM/njOA30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520222; c=relaxed/simple;
	bh=PLWv4lFaQV8sjHDvNQjGIRT6NksTFV03TnQPGI0/WJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DWXtFaU4oZZAqGwwLets6k1DAodA0dMQ7cxgf31otna1KI9Jt4AeOgBF+4yLjN3R6kMKaTooHHJoX/U1lfwLNPVExgWNfVlWsG+zZdl12XMBKcsIUVkNRjtMtyUUkvJzsC6Op/pmArOPHntAzkTkPZnovjoikj+jm8XBNtQ3RXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-62-ca9pfulLNsiTNYZ1CcklcQ-1; Mon, 21 Oct 2024 15:16:52 +0100
X-MC-Unique: ca9pfulLNsiTNYZ1CcklcQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Oct
 2024 15:16:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 21 Oct 2024 15:16:51 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Julian Vetter' <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Guo Ren" <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Richard Henderson
	<richard.henderson@linaro.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig
	<hch@infradead.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Yann Sionneau <ysionneau@kalrayinc.com>
Subject: RE: [PATCH v10 0/4] Replace fallback for IO memcpy and IO memset
Thread-Topic: [PATCH v10 0/4] Replace fallback for IO memcpy and IO memset
Thread-Index: AQHbI73OwWqJmOV6ikC/4nDHNEDFmbKRPskA
Date: Mon, 21 Oct 2024 14:16:51 +0000
Message-ID: <0577266edb9440acb082c9e02c0a73b9@AcuMS.aculab.com>
References: <20241021133154.516847-1-jvetter@kalrayinc.com>
In-Reply-To: <20241021133154.516847-1-jvetter@kalrayinc.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSnVsaWFuIFZldHRlcg0KPiBTZW50OiAyMSBPY3RvYmVyIDIwMjQgMTQ6MzINCj4gDQo+
IFRoYW5rIHlvdSBhZ2FpbiBmb3IgeW91ciByZW1hcmtzIEFybmQgYW5kIENocmlzdG9waCEgSSBo
YXZlIHVwZGF0ZWQgdGhlDQo+IHBhdGNoc2V0LCBhbmQgcGxhY2VkIHRoZSBmdW5jdGlvbnMgZGly
ZWN0bHkgaW4gYXNtLWdlbmVyaWMvaW8uaC4gSSBoYXZlDQo+IGRyb3BwZWQgdGhlIGxpYnMvaW9t
ZW1fY29weS5jIGFuZCBoYXZlIHVwZGF0ZWQvY2xhcmlmaWVkIHRoZSBjb21taXQNCj4gbWVzc2Fn
ZSBpbiB0aGUgZmlyc3QgcGF0Y2guDQoNCkFwYXJ0IGZyb20gYnVpbGQgJ2lzc3Vlcycgd2hhdCBp
cyB0aGUganVzdGlmaWNhdGlvbiBmb3IgaW5saW5pbmcNCnRoZXNlIGZ1bmN0aW9ucz8NCg0KVGhl
eSBhcmUgcXVpdGUgbGFyZ2UgZm9yIGlubGluaW5nIGFuZCBzb21lIGRyaXZlcnMgY291bGQgZWFz
aWx5DQpjYWxsIHRoZW0gbWFueSB0aW1lcy4NCg0KVGhlIEkvTyBjeWNsZXMgdGhlbXNlbHZlcyBh
cmUgbGlrZWx5IHRvIGJlIHNsb3cgZW5vdWdoIHRoYXQNCnRoZSBjb3N0IG9mIGEgZnVuY3Rpb24g
Y2FsbCBpcyBwcmV0dHkgbXVjaCBsaWtlbHkgdG8gYmUgbm9pc2UuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=


