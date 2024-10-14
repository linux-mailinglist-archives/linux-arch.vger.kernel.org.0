Return-Path: <linux-arch+bounces-8070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB699C712
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F8028612B
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F61581F4;
	Mon, 14 Oct 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SQBLBTRf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uodOnEML"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA244156676;
	Mon, 14 Oct 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901451; cv=fail; b=bNq8gT05hwWzSSqgaxowYBjPAeItbFo1cwvjBKlNMrtVSvnxr4uDJI0PrkoDoNUvvb2IP66+BvaUK6KGslKpXyCxAbHi09s5PSu+EYgVaVyhfXYYmcb2PMRjsgkyI/79EbYc3gFqzRuxY6B9B1bOFNxPiROdlrTqI4OV9JnT4T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901451; c=relaxed/simple;
	bh=bCkCP/h7mbi3nKAjvf3wlgXtqHBy/ixNaxwb1ypJ5tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRRITJANtTkNBgtARx1UAK/Q26BNsYWGQ6aymHX9C7n4HEcZMcNsSCo5qA0o5Ndfk7547QFtuwpy9D1tV1PsCned1MTWd73Ml5/vkQ9vj5+TK18kt6Vzn3j8nTjGv+1bG9SmyjzvEm0zSSxDvV3LyEYmqJY/wn4DmUJlpwbsogE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SQBLBTRf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uodOnEML; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9tw42032249;
	Mon, 14 Oct 2024 10:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6jkhPEFUpWo3F9gWwRdNtKb26Fb9mj9GLiXn3W5Ek18=; b=
	SQBLBTRfaj9UqWcjfmGMfMYmV74RDtdLSSO3Ie6fZlnZpvOyCYJbgTrahsca2pxX
	R1C5zGIg1IvSBmIAOApYKbnxqhBEeb9/LSFSCzVkB1VRgE1fSOG0cVzbYWhlZ3Ip
	rbkSnrD5/Ove9bCw16F6nS7UFopBVqNKdvuXXhHP0/PRYKAzDeuicJpYhPFPIrTP
	a18AQwcUmsVeSjBQkeZOnJoxI7/oc43ZxwVoNcDwkjoddpZvRRo7jOlXAA76q6Xz
	8XUR1D31D8sroX8ktN7j/BWSzX9U6XIqs3zTjX39XUm1C3x073e/OcbmmDUZxDi4
	v/HrGb7cRGfXfDiJ9bNeSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1adwu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 10:23:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EADFDq026558;
	Mon, 14 Oct 2024 10:23:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcdnkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 10:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llBxRmVKqynfMi0fhb3WIse74ywdD67MNgsYHyaVKo4HeX3+wcJdZzHW0Z2P6FZNkRphXk0C3KLQ/lb0RvzlYMZWR9f+FE14IHYWlADjRF/+8d1abVhwnubRhI4Zf8TwJH/DJFve2TJOBhYyqVZLK26pHh3ARg+PhMugYb5z+4tPd+9Q5yxeHDMvNtirrAkRHKoKYIAEWnlt9dmB36XoUffXY/E78uAgUsKRtalBKxshtR3iCqwUlIx3QBFObGiyjZIincfafUJiebJCPXlZ3Im2M4Lx8d3X9xarqAgZGb87UD4fyfTa00suqBYDAa9h5lmzTIu2kbc4MvPAZ0I4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jkhPEFUpWo3F9gWwRdNtKb26Fb9mj9GLiXn3W5Ek18=;
 b=UdEl6KLdm152Ajq3zmSgVicsQsEhisSBfVoGyqLkEWP6gvOwPSEdYpYghK0pYkGu1nlcwov4au3soIsvj8dQrxMWtUZjn6gon1PSlhceqKxIRZhaVu6aAZN1G+JI1kfhHybF3urvhcB4hnKHKKa0bd2rUvv1mIk6OUVujvuo5sWpQWTjvQX6QX5lHXAuwgXN1AL4RlkPGWVhDt+kJwMRGQSGJm+8va3JO6ZShTPm2kuG6nX43A/j5N8jmCVoPujToh7aNBMk6ARalrWS581dU7v1AoNs4qyDceUuTjseq2BvixI8QVcDGm7FuaXPYiYDzyl6O4pU/KLbkntPUCmfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jkhPEFUpWo3F9gWwRdNtKb26Fb9mj9GLiXn3W5Ek18=;
 b=uodOnEMLFNkdcKLSaPViwcMip206w38b5ExfsR7c2vC4nHTT7klszP++8CAqDJnyI+KsvAmCfZ6m2eOSR2HtsON6umXpySt8iZUTa7hBt6thFu3svOhibHMQTtu7v3OvfFIzKoxRttGCPrVnTqzsBrNM3lHjnOK1vubEjSH2CFs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 10:23:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 10:23:19 +0000
