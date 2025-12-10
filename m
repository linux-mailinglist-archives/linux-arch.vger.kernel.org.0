Return-Path: <linux-arch+bounces-15326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E7CB3416
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 16:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C8E230074A2
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54418273F9;
	Wed, 10 Dec 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D2QgumN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xLT6obZt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935D280336;
	Wed, 10 Dec 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379229; cv=fail; b=YFTcNpGTufGdosc6Heg3TCKDaogEXOxs5ElpivLhcY9mk4UGrGoSCBZyusFPyJoSF0jKbnD6hgztK42d3NITTBOLYV2vSKIFjMmuRpaVMq/APwFt0xzFydz6z34uLy5sSBkUjXgyzEoU99qqSr5SkSzc77KDnLR47qXEBbOXYxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379229; c=relaxed/simple;
	bh=Tet+2rToPvTf8LsfHeeu+uWfTbXWBleaBjmN4UC7VTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fEclTVrvYzgzZmdPwg8QkH3h8U+gWIj4Ex3B9M2Dw9Y2fEa4xbg4pLfAt4+8dI5xGJkQXQBiRKJdTjxC6Thcw1J0WYxnau8WpyLjjKRe5zaWi64XwA4exTvSiCDcZ9XFatgZk/gqfrFr4VqPEjMUL7gtBNkmhlwnWS8sGm2ueAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D2QgumN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xLT6obZt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAEun9Q3259231;
	Wed, 10 Dec 2025 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HB85DQhoLhaLkvguwk
	INl0UhGJJWv8Tv+wjwl7aTbVI=; b=D2QgumN1lYPkS30x9vJZqlTY9/4vgiiT7+
	sboFnGDwsgs/Ujck/tZx4430DDecP+oMV/SEdKS0hPNuzASgJwnKBbcaEt7NlAFw
	cRcF9/olmAIn7yZ3kme7Q1nxgm6iUUkO/N2g4w/EegIDQ+kASbQPEAtb0uLse7E4
	NPwKFSlE0+DriwTRVUHc4La65Z2cwdSz1dynYwnTUGTDwsvLYDpdBq8ZhuZmeiyf
	Uu2lI7WHrXHcKcKyOavSRJUAIKop+YoyWnM0pOA+KmHavcXgUu3bQ+9rPWkPKKMl
	Zqc1Moyi5Vr/JCKABKZV3ZVjrHqyr47Mr341Ix3guWnOsk+zwRlw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayb2s00gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:06:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAEo0ox040616;
	Wed, 10 Dec 2025 15:06:33 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxedg8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWwEgnXtSY09OVf46CXjad7kNT5/bp45TOd9VSt6EqsqgegkkEDtI7izwaxN5tp46//YTwNsL88GibbwuSmEvPee5gp0PwVXcMqqhTfz73xbl1thsGyQxCbHtIiut3Ijdqr7It4lH2RXXasRbtkcXlgfOg0EwwLCFayQHkdK7Pk8syemKF2skBwfYchdNcAsuzoQgCi8vthSuAWaJW0l9dfgspQtB5MNcvl+SfQ3VznOmyaRH8CpDOjm5tKPdsYTDVNoevhu5MmP+gY+Blt0xvoGp0l8XBenRknVqz+B5w6OTPoi/IvihRUczqoBGOzMO9DmTKVXpXzI1jj89F8gFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB85DQhoLhaLkvguwkINl0UhGJJWv8Tv+wjwl7aTbVI=;
 b=u/Y/yBeF8M6BKgQBHwsGByXHnOBVkehFd4QOQbXQWgBCOlnrOJKPvigYEZQ9YhXkGeW33wBortewmoPi4YEBtTmAFWMskcC3W8WPpZq8L7ATQ8EM2lCvoO7OjZQIBYgtpQKIxVijeTqiVjxWbpjQ2j59kZRLbYH99YO/Hvn4DUWk2OBqEtLlWGzWUs1J3lYgKppnzUPQSjJMpC4KOohmt8VPdD3GexXlwW9rzhKE0pz9YOTaMVI+lgUbRIf9IzulWmw1YPbMJkIpuvCp0MHk+Vp16VkajEuFQZPmXPvNmPhV6W3FtjwKujs0MdlGfO7gGaZZiyb4RD1v4ZTQJxl5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB85DQhoLhaLkvguwkINl0UhGJJWv8Tv+wjwl7aTbVI=;
 b=xLT6obZt0hzBRoJJdE5CGkVVD7SmCWHucQhffskOeotlEmEKf8TCumtnVyM6OlJCQ5CX3j/OKOVsFeD2Bf0e6+KiomBNUkI6/A1sJvA/iHJY4SBhg1P6lVzh6drPBLgvRTyF81FEAwZydBSbrKpM6i3oDAvR+DA3vl7LAOfwUL4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7429.namprd10.prod.outlook.com (2603:10b6:8:15d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 15:06:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:06:26 +0000
Date: Wed, 10 Dec 2025 15:06:24 +0000
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
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
Message-ID: <c641335e-39aa-490a-b587-4a2586917bc9@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-5-david@kernel.org>
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be3d02d-d4a7-4f8a-0563-08de37fdb07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SpdOP3VwoddhqEesQDK/we8p7vx3vwnNKM6cdgpGpm5JJdwrob5MM7eIDIx7?=
 =?us-ascii?Q?RLVF6l2AU+vhIgjuy9WNmNiDYfaWGznkHBie6DveAFHXV2jkVhOqn4gWKj9R?=
 =?us-ascii?Q?bKt4v7a7gCKgfEhrRTHiDFmIhNBnu9oiHGx7TTfC0eYvqLupkaKRRTBPvkLM?=
 =?us-ascii?Q?1xFtjjvZIcj6CuZnxtbrJv+qt8jFq3Oc0MhzJhq6sjdp+stt/tqLE1M5rNFc?=
 =?us-ascii?Q?hcCud/5s8Xluk2gKukZmIvBaPxbtmX9knhNuVZGrpq5Y/cqdvlGmIKFsC/W+?=
 =?us-ascii?Q?QbPxNp/MMWG7Z1oe9d1kjg8beyxs0GyMipDHuQfAa/J8VlZIWKSvWhrTaKGK?=
 =?us-ascii?Q?3DMqO2QDxODdnYGU3mQq9lwuaKH4fcsmtuwqIbeo9/zytfPPfFO4AUV7RA7I?=
 =?us-ascii?Q?JRC8EWRPpukwbmFpw9yaEkAj5CcdzcXicY8r21i2rDP5+0sDxvVn+MoGLeMn?=
 =?us-ascii?Q?I3vQDRHYTLSRmOjIADmbmclXI4LTBhbQYw9ZpRYlPTmM5BUGEML50U28vsrM?=
 =?us-ascii?Q?uP7R8Caq8DNfxcEjgJchsYciwM3MN00yf0+o28ydkdchFcXZBE0B71OhxnJD?=
 =?us-ascii?Q?Ib8fKJpplf/7udF8tUOalroLNnwVTyZfwR7/QbFwjzSogKCYSHG5IZfuA5eD?=
 =?us-ascii?Q?SkQp72yIBK/HHUROTFIEzl87JsdHEBagLIGeSlRxtG/LishUr9AUf5Le5NBY?=
 =?us-ascii?Q?IRm7NnRmH8G0uieaXguMiaINGegi6Ga7d0O5CzOna4d4kInuFuDNHpTY/9WR?=
 =?us-ascii?Q?a3+9t/e94ltJyqWD1/FPpuvwH4qc2hB3VHHe4hlZYtJh9l0+11xPAT1IYGj6?=
 =?us-ascii?Q?RHNVD6FDxyKWuhhr9AIsbl3Nt+OphqgqjXTq4x7sNTr7PhaiRN5v16XbshPL?=
 =?us-ascii?Q?JYeI7lwX0t3MPRc1oIay18P5m66DfhyY392r+mKKjy4nOScMyyZpXUl3qujq?=
 =?us-ascii?Q?b3fxFIHSYrCkvv6UDxhYxaCZ4wPCeXTrotNhSDArheaShRhUDXZcUQlpH4b2?=
 =?us-ascii?Q?9QLvYUaX4BbF+x/JNRCLTm7gIrcf+9nvWo/py8JjrVbxd7wDXV8L4tInH0V/?=
 =?us-ascii?Q?X+Fm0hjFzayzb8uBQBty0Wu7+it2o1ZVNld+dfk/MzwKgjpK12b7AWyUlEYp?=
 =?us-ascii?Q?zv8WBlydann5mIyvdFjE3Bm2iEmWWRqdqyjWvPg84soDgpWo6lwOTzRavOSC?=
 =?us-ascii?Q?e+i501bhEv3ccdlH5ybdrlL7I6+AI/BW7af8acmjNRXZAZEXq8cIMNX8w3Mu?=
 =?us-ascii?Q?5hUGSuBanWkjLMzN4Pe+9kjjHGImr+HCKzXuzDXeTzFwXZTYp+33E5argiAt?=
 =?us-ascii?Q?J0J8h5R5byumy1a81ZHbd1HNtUDxV0LVOL5JDwPAdb5E09lmbwi23kyIDDCL?=
 =?us-ascii?Q?bxl3Njh0XCoiAvryqycr5H9gT9Zguu02OYGBU7DEjUPZksZzWbfrw9VolTw4?=
 =?us-ascii?Q?uhWl7ZZM7tAno0/GE9B++sqj4fyu+QwE6MiUCfXT6jtKrjAOgecHHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OI79prvLOaGBLYhToXFWdtMYOgXTBOwkJ/pJOjsNR3IkU+RtB1t4y+NIp7gK?=
 =?us-ascii?Q?K6W6lOKF+yRw7eg4aMyxUBrvMFGi3JUEOwxMV1javt5ObE4pTHq1D2epSxDx?=
 =?us-ascii?Q?9E7pmIR06FK1GnSlkeJG0zi2u3y5lq1ZjRBcFTYyTC6FNfDMFdiOWcdGluQ1?=
 =?us-ascii?Q?YIfR6AM42Fyppco7rPyfwH2D4iLc1a/ziFDFCW3SeQLeiWWtVD+jJF+5OczH?=
 =?us-ascii?Q?yuzXM0NHOy+IYvfCMW1htuWAWODyR9Vrg2SIf4/yKrmYkFKh43zZ+DFYRN+m?=
 =?us-ascii?Q?GV67WCHDlHH3vhP9CFadJQcejTNEoI6KwK6gz77NN0lSkJOftnNAntW7fZV4?=
 =?us-ascii?Q?e8cxFQEwACV/ZHhALcQTxrBBNRB9LVIqDC/93GKqcUUz2kXLzJYE2/+UryLL?=
 =?us-ascii?Q?ixSmdRLMNuZFwlOfK7igTsXq4J+TSDWJ38kTz2l4L2TS0UNSZiLsPc6QWReO?=
 =?us-ascii?Q?AkTdapN4wdXSAYhoAJmKk1L9dJaUiCOMVYgP8ECTvamhkgeaW75/O8JV0gxZ?=
 =?us-ascii?Q?GHj1lS0bZnXOmBqccJWCJ/8Hs0ZgdvI282df7ax7nrr6wsIGJPOarvgdNDh5?=
 =?us-ascii?Q?g1xkZ8AGUZCRcxyXO0qj3GsXIOgXQ7/HT1ZnuWbbjKjFfiO3ySFWtLVIL7+q?=
 =?us-ascii?Q?JaiLD11sfGyFUSHrL3a6O7NLLQRmWKXHsXkA96HPk52iu/JKBrPeIVSQy1k/?=
 =?us-ascii?Q?IePZHBtDjeCQ9wIdQiI5DpapdyWCUDgLDrrvADgUJ6jII66pWwidk71P75aZ?=
 =?us-ascii?Q?9SI8tfVfMqSs9ZLwj2wNA1MRRpjPeLxnWhKN+NMcJ2H19Fi6LAXOeGCn/Cbw?=
 =?us-ascii?Q?9+EFXml8At9Q1NYzSWWutw18bgpCeJjYDmGPVDMhIoFhNDrb0VK7BKFztG8P?=
 =?us-ascii?Q?cv1P7jKWcrqkXLCCAAKvHZ0Gj0MEESaT2hmKnZhg50qxMqAZuHxAVXNZ+ynh?=
 =?us-ascii?Q?PB0AHB7gcIoZ8s+sl4664zB8q5dN/6Z3wdvJMzEVTiqh05+ZLG/xqbyOVJPE?=
 =?us-ascii?Q?+NkbV++hqP8iNg7OMquSOP54yXjzkNRX9uPt0haFsPFaTn0Sup6wEf5T67lR?=
 =?us-ascii?Q?6q0FQAZikuKqz+zWG7cJ3nu4KE00TKb1hwEPsdOrbtd17aLT1rCSGMqEbHMg?=
 =?us-ascii?Q?cBHHSp9+UfMbWc6+c2Tio/y1/RNprG+rwTO7TfapOnEvOs1W0oT6wA+kGRAQ?=
 =?us-ascii?Q?Xk2HyYg3NpFvWoidZ4giy+seGD5IZ5pUpIR0SIJ9pNuBO1+Zi63OnlFAwAN9?=
 =?us-ascii?Q?DbAXncozTr5oCa6cJRakTcz/etGox/G5Nsur+29TYE3x/YXgoE5jpFlhQgIn?=
 =?us-ascii?Q?NLibKzA3eYzMsafJhx5Gtd5FlXSzGNS4TKbKt+EmXRt4D0gw+gEDcSUgwzG3?=
 =?us-ascii?Q?AuCwa+zVn31yzMXyozDrbeZNAgikkaEwwUQhI7cBVYNF9ycrbHo8Qz+vdkmm?=
 =?us-ascii?Q?LjXXb2sXcvAHntoa+xRPkyCmfAMY4eyB3uYxKYEy2Onp5tCgt2ifF9LqoICa?=
 =?us-ascii?Q?6VuXgpt/AYNK/1l39BL5N4tqRfb+yE+U/40w3iIh6xLyxDb+H8tYeknWBeY+?=
 =?us-ascii?Q?BCTsWeV2SUdvMWHHrYsfr9fWdZVVuqorbrsymudz5uDlfedgyyuKhqPmH6Er?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BNxHeMSUiYXSGf26xR5AXyZLwSsjubMq3gfAfgyJSYGp3eEIwAgBYROI51jmcpqKqz+jeoPjs2lUVSSvktjXdGf9SGQPRmTANqnTI3ldMWdlfL5cntFMSorscuJaSGAIBl/AhHrRUgz/rMqSjO67LNmB2WyfhRTld+NF4yccDOJ7yp7Ys4faqD8OhJ2DW1+yQFOMsQlPIAJmDnCeUnPvSzzhXIM0UkrExZthz39PVinoKq82/mj6YZ8PGXf8mg/mjzP/TxQ2tpIQ3Ewgt8oHDisevcQRHDcBWVl0qLI3mw+kXU60cR7RKXCJtbMf4YvxSF59cSk2JIFMSIz1YaTmzvmZbtM8gLcR0DGlYMEzEAjxcFP8RO/hylLHZ5FFkLLeP9tbFskHRyy8TcYeP8MtRB7WBvDbzxEkGoIDbphv0w4IUuM9gsVlz3G3WHF+k/9yexMb78z/Mkt6th/QEGvkXqFV8goR3UR/xHigrtYuJozkmHGSIzR+cNq7+bBs/Ch+gbK4BzCodNQUikp2qp8mobK+y5NfMGNV5GrL/V/F6is808hq8G9TuPuhtyZnWiTkOKgx6r7MnGursK/sHlQSg9gIUmbZfPY+jtkuE9Q7tsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be3d02d-d4a7-4f8a-0563-08de37fdb07a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:06:26.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27cqpiII7eoI7qr7uG6WukgTxCg1n2PMwpJI0G/66NIvh/adnJ3B/vo27LusL+4aaskkW3r1HDwE83o3JdDZFTAAh3DATFtdJ9OsRlnQz+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100122
X-Authority-Analysis: v=2.4 cv=Raudyltv c=1 sm=1 tr=0 ts=69398c7a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=K1192TvNGPq6cbv30xkA:9 a=tcBg71FQ_zU0-9qO:21
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12098
X-Proofpoint-GUID: JURGma5_Pi2mHBmM2wuO6GfO4dtOgUqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDEyMiBTYWx0ZWRfX+QfX3YmfFI89
 z4zh7ZA+FPMmPY1xM3E9oB7jaSm73+nbMT1STiwYPO4O5RRrwRpManreFnvc7/i0+gEoxHxzX7J
 VwgiIOfwdrbC4QlO5sEZklY2EviwrrsyYLSyz9ZYpVRzC/R4QVy+Ve07ez6OnsTXeLecL81L1jU
 9sKfJA+vt4sXC9p797PVgaoaNaW89/Zo12q2+m7pSEeJbD6zXLf0fDRUDGg4jOrVxCP5nxAfYkW
 B5uK8/sVxoddYYXCiTzMghhOq79pCYeYCix6cp2vyFMbCtiZXfhMnDB2+oZOCfpUJjUBRJkmZZP
 xrCVFrICS0NXeWWO8NJa8cTMoFJv66kx6jD9nZafr7Q4PkpmFAP8rVUQ2vo0LKRDeqI49AqY73/
 ZFMqkDNxJcvh5ltpEtzQ0EGQLauWdgcLB+wE/pTUzQ3Ue3hH6/s=
X-Proofpoint-ORIG-GUID: JURGma5_Pi2mHBmM2wuO6GfO4dtOgUqj

On Fri, Dec 05, 2025 at 10:35:58PM +0100, David Hildenbrand (Red Hat) wrote:
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

Yes :)

