Return-Path: <linux-arch+bounces-15473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D6CC4C18
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 18:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3C730424B7
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7E309EE4;
	Tue, 16 Dec 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTBxaMpB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rKGavTR7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612D223710;
	Tue, 16 Dec 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765907740; cv=fail; b=qygUfr1nH6lYLAa9qvFyLuoSo9J/8Res5EypfwK1S4Gq9ltoQ471HVToK6uRRNF0zmpfOlDGZ3LJcKXejhlRMa+zeAEdODcnaugqtn6sxckhgyNJHKVpwH5hbbYVD/bJfa9RneyBWEyQXl+hHEx5kFs+H4s/tu5y1oRXoZW3rLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765907740; c=relaxed/simple;
	bh=aanYq8LueYkTyuUlD6S+fmxlWdp8OBTvWCvI6t82eqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1dPCvIzQ0+0g4HTXgaTFuHMD2SPrFI+yAXG26/9zhIqlEftCJ97U4Dq1r7i8HfrNpAYWpvr7HDqYydErY4NersQvkAtlJebvaNRT98vjadC3HA3nlZG0ITZ8Vm0TcsG2UYlzF0xlJIZaJK/C+NmaBYdPaMekkrC/YKFQVbW93c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NTBxaMpB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rKGavTR7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuNmw506191;
	Tue, 16 Dec 2025 17:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aanYq8LueYkTyuUlD6S+fmxlWdp8OBTvWCvI6t82eqI=; b=
	NTBxaMpBggB/slTQANgyfWDhg0p+ivUqT4LDnbTIgz9cK7b0c8cEqLxotoh5DQG6
	1EpkGnjLtVKLvcPXSDOSk3wdXA9NMxaFD6+PTgo1hpRyHuv8inrUVkb0MBzBhY7R
	YzKdkJYxywTjQ4qUAX4qiHUAPiACn1BCmvpx/VFwoB2eoe9v5D30zA9BFrowl58f
	+aId4rZJ0GzmVGbTIohBAKsLpEpFXZQyikU6xu8owyErJ958OdTYemET9gu82Qa+
	Ry57xAL0+jC/HhDQq5+HQaENlLClvxGSgGtDcfIRbOmV9pU1J9EpmJKOYTsPvFuG
	JrGSqUlyZ3G/opgk4oOu+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28cgah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:55:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGH741C025232;
	Tue, 16 Dec 2025 17:55:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkasc93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV2vtzBZ0RpU8Wuid+1HI43HCSd1SjbauuYXA+EoIYCNfxUlKvJP8aUv68DBQlfP1nbLsN1GECWW75p95S1Kz1qjJ85bNCfC+XHeYyGSXAzgdY2l5AHercdQ0T9hfSoiPFTJ013qS8p8CxCleAYRSWZXIYnHeLRDOJJWXi3tAV4Yepy4+kpycOGn7/o0NtGBfv88ouIOEq/RIHyvkv8oDF0bsyZGIz/eEBZhxsMrIWFxpEBRIFQmvtiLqmg57BNfPVu8+vmooaOEeQ/u/C3JcqSWDUwLppa6GdqhzZ+5e38MJTF61IiFZyeqiTPOGjwF0GM003IM2GKV+MXFWVxYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aanYq8LueYkTyuUlD6S+fmxlWdp8OBTvWCvI6t82eqI=;
 b=JSWWet5ui2HMXq7NBLFQQvQ253DXyOCYm2Vy0LtW+EV3o0ufnFxU9gcqg/8eYEF5dqNXnh7mjliEs259WXmjPz414lmQPfJAuq74/goiJTlHrwhzB48qI59oRLgelJMY1PZIaV0sUass5rnihWX62JBOmw5m4dur2CmfapZlWO/bHDNgBJo/0cMn8CmQzaErLMvlyx8rgbTEuOTSKCCyhk79zReqod9tBhPPQt07+Gy8+4LHKQJxTqNljouK7OFvaZpHKQd3iAU4p+5xWdSVDVV+RC7/HEhejZW2nm/4PasA5egmBehwb+66IA4H/uLPMQxjNdr2OnBbzKKR5xxn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aanYq8LueYkTyuUlD6S+fmxlWdp8OBTvWCvI6t82eqI=;
 b=rKGavTR7KxAz95ZcAc4O5ev6cXL97B47jOlJLzAFcJVwmheOPHdQraBTFXE3NECHJDMhHUZNAJTKW/RPSXxzeD09DpLppkVRQ4L4aZ5hqSCdEx8fn7Dke1ZXdB+oFaDgB51g/YGmaZ6eckNJBJ/8oWAvQ+sbvcNVVMi2Zh6ODE8=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 17:55:08 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 17:55:07 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        K Prateek
 Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ron Geva <rongevarg@gmail.com>,
        Waiman
 Long <longman@redhat.com>
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension enforcement
 timer
