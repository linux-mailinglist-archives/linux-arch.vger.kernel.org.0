Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75D5BFEC3
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2019 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfI0F5p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 01:57:45 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:23196
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfI0F5p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 01:57:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgGiXWNcdSwtvTnw4DYJqqt3n/Q/L/qDEaH5uYNfnadOA3Y75YvfJSOfShm14scYoug5ufrBrjYWuhngLKoz1tZU371gUDPPphaneQhuVCL4P/hCAIHoYWfjnH4JR2yUeBmzswwssc9UQSfMOdLLKEVf8xx4Kjk/ku0P3gXta8hbpDYgAGoP04mBaOp+5XtSiRAazTCeZWS6oSKvKLwljajrz4mKNM14ow63rmpSPRoTNQAqc+fqm83MY7peKYPUUoOkQJuJ9R2Ddx19+cVTbLn/vgTEaZSwDEzSFsLV9VPE+kE+3UxKUBeV0puUznmWAMy2WrGfI3zXLGN0AgGSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxR0UrYJMkbJ/JG9oWs0F1+RhKIlgReBxld1eCwf5XM=;
 b=gRGiOTFVu+bWMoqOw4gpV3xatCecv66tqE+4u0XoY27fXF0G6VBBNz8OcOZBF2u+js5D2dGuk7OuukSCTlx9Y+8oYzZWhDSDayLdoktOacXbWTjk0rhNaiqjjWodgiP/21cbiPfCMsNNe5zfu6+WPNfU5i3Dyrw13d8I84Z0c6NSK/Zp3FWeKlKG7xK6N+049Y/3RZP3JbthX0xEENW6HUz1gnH84NHtMzRatFY81q66XVYtDAGgfrqhnyY+bfDmde4dpN+grIZ7/q1SVvnJ9UEZIsRyxL18id+beTIkkw8rZnnb9WoM5EQx0PHvZbOoLGwaV8E4l2a4c9q7gHfP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxR0UrYJMkbJ/JG9oWs0F1+RhKIlgReBxld1eCwf5XM=;
 b=PKHN8p3AfgwDb4eJ+3qcU/zlsoYAi4lb8jChuFjJld/hwxR18L+8KWj4+FfQHTXoicbeCl6OSbez8EJGd1vDUBm26L2PbHQ5CGCAjoKl6AYOotBbjlF8hoPT+wLIK3St28gC1/eQG7ev1n0glCCR6zQJd3oN9T8IuhinkJFpmpU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.5; Fri, 27 Sep 2019 05:57:32 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Fri, 27 Sep 2019
 05:57:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVc/fwSon8M7RoH0Cu+okwDUbU56c9CFiQgADo/4CAARScYA==
Date:   Fri, 27 Sep 2019 05:57:31 +0000
Message-ID: <PU1P153MB01693752993D9EFE0DB377DEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-4-git-send-email-decui@microsoft.com>
 <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
 <PU1P153MB0169A28B05A7CDE04A57AA58BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <17e5a535-8597-4780-7cd0-e8c4d2aa8f0f@linaro.org>