>
>     Locking prevents that any of these PMD tables could get reuse before
>     we drop the lock.
>
> (2) When we are not the last sharer (> 2 users including us), there is
>     no need to send the IPI broadcast. The shared PMD tables cannot
>     become exclusive (fully unshared) before an IPI will be broadcasted
>     by the last sharer.

Smart this makes sense.

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

Ugh at the 'special snowflaking' of hugetlb yet again...

>
> (2) tlb_remove_table_sync_one() is not a NOP on architectures with
>     CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.
>
>     Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
>     we still issue IPIs during TLB flushes and don't actually need the
>     second tlb_remove_table_sync_one().

Hmm wasn't aware that x86 would still IPI even with
CONFIG_MMU_GATHER_RCU_TABLE_FREE??

But then we'd have to set tlb->freed_tables and as per your above point
maybe overkill...hm one for another time then I guess! :)

>
>     This optimized can be implemented on top of this, by checking e.g., in
>     tlb_remove_table_sync_one() whether we really need IPIs. But as
>     described in (1), it really must honor tlb->freed_tables then to
>     send IPIs to all relevant CPUs.
>
> Further note that the ptdesc_pmd_pts_dec() in huge_pmd_share() is not a
> concern, as we are holding the i_mmap_lock the whole time, preventing
> concurrent unsharing. That ptdesc_pmd_pts_dec() usage will be removed
> separately as a cleanup later.
>
> There are plenty more cleanups to be had, but they have to wait until
> this is fixed.

