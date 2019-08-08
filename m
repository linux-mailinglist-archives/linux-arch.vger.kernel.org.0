Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC868671C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbfHHQaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 12:30:20 -0400
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:10816
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfHHQaT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 12:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNoaE82fbwF1pLpierq5ugKy9VddWwueDEfMzm07Qc=;
 b=7LUZFP4Z7EFFGreUlxmsqBzKd137RlC0g9WbCpKTxrn6MM2SGKCOYXqvQIUEGGKOKbRAA01DgKHBU2Wt9Q3iEvqYhaB5Xt5tobV3fPSiAgosyrL4iH6DTXB9VMtyTx/CnW7Xr2O9jUnqaJfIInLoHtsgi+vQA1e+t8VGL1/jAso=
Received: from DB7PR08CA0066.eurprd08.prod.outlook.com (2603:10a6:10:26::43)
 by VI1PR0802MB2608.eurprd08.prod.outlook.com (2603:10a6:800:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Thu, 8 Aug
 2019 16:30:13 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by DB7PR08CA0066.outlook.office365.com
 (2603:10a6:10:26::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.18 via Frontend
 Transport; Thu, 8 Aug 2019 16:30:13 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 8 Aug 2019 16:30:11 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Thu, 08 Aug 2019 16:30:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5dc4d4d36e4d8eae
X-CR-MTA-TID: 64aa7808
Received: from 4ec352b2b000.1 (cr-mta-lb-1.cr-mta-net [104.47.9.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 97789F70-CE43-4B58-9E3F-625BD6BD1D00.1;
        Thu, 08 Aug 2019 16:30:04 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4ec352b2b000.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 08 Aug 2019 16:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bixfryjyP5uhqQNBOQVJI8hHrvCuPbrLE+84f3MrCaN8ECiXUFc8wLrxjO1ZaYWOnUKMrwc1TXx4HiGPiGnfkVjPYHeES51KgucH2rLtg1U5xlgMdyCCn8Nudq6px8HQFCut09SHhkC1dUI4ckUAocnvjponY5mtps1M8EUVQnZxYMRhs1XCp9jyPSne0xdq/qTQ09u+NAgDDIJ6N6wwhS6yKPciI9sJYonLELvgK0YXdJbVK7dlVtDEC1BGUSsa6SFAsXRyJtG1iEstM/bXjHCByqpDN4q3P1LbXRQH2xKNDOkauwPblT0grpbvkQ2/jf4mjX2aEpt9yERMLXAZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNoaE82fbwF1pLpierq5ugKy9VddWwueDEfMzm07Qc=;
 b=TVFbf1Y3uEHg5hNAKBVMULbZEgtn2/UHdSWBAZQg5WSaBMhpHprdMkNnY8RYcA6gKyOGPCqh+HKK/bVCkVE/HqG/2KpMmt2jMPZhdIyl2klY1HAzgl+0BDGEXgnwaW30X0r/8ywFgKfHTp0x2wlarh1AMJRbKmJoGWp/0+xElydjyYvkWzs34XGg32fS6+pswb7E2d73XzQpkQj6hyaLZyv7zoRfu6/VQCZENldsyuvcY4Me8sG5bpeht9ibRmICH+mtQSfKjrI7knI/sMraYYk4UCOM4eUkWTXHdxCkKYuu30798uCaK3FXfHNK6i7yKf3/gqYecUTAnVLUI4p2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNoaE82fbwF1pLpierq5ugKy9VddWwueDEfMzm07Qc=;
 b=7LUZFP4Z7EFFGreUlxmsqBzKd137RlC0g9WbCpKTxrn6MM2SGKCOYXqvQIUEGGKOKbRAA01DgKHBU2Wt9Q3iEvqYhaB5Xt5tobV3fPSiAgosyrL4iH6DTXB9VMtyTx/CnW7Xr2O9jUnqaJfIInLoHtsgi+vQA1e+t8VGL1/jAso=
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com (10.172.219.8) by
 AM4PR0802MB2226.eurprd08.prod.outlook.com (10.172.215.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Thu, 8 Aug 2019 16:30:02 +0000
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a]) by AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 16:30:01 +0000
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
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Thread-Topic: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Thread-Index: AQHVTThJtBlc8zHC8EmoKLcy3EHPqqbxcpmA
Date:   Thu, 8 Aug 2019 16:30:01 +0000
Message-ID: <c73e76dd-de90-f5de-7809-5118270471c8@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
In-Reply-To: <20190807155321.9648-2-catalin.marinas@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::19) To AM4PR0802MB2307.eurprd08.prod.outlook.com
 (2603:10a6:200:61::8)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2fde6dd0-bc8b-4e9c-7254-08d71c1daf56
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2226;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2226:|VI1PR0802MB2608:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB26083232E3A40BDF761652F4EDD70@VI1PR0802MB2608.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 012349AD1C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(51444003)(199004)(189003)(31696002)(86362001)(66946007)(2616005)(486006)(476003)(76176011)(66476007)(4326008)(64126003)(81156014)(8936002)(66556008)(81166006)(64756008)(6486002)(8676002)(66446008)(44832011)(256004)(7736002)(71200400001)(305945005)(6436002)(71190400001)(229853002)(53936002)(6512007)(14454004)(2501003)(3846002)(6116002)(65826007)(99286004)(5660300002)(6246003)(25786009)(54906003)(316002)(58126008)(110136005)(446003)(2906002)(186003)(36756003)(26005)(53546011)(102836004)(478600001)(386003)(66066001)(65806001)(31686004)(6506007)(65956001)(11346002)(52116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2226;H:AM4PR0802MB2307.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: vHduti/4snOd9pz4x3iZLF0uY8tXP+GK0Vt+kjPorCd7n2gnQgGc9ZmDxgRejwcKBCoFpzNaJEPgSddy+R/D8lDeoZdmLvoPJk5sXI7vcB4mJ5f57h+czM98hZTiHd9ZpWvp9qyOFeeDJvn2JWgh8WwUKdIGFy8Rw+Z1taHHMmYb7LPSnvQy4GF0B7cscAUym9kpuOktqm3cdYkqMhVI5KSqW67XlRMM/Z6vuT648xazc21TDMLCnuL44ShDwbHPp6TF1yt4jvWw526CyCcZBCt8oe3GPKY71aVi1h2yTfhaVL/pClmcdPUGv8udPxgZx8TqEQgKSEbM9O20gvQ3hTvnuci4eF9kSiJ8+EKuMGcTfI2hiJ7NqRQfHrpFr7OG1qaWY59eoXOF/BZWIS1pD8iGXFtzU0TE/rvtrrSJJIY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2416489F113EC049B7C1E80E7213516F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2226
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: =?utf-8?B?Q0lQOjYzLjM1LjM1LjEyMztJUFY6Q0FMO1NDTDotMTtDVFJZOklFO0VGVjpO?=
 =?utf-8?B?TEk7U0ZWOk5TUE07U0ZTOigxMDAwOTAyMCkoOTc5MDAyKSg0NjM2MDA5KSgz?=
 =?utf-8?B?OTg2MDQwMDAwMikoMzk2MDAzKSgzNDYwMDIpKDEzNjAwMykoMzc2MDAyKSgy?=
 =?utf-8?B?OTgwMzAwMDAyKSg1MTQ0NDAwMykoMTg5MDAzKSgxOTkwMDQpKDMwNTk0NTAw?=
 =?utf-8?B?NSkoNjU4MjYwMDcpKDc3MzYwMDIpKDg2MzYyMDAxKSgxMDc4ODYwMDMpKDM1?=
 =?utf-8?B?NjAwNCkoNjExNjAwMikoNjQ4NjAwMikoMzE2ODYwMDQpKDYyNDYwMDMpKDIy?=
 =?utf-8?B?NzU2MDA2KSgyOTA2MDAyKSg3MDIwNjAwNikoNjUxMjAwNykoNTA0NjYwMDIp?=
 =?utf-8?B?KDc2MTMwNDAwMDAxKSgyMjk4NTMwMDIpKDcwNTg2MDA3KSg1NjYwMzAwMDAy?=
 =?utf-8?B?KSg4Njc2MDAyKSgzMTY5NjAwMikoODExNjYwMDYpKDgxMTU2MDE0KSgxODYw?=
 =?utf-8?B?MDMpKDg5MzYwMDIpKDY0MTI2MDAzKSgzODQ2MDAyKSgyNTAxMDAzKSgyNjAw?=
 =?utf-8?B?NSkoNDQ2MDAzKSg5OTI4NjAwNCkoNDM2MDAzKSgxNDQ1NDAwNCkoMTEzNDYw?=
 =?utf-8?B?MDIpKDQ3NjAwMykoMjYxNjAwNSkoNjMzNzA0MDAwMDEpKDYzMzUwNDAwMDAx?=
 =?utf-8?B?KSgzNjc1NjAwMykoMzM2MDEyKSgxMjYwMDIpKDU4MTI2MDA4KSg0ODYwMDYp?=
 =?utf-8?B?KDU0OTA2MDAzKSgxMTAxMzYwMDUpKDI2ODI2MDAzKSgyNTc4NjAwOSkoNDc4?=
 =?utf-8?B?NjAwMDAxKSg2NTk1NjAwMSkoMjM2NzYwMDQpKDQ3Nzc2MDAzKSgyNDg2MDAz?=
 =?utf-8?B?KSg2NjA2NjAwMSkoNzYxNzYwMTEpKDY1ODA2MDAxKSgxMDI4MzYwMDQpKDMx?=
 =?utf-8?B?NjAwMikoMzg2MDAzKSg0NTAxMDAwMDIpKDUzNTQ2MDExKSg0MzI2MDA4KSg2?=
 =?utf-8?B?NTA2MDA3KSg5NjkwMDMpKDk4OTAwMSkoOTk5MDAxKSgxMDA5MDAxKSgxMDE5?=
 =?utf-8?B?MDAxKTtESVI6T1VUO1NGUDoxMTAxO1NDTDoxO1NSVlI6VkkxUFIwODAyTUIy?=
 =?utf-8?B?NjA4O0g6NjRhYTc4MDgtb3V0Ym91bmQtMS5tdGEuZ2V0Y2hlY2tyZWNpcGll?=
 =?utf-8?B?bnQuY29tO0ZQUjo7U1BGOlRlbXBFcnJvcjtMQU5HOmVuO1BUUjplYzItNjMt?=
 =?utf-8?B?MzUtMzUtMTIzLmV1LXdlc3QtMS5jb21wdXRlLmFtYXpvbmF3cy5jb207TVg6?=
 =?utf-8?Q?1;A:1;?=
X-MS-Office365-Filtering-Correlation-Id-Prvs: bd58a293-aa05-4b53-ddea-08d71c1da909
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0802MB2608;
NoDisclaimer: True
X-Forefront-PRVS: 012349AD1C
X-Microsoft-Antispam-Message-Info: pXDsZlgCmjY0mWK3qwaqtxCpYQd8Ll0vi58SjH7OgMUSkI621DkIJU14leEmcIV+BWuazYTwPNbhd3RFZnH8Gv3CWrKb4gYQSutFWzFHHmmx4v5im7CIqT8CIIjGWCdrjELgn2cCPSWyJo8JJKRiobeTYuIqOQSjXCjuWa4j13U0JNxqnNxWGjFkhuI+E3AseC05SAeZ0m3kM+/uGZg0AfZyxCtHz5bHsP4cHwrTftGvUUCrouKi2zP3xqiYD48rxi4ouxR99fx8JJB8B7TPGjgO4hMBpze8yCASjhOzk9mnUIsOOjTM6+u8+NYr8Y0WUPVVkLPgFX7OX0jNWn/XakNxrXrtgC/jdRQJtlrP9rJys40BzqSgG7JqXlNkKOuqEcJGNSCMxIGVvFHB6WCJDQ6Lgbzbp+FkJVy8ViafV9E=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2019 16:30:11.6751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fde6dd0-bc8b-4e9c-7254-08d71c1daf56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2608
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDcvMDgvMjAxOSAxNjo1MywgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOg0KPiBGcm9tOiBWaW5j
ZW56byBGcmFzY2lubyA8dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbT4NCj4gDQo+IE9uIGFybTY0
IHRoZSBUQ1JfRUwxLlRCSTAgYml0IGhhcyBiZWVuIGFsd2F5cyBlbmFibGVkIGhlbmNlDQo+IHRo
ZSB1c2Vyc3BhY2UgKEVMMCkgaXMgYWxsb3dlZCB0byBzZXQgYSBub24temVybyB2YWx1ZSBpbiB0
aGUNCj4gdG9wIGJ5dGUgYnV0IHRoZSByZXN1bHRpbmcgcG9pbnRlcnMgYXJlIG5vdCBhbGxvd2Vk
IGF0IHRoZQ0KPiB1c2VyLWtlcm5lbCBzeXNjYWxsIEFCSSBib3VuZGFyeS4NCj4gDQo+IFdpdGgg
dGhlIHJlbGF4ZWQgQUJJIHByb3Bvc2VkIHRocm91Z2ggdGhpcyBkb2N1bWVudCwgaXQgaXMgbm93
IHBvc3NpYmxlDQo+IHRvIHBhc3MgdGFnZ2VkIHBvaW50ZXJzIHRvIHRoZSBzeXNjYWxscywgd2hl
biB0aGVzZSBwb2ludGVycyBhcmUgaW4NCj4gbWVtb3J5IHJhbmdlcyBvYnRhaW5lZCBieSBhbiBh
bm9ueW1vdXMgKE1BUF9BTk9OWU1PVVMpIG1tYXAoKS4NCg0KZGVzY3JpcHRpb24gbmVlZHMgdG8g
YmUgdXBkYXRlZCBub3QgdG8gcmVzdHJpY3QgdGFncw0KdG8gYW5vbiBtbWFwLg0KDQo+ICszLiBB
QXJjaDY0IFRhZ2dlZCBBZGRyZXNzIEFCSSBFeGNlcHRpb25zDQo+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICtUaGUgYmVoYXZpb3VyIGRlc2NyaWJl
ZCBpbiBzZWN0aW9uIDIsIHdpdGggcGFydGljdWxhciByZWZlcmVuY2UgdG8gdGhlDQo+ICthY2Nl
cHRhbmNlIGJ5IHRoZSBzeXNjYWxscyBvZiBhbnkgdmFsaWQgdGFnZ2VkIHBvaW50ZXIsIGlzIG5v
dCBhcHBsaWNhYmxlDQo+ICt0byB0aGUgZm9sbG93aW5nIGNhc2VzOg0KPiArDQo+ICstIG1tYXAo
KSBhZGRyIHBhcmFtZXRlci4NCj4gKw0KPiArLSBtcmVtYXAoKSBuZXdfYWRkcmVzcyBwYXJhbWV0
ZXIuDQo+ICsNCj4gKy0gcHJjdGwoUFJfU0VUX01NLCBgYCpgYCwgLi4uKSBvdGhlciB0aGFuIGFy
ZzIgUFJfU0VUX01NX01BUCBhbmQNCj4gKyAgUFJfU0VUX01NX01BUF9TSVpFLg0KPiArDQo+ICst
IHByY3RsKFBSX1NFVF9NTSwgUFJfU0VUX01NX01BUHssX1NJWkV9LCAuLi4pIHN0cnVjdCBwcmN0
bF9tbV9tYXAgZmllbGRzLg0KPiArDQo+ICtBbnkgYXR0ZW1wdCB0byB1c2Ugbm9uLXplcm8gdGFn
Z2VkIHBvaW50ZXJzIHdpbGwgbGVhZCB0byB1bmRlZmluZWQNCj4gK2JlaGF2aW91ci4NCg0KaSB0
aGluayB0aGF0IGJyayBtYXkgYmUgYWZmZWN0ZWQgdG9vIGJ5IHdoYXRldmVyIHRoYXQncw0KY2F1
c2luZyBwcm9ibGVtcyBpbiBtbWFwLg0KDQpvdGhlcndpc2UgdGhlIHRleHQgbG9va3MgZ29vZCB0
byBtZS4NCg==
