Return-Path: <linux-arch+bounces-15323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6DFCB2D1F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66CF2300BD85
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D0309EFA;
	Wed, 10 Dec 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V5tTn9tW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hznlQtwz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BF30FC00;
	Wed, 10 Dec 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366106; cv=fail; b=c9gt6sLkgdj4XiwJkZavB/boLAqqMlgxV0qDGRUer3JtLwkwchHINKROnHqeX7/fBWrgA/osttSM3OaVhe+9i6flQw0V0A2l3ePK9i/fHKe6yoRVN6AEHRmPEpweK7GxtY37kpbF/puRafhTqYR2azir1So8xMQD/ExAtCpmROo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366106; c=relaxed/simple;
	bh=XbQw1RqifkRqLKqzWX9XAm84zWeKCo5W8yup2ARwrjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gg6WCEreNds140ZEAliBLO66DWiaLUCcCy8E3jwl/iDeH80gL3Nu6vaLmInSG+dWLX8eCzfX02RVwwwpEj/6MSxbLTRd3mwUWdKwYhqUq3fuJYFR2j4nSN1NArgPqALUTmc4jSvqIzcAQoSkLcl4mtwcIT4QEH9/57fG9lvFaUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V5tTn9tW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hznlQtwz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAAZekm2897442;
	Wed, 10 Dec 2025 11:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4dL/vVW9+EnSnYZOpD
	Ak0jeuSaxFiu5filwO4kPa5GM=; b=V5tTn9tW8Q3rLNPCFeQ74TGoFPLuOZBaia
	CunrAvuV5fq2c53QW2owjt/QMJiI/rIM7F/fh5tZj9FE6cPOMk4R0X4KI4POSh1X
	9Vc9Kzx9KoaU/9N3MSlYrQFToXlAnx+KwvtyFLt447g9aLQHxSvOZP3bITHyxy/9
	oI035zOhvuamBZa+phmI8RmOAixfdoEa3XrPRtoWZrEFfp2TpV5wdh5PQDr9063Q
	zmjIG8i63aaLf87lp7ys/eSxtsNphyLK6+rnDzWppSPjVmZF0bzFgZmsPkQ40ltM
	XvTJxbvr0JQGnLTklNJRcxmc4OWcBij5GbmyymiMeqD0qzuRFZMQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay78b81wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:22:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAA9t62038344;
	Wed, 10 Dec 2025 11:22:44 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxac944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdIG0Eh71w3WM/WQpmsX2xiy4SFR7CYUdq7MCPzex6yU2bxANHah/x44La29eteJvcgI2vmB8zwSPik06bLNCwRdMbuoWZoWF1PuE/MWduxtIJHpgZigv/VUcBWLmNOrrT3YOqtKFm/MV5CAxaAt/ot1eIyfWiIV0IOIRfA/ecSc0q8eu2vBntiDU9bjIkUc5BgmGBxJBcFJbU2lXTddQd23CzsoWzzriddamVjGMpwolbOKfXIfnJfLlN+pQU42ptGB0hSke0Eck4WZ4DWfpXUc67ik7HDVFpI/zS5UjB6k09MXEPRgo/wfKZBsPKTiTfDzf2ybx1ri5FdkCXNkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dL/vVW9+EnSnYZOpDAk0jeuSaxFiu5filwO4kPa5GM=;
 b=t3mRaJcsh+Umi9lK9Es7pO6fzDv8Pz8DWQdaQkaD7O6H/bCMYTJ7eiR6o3vfgzu6rydD+Cu3meX/ZBZjwzwOt9A0lxCvylnxdSyzWhnTtvwSQS0065/XOrCD87pL+5HygJMyl0RhyP9aFXoH7HHkvxRnRrRCMF9RC0uxRECW/hkprQUxZgmhwneeWMoXh/HXne2ZOVngBB4nldUDm9rUNs/pN+yYs+uziXj3vcvN3ywgx2q283Qv4HnW51CipHM4EdQ5SG4OyV05w8/DHFZqzo75ZMh4DnqsOp7rN5vwSEhQrZ4KVBxQwaoPBTs79cJbC4lAyFzC4LJaDmEHwLU/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dL/vVW9+EnSnYZOpDAk0jeuSaxFiu5filwO4kPa5GM=;
 b=hznlQtwz6FzRlO6pLqkmh3IH9YKozmLjkBYeIc0DDSZOfQTui81D+qWoXrPZ5zKwEraD9DbsZ2zt37QymQ6pOxEL08HNcY2kYaMAFRuLrK370hHA6KjPj2SFjhAaE/00z6b54SsYyXSTAflJpWdSZP6MkVHFVTt9pTWzL7rozo8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 11:22:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 11:22:41 +0000
