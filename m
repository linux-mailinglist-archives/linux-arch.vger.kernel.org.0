Return-Path: <linux-arch+bounces-15452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA43CC1347
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94C7B30019E1
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E31337103;
	Tue, 16 Dec 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n4YiR3Op";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gyWk1zz7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333D309DCC;
	Tue, 16 Dec 2025 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868175; cv=fail; b=LVt68GCKbAUrd0jp0KY3M99dpaXBAovp0hw58j26oucQ4g2zizjcPIQz8E8WGkP0CyaS0l/m19lnCkreuHjexBOOUIkU3u73dmT71cNbvjlwRDSg5CckTAcAKbFRnsVKm0XATbpRIjPEYMFnX7r9y+zEH2EDHx2U0UlRP9LbOIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868175; c=relaxed/simple;
	bh=XsKFSXR2Ir1yTfDXbYmqEObHlwQtJ4HVqgduf8VjJgo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=mmUY9uar5QPZCE/FUPH/quyZgUIcHjlDCgmNV6vSjqZJ+86a1H48F7pg3RqxfEvVVNe30hvevqQC0riZRf4bqLrDDGhHkP4Y4SYbCTEnLsBU67LfKK3cAoC/7h2Kt79uGZ+bpP68QgL5B0aMKqMgMzp1pPL2cUd3evVxfs1tJpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n4YiR3Op; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gyWk1zz7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG1hSVj3538879;
	Tue, 16 Dec 2025 06:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1cSvXf3A0Iq0XyB8qYte982csi9MjR/UAxj+1wFmbOQ=; b=
	n4YiR3OpL6oMrWAyIPHsnwf8PGWm2b1qbk672+j2hMP+MXxE6D/KBsge/Y3TxcoP
	Hf6MxJz8ii9m1EDJIabeVM/cymz+99WuLSokQSohmrX9Nv6tA+B12aqbMm1Sibrj
	WPDC5tKG9D3HjyBqv6nWDUIYe841PxJcr7lArempnern3yGcUz+V/AJOLFGvGHj5
	1npHd5XbWLTkzo+CLplH9FIWcxM9GGXEh/+VH2HooTzUs80A38x9oYRizJLOKhIG
	aJiUpQxb9wIH/1tHPOzqRhK5JrWNzpR9SyJxkcnMAMf1s+abTZLU1d4hLphOxSRH
	BXcL7mv0R+uBosPm2SOeBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015uekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 06:55:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG6sUfQ005907;
	Tue, 16 Dec 2025 06:55:33 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkcwaew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 06:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8guGXnXoHgfNBFMoA+WgSQbqF8lIlx9YKo1nmBDH3lE1LfxFE5vZwswNEr1K9AQgSrLHg2/Lql/tV69hsV/1+dLCIbhnjjeXj+9s2XdsQxhaonSU7KXXCf2I/6oYA/root0pVA23Mdpj2keVkiC9VBS57jakHBN+oUq3Ht+5LAVep5r4vYg6nSDHnhjpFTgaLRwRaYL7c4L60yVnma9upC0Y5pt60aZBD3P8NrrFZIWyhp0Ok/UM1Nec33f+H9so/toUDIn17nZZ64jvWPfFIS8kIXDY0CBX+wWpesbPV7Ym8KdXPHRiWs7Zg5/BLHlacYIZ/Jv/YujNdme/0wSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cSvXf3A0Iq0XyB8qYte982csi9MjR/UAxj+1wFmbOQ=;
 b=W2rsMrP0dQcmulQYBZN74K1aCET6c3wxfQ8zYfwkzsrdUBqAi/DAcJf9DJCic5oSezNc0WyBSzCV41x8r9vadT7xQxZRMD6xID6v8P9PnUnTsOzRrQaijpzLKUN6Ns0Hi4HKlfyx3DKq+0nU3Cy27Fe74SVy/Ty6GJLHl6msepIh/Buk5fXgKEKAWpsCZ37ZpDFM5xqTm5CUWgGlZ3j7ROTObHqtpuPX1JhhFoVfDdmTDwowMzNxH6AnfCdEZmt3Desmk1RpaYrqjVuUc/KAisPqibErY8bJ/piagAHQChkcudi46hgLqo8NhcZTdN/hpT/5W5GtB45wP/rNIXTtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cSvXf3A0Iq0XyB8qYte982csi9MjR/UAxj+1wFmbOQ=;
 b=gyWk1zz7pDK0khf+vbhx3U4jgmtNkxQDgEKn8LlsiuVdrWDjJcGdQuTuT15Jd31nha7aVooBnTo5Fb2QW+Y1Vbq0vOVHAwe/LmgyTLQ1nj8OobTaTvc645dhm1z1YnizGSE6BOEsUDRnBRBDfenB2n/sBTC02bKiZ+CSHFum6LE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF92DC283F3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:55:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 06:55:28 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-13-ankur.a.arora@oracle.com>
 <CAJZ5v0imk5kdqunNGvK+6_BPh2_k89RPPC8B4MDDF1GLZrUhLQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 12/12] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-reply-to: <CAJZ5v0imk5kdqunNGvK+6_BPh2_k89RPPC8B4MDDF1GLZrUhLQ@mail.gmail.com>