Date: Mon, 14 Oct 2024 11:23:16 +0100
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
Subject: Re: [RFC PATCH 2/4] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <34e41a11-10ef-4eb9-8c07-299d193dd8a7@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <03570f8a0ad2a9c0a92cc0c594e375c4185eccdc.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0rLrTrNiT93T2fG86w_n+ARRqNxOS6OXGS-Q_V54GjoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0rLrTrNiT93T2fG86w_n+ARRqNxOS6OXGS-Q_V54GjoQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0158.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 812f1849-cc2f-4a8e-eb01-08dcec3a398d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2xsSmRqQWVFRk5jODVTc0JuY3NNWVh4RUZlS1Q4ZUtXbitVcWpvTG55TU8x?=
 =?utf-8?B?VU5neHhDT0Z2N3F3NU5mZ2RhMUlRQW9QWFJPTW5Bc3BmTVRhaXNiL1ZjVlpZ?=
 =?utf-8?B?VGZIR0oyVURUWXQyejhYYnBBVlNZSEpGN2dsUllsQXhCMG5Dc3c5SFhpNUpj?=
 =?utf-8?B?S3Q1WmxGSjVVa2ZjRUZGQU9ucUZxYzcyc3dSTWRuNnpzUXpwUzhPZmV5UTZY?=
 =?utf-8?B?dFVHZjVrVmpMZ0tlOTYvQzVZVjJsdjVCajJoZHdlQS9tY2pPYVRmekFrZVVo?=
 =?utf-8?B?OFJFM3FMMjFLTndpem8wOGtQWGVRL0Yzd1JYRlFuUVRTRldVZ2ZpUFFjTTFk?=
 =?utf-8?B?NnUvM2c5SFRERkpuWHMyL05pRXZwTXg1S052cHRJM3NaY2c5K0FXdmNHMURl?=
 =?utf-8?B?YzJZSE1uaWl6NDZ1VzhqNFRBWWc4MkxqbTFYRGdIeXViZVZQYWdyZmlrN3FN?=
 =?utf-8?B?bWRacDFaN1hGdFZZaHhDVzYxY3lVdUlOVVpZUmQ5WE8yZzd6Vllub3lnOXJ6?=
 =?utf-8?B?RTZ5SERuMFE4KzRQcjlmb1pkaFlTNld0OE5jdjF2Z1RYZXZyUWhGaGdNYTYy?=
 =?utf-8?B?L1JyalpNSU4xbWt6Yk5SZmJ3RVR0MytvWXJtUmtabWM2b1JWRGk3YXRuUGtD?=
 =?utf-8?B?dDVSdjY2VVlKdGlDMURzT2VWYUdJRlNSUXE5OTk3K1MxZFpzaVVvZ3pXdHdF?=
 =?utf-8?B?eElzUXgvck0rNzFTTFZYMVVnZUZSaHdraVlKSHpzb0dSZ2lacUhTSGpWTUJE?=
 =?utf-8?B?OS82Wmx3RVRTQVZkQ1hMa3lzZzcxUmp0K2lkUkN5aVdKNUY2MTRSTmJIVlJj?=
 =?utf-8?B?bDNsblBkWXVzakUxcVRjY1UzTmdyd0tLbkVRSTRvMlBqdGtWK0NEZ3VJT1N4?=
 =?utf-8?B?UVF6ZmNxYXppWXZEbkdOYUYwUTRIVThkNmdlSGRGdzBjRDdFVWFQZUIydnZm?=
 =?utf-8?B?OGptVVN4RkJyWnJzVFplSE1iT1FsbTlhNytBQWlEQ0gza2Rib1ZZeENBaVRF?=
 =?utf-8?B?d2FyQXRIRTUzdEMySE9JMHJCQ1FWVGlsRnZoaUptU3J4VHBCTDM4VjlnWExE?=
 =?utf-8?B?dHlUSGNSV3QxWGVtOC9VSDZBZElKblVmbHVWMlVDOTQzOGw2ejlxckhYN0dq?=
 =?utf-8?B?NWk2eU9KQ0duKzJJVTErNGpxVWl2UnhXb1ppVnBjU0VqaU9MS1hCYlJuQTZ6?=
 =?utf-8?B?RHRIZGZVL3dvNTA1MUlpb09LZkx2YWNOcmh5UWRIcW5Mb1JJZWFzeWlPd1FB?=
 =?utf-8?B?WXQ1bnkvQS9MeWgxbFZFdFFFR0wvVTBnVG1PSURERmlJMzUwbzkwQ1pnU3BI?=
 =?utf-8?B?VUlYNW1OZnZmLzVKUkVzTkZ0Z3ZMWnFPTkFJNkNMWEE2NklPWDgxRW03Tlk4?=
 =?utf-8?B?aHhTVWwzU1FtVHdzLzVORTVkN2ZaMkVXc1FQSWRoWlFNZkZPVmpzdDJYZGtn?=
 =?utf-8?B?eHpybDdKNnFienZJbFFwYVpWa1l6MER1UUFQKzN5N0hPaGpURFJyeW9BOWYr?=
 =?utf-8?B?WG9UeUtRQ2FucHhoUzZDbm1ncWppdkM5bElwN2pBM3BBN1ZHOVp0ZXlGRG1C?=
 =?utf-8?B?UCtmTmtqL0xJcXhSb3hQMjZxQUJ3b3I3VFRkWGlnT0NCbzdkYXJTaFdGeHRN?=
 =?utf-8?B?M0c3eVh5YTNwdGR6R050TEJ6bm1nOFVBRnhRbE54bERvcEtWNGdSTWFSZkxI?=
 =?utf-8?B?UHY4Mnp5Zmw5R0xoSnBZRWRleVQwRk8yV0RKc3RWTENZSTFCNlVwQXd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?byt6aE04NVZla3psS2VDaFIrV2RvVm5FUGQ5RTh0WHp2bVo0b0MwUmx3TFhW?=
 =?utf-8?B?bXZNMWQyNkRoSjFOQWcwVkxPa2w2ZUtETWx2SWhCYVgvL0x3S3pCcmFjWjRp?=
 =?utf-8?B?dk9LUENlWkZqSWhyUjhRYmNpa1Z4aDlwNXVvTmpKRCtYa3RDS3FQMy85SEFj?=
 =?utf-8?B?OXdnTFJhYk1EQkRXTVBSaGhtTUxINzJ4RGp2RjI1MzVYQk1NY2lQc3pxTyti?=
 =?utf-8?B?TUJHVWhhVUg3SWJia1lvSjlTZ3ZCQUw3RzdjS1BqM0paVEEyaEJHY0NmRnAy?=
 =?utf-8?B?ZkRXc201NXJYMnF4LzRXWWc4QzVocGkrWFFFMG9qbXgvZFRYRmdFdXhIcG5T?=
 =?utf-8?B?czNoOUs3c3QzMGY1UjJZRTRheTlVMDliK1hhVHpMWkM3MzV5d0lrTWlDS2dS?=
 =?utf-8?B?UUpvZ2J6MlE3ZlZoK1pvZzZVRWJVeFcvS2NxRVV3ZDNhY2xLdFdqRzJDV1Q3?=
 =?utf-8?B?U2puWTRVY0xoM3hxbW4xOFpId0xJN3FTS3FpRmdodmIrZko1cnFPOW1NOUMy?=
 =?utf-8?B?eExrMkZFS0UvUnYzS2l6RGRxL1NiLy91SUpiZ1ExM014bUZUbXpTOEtTNWFF?=
 =?utf-8?B?T3Q2RmVrYkIySE5hS2dUWEdRcTFSUktKdklocm44eGYwbVJ5bksyamp3ZjA2?=
 =?utf-8?B?Nms2Q0NsY0orMDRRK2NscXpHRXh5a3gxMjBvZEs3alIxZEJ0cllyYmpJNjBT?=
 =?utf-8?B?OWxzamRKMngyR1I4TlQzSXFKRkJtYkpJSG82RDc1N2RybkdpQ0RvTVJJUUll?=
 =?utf-8?B?U2M2bGU0WVVHVUJlckRaU3U5SDg2ais2MDNiYjNnL0VSVXQwaVYyMTNXOWhC?=
 =?utf-8?B?c3JNOEJybldIV3JONll1VC8vOHc4Z3ZaRkY1anpTTUs4SGc3WTBubkJlWHVJ?=
 =?utf-8?B?OUp0UGFUY2NHa0dTd3QyemNLU3NFWGllRGhDemtHamY5RzYyZ1ppMkE5VFFZ?=
 =?utf-8?B?V3Avc2d6THBoTEpaQXFrQkt3WUk4bGFtUzJTKzdXRkNaRkxZVkNGSFZPZ0FV?=
 =?utf-8?B?cVBKRnZBWEFPUEl3UHFuSjdrclU0QzdrUHhOcU4vaDFaQ1k0RkY5Y1U3akdK?=
 =?utf-8?B?VWMxN2R5UWUrQ1RBZVhPQW03MnY1MFlNT3IvTStwWlZHTFNMeGcvSTVteFRJ?=
 =?utf-8?B?SGN0bVJvZEdlenVtbkJPTWtLWmVodWlsUUd5SmJiQ3RzVUFDVkp6aXVJSUtV?=
 =?utf-8?B?a2dhTG94WXFaNjJ6U1h1WE5Fd0tQRlhjUDd5aVBEc2xUYnRhdUFLM21WNkdW?=
 =?utf-8?B?T3BqN0ZKb25yRU9VMkFWR2QvRU9VMHhNUU0rVVBPcU5IZ2dFempMRGd2ZStr?=
 =?utf-8?B?MGVVVVVCd3gxa0IweFVUOWFoWkJ3V2dnMUdIK3BGSmpIaUc1enNSb3N2KzdU?=
 =?utf-8?B?TitQZ1puZnVGRDlQWGtSbHZvRzhZYUNrdFFOeWU1d2hGN05xU2ZPNVN6KzRo?=
 =?utf-8?B?dHNCTFB1Z05QMjBxVW9RcmJKcmtZQW9FbWJtYnBxanV6dTlFa000STB1dUpi?=
 =?utf-8?B?SUV1b016SDNuSWNRY0FYeUNXMVlHZ2UzZmFScHMxOG1BRk9JbnlNanZYc1VI?=
 =?utf-8?B?YmJLZHhabU5TVEh0a21zS0REQVozYTQreDgxZ2l6NUhLOWdEUUJYcmNYRmtk?=
 =?utf-8?B?WXRaUEwxRzFsWm1HUEp2OER6a3FJcnVPVEFKOXBXd2ZXbHg4RXVtWFpDNzR4?=
 =?utf-8?B?dDdjaXhKVmhGV0FEVjJsSVZCSEsrbmtJK3Znb3JJWGtOMzBualFvR05uZ1Bo?=
 =?utf-8?B?Qk5ncktsRkk1ZlcvQk5HTGtZTzNJa1RNVDkvcXNocHdLY3VaUWRLQVIwZUJP?=
 =?utf-8?B?WWFONnNGN3lRdG9UUzFReCtNVTR2MUdDVUpZVm9sV3dPeHY1ZTVYYXVVcnor?=
 =?utf-8?B?V1JSTTM0WHJLTXdHVE5jMHJ1cFMxbFlLWW9OZWVOc0R3K0RvcER2QWMrOEdx?=
 =?utf-8?B?cnNIY1JkM3dkV2lmd2J4QW83VUFTbndMK29NcEZFc1JBVTdsK25Ca3dQZ0Nq?=
 =?utf-8?B?eFkzaC80YnV6bXhZclNVRGorOFFmdEJlREpaRG52QWI3SnFCejU5WGlmczd3?=
 =?utf-8?B?RlRCOG9DNEpsV2l5Z2xvSGNydTFzVEJzY1FPaUZDY21ZdklZTVIrdGFWYjZM?=
 =?utf-8?B?NHozZk9Cd05yY1pnTFZDcXpXZGhHSFR2dzk2QnBQYTdDZkVCNmY3MVFZQUN6?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q9DOnKcrlA0jRS/qNSk/2BUPny4Fc12ExOlUW2kKsyCF62vdkeEKoC8GfkQNthHZM4+MkSsnAhZeQ7DrbgH+y8UGQticDrUjReHmkKPhSp67EmJLsDqjNSCEbvofBFuFbqj6i3gDGUGYv/NG1rB4RFMRxlLvJjEAhS6EIN6sL5XowrdlDftXps7iU+TgsYRFTCB9xBx2J2BkvbNhlwYpTLlVYqSkHoy3A1km0JMjMVjQDDFQsKNWIRxAOBsGo8f4MZVKkRiNAFukoxMkZqpGRnnSRqNrNF+eDlGBJhJu0SYx3gW0I+d+3Uaex6qQkxoG283WU4rKNiawn1jQZw8tdAUCBOc4BNxZNAIov4a7lCvwHyRQmacbx2kTDpm3oLi9UWcbWvrRxJNXe571giS6H8RLe796GRomKEKato5nhNWrm2BPIqnX/u+2nAcliaSCrpj+kiMPtF/K82fdZdJPPlCOh3dxj5DEtTywhu5VUVErcOFYiYUjQWQVetObquxkKmlX38NCaMKm67sVKxVqqb1gUz6m2qnTzuv2QEnlVRgCa/boVzY2Zf7lFR2ukr0vyUI5mAuzvbxVY2B47GXwfc1k174y8rNy6lHzbzFJ5kk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812f1849-cc2f-4a8e-eb01-08dcec3a398d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 10:23:19.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz/Vcg1hqCByczBeEc+SeMPkwTGdJsKgSZXhwUcxb0lqMrfWTdp3jfQQtDAzwrlzi8SO4mXe0rF4sdx5j7JU0YvCnWjhsY4MT5ZzUrJaJwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140075