Thread-Topic: [patch V6 07/11] rseq: Implement time slice extension
 enforcement timer
Thread-Index: AQHcbeM1s6qyBIihnESRGS2iLgLXNLUj3IQAgACx44A=
Date: Tue, 16 Dec 2025 17:55:07 +0000
Message-ID: <7B4AF4F8-EE20-44CC-BC79-693529F19BA6@oracle.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <d1dcaa6c-98fc-4d02-a958-209c54d8374b@infradead.org>
In-Reply-To: <d1dcaa6c-98fc-4d02-a958-209c54d8374b@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|IA1PR10MB7540:EE_
x-ms-office365-filtering-correlation-id: e0ecfd92-6d53-488d-c8c9-08de3ccc3fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXo0TUdDWTNiUEFZTEZwSlhNVXRtWnZTRW1UbmdBbFVkL0VYZG9vSEVjR2d4?=
 =?utf-8?B?RUtiNnNMNWZ1WUhlVTYrRHd4UjhDZ25rWlFCR3gzUHFnSkwvdW9kSzgybVVR?=
 =?utf-8?B?K3JCUVZ2YkJ5UEVSOEFYV3NCV0hMd1lBMmRnbDdRa1ZxcFhoOGl2YnRidExa?=
 =?utf-8?B?NDMyR1FMeW1pc0tqdFVUY3FBV3dSV1hXL3VUTW9QTGZESlE1OWEwV2FCcFVM?=
 =?utf-8?B?UURRdjBnY0tSc1JGeXdMZzBlVndCTjJkTmxhbmpaY25NMFRTd3VQZC9DRHNs?=
 =?utf-8?B?MnRsZzJLZHgzVjJXaW1OTGFSQi93WlhDVUVtdmg4Nk9IcU5vVytiZHN3cjla?=
 =?utf-8?B?cEFad3NMYlMzM3BZWUR3WFNxbWJkTTFLL3B2ZXh5WlM1Qi9FN01RRWRDaXg2?=
 =?utf-8?B?ZENYNFZaNVhsWG40ZjJJcXhOenlpQ2E5ZVNGNElWQVRMLzdyZ1BlcWZUSHpR?=
 =?utf-8?B?eXRJZnpZeHp2MkkwTjB6M21xdFRYMTRyd2JHaGpDcnZEQktuVUVwQ1NDY04y?=
 =?utf-8?B?YTA3S0tXQmRoL2RzRjBzRHR2TENuc0x6ZGNpVnpJek1WWW5vUUJQcFFrejlY?=
 =?utf-8?B?ZnhsN0EvZnc2UTNGZlRkU0FxZkMvQ24xS3hmeTVxQi9MMHRVVFVpakpLOTF0?=
 =?utf-8?B?TmIvekRTWVZxdzd4Ny82NEN0Tkk4ZTAvS3N2UkNlYXVQSGhyNG1pak4vQmhy?=
 =?utf-8?B?T2g3U2pjb2VXYU9USlhnYW9NdkFWWllDZWFsMnhrYXF1UFlmekpOTVBiZzVl?=
 =?utf-8?B?RFp5OVRLNzRvL0R6Rm9FUExKdFE4ejZvOHRseUxnR25uRWZzWWpkSFBheWd5?=
 =?utf-8?B?dUJBT0x4d3lSc3k2aXNpS2U2SHFmVHpFT0pPNVhXVXFVSjJTNmV4dnhkYjRp?=
 =?utf-8?B?em9YL0ZXcmVPUWdYV1RFbVNpSkdDai9DRG1WY0J1QThiVDlJL1YxRzY5WU5C?=
 =?utf-8?B?NGtnZFVjUTUyNzFUTnNxSVZrQ282ZjA4N2lYMW1aLzBpeWFHUUZXbGlFRnFR?=
 =?utf-8?B?YWNqaUs0SmdvS1M0MHhZQi84UGhacjQ5bW04QUg5akxuYisycHRaZllqVDBP?=
 =?utf-8?B?QmYzTktLYklib21JQWd4YlNhbUhKRVB1MTVGNEQwUUNwL1FiMDdYRDl1dmN5?=
 =?utf-8?B?RTZEVEp6V1g2S2xRV1ZreVdyYzJTdTFlVlkzb1Y4bi9RemhnQm1jdFJGV0Ni?=
 =?utf-8?B?OVppMFZ4dm5VOGUveU45ZWZGWDBXYjAwMkhrcTlsZHFuNHhCSkJaYTJJZDV3?=
 =?utf-8?B?dHRESDdHZjRQc29zNFF3MHlBRHk4WnRIY2VjL2xaZEo0TGQ1c1prS0Z1eTZZ?=
 =?utf-8?B?TkVmWEdoTkZXUTBYMVRabkZqM0tvUUZ5R0laSzhldDdYVlRIcytHWU9hZC92?=
 =?utf-8?B?ai93SzhvVmhYdUk4cE9nRWM4S2JvL2FmMkpFU2dsSlJwZFNhN1lka0tXQ0xj?=
 =?utf-8?B?enlGWnBYWmpCcjJuSnEyNDcrL0VycDVqb29HTnJQdUhHNnNScjRwVWJyYk9v?=
 =?utf-8?B?Vk5ZbTJtWXVDeFYyTmJkMHE4bnF4a1QrMVdIMmtXaGtBaUlqcmYzaVREVXBN?=
 =?utf-8?B?ZStZQXFSZWtJUERoZk1Ic0ZWd2ZCNEUydXBEV1Z1UjZBb1ZROXQxVm9YQWtE?=
 =?utf-8?B?NytWWFQwQ2ZqNkFYR0tBeDZ5eThtYjROU3BDRk45Y1FMd0pLZkVvaXBSeWow?=
 =?utf-8?B?QjRuRUVKQmxTcjRFdnljRkNzTE1wS2EwaFdjYXFhQkhiNUdBVmxRSFpnbXY1?=
 =?utf-8?B?SUNlV1VqS3FTZ25MWFBQYzRoMDk3ZkxCc2k2TDYzVldyVkFJcHVzdHk2YVpy?=
 =?utf-8?B?dVRoeWRQOG85amUwZG1CZFpNUVBKOUVXb2Q5TzdFRjBVUTZpajBGWTlWZEtN?=
 =?utf-8?B?NlRJeWxIVlFlV08wU3BiZ2pEd1RJY0RBSUNaK1NYdXBBQ3hOMUdweWxOMU82?=
 =?utf-8?B?Y24wWGt1ZkE1RUdOdEpNaFlkQU0rYXA3YTVtSnQ1dWtTbzBYOS9UVzJ1RXg4?=
 =?utf-8?B?OWdlWlhQSi9vcytUdC81djJmQWdHcW44YnZCSVN0elcrR1VHTE1hZE5pM2xN?=
 =?utf-8?Q?EBXcmo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTY5WDNRTmc5eUU4NDlzSkx0eDk2c0FCL0UwcE04T1RVL3lhQUt4dUROWWVO?=
 =?utf-8?B?OFVhMWV4TnM2TDNTanBMcmp6YmJxZ2dCdHV2QVM4ZFc5MU05STc4V2o1cmtz?=
 =?utf-8?B?a1p1QjhseGQ2dzFmVWpJM04yaU1tWXA1amhMRnI5UUxvR3lrcEpSZlRxMmZj?=
 =?utf-8?B?R2NFNjlta01PQXU1V0VrMmdjZzJtdHBqUUdJLzdITVZPR2Ryai9xZjZlcC83?=
 =?utf-8?B?Q1lPV3B0ajdhajdpdlpUV3dMTUlFbnZwYXdZWCtvRUNzdmFQYjdTRzUzNkow?=
 =?utf-8?B?b2F4dmJwVVFsQmFpSk5ZYlVBWjhEdmU5UnpVMHBBYjFNZFZZbmlKbENENjdP?=
 =?utf-8?B?M1ZDaXNwQ1dtWkVFaVVMMXpjRExBdGUyMjJMekF6K1Fralh4cW01NFRUWUtB?=
 =?utf-8?B?cE9RL3A0Sm9QZ2pqcjBCbHhOVXFuS1RFV1h3SmM5Zm9tcitLMVNkVWpOQzVD?=
 =?utf-8?B?bVcyOW5SYmFQSndUOWJZTEhnNmN3U2taYTN2WFp1cWxiNUh3bmFRQ3hqK1BK?=
 =?utf-8?B?NDh1T05BMFQxWUR5SCtTVTNIbnlvY00vQ3BWRkl3QVJKQnoweDVDbkVOckJJ?=
 =?utf-8?B?V3BFUFI0UGNiYU1rTXd4Z0FsSVFqbUc2MStWVk9RZUQ1RjlGTWtlVGU1MXNm?=
 =?utf-8?B?WC81R2F3UmoxaDR6dUY2NnJNTElDTXZtVnoyTVRTV2dXRFhUaWhwdHQ2VmZO?=
 =?utf-8?B?T2JSOGw5eTIzcExZenFBMG1OS1lzV1pWem5wdlBwZEtzM1ZES0tNb2ZDUFBP?=
 =?utf-8?B?U1k0cnE1QUllVERCZUdEOS9UcndFaDZXOTJLRkJGUloxanVQUEhxdjUvSTR6?=
 =?utf-8?B?eFZGUWluZS9tVElRWSt6V0hxNjJ5REdoRm1KTzF4T0NFTHNIQnhXQlQ0RnFV?=
 =?utf-8?B?U2ZhNWhvMnl0aFA2Yy81djI1Qlh0RDdOV3V1ei9Ca2YrRlZsbHdvN2hQaTJ3?=
 =?utf-8?B?TW9IRmNQY2w1VFhqRVMxRDZFNzZPb3ZvZmJ5YWJXVlBZVG9ySE9RYjd3dU1V?=
 =?utf-8?B?NExOek9VeTRGVFdxTXF0TWlVM1ZZUWlsTllqdnplSk9ranp0emRxZmEyR0lQ?=
 =?utf-8?B?ZUVOMlVKVmN0d2luRXh4eHRrR0RhMEpmZG85YVZUbnJ3Z09qK2tndEs2MEU3?=
 =?utf-8?B?YVEycFlKR3BhS1ZXSjBwQ3ZPWlhFZEhBZnRETXphOVR0RjJUSWs1UndUY0Zt?=
 =?utf-8?B?VkFCVk5OUlpmdHRjRDVJOHNzZUd5STRXNlBvWnAvVTJ0dHc2NHdma3VBV2I0?=
 =?utf-8?B?TSswSkpsbnJjMHBaL0pHNUl5UEc4VFdIN1RPYXYxMUpCYXpIWmJ2Z3R1aTVh?=
 =?utf-8?B?VjlhemFjeHVOQzd0UVl2ZU4wL2RCcWFPYnc3NDlXZTBVWWNVZFZFMys1aHJ5?=
 =?utf-8?B?a2FyMG9rb21VdzFSaGxFeVBjcVNvaDllTnN0WTM5S3U4aXBNYU5QcVRERGMy?=
 =?utf-8?B?SXh2UUF6eEpUNnZ6NUZXVHZFdGhqRmJLcTZ5UTNKVktybmJXaTAzQ2lPTGwx?=
 =?utf-8?B?NVc2S3lSYkVMNDRwM2I1QkhWaFdRYmJTWTZJaXV0K3dFL0ZiS2pwQUFST3RX?=
 =?utf-8?B?WVFwcVVBbGJpc2VOODc5ZzBqYzBxUHk4L3RtSVIzTnlob2VHMXVGM0FoY3ps?=
 =?utf-8?B?MklHdUE4TWMxbzQvMzAzRlNTcUxGbFBDT3h0Y3NjWUtNTVM1SmNUZzdXK1Q3?=
 =?utf-8?B?dlB3RnVPRlBmYTRCSlpPMEdVOXppYUhzODZFU3Y5WThyYjlFejdqK3VNZFBw?=
 =?utf-8?B?T3hIdWhXS28yc0xMeW5xODA3Vm54bk1PRzBRVHdBNy85MmxpQ2JTL2pIZ2hZ?=
 =?utf-8?B?bHFhakRWcEVvaXJHd3RzTkxkSVpQVm1DZHdEeU1abEdyN1hUQjY2OGdibjcv?=
 =?utf-8?B?cnQrTmlsaFJwK1VuZzhTR3hKL3FtdVVFTlhDRWRudHBvVmlMTWpnblVBRnNm?=
 =?utf-8?B?N1Z3NzgxWnFMUFdvZ3VabTBrUGpPblVWb3NLbHh1eWtTV2E0YzBmSUNHVTJ4?=
 =?utf-8?B?N2tBQnMzNnZpRi83SFE1eDVLbzJnUklYcGVjQitxaWxxQWRDVXY2NFlya0Zr?=
 =?utf-8?B?cG9FdGdhYmY5cm8wQTU0NitweEFqS2YwMlFVMHlrNXFyVlFmd1dMZFRGQ0g0?=
 =?utf-8?B?S0pDS3pSN0h6bFQxcjdFaExHeW4rWkhSN0t6bXJwRkJoUkJMSkk2N0EyUElW?=
 =?utf-8?Q?YEVduq5as0PxI8WrLFikZMI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C1D691FEE9E91419022AEB046ADA633@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QyiwnZNq/156Uwem3gRNX5b/ipMTTkq0CRmC4lxQCTmtTIspz323LIx3OPxuiIWKfaXy6CjBQADVG5Ig9IS3Rhagr/X3lybgoYxElmDEz0b0QaIR8uWWBy/n4RIJ/Xh7GeiTU8abv93TBG5jtzZ5X0CbUrI8hfttplLlsR40olZQAw1A09sN2suK9uZH+ebHNHPDysqlkL3etweB71g6YZMx+OMPkZ/WzpIswqWY2TCZWzSTimpQdaiHl+O8SGiIRp7L5hhYtpSF85l4dQlmKAvHyk2DElggBtePJ+Z76y+kPRYN+SkO6JQD+JDrohYzKUJy+VS9VTo5CRA2w6xcY0faudmJoFDc6Mz78nVTlbgF0KM2gG0jw47rOFEQnw45LP7Kr76K74EoMC+ofzttMRegyXDkBdJOvCCFolcE0ZB3YT0+LN8EWINu8Fu/6rlOhT+rQ/WfeqCurJsfonB6fVrFf6aWSPDISdOc5JawRYs7ATvxxuVHY5v1vceTcAFEhqMeNVykc/krwTAn95mqokx5qxt6VEfljIAHMWUni+zE3ENLX9g3JDhGh7rLnPaisnsLEdais/zWuZ/CuQfiMDcum6N9DG3vTYC2G7VVLW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ecfd92-6d53-488d-c8c9-08de3ccc3fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 17:55:07.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+FDzWTC7bD5NcaJ/SHF4z9RhiI90EL2H40LvwUiBohf10hGuZcHdaDKEywmwxDnOOx14HeLZ0fNHJvMzJQgDqKIpZyYML2qWe3EyOGW4xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=971 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160154
