Return-Path: <linux-arch+bounces-12960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1542B1284F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 02:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FF84E2086
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596AE19005E;
	Sat, 26 Jul 2025 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eaZwNbFQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="udd1upee"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50204188A3A;
	Sat, 26 Jul 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491519; cv=fail; b=n+nJrJnBJVu3dHYX0v50Z+KqdJxcoTms5MUUF5yencPN8+yHpA1RNU8hWHBBanV262+NKWrHZ1PbaM7IaRKz2thAxBUbp+aMMZAmdoYsUOZpTQzOGrPz64lE5eiQCJXvO8OLkBduUtmcC9ACdwSX142WbfT6WrKfzOBA7Y1uOfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491519; c=relaxed/simple;
	bh=QhanFUARNM5bIQxeu27TM/R8UnQ93NxYk7NOx8AupRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NE4yZfk7UT9NobxG7++ijpc7Dg5UlcTeJTGl6BQcVCBp6GH7jfzomoj/mcsdMFeghU2x43k4JHw0sdcKkBVYxhcTjv4ZaylbfpOwU10MUJ7jre2vD88p2WJ5o/JrOeBQXU0WDyu6UENx+q6rEnAl274y/s7VRQ56lZHVDftUGSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eaZwNbFQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=udd1upee; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q0TI1W002526;
	Sat, 26 Jul 2025 00:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1J6wqhpAoARWD3NW4j
	yzwNM5ju8vKM7GGZan6l2hwZE=; b=eaZwNbFQjggUND0R7B7o5gl1hqAWtOhP8y
	EvXqsNZ5Qtaq25DjCYxFv3Ct4IxtWilyDIt6ffLYdam6Qqq6iQreKYdAVqfp+gvQ
	4EZwOI6lqaaPCjLPd0DRhbqGTebBGNv7mnraTaDZgrCP08ZwtLqCbWPHh6KNEzK+
	6OQwXrEvJdBwmVq3oDJ9S46/DQzSf8/jO/kM2EtDkeYnhTlPHrAUJ8J5q8U+/AVV
	1oS12h6XoZnT3gHx6ckwok8X8civbkamXXUaFbl+wk3JEzCObESSp3MQrLrfAnyo
	1hg5Owh4cYmHoDAtAdTj9fHWRWCuD469qJYEMgS63GH4fDifewwg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484mh3g1h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 00:56:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PMtv2M005895;
	Sat, 26 Jul 2025 00:56:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdpdy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 00:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSX3TO/HIfibz6ogNp1gE0b6F6cI11SgstAux2c9R7+/WVc/fGut9uhiJYDG6oAeWBeIGdFamHMv5eeOC8shS0ZhRTz90lL4Dghq0nLJAt9DNex6oGUEtFx0CTLNJzLlZxx9kXUydjXyVTAmCHHzWBNzij0DJe9Z2Q0XaSibVuEHdegHaoOUeL/Ci7RQgpjeC7s2AamEE9FchVxPqsfZkfpFGxXac3fcBkvhAvB0DCzU3OoUpuzC5DiWv6LEE26SJufXm2pCxROkBiTFYZmFvUeYc0LA3E1wLDv/nYBGzUbLCBsFEy1phyMZXqcKsLVjAxf3OxPIb++MrORwvrwV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J6wqhpAoARWD3NW4jyzwNM5ju8vKM7GGZan6l2hwZE=;
 b=GZDkqAUc33Cf4GgRXZHWM56OnQArsB2dQEyVMQ2mc7V9OTyIL5QAS+NgNQhKdXPqEShLxWFTZTZMGabru9Jn2JY7tfsr0UHiOu7R3a8dqEbaqQUpmWADN5DRimPPWB+53eXZR7PWPeexDeW8h8iu/2f5DC/LgnSLkerMI77/qYNHifD6m7FDlJ1dmw8DUpPEXLYlazub8Qxq6df8MunZdskp/pj3SklylDE7esapcxZcSEKxN1iDxJ4pvCkQFrp1nRFfiMxqgPNegIGvNdoGZSCrelCKnQan23STorbsfXiKaLlJuEnipkpre6ZgsE9cl4nDAWvjF/oc5bLlCsjQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J6wqhpAoARWD3NW4jyzwNM5ju8vKM7GGZan6l2hwZE=;
 b=udd1upeeWXnFTRa2Pko2c8TRQq91U0H0RDuleKPnAjKNU2hl7MpT3SFK0GtPLAo90yTuOUlzc7NWDmU46BVZYcxto/GXrveyRoZNrLQnCbd0ncyRn6iRdBiyQvSLefqUm6o+iHahMJIJUZPx+oRPjq20R//Q2Y71SqD3+9py/s0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7557.namprd10.prod.outlook.com (2603:10b6:a03:538::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Sat, 26 Jul
 2025 00:56:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Sat, 26 Jul 2025
 00:56:45 +0000
