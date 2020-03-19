Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9518C281
	for <lists+linux-arch@lfdr.de>; Thu, 19 Mar 2020 22:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgCSVqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Mar 2020 17:46:36 -0400
Received: from mail-dm6nam11on2123.outbound.protection.outlook.com ([40.107.223.123]:46176
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCSVqf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 17:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfCw9ZmO9cxS+ugiJEUvEtjqWXkLJoVhQIHsdhe7ejUqt6ijkzxfEgkqHUAssBOo8ZzwmfH8adF3beb6rFR0aSoS9bxryVpsM9Jp6iam1DMFYilCo5L2yPIFmnokxUzAkxB/T8p+/v0bSpBHhiG4s0GWiU3vgA14ukIMp6KMvdISKx/RFLfOOjHKvl4pwbhimiLuT/OlWCcPb7oizy7Wpv3bUfxRQA0SC4SzjWUOOEbcMxCppQE7dPhrq8oRdIaJMK96xChQhjk5BV8wN7cfsnIaqOZIE7KPiUVoEZZkEqtRIFxp4yuW4oBUFZ/639ogI7QxVCGYq3z7ogVwxHZapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGZFDQK0x2TthHuOrUz3Dusb/U9OWH3OvKmgQmwLTnE=;
 b=VxiN+Ziry1spuVn+m/zOn/YmWxYVakLuGYQheemHGyM0D9eaASDzSUJjgZMv9ZX/LAlMrPw0K6UKT3ho0yIyFdxNymuYIXGNqJvtfZwWToQPxLzxGySTIUlUlpsJa1sevYaq9ZU/VtyIeD0Pb9yizcaiMEUkieU/8mbamYKVyzLVu+vYHMhd4bAj3q3rAmLyvHVOlfN7UecslMpChEwAOh5kWT5S/fnUXNWZ+gI1H3GStBcIcrNMAS+f4FQfk47pF/L3eX+tzVZf+XI9Kq4ECNaXxn5aeOul6c2tdvDKYyarHNg48UEd1G7GoqDhXMw090fMeuYcKrc/J6REUfC4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGZFDQK0x2TthHuOrUz3Dusb/U9OWH3OvKmgQmwLTnE=;
 b=OnYycY2cp1HPXZRazPrxFh1mOTsDnJSXZ0iUMVAat9y698OBdmCajdSqFbG8N994DIAtpeAQwZALvapmWhi5ElnDBPvz4c0FiwJy1g88TTIXV8ZVHvSK5X0M21aceUW0TSI+eGZtsCSuevGfPCgbCU0kDIf1CnA78+rPcOxrBtg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1002.namprd21.prod.outlook.com (2603:10b6:302:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.2; Thu, 19 Mar
 2020 21:46:31 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 21:46:31 +0000
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
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 09/10] arm64: efi: Export screen_info
Thread-Topic: [PATCH v6 09/10] arm64: efi: Export screen_info
Thread-Index: AQHV+hZM60S+LKGqSUO5qXQSEIBQyahK416AgAKQkECAAKacAIACYGNw
Date:   Thu, 19 Mar 2020 21:46:30 +0000
Message-ID: <MW2PR2101MB1052E413218D295EF24E5E05D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
 <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T21:46:28.6393005Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1aef6bc-6f76-4372-a95f-2f5410092062;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88dd4c6e-b82e-4804-5377-08d7cc4efc6b
x-ms-traffictypediagnostic: MW2PR2101MB1002:|MW2PR2101MB1002:|MW2PR2101MB1002:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB100230876759C2A56EA5B5AED7F40@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(478600001)(81166006)(10290500003)(9686003)(76116006)(54906003)(55016002)(81156014)(66446008)(33656002)(66946007)(7416002)(66556008)(66476007)(64756008)(8676002)(8936002)(6916009)(26005)(53546011)(7696005)(186003)(6506007)(71200400001)(2906002)(5660300002)(52536014)(8990500004)(86362001)(316002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1002;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUM9vSPrPgIGmimBtitJzzIZoI9/+wKTz2Zxh2V7Al/xXBgGGftKYCdeRRUvr2On99gLeb0edSUEwMdNhd7fcJ82X2o+dZQE2pl3haGS5XpnwYrj/y9xtjjkg4XuSkHHV7uTVI/LIzt2iW9sW92ZQYTzcRdzA+RAMRGE98i3me/QCz8sq04boUfXfzWKtoYLlgzJs9J/W/TcjJKXQ39Iri9cj+mB3eI4mqdUFYCMqqFOeoxGBKRdQjPVrzITlTMCBx91damvnkZBICi34F4zK40Ov6rp8NdAldnHWnxlDuM3bb9dPjxXX9QffQZhpHWv6z5nr65Dou3KlZnJRzkZTEF7eUItM460INRMgrYNiq3Tf0ILCKMDAoL5ErxfEqwzPgoDFjpo0RKAlIQON8wQR23lBmrwnObK/R0OsQ4fg0Y5qLg0HYn/k1ddmyTomGn4
x-ms-exchange-antispam-messagedata: w+KyCdwA5hDK+9GQekTuLmxBsHXXZYZsrS0+/BAv9iiqXWDA73uKmYRfHX5gkIu/THjheE55zqjo/0YtKIVWLOEwpHZbEQStR9v2jrv/o3rraDGDkWcNUSxSwJJXrcq8Fa4k02BEeTrWafNYRWCAaA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dd4c6e-b82e-4804-5377-08d7cc4efc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 21:46:30.9752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBggJ0tCyhhShH51osoGYn5xMAEd7+JD5W4m53hXsyprEgMVKSLtLTWNGJfTavQp1K026Ie1Si9lkM0BLkFYZw9jo4AoRVkGAHNBFMxa4Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxOCwgMjAyMCAyOjI3IEFNDQo+IA0KPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAxOjE4IEFN
IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiBGcm9t
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+ID4gT24gU2F0LCBNYXIgMTQsIDIw
MjAgYXQgNDozNiBQTSBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBIeXBlci1WIGZyYW1lIGJ1ZmZlciBkcml2ZXIgbWF5
IGJlIGJ1aWx0IGFzIGEgbW9kdWxlLCBhbmQNCj4gPiA+ID4gaXQgbmVlZHMgYWNjZXNzIHRvIHNj
cmVlbl9pbmZvLiBTbyBleHBvcnQgc2NyZWVuX2luZm8uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+ID4N
Cj4gPiA+IElzIHRoZXJlIGFueSBjaGFuY2Ugb2YgdXNpbmcgYSBtb3JlIG1vZGVybiBLTVMgYmFz
ZWQgZHJpdmVyIGZvciB0aGUgc2NyZWVuDQo+ID4gPiB0aGFuIHRoZSBvbGQgZmJkZXYgc3Vic3lz
dGVtPyBJIGhhZCBob3BlZCB0byBvbmUgZGF5IGNvbXBsZXRlbHkgcmVtb3ZlDQo+ID4gPiBzdXBw
b3J0IGZvciB0aGUgb2xkIENPTkZJR19WSURFT19GQkRFViBhbmQgc2NyZWVuX2luZm8gZnJvbSBt
b2Rlcm4NCj4gPiA+IGFyY2hpdGVjdHVyZXMuDQo+ID4gPg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQg
aHlwZXJ2X2ZiLmMgZHJpdmVyIGlzIGFsbCB3ZSBoYXZlIHRvZGF5IGZvciB0aGUgc3ludGhldGlj
IEh5cGVyLVYNCj4gPiBmcmFtZSBidWZmZXIgZGV2aWNlLiAgVGhhdCBkcml2ZXIgYnVpbGRzIGFu
ZCBydW5zIG9uIGJvdGggQVJNNjQgYW5kIHg4Ni4NCj4gPg0KPiA+IEknbSBub3Qga25vd2xlZGdl
YWJsZSBhYm91dCB2aWRlby9ncmFwaGljcyBkcml2ZXJzLCBidXQgd2hlbiB5b3UNCj4gPiBzYXkg
ImEgbW9yZSBtb2Rlcm4gS01TIGJhc2VkIGRyaXZlciIsIGFyZSB5b3UgbWVhbmluZyBvbmUgYmFz
ZWQgb24NCj4gPiBEUk0gJiBLTVM/ICBEb2VzIERSTSBtYWtlIHNlbnNlIGZvciBhICJkdW1iIiBm
cmFtZSBidWZmZXIgZGV2aWNlPw0KPiA+IEFyZSB0aGVyZSBhbnkgZHJpdmVycyB0aGF0IHdvdWxk
IGJlIGEgZ29vZCBwYXR0ZXJuIHRvIGxvb2sgYXQ/DQo+IA0KPiBJdCB1c2VkIHRvIGJlIGEgbG90
IGhhcmRlciB0byB3cml0ZSBhIERSTSBkcml2ZXIgY29tcGFyZWQgdG8gYW4gZmJkZXYNCj4gZHJp
dmVyLCBidXQgdGhpcyBoYXMgY2hhbmdlZCB0byB0aGUgb3Bwb3NpdGUgb3ZlciB0aGUgeWVhcnMu
DQo+IA0KPiBBIGZhaXJseSBtaW5pbWFsIGV4YW1wbGUgd291bGQgYmUgZHJpdmVycy9ncHUvZHJt
L3BsMTExL3BsMTExX2Rydi5jDQo+IG9yIGFueXRoaW5nIGluIGRyaXZlcnMvZ3B1L2RybS90aW55
LywgYnV0IHlvdSBtYXkgd2FudCB0byBsb29rIGF0IHRoZQ0KPiBvdGhlciBoeXBlcnZpc29yIHBs
YXRmb3JtcyBmaXJzdCwgaS5lIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuYywN
Cj4gZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmMsIGRyaXZlcnMvZ3B1L2RybS94
ZW4veGVuX2RybV9mcm9udC5jLA0KPiBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9kcnYuYywgYW5k
IGRyaXZlcnMvZ3B1L2RybS9ib2Nocy9ib2Noc19kcnYuYy4NCj4gDQoNClRoYW5rcyBmb3IgdGhl
IHBvaW50ZXJzLCBlc3BlY2lhbGx5IGZvciB0aGUgb3RoZXIgaHlwZXJ2aXNvcnMuDQoNCk1pY2hh
ZWwNCg==