X-Proofpoint-GUID: ABPEb02ui2fR-WRjM6Xr2r_9faOtN-UP
X-Proofpoint-ORIG-GUID: ABPEb02ui2fR-WRjM6Xr2r_9faOtN-UP

On Fri, Oct 11, 2024 at 08:11:32PM +0200, Jann Horn wrote:
> On Fri, Sep 27, 2024 at 2:51 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Add a new PTE marker that results in any access causing the accessing
> > process to segfault.
> [...]
> >  static inline int is_poisoned_swp_entry(swp_entry_t entry)
> > +{
> > +       /*
> > +        * We treat guard pages as poisoned too as these have the same semantics
> > +        * as poisoned ranges, only with different fault handling.
> > +        */
> > +       return is_pte_marker_entry(entry) &&
> > +               (pte_marker_get(entry) &
> > +                (PTE_MARKER_POISONED | PTE_MARKER_GUARD));
> > +}
>
> This means MADV_FREE will also clear guard PTEs, right?

Yes, this is expected, it acts like unmap in effect (with a delayed
effect), so we give it the same semantics. The same thing happens with
hardware poisoning.

You can see in the tests what expectations we have with different
operations, we assert there this specific behaviour:

	/* Lazyfree range. */
	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);

	/* This should simply clear the poison markers. */
	for (i = 0; i < 10; i++) {
		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
	}

