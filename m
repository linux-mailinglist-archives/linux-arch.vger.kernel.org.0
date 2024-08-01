Return-Path: <linux-arch+bounces-5841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C484C9448E5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F12A1F21958
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD916F267;
	Thu,  1 Aug 2024 09:59:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568B4503A;
	Thu,  1 Aug 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506394; cv=none; b=nmZHubLERcUhAAsKJUH/l5SwNMZamQ8nl5UMmaFsuu0e3uwLTPJJ6L/DOVqg1OvyU2MXRRySQjR+yFfjQ0ZNii50IXoaXZg8KqWQvZF3UAt4HTI7L1/f1nndG6S4N4XrQpCV/uHBKcxXU7SJyw5xYty1fnY4goVtjPiUDn/xwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506394; c=relaxed/simple;
	bh=hJKBqDWK9Ax/+Bl3wOMxZMkJcY32J+0lM0f8oV09EwU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IF9sn2oWUjIOTN2xZrlZukIAsfUcXvcBelJrbL28Yi01A8cl/F1gv1Bgi+hF5/LHX5lrIcHAnjESy4lIXsdKo3NKM8HO49u0Kxysab9FJsWrZNPlY8EfI2sj+h26jZNYDj4gJbbDesAE0zV4G3AZ3QUSQ4G4KAnsuaU0XJ4TyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4719vV3J026474;
	Thu, 1 Aug 2024 17:57:31 +0800 (GMT-8)
	(envelope-from zhang.renze@h3c.com)
Received: from DAG6EX11-BJD.srv.huawei-3com.com (unknown [10.153.34.13])
	by mail.maildlp.com (Postfix) with ESMTP id A6507200472D;
	Thu,  1 Aug 2024 18:02:18 +0800 (CST)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) by
 DAG6EX11-BJD.srv.huawei-3com.com (10.153.34.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 1 Aug 2024 17:57:34 +0800
Received: from DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5])
 by DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5%4]) with mapi
 id 15.02.1258.027; Thu, 1 Aug 2024 17:57:34 +0800
From: Zhangrenze <zhang.renze@h3c.com>
To: David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>,
        "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>,
        "ink@jurassic.park.msu.ru"
	<ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        Jiaoxupo
	<jiaoxupo@h3c.com>, Zhouhaofan <zhou.haofan@h3c.com>
Subject: Re: [PATCH v2 0/1] mm: introduce MADV_DEMOTE/MADV_PROMOTE
Thread-Topic: [PATCH v2 0/1] mm: introduce MADV_DEMOTE/MADV_PROMOTE
Thread-Index: Adrj+TpMWvmFzAgQpUGNt+p1t3dI6Q==
Date: Thu, 1 Aug 2024 09:57:34 +0000
Message-ID: <3a5785661e1b4f3381046aa5e808854c@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4719vV3J026474

