Return-Path: <linux-arch+bounces-14718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E6C5573B
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 03:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673B83A4991
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6EF2F9DA7;
	Thu, 13 Nov 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pW4lCJ+I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZrlmSEvx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D601FBEA6;
	Thu, 13 Nov 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001347; cv=fail; b=ks3oIU/774kMZc6qTUCmPA3lxSfViMrhoWGiLwOrs+mtObasY9AeGAE4VBQemlMBW1mOejAt5ApVkVPX098nT3vk+H6X7cmQn7TOkSKuwMpbO81YpawIqjNzMky/I+T+nTvkJ2Qrr2mj01carQsrcQp5cfm0ADd3vZCKYLDtKi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001347; c=relaxed/simple;
	bh=GtVwHlt6T/CBDUSno1/1qHh0WB08BQOIwGtBjGqDNlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EPV2Q5AsNedT9YTiflGlOs6XGX+re6MVbFDWPGzXZSaRK3I40/sIvj5jIqryhY9KB3ZnUtPzoiZi1iSQAjVPA8xkYO146IS8PiXvDReQ1bYWimN8Peru3Egxy2aEeY7vAroN6WdjHY5KcDR/xFni2ZwAqsjiLVZo43TyuyQ2TbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pW4lCJ+I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZrlmSEvx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gUPT030882;
	Thu, 13 Nov 2025 02:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GtVwHlt6T/CBDUSno1/1qHh0WB08BQOIwGtBjGqDNlI=; b=
	pW4lCJ+IlUiW+IORx9ol/r6fexgfEM1mlGaN5pkCdjYfttQn9vgX3S4u+r1h8b1P
	m+LpEnxVgnuG+9HmXFEaRdxulGS35enJ4ZacOjZZ15Uv9+RHaIjjrF+jM88rEgZK
	12mnIgdBf8/QifLSy30CL8p7DHxyp9gTdd+xaSw91E/8DYiRoQIZLZt2U0us11o7
	1Xocmx+or/aI2M3fQYammk3n6fRC9/RouPBUaZsc4S70n70vXUwlFBxpAWbN/CzK
	mEnxBOQXSOWkqoODzYF4qdt5eENZ+pRxUsKLiyLWjbvOXFJwVhF9nlUm9+b2AWBg
	0lXteNJIgb24xrqX5Iu2lw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyra8pvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 02:34:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1F8kt018676;
	Thu, 13 Nov 2025 02:34:21 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabgwsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 02:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRHw0/hcUeaZSDUbzO05BDcep0wMCr3nQgjEBMKJLbWWZJ3IcrhSrRLP78pMAsHDNzhT4x4fKBqo3XxsTsW8Nw9t5ZhqSPxj0efqUwnT1qlIHsNatEfF/CijtaObgfxJ19EEZLO+xNwCPWWSKrb090wA3Pc2hSPge0Sagk1OgwtVMrC7EtJNvFeknji48gkmgPgPTQ49bq31gLF0QpMHfJPex+h9heBBq2WU28wbNN4z3mwVXOiOr20CQIuOnjKdAbr4mnrNO6vP0i7E1bvjyEH5yFXyLPnjq0+fyt8sLJE3+Nlh1aDxKd8NxHmDl/RNu7FHajbIR8jg8j8wAfHu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtVwHlt6T/CBDUSno1/1qHh0WB08BQOIwGtBjGqDNlI=;
 b=X77jqvgEbBE/5XhIttTIU9C9yOPbDxWe/966qZLWrCGtUwPstjP1q6ewFKZ1EdNoA77dnkTTBvSFgREucN4Rj/47pPqNiFL6uLePbqmxbrfT1vX1NokuDZHVlqRNtcNUJYJSmWlrufVJEP864YGdslZtl/W7Z96tanPSjvzTkXJt4Cr9cZLOWvTnY7lFFiioVmQzZFotiG1J9eAU7zjpvSY8AIxPjV48c/ZJXhNTThBq9YngKyRRTRpMyuA7unDnBt71Tp4eMHnVfe6kphpPjAHllO/qIMEC/m7m710BMhTQ2E7eek4DDitpQsO17MSSniNQ5DhW2X91Z9a4aW2mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtVwHlt6T/CBDUSno1/1qHh0WB08BQOIwGtBjGqDNlI=;
 b=ZrlmSEvxDeq40ZcjcwD2qLcXOm7hx2DvsoLYAbqGwltjXGewD0o/Jofm68rzoEPMaMuW0WYt2j02BKyCp03lbTvmXU7KnXypJWMiOJE4z4ADjH7OVKev8ny5BxlnvZva3rvq9/mR8Tt3tG9lIYNNqPq4PSiW9LISwVi2AWz2CN8=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by PH3PPF34C504C55.namprd10.prod.outlook.com (2603:10b6:518:1::793) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 02:34:18 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 02:34:18 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul
 E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Index:
 AQHcSNcOglHsgNF4y0S/q4HcTckeK7Tl8+kAgAYViQCAAbkyAIAA53EAgAEC54CAABZfgIAANu8A
