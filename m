Return-Path: <linux-arch+bounces-8515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AC9ADDD1
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010901C2367B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20231A704C;
	Thu, 24 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GV4Sqt7G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D1sbFbuG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9261A0B07;
	Thu, 24 Oct 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755341; cv=fail; b=NbCT7+hwNStwmUFwjiOpHL9wv69aUPeoFBmGFm0mUaQgqbYe8sGPZFN2Sjfq9EvmmafPCKqwp4N6spbYgxZfelN+3X/rXWKBMQTVnuB8eDPADhzClhCJCjfSPCM5MlQZbvUpI75tURld8OZR9w/6QvChS8l/xC4Vg8adI4wAM3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755341; c=relaxed/simple;
	bh=GOfbMYrF7ZAkPhzfTyF7+r0pmMCNiWKlvWxDv3XUfVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkmX0nFlC28jGiSrY7jEpv7yYbeiY1GMzdvPXQGZx9fOPXRA8Tu5p/cSRVqZ2r6lf3M0TqZKNrvbiZSCP6vYThf4oAiTe41d1fmuCuiufUNT484OBHr9jN0d+SzJvaU+YiH3aExhTOYNVXRtC4N4HPTFnDGPBc19bFAvULRGoQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GV4Sqt7G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D1sbFbuG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2g6bt030638;
	Thu, 24 Oct 2024 07:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GOfbMYrF7ZAkPhzfTy
	F7+r0pmMCNiWKlvWxDv3XUfVk=; b=GV4Sqt7GpbmTgQ497hBJiiPLz/MXcOGlW5
	5mOBjssiQuwtGqm3d7Po6X3pg1GSAdRiJqm9WewT+KKfEMV4PVWFgmEOKcLssxjB
	zYmn0rE7/pdumT5N7Ed44FSDLJBrg8hxHmu524q7WbDqNIjbIB3VDFaDxpFm3iKL
	HX/NQZGSq67UXlVWmLtauoc7PlKwedWwWeXSF9iuLYdlASP4dXf4KU3pOkeycN6S
	jwSfSirTsS2AX6drSNJfz82wO0taoAchXlQq4gX8Nsz2BNbzmW3EPlgenl9lUUWO
	xWMNsJF6ddJ/8IB7wuzc+LMOgwwuHAFVLAuDFW42eW48keIsmq4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5ashvj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 07:35:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49O7NwCf030872;
	Thu, 24 Oct 2024 07:35:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2hk4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 07:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJzEYbgAc83liBol7YUr252yALBleQKOmO/oTEwygo4wDMtCWUTKMiy+n9fl7oLatrXXYC9Brh5m7thks3rMN/D1Ptrnz/CL4//pcKC4tXTZchiRgiPoDfkqyrZIXcU0LEnpLBojGvMIbaPKgxAx+06NzgTOWDCe6o8S1SbIy7GBMCSgwmxmQHdjcbmpJ7lLZUZIlEOrejwZC7acO/1yYH0B739FHmklKuSSYQrZYDRncei21E+7FvkDQH8xlxlQkMCuv5Ln+CWMbCrlfvi71dD4kDK3EA3G97Ku3OGi1PQEhmHkOykDUxra/umD6s6HQJVj1tpgSXS0ceMvD3X8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOfbMYrF7ZAkPhzfTyF7+r0pmMCNiWKlvWxDv3XUfVk=;
 b=UUW/oY6k3mkd9y+HCCBXF5l5yGjf3+a0Kz5zYQqPbzj8U48iSANWKJjKzK016YYgo+0VkQJlVmTeHa5iO3GI1WY44kUCemgf590gwXeHgQvTjwulUKMHkUb4CizRysrFAej75hh/q5iEi6EceUn0YQiAraSMIU08CZKNnsQP3vOvjUKN9snQarlJ4bDKXuzCM9pTIndVENAw1dMkkQ6ZSdw/cHp8CR2P3rIw1iiBmNv8g5MNY6w723vsEJS+9HuUzBgxEWHvq8lCnP6y2nvHCFnOu+cVdOZmhcfCAfsdkPNLurj75Fa4gTNzFfklkskCZReLkyi3g+IRNK+hFPw75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOfbMYrF7ZAkPhzfTyF7+r0pmMCNiWKlvWxDv3XUfVk=;
 b=D1sbFbuGlNqkTu9LTRqk1iwzZk62UCChVGnWUgZ/gD7fznxi4ani6ACQCuG6Y5r5zi758CuLTKPp+tSR7kilq9ZNJM1moJAtX6g7fzr+MsNkY7nBgtgG0YsZPMUiRjRRyQIl5dD5fZ3mPMwtRJEBmEWYTLZcJcEj1hNSiBQ856A=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:35:01 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 07:35:00 +0000