Date: Wed, 10 Dec 2025 11:22:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v1 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
Message-ID: <834ec5ca-d43c-441d-a10b-ea268333e433@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-3-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-3-david@kernel.org>
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 891da33f-5923-4f5e-91d3-08de37de6ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YVt3SzsnPuGJ71QTzLr/1tVxsy4gukQO0HJY5lltu4hxmFX6+MQvhhvJsKED?=
 =?us-ascii?Q?gA22IpCRMDqcS8eofedQqvC7B4WjDOWI7y6dnyQnxubJQhFHP/HU8UOkycZZ?=
 =?us-ascii?Q?Aom6yhfrT+eGt1EsVGVVroTa3yl29HWnYDPeHtPp9V7k3LRgmhI5a5iIfZOE?=
 =?us-ascii?Q?JGetkfDNHKKrdjnuZSAUlaAkI4YnvTfx2S9q/woUyCBqOrPcWOjCWqe4T1Hr?=
 =?us-ascii?Q?4CxcuG18vI4QV4i2fKpO6XkASxfqFZu5Shkf81Icj6wgHh8OxhGHlIhbugY2?=
 =?us-ascii?Q?BbiIkto9VI0onI3Fyk4LoQq52rVQK5E0xeHjmdxP87LjBLgP456p8XKKjhXx?=
 =?us-ascii?Q?rco882x9o/Leey/Edb5no6tPnNfltE2gynzyVKdkEVwRpmzLGZOLhx3pFRff?=
 =?us-ascii?Q?pl2jFN8yPSarDwoRU82H+pMFn7rXIRDgiw8wPAQglKJ9pdBJqx5s/xtKxfH1?=
 =?us-ascii?Q?9BVOY/IgJ1lpYkaepfH21pfDPOi3mDQmhskv3F9D2vdhYHUcRhagOXlKnJro?=
 =?us-ascii?Q?51WLscUDkZU2dgsEYLV4NCPkeEhT6gLAQojRj4bpcNl8RIxp5y7qaLENl9/a?=
 =?us-ascii?Q?F5K2uZKiNFVD3pC5EPLOP8h7HF/sNBeNsV67ZUyAMBRzDPq+/aQh5FtMXDHv?=
 =?us-ascii?Q?8O3sewet6f8HlK4CMjL2AOT4ZHeApNdRrvDuR8ATtIM4wmJWoDSYOtbMsW7g?=
 =?us-ascii?Q?LdeF9qbKVI8OXju34Tib1peSPJMaCQ1+jtkcETVV2wIklFnVb5sdW06eihwH?=
 =?us-ascii?Q?+xDOhr7n4IXpC+QuLAKmW6XatW3lzIEUKQDBQOR4VzR0ZR3rJgqmznT39rcG?=
 =?us-ascii?Q?LDEdCM7AwvXV38R8/72Wun6usm0rlm5lRHqZ6m3aj6yiddmcwX8szwzunN7M?=
 =?us-ascii?Q?yYtGLatJ4gvywU4ybwLOBwVxssaaajXc2JSPcxOqMF1OSqxwVJERQwrU5OzR?=
 =?us-ascii?Q?xSp4h1cZFwH7HotAJT5hWFMk3itd39bLljsmOtOlZj0UWOcx1xS2crarJ/DL?=
 =?us-ascii?Q?/Zp3uO2ZfRUlfx2mVB4ysmAVJ3RJvmw++ia2n0399P89NE7TNvlVmk3I2PJr?=
 =?us-ascii?Q?BG3YgNiN/BD/1teNh3GRL5dscctgQl0HFu+xkavbv9G+GQeOPt4s8o2/RTjY?=
 =?us-ascii?Q?yzuyXhlMjqTdad0jcO0HYJ2bl8hiZqtCfAeeuv35H8VpgY8Q1BUl/RQxaswQ?=
 =?us-ascii?Q?VFvSPm8AGFyTURw2ho2Dk97Tde6EbmnDfWg9kQfPaIDGzI4xNb4cBMpGOdhc?=
 =?us-ascii?Q?i2QsODGr4zAGgtx0RHYjNK7AdINMCBnSn0SyUltPCNURbUCPBUzCORG9ydic?=
 =?us-ascii?Q?/YAQe/cw7b2FyNV9ffP1HbsD4BSeq1XmzgIR0N355OoE2K5aka7k5aNsSCHo?=
 =?us-ascii?Q?qTyfA5a53nNTg+cfa6ztP4i9Gll85AIxCw20D58rur1FCmMCBhADlgDGitf6?=
 =?us-ascii?Q?4UKQBRg/OWWZDxG2A4B2Yvk7jnv+lSBJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17eBaMPi8GGyYjpvpJMM3ZF1nPABy9r60k5CsASFRcotFvprNWPCUDbpqBVS?=
 =?us-ascii?Q?qDfFOw1PEwy/6Pf3aiGoUtqza3iJAbI+gcFK/RLd9LI2Lz+4HMYDAHyO9IzS?=
 =?us-ascii?Q?vzKSD6D6plOlKWu5V1SuUAHsQSYm8re2MGbUy9XNbIXsBG/cTmdW1x7/JB4N?=
 =?us-ascii?Q?AzhEW6b0NP9Jk0LL7aGajvTW80iteZaM5kJc4+nZJv33/JVIOiykr2l8wcjL?=
 =?us-ascii?Q?H0Ub3dI+rpPoB8wP0cWmiO+xf6WMgO681kxy7rI/bFb96uu7oa1e/i9WcnB/?=
 =?us-ascii?Q?iR+WdGAqsmwvXWS1MxtCV+XNYI+f+X0oIu0o56OgbNW6vZ5t4RhbgYmlW/T9?=
 =?us-ascii?Q?mH5Fsu+DuKol12C+j+TnBkAjs5ku7LSwGXNl6oJijGe6+H9wfvfCQKhpeuRh?=
 =?us-ascii?Q?DAz7mpQyLZNvT1VGIiOLuuXjO1pKFWRzAYuu4ijhAWP1sVk4OrwKOHRcm73y?=
 =?us-ascii?Q?Mhay9aRlCDQ/ApScwYbpQhl+MyIZ6MoGafGhPoUZ30VSnWFK4uBYlWJqW9wH?=
 =?us-ascii?Q?xH851V5EFWCnOYBIrxUbaU+uj62imdmERWp5eoUKc6KZ4oZRIXRo23uBt31z?=
 =?us-ascii?Q?CKV/L7wTbEg/SCRcR0k3013YlGgoMim08F9KjvA6vfRJedkbW0m17n7xcmN1?=
 =?us-ascii?Q?zNl1Ke+lLFtJFX0O3gpXbUTBn/JeBU0pxMuagX5zw2xnebFOIS1zuSZ3nAvC?=
 =?us-ascii?Q?zvzaAN3WvV1zpf7ziYJn17M7lFRojpuSp++KLURuAi3J7QFDJS+KdIBcYTxE?=
 =?us-ascii?Q?cHWa1AeX3JNqFLgzk/8LSNTGEX9i2P/WFOLi6IB88SK7UIR9NXIz4JZYGSRZ?=
 =?us-ascii?Q?kpQ5CeJwhVkKXs8YXTnDGPeBh/t50roKiHLtTa2nq2YuCdgpi4OHJTYwAsrO?=
 =?us-ascii?Q?IFhGquItT10aSPSQveqHmgUmd4YEmC2bAvbxtbJTbxyrcuaPh9/neRS2q0K+?=
 =?us-ascii?Q?6+OJVjeDRpmW1dC/DXeVs6dnLmxYnQnqw5yMWfRv37oHIYzE7q4TtGJjPtSz?=
 =?us-ascii?Q?SQ57OQd4gyJHTZ8X5Qzo5y50F3U/svFnjXHrKw8slpQ6aJL9or+WejqYtF7J?=
 =?us-ascii?Q?GFsQ7N12IuXGYPlx5mOQgqwXdqx7SNc5jeJ0Wc11PIxSpU9MCvMVmFDYkoVQ?=
 =?us-ascii?Q?G7jugxicc2t61co47tFnTtARNvjqTgVj2z8YMd1Dmm7A5/zCHANTT3+S9CQF?=
 =?us-ascii?Q?jYGWVMz/KKUz+Oy3GCNHefV/eqifNxaOINhOL6WWc8oJ+mxEXpSjqwYFzDGh?=
 =?us-ascii?Q?XDrj3Hg0oonmI1gyrA0K/dwg6tk2PZQnGW50GeMaMtQr13+L+erElIeV5SkE?=
 =?us-ascii?Q?3r6nHPoqtf/PESjMkqJ8zdoXSzQqE1nsz+nQ73C4XDuFRg6f9UbTFrw8pygO?=
 =?us-ascii?Q?HKW6SywYtBWL6jRprNr8x4aSCXy2EfJvLsVL9a5VQtXUt0Ei/vNpzVDaH/pm?=
 =?us-ascii?Q?gDB+ra6qkjzHwsoHY+kNLEB7JlzLzBIRrGRFmWzOSftZ7qxG149UuTs7vHfD?=
 =?us-ascii?Q?9Jd1imLt98twiSSt/8eP6lVps48PkXQPGSbVr0jccE3wkzfBOSS/KLTagLlG?=
 =?us-ascii?Q?JOtfgGpKDr6ay1krdPESspM7uslWURIj4ontP/65urb742AMGqCc0sS897Qz?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dwf6cvXeswIm9e4UCaJeHRigBMzGTmjk30UWDNIdZ9Cva7Pq8HzNwfY1AzrHGNCa5Dry+E75bws66AUQQIHcHzu9tqzzFVcMBVBBdT+BMXoxGWc3nL0NO27BK1bF+CLdGdGMgINEnV8Adlp390YwF8apuBmDYs2m2ML6nlP3xnzzaOusiOwcpc0F8+9c6878jWow+yBgIcqMtSA4k9Ufv/CfNDuGLGP4QMfbASHP4GGCOOiMhzl8HdyqxBBerlGwx10M8BU2OYAJWxA9jpJtupV6x3NMy3DVLsEIx8Lr9rasOan0ZbVZkYYRLvqobVd5y2UbK4oRlH7yxeuxtia7G85VRbvfYeTl2usuIkX803MNuCwc8iFukEefXFtEv3u2uOLGjK84oom+nW3griTPw3HeZoAOYwe+4k9zPIlbXxHrVR45wTlgTOvr73aaM7AGRKeF8h4wM1a8sKN9svtUudYtGkgIV7u9vlefRLgvVI8e8HyS7skw8MTSCvNzgrAtZswoNcCqpq7s05QX1OvmQcQWXH96IU2JtL6b3Kk6RUg7w+f+cemipsNGNjFlPNVDyKSYNGg4Gy7CMKK3+AcrHg5gC4uWwSru95pMkFXz/JA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891da33f-5923-4f5e-91d3-08de37de6ed3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:22:41.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfA2mZd8Vo+5kxPrBzQkiRE+fWMrMgyjWnRMzZpMKJsROMQanC5/X+Rltc9cnP1lojPkpcNyN+sYO4rbYJywfBZ6FJzjfyEgJPugsCONFa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MSBTYWx0ZWRfX9tO9EdwXm7W/
 RD98t2jiodnSW8s3IrG/dapwPtEubcL6vvRlEu6JRBE72bDPqfm+n1zJUmljE7vbKs5K776s1SS
 Spssv0jRxOyWe/B5jt6fnEG+vTMaG89BHDquEBWqNe2VbSaw4T91zKP9YULDRAQOGQSLHjy0oS9
 U7xISQNlBa1D6zoUnV/kK2WlB6PAU3Mk3Vq6uPa9MZr48DO9BW/dO3G5j7hvhSzCkcgpBnVJx8o
 EGz4WYoUjNgs/z1KVcAyE3pXJCZ3IpXTWo/wEt60LgOHJ7AoEvu8NCmnBnF0HaARcnsPKk1iPQl
 PmjPQLCFiBvFPoSy3sXSfOqxeJRLX4e6CqoaFMJjJ1dU23CwRUaekTiuLuijm0sOl4B/y63akHm
 0cXTGKGd6Q/b27xw1SZzyVpxt21OTg==