Date: Thu, 13 Nov 2025 02:34:18 +0000
Message-ID: <5DFB2CA1-8751-409F-BBEA-CB753E717821@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
 <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com> <87cy5mewxk.ffs@tglx>
 <368CA4A7-3640-45F7-810F-2E2A073FE27C@oracle.com>
In-Reply-To: <368CA4A7-3640-45F7-810F-2E2A073FE27C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|PH3PPF34C504C55:EE_
x-ms-office365-filtering-correlation-id: 5103080e-669b-4794-465b-08de225d254c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZExpQ3pMczkxT3B6eitYRU1TUUh1SThaM3ZOb3E2NWR2eHpIRUpydFc2T3ky?=
 =?utf-8?B?SkFiZU92SFVPZERjUDVGajJYaUpMS3hEV2NGVUtJNHc2ZWxKUU0zRlA0Slkx?=
 =?utf-8?B?TnBPZXVGQUVKNXdkWTFCbmdiN0dwTHl4QTZvbHVzZHkvZmtOSjhOcUFiTUFY?=
 =?utf-8?B?cTNjcHVkVnc2TmFXeUhRTmRyc0FhLy82cFkyaWtNRFQxQnM0d3c3d3l1NWNS?=
 =?utf-8?B?ZEkyelBXTHRWZzg4anZLRWZVUVUvTkhHSVJaYUZ6RHppOVRxUTVnM3Jub2Vn?=
 =?utf-8?B?dEpoWks4Q1BRTHVVdk5zdHJZdGNPOTJoQWRYM0N2c3ZqSnZ6UW94dFp4VzFz?=
 =?utf-8?B?SUdBcUhMdlRCejFxVktKclhWZ20wNktRYXRDZUJUL2ZRSzFUaXAzbWpWMHkv?=
 =?utf-8?B?VTdnY1ZKYUVlSFpWVERJMnVId29MRFlsWVluSm5KWlNUMXRUQ1FOdnNjUkJK?=
 =?utf-8?B?dUVjZDkwV3Foc2dEQkE4VzBEUzdOVHAyMkExRTdBUjdHOWNsV3cwbitsb1ZN?=
 =?utf-8?B?VEUycUFHdlVGMUtmM2lnZi9zTnFDTmpCb2hNQ3Q2aXNOOHhBS244Vkw4aVZs?=
 =?utf-8?B?SFd3RE03emlRRWJJZU1xLy8vTzArYWVIKzUrcUthQlFwOVJ3THVvTlVoWU4r?=
 =?utf-8?B?UVJ4N1dFN1NDWnhsZVNoczJFZ1oveklzNjRqMDlaWW5WR3VFaHI1L1lCeTdY?=
 =?utf-8?B?dmExRGcyRkQ4d2l2WTUybzNvZE9reXk3YXUwUGltcktsOUFJc0s5N1UxV1hZ?=
 =?utf-8?B?S3pRellDU3RrRVJkRkFBMWhvRHFXMzc2YWpTQ0RWVm54dGZmK2NFenNpOXd0?=
 =?utf-8?B?WVp0ZDVobldMOFBheVZoWXlIcjdkSFpNbkE2WWI4VEJ0OERNWjdaL0V1NVI1?=
 =?utf-8?B?MmxCU1k2ZDU0MGlPa0lYMVUrbGhmUUlsL2hnWEcrcGl6NS9yNFlLdEdPMVpE?=
 =?utf-8?B?VGtWMEkrc2srb0dzNEtIZFdsNEU3Q2lOV2Rub1gxSTZHdlRqQ0dtUWJNZkth?=
 =?utf-8?B?dW5FcjZxVkJaSmdtdVRkcy95akhsK0dLSFBMSXh1LzEyTlFaTTFtVTFkRkY0?=
 =?utf-8?B?dkNBRU5NUlNTWWtiWWU2R1dRQm1hdmw4bERSUnNJNUJFZXFvWFZsanRFUW1S?=
 =?utf-8?B?YlBqendKNFdtYUtqbzVHWUxrLy8vcTF6NUtLdW15TSt6aUUyZFZqK24xbnA5?=
 =?utf-8?B?WkNSMHA2WDBYVHJ3eGJrbnJhK1BYR0U3V3MzTGM3VWZkOEZFZmh3aUtRSnRH?=
 =?utf-8?B?Qk9OWGV2SHFscjBBNlR3UWhyajZad3IrWDJIK0hnT3RiM204SWJtb2phNlZI?=
 =?utf-8?B?a0wyS0VYdXlBM2lFTk1TOVltWFJvaENabHV6VGp4OHB5M25vQjNRRWlzRlJO?=
 =?utf-8?B?L0J6c0lZbDNQTE1RK2V6NiswcDhoYjUxdWtxL2tTQlZTTFBZYUpaWEgvRHYz?=
 =?utf-8?B?cGZPK0lVK1ovNVhGQXhBb0UwMUljSyt1eTg0M2JsRFQ2T3RndGdYbkdLbDZo?=
 =?utf-8?B?TVhhZ1ZZeFNFeUZZenU4VE50eDJXY2FUaGFrRHRqanhCQ2VobzdVNEw5R1c4?=
 =?utf-8?B?VmtqTDBrclBsQ2tHQzgzQkVEcU1xa0NOcFE2WEQwUGNMQkJxdEN2VDczSWdN?=
 =?utf-8?B?bW9RRFdjb202YzR3VmFaTDNmVjFxeXA2Szc3OFYvTnRtMlA3emcxNXJNbzgx?=
 =?utf-8?B?cXcvbWtrZFMxaHp6V1VhaktEWXdzUkdMQlloUU8rdmJzdlpGSG0wWE0wVU1M?=
 =?utf-8?B?STh0b2FGbkRHakdTb0VjVkRiM0d6U0ZyT3ZxaWExOFdxL0VZdUpNb0lMcFdp?=
 =?utf-8?B?OU5ZcG9sOWFLWGFaUE5JdUZpL3VhUGlIa1d3SHl2N3Z3OVJyY2k1NjVuSDdn?=
 =?utf-8?B?V0lBWHZWeW1GbXY5V0JFaDVwcllHVkV1SWZVK283MVFmRU9sUFpvMnNuRjgy?=
 =?utf-8?B?OC9XMmVZZmZLREFEWW5hbm1nUS81aUMvOUNxMzdENnQvTWRhN2xCY2xUTHEy?=
 =?utf-8?B?WHEyQTdwUitFeXFwdjEwQ0VYTGVkZFRsY2kvZ2QwdlFCNGNjbndtZzVsVWZE?=
 =?utf-8?Q?9wJF23?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2I5MkFCRnI0VjNnYW8zdmNzd09zc1doVjFxTnZLaHVHcHltNkpqZjR6ZFlO?=
 =?utf-8?B?bHJOTzRWeHBCT2E0RFUvVkppN3VieVc5MitodEhNOGI3eEhiV1lmbXYydnlP?=
 =?utf-8?B?SmMrcWZqaTFpUFY3YkZjYTRUdk0yR0paSld6ZzJObWxUOXV6YTBoQVkvTHZO?=
 =?utf-8?B?b21aQmRQYXMzQ0RKajZaR1BKTnNlSk4rb1VOUlJCaVVXMlY5WHBoVVR3Wk1T?=
 =?utf-8?B?KzRRcy9VbytQZ1p4L1lNaXB3bThmV2RwV2lSUTRlNHhmN1F1UEZ2NTBmQW1X?=
 =?utf-8?B?ZVpObW5ZcnM4UlhTQ09DQVZ1T09pUVN0emtSNFhCSzNEbURva2FkaVNjOHNS?=
 =?utf-8?B?YVRybzMwbklhc1RRbnoxeTd3bTlpc2hSQ2ZmekljZFc4M0MzNk9OdGNNdXF3?=
 =?utf-8?B?R1ZPYWFKT1lLclBzUWY4WnJIOGpCNldQd3JXTXgzK3I2OUMxZ2Z6Wkt1azlD?=
 =?utf-8?B?N09LK0dKWlRFQkI2T2dWYkN5cXJQSy9sMk8xMEtlWWdzRjIwbThFM0pzZFlk?=
 =?utf-8?B?Q3V0T0QvN2hyVE1IVWxXcnhNY0p3RmkyWEdyVjg5Y1pPckM4VXg1WTJrRGxZ?=
 =?utf-8?B?VWpIZWdRSkswcVUrZjUydDBWY1A0Mm9GeFhGOFN3SFZxUHo1NFNBU3pKWm92?=
 =?utf-8?B?b2RMbDJyUUkzWUZTRTZjREsvTGxNTjl3eWlKQUVMcGJZQjliQkFEdWVBeG5t?=
 =?utf-8?B?WDVyb1lWV0J5ZndKbXFmL2xzbmJ2Ym4vSlB6aDJvMjBPR1gwaVZLeERUdFY5?=
 =?utf-8?B?YzN1RjNPVXZUY0FnbHczTW1RNng0NFptY2pJSzRYM1N5VkJ2Z2lTZFgvTS9W?=
 =?utf-8?B?M0NXdFRrSzVGT3N3TXVZMmhrcHhsNWZiSFZWdWRNaGE5UTJsaFYwdDRFMW81?=
 =?utf-8?B?RlZnQnl2aThIWGhrYXc3ZlNaOTJsK2E5blVWQlJkQ2Q5ZnRiYTQ2R3hlT09E?=
 =?utf-8?B?Yi9SbU5Rb0JYb216bVBTQ0JGNlZYcU13STY1NGx4cm13MHluUEc3UjhrakNQ?=
 =?utf-8?B?MHBSTXNHcWpUdytNQXFZbWVEMURLSk5WZHBEZmk5QXF3UlhoZFdGK3pWUG8y?=
 =?utf-8?B?Nlh3WHRzeWNncHZKbzNnTUhzVm1wbW1acWVhandLdkltQVZ1WXkyY2lmeGpQ?=
 =?utf-8?B?UEVvZkNUV2ZqSkduOGRuOGNialRxemM4ZHBlZjc3a0ptY2t6cXM2Sm83QTYw?=
 =?utf-8?B?WXRMbXZrWUsyajlTWGhEZnNQdnJXN1pRNVA0TkFCeDBESHBJZS9LZUZaWk4v?=
 =?utf-8?B?OUhIRGFla1kyekdGTThOdmNzVWNvTDFsZnZScEk1MmZOcXdtbjlmS3BwcXhG?=
 =?utf-8?B?VCtxc1B3N25OZXIrV3JGY3ZTVTRXc01Kd0Z0TDZacGhKcTM2VkliRXFaTEg5?=
 =?utf-8?B?NVJpQ1ZzakU0Y09DTlNqRXRSQjk5dWtkUG1mTmZocUo2MzlBQUh1aXY1QXZ1?=
 =?utf-8?B?b2lxNnR1ODFRbjY0U2FPbTZ1OUlJQVEwc01vWGlUeDg3bDRkQ2JxS3NBVTIw?=
 =?utf-8?B?NXJTZzNUZWVHUndtSlVDalh5T2wvUmZHNU5iaGpvMC9pNGNRQXd1Z2tDcHZ5?=
 =?utf-8?B?aDllVjZJK1ZteHBhVHRkN2FpVTJVN09kNi9vMW5LM1dobHRURDlZZGlCeU9p?=
 =?utf-8?B?UUZOR1Fsb0h2TEdMSkpyNjhQSHExdHcvYXVlYk9ScFhESk1WTnBDNGp0NkNM?=
 =?utf-8?B?dG02cGhkUE13WnR2bDF0N2w4RGxSTmdwZkhHMURMM3Z5bWNlaHFOQUFmc0VP?=
 =?utf-8?B?UHlJMlJIWmFxUFg3L0daREE2Q2VTS29vQ29oWXZUbk9nWnpVQ2h2RlZQK3RU?=
 =?utf-8?B?bjBCY3ZTN2NhV0IwaGYxbkgxMUtHaXU0SHBNYmxOWDZiL08rVDYrWkx5VUhS?=
 =?utf-8?B?VzFnSllReHVoWnVvV2JwUERNbUV5QkFsS1hBNjN4VGY2a3dqR1dIcSs3Vndz?=
 =?utf-8?B?ekFSQ0VFMk90VjdvdDd5czlpL0t2akxrTDVRM1FvUk10YmdWY2w5eGZLQ1FX?=
 =?utf-8?B?clJFazI2cTZoanlFcWE5SWo3T1NKbXU2MFhBQUhmL2VoQnl2SmxmN2tITEhG?=
 =?utf-8?B?VldGOFJOM1hFWHZLQk1iZ0dVUUhJTmJQWDdjeUlTczE2N2Rwb3p0bTFmclFS?=
 =?utf-8?B?M3Q2YjQzbVZUcEZ0cUdXYXZCbEplL2dsMzBhaHIvVmV0dlBZK2pCR3d1SDZN?=
 =?utf-8?Q?cnqyOfD8/3lE0f3Phyhu6Pg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <388FD3AB8CB9DE4BB05F398ED189D379@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZuOWve5DMWQwjRSUmuVfQFt3ELA0fF/Vcx9aLC+3qG7/8bzF6mKWMeWzpnsGV4zg5dvh5K3V4BsTFXt2t/lTxgdXT15P+kVXZRZk9OZwRLDBFpq7tz2xBnAoczZVFzOilITtEjyQ/1LZ8OjPl+mv10Nf5VZMAjWb2tJOI3HkvwLd1spOuyW4iaYfyhosadWTe6QYt8lbb4MepK4RcCa96VtO1/Uhbo9SX2sfa+ZfUKccrcijH4sZ3UtgeRF8tBYncTy0BEXUPZ6458OXsAM7kaRRYZTmCxOouGui4cA4zeeO1dgHyZ9r8pT0rsngwTQeJLcHvYcD0IqJ0WMOxv1CJtF060KZRsNMucVN8csvEXXjxxw2Z+VwLi+lv9BvlmZGDCEABve9zyCU6HY5YMKqe6+gG7VkujpD+hZghtKIk5vxjI/yQintk4OXxWX3BFGa15zbA/q5VAjsXe6HYt3MKwzDRMkRX/kEFWIIFtRrqjhbJXH4NNtclwe5bJXv64Xal8x85c69YXfYNgOyEAEt/ujmB7/kagnRhP+VYGujPq8oXZ7BbD0qnMV3WQwe0SxKiWsvZRRTGFMpxREEkA9LjmQ9yb582ReZhrgdeMKDoH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5103080e-669b-4794-465b-08de225d254c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 02:34:18.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUktFqVxl0WLgDZwWn7Uqsa/Tw4u5AXcbBeQAuFbUOYqD6z72TsuqJNo1LsHcVAXJXIFaPpSs08gCMVng0+QCnDLQnaYuw5b+mOJzAxEsk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF34C504C55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130016
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX51+buJojgWDB
 3i3OfR1ldZUm7fkmeF2sq/w4yU/NviLIuGotN42zRNdqc4BXRQEJp/59KW9V53xbAJN6uVSBjuc
 aHlvJ5l3UWOciC+ONS9NXbyoL4+fcZLf5w8H3MKDqy4XpnA9XalyuBU+jdpz+5mfc6SmTrJf/3Q
 s9pAXtmQXvcOK/6PQUvZpdY2KaC/YCvlWLHxtGkCSGbuqYpNNFYiBi8G4WrrhjEQL8pXZUGZdiB
 1VbpP5AZpI1Afg54J580mTQhE3K8uqhQxgKQpEmB3xJwDjdyNxhfCa+8R6YKysLxwhZfYWxYs4g
 OSNcYWEcC5yBoC2XrypZ27h4ADbz6RBDcaSEDPGCJEDVRh87WVEne/CgoVsbBiAJdM5ehDPSwWr
 zRR9w6sDsvQxMFU8CLACsT3ICl9V5A==
