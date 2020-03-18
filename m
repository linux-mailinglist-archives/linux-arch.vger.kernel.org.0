Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E52189288
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCRAPb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:15:31 -0400
Received: from mail-eopbgr770131.outbound.protection.outlook.com ([40.107.77.131]:12509
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgCRAPb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:15:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR+yVp63qtsbOyn4oC8iHCftYI7XHz5PGlbX8CNchP1a62J4jHbr1iBkbYjXRhg9LnqRI0kKTyD7Dg8+/sFHLuf1gcC7ime31HOISKoD49RKhgoWj6FvgTphhk0EzrlEUKwj0TzE7NDUU8Eh1+5X8pw5r3Ny/r26Fctt5xmLO3ljlSHpe11nJByG1bF0AnJyu9LvNWig+3bxDbAkoNahm8dlwZ0SOHF565S7Dyt8uZr80kH/R8zSPMAmOy7s5iyEo/wj9PcfsCqerg6PmaqR+VCNix2L2hfNqbePj/eqve3Wodbb9pwmCaaysCzRd1gyS3xGVDeDUTOETYLvJHsGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auibOauM2Qn9g5DqMGQVNaGcTpC/wJKDvXbpt9ctv4U=;
 b=V+g0rrq4o0px9JrPE+mIZTcM+wr1DljbUPHGqgci848iQknbD7H0GJmDkqAIluFT75I0KC80U04zJKNotwGPv7GhDw1q3EfRmbRCW+fv4P9mpHxcIxUVapgGSnq3tOnyF9RqqOgKYn40XTM4Qhu29Sh/fUIk+qp5nyzXbQjbyjw3Tv1MM8lxtpP65iO0Yq2gBsfA1Q8QVNGMssBQHihKdwBNO0Gis2ULEsXPH7U+HU4+eGNeBmgh2p4W3yu3EAPwd0FQLogn/3ArVLZkCj5lAfpnDUcpWa3KyQ5eRRk8opU7bDo2ErW/Wbw4QkTIozeUyzQFhiZR1b2oLD7bv/UH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auibOauM2Qn9g5DqMGQVNaGcTpC/wJKDvXbpt9ctv4U=;
 b=i2SkoqA/81h0idpfH5d1PRo6NzuNdF6zX2bZ2HY/lhXwCPtmXl3fBs93kMThmH2lD3ZsgDROV++QkkNVz5Qq0rfGQ/7pMOyc8FjfK/uItjLfhd9K+IaiMYJcXxE4/VaTykNtz5g16up2VvgzNK/70Gerc1r3jNJIFBOpXcoglcg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7; Wed, 18 Mar
 2020 00:15:25 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:15:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>
CC:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
Thread-Index: AQHV+hZH2sSK6TnWLUqKIqZdhn3BQ6hK4/SAgAACOwCAAACGAIACfgqw
Date:   Wed, 18 Mar 2020 00:15:25 +0000
Message-ID: <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
 <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
In-Reply-To: <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:15:22.5925385Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fde423f0-26dd-42cf-838f-65f5cddd7301;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbf53d61-1c2b-46bf-0849-08d7cad174d3
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10827704F4662B46AC3378C6D7F70@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(10290500003)(55016002)(478600001)(7696005)(5660300002)(9686003)(110136005)(54906003)(2906002)(7416002)(8990500004)(53546011)(33656002)(52536014)(6506007)(76116006)(71200400001)(186003)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(316002)(86362001)(81156014)(8936002)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goHjzolk1403oOapaLy7gmxffuRlCdBEF92SHRi2H3uehK7J3Q0RjubPrpw9hnUC9VTC4Lzqmn3TuscsW7m+0hXCKirsMUByx2zDpiym+UZ+T9Hz+Kn04fRYaZJqLF4HawJ8P5S52Swmdl7aNFAMDdCS34Td8aPjGOy5Jo15VVzmKT4XO6EMNwzoczaw+f/yWBvNoaQfP3eec6VoZrj47wkvsNdPMMhIFP7jbxxj0W4gLg0clheaEjqJ1jUwr1EirAPvJ5c3eIlMpnImuYuHZbu6SSI+mcmpd3X+hJnCzulNz/DPKRQa7Akhvt81jFVq/PlLfSuDJlmCrgG/kHrnHVzeXuxbyxbn7KSPc5jQTQk2DDZqtp2FwKvIMtnKa0E6LM5qM7XdcwuhUuGixNxX7vqn1oA0g3p9dip/pxM2AKIv7ae4ZoDk2l3eHpGb0n4q
x-ms-exchange-antispam-messagedata: ZmExURiXqasFD7guooSsdyMOof40Vw/EegP4o3uQqyRUD7Z8UkKZ0HC2UYnCwt7SUwvEShu+q04uFn6AE4g2lS1RLeshn3hC4RtFoWIjltdbIZKnh6JEva0iROQq6OuhGNHdIRuZcJ/n8HuvAsH+Gg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf53d61-1c2b-46bf-0849-08d7cad174d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:15:25.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVPG3c2NE55mUbtqNHoS0CoQgV2RezuE0xNrJ3dNdjW6L2yqiaOCaVuFWozEck9Zq2mrfhRoDQQYb5wROa0Ty9QkZ7CyOPouuJZ20Qskp4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBNYXJjaCAx
NiwgMjAyMCAxOjMzIEFNDQo+IA0KPiBPbiBNb24sIE1hciAxNiwgMjAyMCBhdCA5OjMwIEFNIE1h
cmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+IE9uIDIwMjAtMDMtMTYgMDg6
MjIsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+ID4gPiBPbiBTYXQsIE1hciAxNCwgMjAyMCBhdCA0
OjM2IFBNIE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gd3Jv
dGU6DQo+ID4gPj4gIC8qDQo+ID4gPj4gKyAqIEZ1bmN0aW9ucyBmb3IgYWxsb2NhdGluZyBhbmQg
ZnJlZWluZyBtZW1vcnkgd2l0aCBzaXplIGFuZA0KPiA+ID4+ICsgKiBhbGlnbm1lbnQgSFZfSFlQ
X1BBR0VfU0laRS4gVGhlc2UgZnVuY3Rpb25zIGFyZSBuZWVkZWQgYmVjYXVzZQ0KPiA+ID4+ICsg
KiB0aGUgZ3Vlc3QgcGFnZSBzaXplIG1heSBub3QgYmUgdGhlIHNhbWUgYXMgdGhlIEh5cGVyLVYg
cGFnZQ0KPiA+ID4+ICsgKiBzaXplLiBXZSBkZXBlbmQgdXBvbiBrbWFsbG9jKCkgYWxpZ25pbmcg
cG93ZXItb2YtdHdvIHNpemUNCj4gPiA+PiArICogYWxsb2NhdGlvbnMgdG8gdGhlIGFsbG9jYXRp
b24gc2l6ZSBib3VuZGFyeSwgc28gdGhhdCB0aGUNCj4gPiA+PiArICogYWxsb2NhdGVkIG1lbW9y
eSBhcHBlYXJzIHRvIEh5cGVyLVYgYXMgYSBwYWdlIG9mIHRoZSBzaXplDQo+ID4gPj4gKyAqIGl0
IGV4cGVjdHMuDQo+ID4gPj4gKyAqDQo+ID4gPj4gKyAqIFRoZXNlIGZ1bmN0aW9ucyBhcmUgdXNl
ZCBieSBhcm02NCBzcGVjaWZpYyBjb2RlIGFzIHdlbGwgYXMNCj4gPiA+PiArICogYXJjaCBpbmRl
cGVuZGVudCBIeXBlci1WIGRyaXZlcnMuDQo+ID4gPj4gKyAqLw0KPiA+ID4+ICsNCj4gPiA+PiAr
dm9pZCAqaHZfYWxsb2NfaHlwZXJ2X3BhZ2Uodm9pZCkNCj4gPiA+PiArew0KPiA+ID4+ICsgICAg
ICAgQlVJTERfQlVHX09OKFBBR0VfU0laRSA8ICBIVl9IWVBfUEFHRV9TSVpFKTsNCj4gPiA+PiAr
ICAgICAgIHJldHVybiBrbWFsbG9jKEhWX0hZUF9QQUdFX1NJWkUsIEdGUF9LRVJORUwpOw0KPiA+
ID4+ICt9DQo+ID4gPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGh2X2FsbG9jX2h5cGVydl9wYWdlKTsN
Cj4gPiA+DQo+ID4gPiBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBndWFyYW50ZWUgdGhhdCBr
bWFsbG9jKCkgcmV0dXJucw0KPiA+ID4gcGFnZS1hbGlnbmVkDQo+ID4gPiBhbGxvY2F0aW9ucyBp
biBnZW5lcmFsLg0KPiA+DQo+ID4gSSBiZWxpZXZlIHRoYXQgZ3VhcmFudGVlIGNhbWUgd2l0aCA1
OWJiNDc5ODVjMWRiICgibW0sIHNsW2FvdV1iOg0KPiA+IGd1YXJhbnRlZQ0KPiA+IG5hdHVyYWwg
YWxpZ25tZW50IGZvciBrbWFsbG9jKHBvd2VyLW9mLXR3bykiKS4NCj4gPg0KPiA+ID4gSG93IGFi
b3V0IHVzaW5nIGdldF9mcmVlX3BhZ2VzKCkgdG8gaW1wbGVtZW50IHRoaXM/DQo+ID4NCj4gPiBU
aGlzIHdvdWxkIGNlcnRhaW5seSB3b3JrLCBhdCB0aGUgZXhwZW5zZSBvZiBhIGxvdCBvZiB3YXN0
ZWQgbWVtb3J5IHdoZW4NCj4gPiBQQUdFX1NJWkUgaXNuJ3QgNGsuDQo+IA0KPiBJJ20gc3VyZSB0
aGlzIGlzIHRoZSBsZWFzdCBvZiB5b3VyIHByb2JsZW1zIHdoZW4gdGhlIGd1ZXN0IHJ1bnMgd2l0
aA0KPiBhIGxhcmdlIGJhc2UgcGFnZSBzaXplLCB5b3UndmUgYWxyZWFkeSB3YXN0ZWQgbW9zdCBv
ZiB5b3VyIG1lbW9yeQ0KPiBvdGhlcndpc2UgdGhlbi4NCj4gDQoNCkkgdGhpbmsgdGhlcmUncyB2
YWx1ZSBpbiBrZWVwaW5nIHRoZXNlIGZ1bmN0aW9ucy4gIFRoZXJlIGFyZSA4IHVzZXMgaW4NCmFy
Y2hpdGVjdHVyZSBpbmRlcGVuZGVudCBjb2RlIGF0IHRoZSBtb21lbnQsIHdoaWNoIGFkbWl0dGVk
bHkgc2F2ZXMNCm9ubHkgfjEvMiBNYnl0ZSBvZiBtZW1vcnkgd2l0aCBhIDY0SyBwYWdlIHNpemUs
IGJ1dCB3ZSB3aWxsIGhhdmUNCmFkZGl0aW9uYWwgdXNlcyB3aXRoIG1vcmUgbWVtb3J5IHNhdmlu
Z3MgYXMgd2UgZ2V0IGFsbCBvZiB0aGUNCkh5cGVyLVYgc3ludGhldGljIGRyaXZlcnMgdG8gd29y
ayB3aXRoIDY0SyBwYWdlIHNpemUuICBGdXJ0aGVybW9yZSwNCnRoZXJlJ3MgY29taW5nIHdvcmsg
dGhhdCB3aWxsIHJlcXVpcmUgYWRkaXRpb25hbCBzdGVwcyB0byBzaGFyZSBhIHBhZ2UNCmJldHdl
ZW4gYSBndWVzdCBhbmQgdGhlIEh5cGVyLVYgaG9zdC4gIFRoZXNlIGZ1bmN0aW9ucyBhcmUgdGhl
IHJpZ2h0DQpwbGFjZSB0byBwdXQgdGhlIGNvZGUgZm9yIHRoZSBhZGRpdGlvbmFsIHNoYXJpbmcg
c3RlcHMuICBSZW1vdmluZyB0aGVtDQpub3cgaW4gZmF2b3Igb2YgYSBiYXJlIGttYWxsb2MoKSBh
bmQgdGhlbiBhZGRpbmcgdGhlbSBiYWNrIGRvZXNuJ3QNCnNlZW0gd29ydGh3aGlsZS4NCg0KTWlj
aGFlbA0K
