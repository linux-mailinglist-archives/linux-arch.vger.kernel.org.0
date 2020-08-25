Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A302522A6
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 23:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHYVUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 17:20:10 -0400
Received: from mail-bn8nam11on2098.outbound.protection.outlook.com ([40.107.236.98]:62256
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgHYVUK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 17:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpLnwZE6KhBnQmQsaH1VpbP8rCAz3VJoH1D3N3op9/SdkvRyzADaw07Zh0iZ1ooM+fCQLypNYoZJBvLJHjgZU7U/wq32NLPG9sxYHptEYh/IOUtGCykR7/vjM2IoHu4u9472r1rgxdEVehX/KwuWOTqcXV6mUjAf3VGGiJbzFxlet5ndsnkbRgolyGsp5FqNppUyABYgjQI8e1/YsHxdWXwkz+SrFvnLEDcB2QITZmsqMrBTTgaAr31oF41M/PwY6cMsqqqdIMCz7jwtM9F5a7F0y+jsrQiluAI85aYUmqNFW2jJI/Y90X0Rw29/rKspW4BglAyA8vHZszen053OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdaHTqhpg/cU3gS5V+kqSlBGOUZJ0m+fn+Ec9JXkQyg=;
 b=OzHHn2i1kdjprAMBwM8XVkXiMHVDOAfSvJOYPHQQEk1TB9Q76D7z/N9rRS54IX6Wf9jCPCDJJsESmzPEmxwxjLaFkNv/Mdt+Kr1PQ71D3o/Le2VrVdDgUVxQZcK/ZIf48SMsj1KKbwCgjqKIi+8kAVEXWRLwRyMgBD1zbxlEi02ikmWi+v86DcAEnmLjbFqzqmXPVHnJzbnay7avHXB4uWs9zMOTbwkACA6LsG6GfG2WdRfSHfAd6zh+I6+gEbNDwsMB+qSWd3gd5IqUd5jxJBugYi6EW+aA3ev1PBu3FQ+mah+O28IJQNqqmyEaMXDF4icZZ0VSHtd5Sd74IvvUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdaHTqhpg/cU3gS5V+kqSlBGOUZJ0m+fn+Ec9JXkQyg=;
 b=jGiNZ1wCbEJYs5KWWRNWYuxi/zLl62B2uh2qCX/ZvFmXCvIPBh18+dDKz3uL2Ae1QgFXBbEgJfQhLgXAtEiqEg+e2Mrk9vthrhzXlrVLoCKavw94jCk6bK0XrfDBxCewvMEjAK/hMP8fH2pxy6LYdlElhBkcUvYz1WYw+wYHKbg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR2101MB0809.namprd21.prod.outlook.com (2603:10b6:301:76::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Tue, 25 Aug
 2020 21:20:04 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3348.004; Tue, 25 Aug 2020
 21:20:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v7 07/10] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v7 07/10] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHWejZV3+V0eGo3rEKOr7IZiaeT4KlHldaAgAG8QZA=
