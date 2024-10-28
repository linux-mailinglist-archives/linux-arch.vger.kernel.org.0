Return-Path: <linux-arch+bounces-8643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A559B30BF
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F311F223E6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22001DD559;
	Mon, 28 Oct 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJdVNH86";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uvkKwmfJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDE1D5CC5;
	Mon, 28 Oct 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119427; cv=fail; b=rzoEra/0p9FrSdybeSSQoaW4N1OJi92RR08BxJUoIBbP8rwjtYHIilQkuTp7W3tGd+RRvxikW+BKcW82lkxBjnz1zDCakZH0l506/aIp7tX/z4U2R0TWMUrFqa31O9bgNV88cS99nR6pODobjIeEZ6LtpAAnFNX5dwxM7okVGus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119427; c=relaxed/simple;
	bh=mtgL3WjNnM4ChVsmCwAJDyNn56PdbJsACJb2WMmJLiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WQXVVNcpYq2QTuxHamTdW+dZrXwCHdwqmufZx38HAnb0vmj+txWyEF8NzRig55IYT4HK8BAGSVGVOmoDlIcO7TTYkwDnBK/ePj07KTrIUy86BytGGsTBnHthAKxJHuEyKfg5CAPKaT5tlDzj2Jfh7lo1mGkeFSTCA2CmI1c3uUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aJdVNH86; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uvkKwmfJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBSeGQ008458;
	Mon, 28 Oct 2024 12:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EySAqxInPcn1ZDqtvl
	AUDKKoUf3OukEc77Gu4w4X73M=; b=aJdVNH86ED18kNOja1pVm54Nj31FuNcOtJ
	8I3/j8Np+hdhVna/bHgbU98vzRmm28PJ8GBXIPcMh2B2PuMHDdJ0Atf04pekwe4c
	newA9/Wck7c+M8usvikjYnbwb8lC49EQn8wf2NB55Ujgnbed5H751ftSoKMTLGOn
	h9AsRq4MqvsqJX+ILt5YJ4X3MRYnzEjrCIsssmgoSlUYQm/jy8iu943O9xANYS8z
	KCUjCEPat3wUPrsyexincGn/Yfi4bfTfC2fFDgqYsXU894R3ygITi5tC4FEFna9A
	mh2T6DnG6+EAXYFuxIB0l/+2CS8BLRSvmobGmjEnnCpM+aU1VtJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1tp3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 12:42:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBdhZ8008454;
	Mon, 28 Oct 2024 12:42:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne7u7xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 12:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq5xYDh3cE1dsefs49+uh5t21sHYdrVev3xERZhU8GUp9WZH1KiPRJOxwvTBnJCznScCGfuRKT32GU/8QWxVq88fa+tti5MLgMa3NWXQk5XdLIY/NLJnNzhsi4fbaGzQAMZYHurMnJ7ixkgLEkaGw3GHOmMTzyXL3nLz5jEJ27+Q2clL87MpQp1z5bFaBgQwvKlCkUimVz4f7zr09Q1eOwkzH8EYSJUKPvCuQEfHV+v22+Geafts9kngEg5gEZC2HfwnYHS3/54hz2SNpPK+mn9VV9Z31YLpsKm9oJl3DngNrcJzyFV5/5sbiV47fr9XWET6bs94lU+/GWumdWQGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EySAqxInPcn1ZDqtvlAUDKKoUf3OukEc77Gu4w4X73M=;
 b=kSeZauCXkuHWqD5OaQQ4BPvPivmR328AJTCQ3sw/LxY6kr4wYdEyRMRfCqzPEJPw5LuRlr/8ofENUMCDuK1hO4pgAQ9Zskdo4mPC+sggX9j4UJ9YxXA2ag0tdG0UyWyixmDWWkQFi3NS4I1ZaHdV1OtkEETukpsUxo0YW9vK8d7eNx06X9cNJpV9OxbWF+7vO36W3MQlwMd3GkHUOzO5yLQejVEGn6rrVPUKG4t8Og5dVHbt5VP02S56llcPOOlYM5RxorxfY/Y/qkTVZKM7hwRxxYCWRXFJWO7oEL5LXw2QepKvSaaPN91NuRp18t0ZRI5GpowbaXqGQcalAdjxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EySAqxInPcn1ZDqtvlAUDKKoUf3OukEc77Gu4w4X73M=;
 b=uvkKwmfJmjSHs2MYQgwzJnfyK8sYvW7LLACOFF759f4PXLcjEXLJ0jD9ycBoTOxqK17aYD9qW8WTMzyk1+VlhBPhqdDmQFPo5qA78ydf7b7m64fBvVYzQ5iR9IMsJOWyVM5U1G6c0SQG7u/9ZK/cpRY9/Y5eCXaUz/ScXac+eJQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6029.namprd10.prod.outlook.com (2603:10b6:8:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 12:42:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 12:42:53 +0000
Date: Mon, 28 Oct 2024 12:40:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <af06ecdb-d579-4ded-af9d-112f91e7d775@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
 <f09086cd-c49c-4eea-adff-d626c16083de@lucifer.local>
 <7c7185ed-f997-484a-b1d1-91ae6c761266@suse.cz>
 <c957ae63-6aa9-4a29-a191-1686ee31987e@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c957ae63-6aa9-4a29-a191-1686ee31987e@lucifer.local>
X-ClientProxiedBy: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee90f2e-fc5a-4f3a-311e-08dcf74e0a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?So2AWMtUEA/cfWjWRUqKUg7tXAryq6N4A6yNV5DiVtMpo9bPg+pTrW2SyAv4?=
 =?us-ascii?Q?/5blmyZetYpds7HYCoRHQ9Se6If8nDAJGvJjpMjnCWWpaoekKO97WAVSoCMw?=
 =?us-ascii?Q?1JEJidIPxwdGoir3EK7ifzW3ZBae3YQZN/Q+Jk0fKTNZGdhMC9cbLflaicVR?=
 =?us-ascii?Q?RZ0OukUnI6UHhdG0xCZbVnjUYykbxHTo/wudblL7P2d3MuK41QjX0g0/wrXY?=
 =?us-ascii?Q?aCa8b+s8XbuiCw3jUoE1sp4qAiVXz6Jpd5wO+EJJMCz/Q0VLeStvNOuUaiaS?=
 =?us-ascii?Q?bdiZq7GY1tpHncuUnPvbtA8jFaaZYAatzmu1jYDdsKUs2ZHGO3zGZAnswV6n?=
 =?us-ascii?Q?Jh6d+3m0XLkNzlNlE4J7z8KZhsPeeAdhTiQ5Nqs7rwFvJk9eXLK6n9tzzSxd?=
 =?us-ascii?Q?SKZtIfgvYr1jsX3Lolzr/ysuAenokH6oQApjdP+gBY2CHoSJf7cqRfM/d/s9?=
 =?us-ascii?Q?TBNOpZOSu36GT06rkNL9y3E4v1c4mdE4/DlxBk9+bUF5kPej+epBk4YCx3JP?=
 =?us-ascii?Q?Q7yk0h3RmruCtImgbIITvasRWpNGpAXrhYSG0YOOefM3rhDk9kxpNO8wuYmy?=
 =?us-ascii?Q?yVGomjj3Vx2CdqGk2ZBGAaMyIB1KjMTUG5pVKayW7BQHpVUSQQVVzdfnAUgi?=
 =?us-ascii?Q?Y2jso1rEOfClNBcD2/e2aDBnU2875iMNv+ixGqeSjPNXjhfhesMVT9xYdYPH?=
 =?us-ascii?Q?0fvMB76DghZxuID+klAIKirFaOEDRBh8hCor/gq3Gj/UYugHaAJdRFSIaznJ?=
 =?us-ascii?Q?fOFUMSSFyCmGMBUlljZF6FzXKmmfbt2/DGsSu+KgXfETj9feVrx/rg4I5G/G?=
 =?us-ascii?Q?yJBLXMw/HfTnaRr+mdWrBKcgQf/PyHt1ZSGv5i5dpXW5Hd7C06lrYBpVVbCX?=
 =?us-ascii?Q?le2FvN+iXPd37+Kdth7tP2rqmKRAV+IcIQb46eiTL52OrGvAs9LdVaw2rtnf?=
 =?us-ascii?Q?xomU95ftxNgRnTuCjCk6HUozA7z/lxjID/hrSvKmeD8zLoJFx/RyGHXiHkhi?=
 =?us-ascii?Q?tQsJC/SpHBh8WfPkprySJLkXQXEq3OdJsuJWWtWAPAE07Aqo0jMs4D5zI4Xi?=
 =?us-ascii?Q?eAHnWsrQXJI+9Zpf5sw83zkPIREmBHqHZGb5aSkK0ZW+WD9ifRDoEnBgLFzK?=
 =?us-ascii?Q?tS6DofVQEIwiwmt+EMdIgKJ9ikYeBhAHrd9784+qJ2B4TRLGP+D+2j6dELSL?=
 =?us-ascii?Q?6LcFEV+5SQDf/PikOHRs8mUcMyQlHj+DFV0wuYBj3SRK0mchwKapwWzC0omt?=
 =?us-ascii?Q?wREJWlRBljTRYx1kazx7q7M/oqeIhM20wupE6bHFc2WEJ6HuovFOhxi6wmzw?=
 =?us-ascii?Q?3KDmbaRcyy4QAUz5BFF4K9tl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zCaeOaz6nAMAs83nj9IDasNsO6r7qcqLfSK9H8805tlH2yZ7hhLyk1Ss1yOX?=
 =?us-ascii?Q?Eb3dgxLmiIlCkYfURgI33jfB9iRtjM6zAspo6pUkgiUz2YUOSe5ephfp4157?=
 =?us-ascii?Q?muo5QWrSlbU+BBzLX1+rMxZPWlO23I7/HffRA0O4mcOuLe+zCRkXpULLNpqR?=
 =?us-ascii?Q?e6Kt464eyWjqd3faJe0r+kugQ+DE3jhXfu3KDavx3d0Jl0A6n4PDxdmhY+qx?=
 =?us-ascii?Q?Iq/rV6/lz1feNUR9Gf1jcG6YYublrvkiuLzihaQpvGgha2QUTTmP4xIED4k4?=
 =?us-ascii?Q?tHWIINtkhIV8OJ4+bIuPjqJtnDJhhWDnTMnPAA86cnbqWbxz1bLUS6HZLOY2?=
 =?us-ascii?Q?cXnP306YaJMnLoCqmVyr3+HGoBpYxRIpPAlPPpcseaWECGjPlzgvINsg8rY+?=
 =?us-ascii?Q?4gSIGn783nbg3iRLcOKKKkd27Z78FioxMWR9J9m3jolVosaetKgfG9mHBoYM?=
 =?us-ascii?Q?jNIKmn7cOKwpqqsUIjFXNP29KfoOHPHIkaIKjje17eDn7xefgN3/OkHHNYnI?=
 =?us-ascii?Q?gOOX9YOL6EOBjWlsQw60/Oxi79zq8GhhbO6FEb0J6iPrvicv7nilnPy7mTJn?=
 =?us-ascii?Q?JhhcSo5SwzyQaAPtWIl3DITgpaazOx/Kza+qgmnuOkqirh+46cRCKo5b7x2d?=
 =?us-ascii?Q?hP86gT55birTNVyT4JXeseK5HY+SEL5R6llUost4nsNRX2L83NJa36es+NvP?=
 =?us-ascii?Q?8X+kl/KwCwPgBhCRHmA/+FrL5D4ASAJvn56ITQ+k9ZxI2A/Vu/7B/DYxyA5P?=
 =?us-ascii?Q?H26qmKjjAOVpTLfzIeI7CsR/MI7mfLcyXaApSA7KCX3NbFxYTtSYl1OZbAvn?=
 =?us-ascii?Q?Ct+Gbp6F3uIhCp3obtS3EZ8vYknxV8MUEWcNxEhj84Is5nhGDGBoqGojHhfJ?=
 =?us-ascii?Q?4PBN213aRmnMSaDHxgwmbWXn0N/DMUcQZ51ObIfb39I+83MvMg5iVMzA9O88?=
 =?us-ascii?Q?CrVHHQyv0zq+HsIQ4RkwVKd/uGKO+KrtSbaBwFRyLkA0usDeHsSjI0uAF/0O?=
 =?us-ascii?Q?LP4IbW7HJWj4/ej6duScRMxWWvYgGxIuVkOA3i9ov10FCpouubpYySVsSDLs?=
 =?us-ascii?Q?b9nH8J7vl2aajtWh8nwF+7hUkjMpKlCaOdd/DfNX8Y2DRQNoAdu4zQ1ZrGc/?=
 =?us-ascii?Q?J65OxUCBSknS1bg22ak6gt3NR7WdoJq7oK8SHMFmbdB4crZh9Ef9t/U6VhzO?=
 =?us-ascii?Q?bidnNlMIgCnzzyvuxvD9mPglJxXpJ1SZ8bkWkUdGtXcBXdeQ41dVfRFvpYyT?=
 =?us-ascii?Q?jmZCT210X5KE3/79R/V+hSZV3v1rEHXpNdTI9vJK6VU5sBBvz6AM2oHMENtH?=
 =?us-ascii?Q?owAaCIPACDV8h14I5OPjXYnu3QrJolS3sT6m8JH9Jc1OlY+RcKz4Fy8aqgQO?=
 =?us-ascii?Q?EFt5BN/e+MRgPRyd11Dx1lKZOenDuDcpLoyg7XKkiJXUevSGdQS/6doPVlp6?=
 =?us-ascii?Q?uzqsZ6mg+SYdtK/mW+0TUjipIQPHpDF0Pj0pn7TnaJX5QVteezTJasir30s4?=
 =?us-ascii?Q?3fR12gzrZwo3EDRoBmX1rTD26ngTzDNlN+T88vel0SgVJLnpksvrivGaMT7y?=
 =?us-ascii?Q?uK345XsdRtZe40Kpt9P0xf0YCGwFzNWGBFFV0tvyx2Lh7kbCAO3EbXjhZO/z?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xidq2JQeS3gyC1LsjkPsrGOYIzTZyGEtoCDDRE3GgaQ80+/CnPpxPmjbpaMdqAz94H7fyRCncx98EmX2ZNfdnsYcrXB6lCd/48WxO8FqsUuP4i1MxyzotT4jE54qJgenPleWA3kQ5/+pIp1bCus2S6Vaie2sCqwYmNg4FJ8Q+AU2eg7xvpZZD9JHr+xqlmHaRHAnM92gC6DrDfUXjIqAeB1eM8Rg2ebaKXZC8vBZ/zDjmSE5uDeiPwQi8lWaeBuSn2c/JeVPoVlnuabXERLr+It02G2x0VbFXH/75zBtP5OHLV7JajgG7H4r38EocydzqbUj+05IJwt8PWGA/I7v37u2tNeGRAFWJqv2jOJvwAxZgmlCh8nEkZBPSMDmHbM7S4NVknSGgbfZ48/mRzaiSh1HoPCZcmooHm89RiqcR6aFHIDlkrvF0nRZPjvTSgMFLxLhAtKKzk5X/86vx01gja1+b/JS70ZOpJ2PNln2IR2HFHp35W2mAOpkC44v8HkJTU+x0feIbxu/OT9PG5+q+BuEwib8W6gSCwJunffEq+2VEOA94hqOb9kRLepIeKWYmUi76h9FBghGN5tH42Fe0MF2R1R57oW3GfHzqqIx1aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee90f2e-fc5a-4f3a-311e-08dcf74e0a82
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:42:53.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvErOwxfrbBt1gUgcgAq5sLZaWuE2fI/DsIY86Zr7sO1wq+U+r8OkBJ834z41mE9EsIGsz4FKh7eF448823Ec0yZ/mYxGCjlhZxsvBuMuM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280102
X-Proofpoint-GUID: PoJ6J1TFO_IvDA6_tAAJvG2ui1Qhc1yg
X-Proofpoint-ORIG-GUID: PoJ6J1TFO_IvDA6_tAAJvG2ui1Qhc1yg

On Fri, Oct 25, 2024 at 11:35:03PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 25, 2024 at 11:56:52PM +0200, Vlastimil Babka wrote:
> > On 10/25/24 19:12, Lorenzo Stoakes wrote:
> > > On Wed, Oct 23, 2024 at 05:24:40PM +0100, Lorenzo Stoakes wrote:
> > >> Implement a new lightweight guard page feature, that is regions of userland
> > >> virtual memory that, when accessed, cause a fatal signal to arise.
> > >
> > > <snip>
> > >
> > > Hi Andrew - Could you apply the below fix-patch? I realise we must handle
> > > fatal signals and conditional rescheduling in the vector_madvise() special
> > > case.
> > >
> > > Thanks!
> > >
> > > ----8<----
> > > From 546d7e1831c71599fc733d589e0d75f52e84826d Mon Sep 17 00:00:00 2001
> > > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Date: Fri, 25 Oct 2024 18:05:48 +0100
> > > Subject: [PATCH] mm: yield on fatal signal/cond_sched() in vector_madvise()
> > >
> > > While we have to treat -ERESTARTNOINTR specially here as we are looping
> > > through a vector of operations and can't simply restart the entire
> > > operation, we mustn't hold up fatal signals or RT kernels.
> >
> > For plain madvise() syscall returning -ERESTARTNOINTR does the right thing
> > and checks fatal_signal_pending() before returning, right?
>
> I believe so. But now you've caused me some doubt so let me double check
> and make absolutely sure :)
>
> >
> > Uh actually can we be just returning -ERESTARTNOINTR or do we need to use
> > restart_syscall()?
>
> Yeah I was wondering about that, but restart_syscall() seems to set
> TIF_SIGPENDING, and I wondered if that was correct... but then I saw other
> places that seemed to use it direct so it seemed so.
>
> Let's eliminiate doubt, will check this next week and make sure.
>

