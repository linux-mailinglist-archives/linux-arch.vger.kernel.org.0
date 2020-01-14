Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFA13B4CD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgANVxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:53:38 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:57660 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgANVxi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 16:53:38 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B6E0C00B0;
        Tue, 14 Jan 2020 21:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579038816; bh=4XwYZ9v8Fz4KKfWDla2VaslFXw2C7n3oP7kX6lohgBg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lMA88E+VPiWb6zXbx7nHAhX4qcPXTLzgfa4DuiMFWpij/YJz8+eo59WQL01S6NyN0
         ww/SoBXVXJ4PViuxjqksUK1qjtYSYHFfquYCDM8sLXec6SvuT9mRbEJxUTvfOymSbT
         yPeuKNgFK9TZc27xXNYYVpD60jHewcTpM+PWDoWkF4euJe0sO4pl+3n5yrbaszbNqA
         xyFiWcGLTthDSr6OiKMrEGOJrmfeURDyuCcPUoIe3GWh+0lqLJxXDbWP1PK52O98Hy
         Piv1g56wF+yOdl5NZXOMy8cZHe8bKm+B+k4tFaryr85WUbUadc0ZlsF7BuLbauSwWj
         rL+WIxeMz62Rg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D6EE0A0069;
        Tue, 14 Jan 2020 21:53:18 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Jan 2020 13:52:48 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 14 Jan 2020 13:52:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Dem2ZO1zKEewYdDjC+BIEmZuGdzIVVtyChHIeA92rYIlFOv6Csenmsi4OkIaUnF9uNwfwlagcfM6ukJua7MpaGZa12mkn2BrJENEkFl7R7A0Y6/O9NFdCT/vD+vPB+3vvOx8DSdb8pAkLIPmP8/phr5XcP2/Fj3jL48J2i4z2YdsSQPS65UInEDXq6rh7IiPN0gNpf8bJZ4jcyekUOjzxLsL74lK0T3v16by5MX+dQgNhmDuFU/IqBhaWBpqSIjGP7lLJh94XYscEeEqWaU8SEEzxQLxrQL6Q6tuzcMh1p7b2cwm35VrF+Kp5bf7b4w3+N0/fUTuQUoqNooEVRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XwYZ9v8Fz4KKfWDla2VaslFXw2C7n3oP7kX6lohgBg=;
 b=cOzc5FbslDsdvaI9FFlJfkJ1/F7p4sDee+6LAb9mG1bmAVKIVqQdVaaBmWg+UOdop/nIEJk7Z/zPVd9OnhLHYlcWIixtVh2b4CfW4UmO1upmnOkPrT7yGVc5ooyi9qUm/+69P3rnVmW9PcTnxAGBSbndbrkgliWnlbqlMuIcA+wG2FVXgy6NjkEqItH59r2WyGtQ4UKU0EknF1bEP/cnV4fvKPWV7K5Us1lQGqsuaL0KIy3sHiMycGj+a0kFunaqh8jeYHoiSesE/20OE29prQbX2xzFPGl19cLIuJ0/aQA3HHDg2mKyHDIiKiLKXkcPKUPsTYU50lTbfdPNoAHmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XwYZ9v8Fz4KKfWDla2VaslFXw2C7n3oP7kX6lohgBg=;
 b=lrNBsYf5ebP2TWCcUxTG33lV3zpclsvOJwfia0Mpc8AKbcKS5bQaBZ/JfNCjDx3qAHBigWpVEZJtCSrzq5Iwp4sVSifOpPpNJ+RJN6X2yEbgGg+aW66/AL7JG1w9ZGsArx0sGXha/JAxvkOk1IzaVP9EFI4yihhD6mV01HWO2uY=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB2885.namprd12.prod.outlook.com (20.179.94.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 21:52:47 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 21:52:47 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Thread-Topic: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Thread-Index: AQHVyxaGa9XIQ1INcUi806p/qvo5ZafqqyuAgAAIj4A=
Date:   Tue, 14 Jan 2020 21:52:47 +0000
Message-ID: <72451406-6575-c16e-057e-30dc68ed9d2f@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-3-vgupta@synopsys.com>
 <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
In-Reply-To: <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b11e8490-2dc1-4bf5-f829-08d7993c17c8
x-ms-traffictypediagnostic: BYAPR12MB2885:
x-microsoft-antispam-prvs: <BYAPR12MB2885157227740C85961D9050B6340@BYAPR12MB2885.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8936002)(478600001)(6506007)(316002)(26005)(31696002)(86362001)(186003)(31686004)(54906003)(53546011)(36756003)(8676002)(6512007)(81156014)(2616005)(6486002)(81166006)(71200400001)(7416002)(66476007)(5660300002)(66556008)(6916009)(66946007)(64756008)(66446008)(76116006)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2885;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPzyAm8f6pgWKWRFiwiEftvXEcretL+o/xzWuvm9+Mh5ZObtVs4G3qWw91aBFktL3YxHoS0CBTvuRycsebnLx5RVbYi3SEqWqcclHh9Aybzvz5x40Bgr4JDd01yFNbUpI9Zp6E2aFvwAlR/DCtWqC9cpB9DxZRB7uoxSCtkSfmo5qWcPq93j7+xatggJqfx88TB12DzGS/N9w4zcrj1sjvSd466EtL12xZj/DDN2Saz+ZiACOKW7eeq07pBg/5xfaJBxg/q+upV/7UR6ycq9R6VWAjVIi7WxxZBahDAZ7JTaDhqP5/g0tjw/33TZbFGSjwvEAtpc40slm2m5ay0GLwRCm59Rlv8lZyIzw7/9ixGNb7UTuRuS9d3G+GJoOnx3HhrKW8J3QGmw9lghIW/BhXOyqT7vXKLyvKPsbXPoxOl5UKJEwt0h7lAgYKe+TXuV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E98DDBD8F53B0845B4739E9AE1F79431@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b11e8490-2dc1-4bf5-f829-08d7993c17c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 21:52:47.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3DVTejsPJCOMnMQDtdLhYAevMHspqT3+nMmwwvXYgwGyWIxxdj034U2AIyxM13w2f/8y3DwEzKtWHLpOj1haw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2885
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMS8xNC8yMCAxOjIyIFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgMTI6MDkgUE0gVmluZWV0IEd1cHRhDQo+IDxWaW5lZXQuR3VwdGExQHN5bm9w
c3lzLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhpcyBjYW1lIHVwIHdoZW4gc3dpdGNoaW5nIEFSQyB0
byB3b3JkLWF0LWEtdGltZSBpbnRlcmZhY2UgYW5kIHVzaW5nDQo+PiBnZW5lcmljL29wdGltaXpl
ZCBzdHJuY3B5X2Zyb21fdXNlcg0KPj4NCj4+IEl0IHNlZW1zIHRoZSBleGlzdGluZyBjb2RlIGNo
ZWNrcyBmb3IgdXNlciBidWZmZXIvc3RyaW5nIHJhbmdlIG11bHRpcGxlDQo+PiB0aW1lcyBhbmQg
b25lIG9mIHRlbSBjbiBiZSBhdm9pZGVkLg0KPiANCj4gTk8hDQo+IA0KPiBETyBOT1QgRE8gVEhJ
Uy4NCj4gDQo+IFRoaXMgaXMgc2VyaW91c2x5IGJ1Z2d5Lg0KPiANCj4+ICBsb25nIHN0cm5jcHlf
ZnJvbV91c2VyKGNoYXIgKmRzdCwgY29uc3QgY2hhciBfX3VzZXIgKnNyYywgbG9uZyBjb3VudCkN
Cj4+ICB7DQo+PiAtICAgICAgIHVuc2lnbmVkIGxvbmcgbWF4X2FkZHIsIHNyY19hZGRyOw0KPj4g
LQ0KPj4gICAgICAgICBpZiAodW5saWtlbHkoY291bnQgPD0gMCkpDQo+PiAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+Pg0KPj4gLSAgICAgICBtYXhfYWRkciA9IHVzZXJfYWRkcl9tYXgoKTsN
Cj4+IC0gICAgICAgc3JjX2FkZHIgPSAodW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHNyYyk7
DQo+PiAtICAgICAgIGlmIChsaWtlbHkoc3JjX2FkZHIgPCBtYXhfYWRkcikpIHsNCj4+IC0gICAg
ICAgICAgICAgICB1bnNpZ25lZCBsb25nIG1heCA9IG1heF9hZGRyIC0gc3JjX2FkZHI7DQo+PiAr
ICAgICAgIGthc2FuX2NoZWNrX3dyaXRlKGRzdCwgY291bnQpOw0KPj4gKyAgICAgICBjaGVja19v
YmplY3Rfc2l6ZShkc3QsIGNvdW50LCBmYWxzZSk7DQo+PiArICAgICAgIGlmICh1c2VyX2FjY2Vz
c19iZWdpbihzcmMsIGNvdW50KSkgew0KPiANCj4gWW91IGNhbid0IGRvIHRoYXQgInVzZXJfYWNj
ZXNzX2JlZ2luKHNyYywgY291bnQpIiwgYmVjYXVzZSAiY291bnQiIGlzDQo+IHRoZSBtYXhpbXVt
IF9wb3NzaWJsZV8gbGVuZ3RoLCBidXQgaXQgaXMgKk5PVCogbmVjZXNzYXJpbHkgdGhlIGFjdHVh
bA0KPiBsZW5ndGggb2YgdGhlIHN0cmluZyB3ZSByZWFsbHkgZ2V0IGZyb20gdXNlciBzcGFjZSEN
Cj4gDQo+IFRoaW5rIG9mIHRoaXMgc2l0dWF0aW9uOg0KPiANCj4gIC0gdXNlciBoYXMgYSA1LWJ5
dGUgc3RyaW5nIGF0IHRoZSBlbmQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UNCj4gDQo+ICAtIGtlcm5l
bCBkb2VzIGENCj4gDQo+ICAgICAgbiA9IHN0cm5jcHlfZnJvbV91c2VyKHVhZGRyLCBwYWdlLCBQ
QUdFX1NJWkUpDQo+IA0KPiBub3cgeW91ciAidXNlcl9hY2Nlc3NfYmVnaW4oc3JjLCBjb3VudCki
IHdpbGwgX2ZhaWxfLCBiZWNhdXNlICJ1YWRkciINCj4gaXMgY2xvc2UgdG8gdGhlIGVuZCBvZiB0
aGUgdXNlciBhZGRyZXNzIHNwYWNlLCBhbmQgdGhlcmUncyBub3Qgcm9vbQ0KPiBmb3IgUEFHRV9T
SVpFIGJ5dGVzIGFueSBtb3JlLg0KDQpPb3BzIGluZGVlZCB0aGF0IHdhcyB0aGUgY2FzZSBJIGRp
ZG4ndCBjb21wcmVoZW5kLiBJbiBteSBpbml0aWFsIHRlc3RzIHdpdGgNCmRlYnVnZ2VyLCBldmVy
eSBzaW5nbGUgaGl0IG9uIHN0cm5jcHlfZnJvbV91c2VyKCkgaGFkIHVzZXIgYWRkcmVzc2VzIHdl
bGwgaW50byB0aGUNCmFkZHJlc3Mgc3BhY2Ugc3VjaCB0aGF0IEBtYXggd2FzIHJpZGljdWxvdXNs
eSBsYXJnZSAoMHhGRkZGX0ZGRkYgLSBwdHIpIGNvbXBhcmVkDQp0byBAY291bnQuDQoNCj4gQnV0
ICJjb3VudCIgaXNuJ3QgYWN0dWFsbHkgaG93IG1hbnkgYnl0ZXMgd2Ugd2lsbCBhY2Nlc3MgZnJv
bSB1c2VyDQo+IHNwYWNlLCBpdCdzIG9ubHkgdGhlIG1heGltdW0gbGltaXQgb24gdGhlICp0YXJn
ZXQqLiBJT1csIGl0J3MgYWJvdXQgYQ0KPiBrZXJuZWwgYnVmZmVyIHNpemUsIG5vdCBhYm91dCB0
aGUgdXNlciBhY2Nlc3Mgc2l6ZS4NCg0KUmlnaHQgSSB1bmRlcnN0b29kIGFsbCB0aGF0LCBidXQg
bWlzc2VkIHRoZSBjYXNlIHdoZW4gdXNlciBidWZmZXIgaXMgdG93YXJkcyBlbmQNCm9mIGFkZHJl
c3Mgc3BhY2UgYW5kIGFjY2Vzc19vaygpIHdpbGwgZXJyb25lb3VzbHkgZmxhZyBpdC4NCg0KPiBC
ZWNhdXNlIHdlJ2xsIG9ubHkgYWNjZXNzIHRoYXQgNS1ieXRlIHN0cmluZywgd2hpY2ggZml0cyBq
dXN0IGZpbmUgaW4NCj4gdGhlIHVzZXIgc3BhY2UsIGFuZCBkb2luZyB0aGF0ICJ1c2VyX2FjY2Vz
c19iZWdpbihzcmMsIGNvdW50KSIgZ2l2ZXMNCj4gdGhlIHdyb25nIGFuc3dlci4NCj4gDQo+IFRo
ZSBmYWN0IGlzLCBjb3B5aW5nIGEgc3RyaW5nIGZyb20gdXNlciBzcGFjZSBpcyAqdmVyeSogZGlm
ZmVyZW50IGZyb20NCj4gY29weWluZyBhIGZpeGVkIG51bWJlciBvZiBieXRlcywgYW5kIHRoYXQg
d2hvbGUgZGFuY2Ugd2l0aA0KPiANCj4gICAgICAgICBtYXhfYWRkciA9IHVzZXJfYWRkcl9tYXgo
KTsNCj4gDQo+IGlzIGFic29sdXRlbHkgcmVxdWlyZWQgYW5kIG5lY2Vzc2FyeS4NCj4gDQo+IFlv
dSBjb21wbGV0ZWx5IGJyb2tlIHN0cmluZyBjb3B5aW5nLg0KDQpJJ20gc29ycnkgYW5kIEkgd2Fz
bid0IHN1cmUgdG8gYmVnaW4gd2l0aCBoZW5jZSB0aGUgZGlzY2xhaW1lciBpbiAwLzQNCg0KPiBJ
dCBpcyB2ZXJ5IHBvc3NpYmxlIHRoYXQgc3RyaW5nIGNvcHlpbmcgd2FzIGhvcnJpYmx5IGJyb2tl
biBvbiBBUkMNCj4gYmVmb3JlIHRvbyAtIGFsbW9zdCBub2JvZHkgZXZlciBnZXRzIHRoaXMgcmln
aHQsIGJ1dCB0aGUgZ2VuZXJpYw0KPiByb3V0aW5lIGRvZXMuDQoNCk5vIGl0IGlzIG5vdC4gSXQg
aXMganVzdCBkb2cgc2xvdyBzaW5jZSBpdCBkb2VzIGJ5dGUgY29weSBhbmQgdXNlcyB0aGUgWmVy
byBkZWxheQ0KbG9vcHMgd2hpY2ggSSdtIHRyeWluZyB0byBnZXQgcmlkIG9mLiBUaGF0J3Mgd2hl
biBJIHJlY2FsbGVkIHRoZSB3b3JkLWF0LWEtdGltZQ0KQVBJIHdoaWNoIEknZCBtZWFuaW5nIHRv
IGdvIGJhY2sgdG8gZm9yIGxhc3QgNyB5ZWFycyA6LSkNCg0KLVZpbmVldA0KDQo=