Date: Sat, 26 Jul 2025 09:56:28 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zyccr.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
        Dev Jain <dev.jain@arm.com>, Bibo Mao <maobibo@loongson.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 mm-hotfixes 0/5] mm, arch: a more robust approach to
 sync top level kernel page tables
Message-ID: <aIQnvFTkQGieHfEh@hyeyoo>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
 <20250725165101.e636bbe3fa69ad0b73810914@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725165101.e636bbe3fa69ad0b73810914@linux-foundation.org>
X-ClientProxiedBy: SL2P216CA0207.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a0e04b-d342-40c9-c743-08ddcbdf4ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvJhHfkfD6UHJa0pC3QoXH08VICUme3YmAjU1Rbewr29qK3/xocZoQyn4oJu?=
 =?us-ascii?Q?eAA6FhBPWiTnVJknxxdLCqf+iwaD1VpRQfm+BUpb0saMdPqd3ZDLbFN4t4/i?=
 =?us-ascii?Q?932zbCbNDwyOrc5/zMate7lJ4hQ1S+e+4mMnskDEiBkXYWwOtY0XsW6O9nP/?=
 =?us-ascii?Q?uyHE0GHghD2uRco+GeH/B2F3VsSHGjWZgMPRsVj+ggfY2KWccW32gAST3A4y?=
 =?us-ascii?Q?mbg/P1B7WNCIhbn/5A2Mes15H4HOEi7FZ7FHucG/GQ+Yahux/4GAk8vhRcQi?=
 =?us-ascii?Q?9R4FiFahiWMRihgCyYqhN+JbP74G7FLE7aKEayJiXN9pya2H03VKeAuBMMFm?=
 =?us-ascii?Q?w8jNqcyjjA9k8bcZ6beqfv5ZIWnR4VrVgUtTKsBWhNfOGJC7kZdrLkJmUgL2?=
 =?us-ascii?Q?ziSR2di8ioIpMBiZ+oVYu+q/O1hRN44819vLDPaKXIpDiFDoszLv/HdGZft5?=
 =?us-ascii?Q?aDlqcNt2T/phQNWmFGLLchTT9mMZjgIYN1K7hD/5Q2yS5ca3wefnQaGe3eTb?=
 =?us-ascii?Q?6LSO5VHVyRGGZCYpfRiG/CVfCijB88Or2rSnAbG1U4V0uvnjHVuKS9dbDRVv?=
 =?us-ascii?Q?HrnO6vYwrggl7ZxryO6Cx68CZb+bfBJ/2M5ET3Emia63E5B1nCUIhnUA5tzJ?=
 =?us-ascii?Q?DGhba3AXSOQI9vPsc/rvbwLLQSJ4KYdUHOQqYAmh006Rv35/4QDZpYiGzREu?=
 =?us-ascii?Q?YYTgruWbPbwzs4o6/1/ZXyjn25CmH2aaF00RIeW3djHr2AWzO9ZkXDU52SCG?=
 =?us-ascii?Q?QNWRDRAZZIy1dW7IZy/iuU/U+UXisrYgG2dLBA86yAoN/3jP3wJaJOGyC24R?=
 =?us-ascii?Q?pAPXbfljlaZ9dg7lOIcCsuftJdgtspWg2SyiSAbeuzvL/XwVOJ3UyVoIhRaz?=
 =?us-ascii?Q?jQadi0XepGbrbTFtnahd/d4IWpjzjM3hSV3Z0AUAEHlQx70MVYF1rsZsmLkw?=
 =?us-ascii?Q?w3KPgAWkLurwrW4av1sM111+Y5+BY3Ki2rzZstssEEs/P7CeOIM2SQ0QOFA8?=
 =?us-ascii?Q?Ww5lTYlWyJ/btNEyAKhPzE+5lVWruc3E8GKc548LvvLQ62WJi1j/p46EYHdi?=
 =?us-ascii?Q?rwRJHn0q5ZjSllw53V4Erudl683gCHK+oTZnXSHKnSDRdCp54nsxC0X+AF67?=
 =?us-ascii?Q?nja0y8df3yXTvclYKtVj+Io49/WT5q9Z8AfwgWz6CA4Vxu2NLREAeX7ZIWHQ?=
 =?us-ascii?Q?/B5RRNsDedIXsjgbOtdadFZwSOvbOXwPS+xJSVLwA7ohpP5KpT9MSD68O5jC?=
 =?us-ascii?Q?5I2BSU7h/pw0myGgljRTLcAbA4+etnyFmKM3Pz6NLqxgvJEvOmK0AKgnpVlz?=
 =?us-ascii?Q?aJtmmesCJAhvnJu7s5bCq3k6IqBeuYUgFruSESefXeAzjurWfQ22kMOhWeLS?=
 =?us-ascii?Q?n27Vc3r6IkScL53jvbpHhohf+y7ZQtYt1U84fR7bCkb+Zt5CK2ovWVsg6G9S?=
 =?us-ascii?Q?BeiEQ5Icxcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ff7sM7aVpoXaRjVdkn038s8Te9swBiE1QWU1x3RIlEhONDMpZ6EbZs96scMF?=
 =?us-ascii?Q?3jQjNtH0gyUg3k0cFQBhAlQirgtU3HI+iqiSNdxtgAzx+X2H96PSfVcFMCYz?=
 =?us-ascii?Q?NJITYpyYnUT8DwnkyBdA046y+beBwqWnk/2H2xOpAyS9GQOrdUEIRK51MoRa?=
 =?us-ascii?Q?TmqKfWQsXisCnTBbCxUh0RmQo9Sx2rFIEAA5CcyVMCVJUcv5esmD3eQgJcte?=
 =?us-ascii?Q?WDaEgsvMAVTL1cnP4JtTc9zip5eQyORfQMBTOIhWfb7SXgjfAxrbYe+m42p/?=
 =?us-ascii?Q?KFknPLI7o5jYiItOJFQYTjR/pQfgFRxcS3WdJFpMTEegCZndkVHl5leHZaUr?=
 =?us-ascii?Q?o+PHrHKcfuasRfwB6nc0CUdQ6R9qlnvhpB1OSWrlabzKONzGgg7FtZXBvz/b?=
 =?us-ascii?Q?hm5tonxyd5fALAwtT94zqJxyDenw4AZOZkSYwC8H+lUuo0ddj0PDz/q0lkbI?=
 =?us-ascii?Q?xdwgJZHs0ue6wDWMYhA7RRrh9lOeHintOsZwQPPyVa8gbpbeULTuf7tXVXKS?=
 =?us-ascii?Q?qnut1oc2gVyMGAP4AcjTAGGVkzcTIJ2wIfE0d2mECMzILqQ9kG1V60ldB2o0?=
 =?us-ascii?Q?zZ5Dj7j3e0L1OX31KV5KM97SbF+2lfK8J+Mcrwf8lks8OhH9jkgytJqOi2J5?=
 =?us-ascii?Q?QP9Ti36WcZdCBozyemc4dLstKNyOZyJ16ltNN1OQBd762LhY/JeUGAAAP5xm?=
 =?us-ascii?Q?n4S8WzBzWY06nK0JFkGl6Z4YAP9Jv5E6fldi0KhgVV5ZrETWViephIGghPH4?=
 =?us-ascii?Q?mWQxd3U3XymXS/tNN7LF9SJgpzEMApZBtsoCi8j3Lj1sbLqLRyryk2whrVWT?=
 =?us-ascii?Q?QFmfomTdq2QslL28PiVkZzVCmJm2MGdQQd9C78jTjfMAK5dqQZoVTNYOF6fV?=
 =?us-ascii?Q?AflcumFKoaxOTrqLI5Ua0XDtoqZ9iC58AgdjcQovNc7T4X4e5BiwGEmQfjeu?=
 =?us-ascii?Q?kwECGZUbDWN9oKe01dgHeNaBnJWi8EHGadkhC6kZAx3Il9nOEC8MMaIjPw/D?=
 =?us-ascii?Q?Wb2xCq2Wb33iRcZ+UPjnySM50Pg5dvpZ8+BanngdrDfrgzzmEGTOQcy6u4XX?=
 =?us-ascii?Q?RECUE1+bZVmg5LAqkpDQ1ph1zqbIZsMuroWDHra6hFeZITQeyzKtdVWaFME1?=
 =?us-ascii?Q?VsIEgnz+wCRIP4MQzJTDMT4gyAJoLltlwiq+dOxn5P/7xBf+R+1F/ewg8kLP?=
 =?us-ascii?Q?uyurjRpJbfSXmo+MEWChGHmHEbpph+SAJSIQhLZtt5yCbYcgHRmVuQSRCWAg?=
 =?us-ascii?Q?03QDGXJ/jfWJX6LbrJ8QC75LB6OJUlW2xIpm+vaLKkBsh6yiRBuqlZ6Uk506?=
 =?us-ascii?Q?TXDdbhSmHqDUccAPaACG2aDZWhCP7OafBORYiOF4nfk3jfnARoX+kabxDrb1?=
 =?us-ascii?Q?Jw8W+ZSydYYQ3UYqbY7osSmeEg385mt3HkTTX8CB7hgvDA4In/GJdivoca+d?=
 =?us-ascii?Q?pSf33W4KoTyvZjk1HvKrY3ruieYiTx8M0seKOul7jMwz8cJ4DaBYR9mixlXl?=
 =?us-ascii?Q?HGn3qEVLwMhOfnvITeo2TgrP6Z3OyR5uVO+DaGXJT72g7Piag223Saf8ShmZ?=
 =?us-ascii?Q?wEEtRP781gJ6LDpNkvZLF9n1M03i8wgbcCF+u7yA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mPj6VMVyws//kLWEeAEK/VbfBANQstpp5e6DteQak18627QsEqMpNL8E/ZSmgbD3rW1B2dmWBoxkL9nnIAv+ggrpINanPlziqdG9JDMCMuASkdRmrdnIyWI/xaJE5bmbFHkBrPFlmy51/j2kAlHO0K1BnLXYEQA9FNiHEapHhG/JIEARNt64y+QJC1dxviizgSRgNlmJmEBafVGlNTZhsNU2f61SsRIDQT7jonAeAn2FeXtLXjDVBfWMUfTIc7+8/C2DhwSXIB5b9R9DH3OgLk57ANcGknMdFI0wduOIaZsQ8g0R3wpYIGl2HkmvBnCrQHrCAYKqzPFywSs2jsaZ9niCrA1OIMiuN97gmeI574qXOMIAQhZWQerR35GUOum/6I10wxWIDW/JvdsSgfFjPtxNCwCSCvYssSAWJcvC3qXNAbxmr8X9AtKofjBAm+5zvSHXuDPqUlQOXtiR4OZm5hq4SVlvQloBwNFu0lnVUI8aSU/aQ1UQQhLOovzJ9GewbbIf/VvrgVen0vO+TXgSShZdlNjdD+klpvtW7zdbC+5z0vDilZec1CBT8TqoSx7hAGcjpt7R7vPf/zzQQnFP5Gt7X90O1Op6fl4V1JCg7tY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a0e04b-d342-40c9-c743-08ddcbdf4ab6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 00:56:44.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgX9PdUwWfTW8Uo+7Sdwl2lJWHCI07eJUtfl0lugtf7oNx2Pb5mFgfcw2jY4U93Ozzfqj6ZP0UUfed4HxoySww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507260004
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDAwNSBTYWx0ZWRfX+1v7phBq5sXm
 TUonn2CmS0Lu1ZqeNgO0Zy4DEtNHWuPSsBYznqtsHeJUOXkbDNhAwbpgWrzUrgcrk9ctIiiQhlF
 EzpJuWRpPVE7nMmAocspycggCBqn69j0s242hSY6jWm+4mJkyvSpZhQVk9oXTuqKF1yiPGZWog9
 vffwe9/2IuOJnkpZAmaAzRp2PNX9y8AhbHu94xYqkLMmstZPClixiJGDNQPRVDn/faZMoeud4AD
 sCKjsFdWshICM1/8fi2lgZMDGb1XQm1jG2YAx0khquFX1/49ToUl+Bi96eE1DAvWAm5iB2hLgu5
 gOwWXb1Wb2bJX4HRA9+Mi7iBUCwwxH7a7nuABHke0Rm+DWiG+RpJvEWDa7nGMYdWdfZ/ItBIfpw
 R5cYN7gb4131Nhj2dSyqQTDewzkh2eTxaSsh4yr2LcL7UWrNlvuBncMFMK7i6S5FH0W93mUd
