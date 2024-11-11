Return-Path: <linux-arch+bounces-8976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4D9C45A2
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8F1B2A508
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C61AB6DE;
	Mon, 11 Nov 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="homEr4Ek"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020123.outbound.protection.outlook.com [52.101.56.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60A1AB538;
	Mon, 11 Nov 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351174; cv=fail; b=G6YvHkzps97yE1gwIwV8v3XKJKJwpf4Z8l4df3ECs16eP2zd2P3LBxiMFRNwr4MEDOjqJIYju0uTA2Lb8wwQQiZutX2x65SqIHcK7wVr4oqW1t82VJOxIP96YU+NqTwqovnC37dPFtfyFyfIqeTT5HjiGot1G9EzoG2MYlwxVag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351174; c=relaxed/simple;
	bh=/V5WzhQEZbr0tOkF4JMWW2PoT16e1k0ogNVRbZx0de4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwp1SS/rPkpC/j6i4spMugKApfAXzSV9WbXht0PWMq+IdhAxtwtRgOmvFOAOE1JT0knFat3KYNRSO/hzhYoyWw7HaHbX31ur3RUM4wd1oMGkFXb3qT7ebjYbYQh9LWPHBsMKsC/aWkNK4I2muY2v+tzeRxG1FDf/Bgo6FFlJ8sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=homEr4Ek; arc=fail smtp.client-ip=52.101.56.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV0nVvTylseUuPuKX1fMhoRtniNg7d3ShriInjYLvFCm55QDGvpV6KXMaVxeJ48XFdGwBXS4tGU5NoArLlaF2jhcd8NF19toa8Vd8cuZkaTMWi/6W8OdqT8ZArGFwX9NPQokyvvRKWw0sSejCSQqoyThYsEyIAasclPZOEgRTp8StRf8vo8+lo+F9riEuBT5/ZfL8CsPg8/1IsW1g+jhG9X2Hlw5IHeQ/ziOUptSSU6XksfHbkeTXI2lzbCvg+3luMugU25n57OVMbV/55CmEV1PzRUWAuMNjco2kX9JgI3q86a7n5lH7kg9N7RGKme69//l0CwD/zjL9au1+npjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V5WzhQEZbr0tOkF4JMWW2PoT16e1k0ogNVRbZx0de4=;
 b=h5hk4BncTDxcje7Oxm8uCbHZHdFt6dT5KeUZpbqcyP0GzyUobmq6ohECvSdIy38k+0m1MsTWu2CGh550WCja3GuaWG7bx5+AV4mOv71JL/kkv39/NJr1Ucb4Psvyk5fA3YdKhsJ87SqHIIs9zQpCzrS+2WuBvliQ4BVG21tcORogagjxWkuPaooi/rg3zr+kSUOaIb7+3uMDMJgI1tdETVOC5Widy0RhbAYUQGQjVR4sRxsQT7dpSCJqWMBPZIAavolxnb0Xk4MNESV292SQn/LnELD2HTwexzhxuKjhf6z0zBiuqTWwg5ooT1kTPemaiuuVf6p8zhpLKdDX/taEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V5WzhQEZbr0tOkF4JMWW2PoT16e1k0ogNVRbZx0de4=;
 b=homEr4EkqoaaY12PlQDic5Q3czNzFNhcnPkxJ1VGv3/XDMb3ZDhNjfZq1SYA1gvGzUOTjlpz4AR+3OF5/tSAePHdXAPfWwuzhn289JCelx2kv56u5XXnW9Xc9xPX1gpxYhrOck4Y7kufIE9A+KD+IV4+TDoBGgIcueYNtL8MxYE=
Received: from DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10)
 by DS7PR21MB3223.namprd21.prod.outlook.com (2603:10b6:8:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 18:52:50 +0000
Received: from DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd]) by DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd%4]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 18:52:49 +0000
From: MUKESH RATHOR <mukeshrathor@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>
Subject: Re: [EXTERNAL] RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Topic: [EXTERNAL] RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Index: AQHbMWTxJJYHeO0ZVECt2plLi445lLKxfTKAgAD10QA=
Date: Mon, 11 Nov 2024 18:52:49 +0000
Message-ID: <b4a46acc-f4bb-81db-fcc1-29c55dc7724f@microsoft.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1434:EE_|DS7PR21MB3223:EE_
x-ms-office365-filtering-correlation-id: b6a44f7b-cd8d-4cf4-195c-08dd02820a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzhEUHRseGZ2a1YySXJWR3NsVjJsSVNuK3pLakxhWngyWWpFdU41TUh4aUo1?=
 =?utf-8?B?MGhNaStFTU5BU2JRcWlGczNQMXVTUWlENWRGRVc4MkVkUTRoalIrTlBRd0g1?=
 =?utf-8?B?bjNOc0xoVlAvOUxnVDJuSU44bk5JeEdMeUhZTU1vQlNaVXZjSURyOWxxYVVT?=
 =?utf-8?B?U2dvYnh3ZGZ6bllOaGxsSjZPZnlEak9XR2c3UzB5NTdOQjc3KzcvOTlneGVE?=
 =?utf-8?B?WldhSlFrNG9lbXV2dWY1Q1VWQzVURm1tSXBOcXRzVXlwS0NjZTd6Vi9CQVg0?=
 =?utf-8?B?cVFURndnSHFvSUdwKzIzUjRybmd6NktJbzV2bGZPUkpJSlhhbTlUVmRDT0p6?=
 =?utf-8?B?TmZNMUw4cVU1N2Ixc2w4RWl5RGlwcElLZnlKYmNHRXlORnBrU3ByNjMxNk9G?=
 =?utf-8?B?UitldDhnNXlHSlRmZnByWHhSc01yMFhjeXFtYkh2Zlp4ZXBvQ3JZZTVZYzhV?=
 =?utf-8?B?WlFpZmdJZXFZeFVGMVYydFMrd0NpbDlRUWFZREFXZ09UenRWaUFOWWtpeWRs?=
 =?utf-8?B?ZjJ1T3R1N0JaVXNHaXFPYzlmUEFMdmZ1UG05MTBWY08vU0k1YXhVK2ZyS1hY?=
 =?utf-8?B?di90MlRBUFlYS3dqK3ovM0pxb0NoSWgrSHZFVXEweEtvdVJqKzVhVzE0OStm?=
 =?utf-8?B?MWM0YmdIQ1FoZWk0U0pPcHdHRTZMa3VHaW5wOEtwdFZERGQwNW12N2hNTnYw?=
 =?utf-8?B?WVdPVjRPS2ZydFU0WUJ0TWpvcXg5cmZRT0xxR0NZNWxDV1BwQ1lZdWg2OGpE?=
 =?utf-8?B?MkNoMVBXejNudVZkZldkZnVFQTY0bWdvUFBLQnViMGYyMFJLeHB1dWpOaHVW?=
 =?utf-8?B?VVBVRVZwck52SkorUFNpQnErYUY5MGdMS1hFVG5nb1RjMTlBWEdHMVpScFhJ?=
 =?utf-8?B?d0JUZXhLcFBwTVk5ajMrZi9PRXdLRVM2ZWtaU2dHYmNpWnZOVnNiZ1QyYWpF?=
 =?utf-8?B?cDFuYnpqTUs4UGtSQlhwRTM3RThXWWFkc3JKUVhBcWlBM2hxekwrbDYzaUJn?=
 =?utf-8?B?OTkyQWxybkhZL2Q1VWgwNDY2eEtXTXlVTjZzM1dVdUZNZHRoZ3M0eTVhR0tS?=
 =?utf-8?B?Vjc1OXFZNWpXd0ZpUDE3T2xJY0NDd2dlUTR4cStUOERXZHJtNElBNVlWQURu?=
 =?utf-8?B?eEtIUExNajRrcklrV0VQd0VCOWFJWUpYMDRrd2MyOWNGT0xnSVZNYVNuMEJp?=
 =?utf-8?B?WlJCMGVaVGMwNEh4Z3luTXdGUU40MTJCVDRYMkNYQXpEc3F2RE9VdlUzeVZN?=
 =?utf-8?B?WE5ZM3NsQWF5MWtYd1c1Wjk5S2xUUDloVUNYMmxyNFd3ZFBteDdmSmV1UmtR?=
 =?utf-8?B?OFlJcXByMVY2VVlhM3VkTTRSd25PNVg3TjRYWE5vcUJkT2VyOTk4VnF0MEpU?=
 =?utf-8?B?azVyQUFCNm9NZE8xWktHYkVjK2dWT0h5SjNwTGdEK08wcHB2dHVVUHBlOXZQ?=
 =?utf-8?B?Qk9qMFhaYXpHSEVDQkRMRzFndm1ndTJDb1dlanlBazhEeFNBa20xYlpnNFJx?=
 =?utf-8?B?SkZickQ5TWJGeHRBODNwbktGVEdXNG9selNsZlg5RE5UTndEUEVvdHJYdGww?=
 =?utf-8?B?aFRndmtVOFh4Z2ZBd0tvY01sUTlXaDg2S2VESk52T3JsWUM1ZCtCKzlSMUUr?=
 =?utf-8?B?NmJIanY4L2hqVXgrWk9GZm04MXRYeTk1VnRHU0Qvc2tmTVhJaGxCU0hSNHMy?=
 =?utf-8?B?Q0VReStUQ2VCUXlNN0tzVDVEamNBdlFjMVFpUnlaZy84K3Q4V2Iwa2lLVUFt?=
 =?utf-8?B?MW4vZWFGZ3ZiS2I2cXlNTkdqUUgvbUFxSTVsL2pjS2FXellTVWFtOGpVaHRJ?=
 =?utf-8?B?MkhoYXJBaEMvWGo3UjZ5OFU2bk9nNkpwOFlFQllkNjg2OWEvNHMvZnFCNzFO?=
 =?utf-8?Q?BSS3UU51H5/GM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1434.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXduMUg2OFFVd3JEWDlrY1dFZmx2MHpzSGMxTzR4cXI3T0x3K3NEUHhmZXZN?=
 =?utf-8?B?WjVhNFZlZ1hpZmNJOXo0MXBTcDRPcm1zSzE3OHB3eGlSSHA2V3NsQ3RTQW9a?=
 =?utf-8?B?MzhDbk55Tmd2RlVaWnNjQUd2R0tPd0xrb3pZdE50K1gzb2xkNHU2UG5lZVJo?=
 =?utf-8?B?OHEzSng2dDRhWWgzdkFucXRrcUZSRjFHcDNmQU5JZGxQMWc4V0QwbGlXdmtj?=
 =?utf-8?B?V00yMFBuVk8xVU0zWVdHNjIwWEY1dVFGV0tJSHltTitYVFhXK2sxaE9JV0RY?=
 =?utf-8?B?TEFldHVMY0MxaW5oMVIvcmdObENlTVYrcEtBKzhWU1luTEZwc2EycHVMMnhP?=
 =?utf-8?B?R0lIUXllS0t5Z0FVZnZlamkzSzN2dWRNRzMxMGhhMFhkbkxteW1JTGQzVXp0?=
 =?utf-8?B?aFNMOGxJYzVlOXpQTEU2elRRT3hVYWV6YXRqWEhtYURNMjRDRE1mNkVaMkdM?=
 =?utf-8?B?M2NYK1c4RzExQnQwMksyN2FOUWlpMkZmelp4WThzdXFJQkZBWmFVcFhWOS9t?=
 =?utf-8?B?d3lmSCsxMGZOMjZkRUVvclA2eE9QZmEwUUNaOVhWQmhlcnhmNHdDVzNueWpN?=
 =?utf-8?B?enFSWTFCTjdEOG1PQ1ozYUswZlV6SGowQXlVQUlXRWFML05zMXIzS1JOZCtN?=
 =?utf-8?B?ZHZWa3VNSThZa2R3NEdVbVkwK0x1SEJVc09BWnMyRGY3QlE5L284RDFKQ1ZU?=
 =?utf-8?B?dnkySm11OFluV2I2VG5GbURuTWR5MUF4b2ppYWYwUE1XRFJ1eEtISFIzR2Vl?=
 =?utf-8?B?WXYyYW1BTmFGY0VuY00xaHF4eGJkVVFQZi92ckEvYi9DbTJ4bVpEdUtuQzZE?=
 =?utf-8?B?VXlyNWN3d3VhZThSWE5jdWVrK3RnRnRUSkIvQUt4M044a1pBNEM4dWxCaURv?=
 =?utf-8?B?R09XTDlCMzlCaUJsbEpjaDZLS080QkFqV3k5SmdPNXNMZWYrcEZWNEpwR2tR?=
 =?utf-8?B?UDFUOTVFYkd1RUtYb1NYaUtSaTFKNmV3NnlsKzVTNWlnM0FRWTZaZm9pWGpm?=
 =?utf-8?B?cWNEbG9VaFpDWmxpVEpuTmNjOWtDaHVvR1p1QkJFcUJaaTRMUFRUV3VWNWdQ?=
 =?utf-8?B?MHU4ZStINk9GSFYwc2NtSXdRVExaekd5TnVxZjd1SWZPZWsvdzZvMHVDaXAw?=
 =?utf-8?B?T3gzcGt3K1I3S1lHZFZ6eWZoVlJsUHN4dy9oVmZRWWhvVVI1dkpLa1BKQkl3?=
 =?utf-8?B?aVBpcGdiRUt4MzdjTnFxR2FZem1JSVp6ekRwb1NhRXdvbzBPOEo3U2JjNmhI?=
 =?utf-8?B?bDJiNlZFdWwzUVljQVB5ZE5uSGlwcmM1QWNyb09jSEVPQjZqaEc3N2g1ZVYw?=
 =?utf-8?B?RkZvNS8yRmIraU1sTG1EcGgvNUh4ZG9xMEgvMXZSWStVYnN4VzhtVGxHV1dF?=
 =?utf-8?B?WjZpRFNZWWo1QXV6RHBKcUtxZWtKZWF6R1N4YjF6SlpTZ2dnOU41UzlrekR5?=
 =?utf-8?B?alJJQWRXem1iSFJLM2JSTG9lQ3VmYUZENVRCUWg4b3Y1N2FIMHlBaFliKzdD?=
 =?utf-8?B?VS9Md2c2VVZIR3ZnOG1GMGpsQ1FIK3ZuMk9CZGpCdVlFUjRjaFp3S0xXQXFM?=
 =?utf-8?B?ckppMDFIcThCeDY5Y1UvdUNIRzNyOGhVVjNpWkhlVWlGQ0JxMUdqeHpHd0ND?=
 =?utf-8?B?VW94d3EyMnlheDdaZnpmUEpGdU5ISUZQVytnQVd4NktHblRmRmVMeGlFWnRJ?=
 =?utf-8?B?Qm5VOVN4bnZwUis3enVPa01pUXFjb2Z0cStjQTNWUUVtdnBrNGJqOXcyd1hC?=
 =?utf-8?B?aWx6aUZJSGVSR255NEtzTEpRem1Vbk9GOEp5dFM2QzU4R0MxWm1jWDF1VUhJ?=
 =?utf-8?B?bWN1UHpOclpNS25Bb0FpNEhHRXZPekU4ci9IT0ZvRWJuWnllUHpDbmxVRlJE?=
 =?utf-8?B?QU9ZTlBKWWtnbHI4ZXVwUFp4UmVTM0VJYlRjL1l0N0xTUVZsV1BvQ2tqWnR2?=
 =?utf-8?B?V1ZCMmV4RnExV1RtaDdQTGJMcy9XeVN4VVBCb1hjK0xoNXlaVm1DTkNadmwv?=
 =?utf-8?B?YVpobTQrbERkUC92RytRUW84WUo5OGduSWhjTzBXQ2dWd2NqQUt5UnMrTlk4?=
 =?utf-8?Q?e5621s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CD93D04899637479F2968D490358D55@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1434.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a44f7b-cd8d-4cf4-195c-08dd02820a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 18:52:49.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tj/4SxNxRGp54pXYiwVZvZ26309a0XxCQr3Mg/49XJCPTBF8JwK/K89pVqEDOWTL38dkw943IoAtGs8Z0ma2PuRffMv7joXcF0sgEcPyUVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3223

