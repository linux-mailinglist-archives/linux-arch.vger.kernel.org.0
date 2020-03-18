Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694FD1892C2
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCRASE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:18:04 -0400
Received: from mail-bn8nam12on2136.outbound.protection.outlook.com ([40.107.237.136]:2010
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbgCRASD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:18:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy77cvv+malbcyrxLEoi6e1E8b6buRGyGfjAuYd+h+TIxgrNwee6Szv0VjYTHZR8PjkJfXEpyLVP5pXogLvb9v5NnZyiHd1BtDPVcJbIQfnLavRTSLFma1MGUbUNWmmBYH7btj3c+N1Sedo9v8JHLoWvTxsCrIDAAh239fEK7H4z2BNN+wHRYlA1645S2r7teZNwhPKyMEuIewpHVOSwu9cyAigBjZCI8skq8h/i2s9qwOdLxIvT/UP4kIB7FoCEgExHeEXqDYhcijZKxFD5p+TD/aqmaZ5Tyb2+yEbYUf+ZavvVUt2rsorGiqIqAXVC/n1lBO/KvaQGqPxhd2RDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvHEQkwcYm+7QAi+r6uTyzhyE4KB2u8dQNEmo+rIuJ4=;
 b=DD9F737v8cztkscd6g07tHNLQli3PvwJN0d5kELC0jX4uwgwei82cs3BLxUBZCa8hGIbrR0YGoI1Wb8WNJyYyV5OcDFDNOYkowHl69qDF+nxu+oIRkkXM34iD91v0ueVhOzfmhdlX+lmeiNm0mST8/xLqeoMxPyHXaBGb576g4aILrfOZd70XJ6nHsOvSFwcN0gjfsra3xhzvuzweuGeTSc2gFaVB972Qn/oEmgJFbdRNoeq+q84fnpcfvGgFxcdMiqmf9pw4gAD2x6DQ3eS8T/3DfkkO5VwVn+5uum7HBpSLTs2yBmdjmiGzLF2v/WqKHhC4X9rYwsJ5pwxK3uMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvHEQkwcYm+7QAi+r6uTyzhyE4KB2u8dQNEmo+rIuJ4=;
 b=OYZA0aRrjyn1rh7oEzCHI0EGqX27Aa4MzesL/VgUDfHUmDWJKSaCvaC0hZCOE/k4/Z1af5bxt1K1MHIpz2S35qk7UvfZhlXMVoQtPZnBQrld47pbwr50Uli5o1hr26iYUcaSOuHC8l61WO2GD7PQBfy6QiFhfRAQ1OfnCmjklt8=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7; Wed, 18 Mar
 2020 00:17:59 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:17:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Andy Whitcroft <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHV+hZK6CjhbGAo+02bGeTm+6xNTahK5fEAgAKKHkA=
Date:   Wed, 18 Mar 2020 00:17:52 +0000
Message-ID: <MW2PR2101MB1052281E5B197F2AA8E4D622D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
 <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:17:50.1944546Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e59fc9d4-f8cd-4b2e-b09b-d342f5fdb9c4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f19328fd-92fd-4dfd-cb7c-08d7cad1cca8
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1082C6B1D3C2EB76541CF2A4D7F70@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(10290500003)(55016002)(478600001)(7696005)(5660300002)(9686003)(54906003)(2906002)(7416002)(8990500004)(53546011)(33656002)(52536014)(6506007)(6916009)(76116006)(71200400001)(186003)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(316002)(86362001)(81156014)(8936002)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGYh/1fvtv/YhUVqZSDkITewYYnL70MSNfknuutc4eKxdZefL+5fdp47Bs426dktVRnMG+g9qBET+icqrZBCZQ1ahBH0ZMp/LWkbRc/FdAy108IfyI6dZMqZO0ZiPhfYhJI4mxCp7CAnyCa/+wUs921zX0tZBuHerENpUSmAQrS14Jw+32BkYVZRCDgt0o966omD/xCBOI94XWNUrYLeuWXnPAcxwbdaYLuxSyqRvpCE6/UAMlY6YkMZT4Lmwbh2juP2Zi1HtTGi7o69KJZwyz5/DuI8fKi8hnnKgYEtRX6wPRcAIjBT8OYsOdOUe63lVNZext+nV7ZpGtb3EdgkLNtAvfGtTiuFOLL4YspMZs8dGSs+0XIWet0CNWYO0I8tuJX6hkS+N8wqLAl9dYqeSzcLOxNu9DoFG0PUzhnlGdK1PflSzk0IbUBuzp0xdsd1
x-ms-exchange-antispam-messagedata: IRDj5V1OO6EYvLyo5qAJSB6mabYxEga6awbmDCceQWmNf2CE370W6uSUozlRXZ5XFbR6nNksh5ly5dtl3SPaWj1L1Mr03nBfOIjB9HTha79o+0qoDZmTjXDUGav6pkvjEMQ1Ot6zohMamEUB57bpwg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19328fd-92fd-4dfd-cb7c-08d7cad1cca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:17:52.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RF5DN/C7txRqQhWX33fo8RFIKSg5W3I+vB5v6xC+VQz6CDdzPDxkOiaEz6NCkLINFbAapVv4m1fNpbDRku4H3cRZmnFr439HTQhhw2terDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBNYXJjaCAx
NiwgMjAyMCAxOjMwIEFNDQo+IA0KPiBPbiBTYXQsIE1hciAxNCwgMjAyMCBhdCA0OjM2IFBNIE1p
Y2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFk
ZCBBUk02NC1zcGVjaWZpYyBjb2RlIHRvIGluaXRpYWxpemUgdGhlIEh5cGVyLVYNCj4gPiBoeXBl
cnZpc29yIHdoZW4gYm9vdGluZyBhcyBhIGd1ZXN0IFZNLiBQcm92aWRlIGZ1bmN0aW9ucw0KPiA+
IGFuZCBkYXRhIHN0cnVjdHVyZXMgaW5kaWNhdGluZyBoeXBlcnZpc29yIHN0YXR1cyB0aGF0DQo+
ID4gYXJlIG5lZWRlZCBieSBWTWJ1cyBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIGNvZGUgaXMgYnVp
bHQgb25seSB3aGVuIENPTkZJR19IWVBFUlYgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBhcmNoL2FybTY0L2h5cGVydi9odl9jb3JlLmMgfCAxNTYNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gDQo+IEFzIHlvdSBhcmUgZWZmZWN0aXZl
bHkgYWRkaW5nIGEgbmV3IGNsb2Nrc291cmNlIGRyaXZlciBoZXJlLCBwbGVhc2UgbW92ZSB0aGUN
Cj4gY29kZSB0byBkcml2ZXJzL2Nsb2Nrc291cmNlIGFuZCBzZW5kIHRoZSBwYXRjaCB0byB0aGUg
cmVzcGVjdGl2ZSBtYWludGFpbmVycw0KPiAoYWRkZWQgdG8gQ2MgaGVyZSksIHNwbGl0dGluZyBp
dCBvdXQgZnJvbSB0aGUgcmVzdCBvZiB0aGUgcGF0Y2guDQo+IA0KPiBZb3Ugc2hvdWxkIGFsc28g
ZGVzY3JpYmUgd2h5IHlvdXIgcGxhdGZvcm0gZG9lc24ndCBqdXN0IHVzZSB0aGUgbm9ybWFsDQo+
IGFyY2hpdGVjdGVkIHRpbWVyIGludGVyZmFjZS4NCj4gDQo+ID4gK1RJTUVSX0FDUElfREVDTEFS
RShoeXBlcnYsIEFDUElfU0lHX0dURFQsIGh5cGVydl9pbml0KTsNCj4gDQo+IFRoaXMgbG9va3Mg
bGlrZSBpdCByZWdpc3RlcnMgYSBkcml2ZXIgZm9yIHRoZSBzYW1lIGRldmljZSBhcyB0aGUgbm9y
bWFsDQo+IGFyY2ggdGltZXIuIFdvbid0IHRoYXQgY2xhc2g/DQo+IA0KPiAgICAgIEFybmQNCg0K
VGhlcmUgaXMgYSBIeXBlci1WIGNsb2Nrc291cmNlIGRyaXZlciBpbiBkcml2ZXJzL2Nsb2Nrc291
cmNlL2h5cGVydl90aW1lci5jLg0KSXQgaXMgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IGFuZCB3
b3JrcyBmb3IgYm90aCB4ODYgYW5kIEFSTTY0Lg0KDQpUaGUgcmVxdWlyZW1lbnQgaGVyZSBpcyBy
ZWFsbHkgZm9yIGEgcGxhY2UgdG8gaGFuZyB0aGUgZ2VuZXJhbCBIeXBlci1WDQppbml0aWFsaXph
dGlvbiBjb2RlLiAgIE9uIHRoZSB4ODYgc2lkZSwgdGhlcmUncyBpbmZyYXN0cnVjdHVyZSBhbHJl
YWR5IGluIHBsYWNlDQp0byBkbyBoeXBlcnZpc29yIGluaXRpYWxpemF0aW9uLCBidXQgbm90aGlu
ZyBjb3JyZXNwb25kaW5nIG9uIHRoZSBBUk02NCBzaWRlLg0KVGhlIFRJTUVSX0FDUElfREVDTEFS
RSBob29rIGlzIGFkbWl0dGVkbHkgYSB0ZW1wb3JhcnkgYXBwcm9hY2gsIGFuZCBJJ20NCmhhcHB5
IHRvIGhlYXIgaWYgc29tZW9uZSBoYXMgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGlzLg0KDQpG
V0lXLCBIeXBlci1WIGRvZXNuJ3QgY3VycmVudGx5IHZpcnR1YWxpemUgdGhlIEFSTSBhcmNoIGNv
dW50ZXIvdGltZXIgZm9yDQpndWVzdCBWTXMuICBUaGUgSHlwZXItViBzeW50aGV0aWMgY291bnRl
ci90aW1lciBpbiB0aGUgSHlwZXItViBjbG9ja3NvdXJjZQ0KZHJpdmVyIGlzIHVzZWQgb24gYm90
aCBBUk02NCBhbmQgeDg2LiAgQnV0IHRoaXMgSHlwZXItViBpbml0IGNvZGUgZG9lc24ndCBhY3R1
YWxseQ0KdG91Y2ggdGhlIEdURFQgZGV2aWNlLCBzbyBpdCB3b24ndCBpbnRlcmZlcmUgd2l0aCB0
aGUgQVJNIGFyY2ggY291bnRlci90aW1lcg0Kd2hlbiBhIGZ1dHVyZSBIeXBlci1WIHZlcnNpb24g
ZG9lcyB2aXJ0dWFsaXplIGl0Lg0KDQpNaWNoYWVsDQo=