Yes!

>
> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Overall the approach looks reasonable, I raised various thoughts,
questions, concerns below.

I know you're at LPC right now so we'll get back to this either when you're
back or you get bored/can't sleep due to caffeine intake ;)

Cheers, Lorenzo

> ---
>  include/asm-generic/tlb.h |  69 +++++++++++++++++++++-
>  include/linux/hugetlb.h   |  19 +++---
>  mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
>  mm/mmu_gather.c           |   6 ++
>  mm/mprotect.c             |   2 +-
>  mm/rmap.c                 |  25 +++++---
>  6 files changed, 173 insertions(+), 69 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 1fff717cae510..324a21f53b644 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -364,6 +364,17 @@ struct mmu_gather {
>  	unsigned int		vma_huge : 1;
>  	unsigned int		vma_pfn  : 1;
>
> +	/*
> +	 * Did we unshare (unmap) any shared page tables?

Given mshare is incoming, maybe worth clarifying and being explicit about
hugetlb in both comment and name?

> +	 */
> +	unsigned int		unshared_tables : 1;
> +
> +	/*
> +	 * Did we unshare any page tables such that they are now exclusive
> +	 * and could get reused+modified by the new owner?
> +	 */
> +	unsigned int		fully_unshared_tables : 1;

Does fully_unshared_tables rely on unshared_tables also being set?

> +
>  	unsigned int		batch_count;
>
>  #ifndef CONFIG_MMU_GATHER_NO_GATHER
> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  	tlb->cleared_pmds = 0;
>  	tlb->cleared_puds = 0;
>  	tlb->cleared_p4ds = 0;
> +	tlb->unshared_tables = 0;

As Nadav points out, should also initialise fully_unshared_tables.

>  	/*
>  	 * Do not reset mmu_gather::vma_* fields here, we do not
>  	 * call into tlb_start_vma() again to set them if there is an
> @@ -484,7 +496,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  	 * these bits.
>  	 */
>  	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> -	      tlb->cleared_puds || tlb->cleared_p4ds))
> +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))