X-Proofpoint-ORIG-GUID: IyA4Ky3aQJXWBgBEB2Z1LTK8vAwCYMZR
X-Proofpoint-GUID: IyA4Ky3aQJXWBgBEB2Z1LTK8vAwCYMZR
X-Authority-Analysis: v=2.4 cv=X/df6WTe c=1 sm=1 tr=0 ts=69395805 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=m6Xm_G35GB99sRZvWEIA:9
 a=CjuIK1q_8ugA:10

On Fri, Dec 05, 2025 at 10:35:56PM +0100, David Hildenbrand (Red Hat) wrote:
> Ever since we stopped using the page count to detect shared PMD
> page tables, these comments are outdated.
>
> The only reason we have to flush the TLB early is because once we drop
> the i_mmap_rwsem, the previously shared page table could get freed (to
> then get reallocated and used for other purpose). So we really have to
> flush the TLB before that could happen.
>
> So let's simplify the comments a bit.
>
> The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
> correctly after huge_pmd_unshare") was confusing: sure it is recorded
> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
> anything. So let's drop that comment while at it as well.
>
> We'll centralize these comments in a single helper as we rework the code
> next.
>
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/hugetlb.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 51273baec9e5d..3c77cdef12a32 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	tlb_end_vma(tlb, vma);
>
>  	/*
> -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
> -	 * could defer the flush until now, since by holding i_mmap_rwsem we
> -	 * guaranteed that the last reference would not be dropped. But we must
> -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
> -	 * dropped and the last reference to the shared PMDs page might be
> -	 * dropped as well.
> -	 *
> -	 * In theory we could defer the freeing of the PMD pages as well, but
> -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
> -	 * detect sharing, so we cannot defer the release of the page either.

Was it this comment that led you to question the page_count issue? :)

> -	 * Instead, do flush now.
> +	 * There is nothing protecting a previously-shared page table that we
> +	 * unshared through huge_pmd_unshare() from getting freed after we
> +	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> +	 * succeeded, flush the range corresponding to the pud.
>  	 */
>  	if (force_flush)
>  		tlb_flush_mmu_tlbonly(tlb);
> @@ -6536,11 +6529,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  		cond_resched();
>  	}
>  	/*
> -	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
> -	 * may have cleared our pud entry and done put_page on the page table:
> -	 * once we release i_mmap_rwsem, another task can do the final put_page
> -	 * and that page table be reused and filled with junk.  If we actually
> -	 * did unshare a page of pmds, flush the range corresponding to the pud.
> +	 * There is nothing protecting a previously-shared page table that we
> +	 * unshared through huge_pmd_unshare() from getting freed after we
> +	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> +	 * succeeded, flush the range corresponding to the pud.
>  	 */
>  	if (shared_pmd)
>  		flush_hugetlb_tlb_range(vma, range.start, range.end);
> --
> 2.52.0
>

