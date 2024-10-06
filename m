Return-Path: <linux-arch+bounces-7728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73944992079
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC10C1F21674
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127218A6B8;
	Sun,  6 Oct 2024 18:51:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC617DFE4
	for <linux-arch@vger.kernel.org>; Sun,  6 Oct 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728240707; cv=none; b=ZcqOL+4Gh7r8irZo84Znqtg5IFHscJRTNMocwNavVHqEHTipb52uhTWyXKzlTzv7BcOUKN9rpdXNtX1Wp6tSSqKU3RKkpRWxo+vUz6iXqk3KMkzujpvNpo1LKsrdclkL7uMMZqp1YCcgtFvybV5qjARkh/zNUURJMVr9P73vqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728240707; c=relaxed/simple;
	bh=aZwIzvlOJcv/ji8nAJdTx51gC2Ws1xeuOlP3sOSFvS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=l99pVtihWMp6DAxF30mQFwAHYsQ+oqmVPl59EkcvY2dPxCni9A4YGgW/Q+GOyAOwJyaw9qf0UFa7ojlYkZqUU5cbqV24KTgD2S7EjsFgKZZl1/cKQZKEopq+KvVahFrdTJgrplgXSMWPjt1wb59+5Iqa5whmWF04Ri8agccfFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-9bgpC3x0OgWrMeD0Qb2vqQ-1; Sun, 06 Oct 2024 19:51:42 +0100
X-MC-Unique: 9bgpC3x0OgWrMeD0Qb2vqQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Oct
 2024 19:50:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 6 Oct 2024 19:50:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Richard Henderson' <richard.henderson@linaro.org>, Julian Vetter
	<jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>, Russell King
	<linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Guo Ren <guoren@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Andrew Morton
	<akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Ivan
 Kokshaysky" <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Helge
 Deller" <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, "Anton
 Ivanov" <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org"
	<linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Yann Sionneau <ysionneau@kalrayinc.com>
Subject: RE: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
Thread-Topic: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
Thread-Index: AQHbFbPJWS6K2t1cH0OJGabOTiBjIbJ6FaUQ
Date: Sun, 6 Oct 2024 18:50:48 +0000
Message-ID: <5bbdbf01d4584a14ae1e16281eb95837@AcuMS.aculab.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
 <20240930132321.2785718-2-jvetter@kalrayinc.com>
 <a4f85184-73d4-44e4-bddd-0c1775ed9f50@linaro.org>
In-Reply-To: <a4f85184-73d4-44e4-bddd-0c1775ed9f50@linaro.org>
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

RnJvbTogUmljaGFyZCBIZW5kZXJzb24NCj4gU2VudDogMDMgT2N0b2JlciAyMDI0IDE3OjQ3DQo+
IA0KPiBPbiA5LzMwLzI0IDA2OjIzLCBKdWxpYW4gVmV0dGVyIHdyb3RlOg0KPiA+ICt2b2lkIG1l
bXNldF9pbyh2b2xhdGlsZSB2b2lkIF9faW9tZW0gKmRzdCwgaW50IGMsIHNpemVfdCBjb3VudCkN
Cj4gPiArew0KPiA+ICsJdWludHB0cl90IHFjID0gKHU4KWM7DQo+IA0KPiBNaXNzZWQgb25lIGNo
YW5nZSB0byAnbG9uZycNCj4gDQo+ID4gKw0KPiA+ICsJcWMgfD0gcWMgPDwgODsNCj4gPiArCXFj
IHw9IHFjIDw8IDE2Ow0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR182NEJJVA0KPiA+ICsJcWMg
fD0gcWMgPDwgMzI7DQo+ID4gKyNlbmRpZg0KPiANCj4gQ291bGQgYmUgJ3FjICo9IC0xdWwgLyAw
eGZmOycNCg0KCXFjICo9IH4wdWwgLyAweGZmOw0KDQp3b3VsZCBiZSBzbGlnaHRseSBiZXR0ZXIu
DQoNCglEYXZpZA0KDQo+IA0KPiANCj4gcn4NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


