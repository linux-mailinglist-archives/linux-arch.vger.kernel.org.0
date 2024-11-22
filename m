Return-Path: <linux-arch+bounces-9152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1189D6497
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2024 20:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DADC160F2C
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064115CD60;
	Fri, 22 Nov 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=boeing.com header.i=@boeing.com header.b="b9Fe4hYW"
X-Original-To: linux-arch@vger.kernel.org
Received: from ewa-mbsout-02.mbs.boeing.net (ewa-mbsout-02.mbs.boeing.net [130.76.20.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE52FC23;
	Fri, 22 Nov 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.76.20.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303942; cv=none; b=t7gTuCueGsGgYfu3vXzOfaa+RSZHr4gDZY3SVkYDWsPkHxBas6oy1ZeqN91tehX25WKCw+noo26AcQx9RBcOrb/XAxx1QOaPFTEoEGtxCnA+BilvKnEIWaMoEniDdD5dluHGihvn3Pb+cjPHJusVvTzS5+rWDrvrKrLS+LKpmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303942; c=relaxed/simple;
	bh=wG2inwSpR/9+X54wlCts1dEXVIrIecNMNuwaBfvJ464=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lEYXUpBP8KqO9oAwSkGQzAXOx/YwW2nchqIkiwDqaznAC4OyxyxKtkA9I3bbXW0xyWRs5Ow1z0gMUvTU7CFX+YbjxUxzns0DTos5eHTXYG7InnsFq5Ljv057BhFp6fqrL7Py9hnnboY4ftYyswXUuoMAVaCdoSMncminuDUP0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=boeing.com; spf=pass smtp.mailfrom=boeing.com; dkim=pass (2048-bit key) header.d=boeing.com header.i=@boeing.com header.b=b9Fe4hYW; arc=none smtp.client-ip=130.76.20.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=boeing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boeing.com
Received: from localhost (localhost [127.0.0.1])
	by ewa-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 4AMJT4ff028071;
	Fri, 22 Nov 2024 11:29:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1732303752;
	bh=wG2inwSpR/9+X54wlCts1dEXVIrIecNMNuwaBfvJ464=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=b9Fe4hYWJDv8vlgzCTBJRYxvgKsY2s2xN94nQIX+oFkSQfukvayGgoYYk2nABAroA
	 FyZHzL14PUk4dE7FeKfiYrdms0/c2Vmu48G4BAUwsNW31cUmUJ5wIDmV59Gl5HWM1f
	 iWdyqjsc/Ggb0sfh6meyffWTBwpOyr0wg7hCawcPRADGq7XEJkDRRuVmYsyPH0CbXu
	 0Y095/BH8cur5GmSkVqsTcqUMQJXv+O9LU1g9sOpMspF+v622PaLECbD6NozlIstk3
	 KPMGdG1e0eMFNTqhMkBz09iXV4wnSRLF6/2hbHKR9ZBX+3phMSKB9eC934hVPIqO+H
	 6zpiT4xVsj+YA==
Received: from XCH16-03-02.nos.boeing.com (xch16-03-02.nos.boeing.com [137.137.111.11])
	by ewa-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 4AMJSmxp027883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Nov 2024 11:28:49 -0800
Received: from XCH16-03-04.nos.boeing.com (137.137.111.13) by
 XCH16-03-02.nos.boeing.com (137.137.111.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 11:28:46 -0800
Received: from XCH16-03-04.nos.boeing.com ([fe80::7809:c78b:36c8:935e]) by
 XCH16-03-04.nos.boeing.com ([fe80::7809:c78b:36c8:935e%13]) with mapi id
 15.01.2507.039; Fri, 22 Nov 2024 11:28:46 -0800
From: "Wolber (US), Chuck" <chuck.wolber@boeing.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor
	<nathan@kernel.org>
CC: Wentao Zhang <wentaoz5@illinois.edu>,
        "Kelly (US), Matt"
	<Matt.Kelly2@boeing.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "Oppelt (US), Andrew J"
	<andrew.j.oppelt@boeing.com>,
        "anton.ivanov@cambridgegreys.com"
	<anton.ivanov@cambridgegreys.com>,
        "ardb@kernel.org" <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jinghao7@illinois.edu"
	<jinghao7@illinois.edu>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "justinstitt@google.com" <justinstitt@google.com>,
        "kees@kernel.org"
	<kees@kernel.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "luto@kernel.org"
	<luto@kernel.org>,
        "marinov@illinois.edu" <marinov@illinois.edu>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "maskray@google.com"
	<maskray@google.com>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "Weber (US), Matthew L"
	<matthew.l.weber3@boeing.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "morbo@google.com" <morbo@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "oberpar@linux.ibm.com"
	<oberpar@linux.ibm.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "Sarkisian (US), Samuel" <samuel.sarkisian@boeing.com>,
        "Vanderleest (US),
 Steven H" <steven.h.vanderleest@boeing.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "tingxur@illinois.edu" <tingxur@illinois.edu>,
        "tyxu@illinois.edu" <tyxu@illinois.edu>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's
 Source-based Code Coverage and MC/DC with Clang
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's
 Source-based Code Coverage and MC/DC with Clang
Thread-Index: AQHbFIcZxf21kGRuK0Wyyav9pF/OKLJzeOYAgAKrngCATew1gP//77aA
Date: Fri, 22 Nov 2024 19:28:46 +0000
Message-ID: <5F5EA6BE-94BD-4352-ADA9-D14BBE703D4F@boeing.com>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <20241122122703.GW24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122122703.GW24774@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.90.24110120
x-tm-snts-smtp: 7DF70432748D194DD0E592FE746D6476C899CCB5789BECADCB3900194B2B36932000:8
Content-Type: text/plain; charset="utf-8"
Content-ID: <16FA026E611EC84494309EE6F018901D@boeing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00

PiA+IE9uIFRodSwgT2N0IDAzLCAyMDI0IGF0IDA0OjI5OjM4UE0gLTA3MDAsIE5hdGhhbiBDaGFu
Y2VsbG9yIHdyb3RlOg0KPiA+DQo+ID4gJCAvdXNyL2Jpbi90aW1lIC12IG1ha2UgLXNraiIkKG5w
cm9jKSIgQVJDSD14ODZfNjQgTExWTT0xIG1ycHJvcGVyIHtkZWYsYW1kX21lbV9lbmNyeXB0Lixm
b3J0aWZ5X3NvdXJjZS4sbGx2bV9jb3YufWNvbmZpZyBiekltYWdlDQo+ID4gLi4uDQo+ID4gdm1s
aW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBfX3Nldl9lc19ubWlfY29tcGxldGUrMHg2ZTogY2Fs
bCB0byBrYXNhbl9jaGVja193cml0ZSgpIGxlYXZlcyAubm9pbnN0ci50ZXh0IHNlY3Rpb24NCg0K
JTwgU05JUCAlPA0KDQo+ID4gdm1saW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBhY3BpX2lkbGVf
ZG9fZW50cnkrMHg0OiBjYWxsIHRvIHBlcmZfbG9wd3JfY2IoKSBsZWF2ZXMgLm5vaW5zdHIudGV4
dCBzZWN0aW9uDQo+DQo+DQo+IEp1c3Qgc2F3IHRoaXMgZmx5IGJ5LCB0aGF0IGxvb2tzIGxpa2Ug
c29tZXRoaW5nIGlzIGJ1Z2dlcmVkIGJhZC4gTm90YWJseQ0KPiBsb2NrZGVwX2hhcmRpcnFzX3tv
bixvZmZ9KCkgYXJlIG5vaW5zdHIuDQo+DQo+DQo+IElzIHRoaXMgcGF0Y2gtc2V0IGNhdXNpbmcg
dGhpcywgb3Igd2hhdD8NCg0KTm8sIHRoZXNlIHBhdGNoZXMgYXJlIG5vdCBjYXVzaW5nIHRoaXMu
IFRoaXMgcGF0Y2gtc2V0IGFwcGVhcnMgdG8gaGF2ZSBleHBvc2VkIGENCmJ1ZyBpbiB0aGUgbGx2
bSBsaW5rZXIgKGxsZCk6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9p
c3N1ZXMvMTE2NTc1DQoNCi4uQ2g6Vy4uDQoNCg==