What about fully_unshared_tables? I guess though unshared_tables implies
fully_unshared_tables.

>  		return;
>
>  	tlb_flush(tlb);
> @@ -773,6 +785,61 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
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

OK I guess before we were always flushing for each page, but now we are
accumulating the flushes here.

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
> +	 * even reused outside of hugetlb context. So flush the TLB now.

Hmm but you're doing this in both the case of unshare and fully unsharing, so is
this the right place to make this comment?

Surely here this is about flushing TLBs for the unsharer only as it no longer
uses it?

> +	 *
> +	 * Note that we cannot defer the flush to a later point even if we are
> +	 * not the last sharer of the page table.
> +	 */

Not hugely clear, some double negative here. Maybe worth saying something like:

'Even if we are not fully unsharing a PMD table, we must flush the TLB for the
unsharer who no longer has access to this memory'

Or something? Assuming this is accurate :)

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

Nice, great comment!

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
> index 03c8725efa289..63b248c6bfd47 100644
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
> @@ -271,7 +272,7 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
>  int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
>  void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
>  void hugetlb_vma_lock_release(struct kref *kref);
> -long hugetlb_change_protection(struct vm_area_struct *vma,
> +long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end, pgprot_t newprot,
>  		unsigned long cp_flags);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
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
> @@ -432,7 +437,7 @@ static inline void move_hugetlb_state(struct folio *old_folio,
>  {
>  }
>
> -static inline long hugetlb_change_protection(
> +static inline long hugetlb_change_protection(struct mmu_gather *tlb,
>  			struct vm_area_struct *vma, unsigned long address,
>  			unsigned long end, pgprot_t newprot,
>  			unsigned long cp_flags)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c77cdef12a32..3db94693a06fc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5096,8 +5096,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	unsigned long last_addr_mask;
>  	pte_t *src_pte, *dst_pte;
>  	struct mmu_notifier_range range;
> -	bool shared_pmd = false;
> +	struct mmu_gather tlb;
>
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, old_addr,
>  				old_end);
>  	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
> @@ -5122,12 +5123,12 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
>  			continue;
>
> -		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
> -			shared_pmd = true;
> +		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
>  			old_addr |= last_addr_mask;
>  			new_addr |= last_addr_mask;
>  			continue;
>  		}
> +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);

