Return-Path: <linux-arch+bounces-13704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB0B8F04F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4849017AD7A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 05:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF1202F93;
	Mon, 22 Sep 2025 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dgKs5Ryb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q565InWc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BA1F2BAD;
	Mon, 22 Sep 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518983; cv=fail; b=JW0WxpgBh49TJQS/bJNElTW1g1U7lhV1tUWbeYgNBkX6GVIgHU/F+l/THC+dfysejLQOEmEqsOyWBqMSoZ1xSKMmTvIxGjnseo8K/IIxMvUVt2Jix11csC2IS11/Z94UANh+mR5NWd/9i9Vqpbgdki5h1z2nLgQalRWWeYkdKsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518983; c=relaxed/simple;
	bh=yTtGOuIApl2v73g5O7pOQJOaX14O7vJE4H0t6I51vk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ty7Q5plzdQAFPMWvNB73LuurTdPcBXLOGNSzHlnXBH+5jCtZd2otjDgqiXR6mPzhKEQ8odr2P8EKyzKe3kbLIDktKtUWS0HPFFOS4vPkkBsPGLMEnmTGagv+m2fYqYrjwQzWB9ifB1kYTVoYDX9GyMI5KAcPcNRQeRzZFqA21zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dgKs5Ryb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q565InWc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LIotBY024994;
	Mon, 22 Sep 2025 05:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yTtGOuIApl2v73g5O7pOQJOaX14O7vJE4H0t6I51vk8=; b=
	dgKs5RybWJ0npUupzSug35Pf3fwRoY4OeP/0T/PQrJcoVK6ymRkrpzXm6ptBL4ah
	NKWlALQYl70HlyKqqPMVa2+P7WDBmWPv/Az3Yo8prlgIrJTWP8WWDgA84bjSL8/k
	SV6yMLyz9cK5AAIb9S46Ael7gA0kXe6mgO+pUV7w1zH3Ev1XpEJ41U6PgDd8WZyA
	3aghE+4U6h0bU3XGT4eaB9Mn6xUmlwKpQW0XVkBcXZijsBhrd1cWnkUTzEDySUtK
	JH21UbQFMuOWUz3EooB8iOTlU/DBFA7HhlynLvM5AA7JR3MKSHwz/kwQyOeGbvSv
	VbYFv9A7lNtvHDkbPoj4bQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad1m5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 05:28:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M3FEov031392;
	Mon, 22 Sep 2025 05:28:59 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a94wgrjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 05:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKrhLALLPr+75cOrTUwsubFZsdN8i+haQCQ83k+7etd9BBz3rTTZlYucx1nK+uOyIRFrihYej5hQDyMCzPnkdvx2M/bjPycGSOUIc1gyrFWzmURvBf5wtA+kNFQAnrfvVf/iT9PVZHBTPmpVLnYCaWah9hau5z6gyA7WVF/HQmb0TUVAAVLs8+j26BbFIG9qp1CTJag1qc0/649F+H5ugEUWA9QvFVF1d2Xoy05UKnI7wZhumeIcI7r1a2dc7pSI4/a58aU1JaLY3cA0zrEwjWJzh8b3QiayjsRW2sgCJSdeQK16+yjBnU/axm5BRNvJC4fWYIWuns5uzlVcW7Kc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTtGOuIApl2v73g5O7pOQJOaX14O7vJE4H0t6I51vk8=;
 b=IYI/876obhCoBcgTBAc5fcuyzo5JH5rzLAxErFZxzLpXPQ8FdER1j/eDtnrra8D59itVQ+joZCNQMOWrBFVvCHZ1pj0lU/WsrrnJ0m4UX+ukI3ey4U3omVdqWlxFXVGPfE/d27agcZRZrd/SG9cIBXgwiF6xxFKJ75LKMGodJ6QmToujndklmnppBMn0TMDqAbsRKZVTbJQ6F1avMeB+80mitgu+IQ06UUl5YnaqWWYm2exJgBGKdwn8NTInCZKcx4CiJIrokYGaBtwXT5texsrl3lv4EMfdFuy1jHvlkGn8CHmNgrvV9vim0oWdwrxS3vbb4uOXIpZbBJ/oCp0yFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTtGOuIApl2v73g5O7pOQJOaX14O7vJE4H0t6I51vk8=;
 b=Q565InWcFKg74EoXWfOwWYsZDKnPK0h8BnAyG+Kxbxp6jx+u+xA8AzXVQMdlvh+vZGCZPJXrZ44EUUAqMNZk0oLRLdsHCKYLzKkNZwfZLamVdaPq5Od9nW9VQWaNvy461PNz15WIbF1qJSisWhSihKprQb+yf1pb2nelb3U1/pw=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by BN0PR10MB5062.namprd10.prod.outlook.com (2603:10b6:408:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 05:28:55 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 05:28:55 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
Thread-Topic: [patch 02/12] rseq: Add fields and constants for time slice
 extension
Thread-Index: AQHcIRRRjeNzxyNt9EyaVRMsclvzdrSewVyA
Date: Mon, 22 Sep 2025 05:28:55 +0000
Message-ID: <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
In-Reply-To: <20250908225752.679815003@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|BN0PR10MB5062:EE_
x-ms-office365-filtering-correlation-id: 1d86dbe6-15e3-456f-db28-08ddf998ec62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bk02SnhrRGkwcnpKVmUvODVDcnNsaXBadEtTdmd3OGhiRFI4U2Y5QitQbmhC?=
 =?utf-8?B?TElIbjUxOHA4VXFTaDJsekk3a25CcnFYdWExOTRwYTk5UFJVZlptZjJqWHM2?=
 =?utf-8?B?bHhIRVV1Z2VoVzJrRmxSdEozT1NHb29aZ1dBbDVZUjNTK3A3SlpmM2ZqT2hE?=
 =?utf-8?B?QkYvc3p6M2M2OEdQcGROQURsQytBSHhscEF3Mlg5OEhjeTdlV3J4VmxlcFVG?=
 =?utf-8?B?NnVYNnZwME5jUWlFdnc0Q25LN2ovaFdPUWxYdkh2MHRBWFdScSttc3FkclFo?=
 =?utf-8?B?TFJpUGZkSDVmYkszanNqOVozSDZsNjA0WlNIekpXbGxWZm1lZFl6MzFwSzBn?=
 =?utf-8?B?bWI5NmNqQXcyaTE4WVQ1VUFDNUZYNGt5QStKZ0tOb1dZZFJZSlVpN2p5bHpR?=
 =?utf-8?B?eFlqVkljb0ZoZ3dyeDNKMW9tN25PMitFQndNbXBrdGxrVEgvd3g5dVJkWC9L?=
 =?utf-8?B?WVpGZXNRZ2pvYi9xYjg3a29zNThFQVAyTkZuaHFGSmJVUlZVZ3FxTm05d0dD?=
 =?utf-8?B?QWlteEJLQ0pwMjh0dnNWcExkRUpDT29YWkhVY0xKcHRqanU4bUxMQytIS0xt?=
 =?utf-8?B?b3JLRkhMS0NJUW0wZ2thbnloSldaNWhuQXM1YklTVDJTelZrMXhhVEsxRWNt?=
 =?utf-8?B?OVBxZzVSZEdjSG4wVEJwK20wdjJGMFV5RURNZkxlZ1FxbUttckRyb09hSGdJ?=
 =?utf-8?B?UU5TelhPd090d0VxSTlMUzA2d3ZlTEtPYlpBRldvOEJPM0FkTWZubm9nU21S?=
 =?utf-8?B?SzYzOTdvVWlXc1F2Vlk0aDNST3BZWHJTNVU4VTQ3S0tUQnpCNHpOYVJUc1d1?=
 =?utf-8?B?WnRCQVJxL1dmeDBxTjJSTlVtb0s2RlVWYWpjblVqUStkcFdXMmtNbVIxV25F?=
 =?utf-8?B?Q2EybDhHN055YUNscC9MUWIzMEx5T2RhSlNCK2htSWljQWFlRk1yQ1pjd080?=
 =?utf-8?B?cnh4T1ZCR25HSXlBWmJvN3ZieTZIZkJHQThHd1c4c2xRMXhWVm5OVUh6aEZk?=
 =?utf-8?B?aDBGOS9DNUNieHBaSWwzYmE1aDhCZjl5aWdHNXAvL3UyV1VPeVUrRjI3ZzRN?=
 =?utf-8?B?TGl0Z3l0YWdQeThqR09SVEpxS0hKUWFIL2pzRE5hTWlMTnVLa2s2Q2hPT1dS?=
 =?utf-8?B?ODhZcFRNYUxTRVY2VXorY3R2QjQ2R2dSbllQWGtaeXRGdVcyVXBQUC9NWU9v?=
 =?utf-8?B?QVZDckF4K0hQSHVyNWFDMWhzd1ZFV0wwLzRKbXpGU3NVdTFzUlhpYUJydFlV?=
 =?utf-8?B?ME9CeU0vaUNpaVlINUFsZ3JNN3ZlWHdiZ20yYzJvcVd5cjVtd2xiZkxPbWIx?=
 =?utf-8?B?WGdEOVhTZzdRSmpiaExSQ002enpSR3RPbzA5ZGF5RzlJODVoZGR0aEU1ZkZv?=
 =?utf-8?B?WjRLd2JOSEtyKzU4ai9uZm1DaXdIaTdhcVBBVkxaMUhwMmdjell4NnZ0V1pL?=
 =?utf-8?B?bjlLRHpocS9yQmM0ME9Tc2xDamh6TmdEdW5HOVFEcitFUkRlVG5wRHFXa2R1?=
 =?utf-8?B?OU1Qck5KdHdLbWR3cUlxYy9UWU1rR1FMUGo0VlhLK053SjZUeWVTVnBpOEUx?=
 =?utf-8?B?Um9vdER2bkZpMDFxUjVXQUFOSkVzTkxackQrSmh0aXI0b041c1hOTXU3OUtL?=
 =?utf-8?B?cUszRGpuU2NLbjdRejRnNXByWEkrWUd6NWFnakFLWEtPSDV3enFpNTlQNDRY?=
 =?utf-8?B?Wkpabm5yK0U0Q1l0elZMYml1ZjQyRmJwZXlLL2tZc3l2RFh6MVNkZXIvWSs4?=
 =?utf-8?B?ZmhZKzlncFNiRWw5bjFiZS9WVVU0Y2oyTUpZSlBvS0s2ckUvR1RJSi9vNFo5?=
 =?utf-8?B?RTl3YVdSdkxoRkx2ZGJSRGg2d0tHVWNvWlNLeWE1cmt2TkhuRlpMT0JackRw?=
 =?utf-8?B?aUc5ZmRCNWpvK0ttUEo2NGNRZXJ6WUZuZWFqL0pjSjFYV0hwMjBoYzV2QUlt?=
 =?utf-8?B?SU1oNnhsSVZPVzNnMkVtbDRLUVNMNDhMV3FqaDJMNktxMm1mK3g4ZWR1aDBL?=
 =?utf-8?Q?EQtJ0UEJqmurRCQEdktlgMJa7UC1c4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHAyZXFsTFRhUnlPV2tLdU1uNEpTcXZTZHdtbmh6b3FMVlgzZjhuUWxhaHBp?=
 =?utf-8?B?WXJscSt2dkNkdmRiNXFCTlNFWWV6cEFvQk5ma012aytORWE5Nnh5Nmc4Q3Bx?=
 =?utf-8?B?NlNDbWZJU2lycHM4eDI2Nk1aUDlnbnoraEErOVNtSktDcVZ5OWVyOEhHUzRw?=
 =?utf-8?B?c1B5eldMKzVveE8xaVhFckdyVGUybzF2bmtSVkg5TStGNjFWQ2ZBdkI1a25Q?=
 =?utf-8?B?ZkhKVW5pRmpoY3duTHl0SUIzS09tRkJ0NHBUd1E3ZUF5NjBOdWovcXNhUm5y?=
 =?utf-8?B?UVVUdnZwTHg2Nk5YUW8veFc3OHVlV1ExOGdhMkxwc0YzdG8yM1gzenFKZXBq?=
 =?utf-8?B?K20yRDhBeGh5b2lWaWVwQXNTZ0VwRC9HZlJYbTEzaG1mM29va1pPbUtMRDBk?=
 =?utf-8?B?cXNydWh6YUIzbGROdDRLUThJZEo3Y0w5dytMM2RReGEwd1dMWWtXVVhJVnpZ?=
 =?utf-8?B?cUY3QnZqMVU2WHhuVGdBR3NEYWJOaXUxSFNuZjFCNEo0VUhDODZOWGFTSHgx?=
 =?utf-8?B?eDNGNzYweW1SV1gybFFJRmJRMC9WVjVHYVVML3JUUUVQYlVtcXFZYjFvellN?=
 =?utf-8?B?OVVGN1gvMWNYTmYyYU1aOEZaODVWOVVxMlFERkY1T2ZEY3dkQW9ja3hvV0dr?=
 =?utf-8?B?TmJ3dnl4N3BlOTNBY3p2YmxUUVNGTVBXV2dyNy9HOUtuNm1vL2E2VjF0ZThT?=
 =?utf-8?B?NTVWM1hRQ1d4S2N3TnVDUHp2SkhiZTlXc2ExWkFHbTVHMmFYQWlVR1Y4RGxO?=
 =?utf-8?B?aFZkdXlhUkhBeCtWcDUxMzRCVzI4YVR0Q2ZNTytaTDFiWVJrem11YWh0cVk2?=
 =?utf-8?B?Q3R5UXlIYmR3RkJpZm1jekozMEN4ekl3WHY3eE1wWGY0N2JudnFiSWEra3RO?=
 =?utf-8?B?OURyZWk0ckJsTjFXdjFjREFYUkNVaWQrOTZ3YkVqUEFiMmFVRDZxZFZhTUlB?=
 =?utf-8?B?enFFdGo0U2ROODRtTFloK2VYUnN5aEVScVFUM2pDVmJMRmZVaVRKM3oyVCtn?=
 =?utf-8?B?cFFmZW1Ld2RpTE40ZDVjQlFRcS94Mkh5SEYvUW00VzVmZ294WllkbzlPWDRQ?=
 =?utf-8?B?MExwWFhZS1cwMWdvaFh0MUtzMGhISkJCS1FrYnBObkhJeXFVS2E5cDlObVlw?=
 =?utf-8?B?dDEzdGQ1SmJMMDFFQUtib2tvZ2V3RFJIQm5nOUJzc29jdlY5eDFYMTFCWk5D?=
 =?utf-8?B?amxibUZxaVNoa2lWOGJDd3B2YXRqMGFHeGlNMGRRbGx4QkZCWllXSEo4eWhM?=
 =?utf-8?B?cGgxN3dHWWVXbEIvZHlSZkFYZnJOek1xb1I2UVlqTWwwb1A4cklDNGM1UGM0?=
 =?utf-8?B?WUhGYmFEendBKzZvcmFtZGZIVndkemljcytDSWNKZUR2eVFRUmRaTGNqazg5?=
 =?utf-8?B?WDF5bHJucGxsK0NyNHVYMEo0dTBvYkZHTXdkSHoyVkxFbGF2WGExVzdibDAy?=
 =?utf-8?B?YVh3QjJzK1k3MWd4TkMxc0xzdlk3V2FrN3c1a25YZUlTRTdXajZJbmlqc1N3?=
 =?utf-8?B?L2IrSkpZOFhzQk4vN0tPY2poV2l0ZWR1YVdrZldOVGFDYUJEQm9JdU9SV3hs?=
 =?utf-8?B?U3VZRGpWM3dkRkFWZm92alFCVEJpSW9CeC9EOGR6OU5JeEh3SzFjbEVDeTA3?=
 =?utf-8?B?dlJYL2d4cFpLREJITXNkU3A1eWVUYTFqQTh1dU1QVkwxZmlJRGx5b3BCcEY3?=
 =?utf-8?B?UG5jbklieU45SmJoNG1Ea2svaUgrUEVpdEZQZWpYWXFBclJFVEFGaGJJbHl6?=
 =?utf-8?B?YUFpa0ZuSzNQR2g0UzZMRm1BaVdNQXNHUENQVm8wT2tVZnZrWE51aGVXMFZJ?=
 =?utf-8?B?d0RCSy9jNXg0eEtSaDlpenh6Mm95S2VUNjVsSmZaMFZaTk42MVBJeHltVzVF?=
 =?utf-8?B?U0ROcldpLytleG5pV09mQWdJRVI3ODFESmZ6aVdsVXFsdkJuV2RoU0VvclJY?=
 =?utf-8?B?OE1aekdONjB6RzZ0LzVwM2dvRCtCQ3psTkMxbjdDOTBCaGRDNmY2YVM4cUZq?=
 =?utf-8?B?MXN0QVp3Q0loVVU2U3ZBVmkvbU9UcUdlaUVHU1VJOEVrdy9KaC80N24vYnRi?=
 =?utf-8?B?REZQV1IxbnZMdnp6RmRvS01QdDhLNkZNN3hBc3lBWTJEdW1IZG15dFFLTzFD?=
 =?utf-8?B?UUpwUFhIODJPblYxVzNlZllLbDA5WEhVZEI2MkZ2M010SEQxc2h0cEMvcTQx?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA7BD3277F9654429AA83751474B45F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6IJ8a2SunrrNScgHpNJK0A2RFBJd/XWJsi+UREaXA7uP8X0T8lDuD5+yGL/2GqvlufzmiO6ZQ2bHUVMVcsfIK7OjDKY4Se2JW1+7Di04uREy6wzO3SRI07WMB2Z+8clSqqzdAbSiUtsGNqsVhqgrhjU+uqlGib7WLN5vmw2IpcY2FhpEt3RJEV8ZmgzGVOeVtWqbFtEah25io/qrmUN1A/lSxbxGQ5Nc2LxuhaafJcN9tcV6kT4tGW0cKGdG5kQdRZJ3PG/KB1EzICrb9oL7fC7BbKkgu88NICK8/JcMyvapIsqivrvY0W4UVDBTcvh/IFLUuCT3LISQ/AwnA2bwuiiMgVN7QNOBAdCeM7G2zJ1Wozuk1ROsGNVgp900xKZh9kFprAMIajD0elkoJlkZAyaODmUYP+EyrjoRIjeAuvhLb7oJ4bWMmRQT9zAYgDDidYfaZwIeaNAOV5NQLNjMuhid7sg4V/iCVb4fQxINV0E0lc35JHCVTbgjwLsx1R22lvCe3GE9AiwcFQUfgwPbPJBbFAEmhNI5NhzNspkXHme/8MwB3BRiTWvaTC5G7dgb46uKm/bwVdzg44pL2MsyeGPGm8tp50eyHVPsBKXKIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d86dbe6-15e3-456f-db28-08ddf998ec62
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 05:28:55.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: istOTrLLCl0pVOHNtqqXQ4Tb/HZf248ujesSXdIkBs8QPNMfFhGinFYoY7xmmqXm6k0NB6w5e5YgLRHd0DyNizkLbzAA9xj8cWqZgyvn8i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509220052
X-Proofpoint-ORIG-GUID: PFUeqa25nVQzKKF_nv0Cbf4l33Sw_Smr
X-Proofpoint-GUID: PFUeqa25nVQzKKF_nv0Cbf4l33Sw_Smr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX9D6q09v20J1M
 qB5WsXjkF4swI14RNTToHD9/g035RTRceNbbY4OOK0LIqirSk8gyn92bJoTEwkDJVKRRR7QoMrW
 QG7hLkDBRJYK6+Z4aZh1BMB46n4euS87Dd4bmhQm0t0tWCxIL6mgKOQXjEvWXx+pLfQ8hrn8mlY
 izqNprFTMsLXLhBXSGT97Mn1nCz4PRCwYRZeaiqQpHQEw55MTVKuRjYzMJX/xt3MPmMDzqkgu9O
 Azs3E0i9PoFcssnbP+YL5FsL6z8GISscWugMMWPNEhjbxnTpGHrCHqvJvY/JK/gkWjNDsoWERHJ
 D9CMKFrsgWRgZZ6B1GRtbVWtVgflUhs+xatkfYkoMP8I9j7XzT38WvY9j0fVXEAKCvchFfiyiRc
 FWy+s/aTa36yKNOYqxgN0Z3GdfbOrw==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d0de9c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=I6razFHGP3SLQFL826cA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12084

DQoNCj4gT24gU2VwIDgsIDIwMjUsIGF0IDM6NTnigK9QTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCi4uDQo+ICtlbnVtIHJzZXFfc2xpY2VfbWFza3Mg
ew0KPiArIFJTRVFfU0xJQ0VfRVhUX1JFUVVFU1QgPSAoMVUgPDwgUlNFUV9TTElDRV9FWFRfUkVR
VUVTVF9CSVQpLA0KPiArIFJTRVFfU0xJQ0VfRVhUX0dSQU5URUQgPSAoMVUgPDwgUlNFUV9TTElD
RV9FWFRfR1JBTlRFRF9CSVQpLA0KPiB9Ow0KPiANCj4gLyoNCj4gQEAgLTE0Miw2ICsxNjQsMTIg
QEAgc3RydWN0IHJzZXEgew0KPiBfX3UzMiBtbV9jaWQ7DQo+IA0KPiAvKg0KPiArICogVGltZSBz
bGljZSBleHRlbnNpb24gY29udHJvbCB3b3JkLiBDUFUgbG9jYWwgYXRvbWljIHVwZGF0ZXMgZnJv
bQ0KPiArICoga2VybmVsIGFuZCB1c2VyIHNwYWNlLg0KPiArICovDQo+ICsgX191MzIgc2xpY2Vf
Y3RybDsNCg0KV2UgaW50ZW5kIHRvIGJhY2twb3J0IHRoZSBzbGljZSBleHRlbnNpb24gZmVhdHVy
ZSB0byBvbGRlciBrZXJuZWwgdmVyc2lvbnMuICANCg0KV2l0aCB1c2Ugb2YgYSBuZXcgc3RydWN0
dXJlIG1lbWJlciBmb3Igc2xpY2UgY29udHJvbCwgY291bGQgdGhlcmUgYmUgZGlzY3JlcGFuY3kg
DQp3aXRoIHJzZXEgc3RydWN0dXJlIHNpemUob2xkZXIgdmVyc2lvbikgcmVnaXN0ZXJlZCBieSBs
aWJjPyAgSW4gdGhhdCBjYXNlIHRoZSBhcHBsaWNhdGlvbiANCm1heSAgbm90IGJlIGFibGUgdG8g
dXNlIHNsaWNlIGV4dGVuc2lvbiBmZWF0dXJlIHVubGVzcyBMaWJj4oCZcyB1c2Ugb2YgcnNlcSBp
cyBkaXNhYmxlZC4NCg0KQXBwbGljYXRpb24gd291bGQgaGF2ZSB0byB2ZXJpZnkgc3RydWN0dXJl
IHNpemUsIHNvIHNob3VsZCBpdCBiZSBtZW50aW9uZWQgIGluIHRoZSANCmRvY3VtZW50YXRpb24u
IEFsc28sIHBlcmhhcHMgbWFrZSB0aGUgcHJjdGwoKSBlbmFibGUgY2FsbCByZXR1cm4gZXJyb3Is
IGlmIHN0cnVjdHVyZSBzaXplIA0KZG9lcyBub3QgbWF0Y2g/DQoNCldpdGggcmVnYXJkcyB0byBh
cHBsaWNhdGlvbiBkZXRlcm1pbmluZyB0aGUgYWRkcmVzcyBhbmQgc2l6ZSBvZiByc2VxIHN0cnVj
dHVyZSANCnJlZ2lzdGVyZWQgYnkgbGliYywgd2hhdCBhcmUgeW91IHRob3VnaHRzIG9uIGdldHRp
bmcgdGhhdCB0aHJ1IHRoZSByc2VxKDIpIA0Kc3lzdGVtIGNhbGwgb3IgYSBwcmN0bCgpIGNhbGwg
aW5zdGVhZCBvZiBkZWFsaW5nIHdpdGggdGhlIF9fd2VlayBzeW1ib2xzIGFzIHdhcyBkaXNjdXNz
ZWQgaGVyZS4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0Y5REJBQkFELUFCRjAtNDlB
QS05QTM4LUJENEQyQkU3OEI5NEBvcmFjbGUuY29tLw0KDQpUaGFua3MsDQotUHJha2FzaA0KDQo+
ICsNCj4gKyAvKg0KPiAqIEZsZXhpYmxlIGFycmF5IG1lbWJlciBhdCBlbmQgb2Ygc3RydWN0dXJl
LCBhZnRlciBsYXN0IGZlYXR1cmUgZmllbGQuDQo+ICovDQo+IGNoYXIgZW5kW107DQoNCg==

