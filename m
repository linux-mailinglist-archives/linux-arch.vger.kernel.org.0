Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D093918D5AB
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTRWV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 13:22:21 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:18817
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbgCTRWU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 13:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5ziMGbtFepxslExpUcQwmJbJ4M/N8rpft6LL5v5lejOzbat1dZ6Isls1DPtMNTx7bkqaHK0UG2Jy3i/Qb4FyGtQs2eAbbBiVgK1lTXooTOPJ3OPDeo3/NeeangLvCRQFCt4rGTBCYZVKU5S/4OyAFaHfjjcwewYBKpJrccxlFkw2GpSCgUXTsWUByX5d0v/ZR8XZOdtmZYi+1Z+cDaWbiJJJ473aW4OZkVR977rxXlZgE274AEmkIZVJ9gtCEZEnZFyul63DonJQG+BqfECPBz4PQwJMDJD2L/aj9LG4sxVyNuQdm3H+FjRCa8EUuVQlOTLaJgflNTwisUXNyzL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4252JX0+KpIkSNxL4cgOQW9Kyf9lUpxRX/bHw+/4OX0=;
 b=hJSVr1Mam5Mc4zdYl+rCTTnb9KaQZYsl5YmzHkk17okOxeT/vcYRxFIYofF0SQJ0K7MmIwxNpmHe/LJ/y0EefMJy8cPwz0lt8ge9SBSrbadLyCXIDbsPq6YnoEa5d9kkVzNeuXwkScEism4Xk7y2xoEj5cSjQ8ZH8+S7Tz5UaETka1nj/qbpoi8QfAWPRISQjjqXruv57PnYqza3GEylxVFQHY6rkS6s2mxgj5yURddT27uaAbTjT63CNkB9dxvK4rd8T2XHW3WbqgNVz4Dc5aSP8voFgro8wFGTujEHoE7wprxnKzVqjIliPhFBHsDc7U+YcImvZac9xxs4MNSZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4252JX0+KpIkSNxL4cgOQW9Kyf9lUpxRX/bHw+/4OX0=;
 b=h7nGFldSkKp+lv/H37Bp4pCPUy1uyCcsRhiobM0G9c3AmH7g7CDSd4jy8zt9m/GZLEXrXMTE+4rgnBGvhp2ugV7b8mM/qU5u6Ad1vHh0kTaTYAoJpx0J72SaJAG3/uxsZRE/RtNsnf9hbWbLMsp/ir61edO1gUq7M7YxlP6uhCU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1002.namprd21.prod.outlook.com (2603:10b6:302:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.2; Fri, 20 Mar
 2020 17:22:16 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.012; Fri, 20 Mar 2020
 17:22:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Thread-Topic: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Thread-Index: AQHV+hZH2sSK6TnWLUqKIqZdhn3BQ6hK4/SAgAACOwCAAACGAIACfgqwgAC+cYCAAlRDsIABPYUAgAAOQwA=
Date:   Fri, 20 Mar 2020 17:22:16 +0000
Message-ID: <MW2PR2101MB10521A71057BDEEDF2BB4F23D7F50@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
 <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
 <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
In-Reply-To: <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-20T17:22:13.9185970Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ba56700-64ff-4d20-868d-5319aa9c83e1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f3dd840-015b-49f6-ac53-08d7ccf33caf
x-ms-traffictypediagnostic: MW2PR2101MB1002:|MW2PR2101MB1002:|MW2PR2101MB1002:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10022F73E9FA53370F842E01D7F50@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(478600001)(81166006)(7416002)(76116006)(54906003)(81156014)(9686003)(55016002)(66446008)(10290500003)(66476007)(33656002)(66946007)(66556008)(64756008)(8676002)(8936002)(6916009)(53546011)(86362001)(71200400001)(186003)(6506007)(2906002)(52536014)(5660300002)(8990500004)(4326008)(26005)(7696005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1002;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7cmKdzQKYlypkbgpMmdB/KqOiE4l+J6xFJNZVXpyWJQHXU53T4eki0pIDdRHTnbWSnh1Gdv1tijG4wPk4xrmrkzVGYJeXsE6nWeB5okssL6JjztVvd65EAfWevIZThYBtuwfVWV+4J01Nz+YRLJgwyEEiGqDQDR1S2PP5QU2t/oP7qF0YzyLmsjCmOzp2E7781XUFPqbCZwSJ4RkKeUKQajpuN+BHirJrD7PIqWTvIcXCTx2xyDbC72g37lOlKXYiFPKIrVM8vRCKZjgEDIj/jqiQR9EklKpikSUM1J+Nbm0qIG/dkanaQmKgFK89PT+km89ZJeOsf3I0yoFrAVMye13TGWaxox1bJVNGJ11JYuRmdmSQphE0g4x/QM/PR7tNPJ10Ql52OR5JSXA3DxbFPo1bE76c/7IvLMdzzTXHvjQB/csxLOBktcvOD7VDSj
x-ms-exchange-antispam-messagedata: nIjl6UoV4iUAHAt7IbBcJpJDrMSxNXyEGk1FB1YUQJe0LZQ74ci12DbInsH8lRyYDPTdapXS6UpfOgvdEai0S6gqWOvSiwiZicmtNIPY7+3ERzCXFhBtM9s9rHWVGHJR0yPq+UDLgAENxsWQMHViig==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3dd840-015b-49f6-ac53-08d7ccf33caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 17:22:16.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3nxu0DuCdm75uABAe629t/dfDf+EidhXRwLPj6y6OAI9rTURajy64T1VspeWb8XcLES24Ktq2YUlvMD4PGGql2MXcrNrmwNixmbECv4z/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogRnJpZGF5LCBNYXJjaCAy
MCwgMjAyMCA5OjI4IEFNDQo+IA0KPiBPbiBUaHUsIE1hciAxOSwgMjAyMCBhdCAxMDo0MyBQTSBN
aWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4gRnJvbTog
QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxOCwg
MjAyMCAyOjU4IEFNDQo+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAxOjE1IEFNIE1pY2hh
ZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiA+IE15IHBvaW50
IHdhcyB0byBrZWVwIHRoZSBmdW5jdGlvbnMgYnV0IHVzZSBhbGxvY19wYWdlcygpIGludGVybmFs
bHksDQo+ID4gPiBzbyB5b3UgY2FuIGRlYWwgd2l0aCB0aGUgaHlwZXJ2aXNvciBoYXZpbmcgYSBs
YXJnZXIgcGFnZSBzaXplIHRoYW4NCj4gPiA+IHRoZSBndWVzdCwgd2hpY2ggc2VlbXMgdG8gYmUg
YSBtb3JlIGltcG9ydGFudCBzY2VuYXJpbyBpZiBJIGNvcnJlY3RseQ0KPiA+ID4gdW5kZXJzdGFu
ZCB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUgd2F5IFdpbmRvd3MgYW5kIExpbnV4DQo+ID4g
PiBkZWFsIHdpdGggcGFnZSBjYWNoZS4NCj4gPg0KPiA+IE9LLCBJIHNlZSBub3cgd2hhdCB5b3Ug
YXJlIGdldHRpbmcgYXQuICBJIHNob3VsZCBzcGVsbCBvdXQgbXkNCj4gPiBhc3N1bXB0aW9uLCB3
aGljaCBpcyB0aGUgb3Bwb3NpdGUuICBIeXBlci1WIHdvbid0IGhhdmUgYSBwYWdlDQo+ID4gc2l6
ZSBvdGhlciB0aGFuIDRLIGFueXRpbWUgaW4gdGhlIGZvcmVzZWVhYmxlIGZ1dHVyZS4gIFRoZQ0K
PiA+IGNvZGUgaXMgdG9vIHdlZGRlZCB0byB0aGUgeDg2IDRLIHBhZ2Ugc2l6ZSwgYW5kIHRoZSBo
b3N0LWd1ZXN0DQo+ID4gaW50ZXJmYWNlcyBoYXZlIGEgbG90IG9mIGltcGxpY2l0IGFzc3VtcHRp
b25zIHRoYXQgdGhlIHBhZ2Ugc2l6ZSBpcw0KPiA+IDRLICh1bmZvcnR1bmF0ZWx5KS4gIEJ1dCB0
aGUgbGFzdCB0aW1lIEkgbG9va2VkLCBSSEVMIGZvciBBUk02NCBpcw0KPiA+IGRlbGl2ZXJlZCB3
aXRoIGEgNjRLIHBhZ2Ugc2l6ZS4gIFNvIG15IGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgb25seQ0K
PiA+IGNvbWJpbmF0aW9uIHRoYXQgcmVhbGx5IG1hdHRlcnMgaXMgdGhlIGd1ZXN0IHBhZ2Ugc2l6
ZSBiZWluZyBsYXJnZXINCj4gPiB0aGFuIHRoZSBIeXBlci1WIHBhZ2Ugc2l6ZS4gIFRoZSBvdGhl
ciB3YXkgYXJvdW5kIGp1c3Qgd29uJ3QNCj4gPiBoYXBwZW4gd2l0aG91dCBhIG1ham9yIG92ZXJo
YXVsIHRvIEh5cGVyLVYsIGluY2x1ZGluZyBhIHJld29yaw0KPiA+IG9mIHRoZSBndWVzdC1ob3N0
IGludGVyZmFjZS4NCj4gDQo+IE9rLCBnb3QgaXQuIFdlIHNob3VsZCByZWFsbHkgYXNrIFJlZCBI
YXQgdG8gY2hhbmdlIHRoZSBwYWdlIHNpemUsDQo+IGJ1dCBhcyBsb25nIGFzIHlvdSBjYXJlIGV4
aXN0aW5nIHN5c3RlbXMsIGFuZCB5b3UgZXhwZWN0IHRoaXMgdG8NCj4gcmVzdWx0IGluIGdpZ2Fi
eXRlcyBvZiBhbGxvY2F0aW9uIG9uIGZ1dHVyZSBzeXN0ZW1zLCBoYXZpbmcgdGhlDQo+IHdyYXBw
ZXIgc2VlbXMgcmVhc29uYWJsZS4NCj4gDQo+IE1heWJlIHlvdSBjb3VsZCBmYWxsIGJhY2sgdG8g
YWxsb2NfcGFnZSB3aGVuIFBBR0VfU0laRSBlcXVhbHMNCj4gSFZfSFlQX1BBR0VfU0laRSB0aG91
Z2g/IEknbSBub3Qgc3VyZSB3aGF0IHRoZSB0cmFkZW9mZg0KPiBiZXR3ZWVuIGttYWxsb2MgYW5k
IGFsbG9jX3BhZ2UgaXMgdGhlc2UgZGF5cywgb3RoZXIgdGhhbiB0aGUNCj4gZmVlbGluZyB0aGF0
IGFsbG9jX3BhZ2UgaXMgdGhlIG1vcmUgb2J2aW91cyBjaG9pY2Ugd2hlbiB5b3Uga25vdw0KPiB5
b3UgYWx3YXlzIHdhbnQgZXhhY3RseSBhIHBhZ2UgaGVyZS4NCj4gDQoNClllcywgdGhhdCB3b3Jr
cyBmb3IgbWUuDQoNCk1pY2hhZWwNCg0KDQo=
