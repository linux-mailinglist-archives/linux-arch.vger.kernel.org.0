Return-Path: <linux-arch+bounces-15676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B1CFAA94
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 585FC3057085
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18C2FF66A;
	Tue,  6 Jan 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="auccEX6f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f3meQXfI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDC2236E3;
	Tue,  6 Jan 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727618; cv=fail; b=LmtzzXgLGBF4g4VHWB7NmCJUiPKzpSUGsOguRsYr0ckkrSnnm0KtzyeVGN3n75LOgjjYlRs6nCSHZC7b2/SmtQVewxpZt+duCNeDIFl2vkoDtUAVmtFUbmGjAZVtYqQyA+sg2HG9oIS0K1CI/OpWejx1QHCPWPOWsnPJgrz+Ne4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727618; c=relaxed/simple;
	bh=JfXOQboJeycHC3Y4n+mhrZF4nyK0ldqUXA6nm5PAhBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gsTrQvMWQ1gBKoW7xwEIdwDOoglEN9OCPFz4cqsN4u5nzS22+x1hgAuZF/K1+SloVT11KY23IQgF2N6ZD/pt8FDuqxP0MKu6T2gz5JsQQXXmXr5GnLKSC3Sa+C7Gdne3J21CR1ecGt4WaGiE4ZpfQpgDq1rUcKrXqPxx4RdmXy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=auccEX6f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f3meQXfI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606JKO9g343678;
	Tue, 6 Jan 2026 19:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5PTwYrRz8VGLWJXJfn
	y38L38CBlz3iiV5IkiY1LU4Ss=; b=auccEX6fSk3e+Caznx99dyOVgUxtSEYQgR
	ni2f8aLORTChpe9jjXXB0I7qSEjC4nknTWMzCQLyo2P33aBetsLDX7mwG/px7htH
	eEH30674KDB1ztKzMMMjO5fybabmQkc1iPCsaOy3fSWHSd4WR5MjIiDzR5ElRqxG
	MfDQBayFN4fIAnXr1aLNSHh7MGo4sMtYwp0UNeqXiCIU+HiPnBGnAwjFwzCie7AF
	/EeqP59RoysMAC65OcrTjgn0o0Mqx/Ly4mB4yjpCtlIv4tU+ZXpazwske5/tB1CH
	sf4FqEwxX4SIyUPx3yNllPgM2XlgxZLOXHlopKos+Rr6ljg5Uziw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh8f7g08m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 19:26:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606HQCd8015540;
	Tue, 6 Jan 2026 19:26:26 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj8r20w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 19:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej9Sw61ZPA4/gsoTyOM6pGlZdflV6GXiSVrl4RT4ZJrnOVyBXBM0HkdC2j60BtHIQKUYVXkE1OkVZ+hgjp2qGHj9kdkl2C9FtZLHSh7nfDfvOTfXFBnyEyTRZek+gaISnYGRHfcpCsrgumHaWWriGWFRJx3+D0WeBVKjAHsWPZK8BwzF2BeAO4/izDzK8DeIuyQKG5Oi3Gc49IKIjXu5WYQ6pSH6InUMAZQQEp0NFFai5MSfCSj3scfJCdYoyMJhYdK6lberpN91zQ4TNTw51xAJWefyzoRqeT/223lAWk77Eg8lLMxfsleTSOb33kKMm80FBC2U4TE6QPdPxjo7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PTwYrRz8VGLWJXJfny38L38CBlz3iiV5IkiY1LU4Ss=;
 b=cG6+UWgzpR6qWYDEcOW57sLRYe+xRocC3sSMX+UabzZmC/EFz2Gh5nEOkAA1YvxQICr4QjUuHVqIPAxrKRpUf0GQOHhMIrB5WZPUmeXt68pKNcX2xvmKQaFNui3vyuLXX0WiDyc+ta4l4z2TlfEeTXE+NA3Updfc95KEom/LMgv2C1FwIbcAI0dw4ImUV+SOi+K7jLIOLPUNGS/th62FyE5hKZ9crbyRXG59dqiHHncBLT0WcpkL7YE2aYGOP/0JCeYVl8SwBvtuRCupYbh3mU0FnTsOpPOtPkvvCoOy1Kx05SWUW+YsT9YaQLofVc5Sdnkk+vWwRRGOjc0zonGxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PTwYrRz8VGLWJXJfny38L38CBlz3iiV5IkiY1LU4Ss=;
 b=f3meQXfILSWN/zMkPm93wwEbaof8HGaI3AXdq2JJ3OuKQNMKv8HV7k9fUPPTHwhNVGPAipqsd5saydNXaTDJIsUnYKlTFyYMbYKGwc1j3x5kf+zRq6pC1op+52JimbXzjvHGyS3hR9S6IR+/rXjJnMUuSGs0yoLAd9JUcQ3z41I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 19:26:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 19:26:22 +0000
Date: Tue, 6 Jan 2026 19:26:24 +0000
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
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 4/4] mm/hugetlb: fix excessive IPI broadcasts
 when unsharing PMD tables using mmu_gather