X-Authority-Analysis: v=2.4 cv=CYsI5Krl c=1 sm=1 tr=0 ts=688427d2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=D3B9rt9QCh3B1xK0abIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1riox9nFfFXQwd7lNzf0K0m5ClYpDT8Q
X-Proofpoint-ORIG-GUID: 1riox9nFfFXQwd7lNzf0K0m5ClYpDT8Q

On Fri, Jul 25, 2025 at 04:51:01PM -0700, Andrew Morton wrote:
> On Fri, 25 Jul 2025 10:21:01 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:
> 
> > During our internal testing, we started observing intermittent boot
> > failures when the machine uses 4-level paging and has a large amount
> > of persistent memory:
> > 
> >   BUG: unable to handle page fault for address: ffffe70000000034
> >   #PF: supervisor write access in kernel mode
> >   #PF: error_code(0x0002) - not-present page
> >   PGD 0 P4D 0 
> >   Oops: 0002 [#1] SMP NOPTI
> >   RIP: 0010:__init_single_page+0x9/0x6d
> >   Call Trace:
> >    <TASK>
> >    __init_zone_device_page+0x17/0x5d
> >    memmap_init_zone_device+0x154/0x1bb
> >    pagemap_range+0x2e0/0x40f
> >    memremap_pages+0x10b/0x2f0
> >    devm_memremap_pages+0x1e/0x60
> >    dev_dax_probe+0xce/0x2ec [device_dax]
> >    dax_bus_probe+0x6d/0xc9
> >    [... snip ...]
> >    </TASK>
> > 
> > ...
> >
> >  arch/x86/include/asm/pgalloc.h          | 20 +++++++++++++
> >  arch/x86/include/asm/pgtable_64_types.h |  3 ++
> >  arch/x86/mm/init_64.c                   | 37 ++++++++++++++-----------
> >  arch/x86/mm/kasan_init_64.c             |  8 +++---
> >  include/asm-generic/pgalloc.h           | 16 +++++++++++
> >  include/linux/pgtable.h                 | 17 ++++++++++++
> >  include/linux/vmalloc.h                 | 16 -----------
> >  mm/kasan/init.c                         | 10 +++----
> >  mm/percpu.c                             |  4 +--
> >  mm/sparse-vmemmap.c                     |  4 +--
> >  10 files changed, 90 insertions(+), 45 deletions(-)
> 
> Are any other architectures likely to be affected by this flaw?

In theory, any architecture that does not share a kernel page table between
tasks can be affected if they forgot to sync page tables properly.
e.g., arm64 uses a single page table for kernel address space which
is shared between tasks, so it should not be affected.

But I'm not aware of any other architectures that are _actually_ known to
have this flaw. Even on x86, it was quite hard to trigger without
hot-plugging a large amount of memory. But if it turns out other
architectures are affected, they can be fixed later in the same way as
x86-64.

> It's late for 6.16.  I'd propose that this series target 6.17 and once
> merged, the cc:stable tags will take care of 6.16.x and earlier.

Yes. It's quite late and that makes sense.

> It's regrettable that the series contains some patches which are
> cc:stable and some which are not.  Because 6.16.x and earlier will end
> up getting only some of these patches, so we're backporting an untested
> patch combination.  It would be better to prepare all this as two
> series: one for backporting and the other not.

Yes, that makes sense and I'll post it as two series (one for backporting
and the other not for backporting but as a follow-up) unless someone
speaks up and argues that it should be backported as a whole.

> It's awkward that some of the cc:stable patches have a Fixes: and
> others do not.  Exactly which kernel version(s) are we asking the
> -stable maintainers to merge these patches into?

I thought technically patch 1 and 2 are not fixing any bugs but they
are prequisites of patch 3. But I think you're right that it only
confuses -stable maintainers. I'll add Fixes: tags (the same one as
patch 3) to patch 1 and 2 in future revisions.

> This looks somewhat more like an x86 series than an MM one.  I can take
> it via mm.git with suitable x86 acks.  Or drop it from mm.git if it
> goes into the x86 tree.  We can discuss that.

It touches both x86/mm and general mm code so I was unsure which tree
is the right one :) I don't have a strong opinion and I'm fine with both.
Let's wait to hear opinions from the x86/mm maintainers.

> For now, I'll add this to mm.git's mm-new branch.  There it will get a
> bit of exposure but it will be withheld from linux-next.  Once 6.17-rc1
> is released I can move this into mm.git's mm-unstable branch to expose
> it to linux-next testers.
> 
> Thanks.  I'll suppress the usual added-to-mm emails, save a few electrons.

Yeah, the Cc list got quite long since it touches many files..

Thanks a lot, Andrew!

-- 
Cheers,
Harry / Hyeonggon