OK I guess we need to add these to cases where we remove previous entries
because before we weren't accumulating TLB state except in
__unmap_hugepage_range()?

>
>  		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
>  		if (!dst_pte)
> @@ -5136,13 +5137,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
>  	}
>
> -	if (shared_pmd)
> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -	else
> -		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
> +	tlb_flush_mmu_tlbonly(&tlb);

Maybe:

	if (!tlb->unshared_tables)
		tlb_flush_mmu_tlbonly(&tlb);

To avoid doing that twice? Not sure if so important as will be noop second time
though.

> +	huge_pmd_unshare_flush(&tlb, vma);

OK I guess the semantics are

huge_pmd_unshare() for everything that needs unsharing, accumulating tlb state...

huge_pmd_unshare_flush() to, err, flush :) followed by tlb_finish_mmu() obv, and
with i_mmap lock held...

> +
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
>  	hugetlb_vma_unlock_write(vma);
> +	tlb_finish_mmu(&tlb);

Does it matter that the hugetlb VMA lock is gone when we invoke
tlb_finish_mmu()? I'm guessing not.

Kinda wish we could wrap these start/end states, it's fiddly to know that
you have to:

- call huge_pmd_unshare_flush()
- release i_mmap lock
- unlock vma hugetlb (ugh god don't even get me started on how that's implemented :)
- call tlb_finish_mmu()