Message-ID: <4e3e2b83-c024-4e16-9913-89f4bc302444@lucifer.local>
References: <20251223214037.580860-1-david@kernel.org>
 <20251223214037.580860-5-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223214037.580860-5-david@kernel.org>
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 6669e2df-e4de-4a41-46af-08de4d597981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Okc809rKvw6RMT4FL56BHugtOv5QfGhHs5Kz5n4nXY1P0CO58KDc9xCvLZC8?=
 =?us-ascii?Q?MPQ0JlegEJsl4XZlwfMYbrN1Jfm/Xfp7rp2PKCRjKhOUtNy/YQ5dM48oe8Qt?=
 =?us-ascii?Q?O0QuWpdbOcMtET+rqCIhEmTlVVqnMcGHNljQ8wjFjkqfDRTygmlBVzlmPd0v?=
 =?us-ascii?Q?z2ds66HIxeVZkkTodJyg4614Q6J7tLcVlMcuAl00w+3DGkTGgS9L/QT0Pv0O?=
 =?us-ascii?Q?o7fHQvfE0tW2tzfP7bW5S1aTzngrvFZOOWYLs7vV2tKxYZKvE1HOyr0jz6jB?=
 =?us-ascii?Q?7lMn98XSOgNcCFh/2UopuiQeXkdHwiHAEcWK3xz0hGEoFfNSpp9kC1a+nqJH?=
 =?us-ascii?Q?RtPP4z8+heBsIcaYk2m4KgurRwfYYTtnAAio4/cAcYzcii/cuxr2cUlrjqHT?=
 =?us-ascii?Q?lPGShX2evJG9/HMFmdb6wbfJbPn1tbfQMHx47kuon8uAu1ZP3fqRlmWAyxIJ?=
 =?us-ascii?Q?u2U//uZIM4HgTUplmC+EGAEp9ZvuiX1DsxnmvFe+Jiuj4YBSPMtacLyfK7g6?=
 =?us-ascii?Q?oYGv6N7M+yR13goywPIT+OxoYpRxXpBNfiCdJl+GBsTZ3aBwdFD6HNfRFIeG?=
 =?us-ascii?Q?cJfV7eauXCDqQoOTnj9VXWkrM2bOHQFYHZksqbgMaMzPjYcVOWt9wchhHE+k?=
 =?us-ascii?Q?0nllojeeyVQ5uNaIVyG1FKK3j2cL/lrCeHLgyBB9S+t3xXqoC/VjW8bmN4Bs?=
 =?us-ascii?Q?VZ5XaMzhaKpUyQAuFjV2CjLOmnlyoG73ITChFNwTyoytugsQJ9IQMJ4deOyS?=
 =?us-ascii?Q?eMUlLCmUmlzgSUPHjbtnkMpZ+uKMT68dIUfMLNktF3FaX+rUbVgpK+jUZkaZ?=
 =?us-ascii?Q?Hs571e9fVqyMaoPAN3SQsIjFP46v6Pxl2bMnvSKmF8RslhrS6PsNMKL97Nec?=
 =?us-ascii?Q?XU4nHvyY8JUriSmBWcqhN7N7kzniMPb4VxpndBZOSlWhq2wGEDu7dSuzG5UJ?=
 =?us-ascii?Q?klrK8KhmLvKqbMTLhnkSzjMnAJARQDpCsk7WeSFG7DhK58sTRWgpXNP8Ya/C?=
 =?us-ascii?Q?1NDHA2KL5Bu616joDo+ci1XLUgINV+CI3yDD+KjSxt+s2UwmxeMDI8OdLYEt?=
 =?us-ascii?Q?kO7C1q5k4b1jYMdY9EBgA2+0RXqlqEa6+1KPLH3je0sU0J+dnh4u2mhrYGK7?=
 =?us-ascii?Q?VkybXxXpvN7NQvgQbBYsZvmxFhEU0bxk7jUAxYJUTdlH8AFNISKkfMCW9FPB?=
 =?us-ascii?Q?g49d+JA5g6my8bT+jxptQbZdfdNxCSbrcE80iu4OcBRrvabDAYgQWX1nZ7nZ?=
 =?us-ascii?Q?Ajgb1Ksf0mxzbPk21UgjF2gYdUeGXi661hVKxKd30HF7Y887ALKe215MqxVk?=
 =?us-ascii?Q?wAxwFVijHQHw5bLhLMX+X7sxb/MUV5IVyZtk+Tq/tSxOkWYiQ2YPSC4PtbEX?=
 =?us-ascii?Q?lYWBtDUGlvRqPlgMJMbCGHgq/oyzuZ3zz0TDPIZt7VzICxX+863Qznu7wAzD?=
 =?us-ascii?Q?9/hWwSyAhjvV9lAQ0iLBtFdSJ37hhcRKSa/OTcBYQ6WHqXPOuga4pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WMVbkX2mP4yL08pMMmPu/kVndAwNpr3RTPkwBqPmrhD/jAa4V57iikJQA1Es?=
 =?us-ascii?Q?Gcbpvjn9BQbM91VtNf7/AlACQT1lptcB1E/iz/Y0FV4vHJgjun821d6M+fNJ?=
 =?us-ascii?Q?X+X8hXboSSkgNnoBvcnyUNqdHgvt2NL3Wr3/mU6zWDMkd6PWCmTdrcOa3vtM?=
 =?us-ascii?Q?T1wSNMjS/82sncXn6NX7dCfpBfCW2bjiKX+KJURHCtmMhDGXF6zH1X6MeApn?=
 =?us-ascii?Q?V6qcPkwr5/NDIQ4VcUOebln0uIVejp+tauifpQ9IThIoEe0ZG39bXfl9u8WO?=
 =?us-ascii?Q?3GfndUDX8NTGEM13LWBd3WW9exgXsQG0cUxDDeZVkCe73slTVb3KcdfzPOGe?=
 =?us-ascii?Q?A5TaL9pyMfNoGo25MUL7thcf6JDmQJIBmIMZYp/bDn+1oCCKcRRllo+edUky?=
 =?us-ascii?Q?Q/XU3cFAwt0fRXWWDBNoynggEI17Vn447Wk59BNZzAjqBh5kUsjYEuTiOLKm?=
 =?us-ascii?Q?2xbOYVCXln1ow3wnSEbMjNc1tf1ZnOmNxorIBf0vgKUKdexCTRxZFGetaOAi?=
 =?us-ascii?Q?g+lWDlFeyYCTuGBEQHKLoJedJ4bNZK8kK1vla1PB2QQbM3jT6/nsKebkAZCz?=
 =?us-ascii?Q?PRGZIXuoEIj85JR4+hssBwYMFK9ZtFkQVi79vU9IStt7CCxJZV8mWp3GmYz+?=
 =?us-ascii?Q?sHPwasBTOmJuBmpEE7q0vrxiNg+BOfc7VZ6uEttrrJxTBPAi2LKOQl+ryz4j?=
 =?us-ascii?Q?ZCglemM0N854ftw20812v+EW/XxBB8nrwN6MT3SInRsaQJnNWgrQEyErzfcM?=
 =?us-ascii?Q?+6yk4+gcVlSHkIwXWzGDPv/DzaMXzlHGe8ySNKZ3nTiTRVA8swZxsakBIh11?=
 =?us-ascii?Q?8uH8YOjN7BrAahYtOohaIUxGPAZBCBQENxNw/f4SHzej30CcikGLLc37I8ot?=
 =?us-ascii?Q?TIUaZ+smU+QyAWwQEWdpwW+B/HExYaQLDTXtt/LsDgt1+6BrttCOwsstNeAG?=
 =?us-ascii?Q?ME3sLIjzWJTrOUYJ0eDF59N7PY4UsDgznwSs2MSAgOe5+oFhYsAw3qBrtE35?=
 =?us-ascii?Q?gs1gqfGH//+eXo6KEUdruwzHdgWK5qwLUSczOrsELY74YrKNHTw/WCDBNiod?=
 =?us-ascii?Q?L5CvdBk2MK7MR0ZfOtrNiv2kroaL8hcnYWgsC/YcCj/jz69N3ojjQt6N3OeO?=
 =?us-ascii?Q?NsaQj1zUR3supxzEOt60bK9o2SxIwWGVU5F9sM2vHt6IDxhMpgJxdYYZhOPI?=
 =?us-ascii?Q?Ssn0btEZBw9ju2vyBlJE02AGli134L17SeIWW61Myt2f9ZC3QL0imSangiLq?=
 =?us-ascii?Q?8ieyDW4hLKsz/VRK+2AHuaQChZqFPRp3oN89sWsUe58gCpMEAheglU8uYggy?=
 =?us-ascii?Q?ifFWXlAvs03JiWxliaA9thgE+dOorj3LfMsRTIbJ06KrQuaYTWk7l97LOp1O?=
 =?us-ascii?Q?DIw4O4QPG/6eJR+UdiAxZMpEJm5sVg3mPY/oaSannSYPezlDhftU2Q+lCCFQ?=
 =?us-ascii?Q?Xoii2kfS3jTB0RdTbTKl/Qz/YNJ2b3xgv2f18Q/RzfY2+JFKLIgZchvmCZRW?=
 =?us-ascii?Q?eAskHYzkzdFf3GrtDWfUS+pbV0Brr64LKD8AOYY2FlJWC5WQzwlodX6tBhtM?=
 =?us-ascii?Q?hswM4AF2IaK1FcadQ8cDa0uJVT4qWwsBp9LmD37yGsE0xwXT0tYXAVvms1nA?=
 =?us-ascii?Q?yL79sVVf9kMX8bf4lT41ZbIrPrVxgp55SDM5AXPxZG/vhtx4WBOTeHXyI8WN?=
 =?us-ascii?Q?KWkjX8cG6ZGG3hTzAgAgB0jZb97btTE5DZU+GJUJnvNJwrY4sGJrbcbouRUl?=
 =?us-ascii?Q?IFzuJ2zobsdMQWsisMVcbmDCOE7YKr4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LyeJYuzlJQneREK5hbq0M5y8v1tzQHJJOpMwxz7L1InY+lLMJOh5bf7YBQD7Mn5jbkX7WcxgDabY23bIIW6AddV5aJog9ZRDWaUvf8dPNP5tQwv7EDOSbQM+EhgxXDCpigJKN9glWl3ICRgGry56/zrxw1fbOwRxU43Rk8i/FKKqNv3My77qHDGKlrk5ti7DvW7T1uSuiloOWKge++VfK1htyWnOIodrG/bwjKjIr72E5RYewJb7gAdJtb5h5L7clhnLmbo5ovW/DE1jdeyx9Q/ICoZOu3IKUUkQQ/KMM14r6dBw1u+9h9zrpsb6yCJABKWo7mmsj5qFynyd17rjCuVhxw0d58stRcGLTpzsnTYDb2Qa4nlh7fOBG0TA8+h35Dcz3guT+RDGM99ADDg0dpOscpB9240YdUhgbdOZD3BdIE0w8ekwNLol86oB3LO7sT3vx6qxXoLCqarAysm55enzLZ6vCpXdMrip1z3NKT93YBY3rWrcxQXn1Ku17geyJVlB6hkE4cyHcp54JzeOaO39w+ozsKSgCIRAI1kXmgomciZ2uwlSBCa5RkLUxrl+Ld5ehYRT9+bn50XuoYQY42h0xb1TwQOW9reSp4hW7HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6669e2df-e4de-4a41-46af-08de4d597981
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 19:26:22.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY7mg0FjlyoDSrRhuTVZ94ray80+rqwcWE70urwD+tjs88ny92GKpZanFYVOWM6DmfvnLbwknKKppQoAvSaY+IgwVCHDTRK9G5kVK6s858k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060168
X-Proofpoint-ORIG-GUID: RvWLKDgP5-DiD2iAfHGciheWCaKCuTuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE2NyBTYWx0ZWRfX1Pt7J+lmlFQS
 aG97q/KOZC7Saiyg+w5KjCmVT/tz+/z3Q9gF7i3P4RW5B7l5pgzaFxNJN7HO8mZVi7YbBPuB+j5
 XNILtnWFIzlr1HYgGpRkqhUln3LRLw3avQ4eO7F7poY6ksKPQJi6BRqZeD978/P4Iz3QQOtY983
 fgWjTsen/VjYkpSok/Rf8XpZljki7JSKs+LTPofj5RkAvlelQPTBaULrGjQjbftG5ZWaUuNO/EG
 Zwvxttu5BZx16IZYAGhC6qIR84NDLUsfaqPWs1OqjwBmKlUDTYwCoLP5/RwFPYEmLre+qJ0dHl/
 uAOssNaxM9X0qGgln8jGxi3+yB5wE9m+wy7xCfuF1G6FfTImb02Q/+cZQcn8tUk42+VP/11w1j4
 JGWgomHqesLRoKWYLXqKIpFBGtx9Y1wWUP5lawegvVw2ensmS7fZLMgi7WfZm3c4ExhP8zeSzRl
 bqHqXr8um111bTd6NNQ==
