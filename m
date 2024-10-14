Return-Path: <linux-arch+bounces-8076-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D940699C863
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBF51C24324
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D491A76DD;
	Mon, 14 Oct 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XnO0Rl7J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bVtAAl/X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086412C475;
	Mon, 14 Oct 2024 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904265; cv=fail; b=SgzamqPOFyH7Ur0h2w6HhnlWoqbLS1D5hwlLf495Nb/eLCUedd44Aojy8GpUAWt2sci9voa60BzBofAhcr63jrEwn88rqA55NInV6u1ku7GAfKSZBpYGBo8OA0ZoSwTYNcH2CiIbdHjZQ+bKEIV7WTbk5TVIwNtv6CXPk/n5moE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904265; c=relaxed/simple;
	bh=5159XSheY0SumwKY3mIdWrXVxE9KMGryg25VG48ZcCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MdgRIARV5BG+0NVMVjzgYZapiLlM3fDVOFTX2V7j2mwYWUqIEJIP4B2wmWdluRUvhIW7QdhWY4ZRGGncJfMeJHAkBs7MsZb20pe8yoplR5DbkGiV6lORwVGezVhI53QXry0QuBrciYSYgwfSDeNbYbRM4Usiq+NqtSLRniSItS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XnO0Rl7J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bVtAAl/X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9tcgr013128;
	Mon, 14 Oct 2024 11:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5159XSheY0SumwKY3mIdWrXVxE9KMGryg25VG48ZcCE=; b=
	XnO0Rl7JwoxlNiKRzJ0Mi3nUM9GhAPW0nzs7bFQi/wTTwxiTYE4st0pobagyb1oc
	1gKvnd5owxmUonadWCKdXeHuVBx4/lb0TufqtY8nMCyjiH8tRFpV9O495WINHLDY
	X1E6CSQeX5/bWkUuH+jXa7tdvGgQe9J/N209JfTX1O3/r1g6HrXAMzdSm8k1USTx
	N47myuBiFpbIky3JnqOMdQCWgsC0SUGWTZ5+JQFWrDNrzSct1OzBibGfROkW1nDK
	DzfXEdt/jGfR4XxjNIRpZiuSJa3XfuXTQ7g6xMugh0zHO/nHi7LRVnHal/gP0huj
	5ojsA218mzabelzPk71klA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcdqkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:10:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E95Kxc014204;
	Mon, 14 Oct 2024 11:10:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj5x9ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+KqtvqM3c7QnV7zsPwg2OIBZM7FLI3/w2xn6xHWTzUrax4C5jOFuVsKWtjilavbTZitlACkJJ/9mGbPOQOobsZODmSL8PStxZ4hjYnInvSUnXm9/yNeO8uGppVI/GdSUWcqQA/nnqmVfzq+BEUQ0l9hljb0jAw20sg/bHT6rsJ3/3AYqU7uKwf/RD4VLEs6KSggolqyumhCzeWiMIhDWXC887dBzNUkHbKuOL0zNSd8vJReNN/oVubsZtTUxO2lQyHXA6Wk320haczosbDRk/W69CmmCq/Rb2jziBzUFQV1duc8pwrbM45Q9rSCpoEqUfdQEIENfOsUDuoLTQdbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5159XSheY0SumwKY3mIdWrXVxE9KMGryg25VG48ZcCE=;
 b=aCVR9iXMXxy89QXtcq8nOlCKXoZBPM30JHShFcTlp9zEdC/IS892lxk0BPkhtZLneI3SRBwxIwhe8SLd9runWE+rqDV5W75Uja7pLB5+4v60KAIHgdtgn3fG/U1vQRtdoGPXfnC1X6ird2JH8Fb0VdjSUck4DVxU5VrXsLv6/d5Q8EVb0+u63tPOh55mD9MkHJSar6q24ZtqWvPAHh8w7WOElI+UHRH4+jhlUl8QSXBlGfPe5vEK77JIc/fHFSNoteOeiTqec31cXbBhoOcQa3WlaUrNShdpkyG8wo9jTOopdNU0netFnw8IdSDQQnctqsW2S9rk6DCYgZh5z2qtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5159XSheY0SumwKY3mIdWrXVxE9KMGryg25VG48ZcCE=;
 b=bVtAAl/X7IPLeZTwJDZuN6GvbBZCjb1p91kYLSB34Jrg/BczomfLYJq3rYM6Gk8SDvSnnkuLsKFoM4N54J/YZsFiQ8XJQKGKol7UhfQvcDN9KNPjERvLHXTA+sIwaMM92FtIj2PTc1pw5riIoHP898hbD8NFXcEgI+ODixU4Ljs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 11:10:26 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 11:10:26 +0000
