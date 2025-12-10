Return-Path: <linux-arch+bounces-15321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E58CB2CC1
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5381A3038F72
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA71D63EF;
	Wed, 10 Dec 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cD8ZZxLU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="youetTkV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7ED3B8D67;
	Wed, 10 Dec 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365411; cv=fail; b=XpBytOznGGRcNXxZdUZrHk1GunusyPmk2NPzJNq8Ul7rNafJrj9doDey2KGYzPqa42ZhFiL7sEwxH/CNjo+CAht43OI2H6XZV2BJPjNP0LpYYfHb/luYIFfMA8OBWymI3biptMwDalsjyhUTLCmain0mWckwVIdMNUKnIFj81y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365411; c=relaxed/simple;
	bh=uxaOHlxCk9lffQVW89YZKe4OF67C8MCCF9sfEYyR0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a7B59YjE9hH09wzzfQ6D6XeZdoAEaGMH5N63fR+6/2ltoiiLugmk59zrJRRonBpiXyP/rjyWwxlmGKB7lWwVfhqifzelZM4QGEnHlhFjDXw0WDJKZWfZV7t0IW72Yo/SA24qX3hhcSCmC9qG2IGWIUb0yFnlKoVIM65QU/4QaNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cD8ZZxLU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=youetTkV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAAwEsn2963037;
	Wed, 10 Dec 2025 11:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EXvUPTgWUMW/o0QXpa
	FoYs4xARtnP13tPTsrPaCEBOk=; b=cD8ZZxLUhGsZ0HPNLRa4vwWBv4Sz23qYc1
	P/bIKYetbURRCu6bV842m8Ln+u3qNz/SILn+McCYFYZEeECBagrO2i8pPalL2jQw
	e+LZVqFBArtQhsn9GnPkx3ukEDQOFirB/lcGjxWJ1sn8m7qxoFQy1D9E0FH4bmdb
	msY0YLzrJQNnniMYT4mccNokYhDu8V1xCAMx5OZPFqR/D8tGiMrc1ZDv8rG3k811
	ADgdmRd3Evn+IJgmSoIwhyDRoA/Qzdyik+a/ZGmfRQiIZopdRSvRJrKGphsvqtTq
	wjP0ssj7iivoNbTli2ASsXPOMx452JSC6cjR+v62oxyO/RC53cpQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay7jnr0jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:16:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAA8U3N020279;
	Wed, 10 Dec 2025 11:16:04 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxacerq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/0A6kmi0/hqPS+Ph4O4qGqEYZ7sjGyaAiNZd5a2LWMtTInk67wLF88CMder3AEt+usWVpJL/eDgvVnnW6ujbG6+dZ6qpjuppsd8z7I+DT0xRYF1v/dJbM810TzpYbdCf1JACpujw4ZPlaftedgIeAzQ6SbDiCvbBpBr/aFwL+IXm+DXQjWFI27L5ghrXujGl3qgWfQiYz2cP8ObpG3nc5O/jz7UVora0iEsxKJe6w6nB/k34GEwZ04PSL07iO8MJPId9aWdvtChFrXSCYXOyc/iJlhvKz9F0UzE69Us9ZYRhL1t+LEa256gOTIkrMRTNnR/igu3bEdFPY2m03Moqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXvUPTgWUMW/o0QXpaFoYs4xARtnP13tPTsrPaCEBOk=;
 b=jX8fSe/xOBLcwnqAcvFFizHuZ0VzxdSHZT/4y215TyJyfNrrE5q5fUNKsU9bA4dctAfSWOX71JMSp+tkKh+BJ1pJkDmiA+Hdo0mZQWDckVNfUd681LhJ4uUwsBv4D8+7olKmQ0P1Bepq1MjGMgorZub58Qxq2dDcHUxK0tJcbnDkRAC1UPXMLHJ66c0LFk4MYQciHikvTOfRYhXUuGDtbS0UL1B1lU1crK1vLplbW16QshvM9lcD1aO46vXfP3+S/Zrxcb9gr2HKEZRuLUVl40ufdjP1v+tSpxhJmq+aeIhYM64tV4a4U+jEjRc69ldAXhbPXtydBalZ2KoAf+D3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXvUPTgWUMW/o0QXpaFoYs4xARtnP13tPTsrPaCEBOk=;
 b=youetTkV8hSQC6qYG1MVXLy7etJ6J27vHovA7UBJcrv5QmhH3/+z+QCA29YqbyZygc+WBkvzSIn8IqTs5tOsiwBz+bn9AR+EN5objgucmOLcdbePIfmMmcjVUWFO5nu3CjMQOvH1Wk5nc1MPOR3a/YsW2ICLF15VMKSrZn2QFU0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 11:16:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 11:16:02 +0000