Obv. this kind of thing can be part of future cleanups

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
> @@ -6399,7 +6390,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  }
>  #endif /* CONFIG_USERFAULTFD */
>
> -long hugetlb_change_protection(struct vm_area_struct *vma,
> +long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end,
>  		pgprot_t newprot, unsigned long cp_flags)
>  {
> @@ -6409,7 +6400,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  	pte_t pte;
>  	struct hstate *h = hstate_vma(vma);
>  	long pages = 0, psize = huge_page_size(h);
> -	bool shared_pmd = false;
>  	struct mmu_notifier_range range;
>  	unsigned long last_addr_mask;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
> @@ -6452,7 +6442,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  			}
>  		}
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (huge_pmd_unshare(tlb, vma, address, ptep)) {
>  			/*
>  			 * When uffd-wp is enabled on the vma, unshare
>  			 * shouldn't happen at all.  Warn about it if it
> @@ -6461,7 +6451,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
>  			pages++;
>  			spin_unlock(ptl);
> -			shared_pmd = true;
>  			address |= last_addr_mask;
>  			continue;
>  		}
> @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  				pte = huge_pte_clear_uffd_wp(pte);
>  			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>  			pages++;
> +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
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
> +	tlb_flush_mmu_tlbonly(tlb);
> +	huge_pmd_unshare_flush(tlb, vma);
>  	/*
>  	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs() we are
>  	 * downgrading page table protection not changing it to point to a new
> @@ -6904,18 +6887,27 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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
> @@ -6927,18 +6919,36 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
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
> + * unsharing with concurrent page table walkers (TLB, GUP-fast, etc.).
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

Extreme nit: inconsistent newline here compared to elsewhere :)

Not even sure why I'm making this point tbh

> +	tlb_flush_unshared_tables(tlb);
> +}
> +
>  #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
>
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> @@ -6947,12 +6957,16 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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
> @@ -7219,6 +7233,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	unsigned long sz = huge_page_size(h);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
>  	unsigned long address;
>  	spinlock_t *ptl;
>  	pte_t *ptep;
> @@ -7229,6 +7244,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	if (start >= end)
>  		return;
>
> +	tlb_gather_mmu(&tlb, mm);
>  	flush_cache_range(vma, start, end);
>  	/*
>  	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> @@ -7248,10 +7264,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
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
> @@ -7261,6 +7277,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	 * Documentation/mm/mmu_notifier.rst.
>  	 */
>  	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);