DQoNCk9uIDExLzEwLzI0IDIwOjEyLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCiA+IEZyb206IE51
bm8gRGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogDQpU
aHVyc2RheSwgTm92ZW1iZXIgNywgMjAyNCAyOjMyIFBNDQogPj4NCiA+PiBUbyBzdXBwb3J0IEh5
cGVyLVYgRG9tMCAoYWthIExpbnV4IGFzIHJvb3QgcGFydGl0aW9uKSwgbWFueSBuZXcNCiA+PiBk
ZWZpbml0aW9ucyBhcmUgcmVxdWlyZWQuDQogPg0KID4gVXNpbmcgImRvbTAiIHRlcm1pbm9sb2d5
IGhlcmUgYW5kIGluIHRoZSBTdWJqZWN0OiBsaW5lIGlzIGxpa2VseSB0bw0KID4gYmUgY29uZnVz
aW5nIHRvIGZvbGtzIHdobyBhcmVuJ3QgaW50aW1hdGVseSBpbnZvbHZlZCBpbiBIeXBlci1WIHdv
cmsuDQogPiBQcmV2aW91cyBMaW51eCBrZXJuZWwgY29tbWl0IG1lc3NhZ2VzIGFuZCBjb2RlIGZv
ciBydW5uaW5nIGluIHRoZQ0KID4gSHlwZXItViByb290IHBhcnRpdGlvbiB1c2UgInJvb3QgcGFy
dGl0aW9uIiB0ZXJtaW5vbG9neSwgYW5kIEkgY291bGRuJ3QNCiA+IGZpbmQgImRvbTAiIGhhdmlu
ZyBiZWVuIHVzZWQgYmVmb3JlLiAicm9vdCBwYXJ0aXRpb24iIHdvdWxkIGJlIG1vcmUNCiA+IGNv
bnNpc3RlbnQsIGFuZCBpdCBhbHNvIG1hdGNoZXMgdGhlIHB1YmxpYyBkb2N1bWVudGF0aW9uIGZv
ciBIeXBlci1WLg0KID4gImRvbTAiIGlzIFhlbiBzcGVjaWZpYyB0ZXJtaW5vbG9neSwgYW5kIGhh
dmluZyBpdCBzaG93IHVwIGluIEh5cGVyLVYNCiA+IHBhdGNoZXMgd291bGQgYmUgY29uZnVzaW5n
IGZvciB0aGUgY2FzdWFsIHJlYWRlci4gSSBrbm93ICJkb20wIiBoYXMNCiA+IGJlZW4gdXNlZCBp
bnRlcm5hbGx5IGF0IE1pY3Jvc29mdCBhcyBzaG9ydGhhbmQgZm9yICJIeXBlci1WIHJvb3QNCiA+
IHBhcnRpdGlvbiIsIGJ1dCBpdCdzIHByb2JhYmx5IGJlc3QgdG8gY29tcGxldGVseSBhdm9pZCBz
dWNoIHNob3J0aGFuZA0KID4gaW4gcHVibGljIExpbnV4IGtlcm5lbCBwYXRjaGVzIGFuZCBjb2Rl
Lg0KID4NCiA+IEp1c3QgbXkgJC4wMiAuLi4uDQoNCkhpIE1pY2hhZWwsDQoNCkZXSVcsIGh5cGVy
diB0ZWFtIGFuZCB1cyBhcmUgdXNpbmcgdGhlIHRlcm0gImRvbTAiIG1vcmUgYW5kIG1vcmUgdG8N
CmF2b2lkIGNvbmZ1c2lvbiBiZXR3ZWVuIHdpbmRvd3Mgcm9vdCBhbmQgbGludXggcm9vdCwgYXMg
ZG9tMCBpcw0KYWx3YXlzIGxpbnV4IHJvb3QuIEkgZGlkIGEgcXVpY2sgc2VhcmNoLCBhbmQgImRv
bTAiIGlzIG5laXRoZXINCmNvcHlyaWdodGVkIG5vciB0cmFkZW1hcmtlZCBieSB4ZW4sIGFuZCBJ
J20gc3VyZSB0aGUgZmluZSBmb2xrcw0KdGhlcmUgd29uJ3QgYmUgb2ZmZW5kZWQuIEhvcGVmdWxs
eSwgW0h5cGVyLVZdIHRhZyB3b3VsZCByZWR1Y2UNCnRoZSBjb25mdXNpb24uDQoNCkp1c3QgbXkg
JDAuMQ0KDQpUaGFua3MsDQotTXVrZXNoDQoNCg==