Date: Thu, 24 Oct 2024 08:34:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Message-ID: <635de052-35a6-40e0-82ea-4349f3aecc06@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
 <20241023160405.33995c68f20c141325a8fadb@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023160405.33995c68f20c141325a8fadb@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 15622f73-08cd-446d-65e3-08dcf3fe5e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kDl80o0+eCTjngW88RFSJFFJwPLfKjLLp750LOVve872UI51RknnXH39xH85?=
 =?us-ascii?Q?IIf8gEXPBH1vUeNUqJLtfNPo1zpwVE8Rux+cJr85snS0hm9gAsIOqtU3/wnE?=
 =?us-ascii?Q?m3hXi90ihXoo+3p8iVVW7+LDzPuuXx91x7X/VLhAuqyvLQs7dhJLr5GCkXjb?=
 =?us-ascii?Q?v6pSCvFS5jgwW7estJ7zfJQOPdgphKMcLLceUYhvQnbCYf+u0b2qflzDyiG3?=
 =?us-ascii?Q?wdaM31y+8fRrUE1nLfUcZmLh8pgZjRglGGcDZUDizqr+0DYkD+wdAfVWfAlF?=
 =?us-ascii?Q?kFA//dBhOTlv7FgFUL5obnAIipTUBMZgZ842lcUKKllGLw4KGpndaoI7JUaT?=
 =?us-ascii?Q?nyi8wXaRelNSNsKbZJ1XOGl2n/4kL0K1qsxdfhOLXcKj/ZRrvTFj1A73fSG0?=
 =?us-ascii?Q?jdyxqJolwZmAJnm6l/BVx1c3a4FHUvDmWmBwc1gvcAZTCnoxeZI2AEBTvrEa?=
 =?us-ascii?Q?qAtQ7KPJM/VI0s39UOZOF2a/xL6sJWr8yhw2UKkLWua+y28GPnZzR7A0E4TI?=
 =?us-ascii?Q?+R7OgofPiPqRWcIy/ySNsSXTVQo4Iqp/D8rn7uAB+172eEwBV3fJ4dJ25dzZ?=
 =?us-ascii?Q?cTRKj4qSRCiUix8dm3PsSyZney+djPCLodEAYiOtnMF8pbINrxnN0Zc5Pp9S?=
 =?us-ascii?Q?SwJXHZiXYHYwJY84lPOmfVVqlrZYfNKJK8xoo8/B+JbXTpTv/nXqQKlC2syp?=
 =?us-ascii?Q?zSpFvqx79K4X/g/2/e8Tru1Z/Hjvv23HyFmyMdgV+UW6bJm2De472sbgkrBj?=
 =?us-ascii?Q?fo/TG0SdE9lKGJ4pcWzPoOiqf4zzIvgQJti9vyIeQVBtgs9RRueDJNjv64Tk?=
 =?us-ascii?Q?8M125tP+Ec1IOeSyPggLnEu8jVeqXQqW87sPVqfUUNmUC9w9cyY7ueuKef7g?=
 =?us-ascii?Q?bk3x5zlFksYZU5ndwavC2SASkvoY+YKOjSNlLj/mUQrke0IXoej4qtHqpSCZ?=
 =?us-ascii?Q?RjyBGkXXaMmlMkgoJR7xxtaasbCpd6HFrRNBJP79JvmdvEfGOGVnkM3tX41r?=
 =?us-ascii?Q?q44+7q1/CAYKrBcPj7WaJX+UtPSMg2UN/XnYyHO55akkvDmoiKucybb26qHh?=
 =?us-ascii?Q?76kv3Hf4R524bK/4J+WtY87HTUYG+rb77TusuPqCnev35i1h5nwsED+u2zon?=
 =?us-ascii?Q?Yc8cLZdxNoPwIAXLtFc6FFunA9v35YV62X/V4w5eCNbcGgOT6DgmkDmtABed?=
 =?us-ascii?Q?EkaADvr1/wjtOc7kui4LLYWOIdjqEqd9V5pvzy03Nmh2mbyhgEOunUIhntWo?=
 =?us-ascii?Q?zomwIzzX9L+v4rVsopAc7wRrNuto9abOQwM76bGEsx8wjVfJkzpA8mnBhcZe?=
 =?us-ascii?Q?0wga7/kMSfIeA7kMDokjIth/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UpLQeKUZ4ULpOqt6E5afdZCYjQHscJrQPmdEmrI60g1Pc29Nzx8/p7I5It0J?=
 =?us-ascii?Q?U8SVy8QLpimnO2GvCxMnmDo/K51oN7YloUaTTJDF1hes89f4/ekXkbxT7j8t?=
 =?us-ascii?Q?47ElwZTl6h6pBqNmnZfnqYmSa3gtcvDS9HyVClIOZ+eSTeJoDF+qin5Pd2Dt?=
 =?us-ascii?Q?pmHM77ZftiXt51ifP6nIiJlLZ4Iwetjx5QCnkT3OJHMvymjsxkvJM5t84Utf?=
 =?us-ascii?Q?NuPaM76gEXJ+YFWKCIz1B9Qfyt3iHe4VLag49WSDTjCr9qzYvGZheKno8ppK?=
 =?us-ascii?Q?4eecmW6X96A1QjpKLBAdbS8vvZYgBIkW5rTr6lQGBOdXCx2uTkvGKt2Ysl3X?=
 =?us-ascii?Q?OtmmPpgtKWG6RM2peVd6G1TqT+sl5i96VLbPpVbNYeDSeU4IZuBbp27/n5Gh?=
 =?us-ascii?Q?7fIZn9AsDqWXbEGa5vnZjloqXoGCQ69NaGoBx02RXdc825HyTZLxXOurwMW3?=
 =?us-ascii?Q?R1QgorgmKboAjsZoaqkocfw91Edcn2jPMuGeoYjn7fLuGb3Rj2NOnF4J0r+j?=
 =?us-ascii?Q?PxOoSMnq5pyCqikdCG7RV2JMVwdFlMubhm4SeBEZB8YlwE5wuv5z+7bBHaAM?=
 =?us-ascii?Q?C6kP0EVw/oeAYLTtLp/BWd8SyrvSx6tmkWTJh33p8EtC/vyLCbejGajFZf+f?=
 =?us-ascii?Q?J9vJTWlXVpzgFmV5MwYUwXpbidRtQ/86kaml6btLmWxJvQIK1UGFP6QIsBNs?=
 =?us-ascii?Q?YzeTrdlIFohWuuvslpBp+RUIm2ReK81UNrCXNiU80Ghe6RR9eht+LLYzXomO?=
 =?us-ascii?Q?EZuep8WdCo13sa2hp6X7e9CwmjBOO9JN3p0qD8buXDqUebogAMaEeP3olzaS?=
 =?us-ascii?Q?ssTG/hTKLi7KxtPj1JGYYEIARFTNjnwdi8dQbBr6u+ZGXBWgGboledZJZ7/7?=
 =?us-ascii?Q?j6HIuURwURjbCxruu0zUBUoAB0M8UhvPtcRQzB62tzR/VZasn/lDsRM0x0I9?=
 =?us-ascii?Q?jp6HWp2c7WfHxesVuHs1k5DSuiBAVBzwaVF8+oDpv/aiUC47nbYad0R8x8nL?=
 =?us-ascii?Q?MCiZhOw4aHuN4bj1+RO/soXdGsHWpn+GzN8F8E6Yq16pxu5AKe3P3oseVVwN?=
 =?us-ascii?Q?vcoEWk+0IDaSE+g9BRW0TR11Jv91Kvl8lJsGL7uzy8dAX7Rq9EfHncibq/Jm?=
 =?us-ascii?Q?R7SHXlQrEZQPDoLh3Hblfa6vB+5zMWx3qaaiQqBMtjtUd4PLKBAtdgTc7s2k?=
 =?us-ascii?Q?7OI7eL/G5d/+nLiS3GBN94cRILEEMZ/aa6NnF/Xxgy2qvRs13BTSSQeF7srn?=
 =?us-ascii?Q?IQwUFxtZZibZ7VwN9rojMUm37v78k5EfVnNSxT5FnyHMUyK4YzA7QbZHYWyu?=
 =?us-ascii?Q?tdH1sUg3pwErR+YntRBQqtKkWneV8BOA45JDSzEWMH1G6ErgvcGgSYY+SJ2n?=
 =?us-ascii?Q?9WUe9tq2fkHus0qMKDj6bN/wZtyZdZudc0nJmS4H0hRnrBEJGcJzLOxrL2WG?=
 =?us-ascii?Q?Mj4yP37MkfY8hW8QHe17Zlsf9lKOEo/w+IKSGYepmN590Kxf65NvfA4rZjuH?=
 =?us-ascii?Q?dBPByiw10jxWwI4fS68ntF4cZt243EVa4OCGDhegIzcE9pqgtzBaExpGuFLx?=
 =?us-ascii?Q?qYZHwWeUSv2GcRRqVmrWSUFjp27fDAdZUjjEhJrpaslig9He699Diq2GLzly?=
 =?us-ascii?Q?kD6FRrN7aekX+Wtl067fKkHG+P0Tt8KRBbLV+wCgfytjpGhlN6kOEd+jwcaC?=
 =?us-ascii?Q?btjbCQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3YO54pMmy6UOwBmrAt3/Olggm7hpMCzDAcqVHilbcsDDgAp3oVpT3xekfNz5JoMEwafHodqQQkCUo2q32jE8X1y+JCHaka+v38nSGa90WBrKEm9cN9sp+l5FsVd/PbnVvhxRTIeh1waGiS9cX9AfJBL4j0B3nGhVTyGcXyE9xrsvIxX8WfFuHx6ehuY4J99qbHpubXUopYgYN/p+61+7SQCM3HmJzdVefQia7WOfpdQZl8hV05uH+c+i7aPClwuzQlWiVx+x5IFpXy5lFNDvHb9kdsQ5pp46cvENhonpbGWLWrSmtdfflThgv8TISBHnc0HmU/M/1e7/uEcVhXzsOtNTKagPTmHVDpkfHhfzZlY8OLNvlwuQeYjuICn40WE9B3bJUEkM9YZJ9rx8vWOPaa342SDYK119egrH+N3+MyILteLMwnsi/h3KObVjlfFc/fJLJWgScOLSYEv59eq+X7wVzFN3c4qPZfmv3NZJ9aTgFT88M0HRhGJEzNv6eUq4zXrYhlZXKCC7EyNOIUy7nIM2w9u2+F7eevh4qfUjyQRhMoOzrVFkQxYZMwwAMzK50jvbdCrigEEeteoVSem59p/k6ZkMckj55TA232wz5UU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15622f73-08cd-446d-65e3-08dcf3fe5e3c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:35:00.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAAVp+W9zrtlOFx4yk+VNuZnP+d2+x5Gzg6QeqHqA9ES8BBSwRAfSAjz0kCrU9PQ6FNRfy7L5YxPYDWu4jPaP2YmtnqqC0cGOu9epqRYvO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_07,2024-10-24_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=798
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240058
X-Proofpoint-GUID: vsBb2VxhYgTOgTDejwV1BE7GZ5hiKXDO
X-Proofpoint-ORIG-GUID: vsBb2VxhYgTOgTDejwV1BE7GZ5hiKXDO

On Wed, Oct 23, 2024 at 04:04:05PM -0700, Andrew Morton wrote:
> On Wed, 23 Oct 2024 17:24:38 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> >
> > ...
> >
> > Existing mechanism for performing a walk which also installs page table
> > entries if necessary are heavily duplicated throughout the kernel,
>
> How complicated is it to migrate those to use this?

I would say probably somewhat difficult as very often people are doing quite
custom things, but I will take a look at seeing if we can't make things a little
more generic.

I am also mildly motivated to look at trying to find a generic way to do
replaces...

Both on the TODO!

>
> > ...
> >
> > We explicitly do not allow the existing page walk API to expose this
> > feature as it is dangerous and intended for internal mm use only. Therefore
> > we provide a new walk_page_range_mm() function exposed only to
> > mm/internal.h.
> >
>
> Is this decision compatible with the above migrations?

Yes, nobody but mm should be doing this. You have to be enormously careful about
locks, caches, accounting and the various other machinery around actually
setting a PTE, and this allows you to establish entirely new mappings, so could
very much be abused.