Date: Wed, 10 Dec 2025 11:16:01 +0000
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
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org,
        Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v1 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
Message-ID: <522c24fb-357e-41ec-9510-2547f1986c42@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-2-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-2-david@kernel.org>
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d919193-bae0-40f6-2e34-08de37dd80b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rFPZDY1sTBQ6mp3OiZ9at3GJuOZoDEaERWT8LGPeOm9QRrFwb6pOIauxsNn5?=
 =?us-ascii?Q?l7lXgIvLjZvjhnyqMPZJgLq1ekngSY3iOIWiafaFCaNkf0nibN9uFH2AyQFs?=
 =?us-ascii?Q?W5EtP7w9p7XLsnYDZ+WlWUwpaZkqn3at0ts4G3TogjWShCd44mM22cwrLVwC?=
 =?us-ascii?Q?KO65zzMzenjlJk0nx6maIumuO2hUnzEMF8R3j+7H1b3gauIsdMM6RTPYCT7a?=
 =?us-ascii?Q?qyz4iNLXqHccy3k3DtW1vkjZLIHOwWzZPzAzOmF6L/Wtq2Umj0qd/oUqyeHf?=
 =?us-ascii?Q?sTlYHQKdEQHsU9HU5NhTzu9eVdEIJ4QYUoB0aTC/KHeH9voxztI276V4IUL9?=
 =?us-ascii?Q?/P+ZiwwgdsyoH/EVgG+Rx7lA5K4d/obAmd29oeoDlRzwfFtrWt4i/ol6XnBF?=
 =?us-ascii?Q?kSGdTAoQeKr8ciQXX0BC65gi9kBSTkoRwodh3Yho/QlmCOSrXM4WaGjEpG36?=
 =?us-ascii?Q?AbVIGVJ/w1QJk3aaLAhnaFIq7S+SQlrCUB6LSLdO5ieSNtVWaL9Xto69Cstu?=
 =?us-ascii?Q?HLaoemvHtg0tbbiAp41rJgoU6MVJbZs9loYq6NqvqEKZDF1i/zeuVmtjbj7h?=
 =?us-ascii?Q?IkrEcVCZXjaVj5A+Jo7gMTQvvGSKedtSHIRVT281wGIKA5g70htXoN58yNCJ?=
 =?us-ascii?Q?Yn7Y3zMWD+Zv9cbV8EF79d7MgSFv9GJ+1mtJkoZNyE7PBDK3JLUuMm7KQuSc?=
 =?us-ascii?Q?tQmZifcYEbz2SHjLvxkFGvimmAHGlvaK/8fVYVAbDWp891dhld0doMdxUN+O?=
 =?us-ascii?Q?DgteCt3soWn9dzAZ5QZyQdwo3GV0AV8Ni8sHMtTeuaOSYYtCRRPI0bjNpVZJ?=
 =?us-ascii?Q?og6iQDuhgjfLwSCmpsaGNUdpYFH0iw3/IALfBDuGtcnZ3uKHKswRaQLHdCLm?=
 =?us-ascii?Q?ZMmHJxgDzQyMGaiPLX8mrdzFyBark+EI0F40AsohvQcZxDhl0walki0btA14?=
 =?us-ascii?Q?imMHTrqBAE6ySwhxlpb1EQLcfEDf3CzSseR7YqqZBlApgeRgmYFqVNO3zOQR?=
 =?us-ascii?Q?PV+4cQtwZpPNil1X6zLTEZB+cntUnzQYDc0C06HP+7YahUsR6LY5EKie03hJ?=
 =?us-ascii?Q?go1fyqCkVzmAiy40PgOWGAKd+clK2U+cV0mZzP+WIzP/ClzeH7zZiiI1K9an?=
 =?us-ascii?Q?8PD2v6Ta6W4WubJQjTHXAjwzEFsdGCklN69USvmgTt9UniiU4Mp+VBLat+vD?=
 =?us-ascii?Q?VR+0Y9xJc0RgzH/B8+ymNgEUd7HMCq4ea+K2016ij8S5t9ba2bfX3DgOq3dE?=
 =?us-ascii?Q?Nrz69TmwXXtf3yUkGYBox3Qp0UlHVUseIKUUXpx0ltvqENjNX6Nr/jraInNC?=
 =?us-ascii?Q?Dy4lRAvC8QQu1ZB8hO2gRbhXVUtapbxyrzM3owLZyiALLoBGK4l4zWQeLARa?=
 =?us-ascii?Q?pcMqkSwvOwNSHBzXs4A/9fAITRqrSrymK7HA59zpQsN0IIrrrwMMsZ4KX/Iy?=
 =?us-ascii?Q?hBLIlwRjOd/I7wJUZByXTZIo/KPnoZhm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbxUqwuj9RwcqCGEwlhnbQjs15jGsbcGeVpCJufGxYMdCw9xVfLnhQR2jjUU?=
 =?us-ascii?Q?Oznnc9SqNou0Ul7LTcD84m+0SSfkc5qU9kxhwBpng7L6vi01LbB8JYugfeix?=
 =?us-ascii?Q?2nHWwDWG2KMiHBC1XYkUzjzZ/fR0gktbm7IZquF8IcyZfBtVI7TDSm5jv260?=
 =?us-ascii?Q?aQINnz8plUYpNtLFe0pqfgRj0LkeJQF+HeimqMrg7KvNInM8Dg5tpEj+G7Ij?=
 =?us-ascii?Q?HNZBvmc9RS1SrcnnF88/cYW+BxVN7cFbiTJd6uGa/sGdHTCWOJ0hUmQ9GS1W?=
 =?us-ascii?Q?eMzwvRPUnXRRAL6hDJEaldgIfEqDspHbtxgBHvTHNRLsYC06WbbLzcQ6D5Ko?=
 =?us-ascii?Q?EvhZIKQ0HnCXzc/kW0OFB5ZMlRMnrBtm3dH6hpN+6/GM4OM8+ckpspHQR6y0?=
 =?us-ascii?Q?Qf+R6DesW7UTaZk1umA7uHgMd/TTYmqSK8+U9mjSTyja8f95HjBKHeIZLqyZ?=
 =?us-ascii?Q?z51p2InuoNIqcQL4WUm2EqJ06sacGIac9AsLrDSQP3cEAr6uwByq5thmuVlv?=
 =?us-ascii?Q?JoTxw8IWnBANj5TZYpYfmqh4EpYlnGRfkXL3/uFV0cHQIsrI79mtKPl44t7/?=
 =?us-ascii?Q?i3U7sH7fPUPXwfc27bX1JppKQm9jFGEbF314r+Xq10rFQIgfehKLxTkiHARA?=
 =?us-ascii?Q?jO7pE4cLD4GYVctGXYDwUYBPLyBxi9j8yVDQ2siFVV55j6zaDEDMXx5fZnG7?=
 =?us-ascii?Q?0XxQPR+3VVjcsciBgDkmXNjJR6mXxMRHGkXNodaFsFk12F2SoPPIT25dXo5/?=
 =?us-ascii?Q?x5ccsDoq/1kcZ64QIAclQewyGcCCcz1HQIddYdHK2kD1Qb61xRqo+rMYyyxg?=
 =?us-ascii?Q?OMnghfY5ZO+bRlgF55GoGXL1XuIH9SZKcB7vddJ7ys/S3EWtp3qoXEBCsIcI?=
 =?us-ascii?Q?6OaOR7LP/clu+YI/b+a165Ps+/TZyWfZ9U3jRrrFINNIqLLqbmScZvkj0zkX?=
 =?us-ascii?Q?t7wl62+Pg4yoa7PCRNj6y07StOfcfqyP4LAhEoaXg3wG6tktm0a5EGeY4mX6?=
 =?us-ascii?Q?Uj/oIk1cL5mQvyU/B2/cLvmNtrwx/HVYHoi/GYM4yI8p+Dj+PsgmLTlg88y7?=
 =?us-ascii?Q?Kiy0NGYg9pVkS6n6gwvIlJmxBEL8bhdZJRrrXjodPJbYO53B5kcYNsEAWJHa?=
 =?us-ascii?Q?POhgMnqkrL6x4jfVDNR+wZtz2NsJ3RhAbeial5hUeOURQlhXCCnGS2yQTa6k?=
 =?us-ascii?Q?IJ72ItmCNu7yK7tpjnk+02oBjLJPanyUViz/NCVMMbBPl0Kr2xEzhPH/wfnF?=
 =?us-ascii?Q?wncZClxlZS+llhTMC58rZlY2fn7VaCZ7EJIzTHVYkWCxkbt3K+HKQYRQZ0pI?=
 =?us-ascii?Q?ki8a5v+My4J/xn2CXqwbOHdui+ILD3eT674OCM57/6b630WqjXkBykPZmU6T?=
 =?us-ascii?Q?gThjCn22YVetpfBuazGCpg6dVuxMGhFEgDlshzNPSk0DCI0Wbf4LjnuzGKqr?=
 =?us-ascii?Q?Z1/oMfGu61qnLPCSaq6wCE3AJ1epUb39KouqvlUYl+SH0tyxD+7Vpmfxmcy1?=
 =?us-ascii?Q?icSNpGcz0NLyYm5V1fPtir540RcPNnC+GrboZR1oU4MbutE3VXSMszA4MkvV?=
 =?us-ascii?Q?nUpJ97+vSsvh61+oDLDn7PU7AAzVxZnkuBs6jLvnvnIbpzIcD2c6fskFiOBS?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YcS83fLzjbJ6E7j3vkaSnia0szHrh60+H50JBxQ7Z/pCtdYGAHye01Qi1xMB9lvKV7/R+9ev187cuxQ2FoytDE06jnOUbgNGUnvR1VQ5S75K6yiPce2mjURFLc2anFkdarZIluLBauoPmVUJIoqrDpR2439h6A/jhba2rivkvVVvbY4Tj3tS30cqil1TsjmYa1rU32L12mQnsSGRRIr29vECHcbolcaFB5JcgUWCR8jyUyQx3RRNxWSfuC5AEuNu+9+/h1OjHk8w86IAWsIv7zZk5nrj5ePG0q3Ao2kNecJivT7qQWzHpzFkVITB1imH7fHOqFw+RWWYn0RQIjN9Xquzi7zYXGBI15VfnbTTEsD6+rz0pSoSwrFEdPg2yAWZZVfFiWP6K7nYwzXYGw0kY9vHAONHPZLezzHVA1wOe+RsnXkvtAYADSwFyK/et90uMusV3fnWLgGIRbPsVHQStlWfllaoKjcJMws1xbUNUksKrwcl5xarYzxd8BVNCyGeHW6SaIv+QKLVL7tjMWCAwTYy+9omypl2qyhL49M+X1hJrLI4vQy5uq1GY6F9WFCL3DTTVln+5mxyBuQHSNSbkoLZjDMq8oFr0uTRJLlYg50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d919193-bae0-40f6-2e34-08de37dd80b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:16:02.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuZuijThWve5A3267/W9dSwbJ5F7CGnc1ppe40g36jLuylSCLlu5JorZDP/YWFSeYtggxKuRY6xfnGPkpCGljkE1TUkTpxcTBQW4pQCWHQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MCBTYWx0ZWRfXwJlD5v345gk8
 AOlBsGDh4eW8b9mh2Cvnnh2TrNIV/lCjBCHMzXfPRdC7RfCAM5wwHzkMZDzsBSj4uMZSWBOLpJu
 WBbVDbF+4xxPnuw32foPl9j7YXC1F566jiPAIWWSLx1gnmBv9VwsClQCoPr9TziALAhigXcSRR1
 qqlEn5K90Bgh4cVqhLASNihEucACyUOjJ8w+X9XiZk4U3OLmELAMlDuY18P2YlkOxQ9B/6PPDqf
 /ecRkF4LV9wROb3LKMMKLeUxt01l5HyjgH8BbqQApDkTFq63BaMzjr5qKwj4G+b4KVUBXS8mjXY
 O5qQzQhcon2TCjKXLvuEwnyn/PHZ5r4rmkCd+n4JQfX+sfjreOY2BGtz7wySD2Z3gUxJ8tIbBpw
 fYMdk+YqaQbPM3ZW+V5navILWgBcfg==
