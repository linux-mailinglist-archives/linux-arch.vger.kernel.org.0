Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5F513D07B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 00:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgAOXCI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 18:02:08 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:36668 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgAOXCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 18:02:08 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EB8C4C0525;
        Wed, 15 Jan 2020 23:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579129327; bh=5N0aWvdhJXHQK2AbtZqnhO0gdG+ZUH0HvJ8mAiJFJtI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=V/mx/1aEfZCmGOTh2331ASabO6VfNR7DTlfxYE1RKqlDCF9GPYGeBW0hOH07B8m7i
         zDth8PMgaf7v/xnCK6pSwvSLzQt6iDePX+Lv15zCh2Y+RrC0lvlVsEeTraCtRnwHLc
         FUwGCsJ1e5FzamqrmxgivctCljWHYC2Xm/Fcvd5vlFE8WwfV3celojwAABFiOPM06j
         Gad31+bsoxMdVWzga32gvOdK0QjthI3etqf18OCGxqErP2FtPPKyhdAnnVuHisahl+
         AeUxF7Ap870G/p1nn9MMCsuBKDSkKMKMuj8KG5a9xp6L7vdVXNGIXQqOWKudYaYDT0
         4JadMwBA7sflA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F0063A0079;
        Wed, 15 Jan 2020 23:02:04 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Jan 2020 15:01:50 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 15 Jan 2020 15:01:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPftBxwph2nlyexCyj7MsZWPfv422SnU4ZbIoNHBaQKyshYW8m4incUd5/LKVpxcQuTZEs4hZ01N93E/uCYgey9yjS4ToLRMnfsgH4vB4PG94WhoZ7Rj/HxrmJJo3HNR17soeBSDzzRWsLx587v857+iIDj3PtJ4sp6x9mz/tCYXfo+wfh4cWUsSY3xGH2nbMjvV0vK/6dR1MLIXWItT8u9PGpceEJsqLiZ19fTJeW0KoiU4nt+Mul4C1zeWnfo6GFsgQ81lUmWaz7ZxPhuzg8McgPRWSZgPLcvG93j1OvB0vZDmhwZjNloz1eFiAEaklEM1WB1NVJJ36NWf+YkaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N0aWvdhJXHQK2AbtZqnhO0gdG+ZUH0HvJ8mAiJFJtI=;
 b=EeqIqxComnDXD4lAVJG5BqYuZBjUeiL9eFyd5DIEMlUIh4s9NcIBmsa5KYHh//9ZsXLq73x81ahDgZ/hxBG0JI8sgX6GQjIG5w4J2ryce2na0ZZPxhCr0SPxryXu1sLLafZnC10ITpDD3TKjmHHQMsBvJ1bJOSWa8dkuRQzG8f9IVHUUhsAJGz2ojchsNlx/BcyRQYZdEuLaSse8UGpi/G1zMqsFUosJKeP9qyakffOAXerZKuGFl2VdUa2cUqQBnrNN/V5g0Ug8U3tJVF7CNNBsF2kjiVW8ut4zm/m9lHI8wCVxS//LelZjG/DfGBgjruonXKdeIWUmnyQST5bQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N0aWvdhJXHQK2AbtZqnhO0gdG+ZUH0HvJ8mAiJFJtI=;
 b=YR5Mtm4wMt20wUeDkivJPElXYp7YO3c+MUzZlto7N5eaA0SK6Qi7n69akHeNd3SqHHCmiKOEuTjpfT1c9j094utXkeyslx90Gqum+PkhTbPLmw6+hm+Cgvd/Wv5+dBatvOS/2/a71zW7fT9Ti+E8Hg4/c5zm6RRQpuGwTRh7Iz8=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3445.namprd12.prod.outlook.com (20.178.196.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 23:01:48 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 23:01:48 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        "Ingo Molnar" <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Thread-Topic: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Thread-Index: AQHVyxaHbM7a7l3XuUaNwAYN+sKBiqfqpFkAgAG1AIA=
Date:   Wed, 15 Jan 2020 23:01:48 +0000
Message-ID: <6eb7587b-c3bc-691d-9d27-d4e687114a42@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-2-vgupta@synopsys.com>
 <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f1effe-33a7-410b-06de-08d79a0ee684
x-ms-traffictypediagnostic: BYAPR12MB3445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB344528246EFADD457721148CB6370@BYAPR12MB3445.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(66556008)(36756003)(8936002)(2616005)(81166006)(66946007)(4326008)(64756008)(66446008)(66476007)(31696002)(76116006)(6506007)(8676002)(31686004)(7416002)(110136005)(316002)(81156014)(71200400001)(6512007)(86362001)(2906002)(6486002)(186003)(53546011)(5660300002)(478600001)(54906003)(26005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3445;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWlkuu5doewNfrbSIdE3skwK8DePMZ0OiWlkPXuHdOUpnQ2QgErcuxY3jeCEQzMtUW3yeE6nKhAunzLbK4BiXtJhK+CHuMeV81af6BBdekrqrSxVw/Lq4X4BEZAsT69ZGKkC+qlIx+I3e4lGvd08td1cGFx/NAxj4OFP5L7NXFy2Q9QeLG8RKF40anuNfq7EzwutiytL4fZm9IpLc9Na9h12bKMv9t17dhGmSvy28FZtVJt6uSadJjBvzbKrC9m0mFm6Gysebt/YFX1lM/Pcdtd17TY7LXtFl1aSuAKIRgXoRvnIxaNlLUREh+guXpgeoM6ey4mvwDxiUN02FPuRSTW0bSAMiCxUJJSBjisORIBuC2Xl/CljrwbCte9IDswXjdjT/Bx+xj2CGa9Xzp58KBZ122+lSkTMTzc9i3vt7PAill/G5iwGN+h4+YbnJ7isoJoCNkhOBtav+ajh6snRyhB2TDpFjV+T+bKLEB2Ft/s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B676B95FC3FC714FA1FB6336730C5498@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f1effe-33a7-410b-06de-08d79a0ee684
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 23:01:48.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFJXx6/LxoaXZHq/MShv4RY0q05dOgIbP/GWnQbkwXPQWNHVBYy2xhkbWblp97m3jIUU6QtzdyUhEDHWsO6QbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMS8xNC8yMCAxMjo1NyBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgOTowOCBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4+IFRoZXJlIGFyZSAyIGdlbmVyaWMgdmFyYWludHMgb2Ygc3RybmNweV9m
cm9tX3VzZXIoKSAvIHN0cm5sZW5fdXNlcigpDQo+PiAgKDEpLiBpbmxpbmUgdmVyc2lvbiBpbiBh
c20tZ2VuZXJpYy91YWNjZXNzLmgNCj4+ICAoMikuIG9wdGltaXplZCB3b3JkLWF0LWEtdGltZSB2
ZXJzaW9uIGluIGxpYi8qDQo+Pg0KPj4gVGhpcyBwYXRjaCBkaXNhYmxlcyAjMSBpZiAjMiBzZWxl
Y3RlZC4gVGhpcyBhbGxvd3MgYXJjaGVzIHRvIGNvbnRpbnVlDQo+PiByZXVzaW5nIGFzbS1nZW5l
cmljL3VhY2Nlc3MuaCBmb3IgcmVzdCBvZiBjb2RlDQo+Pg0KPj4gVGhpcyBjYW1lIHVwIHdoZW4g
c3dpdGNoaW5nIEFSQyB0byBnZW5lcmljIHdvcmQtYXQtYS10aW1lIGludGVyZmFjZQ0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4gVGhp
cyBsb29rcyBsaWtlIGEgdXNlZnVsIGNoYW5nZSwgYnV0IEkgdGhpbmsgd2UgY2FuIGRvIGV2ZW4g
YmV0dGVyOiBJdA0KPiBzZWVtcyB0aGF0DQo+IHRoZXJlIGFyZSBubyAgY2FsbGVycyBvZiBfX3N0
cm5sZW5fdXNlciBvciBfX3N0cm5jcHlfZnJvbV91c2VyICBpbiB0aGUNCj4ga2VybmVsIHRvZGF5
LCBzbyB0aGVzZSBzaG91bGQgbm90IGJlIGRlZmluZWQgZWl0aGVyIHdoZW4gdGhlIEtjb25maWcg
c3ltYm9scw0KPiBhcmUgc2V0LiBBbHNvLCBJIHdvdWxkIHN1Z2dlc3QgbW92aW5nIHRoZSAnZXh0
ZXJuJyBkZWNsYXJhdGlvbiBmb3IgdGhlIHR3bw0KPiBmdW5jdGlvbnMgaW50byB0aGUgI2Vsc2Ug
YnJhbmNoIG9mIHRoZSBjb25kaXRpb25hbCBzbyBpdCBkb2VzIG5vdCBuZWVkIHRvIGJlDQo+IGR1
cGxpY2F0ZWQuDQoNCkdpdmVuIHdoZXJlIHRoaW5ncyBzZWVtIHRvIGJlIGhlYWRpbmcsIGRvIHUg
c3RpbGwgd2FudCBhbiB1cGRhdGVkIHBhdGNoIGZvciB0aGlzDQpvciBkbyB1IHBsYW4gdG8gZGl0
Y2ggdGhlIGlubGluZSB2ZXJzaW9uIGluIHNob3J0IHRlcm0gYW55d2F5cy4NCg0KLVZpbmVldA0K
DQo=
