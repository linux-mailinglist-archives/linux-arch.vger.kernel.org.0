Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1985E3D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 11:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfHHJ1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 05:27:46 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:63109
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730678AbfHHJ1p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 05:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWmUXu6Z3ulF6zBDue55trNJhyLyULxjqTZ0CFENnAg=;
 b=EUW+HhMayIBSviMC+kpY+z/6ceGR6/DKFT642p/iDzJV/wj9//nfEdKssK28m4dBxxPoyjzVkyXdFS2Ey61xQy64dqmJvbnpCmu6sTpmb+jQdAOX7A502gyEYKz7yNMicscq/zG75dhCflCj3gIhmU6oWJ/YYJZzHJypqP220cM=
Received: from VI1PR08CA0115.eurprd08.prod.outlook.com (2603:10a6:800:d4::17)
 by VI1PR0802MB2606.eurprd08.prod.outlook.com (2603:10a6:800:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.13; Thu, 8 Aug
 2019 09:26:00 +0000
Received: from VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0115.outlook.office365.com
 (2603:10a6:800:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Thu, 8 Aug 2019 09:26:00 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT008.mail.protection.outlook.com (10.152.18.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 8 Aug 2019 09:25:59 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Thu, 08 Aug 2019 09:25:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d7cb0969aa170b39
X-CR-MTA-TID: 64aa7808
Received: from 0c6d593ab3bc.2 (cr-mta-lb-1.cr-mta-net [104.47.13.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 55948023-1D86-4AFD-9B76-7F5F0D2AB9A6.1;
        Thu, 08 Aug 2019 09:25:50 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0c6d593ab3bc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 08 Aug 2019 09:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSKjV8eo7xrv3vuSLqaVy78hFjzs5Zs1WLlrwFzgF9I6Wj6mSZN/6aaGrbzoWvksFyeOxjw3n6z+nfEbQk5BAuUbb1GOpNa2y6lZxz8DD+8RUQOdx9xnO+5D5puaO2YoBABSBrBwfBSAuDWyNNgidRfoA7Yp50jJSv4R0Sq5Hbqw4HERRMpDoTso3Dc8yQ9NYLm1Za2o27+JVwC7Ci+V8lxS7fSjLn7iNNw16fCFDSXUvijZOnOmSV5QQKLO6OAkrJmZeVGafZW57hXe0zPP//LEM/Mfe9MGTe7WI7JBYKZitMkJugIwfpoJWjjhVIssFLGOMxzGHHP/zwQBnFRIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWmUXu6Z3ulF6zBDue55trNJhyLyULxjqTZ0CFENnAg=;
 b=ZLD9krQtJuYnmkbEdR6ta+GNK9fmfyL2qYEV2hqvORK7FDdD7+/FcxIhAg/EnR0dppT6UgM16xjhLeK/iLwr/BgavIFtxHWOwHpSWWYV1SUfQu9J8tDzjhzDinRV7cDpIKpXPPcIhtxwXdGHMkfmAu2QsF9jkeKg7/96S5tLz5rrie9etrqJjdyfk7W9HdinpMY22A+UY/VWtwL5yxoS0h8DdHUv94a2Ug5OdCiwyMBCuf28VDEM2Q0DTGNOn7MZRDJJWtN8obDKDnu81zmjwLX+jJc9p8PeMr8PBsUfU+x4h/oaruP5NosxWadfqF9y8qKwG4Wf7eoaPBqO45hnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWmUXu6Z3ulF6zBDue55trNJhyLyULxjqTZ0CFENnAg=;
 b=EUW+HhMayIBSviMC+kpY+z/6ceGR6/DKFT642p/iDzJV/wj9//nfEdKssK28m4dBxxPoyjzVkyXdFS2Ey61xQy64dqmJvbnpCmu6sTpmb+jQdAOX7A502gyEYKz7yNMicscq/zG75dhCflCj3gIhmU6oWJ/YYJZzHJypqP220cM=
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com (10.172.219.8) by
 AM4PR0802MB2161.eurprd08.prod.outlook.com (10.172.216.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 8 Aug 2019 09:25:47 +0000
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a]) by AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 09:25:47 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     nd <nd@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        "Will Deacon" <Will.Deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Kevin Brodsky" <Kevin.Brodsky@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Thread-Topic: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Thread-Index: AQHVTThJtBlc8zHC8EmoKLcy3EHPqqbwJaMAgADWb4A=
Date:   Thu, 8 Aug 2019 09:25:47 +0000
Message-ID: <48c5f9b3-d253-bede-e755-0aabba2757b5@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::13) To AM4PR0802MB2307.eurprd08.prod.outlook.com
 (2603:10a6:200:61::8)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 59e7a5c8-ce21-42e2-a55c-08d71be26cba
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2161;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2161:|VI1PR0802MB2606:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2606D1EFC0A3B4975BCE5702EDD70@VI1PR0802MB2606.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5236;OLM:5236;
x-forefront-prvs: 012349AD1C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(54094003)(199004)(189003)(6512007)(52116002)(53936002)(86362001)(25786009)(7736002)(99286004)(71190400001)(71200400001)(476003)(36756003)(102836004)(386003)(53546011)(6506007)(44832011)(256004)(486006)(4326008)(6246003)(76176011)(2616005)(11346002)(446003)(186003)(5660300002)(26005)(66946007)(66476007)(66556008)(64756008)(66446008)(31696002)(2501003)(6116002)(14454004)(65806001)(65956001)(66066001)(3846002)(65826007)(478600001)(6486002)(81156014)(81166006)(2906002)(54906003)(110136005)(316002)(58126008)(229853002)(305945005)(64126003)(8676002)(6436002)(31686004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2161;H:AM4PR0802MB2307.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: kAQ/NcX1v7sXRgpyyyNJZO/B0kZE/8IxEJH6DBs6ZzZ4jOpflqQFaW1n/5gg1IgHZ/RuWIBFK9Wls04AmYnyjJi3XlpNsuqeJ1vNmVkieYu/x5VtoZFCKTIUdUCahah90rLVx2bfmiowjz6+gVFEobszH/k2YWYJBdoPRT8jp+xzUpJ0fHer3GJVm6FFbMBCFrCBY5sP5iJ1PxX8okJs9zxCUCzoukY55IGVk+u24lZminPg6mdJ52j3B94I3mRvRD1gAn+W4ZEphyeAWuNB+s75+OWalyPQqhfysIJ9adn3oiYHq12ZVgdsYyVxw4PgbCqvVtk66CRaej92QasGdv0oU4kSa3rjCJUDBxMaPu7vVq8vtGmFN7lYUdIKsJht7A6oK+btq4piRwBASokXW2DZrc91qvLYB+6fkwUMu5k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <960F9790878B3346A988307D90E92E55@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2161
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(54094003)(63370400001)(22756006)(25786009)(81156014)(63350400001)(450100002)(336012)(81166006)(2616005)(6116002)(8676002)(486006)(126002)(2906002)(3846002)(356004)(99286004)(186003)(476003)(8936002)(436003)(26005)(14454004)(6512007)(305945005)(7736002)(66066001)(65956001)(65806001)(47776003)(76176011)(31686004)(446003)(23676004)(2486003)(11346002)(26826003)(478600001)(36756003)(229853002)(76130400001)(386003)(6506007)(102836004)(53546011)(36906005)(86362001)(31696002)(6486002)(316002)(70586007)(5660300002)(64126003)(70206006)(4326008)(6246003)(58126008)(54906003)(110136005)(50466002)(2501003)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2606;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 92843451-54da-426b-674f-08d71be26534
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0802MB2606;
NoDisclaimer: True
X-Forefront-PRVS: 012349AD1C
X-Microsoft-Antispam-Message-Info: PEB3kRPWy7EXCsceIJwN//F9DF2JfJ6ieVO1Eu8pms+hTLoWmRHyqbVtzl9QJNxdS+DqwNrizs4haEU55dkzlgNkeQGsb9wKyIQ7CohQtTEGfOa4Yems+4u3NbfmOPHe0A9xBi2TnNQJlYP8SIlIGwDdGyUNOXV+9ISrD2Vh5UTGZcG3nNZ9HwUFIpWILTfw8ZjPWyd+Noa1CaYaAMthaHrySWJGHwQnzhp7GwFNs9HV922BlzPYLKiGp0TdG60wdycLQ+OaWkuspOVvJg5JVd/GlL2/uW0V+y1Z+Mc8ypcTDSMWKlHnFCeZwt469HlXdVkghvlxq55mdsyJ+XLwW0EBj0LRz+ovH2pI8JAwIbccuIABYZi0WKWzis1FER/2mzwb/H/wgc13TG81sPGmfzlasD/7IJqaoWpOvLlSyVw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2019 09:25:59.4997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e7a5c8-ce21-42e2-a55c-08d71be26cba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2606
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDcvMDgvMjAxOSAyMTozOCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IE9uIDgvNy8xOSA4OjUz
IEFNLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6DQo+PiArLSBUaGUgc3lzY2FsbCBiZWhhdmlvdXIg
aXMgdW5kZWZpbmVkIGZvciBub24gdmFsaWQgdGFnZ2VkIHBvaW50ZXJzLg0KPiANCj4gRG8geW91
IHJlYWxseSBtZWFuICJ1bmRlZmluZWQiPyAgSSBtZWFuLCBhIGJhZCBwb2ludGVyIGlzIGEgYmFk
IHBvaW50ZXIuDQo+ICBXaHkgc2hvdWxkIGl0IG1hdHRlciBpZiBpdCdzIGEgdGFnZ2VkIGJhZCBw
b2ludGVyIG9yIGFuIHVudGFnZ2VkIGJhZA0KPiBwb2ludGVyPw0KDQpiYWQgcG9pbnRlcnMgYXJl
IGludmFsaWQsIGJ1dCBzb21lIG5vbi1iYWQgcG9pbnRlcnMgYXJlDQphbHNvIGludmFsaWQgaWYg
dGhleSBhcmUgdGFnZ2VkIChlLmcuIHRhZ2dlZCBwb2ludGVyIHRvDQpkZXZpY2UgbWVtb3J5Pykg
dGhvc2UgbWF5IGJlIHZhbGlkIHRvIGRlcmVmZXJlbmNlIGluDQp1c2Vyc3BhY2UgYnV0IGRvbid0
IHdvcmsgYWNyb3NzIHRoZSBzeXNjYWxsIGFiaSAoZGV2aWNlDQpkcml2ZXIgZG9lcyBub3QgaGFu
ZGxlIHRoZSB0YWc/KS4NCg0KPj4gKy0gbW1hcCgpIGFkZHIgcGFyYW1ldGVyLg0KPj4gKw0KPj4g
Ky0gbXJlbWFwKCkgbmV3X2FkZHJlc3MgcGFyYW1ldGVyLg0KPiANCj4gSXMgbXVubWFwKCkgbWlz
c2luZz8gIE9yIHdhcyB0aGVyZSBhIHJlYXNvbiBmb3IgbGVhdmluZyBpdCBvdXQ/DQoNCnRoZSBu
ZXcgYWRkcmVzcyBpbiBtbWFwIGFuZCBtcmVtYXAgbWF5IG5vdCBiZSBjdXJyZW50bHkNCm1hcHBl
ZCwgb3RoZXIgbSogZnVuY3Rpb25zIG9wZXJhdGUgb24gZXhpc3RpbmcgbWFwcGluZ3MNCihtdW5t
YXAsIG1hZHZpc2UsIG1wcm90ZWN0LCBtbG9jaywuLi4pDQoNCmFsdGhvdWdoIGJ5IHRoaXMgbG9n
aWMgYnJrIChhbmQgcmVsYXRlZCBQUl9TRVRfTU1fKikNCnNob3VsZCBiZSBleGNsdWRlZCBoZXJl
IHRvby4NCg0KPj4gKy0gcHJjdGwoUFJfU0VUX01NLCBgYCpgYCwgLi4uKSBvdGhlciB0aGFuIGFy
ZzIgUFJfU0VUX01NX01BUCBhbmQNCj4+ICsgIFBSX1NFVF9NTV9NQVBfU0laRS4NCj4+ICsNCj4+
ICstIHByY3RsKFBSX1NFVF9NTSwgUFJfU0VUX01NX01BUHssX1NJWkV9LCAuLi4pIHN0cnVjdCBw
cmN0bF9tbV9tYXAgZmllbGRzLg0KPj4gKw0KPj4gK0FueSBhdHRlbXB0IHRvIHVzZSBub24temVy
byB0YWdnZWQgcG9pbnRlcnMgd2lsbCBsZWFkIHRvIHVuZGVmaW5lZA0KPj4gK2JlaGF2aW91ci4N
Cj4gDQo+IEkgd29uZGVyIGlmIHlvdSB3YW50IHRvIGdlbmVyYWxpemUgdGhpcyBhIGJpdC4gIEkg
dGhpbmsgeW91J3JlIHNheWluZw0KPiB0aGF0IHBhcnRzIG9mIHRoZSBBQkkgdGhhdCBtb2RpZnkg
dGhlICpsYXlvdXQqIG9mIHRoZSBhZGRyZXNzIHNwYWNlDQo+IG5ldmVyIGFjY2VwdCB0YWdnZWQg
cG9pbnRlcnMuDQoNCnNvbWV0aGluZyBsaWtlIHRoYXQsIGJ1dCBpIHRoaW5rIHRoaXMgaXMgaGFy
ZCB0byBzcGVjaWZ5DQppbiBhIGdlbmVyaWMgd2F5Lg0K
