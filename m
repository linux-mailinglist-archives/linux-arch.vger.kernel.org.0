Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01E189283
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCRAMZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:12:25 -0400
Received: from mail-eopbgr770107.outbound.protection.outlook.com ([40.107.77.107]:28133
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCRAMZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQWj3pXqlyuaDJqyH/Ux5DFcIqjLqK5+8Y2G6iqANrNiO5TGqLX7mjr6D0VzT0w3jcy2IuuOroRicZlE0/mAwFuWWisP174Y7o8I5lABt7oMMnHiGQKykrnp+GHrUQaeqtGQYXPbNSuevQzPYTk6iA7t4o9NbWtmURTGQ5QsKzhwKYKtREDdWAEMs06h8B6EPrGWdC5oUleP5sChyAunRlbG4jull1omawT5m+VmKb6nQz53M7gDf53mb7CqGXEzNn1GGCt5SSzZ2BWzL10x6inVQadVSAhti69xiBitS338gQtkb5M9igSK2FTK9bC0xBTAaybCxPfkqZJ598kbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4apO04KVy7HQEfL+4q5FJZrzwLcAbNqyUuDyF3zEpkI=;
 b=EzeLKJKNaFIU+BtKMLMW5vEgUZK+pzhgTfNZPnuHUXY6/XiVLZtb4IAkC0iOcse+tGSw99FmZ5KCl/bp5/RnR9UOPZ+pE0zkOBERKV5QqjJJu/hZhYg/G4lS3aJ3ZeGcotgFQlWBtpA/djszvd4n62LZSggQE06zaSGLVJEcyolhPjhsC5mzlzdEeHK5f4mwxCocAj22nrXxsrQg7h+lL60GffmBuv2giHGZ52f1F25SJ6j7k8oRlPPC+8ue7wSWxTSh1TJfyRJT0lpOehP8Fn9FJ03OmDn0b/w7fDnSFun2R75d6/Gvl080lI+NoCI/0gZimQvWs+QitKCXcE//CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4apO04KVy7HQEfL+4q5FJZrzwLcAbNqyUuDyF3zEpkI=;
 b=jOsyeVmKDP6g28C3kMpKOIt3wtL+JKiuZfC6q1n+GfTQbn9nFKI6ukpn298xqROBYzjPYDJAKyomj651v+JQYu1aT7pOKVDtW18RAFipoZlvLPfboFkid/IP7jmhuUDAtdJkdIZb7ZUyAX4yYvWCjrX6duS25GVbVFCVbGK9718=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7; Wed, 18 Mar
 2020 00:12:19 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:12:19 +0000
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
Subject: RE: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHV+hZFy2PYk3vLgUeMDTQcrJxEgqhK6wGAgAJAuNA=
Date:   Wed, 18 Mar 2020 00:12:18 +0000
Message-ID: <MW2PR2101MB10524879CD685710A51AB740D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
In-Reply-To: <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:12:16.8474672Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c90051e-250f-4594-b94a-1ef53dfada48;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7884e1b1-8379-46b2-664d-08d7cad105d1
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1082520AC43CAEFF509C74D7D7F70@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(10290500003)(55016002)(478600001)(7696005)(5660300002)(9686003)(54906003)(2906002)(7416002)(966005)(8990500004)(53546011)(33656002)(52536014)(6506007)(6916009)(76116006)(71200400001)(186003)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(316002)(86362001)(81156014)(8936002)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0AwXp6/HcMxLHZYsF4GKJWYBGKeXkvw/vfmqW7vNEQKJebAe+LLTsdUUbX1oAgGEvyi9gOyFjEuakdE04uuvINDIcxmsJ1STDSlcymW0eHdLSsEG8On5EHbUTk5WjMHo9+8HVQMurFV7vK6CNrHMs3QJQX7wZsP4DhpypbJZrYp8g4s1dX6PeBO11vIDt0vD64zjh77uNa2/h7FcT1Q3l3Q0VnlviudWPDZ4fpSKGClHrJuHbnbFO2jAaHZwgHALMQbE/WLc4PeXCZPPern5iDcw156uJYcPtvu6B9BSCuM087B1qQ567V+jLuIcD39sBePyJZ+nq3GEUybb8zgj4N0/l0zF2ONhmW3PTueE91Zh43CockX209eXzzfSDsd2dZSjIKbSzn2sMBY4vCqglwhttlY/HzPhaKRdGs+Hetdf0NEd3z7nR512tNe2UUnJuTIDoof19EnlYVsHSAIVLeC4R9m2GOPF5ErYGPvhchJE7Me/OOUhM3QK/q3czstrrXhl6xXjYI8sWac5yA5jXg==
x-ms-exchange-antispam-messagedata: 3Zu9UFj3Apk8s8ELr7c5sqAez17jymLeCUX0cfwPRbzFuac1lY5ye+nCPtMzJH1GhHSUTG9E0K2qMf55DKaMBQDguo2yM1BdqAC9KSYmYcIqcjhMM2dcvBXz/6p7UzeVlrDv6iHEW9JoHjzMq4zhkg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7884e1b1-8379-46b2-664d-08d7cad105d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:12:18.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJlt63tvAm1/6bq2OG4G1UOsm09vZ0OMZRZHCV3BzDNVuiAU51JUq3MWdiyw6CWhxdqx37HFU19M4FMB1o02WAvYuTBlu83t7hdHM6Hn+Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBNYXJjaCAx
NiwgMjAyMCAxOjQ4IEFNDQo+IA0KPiBPbiBTYXQsIE1hciAxNCwgMjAyMCBhdCA0OjM2IFBNIE1p
Y2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gDQo+ID4gKw0K
PiA+ICsvKiBEZWZpbmUgaW5wdXQgYW5kIG91dHB1dCBsYXlvdXQgZm9yIEdldCBWUCBSZWdpc3Rl
ciBoeXBlcmNhbGwgKi8NCj4gPiArc3RydWN0IGh2X2dldF92cF9yZWdpc3Rlcl9pbnB1dCB7DQo+
ID4gKyAgICAgICB1NjQgcGFydGl0aW9uaWQ7DQo+ID4gKyAgICAgICB1MzIgdnBpbmRleDsNCj4g
PiArICAgICAgIHU4ICBpbnB1dHZ0bDsNCj4gPiArICAgICAgIHU4ICBwYWRkaW5nWzNdOw0KPiA+
ICsgICAgICAgdTMyIG5hbWUwOw0KPiA+ICsgICAgICAgdTMyIG5hbWUxOw0KPiA+ICt9IF9fcGFj
a2VkOw0KPiANCj4gQXJlIHlvdSBzdXJlIHRoZXNlIG5lZWQgdG8gYmUgbWFkZSBieXRlLWFsaWdu
ZWQgYWNjb3JkaW5nIHRvIHRoZQ0KPiBzcGVjaWZpY2F0aW9uPyBJZiB0aGUgc3RydWN0dXJlIGl0
c2VsZiBpcyBhbGlnbmVkIHRvIDY0IGJpdCwgYmV0dGVyIG1hcmsgb25seQ0KPiB0aGUgaW5kaXZp
ZHVhbCBmaWVsZHMgdGhhdCBhcmUgbWlzYWxpZ25lZCBhcyBfX3BhY2tlZC4NCj4gDQo+IElmIHRo
ZSBzdHJ1Y3R1cmUgaXMgYWxpZ25lZCB0byBvbmx5IDMyLWJpdCBhZGRyZXNzZXMgaW5zdGVhZCBv
Zg0KPiA2NC1iaXQsIG1hcmsgaXQgYXMgIl9fcGFja2VkIF9fYWxpZ25lZCg0KSIgdG8gbGV0IHRo
ZSBjb21waWxlcg0KPiBnZW5lcmF0ZSBiZXR0ZXIgY29kZSBmb3IgYWNjZXNzaW5nIGl0Lg0KDQpO
b25lIG9mIHRoZSBmaWVsZHMgYXJlIG1pc2FsaWduZWQgYW5kIGl0IHdpbGwgYWx3YXlzIGJlIGFs
aWduZWQgdG8gNjQtYml0DQphZGRyZXNzZXMsIHNvIHRoZXJlIHNob3VsZCBiZSBubyBwYWRkaW5n
IG5lZWRlZCBvciBhZGRlZC4gIFRoZXJlIHdhcw0KYSBkaXNjdXNzaW9uIG9mIF9fcGFja2VkIGFu
ZCB0aGUgSHlwZXItViBkYXRhIHN0cnVjdHVyZXMgaW4gZ2VuZXJhbCBvbg0KTEtNTCBoZXJlOiAg
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvMTEvMzAvODQ4LiAgQWRkaW5nIF9fcGFja2VkIHdh
cw0KZG9uZSBhcyBhIHByZXZlbnRhdGl2ZSBtZWFzdXJlLCBub3QgYmVjYXVzZSBhbnl0aGluZyB3
YXMgYWN0dWFsbHkNCmJyb2tlbi4gIE1hcmtpbmcgYXMgX19hbGlnbmVkKDgpIGhlcmUgd291bGQg
aW5kaWNhdGUgdGhlIGNvcnJlY3QgaW50ZW50LA0KdGhvdWdoIHRoZSB1c2Ugb2YgdGhlIHN0cnVj
dHVyZSBhbHdheXMgZW5zdXJlcyA2NC1iaXQgYWxpZ25tZW50Lg0KDQo+IA0KPiBBbHNvLCBpbiBv
cmRlciB0byB3cml0ZSBwb3J0YWJsZSBjb2RlLCBpdCB3b3VsZCBiZSBoZWxwZnVsIHRvIG1hcmsN
Cj4gYWxsIHRoZSBmaWVsZHMgYXMgZXhwbGljaXRseSBsaXR0bGUtZW5kaWFuLCBhbmQgdXNlIF9f
bGUzMl90b19jcHUoKQ0KPiBldGMgZm9yIGFjY2Vzc2luZyB0aGVtLg0KDQpUaGVyZSdzIGFuIG9w
ZW5pbmcgY29tbWVudCBpbiB0aGlzIGZpbGUgc3RhdGluZyB0aGF0IGFsbCBkYXRhDQpzdHJ1Y3R1
cmVzIHNoYXJlZCBiZXR3ZWVuIEh5cGVyLVYgYW5kIGEgZ3Vlc3QgVk0gYXJlIGxpdHRsZQ0KZW5k
aWFuLiAgSXMgdGhlcmUgc29tZSBvdGhlciBtYXJraW5nIHRvIGNvbnNpZGVyIHVzaW5nPw0KDQpX
ZSBoYXZlIGRlZmluaXRlbHkgbm90IGFsbG93ZWQgZm9yIHRoZSBjYXNlIG9mIEh5cGVyLVYgcnVu
bmluZyBvbg0KYSBiaWcgZW5kaWFuIGFyY2hpdGVjdHVyZS4gIFRoZXJlIGFyZSBhICpsb3QqIG9m
IG1lc3NhZ2VzIGFuZCBkYXRhDQpzdHJ1Y3R1cmVzIHBhc3NlZCBiZXR3ZWVuIHRoZSBndWVzdCBh
bmQgSHlwZXItViwgYW5kIGNvZGluZw0KdG8gaGFuZGxlIGVpdGhlciBlbmRpYW5uZXNzIGlzIGEg
YmlnIHByb2plY3QuICBJJ20gZG91YnRmdWwNCm9mIHRoZSB2YWx1ZSB1bnRpbCBhbmQgdW5sZXNz
IHdlIGFjdHVhbGx5IGhhdmUgYSBuZWVkIGZvciBpdC4NCg0KPiANCj4gPiArLyogRGVmaW5lIHN5
bnRoZXRpYyBpbnRlcnJ1cHQgY29udHJvbGxlciBtZXNzYWdlIGZsYWdzLiAqLw0KPiA+ICt1bmlv
biBodl9tZXNzYWdlX2ZsYWdzIHsNCj4gPiArICAgICAgIF9fdTggYXN1ODsNCj4gPiArICAgICAg
IHN0cnVjdCB7DQo+ID4gKyAgICAgICAgICAgICAgIF9fdTggbXNnX3BlbmRpbmc6MTsNCj4gPiAr
ICAgICAgICAgICAgICAgX191OCByZXNlcnZlZDo3Ow0KPiA+ICsgICAgICAgfSBfX3BhY2tlZDsN
Cj4gPiArfTsNCj4gDQo+IEZvciBzaW1pbGFyIHJlYXNvbnMsIHBsZWFzZSBhdm9pZCBiaXQgZmll
bGRzIGFuZCBqdXN0IHVzZSBhDQo+IGJpdCBtYXNrIG9uIHRoZSBmaXJzdCBtZW1iZXIgb2YgdGhl
IHVuaW9uLg0KDQpVbmZvcnR1bmF0ZWx5LCBjaGFuZ2luZyB0byBhIGJpdCBtYXNrIHJpcHBsZXMg
aW50bw0KYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IGNvZGUgYW5kIGludG8gdGhlIHg4Ng0KaW1w
bGVtZW50YXRpb24uICBJJ2QgcHJlZmVyIG5vdCB0byBkcmFnIHRoYXQgY29tcGxleGl0eQ0KaW50
byB0aGlzIHBhdGNoIHNldC4NCg0KPiANCj4gVGhlIF9fcGFja2VkIGFubm90YXRpb24gaGVyZSBp
cyBub3QgbWVhbmluZ2Z1bCwNCj4gYXMgdGhlIHRvdGFsIHNpemUgaXMgYWxyZWFkeSBvbmx5IGEg
c2luZ2xlIGJ5dGUuDQoNCkFncmVlZC4NCg0KPiANCj4gPiArLyogRGVmaW5lIHBvcnQgaWRlbnRp
ZmllciB0eXBlLiAqLw0KPiA+ICt1bmlvbiBodl9wb3J0X2lkIHsNCj4gPiArICAgICAgIF9fdTMy
IGFzdTMyOw0KPiA+ICsgICAgICAgc3RydWN0IHsNCj4gPiArICAgICAgICAgICAgICAgX191MzIg
aWQ6MjQ7DQo+ID4gKyAgICAgICAgICAgICAgIF9fdTMyIHJlc2VydmVkOjg7DQo+ID4gKyAgICAg
ICB9ICBfX3BhY2tlZCB1Ow0KPiA+ICt9Ow0KPiANCj4gSGVyZSwgdGhlIF9fcGFja2VkIGFubm90
YXRpb24gaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIHVzZQ0KPiBpbiB0aGUgcmVzdCBvZiB0aGUg
ZmlsZTogbWFya2luZyBvbmx5IG9uZSBtZW1iZXIgb2YgdGhlIHVuaW9uDQo+IGFzIF9fcGFja2Vk
IG1lYW5zIHRoYXQgdGhlIHVuaW9uIGl0c2VsZiBpcyBzdGlsbCBleHBlY3RlZCB0bw0KPiBiZSA0
IGJ5dGUgYWxpZ25lZC4gSSB3b3VsZCBleHBlY3QgdGhhdCBlaXRoZXIgYWxsIG9mIHRoZXNlDQo+
IHN0cnVjdHVyZXMgaGF2ZSBhIHNlbnNpYmxlIGFsaWdubWVudCwgb3IgdGhleSBhcmUgYWxsDQo+
IGNvbXBsZXRlbHkgdW5hbGlnbmVkLg0KDQpBZ3JlZWQuICBMb29rcyBsaWtlIGl0IGlzIHdyb25n
IG9uIHRoZSB4ODYgc2lkZSB0b28uICANCg0KPiANCj4gPiArICogVXNlIHRoZSBIeXBlci1WIHBy
b3ZpZGVkIHN0aW1lcjAgYXMgdGhlIHRpbWVyIHRoYXQgaXMgbWFkZQ0KPiA+ICsgKiBhdmFpbGFi
bGUgdG8gdGhlIGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudCBIeXBlci1WIGRyaXZlcnMuDQo+ID4g
KyAqLw0KPiA+ICsjZGVmaW5lIGh2X2luaXRfdGltZXIodGltZXIsIHRpY2spIFwNCj4gPiArICAg
ICAgICAgICAgICAgaHZfc2V0X3ZwcmVnKEhWX1JFR0lTVEVSX1NUSU1FUjBfQ09VTlQgKyAoMip0
aW1lciksIHRpY2spDQo+ID4gKyNkZWZpbmUgaHZfaW5pdF90aW1lcl9jb25maWcodGltZXIsIHZh
bCkgXA0KPiA+ICsgICAgICAgICAgICAgICBodl9zZXRfdnByZWcoSFZfUkVHSVNURVJfU1RJTUVS
MF9DT05GSUcgKyAoMip0aW1lciksIHZhbCkNCj4gPiArI2RlZmluZSBodl9nZXRfY3VycmVudF90
aWNrKHRpY2spIFwNCj4gPiArICAgICAgICAgICAgICAgKHRpY2sgPSBodl9nZXRfdnByZWcoSFZf
UkVHSVNURVJfVElNRV9SRUZDT1VOVCkpDQo+IA0KPiBJbiBnZW5lcmFsLCB3ZSBwcmVmZXIgaW5s
aW5lIGZ1bmN0aW9ucyBvdmVyIG1hY3JvcyBpbiBoZWFkZXIgZmlsZXMuDQoNCkkgY2FuIGNoYW5n
ZSB0aGUgInNldCIgY2FsbHMgdG8gaW5saW5lIGZ1bmN0aW9ucy4gIEFzIHlvdSBjYW4gc2VlLCB0
aGUgImdldCINCmZ1bmN0aW9ucyBhcmUgY29kZWQgYW5kIHVzZWQgaW4gYXJjaGl0ZWN0dXJlIGlu
ZGVwZW5kZW50IGNvZGUgYW5kIG9uDQp0aGUgeDg2IHNpZGUgaW4gYSB3YXkgdGhhdCB3b24ndCBj
b252ZXJ0IHRvIGlubGluZSBmdW5jdGlvbnMuDQoNCj4gDQo+ID4gKyNpZiBJU19FTkFCTEVEKENP
TkZJR19IWVBFUlYpDQo+ID4gKyNkZWZpbmUgaHZfZW5hYmxlX3N0aW1lcjBfcGVyY3B1X2lycShp
cnEpICAgICAgZW5hYmxlX3BlcmNwdV9pcnEoaXJxLCAwKQ0KPiA+ICsjZGVmaW5lIGh2X2Rpc2Fi
bGVfc3RpbWVyMF9wZXJjcHVfaXJxKGlycSkgICAgIGRpc2FibGVfcGVyY3B1X2lycShpcnEpDQo+
ID4gKyNlbmRpZg0KPiANCj4gU2hvdWxkIHRoZXJlIGJlIGFuICNlbHNlIGRlZmluaXRpb24gaGVy
ZT8gSXQgaGVscHMgcmVhZGFiaWxpdHkNCj4gdG8gaGF2ZSB0aGUgdHdvIHZlcnNpb25zICh3aXRo
IGFuZCB3aXRob3V0IGh5cGVydiBzdXBwb3J0KSBjbG9zZQ0KPiB0b2dldGhlciByYXRoZXIgdGhh
biBpbiBkaWZmZXJlbnQgZmlsZXMuIElmIHRoZXJlIGlzIG5vIG90aGVyDQo+IGRlZmluaXRpb24s
IGp1c3QgZHJvcCB0aGUgI2lmLg0KDQpBZ3JlZWQuICBJJ2xsIGZpZ3VyZSBvdXQgYSB3YXkgdG8g
aGFuZGxlIHRoaXMgYmV0dGVyLg0KDQo+IA0KPiAgICAgIEFybmQNCg==
