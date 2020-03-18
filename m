Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9E189292
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 01:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRAQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 20:16:28 -0400
Received: from mail-eopbgr770100.outbound.protection.outlook.com ([40.107.77.100]:38157
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbgCRAQ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+W4T2l42QQmS4YXWQshKqy8ayZts0MQMOv/jeuD8QCXZDdO4z3S9ieFIQTZFjxTNQz6/l0urps2FNv23SkmEmAJauIygdQVWiIBbLNMO6o6xO2T48M213e3fLWMqmjuXonRq1y+X6ElPJoWDv+8+/w58aVE/ttnyMgQTp1TS7y5VXAlBtph6T7ThHu7sj7X+EzUpF/ws8UZep3gT6DoziQJpy+WU2LIKoSCM0Q63B6X/yQ5kMVMvAOnX/vPFuKWMOOoPrg9wSAD8UUc9B8X/IL7hGDaGfHMnFQMUxF0taqSw9DhIM/LoLqC+MtjN51RRH1viYTGTBO/ZlI5dYSKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJHgJPuX8dGQO1+ejko1t5oSTcLJVAxgVvJcPZNGY1U=;
 b=IhiXc81+HyjkDSW4vxK2xMbnjhVMQMQ6awzpiJLxSZuf9lgOZUcQGxcp1bFyQoPXNTBCARwmTiVbzW6lk+i8rWKOVk5N6hPzAj+9/kyU21mJuML/QR22doUxpIYgT7x5zuGwdvvKThRbt9TRHsiZ6dLkQOLRlpCUe2MEXbgnqtZcCs9UwwO5CxfwOrTFqav7QuSdAqM1U35G5IOv4BbOF0602TkzculvkP3f0Jp5NwJj4DJGd0Bv4tno0uIzN/orRolHCTMesaxR+wcv5SMc64HBvaYI+0eL0gnWUrJX4Z4UWL3uOCw8LySWTGHNm8NzaicHgAHsUxwWjVBcU1vGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJHgJPuX8dGQO1+ejko1t5oSTcLJVAxgVvJcPZNGY1U=;
 b=RgZ2T8q7fJUhLm09BI4njxDJeVC7HTbkQXlDz2YdvRWcb2HkXNkpR7UlnSb4nkBBP71YafoORfKzVZ0leTWP2aFnKgDt/iRxapYNzNTvjqohoOBbvbJpdETX6MMsihwq0dyeQWoZAuJexjOu9iK7yrtdw9xKRRZgNnl9TTMv5FQ=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1082.namprd21.prod.outlook.com (2603:10b6:302:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7; Wed, 18 Mar
 2020 00:16:24 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Wed, 18 Mar 2020
 00:16:24 +0000
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
Subject: RE: [PATCH v6 05/10] arm64: hyperv: Add interrupt handlers for VMbus
 and stimer
Thread-Topic: [PATCH v6 05/10] arm64: hyperv: Add interrupt handlers for VMbus
 and stimer
Thread-Index: AQHV+hZIL2+dATPWTUO/QTJHvYiYe6hK5JcAgAKDmoA=
Date:   Wed, 18 Mar 2020 00:16:24 +0000
Message-ID: <MW2PR2101MB1052B9C24DAB19FBBD818347D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-6-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2yve3R1w5igBYMy3HSFJ8Xt4BHhXQcaTAkNCdZXZ1v-w@mail.gmail.com>
In-Reply-To: <CAK8P3a2yve3R1w5igBYMy3HSFJ8Xt4BHhXQcaTAkNCdZXZ1v-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-18T00:16:20.9441965Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e59fef64-a88e-4099-a0a7-5202206f3831;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b4d1d31-7079-40ac-9080-08d7cad19821
x-ms-traffictypediagnostic: MW2PR2101MB1082:|MW2PR2101MB1082:|MW2PR2101MB1082:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10820477F2ABC223CB380717D7F70@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(10290500003)(55016002)(478600001)(7696005)(5660300002)(9686003)(54906003)(2906002)(7416002)(8990500004)(53546011)(33656002)(52536014)(6506007)(6916009)(76116006)(71200400001)(186003)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(316002)(86362001)(81156014)(8936002)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xF8Ah9zuqWyN9QDtpg8SSxKbHhqZEDf2V8epQ7kZlFNQqPPI7iBtVX3TqisVmGtucJOHRLlbCxTMa5rEW0Y7k5LtTFcrucJmjVDxmDlqtJ3kTnYv55VY2tI5QqjPtxp5J3pqXyn6HJvpubMvX/TkZM9xV08PwNGTVfl5bp7NRcb1OrHKp9gQ3M8+dco9QJc2NlDwWBRynHO9xAm1C4G0mMMS650PD8yPrkZJvcqBwAJWnY9146fZGXCr+YpBPWR6lj+vgz6xEuFM9ZJpYqmszz9JrsFku3UJpwcYmo87lW7F6fmglsDzkVPwR6M/+uM4xojXw/H415Cg4c15at1dFdVxojz4mGQ0OOvTMgXy56+HyZ/HYSJOX0/VprfTVTNnMOlPIY7lfd4KK399ARvSqElRhX/J0CmoEiOTVilNRZUJ4ldm3wyMjvWSCCyoVb3
x-ms-exchange-antispam-messagedata: cnlNzS7v6Iik7GxywXJaM7MQA/IVdu0I1SgxC8wQeYER9nPeoZWtEPMP3zuq7Wu92qd/8DvXAL2hUmRFv3wENjx32etDhTZ3xS1TjYnKwnbVPZFTaLDR5PXV6QajsaYuoSpjbOJMWI5F2gL8kVXqgg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4d1d31-7079-40ac-9080-08d7cad19821
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 00:16:24.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8LJbfOZREV7iGmqKzmRXubCOjcQpLLRpcyFp9ey5j6EOSGh1A08gDr7KisA2hDUexfw/dPzPMr9FheusIJ9//pBVsu5U2q7I1SONPxYEko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IE9uIFNhdCwgTWFyIDE0
LCAyMDIwIGF0IDQ6MzYgUE0gTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gQWRkIEFSTTY0LXNwZWNpZmljIGNvZGUgdG8gc2V0IHVwIGFuZCBo
YW5kbGUgdGhlIGludGVycnVwdHMNCj4gPiBnZW5lcmF0ZWQgYnkgSHlwZXItViBmb3IgVk1idXMg
bWVzc2FnZXMgYW5kIGZvciBzdGltZXIgZXhwaXJhdGlvbi4NCj4gPg0KPiA+IFRoaXMgY29kZSBp
cyBhcmNoaXRlY3R1cmUgZGVwZW5kZW50IGFuZCBpcyBtb3N0bHkgZHJpdmVuIGJ5DQo+ID4gYXJj
aGl0ZWN0dXJlIGluZGVwZW5kZW50IGNvZGUgaW4gdGhlIFZNYnVzIGRyaXZlciBhbmQgdGhlDQo+
ID4gSHlwZXItViB0aW1lciBjbG9ja3NvdXJjZSBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIGNvZGUg
aXMgYnVpbHQgb25seSB3aGVuIENPTkZJR19IWVBFUlYgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiAN
Cj4gVGhpcyBsb29rcyBsaWtlIGl0IHNob3VsZCBiZSBhIG5lc3RlZCBpcnFjaGlwIGRyaXZlciBp
bnN0ZWFkLCBzbyB5b3VyDQo+IGRldmljZSBkcml2ZXJzIGNhbiB1c2UgdGhlIG5vcm1hbCByZXF1
ZXN0X2lycSgpIGZ1bmN0aW9ucyBldGMuDQo+IA0KPiBJcyBhbnl0aGluZyBwcmV2ZW50aW5nIHlv
dSBmcm9tIGRvaW5nIHRoYXQ/IElmIHNvLCBwbGVhc2UgZGVzY3JpYmUNCj4gdGhhdCBpbiB0aGUg
Y2hhbmdlbG9nIGFuZCBpbiBhIGNvbW1lbnQgaW4gdGhlIGRyaXZlci4NCj4gDQoNCkFzIG1lbnRp
b25lZCBpbiBteSByZXBseSBvbiBQYXRjaCAxLCBIeXBlci1WIG9mZmVycyBhIGxpbWl0ZWQgc3lu
dGhldGljDQppbnRlcnJ1cHQgY29udHJvbGxlciBtYW5hZ2VkIGJ5IExpbnV4IGNvZGUgdGhhdCdz
IGJlZW4gYXJvdW5kIHRoZSBsYXN0DQoxMCB5ZWFycyBvbiB0aGUgeDg2IHNpZGUuICAgRm9yIHJl
YXNvbnMgdGhhdCBwcmUtZGF0ZSBtZSwgaXQgd2FzIG5vdCB3cml0dGVuDQphcyBhbiBpcnFjaGlw
IGRyaXZlci4NCg0KTW9kdWxvIHRoZSBzbWFsbCByb3V0aW5lcyB5b3Ugc2VlIGluIHRoaXMgcGF0
Y2gsIHRoZSBjb2RlIGlzIGFyY2hpdGVjdHVyZQ0KaW5kZXBlbmRlbnQsIGFuZCBpdCBzZWVtcyB3
ZSBvdWdodCB0byBrZWVwIHRoZSBoaWdoIGRlZ3JlZSBvZiBjb21tb25hbGl0eS4NClJlLWFyY2hp
dGVjdGluZyB0aGUgYXJjaCBpbmRlcGVuZGVudCBjb2RlIHRvIG1vZGVsIGFzIGFuIGlycWNoaXAg
ZHJpdmVyIHNlZW1zDQp0byBjYXJyeSBzb21lIHJpc2sgdG8gdGhlIHg4NiBzaWRlIHRoYXQgaGFz
IGEgbG90IG9mIHJlYWwtd29ybGQgdXNhZ2UgdG9kYXksIGJ1dA0KSSdsbCB0YWtlIGEgbG9vayBh
bmQgc2VlIHdoYXQgdGhlIHJpc2tzIGxvb2sgbGlrZSBhbmQgaWYgaXQgYWRkcyBhbnkgY2xhcml0
eS4NCg==