The tests somewhat self-document expected behaviour.

>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 5c6486e33e63..6c413c3d72fd 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1457,7 +1457,7 @@ static inline bool should_zap_folio(struct zap_details *details,
> >         return !folio_test_anon(folio);
> >  }
> >
> > -static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
> > +static inline bool zap_drop_markers(struct zap_details *details)
> >  {
> >         if (!details)
> >                 return false;
> > @@ -1478,7 +1478,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> >         if (vma_is_anonymous(vma))
> >                 return;
> >
> > -       if (zap_drop_file_uffd_wp(details))
> > +       if (zap_drop_markers(details))
> >                 return;
> >
> >         for (;;) {
> > @@ -1673,7 +1673,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                          * drop the marker if explicitly requested.
> >                          */
> >                         if (!vma_is_anonymous(vma) &&
> > -                           !zap_drop_file_uffd_wp(details))
> > +                           !zap_drop_markers(details))
> > +                               continue;
> > +               } else if (is_guard_swp_entry(entry)) {
> > +                       /*
> > +                        * Ordinary zapping should not remove guard PTE
> > +                        * markers. Only do so if we should remove PTE markers
> > +                        * in general.
> > +                        */
> > +                       if (!zap_drop_markers(details))
> >                                 continue;
>
> Just a comment: It's nice that the feature is restricted to anonymous
> VMAs, otherwise we'd have to figure out here what to do about
> unmap_mapping_folio() (which sets ZAP_FLAG_DROP_MARKER together with
> details.single_folio)...

Yes this is not the only issue with file-backed mappings. Readahead being
another, and plenty more.

We will probably look at how we might do this once this patch set lands,
and tackle all of these fun things then...

>
>
> >                 } else if (is_hwpoison_entry(entry) ||
> >                            is_poisoned_swp_entry(entry)) {
> > @@ -4005,6 +4013,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> >         if (marker & PTE_MARKER_POISONED)
> >                 return VM_FAULT_HWPOISON;
> >
> > +       /* Hitting a guard page is always a fatal condition. */
> > +       if (marker & PTE_MARKER_GUARD)
> > +               return VM_FAULT_SIGSEGV;
> > +
> >         if (pte_marker_entry_uffd_wp(entry))
> >                 return pte_marker_handle_uffd_wp(vmf);
> >
> > --
> > 2.46.2
> >