PiA+IFN1cmUsIGhlcmUncyB0aGUgU2NhbGFibGUgVGllcmVkIE1lbW9yeSBDb250cm9sIChTVE1D
KQ0KPiA+IA0KPiA+ICoqQmFja2dyb3VuZCoqDQo+ID4gDQo+ID4gSW4gdGhlIGVyYSB3aGVuIGFy
dGlmaWNpYWwgaW50ZWxsaWdlbmNlLCBiaWcgZGF0YSBhbmFseXRpY3MsIGFuZA0KPiA+IG1hY2hp
bmUgbGVhcm5pbmcgaGF2ZSBiZWNvbWUgbWFpbnN0cmVhbSByZXNlYXJjaCB0b3BpY3MgYW5kDQo+
ID4gYXBwbGljYXRpb24gc2NlbmFyaW9zLCB0aGUgZGVtYW5kIGZvciBoaWdoLWNhcGFjaXR5IGFu
ZCBoaWdoLQ0KPiA+IGJhbmR3aWR0aCBtZW1vcnkgaW4gY29tcHV0ZXJzIGhhcyBiZWNvbWUgaW5j
cmVhc2luZ2x5IGltcG9ydGFudC4NCj4gPiBUaGUgZW1lcmdlbmNlIG9mIENYTCAoQ29tcHV0ZSBF
eHByZXNzIExpbmspIHByb3ZpZGVzIHRoZQ0KPiA+IHBvc3NpYmlsaXR5IG9mIGhpZ2gtY2FwYWNp
dHkgbWVtb3J5LiBBbHRob3VnaCBDWEwgVFlQRTMgZGV2aWNlcw0KPiA+IGNhbiBwcm92aWRlIGxh
cmdlIG1lbW9yeSBjYXBhY2l0aWVzLCB0aGVpciBhY2Nlc3Mgc3BlZWQgaXMgbG93ZXINCj4gPiB0
aGFuIHRyYWRpdGlvbmFsIERSQU0gZHVlIHRvIGhhcmR3YXJlIGFyY2hpdGVjdHVyZSBsaW1pdGF0
aW9ucy4NCj4gPiANCj4gPiBUbyBlbmpveSB0aGUgbGFyZ2UgY2FwYWNpdHkgYnJvdWdodCBieSBD
WEwgbWVtb3J5IHdoaWxlIG1pbmltaXppbmcNCj4gPiB0aGUgaW1wYWN0IG9mIGhpZ2ggbGF0ZW5j
eSwgTGludXggaGFzIGludHJvZHVjZWQgdGhlIFRpZXJlZCBNZW1vcnkNCj4gPiBhcmNoaXRlY3R1
cmUuIEluIHRoZSBUaWVyZWQgTWVtb3J5IGFyY2hpdGVjdHVyZSwgQ1hMIG1lbW9yeSBpcw0KPiA+
IHRyZWF0ZWQgYXMgYW4gaW5kZXBlbmRlbnQsIHNsb3dlciBOVU1BIE5PREUsIHdoaWxlIERSQU0g
aXMNCj4gPiBjb25zaWRlcmVkIGFzIGEgcmVsYXRpdmVseSBmYXN0ZXIgTlVNQSBOT0RFLiBBcHBs
aWNhdGlvbnMgYWxsb2NhdGUNCj4gPiBtZW1vcnkgZnJvbSB0aGUgbG9jYWwgbm9kZSwgYW5kIFRp
ZXJlZCBNZW1vcnksIGxldmVyYWdpbmcgbWVtb3J5DQo+ID4gcmVjbGFtYXRpb24gYW5kIE5VTUEg
QmFsYW5jaW5nIG1lY2hhbmlzbXMsIGNhbiB0cmFuc3BhcmVudGx5IGRlbW90ZQ0KPiA+IHBoeXNp
Y2FsIHBhZ2VzIG5vdCByZWNlbnRseSBhY2Nlc3NlZCBieSB1c2VyIHByb2Nlc3NlcyB0byB0aGUg
c2xvd2VyDQo+ID4gQ1hMIE5VTUEgTk9ERS4gSG93ZXZlciwgd2hlbiB1c2VyIHByb2Nlc3NlcyBy
ZS1hY2Nlc3MgdGhlIGRlbW90ZWQNCj4gPiBtZW1vcnksIHRoZSBUaWVyZWQgTWVtb3J5IG1lY2hh
bmlzbSB3aWxsLCBiYXNlZCBvbiBjZXJ0YWluIGxvZ2ljLA0KPiA+IGRlY2lkZSB3aGV0aGVyIHRv
IHByb21vdGUgdGhlIGRlbW90ZWQgcGh5c2ljYWwgcGFnZXMgYmFjayB0byB0aGUNCj4gPiBmYXN0
IE5VTUEgTk9ERS4gSWYgdGhlIHByb21vdGlvbiBpcyBzdWNjZXNzZnVsLCB0aGUgbWVtb3J5IGFj
Y2Vzc2VkDQo+ID4gYnkgdGhlIHVzZXIgcHJvY2VzcyB3aWxsIHJlc2lkZSBpbiBEUkFNOyBvdGhl
cndpc2UsIGl0IHdpbGwgcmVzaWRlIGluDQo+ID4gdGhlIENYTCBOT0RFLiBUaHJvdWdoIHRoZSBU
aWVyZWQgTWVtb3J5IG1lY2hhbmlzbSwgTGludXggYmFsYW5jZXMNCj4gPiBiZXR3ZWVubGFyZ2Ug
bWVtb3J5IGNhcGFjaXR5IGFuZCBsYXRlbmN5LCBzdHJpdmluZyB0byBtYWludGFpbiBhbg0KPiA+
IGVxdWlsaWJyaXVtIGZvciBhcHBsaWNhdGlvbnMuDQo+ID4gDQo+ID4gKipQcm9ibGVtKioNCj4g
PiBBbHRob3VnaCBUaWVyZWQgTWVtb3J5IHN0cml2ZXMgdG8gYmFsYW5jZSBiZXR3ZWVuIGxhcmdl
IGNhcGFjaXR5IGFuZA0KPiA+IGxhdGVuY3ksIHNwZWNpZmljIHNjZW5hcmlvcyBjYW4gbGVhZCB0
byB0aGUgZm9sbG93aW5nIGlzc3VlczoNCj4gPiANCj4gPiAgICAxLiBJbiBzY2VuYXJpb3MgcmVx
dWlyaW5nIG1hc3NpdmUgY29tcHV0YXRpb25zLCBpZiBkYXRhIGlzIGhlYXZpbHkNCj4gPiAgICAg
ICBzdG9yZWQgaW4gQ1hMIHNsb3cgbWVtb3J5IGFuZCBUaWVyZWQgTWVtb3J5IGNhbm5vdCBwcm9t
cHRseQ0KPiA+ICAgICAgIHByb21vdGUgdGhpcyBtZW1vcnkgdG8gZmFzdCBEUkFNLCBpdCB3aWxs
IHNpZ25pZmljYW50bHkgaW1wYWN0DQo+ID4gICAgICAgcHJvZ3JhbSBwZXJmb3JtYW5jZS4NCj4g
PiAgICAyLiBTaW1pbGFyIHRvIHRoZSBzY2VuYXJpbyBkZXNjcmliZWQgaW4gcG9pbnQgMSwgaWYg
VGllcmVkIE1lbW9yeQ0KPiA+ICAgICAgIGRlY2lkZXMgdG8gcHJvbW90ZSB0aGVzZSBwaHlzaWNh
bCBwYWdlcyB0byBmYXN0IERSQU0gTk9ERSwgYnV0DQo+ID4gICAgICAgZHVlIHRvIGxpbWl0YXRp
b25zIGluIHRoZSBEUkFNIE5PREUgcHJvbW90ZSByYXRpbywgdGhlc2UgcGh5c2ljYWwNCj4gPiAg
ICAgICBwYWdlcyBjYW5ub3QgYmUgcHJvbW90ZWQuIENvbnNlcXVlbnRseSwgdGhlIHByb2dyYW0g
d2lsbCBrZWVwDQo+ID4gICAgICAgcnVubmluZyBpbiBzbG93IG1lbW9yeS4NCj4gPiAgICAzLiBB
ZnRlciBhbiBhcHBsaWNhdGlvbiBmaW5pc2hlcyBjb21wdXRpbmcgb24gYSBsYXJnZSBibG9jayBv
ZiBmYXN0DQo+ID4gICAgICAgbWVtb3J5LCBpdCBtYXkgbm90IGltbWVkaWF0ZWx5IHJlLWFjY2Vz
cyBpdC4gSGVuY2UsIHRoaXMgbWVtb3J5DQo+ID4gICAgICAgY2FuIG9ubHkgd2FpdCBmb3IgdGhl
IG1lbW9yeSByZWNsYW1hdGlvbiBtZWNoYW5pc20gdG8gZGVtb3RlIGl0Lg0KPiA+ICAgIDQuIFNp
bWlsYXIgdG8gdGhlIHNjZW5hcmlvIGRlc2NyaWJlZCBpbiBwb2ludCAzLCBpZiB0aGUgZGVtb3Rp
b24NCj4gPiAgICAgICBzcGVlZCBpcyBzbG93LCB0aGVzZSBjb2xkIHBhZ2VzIHdpbGwgb2NjdXB5
IHRoZSBwcm9tb3Rpb24NCj4gPiAgICAgICByZXNvdXJjZXMsIHByZXZlbnRpbmcgc29tZSBlbGln
aWJsZSBzbG93IHBhZ2VzIGZyb20gYmVpbmcNCj4gPiAgICAgICBpbW1lZGlhdGVseSBwcm9tb3Rl
ZCwgc2V2ZXJlbHkgYWZmZWN0aW5nIGFwcGxpY2F0aW9uIGVmZmljaWVuY3kuDQo+ID4gDQo+ID4g
KipTb2x1dGlvbioqDQo+ID4gV2UgcHJvcG9zZSB0aGUgKipTY2FsYWJsZSBUaWVyZWQgTWVtb3J5
IENvbnRyb2wgKFNUTUMpKiogbWVjaGFuaXNtLA0KPiA+IHdoaWNoIGRlbGVnYXRlcyB0aGUgYXV0
aG9yaXR5IG9mIHByb21vdGluZyBhbmQgZGVtb3RpbmcgbWVtb3J5IHRvIHRoZQ0KPiA+IGFwcGxp
Y2F0aW9uLiBUaGUgcHJpbmNpcGxlIGlzIHNpbXBsZSwgYXMgZm9sbG93czoNCj4gPiANCj4gPiAg
ICAxLiBXaGVuIGFuIGFwcGxpY2F0aW9uIGlzIHByZXBhcmluZyBmb3IgY29tcHV0YXRpb24sIGl0
IGNhbiBwcm9tb3RlDQo+ID4gICAgICAgdGhlIG1lbW9yeSBpdCBuZWVkcyB0byB1c2Ugb3IgZW5z
dXJlIHRoZSBtZW1vcnkgcmVzaWRlcyBvbiBhIGZhc3QNCj4gPiAgICAgICBOT0RFLg0KPiA+ICAg
IDIuIFdoZW4gYW4gYXBwbGljYXRpb24gd2lsbCBub3QgdXNlIHRoZSBtZW1vcnkgc2hvcnRseSwg
aXQgY2FuDQo+ID4gICAgICAgaW1tZWRpYXRlbHkgZGVtb3RlIHRoZSBtZW1vcnkgdG8gc2xvdyBt
ZW1vcnksIGZyZWVpbmcgdXAgdmFsdWFibGUNCj4gPiAgICAgICBwcm9tb3Rpb24gcmVzb3VyY2Vz
Lg0KPiA+IA0KPiA+IFNUTUMgbWVjaGFuaXNtIGlzIGltcGxlbWVudGVkIHRocm91Z2ggdGhlIG1h
ZHZpc2Ugc3lzdGVtIGNhbGwsIHByb3ZpZGluZw0KPiA+IHR3byBuZXcgYWR2aWNlIG9wdGlvbnM6
IE1BRFZfREVNT1RFIGFuZCBNQURWX1BST01PVEUuIE1BRFZfREVNT1RFDQo+ID4gYWR2aXNlcyBk
ZW1vdGUgdGhlIHBoeXNpY2FsIG1lbW9yeSB0byB0aGUgbm9kZSB3aGVyZSBzbG93IG1lbW9yeQ0K
PiA+IHJlc2lkZXM7IHRoaXMgYWR2aWNlIG9ubHkgZmFpbHMgaWYgdGhlcmUgaXMgbm8gZnJlZSBw
aHlzaWNhbCBtZW1vcnkgb24NCj4gPiB0aGUgc2xvdyBtZW1vcnkgbm9kZS4gTUFEVl9QUk9NT1RF
IGFkdmlzZXMgcmV0YWluaW5nIHRoZSBwaHlzaWNhbCBtZW1vcnkNCj4gPiBpbiB0aGUgZmFzdCBt
ZW1vcnk7IHRoaXMgYWR2aWNlIG9ubHkgZmFpbHMgaWYgdGhlcmUgYXJlIG5vIHByb21vdGlvbg0K
PiA+IHNsb3RzIGF2YWlsYWJsZSBvbiB0aGUgZmFzdCBtZW1vcnkgbm9kZS4gQmVuZWZpdHMgYnJv
dWdodCBieSBTVE1DDQo+ID4gaW5jbHVkZToNCj4gPiANCj4gPiAgICAxLiBUaGUgU1RNQyBtZWNo
YW5pc20gaXMgYSB2YXJpYW50IG9mIG9uLWRlbWFuZCBtZW1vcnkgbWFuYWdlbWVudA0KPiA+ICAg
ICAgIGRlc2lnbmVkIHRvIGxldCBhcHBsaWNhdGlvbnMgZW5qb3kgZmFzdCBtZW1vcnkgYXMgbXVj
aCBhcyBwb3NzaWJsZSwNCj4gPiAgICAgICB3aGlsZSBhY3RpdmVseSBkZW1vdGluZyB0byBzbG93
IG1lbW9yeSB3aGVuIG5vdCBpbiB1c2UsIHRodXMNCj4gPiAgICAgICBmcmVlaW5nIHVwIHByb21v
dGlvbiBzbG90cyBmb3IgdGhlIE5PREUgYW5kIGFsbG93aW5nIGl0IHRvIHJ1biBpbg0KPiA+ICAg
ICAgIGFuIG9wdGltaXplZCBUaWVyZWQgTWVtb3J5IGVudmlyb25tZW50Lg0KPiA+ICAgIDIuIFRo
ZSBTVE1DIG1lY2hhbmlzbSBiZXR0ZXIgYmFsYW5jZXMgbGFyZ2UgY2FwYWNpdHkgYW5kIGxhdGVu
Y3kuDQo+ID4gDQo+ID4gKipTaG9ydGNvbWluZ3Mgb2YgU1RNQyoqDQo+ID4gVGhlIFNUTUMgbWVj
aGFuaXNtIHJlcXVpcmVzIHRoZSBjYWxsZXIgdG8gbWFuYWdlIG1lbW9yeSBkZW1vdGlvbiBhbmQN
Cj4gPiBwcm9tb3Rpb24uIElmIHRoZSBtZW1vcnkgaXMgbm90IHByb21wdGx5IGRlbW90aW5nIGFm
dGVyIGFuIHByb21vdGlvbiwNCj4gPiBpdCBtYXkgY2F1c2UgaXNzdWVzIHNpbWlsYXIgdG8gbWVt
b3J5IGxlYWtzDQo+IEVobSwgdGhhdCBzb3VuZHMgc2NhcnkuIENhbiB5b3UgZWxhYm9yYXRlIHdo
YXQncyBoYXBwZW5pbmcgaGVyZSBhbmQgd2h5IA0KPiBpdCBpcyAic2ltaWxhciB0byBtZW1vcnkg
bGVha3MiPw0KPiANCj4gDQo+IENhbiB5b3UgYWxzbyBwb2ludCBvdXQgd2h5IG1pZ3JhdGVfcGFn
ZXMoKSBpcyBub3Qgc3VpdGFibGU/IEkgd291bGQgDQo+IGFzc3VtZSBkZW1vdGUvcHJvbW90ZSBp
cyBpbiBlc3NlbmNlIHNpbXBseSBtaWdyYXRpbmcgbWVtb3J5IGJldHdlZW4gbm9kZXMuDQo+IA0K
PiAtLSANCj4gQ2hlZXJzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KPiANCg0KVGhhbmsgeW91
IGZvciB0aGUgcmVzcG9uc2UuIEJlbG93IGFyZSBteSBwb2ludHMgb2Ygdmlldy4gSWYgdGhlcmUg
YXJlIGFueQ0KbWlzdGFrZXMsIEkgYXBwcmVjaWF0ZSB5b3VyIHVuZGVyc3RhbmRpbmc6DQoNCjEu
IEluIGEgdGllcmVkIG1lbW9yeSBzeXN0ZW0sIGZhc3Qgbm9kZXMgYW5kIHNsb3cgbm9kZXMgYWN0
IGFzIHR3byBjb21tb24NCiAgIG1lbW9yeSBwb29scy4gVGhlIHN5c3RlbSBoYXMgYSBjZXJ0YWlu
IHJhdGlvIGxpbWl0IGZvciBwcm9tb3Rpb24uIEZvcg0KICAgZXhhbXBsZSwgYSBOT0RFIG1heSBz
dGlwdWxhdGUgdGhhdCB3aGVuIHRoZSBhdmFpbGFibGUgbWVtb3J5IGlzIGxlc3MNCiAgIHRoYW4g
MUdCIG9yIDEvNCBvZiB0aGUgbm9kZSdzIG1lbW9yeSwgcHJvbW90aW9uIGFyZSBwcm9oaWJpdGVk
LiBJZiB3ZQ0KICAgdXNlIG1pZ3JhdGVfcGFnZXMgYXQgdGhpcyBwb2ludCwgaXQgd2lsbCB1bnJl
c3RyaWN0ZWRseSBwcm9tb3RlIHNsb3cNCiAgIHBhZ2VzIHRvIGZhc3QgbWVtb3J5LCB3aGljaCBt
YXkgcHJldmVudCBvdGhlciBwcm9jZXNzZXPigJkgcGFnZXMgdGhhdA0KICAgc2hvdWxkIGhhdmUg
YmVlbiBwcm9tb3RlZCBmcm9tIGJlaW5nIHByb21vdGVkLiBUaGlzIGlzIHdoYXQgSSBtZWFuIGJ5
DQogICBvY2N1cHlpbmcgcHJvbW90aW9uIHJlc291cmNlcy4NCjIuIEFzIGRlc2NyaWJlZCBpbiBw
b2ludCAxLCBpZiB3ZSB1c2UgTUFEVl9QUk9NT1RFIHRvIHRlbXBvcmFyaWx5IHByb21vdGUNCiAg
IGEgYmF0Y2ggb2YgcGFnZXMgYW5kIGRvIG5vdCBkZW1vdGUgdGhlbSBpbW1lZGlhdGVseSBhZnRl
ciB1c2FnZSwgaXQNCiAgIHdpbGwgb2NjdXB5IG1hbnkgcHJvbW90aW9uIHJlc291cmNlcy4gT3Ro
ZXIgaG90IHBhZ2VzIHRoYXQgbmVlZCBwcm9tb3RlDQogICB3aWxsIG5vdCBiZSBhYmxlIHRvIGdl
dCBwcm9tb3RlLCB3aGljaCB3aWxsIGltcGFjdCB0aGUgcGVyZm9ybWFuY2Ugb2YNCiAgIGNlcnRh
aW4gcHJvY2Vzc2VzLg0KMy4gTUFEVl9ERU1PVEUgYW5kIE1BRFZfUFJPTU9URSBvbmx5IHJlbHkg
b24gbWFkdmlzZSwgd2hpbGUgbWlncmF0ZV9wYWdlcw0KICAgZGVwZW5kcyBvbiBsaWJudW1hLg0K
NC4gTUFEVl9ERU1PVEUgYW5kIE1BRFZfUFJPTU9URSBwcm92aWRlIGEgYmV0dGVyIGJhbGFuY2Ug
YmV0d2VlbiBjYXBhY2l0eQ0KICAgYW5kIGxhdGVuY3kuIFRoZXkgYWxsb3cgaG90IHBhZ2VzIHRo
YXQgbmVlZCBwcm9tb3RpbmcgdG8gYmUgcHJvbW90ZWQNCiAgIHNtb290aGx5IGFuZCBwYWdlcyB0
aGF0IG5lZWQgZGVtb3RpbmcgdG8gYmUgZGVtb3RlZCBpbW1lZGlhdGVseS4gVGhpcw0KICAgaGVs
cHMgdGllcmVkIG1lbW9yeSBzeXN0ZW1zIHRvIG9wZXJhdGUgbW9yZSByYXRpb25hbGx5Lg0KDQo6
KSBCaXNjdWl0T1MgQnJvaWxlcg0K

