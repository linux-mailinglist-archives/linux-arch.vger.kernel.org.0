Return-Path: <linux-arch+bounces-7821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA29943D1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376EFB27E77
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1218FDC9;
	Tue,  8 Oct 2024 09:04:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AB17E004
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378266; cv=none; b=UfupYY1UMvC1OTs4+XbU93dpstB8V1oVI1LX4gwqpKSvMGdHQmUG+Ga+jT/v28bptuGT95yzZGN176R6MOYbECMiyd0yL6VL0cR7wkr3h8CCD6NWO2TIPoCYOfd/1d1zrHAcjnr59dO395yK9vIiNsTivwBuQzcKqYcczTUFWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378266; c=relaxed/simple;
	bh=0nob4TrGi5+r5B19NJ2r4kikq0G9rK+r24VO4RExxo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EkTP29EaEEBc7jXnl+vt9DOlUkXkMRWQb0u9+sZtgVJu2D6yq/Jfcq/yhZFdmFv4QbGW0u7HGSILyd5hCtMWRtqHTvdWjJsAdyIobFfmCjojiMUHjaG2XEU3zPxZgv4uQZNUuVEhvdCaBmjigZ8Mih417Nm61ZZgeWiqwIkLKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-283-WcSs95YvN3S1XP-Zh8cxpQ-1; Tue, 08 Oct 2024 10:04:15 +0100
X-MC-Unique: WcSs95YvN3S1XP-Zh8cxpQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Oct
 2024 10:03:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 8 Oct 2024 10:03:27 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Marius.Cristea@microchip.com'" <Marius.Cristea@microchip.com>,
	"arnd@arndb.de" <arnd@arndb.de>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Topic: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Index: AQHbELhIoRgtG0Q7D0uFOhXRGdeyrrJvSFqAgAwkAQCAAAERgIAAA5AAgAEtuwA=
Date: Tue, 8 Oct 2024 09:03:27 +0000
Message-ID: <8280ddecc4e14643b446c018d89fab28@AcuMS.aculab.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
	 <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
	 <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
	 <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
 <2f53046dd5b791845c2ffa783d7637ca94ca330c.camel@microchip.com>
In-Reply-To: <2f53046dd5b791845c2ffa783d7637ca94ca330c.camel@microchip.com>
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

Li4uDQo+IEknbSB1c2luZyBibG9jayByZWFkIGluIG9yZGVyIHRvIGdldCBtdWx0aXBsZSByZWdp
c3RlcnMgYXQgYSB0aW1lDQo+IChhcm91bmQgNzYgYnl0ZXMpIGFuZCB0byBpbmNyZWFzZSB0aGUg
ZWZmaWNpZW5jeSBvZiB0aGUgdHJhbnNmZXIgb3Zlcg0KPiBJMkMuIEJlaW5nIGEgYmxvY2sgcmVh
ZCB0aGVyZSBhcmUgZGlmZmVyZW50IHJlZ2lzdGVycyBsZW5ndGggaW52b2x2ZWQNCj4gZnJvbSAx
NiB1cCB0byA1NiBiaXRzIGxvbmcgYW5kIEkgbmVlZCB0byB1bnBhY2suDQoNCllvdSBjb3VsZCBk
byBhbiB1bmFsaWduZWQgNjRiaXQgQkUgcmVhZCBhbmQgdGhlbiBzaGlmdCB0aGUgdmFsdWUgcmln
aHQgOCBiaXRzDQooYW5kIG9ubHkgYWR2YW5jZSB0aGUgcG9pbnRlciA3IGJ5dGVzKS4NClNhZmUg
YmVjYXVzZSB5b3UgY2FuIGd1YXJhbnRlZSBhIHNwYXJlIGJ5dGUgYXQgdGhlIGVuZCBvZiB0aGUg
ZGF0YS4NCg0KT24geDg2LTY0IHlvdSBjb3VsZCBkbyB0aGF0IGZvciBhbGwgc2l6ZXMhDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=