X-Proofpoint-GUID: eAxEZEsucXvh37KDHQayOoJ-8q0DoZQR
X-Proofpoint-ORIG-GUID: eAxEZEsucXvh37KDHQayOoJ-8q0DoZQR
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=69419d00 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=jZzICNVak2D2NI_y5wAA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE1MyBTYWx0ZWRfXwlxAvzFnevJE
 kkHpmAAf2mkGjibOm5XfwywegyfckBDn5JxjmJ2I3wOzzpK68Rj6JSdrfNdwatGRaF9OQjLJTi0
 0Zpfb0viUAgaQsQcRb/B1BclR6TPUkJ4PJz6KMEx2WSkoCDW8yHHOuZ3jgliwIty3QufMb93nxs
 m59ns8U5yfVZ1fV6JQCuRks5vZFtzgZVOPqu6yI4SjTAj227lPfq9uXJbXbZQhC7d0skXHx5ai2
 PP7dFPOFqniA9K8goYs5xe+nRzltTC2ZKXiUO1pZDREm0hMIo/HnJ/42RWtww3kIrNySOkoRGLJ
 YIITf4/Lu6t+aTpRNOaYzi3agUwv0kUwlM/JfhfZcs5CISKbYqbQ9oD6knSh/y9nOrVK49tSgZI
 kDL74QJcGDP3tyGDsYjmLob0mLCGSg==

