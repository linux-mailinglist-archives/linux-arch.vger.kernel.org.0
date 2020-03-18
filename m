Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B221892C7
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCRASm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:18:42 -0400
Received: from mail-eopbgr770101.outbound.protection.outlook.com ([40.107.77.101]:27902
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCRASm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9qs5GRq9v40XZmFfW5YDJH3ci7OFvETTsQ7B3HiJ2pK9i821Ezd+oLCggVpXzgrFHmoI1vOPJH+jlSR3Tae0+as33bvUdnhxhZhY6k1wG4Y8IA1y5SAM48zoLmLaXknAGZVGmXaJivkI6jgdZghqZtrH3aYj5vVfdsw7whZXJI5oInoiXq3shK/UwPD45XV1yW9trkeYjOTsvHnYRBPo9GxdB0aqpxDtomNSsP3USkHrluNkGJiJ0u5QQFXJPxbJxD0mkBh9+kdUa+VXsY80+nlAAysFaJj1fSx6nx9OR1RMThzEllFF/S7xfLUdCcBiu0EJzNmEO2pI7ommCaJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d+VYi8g7pTo0pUctlsP9nsPPvpQ/jGV+rl1Qn8AErE=;
 b=BFOcqGpdSmNFf5oFwa2cnouOoEkFuqbTCqv9IX5y2UShyAaTj7U0m7PiaU2HyeQDZbujHcs87UUuDXv5ZDbIeLEUOVVIoEjqxjFpMG7bi1vCGfloHBqkiA1GpA3PijK9v7+nLP5zPtlA0hl6+23dRNvM7dBgZ1/H0XilIQvuui3Y6RgYam98Xtn+Qvy33fPwoL1UmJznbRFzs1J+DdOP7jkTZfJgeWr93eydXlDceGpm0/grvUACvVluguvsI0qFnlIyKifzStJlC3aV+cDUruErkrxLBjrNAh5/Zp32VmoyFDf3vjglEw0Ii40Ut8JpVfV3wDeRGi+brlPLYa//zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d+VYi8g7pTo0pUctlsP9nsPPvpQ/jGV+rl1Qn8AErE=;
 b=VojK9mX+FrTBR4KsjJzW43N7eFPGIB8UrdePlsh/hefTJlRvAcfDNMgUd2H+dlk/O8Op6eskdKm0OEJmhZnMrwrfnWnSooPJI1x96gdTy6bl8ZMXi3GhNlLfk4LdCYaaw33nyP6TxN8DYvpkAIGVS9O0AOyYwe83bQPNuzyGMwY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7; Wed, 18 Mar
 2020 00:18:39 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:18:39 +0000
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
Thread-Index: AQHV+hZM60S+LKGqSUO5qXQSEIBQyahK416AgAKQkEA=
Date:   Wed, 18 Mar 2020 00:18:39 +0000
Message-ID: <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:18:36.7972300Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=92eac9d0-fc23-4dc8-9926-4f5d9b19181f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39cc58c0-2c60-48cb-5116-08d7cad1e86b
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1082BD0386B7115665EB1D14D7F70@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(10290500003)(55016002)(478600001)(7696005)(5660300002)(9686003)(54906003)(2906002)(7416002)(8990500004)(53546011)(33656002)(52536014)(6506007)(6916009)(76116006)(71200400001)(186003)(4744005)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(316002)(86362001)(81156014)(8936002)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIuoynU3lG/4CEJHwvOc3DUUrjvzesO/IF7QFmPuUKIkEaoNjqYOg9TUC/cLgSltN/rLeZ5fwjU9zYHKFl8dSrevPLnlkTCKJ6KRMtTPZwU0H6Y1jiiZvJ9uwV17UII3I64GKIVHQzz6npucUkoT9JWmKezymJsITuUitGAyNcpqOUjaPf6e9+lenzOfoMdpqHh+ECo8aaz7ecLk3+Ej3De3I7lO4zVW8hfG//td+ztVeohKwxXVICH9Cl4qEUHPdhaHJneHpVggHlAXZW4rCeFzHYCfz9KMYcQU1t0ToD+Mimuduf73n5FYdoXK7g38tpwiSe2bK6YWijfFnZfOsi/YQo3N8J7eCgSD3xRAWZ64oMYITT66bMrrnuQY6wydjutWw8mG+x9tsQIQdaeDXcJN0MDLlumvCjDXskMDC69ISKt7QCKlUV0ttGBC4Qf5
x-ms-exchange-antispam-messagedata: 7VQPMRZBgY1mWcLu8YDz+RVEoqF40yQoksCiG9tX9cP9MIZsau0F83BeENi7eIYqcCexY6PxtuGSXT6i/hg0G5DXIwRs6P8Z1AD616/B4z/nCY2KbmpjfySxISqaeNNuoSl5fNlk2DYKmIojaveXKA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cc58c0-2c60-48cb-5116-08d7cad1e86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:18:39.0758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Psd0mnrks8as3rv16Tp4Ra8aNacOu3+ok9lahG4zuNKlYVA2MUs80IQ852swg9lugDtUiy6MKsZMcGFeaMwWSZCf5Y+lBIkalSZvR6x3v4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IE9uIFNhdCwgTWFyIDE0
LCAyMDIwIGF0IDQ6MzYgUE0gTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gVGhlIEh5cGVyLVYgZnJhbWUgYnVmZmVyIGRyaXZlciBtYXkgYmUg
YnVpbHQgYXMgYSBtb2R1bGUsIGFuZA0KPiA+IGl0IG5lZWRzIGFjY2VzcyB0byBzY3JlZW5faW5m
by4gU28gZXhwb3J0IHNjcmVlbl9pbmZvLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IA0KPiBJcyB0aGVyZSBhbnkgY2hh
bmNlIG9mIHVzaW5nIGEgbW9yZSBtb2Rlcm4gS01TIGJhc2VkIGRyaXZlciBmb3IgdGhlIHNjcmVl
bg0KPiB0aGFuIHRoZSBvbGQgZmJkZXYgc3Vic3lzdGVtPyBJIGhhZCBob3BlZCB0byBvbmUgZGF5
IGNvbXBsZXRlbHkgcmVtb3ZlDQo+IHN1cHBvcnQgZm9yIHRoZSBvbGQgQ09ORklHX1ZJREVPX0ZC
REVWIGFuZCBzY3JlZW5faW5mbyBmcm9tIG1vZGVybg0KPiBhcmNoaXRlY3R1cmVzLg0KPiANCg0K
VGhlIGN1cnJlbnQgaHlwZXJ2X2ZiLmMgZHJpdmVyIGlzIGFsbCB3ZSBoYXZlIHRvZGF5IGZvciB0
aGUgc3ludGhldGljIEh5cGVyLVYNCmZyYW1lIGJ1ZmZlciBkZXZpY2UuICBUaGF0IGRyaXZlciBi
dWlsZHMgYW5kIHJ1bnMgb24gYm90aCBBUk02NCBhbmQgeDg2Lg0KDQpJJ20gbm90IGtub3dsZWRn
ZWFibGUgYWJvdXQgdmlkZW8vZ3JhcGhpY3MgZHJpdmVycywgYnV0IHdoZW4geW91DQpzYXkgImEg
bW9yZSBtb2Rlcm4gS01TIGJhc2VkIGRyaXZlciIsIGFyZSB5b3UgbWVhbmluZyBvbmUgYmFzZWQg
b24NCkRSTSAmIEtNUz8gIERvZXMgRFJNIG1ha2Ugc2Vuc2UgZm9yIGEgImR1bWIiIGZyYW1lIGJ1
ZmZlciBkZXZpY2U/DQpBcmUgdGhlcmUgYW55IGRyaXZlcnMgdGhhdCB3b3VsZCBiZSBhIGdvb2Qg
cGF0dGVybiB0byBsb29rIGF0Pw0KDQpNaWNoYWVsDQoNCg==