X-Proofpoint-GUID: UJ3dI4RaWYNt8_HxaocjtsfHkyq56bEO
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=69395676 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=rOnCVb_mmqEaAXsMVXwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: UJ3dI4RaWYNt8_HxaocjtsfHkyq56bEO

On Fri, Dec 05, 2025 at 10:35:55PM +0100, David Hildenbrand (Red Hat) wrote:
> We switched from (wrongly) using the page count to an independent
> shared count. Now, shared page tables have a refcount of 1 (excluding
> speculative references) and instead use ptdesc->pt_share_count to
> identify sharing.
>
> We didn't convert hugetlb_pmd_shared(), so right now, we would never
> detect a shared PMD table as such, because sharing/unsharing no longer
> touches the refcount of a PMD table.
>
> Page migration, like mbind() or migrate_pages() would allow for migrating
> folios mapped into such shared PMD tables, even though the folios are
> not exclusive. In smaps we would account them as "private" although they
> are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
> pagemap interface.

Yikes this seems pretty serious!!

How did we not pick up on this before...

>
> Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().
>
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: <stable@vger.kernel.org>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Esp. given Lance's testing... LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/hugetlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 019a1c5281e4e..03c8725efa289 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1326,7 +1326,7 @@ static inline __init void hugetlb_cma_reserve(int order)
>  #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>  static inline bool hugetlb_pmd_shared(pte_t *pte)
>  {
> -	return page_count(virt_to_page(pte)) > 1;
> +	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
>  }
>  #else
>  static inline bool hugetlb_pmd_shared(pte_t *pte)
> --
> 2.52.0
>

