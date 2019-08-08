Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D06866E9
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHHQWq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 12:22:46 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:3165
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbfHHQWq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 12:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLBJoVDzH7bMp2WAajmt3aFLPL3zQ+436nv7X4WHpf0=;
 b=8H3lNv9fejtPxAELuF4qA22OPAEvPOYeee9Oh1gEEmks+Y4+pHPHpS1HtraELj0DOc2BsmsTMLM2meEDQqXKVkaPJAZJ7xqaoDnWBnUzeqUKXYpBGY9mkmBuL/PH1N4vHvpzE4E4U6dLC+wAzHPxaTNx52O6ZwXUqIHQlPdPek0=
Received: from VE1PR08CA0006.eurprd08.prod.outlook.com (2603:10a6:803:104::19)
 by DB6PR0801MB1848.eurprd08.prod.outlook.com (2603:10a6:4:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Thu, 8 Aug
 2019 16:21:00 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VE1PR08CA0006.outlook.office365.com
 (2603:10a6:803:104::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Thu, 8 Aug 2019 16:21:00 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 8 Aug 2019 16:20:59 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Thu, 08 Aug 2019 16:20:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 777faca64e48032d
X-CR-MTA-TID: 64aa7808
Received: from f716b1a1155c.1 (cr-mta-lb-1.cr-mta-net [104.47.2.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E476E1F2-1D6D-490A-8B3B-217DD1E4BE2B.1;
        Thu, 08 Aug 2019 16:20:54 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f716b1a1155c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 08 Aug 2019 16:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apJbbjum2mtrUhDRndiMh2/xJ6PbIAwlQ41b0dMroI5KtEEpw9fwAeKGscJ9uQ4RiJbS4oVGzJ61Bhb3vwX2na8eizvEZoY8pkTYyHekD35ODgjgUqt/xaTdYZzeh2go/cZgeutcblvrM5MM4D7BHIx8OAt9SfBGJrEiDlGAyF1OL7oAmJpt/BhSWMTlMI4D/8qpG7qR2gD2LSy3l3LORjZRyelW2/UF6Jq6nYMkeP9sj+hFHCMkCW28Vynwy0jP28h31WQU8seiJibzbQO0y7pJ2OuYnOqcfnolHnIUIlmn/TGRkzsPNEEouIJA1tSrv00t42qd+QZ8Xgyts9Lqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLBJoVDzH7bMp2WAajmt3aFLPL3zQ+436nv7X4WHpf0=;
 b=PqKDFCAQ1BkSxQxy4hB3Uid9e1tbIQNUD9xb5rTFAHxBA9xXPiauBXKqYiJ6kHBCL6cV+26p3/371s7204gIYtVottxqAE56elJ/dk2/c45rSAebkL4zGflRv8xs5x2iSsKi5eUs08cohOSb8x73DHAox0Z3RcWKN9I7sYrBd8seEHYiD0vo1hdqPopvg1Ss+X7cnrSCiN0tnOLFijRhupGeWQTqoHHkVhkdDRnFfquAvn40L/mRRsEQpGDWEDnURaNosOICnZuy0c9h6BR6D36BhoRD9N96AUt/YFMP7LB0ZOlpi+hJEZEPAdl30jpE5oj5zMULbFOcPb+hQiN6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLBJoVDzH7bMp2WAajmt3aFLPL3zQ+436nv7X4WHpf0=;
 b=8H3lNv9fejtPxAELuF4qA22OPAEvPOYeee9Oh1gEEmks+Y4+pHPHpS1HtraELj0DOc2BsmsTMLM2meEDQqXKVkaPJAZJ7xqaoDnWBnUzeqUKXYpBGY9mkmBuL/PH1N4vHvpzE4E4U6dLC+wAzHPxaTNx52O6ZwXUqIHQlPdPek0=
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com (10.172.219.8) by
 AM4PR0802MB2226.eurprd08.prod.outlook.com (10.172.215.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Thu, 8 Aug 2019 16:20:51 +0000
Received: from AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a]) by AM4PR0802MB2307.eurprd08.prod.outlook.com
 ([fe80::e854:32de:1cad:f93a%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 16:20:51 +0000
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
Thread-Index: AQHVTThJtBlc8zHC8EmoKLcy3EHPqqbwJaMAgAFKZ4A=
Date:   Thu, 8 Aug 2019 16:20:51 +0000
Message-ID: <d487294a-43b0-45ca-93ea-dcff1c2b022a@arm.com>
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
x-clientproxiedby: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To AM4PR0802MB2307.eurprd08.prod.outlook.com
 (2603:10a6:200:61::8)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6a306046-7e83-43e5-7ced-08d71c1c6640
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2226;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2226:|DB6PR0801MB1848:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1848D0F89238C96DFCE5583AEDD70@DB6PR0801MB1848.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2201;OLM:2201;
x-forefront-prvs: 012349AD1C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(31696002)(86362001)(66946007)(2616005)(486006)(476003)(76176011)(66476007)(4326008)(64126003)(81156014)(8936002)(66556008)(81166006)(64756008)(6486002)(8676002)(66446008)(44832011)(256004)(7736002)(71200400001)(305945005)(6436002)(6306002)(71190400001)(229853002)(53936002)(6512007)(14454004)(2501003)(966005)(3846002)(6116002)(65826007)(99286004)(4744005)(5660300002)(6246003)(25786009)(54906003)(316002)(58126008)(110136005)(446003)(2906002)(186003)(36756003)(26005)(53546011)(102836004)(478600001)(386003)(66066001)(65806001)(31686004)(6506007)(65956001)(11346002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2226;H:AM4PR0802MB2307.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: kN0sHRCAenECeJssjNBl4+s8x5rlnUJG2XnekZ0krdvJkdX4UvtEApfEALBqiufDWC52tDmnPaapTH1eN0Cl7j7IyTPWDLh/XxrhOht/6Pq5i6Sz/6ZdPloqpxAAYOBHf3o+j8Vo9GdRzf516cNTV87bUv3os5xRQtd7itFycZoWDFsvzJH9zG2lTVci0rDihrPGmb3RGrBRdKwsnna9pOLTz5n0ItanUBF1cbPLy+JMVs/zreGfYY7LbbJ0MUtxokHMTMZw/1ovZGaZNrR9xUdPnibcIz4/A0BRSEZzAfQqyVwpl5PKMf0hv8kMBFIRnwI4Byb8/k1JJd32Bd0wSECwObe1Cb1EaGWdqrjrxzUYlSCvkM12MemO9GO3DhaeaPtxRpD3KSfTe+rKEcKYUfdqxtoJyp08PxkDPOBZ5D8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8DD9C09E60D9E4589E7C3CCF10A847A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2226
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(81156014)(64126003)(316002)(229853002)(6246003)(2616005)(436003)(336012)(6486002)(99286004)(63350400001)(50466002)(386003)(53546011)(6506007)(76176011)(305945005)(66066001)(70206006)(70586007)(486006)(65956001)(126002)(6306002)(86362001)(102836004)(6512007)(31686004)(22756006)(76130400001)(450100002)(476003)(65806001)(6116002)(31696002)(3846002)(2906002)(58126008)(14454004)(4744005)(36756003)(966005)(47776003)(8676002)(26005)(63370400001)(5660300002)(81166006)(186003)(2501003)(478600001)(446003)(356004)(4326008)(23676004)(36906005)(11346002)(7736002)(8936002)(54906003)(2486003)(110136005)(25786009)(65826007)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1848;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f54523b6-96b1-4a58-0138-08d71c1c615f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB6PR0801MB1848;
NoDisclaimer: True
X-Forefront-PRVS: 012349AD1C
X-Microsoft-Antispam-Message-Info: jZUuhdrra+pgsulrNgH45pcrQoJ/61aYiXsfs5LRaDdecr0oJUghxs7vXeA9d6BFfgr9zevqZ0ZbRlPaiIE3yd0JtiigsGmH0dZk2e0fv0v5WK8V50e2nju9RX1p4T1nloJph1Bq30QzISnvaKaoynjfDpIRXRDzvibjeK5U/iEr21RmEx69ej0ejDnx6ByA5IMPUdM+ouRSK+5d0HwbpgTJvtG3G5prM9agg2EWSRTK8gyJkw2f27DqhwBm6rmECnCxfay7MLgDtVTOLjDNCczZJaQAmc3zsg/kMxSh2KmzLSSLGXV8ztOa0GGXGbx7/5IRUQwRzx3F3wJhOlXmt6B3A0z9MV4VoojapukitKEqpLyTY13wi+cu5Fek3z+git178IMtEnFPjTdCDCWfpqTuNA5woKB2/33/+Z5Meqo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2019 16:20:59.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a306046-7e83-43e5-7ced-08d71c1c6640
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1848
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDcvMDgvMjAxOSAyMTozOCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IE9uIDgvNy8xOSA4OjUz
IEFNLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6DQo+PiArLSBtbWFwKCkgZG9uZSBieSB0aGUgcHJv
Y2VzcyBpdHNlbGYgKG9yIGl0cyBwYXJlbnQpLCB3aGVyZSBlaXRoZXI6DQo+PiArDQo+PiArICAt
IGZsYWdzIGhhdmUgdGhlICoqTUFQX0FOT05ZTU9VUyoqIGJpdCBzZXQNCj4+ICsgIC0gdGhlIGZp
bGUgZGVzY3JpcHRvciByZWZlcnMgdG8gYSByZWd1bGFyIGZpbGUgKGluY2x1ZGluZyB0aG9zZSBy
ZXR1cm5lZA0KPj4gKyAgICBieSBtZW1mZF9jcmVhdGUoKSkgb3IgKiovZGV2L3plcm8qKg0KPiAN
Cj4gV2hhdCdzIGEgInJlZ3VsYXIgZmlsZSI/IDspDQoNCmknZCBleHBlY3QgdGhlIHBvc2l4IGRl
ZmluaXRpb24uDQoNCmluIHBvc2l4ICJGaWxlIHR5cGVzIGluY2x1ZGUgcmVndWxhciBmaWxlLCBj
aGFyYWN0ZXINCnNwZWNpYWwgZmlsZSwgYmxvY2sgc3BlY2lhbCBmaWxlLCBGSUZPIHNwZWNpYWwg
ZmlsZSwNCnN5bWJvbGljIGxpbmssIHNvY2tldCwgYW5kIGRpcmVjdG9yeS4gT3RoZXIgdHlwZXMg
b2YNCmZpbGVzIG1heSBiZSBzdXBwb3J0ZWQgYnkgdGhlIGltcGxlbWVudGF0aW9uLiINCg0Kd2hl
cmUgcmVndWxhciBmaWxlIGlzICJBIGZpbGUgdGhhdCBpcyBhIHJhbmRvbWx5DQphY2Nlc3NpYmxl
IHNlcXVlbmNlIG9mIGJ5dGVzLCB3aXRoIG5vIGZ1cnRoZXINCnN0cnVjdHVyZSBpbXBvc2VkIGJ5
IHRoZSBzeXN0ZW0uIg0KaHR0cDovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzk2OTk5
MTk3OTkvYmFzZWRlZnMvVjFfY2hhcDAzLmh0bWwjdGFnXzAzXzMyMw0K