Date:   Tue, 25 Aug 2020 21:20:04 +0000
Message-ID: <MW2PR2101MB1052AD42CC4F9A71F87EFE95D7570@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-8-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1NXVJON+apBZeVDdx_bqQmenab8srqJDWS_VFVpAncRA@mail.gmail.com>
In-Reply-To: <CAK8P3a1NXVJON+apBZeVDdx_bqQmenab8srqJDWS_VFVpAncRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-25T21:20:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a1929ea-825f-4297-bd92-34f2e018906f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c576276-f296-4ac9-f1d7-08d8493ca24f
x-ms-traffictypediagnostic: MWHPR2101MB0809:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR2101MB0809B6A6FFC6B992F3037C7ED7570@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWowos2NO4sexEy94qAxNvlZaGMBcDJbU8vgzOkexpXy0n0z4lbqVU9vTy98NcuQEs+nEYiLYl4mix00eXA6w6nfVnZf8CZacS6Th3iIEIV4M+M/I2u3wO/KINgn6FloDpby2/P5SQ6uJDlDy5iAv+XH4tCBJuFZ9MW4Sb8YH9KvJCmpPzM5uigy3OrCk0Mky+lpI1xwNQw9c0otV14dCpq8ab18jf5EngLXr56fnXT1QOHwEnRco9XsDJ8c93LXCvsebi1EVY/C73uaoEw4HaTpkHhqryp+FMDMUzh86zlncZw816VlsuT/Zm9yCIsYT9uEVuwSMRqgmx4DSgQpJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(186003)(6916009)(55016002)(26005)(10290500003)(7696005)(7416002)(9686003)(54906003)(316002)(4326008)(2906002)(71200400001)(8676002)(8936002)(53546011)(82950400001)(5660300002)(66556008)(66476007)(64756008)(66446008)(83380400001)(86362001)(66946007)(8990500004)(6506007)(82960400001)(76116006)(52536014)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: E3x3APA59R1tztUqZkj8MPXBtm/Cl9yumJmeaBbR1ZyTuRwJN22cv+TAkY0t9ea/ECyNw4ZKrF1lR6BTTv1pVILjdj86Ri2WPIhYV84z4+5VLZMPTuX/8rNO3waHN8ikYtbhXTeUoqv3e4LHXQujw1Z9QwybpcaE1GMuiCrdyoJXv653I+rXYNyiUJ/4vWBoOf+y4n1m0wQLmr/CRMRQsBeE51Sg1MLg4svIOIwyMqluYbKmnfA3Cja4vtffk5osTnMTH/p2lThhTTj1Ah3rKkkhRt+V7mJ5lzqiCp/8KTPPSDTvmu4OPHhBWH92IRnFcmg01+wN6Cvfq1D3XjzH1U5bmvU625WWPRV8g3ourI2ShCWSsdOYvSnGe3STOG1ZjhG9OWAfRnQvLDUlMCafdh3yojV5jyy9QWkqPEgx28pkK5zpZfVszxwxdBqmHy8huuSHvvJXkVbxIu/89GHR/EbHwvfYxbpNLMiws8OLsQwtcuU/961suDo4oE/OrBZONdM8TwviQiIl4zlnNiaWfj4VnFuawPtdOvdgbIJ4874y/GW2ouB5A4d39QIyR8c0BcbQGKRVY4eEXFPd2Ybbndy2KAyxkSrnea230lpZJZ/kHZe41a68FM/ghGez60ItBEwIqHL3zJNCyDe08ljyDg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c576276-f296-4ac9-f1d7-08d8493ca24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 21:20:04.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfD9lkyinczPfyZrXnPxoP45swXoKMf7me/VXoweWC5o8c4BuR+OM+P6HSULMqvKKPlUTL4tahq/603n4vKjh8x4pPklHFQru9A2JVHMDZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBBdWd1c3Qg
MjQsIDIwMjAgMTE6MzQgQU0NCj4gDQo+IE9uIE1vbiwgQXVnIDI0LCAyMDIwIGF0IDY6NDggUE0g
TWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
IC8qDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgaW52b2tlZCB2aWEgdGhlIEFDUEkgY2xvY2tz
b3VyY2UgcHJvYmUgbWVjaGFuaXNtLiBXZQ0KPiA+ICsgKiBkb24ndCBhY3R1YWxseSB1c2UgYW55
IHZhbHVlcyBmcm9tIHRoZSBBQ1BJIEdURFQgdGFibGUsIGJ1dCB3ZSBzZXQgdXANCj4gPiArICog
dGhlIEh5cGVyLVYgc3ludGhldGljIGNsb2Nrc291cmNlIGFuZCBkbyBvdGhlciBpbml0aWFsaXph
dGlvbiBmb3INCj4gPiArICogaW50ZXJhY3Rpbmcgd2l0aCBIeXBlci1WIHRoZSBmaXJzdCB0aW1l
LiAgVXNpbmcgZWFybHlfaW5pdGNhbGwgdG8gaW52b2tlDQo+ID4gKyAqIHRoaXMgZnVuY3Rpb24g
aXMgdG9vIGxhdGUgYmVjYXVzZSBpbnRlcnJ1cHRzIGFyZSBhbHJlYWR5IGVuYWJsZWQgYXQgdGhh
dA0KPiA+ICsgKiBwb2ludCwgYW5kIGh2X2luaXRfY2xvY2tzb3VyY2UoKSBtdXN0IHJ1biBiZWZv
cmUgaW50ZXJydXB0cyBhcmUgZW5hYmxlZC4NCj4gPiArICoNCj4gPiArICogMS4gU2V0dXAgdGhl
IGd1ZXN0IElELg0KPiA+ICsgKiAyLiBHZXQgZmVhdHVyZXMgYW5kIGhpbnRzIGluZm8gZnJvbSBI
eXBlci1WDQo+ID4gKyAqIDMuIFNldHVwIHBlci1jcHUgVlAgaW5kaWNlcy4NCj4gPiArICogNC4g
SW5pdGlhbGl6ZSB0aGUgSHlwZXItViBjbG9ja3NvdXJjZS4NCj4gPiArICovDQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IF9faW5pdCBoeXBlcnZfaW5pdChzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIg
KnRhYmxlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgaHZfZ2V0X3ZwX3JlZ2lzdGVyc19v
dXRwdXQgcmVzdWx0Ow0KPiA+ICsgICAgICAgdTMyICAgICBhLCBiLCBjLCBkOw0KPiA+ICsgICAg
ICAgdTY0ICAgICBndWVzdF9pZDsNCj4gPiArICAgICAgIGludCAgICAgaSwgY3B1aHA7DQo+ID4g
Kw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIElmIHdlJ3JlIGluIGEgVk0gb24gSHlw
ZXItViwgdGhlIEFDUEkgaHlwZXJ2aXNvcl9pZCBmaWVsZCB3aWxsDQo+ID4gKyAgICAgICAgKiBo
YXZlIHRoZSBzdHJpbmcgIk1zSHlwZXJWIi4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAg
aWYgKHN0cm5jbXAoKGNoYXIgKikmYWNwaV9nYmxfRkFEVC5oeXBlcnZpc29yX2lkLCAiTXNIeXBl
clYiLCA4KSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+
ICsgICAgICAgLyogU2V0dXAgdGhlIGd1ZXN0IElEICovDQo+ID4gKyAgICAgICBndWVzdF9pZCA9
IGdlbmVyYXRlX2d1ZXN0X2lkKDAsIExJTlVYX1ZFUlNJT05fQ09ERSwgMCk7DQo+ID4gKyAgICAg
ICBodl9zZXRfdnByZWcoSFZfUkVHSVNURVJfR1VFU1RfT1NJRCwgZ3Vlc3RfaWQpOw0KPiA+ICsN
Cj4gPiArICAgICAgIC8qIEdldCB0aGUgZmVhdHVyZXMgYW5kIGhpbnRzIGZyb20gSHlwZXItViAq
Lw0KPiA+ICsgICAgICAgaHZfZ2V0X3ZwcmVnXzEyOChIVl9SRUdJU1RFUl9GRUFUVVJFUywgJnJl
c3VsdCk7DQo+ID4gKyAgICAgICBtc19oeXBlcnYuZmVhdHVyZXMgPSByZXN1bHQuYXMzMi5hOw0K
PiA+ICsgICAgICAgbXNfaHlwZXJ2Lm1pc2NfZmVhdHVyZXMgPSByZXN1bHQuYXMzMi5jOw0KPiA+
ICsNCj4gPiArICAgICAgIGh2X2dldF92cHJlZ18xMjgoSFZfUkVHSVNURVJfRU5MSUdIVEVOTUVO
VFMsICZyZXN1bHQpOw0KPiA+ICsgICAgICAgbXNfaHlwZXJ2LmhpbnRzID0gcmVzdWx0LmFzMzIu
YTsNCj4gPiArDQo+ID4gKyAgICAgICBwcl9pbmZvKCJIeXBlci1WOiBGZWF0dXJlcyAweCV4LCBo
aW50cyAweCV4LCBtaXNjIDB4JXhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgIG1zX2h5cGVydi5m
ZWF0dXJlcywgbXNfaHlwZXJ2LmhpbnRzLCBtc19oeXBlcnYubWlzY19mZWF0dXJlcyk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIElmIEh5cGVyLVYgaGFzIGNyYXNoIG5v
dGlmaWNhdGlvbnMsIHNldCBjcmFzaF9rZXhlY19wb3N0X25vdGlmaWVycw0KPiA+ICsgICAgICAg
ICogc28gdGhhdCB3ZSB3aWxsIHJlcG9ydCB0aGUgcGFuaWMgdG8gSHlwZXItViBiZWZvcmUgcnVu
bmluZyBrZHVtcC4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKG1zX2h5cGVydi5t
aXNjX2ZlYXR1cmVzICYgSFZfRkVBVFVSRV9HVUVTVF9DUkFTSF9NU1JfQVZBSUxBQkxFKQ0KPiA+
ICsgICAgICAgICAgICAgICBjcmFzaF9rZXhlY19wb3N0X25vdGlmaWVycyA9IHRydWU7DQo+ID4g
Kw0KPiA+ICsgICAgICAgLyogR2V0IGluZm9ybWF0aW9uIGFib3V0IHRoZSBIeXBlci1WIGhvc3Qg
dmVyc2lvbiAqLw0KPiA+ICsgICAgICAgaHZfZ2V0X3ZwcmVnXzEyOChIVl9SRUdJU1RFUl9IWVBF
UlZJU09SX1ZFUlNJT04sICZyZXN1bHQpOw0KPiA+ICsgICAgICAgYSA9IHJlc3VsdC5hczMyLmE7
DQo+ID4gKyAgICAgICBiID0gcmVzdWx0LmFzMzIuYjsNCj4gPiArICAgICAgIGMgPSByZXN1bHQu
YXMzMi5jOw0KPiA+ICsgICAgICAgZCA9IHJlc3VsdC5hczMyLmQ7DQo+ID4gKyAgICAgICBwcl9p
bmZvKCJIeXBlci1WOiBIb3N0IEJ1aWxkICVkLiVkLiVkLiVkLSVkLSVkXG4iLA0KPiA+ICsgICAg
ICAgICAgICAgICBiID4+IDE2LCBiICYgMHhGRkZGLCBhLCBkICYgMHhGRkZGRkYsIGMsIGQgPj4g
MjQpOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIEFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHBlcmNw
dSBWUCBpbmRleCBhcnJheSAqLw0KPiA+ICsgICAgICAgaHZfdnBfaW5kZXggPSBrbWFsbG9jX2Fy
cmF5KG51bV9wb3NzaWJsZV9jcHVzKCksIHNpemVvZigqaHZfdnBfaW5kZXgpLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAg
aWYgKCFodl92cF9pbmRleCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gKw0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9wb3NzaWJsZV9jcHVzKCk7IGkr
KykNCj4gPiArICAgICAgICAgICAgICAgaHZfdnBfaW5kZXhbaV0gPSBWUF9JTlZBTDsNCj4gPiAr
DQo+ID4gKyAgICAgICBjcHVocCA9IGNwdWhwX3NldHVwX3N0YXRlKENQVUhQX0FQX09OTElORV9E
WU4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgImFybTY0L2h5cGVydl9pbml0Om9ubGlu
ZSIsIGh2X2NwdV9pbml0LCBOVUxMKTsNCj4gPiArICAgICAgIGlmIChjcHVocCA8IDApDQo+ID4g
KyAgICAgICAgICAgICAgIGdvdG8gZnJlZV92cF9pbmRleDsNCj4gPiArDQo+ID4gKyAgICAgICBo
dl9pbml0X2Nsb2Nrc291cmNlKCk7DQo+ID4gKyAgICAgICBpZiAoaHZfc3RpbWVyX2FsbG9jKCkp
DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gcmVtb3ZlX2NwdWhwX3N0YXRlOw0KPiA+ICsNCj4g
PiArICAgICAgIGh5cGVydl9pbml0aWFsaXplZCA9IHRydWU7DQo+ID4gKyAgICAgICByZXR1cm4g
MDsNCj4gPiArDQo+ID4gK3JlbW92ZV9jcHVocF9zdGF0ZToNCj4gPiArICAgICAgIGNwdWhwX3Jl
bW92ZV9zdGF0ZShjcHVocCk7DQo+ID4gK2ZyZWVfdnBfaW5kZXg6DQo+ID4gKyAgICAgICBrZnJl
ZShodl92cF9pbmRleCk7DQo+ID4gKyAgICAgICBodl92cF9pbmRleCA9IE5VTEw7DQo+ID4gKyAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArfQ0KPiA+ICtUSU1FUl9BQ1BJX0RFQ0xBUkUoaHlw
ZXJ2LCBBQ1BJX1NJR19HVERULCBoeXBlcnZfaW5pdCk7DQo+IA0KPiBJIHRoaW5rIHRoaXMgaGFz
IGNvbWUgdXAgYmVmb3JlLCBhbmQgSSBzdGlsbCBkb24ndCBjb25zaWRlciBpdCBhbiBhY2NlcHRh
YmxlDQo+IGhhY2sgdG8gaG9vayBwbGF0Zm9ybSBpbml0aWFsaXphdGlvbiBjb2RlIGludG8gdGhl
IHRpbWVyIGNvZGUuDQo+IA0KPiBQbGVhc2Ugc3BsaXQgb3V0IHRoZSB0aW1lciBpbnRvIGEgc3Rh
bmRhbG9uZSBkcml2ZXIgaW4gZHJpdmVycy9jbG9ja3NvdXJjZQ0KPiB0aGF0IGNhbiBnZXQgcmV2
aWV3ZWQgYnkgdGhlIGNsb2Nrc291cmNlIG1haW50YWluZXJzLg0KDQpJIHNlZSB0d28gcmVsYXRl
ZCB0b3BpY3MgaGVyZS4gIEZpcnN0LCB0aGUgSHlwZXItViBjbG9ja3NvdXJjZSBkcml2ZXIgaXMN
CmRyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMuICBUaGUgY29kZSBpcyBhcmNoaXRl
Y3R1cmUgaW5kZXBlbmRlbnQNCmFuZCBpcyB1c2VkIHRvZGF5IG9uIHRoZSB4ODYgc2lkZSBhbmQg
Zm9yIEFSTTY0IGluIHRoaXMgcGF0Y2ggc2VyaWVzLiAgQSBmZXcNCmFyY2hpdGVjdHVyZSBzcGVj
aWZpYyBjYWxscyBhcmUgc2F0aXNmaWVkIGJ5IGNvZGUgdW5kZXIgYXJjaC94ODYsIGFuZCBpbiB0
aGlzDQpwYXRjaCBzZXJpZXMsIHVuZGVyIGFyY2gvYXJtNjQuICBJcyB0aGVyZSBzb21lIGFzcGVj
dCBvZiB0aGlzIGRyaXZlciB0aGF0DQpuZWVkcyByZWNvbnNpZGVyYXRpb24/ICBJIGp1c3Qgd2Fu
dCB0byBtYWtlIHN1cmUgdG8gdW5kZXJzdGFuZCB3aGF0IHlvdQ0KYXJlIGdldHRpbmcgYXQuDQoN
ClNlY29uZCBpcyB0aGUgcXVlc3Rpb24gb2Ygd2hlcmUvaG93IHRvIGRvIEh5cGVyLVYgc3BlY2lm
aWMgaW5pdGlhbGl6YXRpb24uDQpJIGFncmVlIHRoYXQgaGFuZ2luZyBpdCBvZmYgdGhlIHRpbWVy
IGluaXRpYWxpemF0aW9uIGlzbid0IGEgZ3JlYXQgYXBwcm9hY2guDQpTaG91bGQgSSBhZGQgYSBI
eXBlci1WIHNwZWNpZmljIGluaXRpYWxpemF0aW9uIGNhbGwgYXQgdGhlIGFwcHJvcHJpYXRlIHBv
aW50DQppbiB0aGUgQVJNNjQgaW5pdCBzZXF1ZW5jZT8gIFRoZSB4ODYgc2lkZSBoYXMgc29tZSBz
dHJ1Y3R1cmUgZm9yIGhhbmRsaW5nDQptdWx0aXBsZSBoeXBlcnZpc29ycywgYW5kIHRoZSBIeXBl
ci1WIGluaXRpYWxpemF0aW9uIGNvZGUgbmF0dXJhbGx5IHBsdWdzIGludG8NCnRoYXQgc3RydWN0
dXJlLiAgSSdtIGNlcnRhaW5seSBvcGVuIHRvIHN1Z2dlc3Rpb25zIG9uIHRoZSBiZXN0IHdheSB0
byBoYW5kbGUNCml0IGZvciBBUk02NC4NCg0KTWljaGFlbA0KDQo+IA0KPiAgICAgICBBcm5kDQo=