Date: Mon, 15 Dec 2025 22:55:27 -0800
Message-ID: <87ecoudig0.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:303:2b::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF92DC283F3:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c061b3c-9d42-4603-8c75-08de3c7018db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0dJWVdNaEZwOXc1RDFaQWNjanQ3dEhjYWJOamtCYjB5V2JIR3pkSFcveFFs?=
 =?utf-8?B?dmt5VHlJNnRxS3E4RE9WVzVIekdlS0ZMcWFJanZVQWRuUVpqWndyVHBkKzBh?=
 =?utf-8?B?RzhMZ1pVNnNIYVg3Zlp4YndZMkcvRnVnb1JSMWtaTUNmNTZvWFpDOHEvUG43?=
 =?utf-8?B?ODdXSmxMbEh4MUxsR0ZaVlNLQzFsZkpWa25aZ0IxOS8zbnM5R2lpZ3dGa1Y0?=
 =?utf-8?B?TnJ0YkMxdWlDdU8yWE9JSG4xWGo0Vll3bHUvaEVoSHZCOFp1Q3cwZ2FjUzU2?=
 =?utf-8?B?RmVOcVFkTXFjcUxFKzlMMmtGaGt3ak96eFZGNlExVTFBenYxekE0anBlUUoy?=
 =?utf-8?B?Nm4vQkZNakxob0RNSkRxUElUTlE3M3pZYkpBblowTzVxbjdaZ29URG9JeWJ6?=
 =?utf-8?B?N2ZhaG9nTElWYklzM241WHhoeEpMZWJ0a2hvZE11TXdtYVhzZ1k4K3k3MDdI?=
 =?utf-8?B?d3RBb01pbkV3SEplMVFFcmcxQllabzh2MlVDWDJ5QXdKY3pBWnpzV05CYU5E?=
 =?utf-8?B?S3MzdlJSb3dzVm1MbjdNTUhNdEs0QVM4Z252RHcwZmNpSlpTSUVYMEZXUm1G?=
 =?utf-8?B?TlR0RU94eVhwam5ObkYycUphY25pRGxTbVE0LzliS0wyUVd5REhnbnhwaTda?=
 =?utf-8?B?NnQzNXJlbUNKVUNLeWtuQ3ppS29Fc2hnMzArcnQyY1BKSFFjVHAwUm5tYWlT?=
 =?utf-8?B?MmJjMzJvZndsK2l2RHBkd0dzUDNlTm5kUjl5V2M5YjRnQXg3Y0M2SWdtSk5D?=
 =?utf-8?B?MEp5RGNaRTV1ZXhORVN6ZU1FUTl1S3UyQ0VYcytrK3dYWk1tZHhrNWZQbmRX?=
 =?utf-8?B?bnVWVEVTSHJWWUkrVnFpdXZWTE53Y21nVWNmbnNBN3VocmxPT1BGd3BoQThM?=
 =?utf-8?B?MjNTMjZReUZ0b09oa3MwYjhxUThPeGZKUEVIcU5YbDNFZVd4dGRoZXlMR25M?=
 =?utf-8?B?WmJOUHZrblJHQlZHcU1KQVVITkVsaDlGaGh0cjVQNVQwR0plK0hoMkNpQWNi?=
 =?utf-8?B?RGdnQ0o3cHdtcHM3QVZpMTlaTWxZY3BsYUNIMk9hTG5SK3RaSVErdjFHbWpn?=
 =?utf-8?B?ZE9iZUhCVFdoeU14QkdmNjRNSTd1aDRXYkY0T1hEWlV0VTVwRjNQK25rTDlE?=
 =?utf-8?B?dXRCMG42azBIcUErRHJHKy92dmNpbUVvYk95b20xSmNKR2VyUHVneFdZamdP?=
 =?utf-8?B?Z3ZnY3RzTFkxQVFoOVUvekFzcnNSY1BVYjRLajQ0Z2xLc01sL2M0YTlHcjk2?=
 =?utf-8?B?eXZYSy9zMHE2bWppTWlRSW9DV2hkdENBZ3pUemFTc1ZZZVV6cDlLMlJ2enNj?=
 =?utf-8?B?OU9FWkRmZmwrSm4vYVRtK3lGdS9MVUNERjdjVkRFYjNySHU0NThxOFpxSUZu?=
 =?utf-8?B?UHcxWTlpRjNQZE10RVFHL2dTUFJEQ1R5SC94KzJkb1ZwcjhyZEZWVUQxQU9p?=
 =?utf-8?B?NFhyUi8xcm1EOFBHend5dm1qK2dlQlNlRXRPaVlmRVlZZTlvdUl5dW9rQ2Y1?=
 =?utf-8?B?dUJJV1gxQ09QckU3SHYwZC9DTkIwMkl3c2t0c2Y4N3BZRUxuNmRrM2xnQ25W?=
 =?utf-8?B?WUw1alZaNEczejBoRWdaY011N2diVTRVZkRzUGwxdmhPbncvRUVaNnNCYTFT?=
 =?utf-8?B?aW1iSGJKRzkxc09wdzRmMWtuTkRITGdGSWJDbm81aEVhcm03cW42YjVjUW01?=
 =?utf-8?B?RjZZcCtzSmZNdDk1dHNGRkpDWTlTTXBQR1NpQ3VrVm8rQ25NN0lNZ08raWlL?=
 =?utf-8?B?OHRtOTlOMTBYenduWnpNM1RkQVlJZ3B0SDM1SkhkS0w2YmlNdGxlUVZ0REU4?=
 =?utf-8?B?emdPQ1lrS3VIWmxWaGo0ZnJXekwxczBqdTc0TnNSWXNjcG1Dc28wWGFaa1ps?=
 =?utf-8?B?U3BYZlJDREg4TFNIMGUzS0xQWE9JRXBXUmxoVnpaVlcrci9KRGo3ZTA2TnAr?=
 =?utf-8?Q?tCH5OD06z82kn1BRhe8i7FEmhpDY2wN2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2hZZDhBeFQxMEtYS3pyK1BXU3ZMZFRpeWIxQ0xaUTJaUWlHMzVqSXNVWkJi?=
 =?utf-8?B?b2tPNUp0dGtpZ1NvdFFmdTJZKzNyTjNNa2gvNUxReDNtVURwSSszUklGa2xS?=
 =?utf-8?B?UmtFT2pnUmh0b2FvWUR1WFZ5bjlHWFdLQ2pCQ0hjNW5XbzUxdXcvbyt1NGVN?=
 =?utf-8?B?UWc4ZFd5a2Uya3ZNR3Q1ZFRZZUJrM2dkTm9hQ24zU1dSUENQaWVVTkVZSDhR?=
 =?utf-8?B?VkRLSnJtb0tyd2tnUTFxbG1SWHhsRkIrTE5ldWgzSTlVd0FHWEMwUFk1SlZj?=
 =?utf-8?B?WE40YzVjQVU1UUJEc0l6QitQU3F1VmFXdVlrRlBnbEZQTEcrZ2Rjc1BQUnpr?=
 =?utf-8?B?NTUrR1o1bGxrTmhvKzVvbjdGZ1UzWHNsMTd6T3pIVXZja09QNlppN3pZdXJ6?=
 =?utf-8?B?a2plb0UrcWtqaDh3SmR5RkFnZmpGZ1dVLzNDYlozOUZuMVFhODN4TnVTK1Jx?=
 =?utf-8?B?SGVMUDAzVVJRVXdxSWZxbTlzQlBadzNJaTdYTDNSWkxRU05oczA1N1RLQlox?=
 =?utf-8?B?WFN1T2NubDEzOVc2M2gxME1Vcjd6U3ZpSXdXZ3JVQ2FwNFBGUHZMRk9kSy80?=
 =?utf-8?B?MGVjeEJPWHZMTW0rVXYvczlYQ3FvYmFnOGZDaHA3UnBPVEZkS3RBRXJjRGU3?=
 =?utf-8?B?TTJ5NzI2anRBN0tvZCtPbzh2S0ltdVRTUmM2c3dLQVZFMXBnd0pMcVgvU05G?=
 =?utf-8?B?WDRleVBnYTZScmpVRlRxNllNNzNkZEdkc3pFcEZENDFKdkQvenkwZzJTMS9M?=
 =?utf-8?B?UFVhTDNwcDZxSGNjeSs1biszcG1ZSnFVVE9rczNmSm14K00zK1RLOU84RWR5?=
 =?utf-8?B?eXRQdDc1bzRBNGhtSFlZMmg4dzJteEtTQTgwclpqSDdpWnB5NXFUbDExcUVo?=
 =?utf-8?B?YVdFRHN6TVJCTUVaMmh6Tlc2dFNUbkRpZzJHWUQ2QXlLNnBXTkhDOC9Zc1JH?=
 =?utf-8?B?UE81bHpYOEFXNWJ6Mm1qaFVlZDBjWmVXWkZaUzIwTnJRUjlOeWZpd2xtTE9V?=
 =?utf-8?B?K3d1ZllyR01wTUNxUjdIY2ZUVFJzdE9velVkOHVCcXdnemhiTzJEZFRmZFZW?=
 =?utf-8?B?S3lCWHpTRFlyQUd1VUZwSmozQ0dVQTlHVWVudW10K2loVmtUbDFPa1RZbzZn?=
 =?utf-8?B?WHV3ZERUbDhPN1NDZnlPUkhCQVhranBrU0hJUGlTT1E1SzdrZEZOdENyTDVP?=
 =?utf-8?B?RjhMVTRHdDl3bzdWbHNZM0xMQUNFNnlmNFF1alNsNVZ0U2owYnBidm5LREVr?=
 =?utf-8?B?RVNzT0pMWUw4S3c3enFnbUhZU2szcU5sU2lRWXg4Sko3aEE0TlZUNTlXdEEx?=
 =?utf-8?B?c2ErQWNRdThhUTlCSDQyQlNrVWpUWEpxTUU2RlZIU0tjMDVBdE9vWDBjUFoy?=
 =?utf-8?B?Z29sYzRkQkpvbndhZjFSZExGb3NpQmZHSlQvelBUQTg0OTNXbkQxZW00M2NS?=
 =?utf-8?B?NENSdlFGcmdsSmFKNHlIRlRqVzhEVElVQ3NRSHNEMEJlYXMrSFpJTzVONFdR?=
 =?utf-8?B?eG5xVWN2eFBMQzlLTWtQcU13UjkrdVhTYUlxNTZRd2pDbVFGZUF2eW5LUFdz?=
 =?utf-8?B?SW42Qlh0RllKT2ZtSW1OUHlQK2lDQjlLRkRBNGdWTUMrR21iR0ZDSU5iK2JR?=
 =?utf-8?B?ZHk0S0kzajhvSHVld2JmUEdEVkdTTlV6UmtBcEIvamhpNHdQNk83OE5YRU41?=
 =?utf-8?B?SEQxUjlQY3Y0dFUrVjV0NVBVL3dYKzJGR0N5ak5XRDNkTGtmallSaGQ5ZGIx?=
 =?utf-8?B?ekh5QUZod3NvU2swWVdiVUlQeTNWaDMrR2lKQi9pbUY1a1ZyS3dqcVR0dE9w?=
 =?utf-8?B?STJZOWovenpRbTRsM0ZtYTdQZzNwRXp6RTRpbmpJMDBCd2lIMExNTDlkaE5v?=
 =?utf-8?B?VVgycGM4b1dUT2NEbzlzY1lRVWdrcjY4OHFMdkJZanlNeGN6N0xlSGNKaTNH?=
 =?utf-8?B?UUtXbmpGekRWTlJIUEhLVW4zZGhjNVhrWEMybENtSmkwV2ZqR1o4Q1M3bDda?=
 =?utf-8?B?SUtleldXQjY1QUs4dDhtdVNzdHo0VlViUnp3MjlwVCtXYU9seHFWWWVTR2Jr?=
 =?utf-8?B?ZnBnamszSXNCN2YxR0YxRHc4eTV2QzBreldRSVdrNmQ0MHRPaWpSbDUzSnVn?=
 =?utf-8?B?NTI4Yyt4Qzk2SlRGd1FQWldhdldWR1pnUHBISkJSRDY5bGlRd29VUXhaeG12?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EpI4K/+0gtKosdV630i0GgCaU4XNkDclMKvxkB7uaV+ctaw5P3Au1IkueLtCVQkZqKEuxXwcOGzSj8lU4bwRJlG0HeTL3UpWwuDH+I3GYQOA3Ys6CmgRpLbQ5BhxwT9n2256BqGg5vZwxqDsvM6OKbsyrMwnLyK4ip0ixQEndtdBQo2cgZfBW6nXIWeep7+0XQmTTpwG3e23SfPhIV+515HNodsGS94dSNDS2oHxqi81tehHND/3X/FlMdR/QYC8wKyvVb+2grzZk+vATmPUm9ENrWxs1N77BoQutq3tEiC8A1TEq3IDpRNmZAXEHQaiMz3CZYX9LetxLjHEyEKvqlFems6WrF3NbigALlQymo/+MyP1TUyJ4zUJqPkpigo3+LoaqmxuVF9BtjAcHF+oU3BXq3w6/5li8MOIqVPo9YO6p9yOxPk7l3gY5rpbcwsQ4EdrE/wwce72vUyWoFQQnggCoQ5nLKR0w8WLodl1FBUxoPiFDKncDnd7q47ela/1+hYKpSpKcummHYSLBaufv13ZJkKvRMLY9MWMeROrlNPjbCvtdxL4PZGaE//X0zI9H+rUagxaZqHqfqdD3AqhpL26Us7gjUFiNo9WDI+cHcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c061b3c-9d42-4603-8c75-08de3c7018db
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:55:28.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjG8Srs6dwOfCkgrl4kOBLHdXshe0EL+PPOGerx6U2rvUnY7EYJ6lujWqyxbUeA5YdtSx64sFIFiXMfi+fG0fVCbs1u9XgFnH9vL95xGP+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF92DC283F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160055
X-Proofpoint-GUID: CgbJNDc1AXiLPQB9A9zO4awdpMKj85Wf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1NiBTYWx0ZWRfX3S1qazUUqtdk
 hmjjn++bK7XZmsjM4ZXSxInYf+cVR9SWa3MP6L6wqJguFbE2JH7O+Sa3ypYPdOG1jVDFwf0gNeG
 lC58y5v2mT1CW6aEBzrHl3aAzIjdkW61Rbah+4QEmH73vhc3G+MvXc9TrBl8+GMFbO65O6fB/V/
 ESCRZVXbPCCNZK3Y/He3e1GN77YTAJGkKrVGqvkC1q6++tWS+CEKFxHHClcVggxlC3hrDbOn3Gt
 S9peq8HnT7etJtnhf11cvMRHYnC/0cNK3PAFMUWyFDi1+0vxkOnl+LgDI+7sQLPS0tvr8BGoVPj
 BdoB6GCITD0OjLZ2Iv/8RWfVQLDs9MCIKTICTQWWrkrD4uIfab9tlFrc4B5bhStaFIBQ0g0q83Q
 59NSuvtZ49vF4G43YCETpJlUUMRnaxyhCktToR+tlMTelij9Nlg=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69410266 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=aS3RbhD_uffAsGnv6SQA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: CgbJNDc1AXiLPQB9A9zO4awdpMKj85Wf


