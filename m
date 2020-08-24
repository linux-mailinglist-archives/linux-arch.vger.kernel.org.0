Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2625062F
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHXR3T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 13:29:19 -0400
Received: from mail-bn7nam10on2094.outbound.protection.outlook.com ([40.107.92.94]:8010
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbgHXR2y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 13:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE7d8SbJ/hzqZMxPoxRr5n94qBkttfrmf40crZaCujefU4xVGH8w9T2I827zTiqvXbWp69ZCn14eDVuOxB4ePshw9+wI0CPRw0NFgB+YwBzKfFMoxYRdGPdAHoYvWKxikMgY8kTJglhI6u7DJvID7xa6oZFHaBsPExrkLc1heFV90w2xVY37OVVVIme7a+fqUDSIkPUN8wGFg3zr8C46AD0YhjPbyRz0tiCgAiAvJrT4kmMK4shKvuTvkfn4EoNIGpSkS1mfYxigadlIToMh7uYX6Z2ZJSbbSeZmhbZzGKhdvyB7RBIwMZ9iNVlxas1KtWdUO0eIWFUrA/38MRdwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w47r0ISj5MxbOAsku3dBW5QCdk12SEKAyUZvokID1AA=;
 b=muKey2ED9UjcBrwpnV2mn3EwiBUbeyMPc1KZ5JWxiF83CMzhvmB/hYI/RM/uzo3xbNHClchhInn5zbzKMvOJb8GgKdiNqIu9fuuNHC0pIYdaWdDhARizhNGzODdwnsFEloT3/L9T6apYz0+bsYnjwiOTYHlEEN4qz80ZoGJkkOfy/9HA/bmYx5qPNo7ViKVPZ8hMy4yYu18BHfi18HeIlho2UO8KZMeZ4S+WE8XTxo+W1RfDJG82NUrCWACWioT1tx9cjMegRRiaSopONGKdrZS9TzT1Ryj4CLDeaD9OR84WTmBS7CGgCKCfE84enryDmx4XyGhQC5AA+R+Hiq3rDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w47r0ISj5MxbOAsku3dBW5QCdk12SEKAyUZvokID1AA=;
 b=O7p3Mxzw+DhJCHduIZI8TKA9Qkr9HompPgR7N8UwmwZB92A4JKj09QDiFujtaYh1oQAHItXhUu8uB5Klbyr39whRtCI2j+eZ+ApIuulphcAOGd2G0o9cIMSIoYonSuR726QdDfufuz+1qvySdA6NAbKN040ovlUY1G8ETj6+OyU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0831.namprd21.prod.outlook.com (2603:10b6:300:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.3; Mon, 24 Aug
 2020 17:28:49 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3305.021; Mon, 24 Aug 2020
 17:28:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v7 10/10] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Thread-Topic: [PATCH v7 10/10] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Thread-Index: AQHWejZWNuKXVWhQ2UWrPvmUu4ovzalHgkqAgAAA5dA=
Date:   Mon, 24 Aug 2020 17:28:49 +0000
Message-ID: <MW2PR2101MB1052425768531AC236A34A9AD7560@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-11-git-send-email-mikelley@microsoft.com>
 <CAMj1kXHKDD5+Na7t=bbkqo2OaiidmnJg+RqermV-2=exj-P77A@mail.gmail.com>
In-Reply-To: <CAMj1kXHKDD5+Na7t=bbkqo2OaiidmnJg+RqermV-2=exj-P77A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-24T17:28:47Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a9505d0a-9501-442b-b70a-16ad3083ebf1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85dd1319-049c-4d00-e9f1-08d8485329ea
x-ms-traffictypediagnostic: MWHPR21MB0831:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0831B9399071C3C02FFE673CD7560@MWHPR21MB0831.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5RWf4ytd2nunOxq6VYnCfUf77dt76MaBhrDjZI4ayKokrzrhnQD9Isrj0SPlmOwJPGn+QgxZcxAHfdoiZ0hDU3TvfC21ii9EBFDb04pGy3z/KoTuXjcGJnQEOQD5PPj/KVHywM6ipgbrJgxuqoEnsZeDsYJnKlcK9AY024oq5YGQgc6INuReImNmlWMUQ9W50J2elL2NNT2zPo1PXKzGpgMzXZvQvPAwNsyaCVbHlglL7aG20rR3zHPAGc+LsL+FsxkR5lZpEJoKn2nVBqfD4ejFDLfu9TFn9jhdmr7vHbiA4LSGNG3QQz4aaTi/RcsfdnLWm2nCOu7mtqqM3YW5fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(8676002)(10290500003)(26005)(186003)(82960400001)(9686003)(6916009)(4326008)(8990500004)(2906002)(66446008)(66556008)(64756008)(66476007)(82950400001)(66946007)(7416002)(55016002)(33656002)(54906003)(76116006)(83380400001)(7696005)(316002)(71200400001)(6506007)(52536014)(8936002)(478600001)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WfyxPdPvolm9lKSUV/rHcCWD2z9ALQJ7jZsVtBTViNXttpRcbtdk0N03juBRdJalCo+20EPjnDxYZGCmaL2e45niaRnBg7MvsarSuW2Cjl7QVUJvjcyLYKak2hKsSibVxhLGUor2++miuucUxzHDD6QuHI4Ea1nNcMmUxMjwpxZhs/0e5kyFf17f1Z4q+G6BUHb5CVii5xSKu34QcRdg4lQ3EeXLJc1U+lvYLReZhVtWGhfIVQRJNsOsoJxCgVLhoEoJW/vj1X1FKuELyFefeaKBsyMzTiLTfW2KGW9tPBE+eG8g0zZZ2df5rKV366jZa3VHL02Opqw4BDInRSb82dJaY012bhAppA1YmPw0zxu1t4DZFzKDZXQEU9RN7i1m1tqSSADC0yAspd470oFAP8bu1WkviMmzl9MjeHAZ8RyM9XpPxryUxQuAKuf8vcBUSmPJOPB1KE+dlasgWT3Br2Kd4ceS/zcAfwee4VHLUQQaxQh32XIjt1kP4ZUnXVIVo4+dPN2mlLp0MyIl1ZJdK/vKYJYuv+hb1bHBzvmT/J8VwpOo8sS78xAnhIHVNHZLfPbtUDYqwfCVEWs9ZO1FzVVFq5Z5VUPss8uCtRwWhhDm+nN9XHZ5WOfkJQpV5y+6+J9jBFMvL99pI6Y3Av5gXQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dd1319-049c-4d00-e9f1-08d8485329ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 17:28:49.3682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jk0JttJg02hOd615M/U5kTg3dhBjL3flhzOlxFjggj2R+kn/JjLU0KFyvzE1StjJ5fSuE99vs2rM/SoDi4Y0I6GlKRZ3hcoGSAa+LcBbqIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0831
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gU2VudDogTW9uZGF5LCBBdWd1
c3QgMjQsIDIwMjAgMTA6MjQgQU0NCj4gDQo+IE9uIE1vbiwgMjQgQXVnIDIwMjAgYXQgMTg6NDgs
IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0KPiA+
IFVwZGF0ZSBkcml2ZXJzL2h2L0tjb25maWcgc28gQ09ORklHX0hZUEVSViBjYW4gYmUgc2VsZWN0
ZWQgb24NCj4gPiBBUk02NCwgY2F1c2luZyB0aGUgSHlwZXItViBzcGVjaWZpYyBjb2RlIHRvIGJl
IGJ1aWx0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5
QG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaHYvS2NvbmZpZyB8IDMgKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L0tjb25maWcgYi9kcml2ZXJzL2h2L0tjb25m
aWcNCj4gPiBpbmRleCA3OWU1MzU2Li4xMTEzZTQ5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aHYvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvaHYvS2NvbmZpZw0KPiA+IEBAIC00LDcgKzQs
OCBAQCBtZW51ICJNaWNyb3NvZnQgSHlwZXItViBndWVzdCBzdXBwb3J0Ig0KPiA+DQo+ID4gIGNv
bmZpZyBIWVBFUlYNCj4gPiAgICAgICAgIHRyaXN0YXRlICJNaWNyb3NvZnQgSHlwZXItViBjbGll
bnQgZHJpdmVycyINCj4gPiAtICAgICAgIGRlcGVuZHMgb24gWDg2ICYmIEFDUEkgJiYgWDg2X0xP
Q0FMX0FQSUMgJiYgSFlQRVJWSVNPUl9HVUVTVA0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBBQ1BJ
ICYmIFwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAoKFg4NiAmJiBYODZfTE9DQUxfQVBJ
QyAmJiBIWVBFUlZJU09SX0dVRVNUKSB8fCBBUk02NCkNCj4gPiAgICAgICAgIHNlbGVjdCBQQVJB
VklSVA0KPiA+ICAgICAgICAgc2VsZWN0IFg4Nl9IVl9DQUxMQkFDS19WRUNUT1INCj4gPiAgICAg
ICAgIGhlbHANCj4gDQo+IEdpdmVuIHRoZSBjb21tZW50IGluIGEgcHJldmlvdXMgcGF0Y2gNCj4g
DQo+ICsvKg0KPiArICogQWxsIGRhdGEgc3RydWN0dXJlcyBkZWZpbmVkIGluIHRoZSBUTEZTIHRo
YXQgYXJlIHNoYXJlZCBiZXR3ZWVuIEh5cGVyLVYNCj4gKyAqIGFuZCBhIGd1ZXN0IFZNIHVzZSBM
aXR0bGUgRW5kaWFuIGJ5dGUgb3JkZXJpbmcuICBUaGlzIG1hdGNoZXMgdGhlIGRlZmF1bHQNCj4g
KyAqIGJ5dGUgb3JkZXJpbmcgb2YgTGludXggcnVubmluZyBvbiBBUk02NCwgc28gbm8gc3BlY2lh
bCBoYW5kbGluZyBpcyByZXF1aXJlZC4NCj4gKyAqLw0KPiANCj4gc2hvdWxkbid0IHRoaXMgZGVw
ZW5kIG9uICFDT05GSUdfQ1BVX0JJR19FTkRJQU4gPw0KDQpZZXMgaW5kZWVkLiAgSSdsbCBhZGQg
aXQuDQoNCk1pY2hhZWwNCg==