Hmm, does it matter that if !take_locks, the i_mmap lock and hugetlb vma
locks will still be held when tlb_finish_mmu() is invoked here? I'm
guessing it has no bearing but just to be sure :)

>  }
>
>  /*
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 247e3f9db6c7a..822a790127375 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -468,6 +468,12 @@ void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
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
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 283889e4f1cec..5c330e817129e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -652,7 +652,7 @@ long change_protection(struct mmu_gather *tlb,
>  #endif
>
>  	if (is_vm_hugetlb_page(vma))
> -		pages = hugetlb_change_protection(vma, start, end, newprot,
> +		pages = hugetlb_change_protection(tlb, vma, start, end, newprot,
>  						  cp_flags);
>  	else
>  		pages = change_protection_range(tlb, vma, start, end, newprot,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 748f48727a162..d6799afe11147 100644
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
> +				tlb_gather_mmu(&tlb, mm);
> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
>  					hugetlb_vma_unlock_write(vma);
> -					flush_tlb_range(vma,
> -						range.start, range.end);
> +					huge_pmd_unshare_flush(&tlb, vma);
> +					tlb_finish_mmu(&tlb);

Not sure if it matters, but elsewhere you order the locks as:

- huge_pmd_unshare_flush()
- release i_mmap lock
- unlock vma hugetlb
- call tlb_finish_mmu()

But here it's:

- unlock vma hugetlb
- huge_pmd_unshare_flush()
- call tlb_finish_mmu()
- (later) release i_mmap lock

Does that matter in terms of lock inversions etc.?

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
> +				tlb_gather_mmu(&tlb, mm);
> +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
> +					hugetlb_vma_unlock_write(vma);
> +					huge_pmd_unshare_flush(&tlb, vma);
> +					tlb_finish_mmu(&tlb);

Again this ordering is different from elsewhere, as per above. Not sure if an issue?

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