DQoNCj4gT24gRGVjIDE1LCAyMDI1LCBhdCAxMToxOOKAr1BNLCBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPdWNoLiBXb3VsZCB5b3UgbWluZCByZWFy
cmFuZ2luZyBwYXJ0cyBvZiB0aGUgZmlyc3Qgc2VudGVuY2U/DQo+IA0KPiBPbiAxMi8xNS8yNSAx
MDoyNCBBTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9zeXNjdGwva2VybmVsLnJzdA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9zeXNjdGwva2VybmVsLnJzdA0KPj4gQEAgLTEyMjgsNiArMTIyOCwxNCBAQCByZWJv
b3QtY21kIChTUEFSQyBvbmx5KQ0KPj4gUk9NL0ZsYXNoIGJvb3QgbG9hZGVyLiBNYXliZSB0byB0
ZWxsIGl0IHdoYXQgdG8gZG8gYWZ0ZXINCj4+IHJlYm9vdGluZy4gPz8/DQo+PiANCj4+ICtyc2Vx
X3NsaWNlX2V4dGVuc2lvbl9uc2VjDQo+PiArPT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4g
Kw0KPj4gK0EgdGFzayBjYW4gcmVxdWVzdCB0byBkZWxheSBpdHMgc2NoZWR1bGluZyBpZiBpdCBp
cyBpbiBhIGNyaXRpY2FsIHNlY3Rpb24NCj4+ICt2aWEgdGhlIHByY3RsKFBSX1JTRVFfU0xJQ0Vf
RVhURU5TSU9OX1NFVCkgbWVjaGFuaXNtLiBUaGlzIHNldHMgdGhlIG1heGltdW0NCj4+ICthbGxv
d2VkIGV4dGVuc2lvbiBpbiBuYW5vc2Vjb25kcyBiZWZvcmUgc2NoZWR1bGluZyBvZiB0aGUgdGFz
ayBpcyBlbmZvcmNlZC4NCj4+ICtEZWZhdWx0IHZhbHVlIGlzIDMwMDAwbnMgKDMwdXMpLiBUaGUg
cG9zc2libGUgcmFuZ2UgaXMgMTAwMDBucyAoMTB1cykgdG8NCj4+ICs1MDAwMG5zICg1MHVzKS4N
Cj4gDQo+IE1heWJlDQo+IEEgdGFzayB0aGF0IGlzIGluIGEgY3JpdGljYWwgc2VjdGlvbiBjYW4g
cmVxdWVzdCB0byBkZWxheSBpdHMgc2NoZWR1bGluZyB2aWENCj4gdGhlIHByY3RsKFBSX1JTRVFf
U0xJQ0VfRVhURU5TSU9OX1NFVCkgbWVjaGFuaXNtLg0KPiANCg0KV2VsbCwgdGhpcyBwcmN0bCBj
YWxsIGlzIHRvIGVuYWJsZSB0aGUgdGltZSBzbGljZSBleHRlbnNpb24gbWVjaGFuaXNtIGZvciB0
aGUgdGhyZWFkLg0KQWN0dWFsbHkgcmVxdWVzdGluZyB0byBkZWxheSBzY2hlZHVsaW5nKHRpbWUg
c2xpY2UgZXh0ZW5zaW9uKSBpcyBkb25lIA0KYnkgdXBkYXRpbmcgYSBtZW1iZXIgaW4gcnNlcSBz
dHJ1Y3R1cmUuIFBlcmhhcHMgdGhpcyBuZWVkcyB0byBiZSBjbGFyaWZpZWQuDQoNCi1QcmFrYXNo
DQoNCj4gLS0gDQo+IH5SYW5keQ0KPiANCg0K