Yeah looks like we do actually, as the function is handled by
arch_do_signal_or_restart():

do_syscall_64()
  -> sycall_exit_to_user_mode_work()
    -> __sycall_exit_to_user_mode_work()
      -> exit_to_user_mode_prepare()
        -> exit_to_user_mode_loop()
	  -> arch_do_signal_or_restart()
	    -> (possibly) get_signal()

And arch_do_signal_or_restart() is only invoked by exit_to_user_mode_loop()
if _TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL is set:

		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
			arch_do_signal_or_restart(regs);

This is set by restart_syscall():

static inline int restart_syscall(void)
{
	set_tsk_thread_flag(current, TIF_SIGPENDING);
	return -ERESTARTNOINTR;
}

It's a nop if no signal is actually pending too, and it handily also deals
with signals...

> >
> > > ---
> > >  mm/madvise.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 48eba25e25fe..127aa5d86656 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1713,8 +1713,14 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
> > >  		 * we have already rescinded locks, it should be no problem to
> > >  		 * simply try again.
> > >  		 */
> > > -		if (ret == -ERESTARTNOINTR)
> > > +		if (ret == -ERESTARTNOINTR) {
> > > +			if (fatal_signal_pending(current)) {
> > > +				ret = -EINTR;
> > > +				break;
> > > +			}
> > > +			cond_resched();
> >
> > Should be unnecessary as we're calling an operation that takes a rwsem so
> > there are reschedule points already. And with lazy preempt hopefully
> > cond_resched()s will become history, so let's not add more only to delete later.
>
> Ack will remove on respin.
>
> >
> > >  			continue;
> > > +		}
> > >  		if (ret < 0)
> > >  			break;
> > >  		iov_iter_advance(iter, iter_iov_len(iter));
> > > --
> > > 2.47.0
> >
>
> For simplicitly with your other comments too I think I'll respin this next
> week.

So will respin to use restart_syscall() correctly (+ fix up your other points too).

Have tested and confirmed that failing to use restart_syscall() causes the
-ERESTARTINTR to be returned and no restart, but using it works.

