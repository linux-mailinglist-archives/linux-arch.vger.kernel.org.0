Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42213B479
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANVhJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:37:09 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:56924 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728656AbgANVhJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 16:37:09 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 25C85C00B0;
        Tue, 14 Jan 2020 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579037827; bh=IGoaseOLOTBBKU71cinrmDHmBLJIVMsgQKrQ4bcmKpY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TVpnjz1Bjb27L7xLAwjRdLSCxwovOQe04GcniVIBP+2YLvvhUn5rbBfcPzzqJvJ0y
         Cpo/jToeFpiDX8fceIhug5H3jPMGU1/odaZFeH2hFvqYdGzixcP37XA2nBTU9wcFZx
         LxfygJDokzB57O+7a1jcGhXKCioAmesuF9w75J+tZXQvLVPRgl0dAQTz5Z7xqBSOU4
         FuWFPL/iZjufYb4rZaG4aZHcyuiIR1Tmar8//6LjKnpOeYi7E6ZniSSn6E0lPDakJm
         iDZtKJCfhX1WwrJO8URvuJpZzfnmJY/KxdvYIR+V6WJu/stGmaA1jWGzXbdLpoE584
         GV/0vfBNu4zqA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A8082A0079;
        Tue, 14 Jan 2020 21:36:47 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Jan 2020 13:36:16 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 14 Jan 2020 13:36:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0NakyKvXOomcyI1r0fP0U5VG1A2KRpa78fABrJz2aGDnPKLIBC5/t7BfjI/If8WWkgVPLmCzJupvE28BUg1Ju6PEGX5y9fepHCeC72RFtIvSelG7oUbbcB8pRQhblLdClgZE+AhpqIRgWp1yXFwQruKn4Z98BeacP7wCASctEE4kXN8qajkToWkmjk1gUIv92LojC/pdj8Axl6HYhTfA1FC2KCpBSA0HoiNVRnTNuwC+gz8Ym+2aTWbwgf8mIP27Y/IeIEsFqJJ2/qg5B5bJpKzKUQCQvbvA7NwU3wmB4zqiMu5L3SKe1M/fGZFFQeo6Le0pQtR/I3jpXAyaw9unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGoaseOLOTBBKU71cinrmDHmBLJIVMsgQKrQ4bcmKpY=;
 b=ZgDqJaza5CkjHfeaMbi+rPAlCYX7rHHa625q1IZ0Ho8+D7r0SU8cINX3b5A1C1ugvkwZK8qO/prcESU4egYgq8RGQWvYXKjl1coHAmPnA/ZXBRAc6c2hlRQM9Pc6cADZT8JEov4DeN28R7Jfv2B1UHwMtY4b2wu2Lti4EiQTGf0t8A6rVnOE2JTHy31iPXtR294Yx2h6z43b8e+PiXc4sePuFizj5TFAyXqFPGLTAdTXPz7n6d9+X0BMuvDkYIgvXk3gFGoCJHW5cbYcOihwvabGiv1w91wKxD3cBotdjs7Syiu1zv2z2awn1nNDbBfG/ai3XFpSJNu/v99/NUIr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGoaseOLOTBBKU71cinrmDHmBLJIVMsgQKrQ4bcmKpY=;
 b=SkQ5Lx710qH3QpmvNVEt4wc6gUFvlGGv//BUmBVNkfeDRR6SjZKisxa82uZ3q6JIf++/V6k4ir3t5pBFimelgy6rXqNQVgdDKxg+qdWpHDLjCK+zXwSrdLYa6zUoROlzIShte+GyWnpw45mKz87tV0bHq9g5fEYgVLX0DSCGfxI=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3430.namprd12.prod.outlook.com (20.178.196.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Tue, 14 Jan 2020 21:36:15 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 21:36:15 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic
 __strnlen_user/__strncpy_from_user
Thread-Topic: [RFC 4/4] ARC: uaccess: use optimized generic
 __strnlen_user/__strncpy_from_user
