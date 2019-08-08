Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDDE85E8A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbfHHJcq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 05:32:46 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:1601
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732076AbfHHJcp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 05:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHYOkepV1GeGGpuIlCr9zOnX82EtrrYCPqngyYpjKfA=;
 b=9UfFfaQ+4SYoyXV7ZvuRbmk9SAgEiKnJiNT9CRBSLyag0jBLP4O1g7qFwCpGR85g10Kgd1oipo5h9TDNCxnHX/ne5/wjY0+QDl4ZG6HyD4/kOGpYH7YLBKqSsrQMI9zSTE2tTjhAY0f4f7jE2QcMcjtHXANMtm8HDtjMbNVemTI=
Received: from AM4PR08CA0078.eurprd08.prod.outlook.com (2603:10a6:205:2::49)
 by AM5PR0801MB1842.eurprd08.prod.outlook.com (2603:10a6:203:3c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.13; Thu, 8 Aug
 2019 09:32:39 +0000
Received: from AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by AM4PR08CA0078.outlook.office365.com
 (2603:10a6:205:2::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.18 via Frontend
 Transport; Thu, 8 Aug 2019 09:32:39 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT022.mail.protection.outlook.com (10.152.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 8 Aug 2019 09:32:37 +0000
Received: ("Tessian outbound 6d016ca6b65d:v26"); Thu, 08 Aug 2019 09:32:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0a296c13c8d686c1
X-CR-MTA-TID: 64aa7808
Received: from fe0455a3223b.1 (cr-mta-lb-1.cr-mta-net [104.47.9.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 37286508-3FF9-42C0-9BA4-07CB454BDCFD.1;
        Thu, 08 Aug 2019 09:32:30 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fe0455a3223b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 08 Aug 2019 09:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNYT9+cPojR0fy5n3n2eXgB7wyrqX66VMD4CTtPloAQblioreC6bYWnTvl0s8SvYPioWQz7fKr6uBNAGtiawH4zY6UR6jkbB3sUP+bkymI8ejeK8b0YqD5LeFTxKNZdl5UCm1725rNLpn121EBbjUX3ZzAZzcP6sMdapHxTuT+dUvhSwkfOaD0Rp5qnP+ZsF3TzvHBNn9I8wFJEF/q3+WGlOFjgrYeCA2R7oe5RLZseh/n/a92AmHcdGjVw80wzI04+kH5mcxO5W7OAAo7cxxPUNjrIzOTu8eDjlLjQqbZFoA1/C72aihzHSuFiiyOAG00PalByvksH7jfWARzCM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHYOkepV1GeGGpuIlCr9zOnX82EtrrYCPqngyYpjKfA=;
 b=MEECGjx7vRrX01RKz19SkVLegQgZqzUhEiLfK5HcrOLFP+vscDPoUpzVPJF9JIMZa90WGCTsa7f5Lgc2ehU0T40S4QqiM3rQD/tCR91RDLPDUan07jCtM2gEJpFL+pTOISTKQxh8/hqamxfWMdcVGXeEoYPdgLtCMUWuqxg149ZmCzd125b61TpJ3MkP5sDas7guwD87zlnhF852OW83ga+ZftEH4J1FsWxOUen3WgUCPnDf7Qjs424iSpitvhfcBz9/iTjsE71InIkDQHkwiSzsxwvN0t6tHb70wxKGOjB4TT+2O55DuQ/rjxqJbz39wVVgtKVlrvyxfCcFz7bcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHYOkepV1GeGGpuIlCr9zOnX82EtrrYCPqngyYpjKfA=;
 b=9UfFfaQ+4SYoyXV7ZvuRbmk9SAgEiKnJiNT9CRBSLyag0jBLP4O1g7qFwCpGR85g10Kgd1oipo5h9TDNCxnHX/ne5/wjY0+QDl4ZG6HyD4/kOGpYH7YLBKqSsrQMI9zSTE2tTjhAY0f4f7jE2QcMcjtHXANMtm8HDtjMbNVemTI=
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com (10.172.219.8) by
 AM4PR0802MB2161.eurprd08.prod.outlook.com (10.172.216.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 8 Aug 2019 09:32:28 +0000
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a]) by AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 09:32:28 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     nd <nd@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        "Will Deacon" <Will.Deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Kevin Brodsky" <Kevin.Brodsky@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v7 0/2] arm64 tagged address ABI
Thread-Topic: [PATCH v7 0/2] arm64 tagged address ABI
Thread-Index: AQHVTThJ40O32AFbdkapzf5hdYvQPKbw/fAA
Date:   Thu, 8 Aug 2019 09:32:28 +0000
Message-ID: <44bc76f2-e782-b3ac-5ba3-39ef59be6fe9@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
In-Reply-To: <20190807155321.9648-1-catalin.marinas@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::16) To AM4PR0802MB2307.eurprd08.prod.outlook.com
 (2603:10a6:200:61::8)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6284d217-1348-4e77-4803-08d71be35a0a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2161;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2161:|AM5PR0801MB1842:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1842E17C84683EF54D5206C8EDD70@AM5PR0801MB1842.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 012349AD1C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(51914003)(199004)(189003)(6512007)(52116002)(53936002)(6306002)(86362001)(25786009)(7736002)(99286004)(71190400001)(71200400001)(476003)(36756003)(102836004)(386003)(53546011)(6506007)(44832011)(256004)(486006)(4326008)(6246003)(14444005)(76176011)(2616005)(11346002)(446003)(186003)(5660300002)(26005)(66946007)(66476007)(66556008)(64756008)(66446008)(31696002)(2501003)(6116002)(14454004)(966005)(65806001)(65956001)(66066001)(3846002)(65826007)(478600001)(6486002)(81156014)(81166006)(2906002)(54906003)(110136005)(316002)(58126008)(229853002)(305945005)(64126003)(8676002)(6436002)(31686004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2161;H:AM4PR0802MB2307.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: J9dX/k4JAEpDfgQngapDQX+XDLGM7ZFTbwydZBC6Z3zgrQ9ru0UIK3K0O5KbJHygMiaPqr7pf99rX9339bsh8hGV4YJFCZq+Sr9fSRtrTY9BTzDjFs1rYvGRTIWSQM7FpE34XS7HjBOHelFCOXr6iliQvv8uNE+mNadecBuzpZGuyJfha/CNbJub4fOU1lLYNnNyiZTF+1IUDvtPAr9BaopcbcLnEnEcE8jgpzkOxXbqWEyhcVYfXm1vFq1VBd3HmfQb842Cj6f3M2dQu6E19H3smK67QLz0MdKtZhivv49DQqOoSrWubwmtInENCR1FfwvFAg09OwVJT7llb81RomBvF7Uwq4py/NbHOIdsASVpXyCfLuLNMMp1K4max8vZbxd2oyrnqgAl+vPDV1kYQ62TndMtS3DRHfH6VwEdyNU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E89EAA9961235F47ADB26CEFBCAEB557@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2161
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: =?utf-8?B?Q0lQOjYzLjM1LjM1LjEyMztJUFY6Q0FMO1NDTDotMTtDVFJZOklFO0VGVjpO?=
 =?utf-8?B?TEk7U0ZWOk5TUE07U0ZTOigxMDAwOTAyMCkoNDYzNjAwOSkoMzQ2MDAyKSgz?=
 =?utf-8?B?NzYwMDIpKDM5NjAwMykoMTM2MDAzKSgzOTg2MDQwMDAwMikoMjk4MDMwMDAw?=
 =?utf-8?B?MikoMTg5MDAzKSgxOTkwMDQpKDUxOTE0MDAzKSg3NjEzMDQwMDAwMSkoNjU4?=
 =?utf-8?B?MDYwMDEpKDY2MDY2MDAxKSg2NTk1NjAwMSkoMjI5ODUzMDAyKSgzMTY4NjAw?=
 =?utf-8?B?NCkoODkzNjAwMikoNzA1ODYwMDcpKDcwMjA2MDA2KSgxMTAxMzYwMDUpKDU2?=
 =?utf-8?B?NjAzMDAwMDIpKDY0ODYwMDIpKDMwNTk0NTAwNSkoNTgxMjYwMDgpKDc3MzYw?=
 =?utf-8?B?MDIpKDYzMDYwMDIpKDY1MTIwMDcpKDU0OTA2MDAzKSgzMTYwMDIpKDgxMTU2?=
 =?utf-8?B?MDE0KSg4MTE2NjAwNikoNjExNjAwMikoMzg0NjAwMikoNDc3NzYwMDMpKDI5?=
 =?utf-8?B?MDYwMDIpKDM2OTA2MDA1KSgyMjc1NjAwNikoODY3NjAwMikoOTkyODYwMDQp?=
 =?utf-8?B?KDE0NDQ0MDA1KSgyNTAxMDAzKSgxNDQ1NDAwNCkoNzYxNzYwMTEpKDI2ODI2?=
 =?utf-8?B?MDAzKSgyMzY3NjAwNCkoMjQ4NjAwMykoOTY2MDA1KSg1MDQ2NjAwMikoMjU3?=
 =?utf-8?B?ODYwMDkpKDMzNjAxMikoNjI0NjAwMykoMjYwMDUpKDQzMjYwMDgpKDE4NjAw?=
 =?utf-8?B?MykoMTA3ODg2MDAzKSg0NTAxMDAwMDIpKDEyNjAwMikoMTAyODM2MDA0KSg0?=
 =?utf-8?B?Nzg2MDAwMDEpKDY0MTI2MDAzKSgzNjc1NjAwMykoNDg2MDA2KSg2MzM3MDQw?=
 =?utf-8?B?MDAwMSkoMjYxNjAwNSkoNDQ2MDAzKSgxMTM0NjAwMikoMzg2MDAzKSg0NzYw?=
 =?utf-8?B?MDMpKDQzNjAwMykoNjMzNTA0MDAwMDEpKDUzNTQ2MDExKSg2NTA2MDA3KSgz?=
 =?utf-8?B?MTY5NjAwMikoODYzNjIwMDEpKDM1NjAwNCkoNjU4MjYwMDcpO0RJUjpPVVQ7?=
 =?utf-8?B?U0ZQOjExMDE7U0NMOjE7U1JWUjpBTTVQUjA4MDFNQjE4NDI7SDo2NGFhNzgw?=
 =?utf-8?B?OC1vdXRib3VuZC0xLm10YS5nZXRjaGVja3JlY2lwaWVudC5jb207RlBSOjtT?=
 =?utf-8?B?UEY6VGVtcEVycm9yO0xBTkc6ZW47UFRSOmVjMi02My0zNS0zNS0xMjMuZXUt?=
 =?utf-8?Q?west-1.compute.amazonaws.com;MX:1;A:1;?=
X-MS-Office365-Filtering-Correlation-Id-Prvs: 49eee5c6-97b4-48e5-b903-08d71be3541c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0801MB1842;
NoDisclaimer: True
X-Forefront-PRVS: 012349AD1C
X-Microsoft-Antispam-Message-Info: tNQiHD/FpOAZcipLGhOZDQlNL2dsqROD7nZXZw7PIaTnvXF42rQlKhpb/UVwO1AEKocz+0jgjWkaKQTVdym5XWWdMYXZV8N54VKn8tf+IYloReXvJcG573EeHEoOc/FpsNTVG87QfW0HtopBB9yMv+KaM2bn67s3PQVK31Wa74NmY1XYc+J0P7uVtFsejq+UgoTuRL7ulyhakWiTi+MZkwNajf2MPULm2u4zLKyjL+xs9yQYc6paNAJmL3IqJ5Oeh6iZl1dwMwx2p6JedXfGF4m1XIqRBvQ+qN0gDJT/78Mc4QMrztNYC2OBQaYC1rFeOxKFfjvZFP1AmTR8gFK+AxuIGCpvPWo9rxTU0jjcQ8qBAHlvKGKhxSjsl32cFzbxkI1zXM32vGwtgQu5/I2e+a8c3bJlKPXPN7cXEcIrchY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2019 09:32:37.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6284d217-1348-4e77-4803-08d71be35a0a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1842
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDcvMDgvMjAxOSAxNjo1MywgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIHNvIGZhci4gVGhpcyBpcyBhbiB1cGRhdGVkIHNlcmll
cyBkb2N1bWVudGluZw0KPiB0aGUgQUFyY2g2NCBUYWdnZWQgQWRkcmVzcyBBQkkgYXMgaW1wbGVt
ZW50ZWQgYnkgdGhlc2UgcGF0Y2hlczoNCj4gDQo+IGh0dHA6Ly9sa21sLmtlcm5lbC5vcmcvci9j
b3Zlci4xNTYzOTA0NjU2LmdpdC5hbmRyZXlrbnZsQGdvb2dsZS5jb20NCj4gDQo+IFZlcnNpb24g
NiBvZiB0aGUgZG9jdW1lbnRhdGlvbiBzZXJpZXMgaXMgYXZhaWxhYmxlIGhlcmU6DQo+IA0KPiBo
dHRwOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTA3MjUxMzUwNDQuMjQzODEtMS12aW5jZW56by5m
cmFzY2lub0Bhcm0uY29tDQo+IA0KPiBDaGFuZ2VzIGluIHY3Og0KPiANCj4gLSBEcm9wcGVkIHRo
ZSBNQVBfUFJJVkFURSByZXF1aXJlbWVudHMgZm9yIHRhZ2dlZCBwb2ludGVycyBmb3IgYm90aA0K
PiAgIGFub255bW91cyBhbmQgZmlsZSBtYXBwaW5ncy4gT25lIHJlYXNvbiBpcyB0aGF0IHdlIGNh
bid0IGVuZm9yY2Ugc3VjaA0KPiAgIHJlc3RyaWN0aW9uIGFueXdheS4gVGhlIG90aGVyIHJlYXNv
biBpcyB0aGF0IGEgZnV0dXJlIHNlcmllcw0KPiAgIGltcGxlbWVudGluZyBzdXBwb3J0IGZvciB0
aGUgaGFyZHdhcmUgTVRFIHdpbGwgZGV0ZWN0DQo+ICAgaW5jb21wYXRpYmlsaXRpZXMgb2YgdGhl
IG5ldyBQUk9UX01URSBmbGFnIHdpdGggdmFyaW91cyBtbWFwKCkNCj4gICBvcHRpb25zLg0KDQpP
Sy4NCg0KPiAtIEFzIGEgY29uc2VxdWVuY2Ugb2YgdGhlIGFib3ZlLCBJIHJlbW92ZWQgU3phYm9s
Y3MgYWNrIGFzIEknbSBub3Qgc3VyZQ0KPiAgIGhlJ3Mgb2sgd2l0aCB0aGUgY2hhbmdlLg0KPiAN
Cj4gLSBDbGFyaWZpZWQgdGhlIHN5c2N0bCBhbmQgcHJjdGwoKSBpbnRlcmFjdGlvbiBhbmQgcmVv
cmRlcmVkIHRoZQ0KPiAgIGRlc2NyaXB0aW9ucy4NCj4gDQo+IC0gUmV3b3JkZWQgdGhlIHByY3Rs
KFBSX1NFVF9NTSkgcmVzdHJpY3Rpb25zLg0KPiANCj4gLSBSZW1vdmVkIHRoZSBkZXNjcmlwdGlv
biBvZiB0aGUgdGFnIHByZXNlcnZhdGlvbiBmcm9tIHRoZSBmaXJzdCBwYXRjaA0KPiAgIGFzIGl0
IGRpZG4ndCByZWFsbHkgbWFrZSBzZW5zZSAodGhlIHN5c2NhbGwgQUJJIGhhcyBhbHdheXMgcHJl
c2VydmVkDQo+ICAgYWxsIHJlZ2lzdGVycyBvdGhlciB0aGFuIHgwIG9uIHJldHVybiB0byB1c2Vy
KS4NCg0KcHJlc2VydmF0aW9uIGlzIG1vcmUgaW50ZXJlc3Rpbmcgd2hlbiBhIHVzZXIgcG9pbnRl
cg0KaXMgcGFzc2VkIHRvIHRoZSBrZXJuZWwgYW5kIGxhdGVyIGl0IGlzIHBhc3NlZCBiYWNrDQp0
byB1c2VyIHNwYWNlIChlLmcuIHNldC9nZXRfcm9idXN0X2xpc3QsIG9yIHNpZ2FjdGlvbg0Kd2hl
cmUgb2xkIGhhbmRsZXIgcG9pbnRlciBpcyByZXR1cm5lZCksIHRoZW4gdGhlDQprZXJuZWwgbWF5
IHdhbnQgdG8gZHJvcCB0aGUgdGFnIHRvIGRvIHNvbWV0aGluZyB3aXRoDQp0aGUgcG9pbnRlciwg
YnV0IHVzZXIgc3BhY2UgbWF5IHdhbnQgaXQgdG8gYmUgcHJlc2VydmVkLg0KDQppbiBwcmluY2lw
bGUgc2VnZmF1bHQgc2lfYWRkciBpcyBhIHNpbWlsYXIgY2FzZSB3aGVuDQptZW1vcnkgYWNjZXNz
IHZpYSB0YWdnZWQgcG9pbnRlciBmYXVsdHM6IGN1cnJlbnRseQ0KdGhlIGtlcm5lbCBkb2VzIG5v
dCBwcmVzZXJ2ZSB0aGUgdGFnLg0KDQpzbyBpIHRoaW5rIGl0J3MgaW50ZXJlc3RpbmcgdG8ga25v
dyB3aGVuIGV4YWN0bHkgdGhlDQprZXJuZWwgcHJlc2VydmVzIHRoZSB0YWdzLCBidXQgaXQgbWF5
IG5vdCBiZSBlYXN5IHRvDQpkb2N1bWVudCBpbiBhIGdlbmVyaWMgd2F5Lg0KDQo+IA0KPiAtIHMv
QVJNNjQvQUFyY2g2NC8gZm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIHRhZ2dlZC1wb2ludGVycy5y
c3QNCj4gICBkb2N1bWVudC4NCj4gDQo+IC0gT3RoZXIgbWlub3IgcmV3b3JkaW5ncy4NCj4gDQo+
IFZpbmNlbnpvIEZyYXNjaW5vICgyKToNCj4gICBhcm02NDogRGVmaW5lIERvY3VtZW50YXRpb24v
YXJtNjQvdGFnZ2VkLWFkZHJlc3MtYWJpLnJzdA0KPiAgIGFybTY0OiBSZWxheCBEb2N1bWVudGF0
aW9uL2FybTY0L3RhZ2dlZC1wb2ludGVycy5yc3QNCj4gDQo+ICBEb2N1bWVudGF0aW9uL2FybTY0
L3RhZ2dlZC1hZGRyZXNzLWFiaS5yc3QgfCAxNTEgKysrKysrKysrKysrKysrKysrKysrDQo+ICBE
b2N1bWVudGF0aW9uL2FybTY0L3RhZ2dlZC1wb2ludGVycy5yc3QgICAgfCAgMjMgKysrLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxNjcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2FybTY0L3RhZ2dlZC1hZGRyZXNzLWFiaS5y
c3QNCj4gDQoNCg==
