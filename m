Return-Path: <linux-arch+bounces-8276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF79A4404
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAF1284572
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56912036F6;
	Fri, 18 Oct 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FX7ERcfG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zDCLS69i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E956B81;
	Fri, 18 Oct 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269733; cv=fail; b=g1vL/sjKOn+O4NjJfax+JjYzg6V61kT0RSqNXyz1DQqSQBiqd1ld1IjbiY/3SskEYoGOPYYAYDI3e/Uj4td9PYBFlVh/ymWrel2PRMkDBzcriL8d+VYod8o+rAr8hISupvVJws71f/cJl+vyUgu44tFHXhR4kkVdtV00z4haE1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269733; c=relaxed/simple;
	bh=duceKGehCuf4HO5Eu/kcxbjIUJHUBa4aguX3C7WXsbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jRdVApZuQg+54RO/Sj9EJXTUl/Ust1V1WtJQlsu+J8+dE73X2aGRqQudNCtQBDPzD/etb1KuQ9s1W/lJv6QZy2WgQkxrAIeFp6/Rx+DWtWzt5UbhS4bPgXd7yD1MCrf0sXU5s42OmyQxenIoHeMCyf9adTHSIbM0Fqhj0UI9kdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FX7ERcfG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zDCLS69i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBgMa019358;
	Fri, 18 Oct 2024 16:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4Ja7LVSr9ZxZLpIZ4H
	r1LklnUF4bv5RwIogxymt3nMI=; b=FX7ERcfGUjcmjcOyC9Cs9z3cK9hq/FQKJ/
	5xqUZ6ZHzsXqHgoC2Z1c7zuHyoUlxOw64QisP0o/DTCHfx2cUylk0eTvI70l2Y7c
	PTQ3EJRF0Hd8Mkvj0GHqTwLaSUJupbEUuCe3RYsXoNb8j5rCGrAezhf1sPyVem9A
	/ADoq5mVOE9wQn0BhAn49bSWeaHjpF/XK/aISxJOnACt/OAA6Ud4DOgKh9Gkr6Me
	NVzAslrOXetFHSKgy8hVNeIdwb7492bjTY7qRXevvfXkx0+dI8RBn1X2sou2J8yz
	cKYFXkPyyIWpsaLmDO9U0ZRsIiHzec5OcpBs6+fW2LKHYSsqUkTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcrvdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:41:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IG6Ilk027100;
	Fri, 18 Oct 2024 16:41:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbtm2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYdj190P2TdMlFKekcnsxkHrtCcRkEC25Sz+METIw81m/a/SKg34OMpm2BV/p96gWQNhRPGaKJcoGsQcfdgwW03FZqX15du2ep/ujhJoKOcdaHOfliYoOTDGemKpTW5Depwxb+7QqfSG51qhJSKWmMDb6PrjBUrzusyTnzF3vZoqKNlBTKntp2XcYiaDssDUYX+Qn4J41pZyrxo4KciRtKVUUbn6VYGw45oM+CeEDqvWgIxaGDNatSAFq+F/ViF5eQgcm29JezZxTG8ERH/D/0eS/fH2vwdwmG4FM3wmfrSTF1ptRGHTUYObUJ7j5LiZ/H7dw5J+9ckC1mq29eStdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ja7LVSr9ZxZLpIZ4Hr1LklnUF4bv5RwIogxymt3nMI=;
 b=wx4AZeaU0icQpbAUAvRNuGz89Ox29h0tzwQJzv/LoLvk+AKgnVOVqBjHfL64WeNi9TzyBq0TnHBEX/5hrRR1TqISRV4xqPoI/LG0rHjoXYSNUDTeuFe5zNQQ2M42rw6kTiNZvfda3V8pD+XWZ4FmXUr610TVlPJt1JDYtyup3KA/pvm6Lr8Fy2bDCc1OGeNAsvX87rZhpDtCtLiYuJHcXsipqLKFYY2hurpm2YlwXY8DHyy8JGzNnRF1YTRfIaNPi1MYw4ywQ2rhO1ieRPLHjOiIE8vTwUyA/6pVviqq9cc2m/bWRcg8tEtFJf2jqRU2JfW0mgDM/YgJHeIsIPIJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ja7LVSr9ZxZLpIZ4Hr1LklnUF4bv5RwIogxymt3nMI=;
 b=zDCLS69irvpSjPfK6d2v5NeWH9uI3sFkrG8dTCesoC2z8iH/qObuIBpyTyYuJ5ABGB3uCbM/QLKTFAJtLcvEXkmcBZc+6GhOuiumvbQpS5I924q3JwZv3jXq4KvKoj6smHpekdzNLcBsOvEf/p1oawUJlqHXMqdJ9cu6YJf1BZ4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN4PR10MB5608.namprd10.prod.outlook.com (2603:10b6:806:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 16:41:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 16:41:38 +0000
Date: Fri, 18 Oct 2024 17:41:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
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
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] selftests/mm: add self tests for guard page feature
Message-ID: <a64650ea-fef3-4d6c-8a36-3fab73f7a0bf@lucifer.local>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
 <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
 <dfbf9ccb-6834-4181-a382-35c9c9af8064@lucifer.local>
 <22d386cd-e62f-43f9-905e-2d0881781abe@linuxfoundation.org>
 <7bbfc635-8d42-4c3d-8808-cb060cd9f658@lucifer.local>
 <3a41a1b5-e9a7-43db-b50e-84d6cc275d10@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a41a1b5-e9a7-43db-b50e-84d6cc275d10@linuxfoundation.org>
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN4PR10MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: fb193751-3e76-4024-d4a7-08dcef93bc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UTREvyVooGSf7S4/k/bmg1CpV9jn8xC0n0X7sQ3/HN+KsLCsd/GMov+16DEK?=
 =?us-ascii?Q?nAyzlET3zClibWVsct1I4A30uePZ9wctmznL+06Oe88mJ9NmC62HggltTE/t?=
 =?us-ascii?Q?PUFcTjZ89sCOVOD/kScI9tHSlKmwUrEUyeacgbcFvsGHCf6uSbufYuGalksK?=
 =?us-ascii?Q?JE762ylGJLng+sewdDYGWJqYOmhwSSyUgyKTpn4fD86uNKpYcXhDMoMPjJCq?=
 =?us-ascii?Q?iKbF0sTZcRe+ZLKGB4fJWcYEdekTXfQCDmc+FFVc2GROL88DG36AfgNoWImB?=
 =?us-ascii?Q?XgpUlbsUZsTQlo+gLTPvZptXQ9OuETIZjt+/pf/3FfjFrKrgMqcg7WFXDivL?=
 =?us-ascii?Q?7kd7zZDxrxyXz9rGWNay0PKQ6io/DMIaMnUnfugOsIeJ+QchtfbDO+uJKbRK?=
 =?us-ascii?Q?3XHCHVLjv0Q3mPYP1Fvyx+V7mZ69Qzh9e7QmEeT4c2svRUzVa+hAm0OqScBu?=
 =?us-ascii?Q?ftWHE/Frfeczx5EBR+t9pdMpuq2p8NqTvx8MB2F8+2t2i4J3A1xr2aqHV0Y8?=
 =?us-ascii?Q?6BRYU2JDbQGcPaPFi5qKvu7zkzSJ7qjFkDajDNmd6wM7jQc4gYXamZN4V+qg?=
 =?us-ascii?Q?sAROgFFTLUmHo6jUzCEma8FfbPdh6+G3aQC5KAzdW57Q727VFPkIV5sRYli9?=
 =?us-ascii?Q?syi2rOWnf9PamPtjopint3Ad0TyJ2E0UirYRdw9iYc9ji+BgN67aSfpmXfqY?=
 =?us-ascii?Q?mRw2a0wHPQ8guWKRoneAktWVWzlMZ2hXJ3wzDLt0rNA7CQIgBa7p9CU0GUqN?=
 =?us-ascii?Q?1KGJtKG0q3ROoKy49f2erH7zWKR17bo9Y9ukwtbo6mBimeqJ5hUxaKVxdjqU?=
 =?us-ascii?Q?ufF2PDdEE/Rq3G8rWyhIXxHhTTtcLIj1SKDjsDP1GaztonmxcaqsbfJjTktH?=
 =?us-ascii?Q?t1LM6U1QfInIvqMoUeGefx2vm2B5mzbMRGDM8opJf7ouYVSx6iKCNR2Ikz1D?=
 =?us-ascii?Q?ddl40BpT3ZtLGH3gnGB8YDTd0J2zerNUeQtGrDhOtXIQdLO4Gxt1FNbeK9L/?=
 =?us-ascii?Q?vc4T0HaVc6ZTWWbnkt3y2FKPEpjK8dKvADsaMNXxNg1VBPwoiqIDz7UMsvxT?=
 =?us-ascii?Q?sLqkaG1Tcban1LyoXQKGen7Rz0bby4UkZ53vg5tApoq2PXJgmwfjkbUxLIps?=
 =?us-ascii?Q?rrjy+RgEwx/fTO2ALXO43Qlaxhi2GVz3QVoBvfP1vahJRL5droK8sm9O+QYz?=
 =?us-ascii?Q?2vDq1/rJObvipNEsPpX7RLvKzlLRSjE8D7yebsnKj50WUwEiy+i8ZeZWqskU?=
 =?us-ascii?Q?0tyXSopCEhsdNHkOW7I7Fe2OdFuCXpq2sZHxDGGmuQgdWHk1ycxrfOC2jfWJ?=
 =?us-ascii?Q?Ng6vudHk0i5e5EshJmeUiREw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+r1L4HOCPwAJNnILlm/oqxHBUxhGfrvx6/hRLw3EtWYdQwQSDNXZqPKadWc?=
 =?us-ascii?Q?8ZxZGbDCe59wMZFFRKtLaiVoGCoWWrZqrn5n9cM/498KkLaD5pywmWe5lY1k?=
 =?us-ascii?Q?BhXbfWIdQwwP6+9UiGl3hc76Q9Dm4oLMZS8BgvWUjvqvf5+GlxkbBuqjGG5X?=
 =?us-ascii?Q?BEohEwP68xhuqmQwZiJZ3CXP1aoQhXnA8DY4RC2N2KHF7jsUbWf09ShaRbWY?=
 =?us-ascii?Q?C55zOoEbmVsMgJtE6vPfbwEe/3KyosWxAli4DvO5Rp/NGq965pSI+MnGlFNM?=
 =?us-ascii?Q?FvMpvu3bKeBt2m8x+CTN0v8B1ZnnHWbfJG2AaK8tzTnrQLVgvESfWqJjcDzv?=
 =?us-ascii?Q?5iBfurrncvwLT+N4wAJLSLD5OLEp7M+5bEeguBNhSRfDeoybipJm+K+s6jpE?=
 =?us-ascii?Q?uxZyUW4xx6jxjQ5vP7JPp47R4wGFUSR8k43OAo1XGPHv+4mOmfVaE725v/Zp?=
 =?us-ascii?Q?rcLt7aqdk6nR7hCyv7BiSqVfnq7ZZno8Vt7a151sdwOEUWJI46WF/Xu+RFMk?=
 =?us-ascii?Q?PQEZxVaMZ2Klf2TIZOb1Rhw5YHzQzdEYqh4hA7q7jV6A5VRwfMxB7UD0IvRt?=
 =?us-ascii?Q?P8i+CvHKM0K0nkhIRIxmuCcSCfUJYD9M0j3IOYPf+Fkim4yXSmNIFYeMUvls?=
 =?us-ascii?Q?QWfWZ2YmcAioQcOfCmYp6P4Z3G74nn8en7tb8iwQVABfaVG70CnkH7FHgQnO?=
 =?us-ascii?Q?tPDbwPwyRfTAcRddZNLDk+6XLEAdHTmrFW9HujkBRGsfax/kcAq0Z2JKQkoL?=
 =?us-ascii?Q?f6rUxorzlnFID6hoIxc0+UxZnrxdOqziIlXNuR0ZwDzpDXFulAD4idgqVCY0?=
 =?us-ascii?Q?LcODF2LPeqIDcNkZr8z/9p1Nqw9im0rb3aTMXnfIE89Ms1/Bfer/DZRT05Z1?=
 =?us-ascii?Q?5yHtHATqGkRpk1+FAQ9iivMNj/69X5SY/h1701mKnapMkd2UKo94cNbQZ3nU?=
 =?us-ascii?Q?NtIEw4EDI2ZSFJpNfaqegz6vd0FbDmiIL18rtYDi5BMgWuHMA9fztfe4bJSA?=
 =?us-ascii?Q?XuBZM2vifCBoF5ausav0SI8p9UX77ibb720IJhmkez4frTotHUaC139auFAF?=
 =?us-ascii?Q?DQZrmK+J2mErvkDgJMJAVEIKwfUnlLCdM5d1+brtpnNpAiWpR+2f1/sAFMpC?=
 =?us-ascii?Q?T4AMy4USjPXNwLEKK47W6pAHoQ7GCJAKFE3BlKDuADBdbJ5YUXyhp6lIMkXZ?=
 =?us-ascii?Q?tiuTIzBFZX+lcaP4A4ERguPaaPUXW4Gzmu65h7bPui92sVGCfSQAIlkVCXJI?=
 =?us-ascii?Q?UaI6OuN3d6rnICrtizlhTTZWCtqUcDqFX/LEOZdj+6xBvGSCDgN895NmAm3S?=
 =?us-ascii?Q?oSH3uOXmDDhfhhcA28CQSPMeudDdGtq4VWEJZthnonLJHTq841oUpaY2dB+Q?=
 =?us-ascii?Q?627sBl7vjMIeRFbuoXEvBc7dly18CDfBv1OqDDXKH9JUpEaO/IqYtV1lHrVt?=
 =?us-ascii?Q?8t3+cYnscH3UwXjovlipRkmZrIIfYMuyuLGWwFLo18cuKmA9XI3EgHUHIaSP?=
 =?us-ascii?Q?8PY2fmwlqGeC1uUJ8xq9cvX8KVRPpQ8IkjMopkLQ5IPbDG9UlHcHdGVQ+5QX?=
 =?us-ascii?Q?Kq0meRv/iHqhHO8oOI9R4BnQ1mpSiB5CCj6qMlbxNECwJo18FXkouT8/5GVN?=
 =?us-ascii?Q?CCKTC/I1jP8zrdDnfFpQp+tOk3CI17dx/xPes/kJAtCHSkZ7Ei/+vMU2gFvX?=
 =?us-ascii?Q?opip6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DmnvqR4kIcs/6SyTpG27i10MBySOPBhRO+tjaoXSbvOfEpG2tAs3mkkmXz9NoRmzPd9yUQlesko3LSmxaMdf40yE5kGolvAxh/GQAE+7ZUaw4XH72LhjPptV7wUrp8jmw85XgdMU4uRL3eH0cLfV05ySmUsl/UGj/kgyYWo8OOwEX+J47nAD9XgNtrHwEpOY8g+LHKHrsp0oKYipPj46JCnobpO0Xq+BmCj4ncnY3kJdSbk6yiqZU/Qn0N46DjEUbyHADDE28obAekxTLUUB5MWQx1/k3zXsurAxVJmfJzS8flq//Qb16br8GMih5BkEOi5fCiJL2IUQ/JvV1syuF7LvEgGdI6hk9u5QffdN3Vj0kFnMWTa8wnaC4LqxjBUa4NL92BZJkIvWDOzD8czlOXS0CSIIJA5r1TXUP5befPaVTZp07b3jTBq1riki9ywevZ/irn+mfbVozXlEpb6bPIHaXHIkTzQ2PoqfL3A6dLXHvdr6lq7JyWIte09mysQZ+q7Jo1JXoxnjX1np9WZtPdVyJOywUdDlObc2hAdCWlqXKjx94GubeVH102u+KLjCfboSzZCYV8u71GAM5MPRAh+FTqShvk+PzGzwyXg3DdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb193751-3e76-4024-d4a7-08dcef93bc53
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:41:38.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fG1UMXU4M9/78JlttFtn1AGh6sZIS7HvD7PasVANy5+CyEqBvxdS6mq/zU11UDjuLbUSWUEDUe2DSaSfb2dvSStdGpZv1U0Psz+rr23L8oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_12,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=676 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180106
X-Proofpoint-GUID: B9Gjdww84tO5fHuAYXPUDw6gzP7lzXcK
X-Proofpoint-ORIG-GUID: B9Gjdww84tO5fHuAYXPUDw6gzP7lzXcK