X-Proofpoint-GUID: uo83TQ9bt9dGcYO4BjADYntdRgL35uqP
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=691543ae b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=GrFaqQQxeLmYTSPIwwIA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: uo83TQ9bt9dGcYO4BjADYntdRgL35uqP

DQoNCj4gT24gTm92IDEyLCAyMDI1LCBhdCAzOjE34oCvUE0sIFByYWthc2ggU2FuZ2FwcGEgPHBy
YWthc2guc2FuZ2FwcGFAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3Yg
MTIsIDIwMjUsIGF0IDE6NTfigK9QTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+IHdyb3RlOg0KPj4gDQo+PiBPbiBXZWQsIE5vdiAxMiAyMDI1IGF0IDA2OjMwLCBQcmFrYXNo
IFNhbmdhcHBhIHdyb3RlOg0KPj4+IFRoZSBwcm9ibGVtIHJlcHJvZHVjZXMgb24gYSAyIHNvY2tl
dCBBTUQoMzg0IGNwdXMpIGJhcmUgbWV0YWwgc3lzdGVtLg0KPj4+IEl0IG9jY3VycyBzb29uIGFm
dGVyIHN5c3RlbSBib290IHVwLiAgRG9lcyBub3QgcmVwcm9kdWNlIG9uIGEgNjRjcHUgVk0uDQo+
PiANCj4+IENhbiB5b3UgdmVyaWZ5IHRoYXQgdGhlIHRvcCBtb3N0IGNvbW1pdCBvZiB0aGUgcnNl
cS9zbGljZSBicmFuY2ggaXM6DQo+PiANCj4+ICAgZDJlYjVjOWMwNjkzICgic2VsZnRlc3RzL3Jz
ZXE6IEltcGxlbWVudCB0aW1lIHNsaWNlIGV4dGVuc2lvbiB0ZXN0IikNCj4gDQo+IE5vIGl0IGlz
DQo+IA0KPiBjNDZmMTJhMTE2NjA1ODc2NGRhOGU4NGEyMTVhNmI2NmNhZTJmZTBhDQo+ICAgIHNl
bGZ0ZXN0cy9yc2VxOiBJbXBsZW1lbnQgdGltZSBzbGljZSBleHRlbnNpb24gdGVzdA0KPiANCg0K
VGVzdGVkIHRoZSBsYXRlc3QgZnJvbSByc2VxL3NsaWNlIHdpdGggdGhlIHRvcCBtb3N0IGNvbW1p
dCB5b3UgbWVudGlvbmVkIGFib3ZlIGFuZCB0aGUgDQp3YXRjaGRvZyBwYW5pYyBkb2VzIG5vdCBy
ZXByb2R1Y2UgYW55bW9yZS4NCg0KVGhhbmtzLA0KLVByYWthc2gNCg0KPiBJIGNhbiByZWZyZXNo
IGFuZCB0cnkuDQo+IC1QcmFrYXNoDQo+IA0KPj4gDQo+PiBUaGFua3MsDQo+PiANCj4+ICAgICAg
IHRnbHgNCj4gDQoNCg==