X-Proofpoint-GUID: RvWLKDgP5-DiD2iAfHGciheWCaKCuTuK
X-Authority-Analysis: v=2.4 cv=Y4z1cxeN c=1 sm=1 tr=0 ts=695d61e3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=K1192TvNGPq6cbv30xkA:9
 a=JwldTkq2j4ZXW0OM:21 a=CjuIK1q_8ugA:10

On Tue, Dec 23, 2025 at 10:40:37PM +0100, David Hildenbrand (Red Hat) wrote:
> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
> tables that it severely regresses some workloads.
>
> In particular, when we fork()+exit(), or when we munmap() a large
> area backed by many shared PMD tables, we perform one IPI broadcast per
> unshared PMD table.
>
> There are two optimizations to be had:
>
> (1) When we process (unshare) multiple such PMD tables, such as during
>     exit(), it is sufficient to send a single IPI broadcast (as long as
>     we respect locking rules) instead of one per PMD table.
>
>     Locking prevents that any of these PMD tables could get reused before
>     we drop the lock.
>
> (2) When we are not the last sharer (> 2 users including us), there is
>     no need to send the IPI broadcast. The shared PMD tables cannot
>     become exclusive (fully unshared) before an IPI will be broadcasted
>     by the last sharer.
>
>     Concurrent GUP-fast could walk into a PMD table just before we
>     unshared it. It could then succeed in grabbing a page from the
>     shared page table even after munmap() etc succeeded (and supressed
>     an IPI). But there is not difference compared to GUP-fast just
>     sleeping for a while after grabbing the page and re-enabling IRQs.
>
>     Most importantly, GUP-fast will never walk into page tables that are
>     no-longer shared, because the last sharer will issue an IPI
>     broadcast.
>
>     (if ever required, checking whether the PUD changed in GUP-fast
>      after grabbing the page like we do in the PTE case could handle
>      this)
>
> So let's rework PMD sharing TLB flushing + IPI sync to use the mmu_gather
> infrastructure so we can implement these optimizations and demystify the
> code at least a bit. Extend the mmu_gather infrastructure to be able to
> deal with our special hugetlb PMD table sharing implementation.
>
> To make initialization of the mmu_gather easier when working on a single
> VMA (in particular, when dealing with hugetlb), provide
> tlb_gather_mmu_vma().
>
> We'll consolidate the handling for (full) unsharing of PMD tables in
> tlb_unshare_pmd_ptdesc() and tlb_flush_unshared_tables(), and track
> in "struct mmu_gather" whether we had (full) unsharing of PMD tables.
>
> Because locking is very special (concurrent unsharing+reuse must be
> prevented), we disallow deferring flushing to tlb_finish_mmu() and instead
> require an explicit earlier call to tlb_flush_unshared_tables().
>
> From hugetlb code, we call huge_pmd_unshare_flush() where we make sure
> that the expected lock protecting us from concurrent unsharing+reuse is
> still held.
>
> Check with a VM_WARN_ON_ONCE() in tlb_finish_mmu() that
> tlb_flush_unshared_tables() was properly called earlier.
>
> Document it all properly.
>
> Notes about tlb_remove_table_sync_one() interaction with unsharing:
>
> There are two fairly tricky things:
>
> (1) tlb_remove_table_sync_one() is a NOP on architectures without
>     CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>     Here, the assumption is that the previous TLB flush would send an
>     IPI to all relevant CPUs. Careful: some architectures like x86 only
>     send IPIs to all relevant CPUs when tlb->freed_tables is set.
>
>     The relevant architectures should be selecting
>     MMU_GATHER_RCU_TABLE_FREE, but x86 might not do that in stable
>     kernels and it might have been problematic before this patch.
>
>     Also, the arch flushing behavior (independent of IPIs) is different
>     when tlb->freed_tables is set. Do we have to enlighten them to also
>     take care of tlb->unshared_tables? So far we didn't care, so
>     hopefully we are fine. Of course, we could be setting
>     tlb->freed_tables as well, but that might then unnecessarily flush
>     too much, because the semantics of tlb->freed_tables are a bit
>     fuzzy.
>
>     This patch changes nothing in this regard.
>
> (2) tlb_remove_table_sync_one() is not a NOP on architectures with
>     CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.
>
>     Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
>     we still issue IPIs during TLB flushes and don't actually need the
>     second tlb_remove_table_sync_one().
>
>     This optimized can be implemented on top of this, by checking e.g., in
>     tlb_remove_table_sync_one() whether we really need IPIs. But as
>     described in (1), it really must honor tlb->freed_tables then to
>     send IPIs to all relevant CPUs.
>
> Notes on TLB flushing changes:
>
> (1) Flushing for non-shared PMD tables
>
>     We're converting from flush_hugetlb_tlb_range() to
>     tlb_remove_huge_tlb_entry(). Given that we properly initialize the
>     MMU gather in tlb_gather_mmu_vma() to be hugetlb aware, similar to
>     __unmap_hugepage_range(), that should be fine.
>
> (2) Flushing for shared PMD tables
>
>     We're converting from various things (flush_hugetlb_tlb_range(),
>     tlb_flush_pmd_range(), flush_tlb_range()) to tlb_flush_pmd_range().
>
>     tlb_flush_pmd_range() achieves the same that
>     tlb_remove_huge_tlb_entry() would achieve in these scenarios.
>     Note that tlb_remove_huge_tlb_entry() also calls
>     __tlb_remove_tlb_entry(), however that is only implemented on
>     powerpc, which does not support PMD table sharing.
>
>     Similar to (1), tlb_gather_mmu_vma() should make sure that TLB
>     flushing keeps on working as expected.
>
> Further, note that the ptdesc_pmd_pts_dec() in huge_pmd_share() is not a
> concern, as we are holding the i_mmap_lock the whole time, preventing
> concurrent unsharing. That ptdesc_pmd_pts_dec() usage will be removed
> separately as a cleanup later.
>
> There are plenty more cleanups to be had, but they have to wait until
> this is fixed.
>
> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