On Fri, Oct 18, 2024 at 10:25:55AM -0600, Shuah Khan wrote:
[snip]
> > > Sorry - this violates the coding styles and makes it hard to read.
> > >
> > > See process/coding-style.rst:
> > >
> > > Do not unnecessarily use braces where a single statement will do.
> > >
> > > .. code-block:: c
> > >
> > >          if (condition)
> > >                  action();
> > >
> > > and
> > >
> > > .. code-block:: c
> > >
> > >          if (condition)
> > >                  do_this();
> > >          else
> > >                  do_that();
> > >
> > > This does not apply if only one branch of a conditional statement is a single
> > > statement; in the latter case use braces in both branches:
> > >
> > > .. code-block:: c
> > >
> > >          if (condition) {
> > >                  do_this();
> > >                  do_that();
> > >          } else {
> > >                  otherwise();
> > >          }
> > >
> > > Also, use braces when a loop contains more than a single simple statement:
> > >
> > > .. code-block:: c
> > >
> > >          while (condition) {
> > >                  if (test)
> > >                          do_something();
> > >          }
> > >
> > > thanks,
> > > -- Shuah
> >
> > Shuah, quoting coding standards to an experienced kernel developer
> > (maintainer now) is maybe not the best way to engage here + it may have
> > been more productive for you to first engage on why it is I'm deviating
> > here.
> >
>
> This is not the only comment I gave you in this patch and your
> other patches.
>

And to be clear - I absolutely appreciate your feedback and in all cases
except ones which would result in things not compiling have acted (rather
promptly) to address them.

I am simply pointing out that it's not my lack of knowledge of these rules
that's the issue it's 3 things:

1. Some code doesn't compile following these rules
2. I therefore don't trust the macros in single-line statements
3. I am not a fan of for/while loops with heavily compound statements

1 and is unavoidable, 2 maybe is avoidable with auditing and 3 is
subjective, and is something I have now undertaken to change.

I've heard a number of kernel developers' opinions on checkpatch and the
overall consensus has been that, while the core style is sacrosanct, strict
adherence to checkpatch warnings is not.

This may be worth a broader discussion (outside of this series). One must
definitely account for cases where the syntactic analysis fails for
instance so 'always strictly adhere' is out unfortunately (why I say it is
fallible) however perhaps 'strict adherence except where it is obviously
wrong' is a position one could take.

Your have a significantly different view on this and that's fine, as I said
I always try to be accommodating.

Key thing is we've found a way forward which I will act on.

Thanks, Lorenzo