Date: Mon, 14 Oct 2024 12:10:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [RFC PATCH 1/4] mm: pagewalk: add the ability to install PTEs
Message-ID: <78fb890a-a901-4616-86e8-cf56eea89ab2@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3XwT3aeXRDrW2e_46aAzyQ8iVGr6G7PrMz0KATaJNtew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3XwT3aeXRDrW2e_46aAzyQ8iVGr6G7PrMz0KATaJNtew@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: ad131743-1e32-4bda-6f77-08dcec40ce84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Skg0SkU1S09sTW02T1V4M2g2aXZHdE9GK3lIVmdwTlI3RHQvY0lIakdXS3Vj?=
 =?utf-8?B?SmwxVnQzMFRCRVpkdzlYWFZoSHlZL3AxZ0dFMzBXaWRWa3ZJS3g1OUtJaFhR?=
 =?utf-8?B?cGQvdUpzbU1FSFJBSkgrQXljK3JaVHRyUUZ6NkR0RWpXd1B0bjE3STRIMEdo?=
 =?utf-8?B?OHJYMHJySGJnRzhFdGcweWM4aDB6eUhHQ2JhU283UXpoVmp0ZHBmbnBnTWlj?=
 =?utf-8?B?dzlWTTJSREpjdXpnQ0wrWk1VZnRkQW1kd2h1RlBWTnc5SHpVVVpqNWtqTjNm?=
 =?utf-8?B?L0lhM3ZxUjdCSFZ3NG1nalFtNGJlcHNwTWZLdXVxU0dpeDEzak84RXViaWtS?=
 =?utf-8?B?aGl4QlJVVkQrZU9mKzJMN1lRMTMyQlpwdnAwa2RTMVgvekVFUnp3UTcrbTV0?=
 =?utf-8?B?NnBRbE9tWEJ4UWRBazc0RjJsSjRVaVN4QkxFNEozVmNBajUyYUUraXI1amJq?=
 =?utf-8?B?OW85OTErVWEvK0lYT09vQnR3V3p5L291NC9JRnd1T0ZOTGI0WUFud1dSMEdE?=
 =?utf-8?B?eGkzZWF3d3NaSCs5Mk0xOTNiaEgwMTN5VDdaSWtjQUNnb0NXaGJmZXcxUE05?=
 =?utf-8?B?ZmJCb05hRStYSGJ2OG5wTlVoVzNJVlhzd0FTTy9XbXpLdUljL04vOFNwTjJZ?=
 =?utf-8?B?NWxOVHkwaTlrekl0ZVFUU25sUUw1R1daQ3B6Z0JQU0tmYS9mZkhuRmdocWhM?=
 =?utf-8?B?NUd0VlBwencvMDNSNUM4bEFTd1JWNW41ek1MZXJOUVlkT1d3V2JUVFFDUitI?=
 =?utf-8?B?NjJXWUNCNDVNclZnU2pvTDNzbDUxNEVmQjhCbFhSdUo2bmhsM081L0YyVEps?=
 =?utf-8?B?akhBclQvU1YxVHIrL2hoVWR4dGx4bnFpaW5USEl5ZDZudnFxdks3ZjZZaHBJ?=
 =?utf-8?B?QWFGRGxXZGdxOWJEQXdMSUU1Qk16dTJ2M2JXRnV1eE5HQndsWUdVb3hZWUox?=
 =?utf-8?B?SEp3aWRDNmljS1dqMGxweDhLSTIvK0h4WlJzWmFDc01qd1ZFZEJkNlVGTU9a?=
 =?utf-8?B?Rjh2bFdaR2lHRkNHclhPc0g5NkhXOTZnVUV0dHNNQmxCM2dXTmpYVHV5YWRw?=
 =?utf-8?B?ZGljdXh5S3BEUkFsYnRMcnhhN2xZZDBNbnJzSVVXNXJPM1JuUzBlWGhnd29y?=
 =?utf-8?B?dDFOLy9oRzFTTGpyT2VkeXpSUGtNaTVwb3F6L1hRN1A1UWtCSHNSb1UxWFNU?=
 =?utf-8?B?S1dTb1FneU8xblNacXgrSnprRUhqakszV1VGZ1k3dkl3MVRLU2FSZ0VFMyth?=
 =?utf-8?B?Y1ZWNlcvdndid0dKclllOXErMlowR2krS2daTVA1cTZwQnhOMGZTc3BSZndL?=
 =?utf-8?B?aVVDL1Z6elFMMXliMU1PUUFDUzQyc3dYMEg3dGVWWVovNWRXTEVIdmY0ekxB?=
 =?utf-8?B?WHdqbWc5TmdQQ3FLZ2szaG5adVlsUUJuenc0R0JzdHFETmNGeGtocE1WTHhN?=
 =?utf-8?B?TG9zUkMwbVUrTmdFVm5qS3RIRmZ1RHR1VDF2N0ZXU290UWVSNWlyeGVSMnVT?=
 =?utf-8?B?REJSNG01czV4cCtQdURETWliU0NMWW1LaDlmNDZscFhzN3BOOXFabEJHL2hP?=
 =?utf-8?B?ck41Ty9zQlBJZzVUc3hua3UrS3J5Vm1abGN3YXpGSjhnN2FZMUVkdTFFVG1n?=
 =?utf-8?B?M3gzQ3pXODNqVlREQ1hiREpiczhxQm5TS0FzZUc2K01WeHo4ZndoL3NmUC9T?=
 =?utf-8?B?dEh2UjI0RzBYTThZV00rMjJOTGVPM2FqYUlqV2ZoWDNEVkcvUW51MFVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0dBYjJtSS91V3hXL0d2WkpBSS9TWFZzVGRDMkRieXkyQ1lCREpoc3NSVVdy?=
 =?utf-8?B?K3NsSDFuSTQ3Z01nTHNHZUFKRUx0RWgySXBUOTVqZTFOV0tEekpmVVZCclNv?=
 =?utf-8?B?OUhKWW1ydXViaDVWOEFwK2xqVDI2Rk41MmZzcnVWYmZqdDdSY0M3WEtGc0xP?=
 =?utf-8?B?VHFpcmN4TENtd21Lbm8rdzFsU1V4eUU3QTlIeksvaXQvQk1WRllyT3ROeEdG?=
 =?utf-8?B?SDNWRG1rQTFYV055bk12ekFRekNUYjA0K0p0TFl0SHczV0xvWllXL2lEU2la?=
 =?utf-8?B?TE5LcElLQzZQcTJSUHMyQ0h0emtIMVo1MXJCOUFESDhkdllab3N6QVc0cXlV?=
 =?utf-8?B?VC9rd25XNFlBdjRlUzZZN2tUNlpWZnN3aTlmdmZVMUYwdk1idG56UzNvRERY?=
 =?utf-8?B?TUN0WFNzSmxNa1lWWVQ2MjlPYnNiaGJCWEVlNFoxTEZDR0hiVWR5cUhMNitv?=
 =?utf-8?B?eXRLZ2g5czFpZzhqRlQ2MVdZc21ENmhIbGFxa0thWURlbnhSeWJjb1ZuZ1Np?=
 =?utf-8?B?czlHQ2tWS2ZIa0VGbkl1TS9YSGlnQmF6bjdYM3EyMkx2ZHZuZWdBMnJXNlNu?=
 =?utf-8?B?cVFGek5DWXpSWW9qeHhBdWExR21wajd2VUJad0lkVW8rTmdDa0RmN0NUOEVm?=
 =?utf-8?B?RU03WUZUaFI5eFVndkEybzlPTUxBRHJyQk8zWjhwTm0vMk1PM2VMVXIrWEc3?=
 =?utf-8?B?czFjSUhxcVBEaUMweUU5Yi9KV0RHa3daWDR5TnZ4OEU2ZjNkNVJaTDFVWjFv?=
 =?utf-8?B?anNWMFprNEZJa1YwbWZjU0l3am9LTmNvcjZob3ptNzRkdmppb2gyUUhIRmw1?=
 =?utf-8?B?N2FJS0lhQUxqelhMcnNCRS94b1h0ckNsWWdJQ1p0UEZLSU4yMHBXS0NVQ1oy?=
 =?utf-8?B?Yzd6WUdFRDlKd2wwalBLYWFkcklaWWlYbXZ4bmQ0Z3k2WWpBdHNvSzRkUEQy?=
 =?utf-8?B?WWZSUmhHcGRBQzltcDZJZEtnR3htVXZPcS9PRWVHSkQvV0FhYkJYWTcwSWhx?=
 =?utf-8?B?dE5xa0lZeVVaaGNYSzFMakphT3RpU3RHS0RYdjlXMWxycm94eVdSS05zR2RG?=
 =?utf-8?B?VThjL1Nkb3pFU1BCYWl6dGk4M0NhbVFxQlBvd1JseldvaXQ3dEtsNVRmNlNN?=
 =?utf-8?B?Y0VOT0ZsTUU5dTBiT2tSVjg3ZUYrUzZDQW1La0tTc0lwb3FWV1ZwS1hkOGQ5?=
 =?utf-8?B?Q3FiUjRxcis5K1VXbjNNUk5Kb0YxN2Z5WXhTTEdPLzhwMktuQmR3V3ZxeVFm?=
 =?utf-8?B?Yzg4VWxiODRTUW1TZUlkK1h3cVpEU1VIUVorbzlvTy9PZzFJZmhsNisxNjZt?=
 =?utf-8?B?WnpDekpYcG9OVjNkV2RjYWFPakRzZExvYzNibmsvOGhBbkVTZjNMVTNUcklQ?=
 =?utf-8?B?VnVINCtReG16VG5lb25mSFQ3a3IyRXZPTmpnOHpoN1l2VlpnZld5UHlOQW94?=
 =?utf-8?B?KzEwdHBVMmhMT3lWeEtqUEJRZW8zN1BpbEJiNmVOcTFjOGlTeFA2bFBGK2FX?=
 =?utf-8?B?ak5jaVJ2UklKRDAyTXNLcFpmRVp5endLcUFwUE42a2ovaEU2OGRqbVNtc0d4?=
 =?utf-8?B?TmNOT0IxZkRFVUdJMHFETkpZRkJmOGk5OUF3Ry9weDVmeXEyamFXMW1jdktj?=
 =?utf-8?B?eUlJMU1jdVQvUmN3MXZDd1gxejFLMksxWDBGVTg1ZU8zankvQ0YwV1h1MmJ5?=
 =?utf-8?B?bHV6dUpnOGIyNGtkdlRmRVpFSU9MNWFZdGROV3ZjVXZzUnMrTnJ1cHdORHhm?=
 =?utf-8?B?VTVvNlZHSXgwNVlKcm5GTVFuU21NRVZwRGhFOUdYeDJFK09YUGlZNXdGUmpU?=
 =?utf-8?B?ZWEzKzhiNnFLcWZWMUYyMkpYdlFma1UwTVBERVJobDlFOFo4d0l4MlFSbW5F?=
 =?utf-8?B?UXpJUTcwN2tZTXNuOGJwNHhHRS9XeVpnamFEMXhDcXZhNlo3dU1ua2twLytR?=
 =?utf-8?B?OEkrMFJXWlpVY3NHQzE5TFpiZytIVjU4T2s4dkhsRDV6M3RXeHl4cURSWU16?=
 =?utf-8?B?YTJwcklWU3JJK3VkV3U2Sk41MEF0enVrQ1NtUjJ4RTNJNk5OYmlKTXlFRkRY?=
 =?utf-8?B?QkhYRGtwWHlmSER0T2NsQTFZUWMyMzdsZFlTalVyZzM2TThpOEZkVWNobXZk?=
 =?utf-8?B?SmFnZld1Y292MUh1Y1pNS244ek91TnVGZ1lXTkowbUp2QkhjOUdpV0FGWHo3?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gOR8Y/9Zp/pHrmwEHW4QFab1LYDkC3GBUnUfvdcdPv010s/zx0Ju63KZPPGzaVONKrf896vBgidFiEYNCDH4jC3oUKatoM1cJtKeiR7vRm4NLuR8fgIhPibM8Zg2MOJKcmoWuLc0uLpxlHd7EqFuhwjYr1j0nKC1Lu5Bahel8+D1JZFTd1DT5BWUJZGXqrz9hWUX6XnavCZPuN1oq8mulLJ/KuLhtoIp5fZpsgliVeQ5WpMsjqooHP65eOBIyYYDkkf081mvmMc1rr3htLmkfQ/tV0Bzo9wek+o7y0AnhDZVUcY3S6Gd4p6OQDCX6uHVv5J1wf5U3JIdulxvIbwDMdhQlYwYszOh3Vj+d9wKDKzzxxsulql3yzr6/OvhO0Uz+SwOaa7HExKlqUzRRis4MvSndMXUrkKwYB74A9GuNrcfLo/VOqvnrfeMKAYuTgAUc2jFhGqwLcQZJEr9S/H74PjMgJfByuXkYasLtwns+ir5rViJX5HsCQw6B8WwOmZNWGg8DlqI7gA9y0hGgKqScmDwOuTp8HquF5kCeWRcOh+Z0uy3hGNkAVlA0DX3AygYHfHZt1O0MrAF8nX9Kxdah5KFPGGSLw0cdWU3sQnvjLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad131743-1e32-4bda-6f77-08dcec40ce84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 11:10:26.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCW8J42YHvy1zlxmMa+KYmQN7FB/X9b8QHrIV0k356gn90KjggoZCnx2GqeDMVCb3BaCeSTL9gDzgCZL3oBJATyu4obLU2oPbUbbWinr/ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=935 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140078
X-Proofpoint-GUID: ZBa3fqGcCkMbUfCjavlkrKkAmwW5v2gP
X-Proofpoint-ORIG-GUID: ZBa3fqGcCkMbUfCjavlkrKkAmwW5v2gP

On Fri, Oct 11, 2024 at 08:11:28PM +0200, Jann Horn wrote:
> On Fri, Sep 27, 2024 at 2:51 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Rather than add yet another implementation, we extend the generic pagewalk
> > logic to enable the installation of page table entries by adding a new
> > install_pte() callback in mm_walk_ops. If this is specified, then upon
> > encountering a missing page table entry, we allocate and install a new one
> > and continue the traversal.
> [...]
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!

