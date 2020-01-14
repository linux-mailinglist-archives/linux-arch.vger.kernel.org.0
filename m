Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8513B529
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 23:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgANWOl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 17:14:41 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:58544 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgANWOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 17:14:40 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9E100C00BF;
        Tue, 14 Jan 2020 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579040079; bh=kbkDR+FjHsooBwpisOHzZVcT4FgZLz9uPYQljdMvgok=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IU7t2Sb2LGvxqwj7VtIaVv/kchUBZ6eC90zbHic4SFivFs5yxuAdP+WljdTTT3DVo
         +IAgtoMbMm6DcCRuZdD/QsrxzIs0tyNG/JpsBv1f8SiHJcsBs/hKOE674WLe6asnkn
         xigrh/AMswh/ee2Yaa1ClubIw5Z8iDSaahA/mR7YBRQdmcu//KllP7Zp86GfwjzwYm
         C2juUtxBNclXHUsDjcfvVtk3zhqDxn213vv89OKO2OMLWsPm7r2g0lVNinfeM6TCT+
         R0E72pQbD5BT/icvfik5f5JWoCYSrVAkcZ2XIm5qBYFaIzdHHWpzxNK/FXdv0oB5Li
         m9pcIlPHh2yZA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DF832A008A;
        Tue, 14 Jan 2020 22:14:37 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Jan 2020 14:14:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 14 Jan 2020 14:14:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvVsocyMOdQbOlTgTl2ibA2fhWVFJNgDT7OQvezIqfWvUQj3INwfmagukqfGh3TniKSY7O2GFnVqtGA8c4dYcL22inEQJRtk7elJc0Wm6O8Kkn3fa0vFrVz/3lu9PMdbAOzGpiP0EViExBEfcXuhpgEdfzbmvW7rTEgEk9wwQgce2LkrAWof7XyMRapZ9NzGHtyMQxK2zpEl2sZE6rzQMfNHMzd0DBysqJGG9YfzcEj3asV6g4hht9apPB6cEuFJr7lL6bnKLYDymL87MZJfBax1QVGiwbaaRZYmrKwd/zIEma39c2XsXPcuqd2ECmtChLVFsCACAuWzNoS7EHwdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbkDR+FjHsooBwpisOHzZVcT4FgZLz9uPYQljdMvgok=;
 b=Rlp75e4AAiv+DakmXlRKLP7BgIZ09eCPiIJeZ2gxPhpXObdpUGmpNF3uoPjpm8e4cgM/SfGiqjhZP4gTHI+Bl1e0xJB5xwgXae1kJ7RWe1hwtSXjBFrbo2SvlzJixMg4h4diN4DoKX+wgNuhoe16QKB+WlvQ0U67Lw9KQAOLwsE1j0SB0HOBKLMzkwj/xpewUUNVlsTyHZ7jQKUldMbqtKnRg3UI3wTv1w+DLR6FOom7Plpp7v2zSoX8UskfOG/zuAGcMMQcDA7CFx3cOu2junQFaLF6C3g5qm2aaGfBncanrUsJ2u30YsCci2cLASrn/2ADEiJ4OZBPaG3KUDEpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbkDR+FjHsooBwpisOHzZVcT4FgZLz9uPYQljdMvgok=;
 b=f8cScqlM7hKmPzPJFxGR2X6YlTfgMjPiLAO+EtPInTY8HGrRMD4gZRmx7x532Lg4l9B53lRBncGtPWU18JDUTzSZUVZ06W5VRdfO9OpMAOYaSrl868F0LPQtn0zEtxz2psEel+hN9qKRcaJBzxFCXY7LnZW9AcY410ypTIFi3M8=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3367.namprd12.prod.outlook.com (20.178.53.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 22:14:31 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 22:14:31 +0000
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
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic
 __strnlen_user/__strncpy_from_user
Thread-Topic: [RFC 4/4] ARC: uaccess: use optimized generic
 __strnlen_user/__strncpy_from_user
Thread-Index: AQHVyxaGhnH3EiIrPUWW/UkFermp56fqoAiAgAAPFICAAAOWgIAABxwA
Date:   Tue, 14 Jan 2020 22:14:31 +0000
Message-ID: <67715aba-fa40-1f46-288d-391d086328ac@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
 <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
 <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
In-Reply-To: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: ac5bc04c-1279-4708-1953-08d7993f2152
x-ms-traffictypediagnostic: BYAPR12MB3367:
x-microsoft-antispam-prvs: <BYAPR12MB3367189505272C1437849906B6340@BYAPR12MB3367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(8936002)(186003)(2906002)(26005)(5660300002)(54906003)(76116006)(66946007)(8676002)(81166006)(81156014)(316002)(478600001)(6506007)(53546011)(71200400001)(66556008)(66446008)(64756008)(66476007)(7416002)(36756003)(4326008)(86362001)(6512007)(6486002)(6916009)(31696002)(2616005)(31686004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3367;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeCJUHPgn2uXPzNUXTrW0/a0Vyq1Hf6pOt5cbmWatgondr1SYU2lsr1SZ2aB/ZVFfpkL9iuFfMPEqR0CrohDvCyBYc6P9ZM00KmmnsUa9RwSiSHDXBCLknq4OQR0Jnrd7dDj1AvwBZk9zWgULfNpWuDUZFFigI7O+9qlRwbNevVUYtEHzSffx0+D/v4McuDgeTbZzifmxR0vkVgVh7GmWwsumoY9G1crRkL8AFTOPY4+KR4j++07V/s263JMwpaX8vh5R6aWeJCH1J7GwgL3lnSPhYCCfbqvIofN3Lc3C6a1vheXfj7KIoPiav2wklP9JjqW1RqRGxP2s8GpCiHfF45QyxVA+22Rs3n+5xsjpFWo+D6eaVgiBTbHvSekOobqRQ1IheURChLb+QKvmNbg6HQBoktdoDnNxKLL25Oq3NLd7SsGX/73zjjgnFwjFaH0wZcjz+Z2bi8GbVkNeCPGfAqmWzMHUiby6QRBvTuOvew=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <482E57B4610060459E6825AB481A2823@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5bc04c-1279-4708-1953-08d7993f2152
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 22:14:31.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyDi7hbG8IwIdfseSelsjBVTq9yQFBuPhWPDF9mhp2NU6EOll4FCsoeEs2o3W4IpwE0SARtDy6o9LdXdTVOjDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMS8xNC8yMCAxOjQ5IFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MTQsIDIwMjAgYXQgMTozNyBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4+DQo+PiBPbiAxLzE0LzIwIDEyOjQyIFBNLCBBcm5kIEJlcmdtYW5uIHdy
b3RlOg0KPj4+DQo+Pj4gV2hhdCdzIHdyb25nIHdpdGggdGhlIGdlbmVyaWMgdmVyc2lvbiBvbiBs
aXR0bGUtZW5kaWFuPyBBbnkNCj4+PiBjaGFuY2UgeW91IGNhbiBmaW5kIGEgd2F5IHRvIG1ha2Ug
aXQgd29yayBhcyB3ZWxsIGZvciB5b3UgYXMNCj4+PiB0aGlzIGNvcHk/DQo+Pg0KPj4gZmluZF96
ZXJvKCkgYnkgZGVmYXVsdCBkb2Vzbid0IHVzZSBwb3AgY291bnQgaW5zdHJ1Y3Rpb25zLg0KPiAN
Cj4gRG9uJ3QgeW91IHRoaW5rIHRoZSBnZW5lcmljIGZpbmRfemVybygpIGlzIGxpa2VseSBqdXN0
IGFzIGZhc3QgYXMgdGhlDQo+IHBvcCBjb3VudCBpbnN0cnVjdGlvbj8gT24gMzItYml0LCBJIHRo
aW5rIGl0J3MgbGlrZSBhIHNoaWZ0IGFuZCBhIG1hc2sNCj4gYW5kIGEgY291cGxlIG9mIGFkZGl0
aW9ucy4NCg0KWW91IGFyZSByaWdodCB0aGF0IGluIGdyYW5kIHNjaGVtZSB0aGluZ3MgaXQgbWF5
IGJlIGxlc3MgdGhhbiBub2lzZS4NCg0KQVJDIHBvcCBjb3VudCB2ZXJzaW9uDQoNCiMgCWJpdHMg
PSAoYml0cyAtIDEpICYgfmJpdHM7DQojICAJcmV0dXJuIGJpdHMgPj4gNzsNCg0KCXN1YiByMCxy
NiwxDQoJYmljIHI2LHIwLHI2DQoJbHNyIHIwLHI2LDcNCg0KIyAJcmV0dXJuIGZscyhtYXNrKSA+
PiAzOw0KDQoJZmxzLmYJcjAsIHIwDQoJYWRkLm56CXIwLCByMCwgMQ0KCWFzciByNSxyMCwzDQoN
CglqX3MuZCBbYmxpbmtdDQoNCkdlbmVyaWMgdmVyc2lvbg0KDQojIAliaXRzID0gKGJpdHMgLSAx
KSAmIH5iaXRzOw0KIyAgCXJldHVybiBiaXRzID4+IDc7DQoNCglzdWIgcjUscjYsMQ0KCWJpYyBy
NixyNSxyNg0KCWxzciByNSxyNiw3DQoNCiMgIAl1bnNpZ25lZCBsb25nIGEgPSAoMHgwZmYwMDAx
K21hc2spID4+IDIzOw0KIyAJcmV0dXJuIGEgJiBtYXNrOw0KDQoJYWRkIHIwLHI1LDB4MGZmMDAw
MQk8LS0gdGhpcyBpcyA4IGJ5dGUgaW5zdHJ1Y3Rpb24gdGhvdWdoDQoJbHNyX3MgcjAscjAsMjMN
CglhbmQgcjUscjUscjANCg0KCWpfcy5kIFtibGlua10NCg0KDQpCdXQgaXRzIHRoZSB1c3VhbCBp
dGNoL2luY2xpbmF0aW9uIG9mIGFyY2ggcGVvcGxlIHRvIHRyeSBhbmQgdXNlIHRoZSBzcGVjaWZp
Yw0KaW5zdHJ1Y3Rpb24gaWYgYXZhaWxhYmxlLg0KDQo+IA0KPiBUaGUgNjQtYml0IGNhc2UgaGFz
IGEgbXVsdGlwbHkgdGhhdCBpcyBsaWtlbHkgZXhwZW5zaXZlIHVubGVzcyB5b3UNCj4gaGF2ZSBh
IGdvb2QgbXVsdGlwbGljYXRpb24gdW5pdCAoYnV0IHdoYXQgNjQtYml0IGFyY2hpdGVjdHVyZQ0K
PiBkb2Vzbid0PyksIGJ1dCB0aGUgZ2VuZXJpYyAzMi1iaXQgTEUgY29kZSBzaG91bGQgYWxyZWFk
eSBiZSBwcmV0dHkNCj4gY2xvc2UgdG8gb3B0aW1hbCwgYW5kIGl0IG1pZ2h0IG5vdCBiZSB3b3J0
aCBpdCB0byB3b3JyeSBhYm91dCBpdC4NCj4gDQo+IChUaGUgYmlnLWVuZGlhbiBjYXNlIGlzIHZl
cnkgZGlmZmVyZW50LCBhbmQgYXJjaGl0ZWN0dXJlcyByZWFsbHkgY2FuDQo+IGRvIG11Y2ggYmV0
dGVyLiBCdXQgTEUgYWxsb3dzIGZvciBiaXQgdHJpY2tzIHVzaW5nIHRoZSBjYXJyeSBjaGFpbikN
Cg0KLVZpbmVldA0K