OK with some local testing, ample use of git range-diff, this LGTM, hopefully no
horrifying weird arch strangeness in some other corner lurking to bite us :P

So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/asm-generic/tlb.h |  77 +++++++++++++++++++++++-
>  include/linux/hugetlb.h   |  15 +++--
>  include/linux/mm_types.h  |   1 +
>  mm/hugetlb.c              | 123 ++++++++++++++++++++++----------------
>  mm/mmu_gather.c           |  33 ++++++++++
>  mm/rmap.c                 |  25 +++++---
>  6 files changed, 208 insertions(+), 66 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 1fff717cae510..4d679d2a206b4 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -46,7 +46,8 @@
>   *
>   * The mmu_gather API consists of:
>   *
> - *  - tlb_gather_mmu() / tlb_gather_mmu_fullmm() / tlb_finish_mmu()
> + *  - tlb_gather_mmu() / tlb_gather_mmu_fullmm() / tlb_gather_mmu_vma() /
> + *    tlb_finish_mmu()
>   *
>   *    start and finish a mmu_gather
>   *
> @@ -364,6 +365,20 @@ struct mmu_gather {
>  	unsigned int		vma_huge : 1;
>  	unsigned int		vma_pfn  : 1;
>
> +	/*
> +	 * Did we unshare (unmap) any shared page tables? For now only
> +	 * used for hugetlb PMD table sharing.
> +	 */
> +	unsigned int		unshared_tables : 1;
> +
> +	/*
> +	 * Did we unshare any page tables such that they are now exclusive
> +	 * and could get reused+modified by the new owner? When setting this
> +	 * flag, "unshared_tables" will be set as well. For now only used
> +	 * for hugetlb PMD table sharing.
> +	 */
> +	unsigned int		fully_unshared_tables : 1;
> +
>  	unsigned int		batch_count;
>
>  #ifndef CONFIG_MMU_GATHER_NO_GATHER
> @@ -400,6 +415,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  	tlb->cleared_pmds = 0;
>  	tlb->cleared_puds = 0;
>  	tlb->cleared_p4ds = 0;
> +	tlb->unshared_tables = 0;
>  	/*
>  	 * Do not reset mmu_gather::vma_* fields here, we do not
>  	 * call into tlb_start_vma() again to set them if there is an
> @@ -484,7 +500,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  	 * these bits.
>  	 */
>  	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> -	      tlb->cleared_puds || tlb->cleared_p4ds))
> +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
>  		return;
>
>  	tlb_flush(tlb);
> @@ -773,6 +789,63 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
>  }
>  #endif
>
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +static inline void tlb_unshare_pmd_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt,
> +					  unsigned long addr)
> +{
> +	/*
> +	 * The caller must make sure that concurrent unsharing + exclusive
> +	 * reuse is impossible until tlb_flush_unshared_tables() was called.
> +	 */
> +	VM_WARN_ON_ONCE(!ptdesc_pmd_is_shared(pt));
> +	ptdesc_pmd_pts_dec(pt);
> +
> +	/* Clearing a PUD pointing at a PMD table with PMD leaves. */
> +	tlb_flush_pmd_range(tlb, addr & PUD_MASK, PUD_SIZE);
> +
> +	/*
> +	 * If the page table is now exclusively owned, we fully unshared
> +	 * a page table.
> +	 */
> +	if (!ptdesc_pmd_is_shared(pt))
> +		tlb->fully_unshared_tables = true;
> +	tlb->unshared_tables = true;
> +}
> +
> +static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
> +{
> +	/*
> +	 * As soon as the caller drops locks to allow for reuse of
> +	 * previously-shared tables, these tables could get modified and
> +	 * even reused outside of hugetlb context, so we have to make sure that
> +	 * any page table walkers (incl. TLB, GUP-fast) are aware of that
> +	 * change.
> +	 *
> +	 * Even if we are not fully unsharing a PMD table, we must
> +	 * flush the TLB for the unsharer now.
> +	 */
> +	if (tlb->unshared_tables)
> +		tlb_flush_mmu_tlbonly(tlb);
> +
> +	/*
> +	 * Similarly, we must make sure that concurrent GUP-fast will not
> +	 * walk previously-shared page tables that are getting modified+reused
> +	 * elsewhere. So broadcast an IPI to wait for any concurrent GUP-fast.
> +	 *
> +	 * We only perform this when we are the last sharer of a page table,
> +	 * as the IPI will reach all CPUs: any GUP-fast.
> +	 *
> +	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
> +	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
> +	 * required IPIs already for us.
> +	 */
> +	if (tlb->fully_unshared_tables) {
> +		tlb_remove_table_sync_one();
> +		tlb->fully_unshared_tables = false;
> +	}
> +}
> +#endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
> +
>  #endif /* CONFIG_MMU */
>
>  #endif /* _ASM_GENERIC__TLB_H */
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 03c8725efa289..e51b8ef0cebd9 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -240,8 +240,9 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  unsigned long hugetlb_mask_last_page(struct hstate *h);
> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -				unsigned long addr, pte_t *ptep);
> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep);
> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end);
>
> @@ -300,13 +301,17 @@ static inline struct address_space *hugetlb_folio_mapping_lock_write(
>  	return NULL;
>  }
>
> -static inline int huge_pmd_unshare(struct mm_struct *mm,
> -					struct vm_area_struct *vma,
> -					unsigned long addr, pte_t *ptep)
> +static inline int huge_pmd_unshare(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
>  	return 0;
>  }
>
> +static inline void huge_pmd_unshare_flush(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma)
> +{
> +}
> +
>  static inline void adjust_range_if_pmd_sharing_possible(
>  				struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 42af2292951d4..d1053b2c1f800 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1522,6 +1522,7 @@ static inline unsigned int mm_cid_size(void)
>  struct mmu_gather;
>  extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
>  extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
> +void tlb_gather_mmu_vma(struct mmu_gather *tlb, struct vm_area_struct *vma);
>  extern void tlb_finish_mmu(struct mmu_gather *tlb);
>
>  struct vm_fault;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c77cdef12a32..2609b6d58f99e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5096,7 +5096,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	unsigned long last_addr_mask;
>  	pte_t *src_pte, *dst_pte;
>  	struct mmu_notifier_range range;
> -	bool shared_pmd = false;
> +	struct mmu_gather tlb;
>
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, old_addr,
>  				old_end);
> @@ -5106,6 +5106,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	 * range.
>  	 */
>  	flush_cache_range(vma, range.start, range.end);
> +	tlb_gather_mmu_vma(&tlb, vma);
>
>  	mmu_notifier_invalidate_range_start(&range);
>  	last_addr_mask = hugetlb_mask_last_page(h);
> @@ -5122,8 +5123,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
>  			continue;
>
> -		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
> -			shared_pmd = true;
> +		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
>  			old_addr |= last_addr_mask;
>  			new_addr |= last_addr_mask;
>  			continue;
> @@ -5134,15 +5134,16 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  			break;
>
>  		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
> +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
>  	}
>
> -	if (shared_pmd)
> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -	else
> -		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
> +	tlb_flush_mmu_tlbonly(&tlb);
> +	huge_pmd_unshare_flush(&tlb, vma);
> +
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
>  	hugetlb_vma_unlock_write(vma);
> +	tlb_finish_mmu(&tlb);
>
>  	return len + old_addr - old_end;
>  }
> @@ -5161,7 +5162,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	unsigned long sz = huge_page_size(h);
>  	bool adjust_reservation;
>  	unsigned long last_addr_mask;
> -	bool force_flush = false;
>
>  	WARN_ON(!is_vm_hugetlb_page(vma));
>  	BUG_ON(start & ~huge_page_mask(h));
> @@ -5184,10 +5184,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		}
>
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (huge_pmd_unshare(tlb, vma, address, ptep)) {
>  			spin_unlock(ptl);
> -			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
> -			force_flush = true;
>  			address |= last_addr_mask;
>  			continue;
>  		}
> @@ -5303,14 +5301,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	}
>  	tlb_end_vma(tlb, vma);
>
> -	/*
> -	 * There is nothing protecting a previously-shared page table that we
> -	 * unshared through huge_pmd_unshare() from getting freed after we
> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> -	 * succeeded, flush the range corresponding to the pud.
> -	 */
> -	if (force_flush)
> -		tlb_flush_mmu_tlbonly(tlb);
> +	huge_pmd_unshare_flush(tlb, vma);
>  }
>
>  void __hugetlb_zap_begin(struct vm_area_struct *vma,
> @@ -6409,11 +6400,11 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  	pte_t pte;
>  	struct hstate *h = hstate_vma(vma);
>  	long pages = 0, psize = huge_page_size(h);
> -	bool shared_pmd = false;
>  	struct mmu_notifier_range range;
>  	unsigned long last_addr_mask;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	struct mmu_gather tlb;
>
>  	/*
>  	 * In the case of shared PMDs, the area to flush could be beyond
> @@ -6426,6 +6417,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>
>  	BUG_ON(address >= end);
>  	flush_cache_range(vma, range.start, range.end);
> +	tlb_gather_mmu_vma(&tlb, vma);
>
>  	mmu_notifier_invalidate_range_start(&range);
>  	hugetlb_vma_lock_write(vma);
> @@ -6452,7 +6444,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  			}
>  		}
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (huge_pmd_unshare(&tlb, vma, address, ptep)) {
>  			/*
>  			 * When uffd-wp is enabled on the vma, unshare
>  			 * shouldn't happen at all.  Warn about it if it
> @@ -6461,7 +6453,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
>  			pages++;
>  			spin_unlock(ptl);
> -			shared_pmd = true;
>  			address |= last_addr_mask;
>  			continue;
>  		}
> @@ -6522,22 +6513,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  				pte = huge_pte_clear_uffd_wp(pte);
>  			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>  			pages++;
> +			tlb_remove_huge_tlb_entry(h, &tlb, ptep, address);
>  		}
>
>  next:
>  		spin_unlock(ptl);
>  		cond_resched();
>  	}
> -	/*
> -	 * There is nothing protecting a previously-shared page table that we
> -	 * unshared through huge_pmd_unshare() from getting freed after we
> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> -	 * succeeded, flush the range corresponding to the pud.
> -	 */
> -	if (shared_pmd)
> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -	else
> -		flush_hugetlb_tlb_range(vma, start, end);
> +
> +	tlb_flush_mmu_tlbonly(&tlb);
> +	huge_pmd_unshare_flush(&tlb, vma);
>  	/*
>  	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs() we are
>  	 * downgrading page table protection not changing it to point to a new
> @@ -6548,6 +6533,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  	i_mmap_unlock_write(vma->vm_file->f_mapping);
>  	hugetlb_vma_unlock_write(vma);
>  	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);
>
>  	return pages > 0 ? (pages << h->order) : pages;
>  }
> @@ -6904,18 +6890,27 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return pte;
>  }
>
> -/*
> - * unmap huge page backed by shared pte.
> +/**
> + * huge_pmd_unshare - Unmap a pmd table if it is shared by multiple users
> + * @tlb: the current mmu_gather.
> + * @vma: the vma covering the pmd table.
> + * @addr: the address we are trying to unshare.
> + * @ptep: pointer into the (pmd) page table.
> + *
> + * Called with the page table lock held, the i_mmap_rwsem held in write mode
> + * and the hugetlb vma lock held in write mode.
>   *
> - * Called with page table lock held.
> + * Note: The caller must call huge_pmd_unshare_flush() before dropping the
> + * i_mmap_rwsem.
>   *
> - * returns: 1 successfully unmapped a shared pte page
> - *	    0 the underlying pte page is not shared, or it is the last user
> + * Returns: 1 if it was a shared PMD table and it got unmapped, or 0 if it
> + *	    was not a shared PMD table.
>   */
> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -					unsigned long addr, pte_t *ptep)
> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep)
>  {
>  	unsigned long sz = huge_page_size(hstate_vma(vma));
> +	struct mm_struct *mm = vma->vm_mm;
>  	pgd_t *pgd = pgd_offset(mm, addr);
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	pud_t *pud = pud_offset(p4d, addr);
> @@ -6927,18 +6922,36 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>  	hugetlb_vma_assert_locked(vma);
>  	pud_clear(pud);
> -	/*
> -	 * Once our caller drops the rmap lock, some other process might be
> -	 * using this page table as a normal, non-hugetlb page table.
> -	 * Wait for pending gup_fast() in other threads to finish before letting
> -	 * that happen.
> -	 */
> -	tlb_remove_table_sync_one();
> -	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
> +
> +	tlb_unshare_pmd_ptdesc(tlb, virt_to_ptdesc(ptep), addr);
> +
>  	mm_dec_nr_pmds(mm);
>  	return 1;
>  }
>
> +/*
> + * huge_pmd_unshare_flush - Complete a sequence of huge_pmd_unshare() calls
> + * @tlb: the current mmu_gather.
> + * @vma: the vma covering the pmd table.
> + *
> + * Perform necessary TLB flushes or IPI broadcasts to synchronize PMD table
> + * unsharing with concurrent page table walkers.
> + *
> + * This function must be called after a sequence of huge_pmd_unshare()
> + * calls while still holding the i_mmap_rwsem.
> + */
> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
> +{
> +	/*
> +	 * We must synchronize page table unsharing such that nobody will
> +	 * try reusing a previously-shared page table while it might still
> +	 * be in use by previous sharers (TLB, GUP_fast).
> +	 */
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +
> +	tlb_flush_unshared_tables(tlb);
> +}
> +
>  #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
>
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> @@ -6947,12 +6960,16 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return NULL;
>  }
>
> -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -				unsigned long addr, pte_t *ptep)
> +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep)
>  {
>  	return 0;
>  }
>
> +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
> +{
> +}
> +
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
> @@ -7219,6 +7236,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	unsigned long sz = huge_page_size(h);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
>  	unsigned long address;
>  	spinlock_t *ptl;
>  	pte_t *ptep;
> @@ -7230,6 +7248,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		return;
>
>  	flush_cache_range(vma, start, end);
> +	tlb_gather_mmu_vma(&tlb, vma);
> +
>  	/*
>  	 * No need to call adjust_range_if_pmd_sharing_possible(), because
>  	 * we have already done the PUD_SIZE alignment.
> @@ -7248,10 +7268,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		if (!ptep)
>  			continue;
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		huge_pmd_unshare(mm, vma, address, ptep);
> +		huge_pmd_unshare(&tlb, vma, address, ptep);
>  		spin_unlock(ptl);
>  	}
> -	flush_hugetlb_tlb_range(vma, start, end);
> +	huge_pmd_unshare_flush(&tlb, vma);
>  	if (take_locks) {
>  		i_mmap_unlock_write(vma->vm_file->f_mapping);
>  		hugetlb_vma_unlock_write(vma);
> @@ -7261,6 +7281,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	 * Documentation/mm/mmu_notifier.rst.
>  	 */
>  	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);
>  }
>
>  /*
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 247e3f9db6c7a..cd32c2dbf501b 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -10,6 +10,7 @@
>  #include <linux/swap.h>
>  #include <linux/rmap.h>
>  #include <linux/pgalloc.h>
> +#include <linux/hugetlb.h>
>
>  #include <asm/tlb.h>
>
> @@ -426,6 +427,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  #endif
>  	tlb->vma_pfn = 0;
>
> +	tlb->fully_unshared_tables = 0;
>  	__tlb_reset_range(tlb);
>  	inc_tlb_flush_pending(tlb->mm);
>  }
> @@ -459,6 +461,31 @@ void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
>  	__tlb_gather_mmu(tlb, mm, true);
>  }
>
> +/**
> + * tlb_gather_mmu - initialize an mmu_gather structure for operating on a single
> + *		    VMA
> + * @tlb: the mmu_gather structure to initialize
> + * @vma: the vm_area_struct
> + *
> + * Called to initialize an (on-stack) mmu_gather structure for operating on
> + * a single VMA. In contrast to tlb_gather_mmu(), calling this function will
> + * not require another call to tlb_start_vma(). In contrast to tlb_start_vma(),
> + * this function will *not* call flush_cache_range().
> + *
> + * For hugetlb VMAs, this function will also initialize the mmu_gather
> + * page_size accordingly, not requiring a separate call to
> + * tlb_change_page_size().
> + *
> + */
> +void tlb_gather_mmu_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> +{
> +	tlb_gather_mmu(tlb, vma->vm_mm);
> +	tlb_update_vma_flags(tlb, vma);
> +	if (is_vm_hugetlb_page(vma))
> +		/* All entries have the same size. */
> +		tlb_change_page_size(tlb, huge_page_size(hstate_vma(vma)));
> +}
> +
>  /**
>   * tlb_finish_mmu - finish an mmu_gather structure
>   * @tlb: the mmu_gather structure to finish
> @@ -468,6 +495,12 @@ void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
>   */
>  void tlb_finish_mmu(struct mmu_gather *tlb)
>  {
> +	/*
> +	 * We expect an earlier huge_pmd_unshare_flush() call to sort this out,
> +	 * due to complicated locking requirements with page table unsharing.
> +	 */
> +	VM_WARN_ON_ONCE(tlb->fully_unshared_tables);
> +
>  	/*
>  	 * If there are parallel threads are doing PTE changes on same range
>  	 * under non-exclusive lock (e.g., mmap_lock read-side) but defer TLB
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 748f48727a162..7b9879ef442d9 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -76,7 +76,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/oom.h>
>
> -#include <asm/tlbflush.h>
> +#include <asm/tlb.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/migrate.h>
> @@ -2008,13 +2008,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * if unsuccessful.
>  			 */
>  			if (!anon) {
> +				struct mmu_gather tlb;
> +
>  				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>  				if (!hugetlb_vma_trylock_write(vma))
>  					goto walk_abort;
> -				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> +
> +				tlb_gather_mmu_vma(&tlb, vma);
> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>  					hugetlb_vma_unlock_write(vma);
> -					flush_tlb_range(vma,
> -						range.start, range.end);
> +					huge_pmd_unshare_flush(&tlb, vma);
> +					tlb_finish_mmu(&tlb);
>  					/*
>  					 * The PMD table was unmapped,
>  					 * consequently unmapping the folio.
> @@ -2022,6 +2026,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  					goto walk_done;
>  				}
>  				hugetlb_vma_unlock_write(vma);
> +				tlb_finish_mmu(&tlb);
>  			}
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>  			if (pte_dirty(pteval))
> @@ -2398,17 +2403,20 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * fail if unsuccessful.
>  			 */
>  			if (!anon) {
> +				struct mmu_gather tlb;
> +
>  				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>  				if (!hugetlb_vma_trylock_write(vma)) {
>  					page_vma_mapped_walk_done(&pvmw);
>  					ret = false;
>  					break;
>  				}
> -				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> -					hugetlb_vma_unlock_write(vma);
> -					flush_tlb_range(vma,
> -						range.start, range.end);
>
> +				tlb_gather_mmu_vma(&tlb, vma);
> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
> +					hugetlb_vma_unlock_write(vma);
> +					huge_pmd_unshare_flush(&tlb, vma);
> +					tlb_finish_mmu(&tlb);
>  					/*
>  					 * The PMD table was unmapped,
>  					 * consequently unmapping the folio.
> @@ -2417,6 +2425,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  					break;
>  				}
>  				hugetlb_vma_unlock_write(vma);
> +				tlb_finish_mmu(&tlb);
>  			}
>  			/* Nuke the hugetlb page table entry */
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
> --
> 2.52.0
>