Rafael J. Wysocki <rafael@kernel.org> writes:

> On Mon, Dec 15, 2025 at 5:55=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle=
.com> wrote:
>>
>> The inner loop in poll_idle() polls over the thread_info flags,
>> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> exits once the condition is met, or if the poll time limit has
>> been exceeded.
>>
>> To minimize the number of instructions executed in each iteration,
>> the time check is rate-limited. In addition, each loop iteration
>> executes cpu_relax() which on certain platforms provides a hint to
>> the pipeline that the loop busy-waits, allowing the processor to
>> reduce power consumption.
>>
>> Switch over to tif_need_resched_relaxed_wait() instead, since that
>> provides exactly that.
>>
>> However, given that when running in idle we want to minimize our power
>> consumption, continue to depend on CONFIG_ARCH_HAS_CPU_RELAX as that
>> serves as an indicator that the platform supports an optimized version
>> of tif_need_resched_relaxed_wait() (via
>> smp_cond_load_acquire_timeout()).
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>
>> Notes:
>>   - use tif_need_resched_relaxed_wait() instead of
>>     smp_cond_load_relaxed_timeout()
>>
>>  drivers/cpuidle/poll_state.c | 27 +++++----------------------
>>  1 file changed, 5 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index c7524e4c522a..20136b3a08c2 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
>> @@ -6,41 +6,24 @@
>>  #include <linux/cpuidle.h>
>>  #include <linux/export.h>
>>  #include <linux/irqflags.h>
>> -#include <linux/sched.h>
>> -#include <linux/sched/clock.h>
>>  #include <linux/sched/idle.h>
>>  #include <linux/sprintf.h>
>>  #include <linux/types.h>
>>
>> -#define POLL_IDLE_RELAX_COUNT  200
>> -
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>                                struct cpuidle_driver *drv, int index)
>>  {
>> -       u64 time_start;
>> -
>> -       time_start =3D local_clock_noinstr();
>> -
>>         dev->poll_time_limit =3D false;
>>
>>         raw_local_irq_enable();
>>         if (!current_set_polling_and_test()) {
>> -               unsigned int loop_count =3D 0;
>> -               u64 limit;
>> +               s64 limit;
>> +               bool nr_set;
>
> It doesn't look like the nr_set variable is really needed.
>
>>
>> -               limit =3D cpuidle_poll_time(drv, dev);
>> +               limit =3D (s64)cpuidle_poll_time(drv, dev);
>
> Is the explicit cast needed to suppress a warning?  If not, I'd drop it.

Ack.

>>
>> -               while (!need_resched()) {
>> -                       cpu_relax();
>> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> -                               continue;
>> -
>> -                       loop_count =3D 0;
>> -                       if (local_clock_noinstr() - time_start > limit) =
{
>> -                               dev->poll_time_limit =3D true;
>> -                               break;
>> -                       }
>> -               }
>> +               nr_set =3D tif_need_resched_relaxed_wait(limit);
>> +               dev->poll_time_limit =3D !nr_set;
>
> This can be
>
> dev->poll_time_limit =3D !tif_need_resched_relaxed_wait(limit);

Yeah that looks pretty clear.


Thanks!
--
ankur