In-Reply-To: <17e5a535-8597-4780-7cd0-e8c4d2aa8f0f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-27T05:57:29.3587243Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bbef767a-2d05-4de1-bedd-761b7f2037a6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:557a:f14b:ea25:465f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a243096e-0b5e-4c5f-292a-08d7430f9647
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB020132F30911C2617793BFE0BF810@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(51914003)(189003)(199004)(486006)(256004)(74316002)(66946007)(64756008)(66476007)(86362001)(66556008)(2906002)(66446008)(5660300002)(2201001)(25786009)(52536014)(229853002)(76116006)(81166006)(81156014)(8676002)(2501003)(7736002)(8936002)(305945005)(8990500004)(7416002)(33656002)(6636002)(14454004)(4326008)(22452003)(6506007)(76176011)(446003)(6246003)(11346002)(10290500003)(478600001)(1511001)(186003)(71200400001)(71190400001)(476003)(6116002)(110136005)(10090500001)(6436002)(46003)(7696005)(316002)(99286004)(9686003)(102836004)(55016002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Efr/xuJfHPg6J7UA5wLX2+c/xirgbdzZK3NOa+iFYFTPUqPMwiZD+R7Q7vqM1oSrZyjlRZzyIQPINWHHlm1AgZ7owIGTA6s1J0p9sOdtl/i1ypvqeVe1gPCnaMsCslFFBAiw5XI9BuEeRdONgxabddjSdfUh93ijHvDHiPXtFBM+NjfkqLki2bAaPzwu9wDpu1lSLkIXK0n5KrZkqP4uOpGbIi2wIQ3qpj8QmsE5RiyAE/b1yre8lb7HAc9MNqGVG30zJlb6o01Ls2bNszFumKwBZdDzbZywjXFgWvvNBddz1auvrs+tys62xIORI25EUkBjy5vzesbexDIsKsiE8kuja2kYn6bLCWZlvUjiD0LBmc4h+Sb/g7LbjrC7+quPDET8TR3aQe4Xmw9dVqfa6+XnGpWqh3hqGv7sMP5tL8Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a243096e-0b5e-4c5f-292a-08d7430f9647
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 05:57:31.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA85Svstsol1cBtmwgI4iwrHEX2yMc5+5aJo38haZxy6uTYzmiznzQIgYMJG2j7IgSn/lACYBhY5r5FnXC4DCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAyNiwgMjAxOSA2OjE3IEFNDQo+ID4+DQo+ID4+IEkgY2Fu
IHRha2UgdGhpcyBwYXRjaCBpZiBuZWVkZWQuDQo+ID4NCj4gPiBUaGFua3MsIERhbmllbCEgVXN1
YWxseSB0Z2x4IHRha2VzIGNhcmUgb2YgdGhlIHBhdGNoZXMsIGJ1dCBpdCBsb29rcyByZWNlbnRs
eSBoZQ0KPiA+IG1heSBiZSB0b28gYnVzeSB0byBoYW5kbGUgdGhlIDMgcGF0Y2hlcy4NCj4gPg0K
PiA+IEkgZ3Vlc3MgeW91IGNhbiB0YWtlIHRoZSBwYXRjaCwgaWYgdGdseCBoYXMgbm8gb2JqZWN0
aW9uLiA6LSkNCj4gPiBJZiB5b3UgdGFrZSB0aGUgcGF0Y2gsIHBsZWFzZSB0YWtlIGFsbCB0aGUg
MyBwYXRjaGVzLg0KPiANCj4gSSBtYWludGFpbiBkcml2ZXJzL2Nsb2Nrc291cmNlIGZvciB0aGUg
dGlwL3RpbWVycy9jb3JlIGJyYW5jaC4gSSBkb24ndA0KPiB3YW50IHRvIHByb3h5IGFub3RoZXIg
dGlwIGJyYW5jaCBhcyBpdCBpcyBvdXQgb2YgbXkganVyaXNkaWN0aW9uLg0KDQpJIHNlZS4gVGhh
bmtzIGZvciB0aGUgZXhwbGFuYXRpb24hIEkgbGVhcm5lZCBtb3JlIGFib3V0IHRoZSB0aXAgdHJl
ZS4gOi0pDQoNCj4gU28gSSBjYW4gdGFrZSBwYXRjaCAzLzMgYnV0IHdpbGwgbGV0IHRoZSBvdGhl
ciAyIHBhdGNoZXMgdG8gYmUgcGlja2VkIGJ5DQo+IHRoZSByaWdodCBwZXJzb24uIEl0IGlzIHlv
dXIgY2FsbC4NCg0KU291bmRzIGdvb2QuIERhbmllbCwgdGhlbiBwbGVhc2UgdGFrZSB0aGlzIHBh
dGNoLCBlLmcuIHBhdGNoIDMvMy4NCg0KUGF0Y2ggMi8zIG1heSBhcyB3ZWxsIGdvIHRocm91Z2gg
U2FzaGEncyBoeXBlci12IHRyZWUsIHNpbmNlIGl0J3MgcmVxdWlyZWQgYnkNCm90aGVyIGNoYW5n
ZXMgdG8gdGhlIGRyaXZlcnMgaHZfYmFsbG9vbiwgaHZfdXRpbHMgYW5kIGh2X3ZtYnVzLg0KDQpJ
IHN1cHBvc2UgdGdseCBpcyB0aGUgYmVzdCBwZXJzb24gdG8gdGFrZSBwYXRjaCAxLzMsIGJ1dCBp
ZiBoZSdzIHRvbyBidXN5IHRvDQpoYW5kbGUgaXQsIGl0IGNhbiBhbHNvIGdvIHRocm91Z2ggdGhl
IGh5cGVyLXYgdHJlZSwgc2luY2UgdGhlIHJlbGF0ZWQgb3RoZXINCnBhdGNoZXMgaGF2ZSBiZWVu
IGluIHRoZSBtYWlubGluZSBub3cuDQoNClRoYW5rcywNCi0tIERleHVhbg0K