Thread-Index: AQHVyxaGhnH3EiIrPUWW/UkFermp56fqoAiAgAAPFIA=
Date:   Tue, 14 Jan 2020 21:36:15 +0000
Message-ID: <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
In-Reply-To: <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 3419362c-b51a-4387-4f40-08d79939c866
x-ms-traffictypediagnostic: BYAPR12MB3430:
x-microsoft-antispam-prvs: <BYAPR12MB3430CF0F3406F0D49271B0EAB6340@BYAPR12MB3430.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(8676002)(66476007)(6486002)(7416002)(2616005)(71200400001)(66946007)(76116006)(54906003)(5660300002)(31696002)(66556008)(81156014)(81166006)(6512007)(8936002)(186003)(26005)(36756003)(2906002)(316002)(4326008)(64756008)(86362001)(478600001)(66446008)(31686004)(6506007)(53546011)(6916009)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3430;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LW3UdTWTvpqCLl0N1wxyBABjXzu9YFCveJM6ewNBb4BBc2aG8HEiy72thzsPL9chl69rVhl6KjrFQpwBvzQuTVuR6afgH2IqSuLz6pPeHnsF4bzdA92UhorXfkK8QIrE6eGje3IDJCMBhls//csxaHF15EcB5PMuYsyJTKra80mbNOLHS5I8Kyf9huY1aZQ5AkwH4FssREWbDZSQOWNi1JxBvRC0T+2ItrOaBO980FtNqNTfr7BgmdWhjVnEav2xiCRHAdH7ICCGZ97UOWEI3ylRiC7E73dwZyaMkfqyBAVKXUTGwpej1tQvfPQpx5IsWh9FxhwJ6+BHD4D7I9PHoav8AwX9vZG9ooZaB5mqEKi4AhtK00rKiGohfwHmgn5LeRammi9047JFSCBz/3GSscD95qKBMQYknLS5Iyb/lFEaIaBPH8ClEbURqR6vmGl+1EoeEfymkmnjrMb8CPxyxC91rP/dHCmoI4wM7e+b6EjhaSSJ7GGdng4X7tR4cU5J
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F5200B14FC6254BA227563B1C09096A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3419362c-b51a-4387-4f40-08d79939c866
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 21:36:15.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRzidHlpCTjetmq7iX4h0uw9eJ6RP1gGYeJSrUFVw2u/+Lwm4+B7RIlrk5m0WwiW28T/iGtvehJvYQzOhji5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMS8xNC8yMCAxMjo0MiBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgOTowOCBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vd29y
ZC1hdC1hLXRpbWUuaCBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL3dvcmQtYXQtYS10aW1lLmgNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjAwZTkyYmU3MDk4
Nw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vd29yZC1h
dC1hLXRpbWUuaA0KPj4gQEAgLTAsMCArMSw0OSBAQA0KPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAy
MCBTeW5vcHN5cyBJbmMuDQo+PiArICovDQo+PiArI2lmbmRlZiBfX0FTTV9BUkNfV09SRF9BVF9B
X1RJTUVfSA0KPj4gKyNkZWZpbmUgX19BU01fQVJDX1dPUkRfQVRfQV9USU1FX0gNCj4+ICsNCj4+
ICsjaWZkZWYgX19MSVRUTEVfRU5ESUFOX18NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgva2Vy
bmVsLmg+DQo+PiArDQo+PiArc3RydWN0IHdvcmRfYXRfYV90aW1lIHsNCj4+ICsgICAgICAgY29u
c3QgdW5zaWduZWQgbG9uZyBvbmVfYml0cywgaGlnaF9iaXRzOw0KPj4gK307DQo+IA0KPiBXaGF0
J3Mgd3Jvbmcgd2l0aCB0aGUgZ2VuZXJpYyB2ZXJzaW9uIG9uIGxpdHRsZS1lbmRpYW4/IEFueQ0K
PiBjaGFuY2UgeW91IGNhbiBmaW5kIGEgd2F5IHRvIG1ha2UgaXQgd29yayBhcyB3ZWxsIGZvciB5
b3UgYXMNCj4gdGhpcyBjb3B5Pw0KDQpmaW5kX3plcm8oKSBieSBkZWZhdWx0IGRvZXNuJ3QgdXNl
IHBvcCBjb3VudCBpbnN0cnVjdGlvbnMuIEkgZGlkbid0IGxpa2UgdGhlIGNvcHkNCmVpdGhlciBi
dXQgd2Fzbid0IHN1cmUgb2YgdGhlIGJlc3Qgd2F5IHRvIG1ha2UgdGhpcyA0IEFQSSBpbnRlcmZh
Y2UgcmV1c2FibGUuIEFyZQ0KeW91IHN1Z2dlc3Rpbmcgd2UgYWxsb3cgcGFydGlhbCBvdmVyLXJp
ZGUgc3RhcnRpbmcgd2l0aCAjaWZuZGVmIGZpbmRfemVybyA/DQoNCj4+ICtzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGxvbmcgZmluZF96ZXJvKHVuc2lnbmVkIGxvbmcgbWFzaykNCj4+ICt7DQo+PiAr
I2lmZGVmIENPTkZJR182NEJJVA0KPj4gKyAgICAgICByZXR1cm4gZmxzNjQobWFzaykgPj4gMzsN
Cj4+ICsjZWxzZQ0KPj4gKyAgICAgICByZXR1cm4gZmxzKG1hc2spID4+IDM7DQo+PiArI2VuZGlm
DQo+IA0KPiBUaGUgQ09ORklHXzY0QklUIGNoZWNrIG5vdCBiZSBuZWVkZWQsIHVubGVzcyB5b3Ug
YXJlIGFkZGluZw0KPiBzdXBwb3J0IGZvciA2NC1iaXQgQVJDIHJlYWxseSBzb29uLg0KDQo6LSkg
SW5kZWVkIHRoYXQgd2FzIHRoZSBwcmVtaXNlICENCg0KVGh4IGZvciB0aGUgcXVpY2sgcmV2aWV3
Lg0KDQotVmluZWV0DQo=
