Return-Path: <linux-arch+bounces-15806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90FD26E51
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 18:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD10D3028893
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85743BC4F2;
	Thu, 15 Jan 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ONAeW3G5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UjJ52Kn2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DF2D6E72;
	Thu, 15 Jan 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497861; cv=fail; b=UJ347qn5seyfiGPP/bQDQlSKOsvr6Asukp386eqny7kztKsUTZ8NZMuC4/9lixmTa4zEvCAlFcZut7drMHFVTMaG8myU8D9ZVtCvNyT16E5a+EE6RMLtLreyru+PNSImKwCIeXsda5210Wo+2KIVvnJ1Lrm6Sqk4q/yMWp2zINE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497861; c=relaxed/simple;
	bh=BnkOUBF3xUmhROKq38g3RUUU5ULtLpr0Ievfv0yIafo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CMTO5CUg5UA2YULx6pUI0/3OUV2W/RIoPPei2kWHX9DFUa8hD7Uvs/gqxT/8wlXjvYLr/g3JxmZJ1FOeOlUsUmqbxyCBIaXfAJo8uQ8YvOUOWFDk6KtMFsNDIzyH6hDwol8KcQoka8Dq5mIYOKkReZh9ulIqxIN8Rc13bTMWYeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ONAeW3G5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UjJ52Kn2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FDcuDK3643762;
	Thu, 15 Jan 2026 17:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VRxeQY7IwbY3FbWkWq
	f1UCQHc68BB9udhvBUae3JkM4=; b=ONAeW3G5NlPU84NirkNoNryMHxoB9wPvWW
	W0w0PJDcPyMfe8RcRWxwhKtq16g51tMjiOqi8zWIUeMTxOhy5iEc5EScj+Q/BcO/
	1bzUN4yNFQIgLBHAxKTTOFKy7mDNeksgZgZSECa0t/Ugs4qi0+38l+1RsL25lgKu
	0mOy+9IUAZQRQaAOqlspaKWUDV6TZVr5rhfPeuUXPl3qwRQYosdYB+LIk83Q04OM
	EeAZA6sJNwZ80iXOB5ygiXKpz/7UFx1mQt3p7wVNjTEnd3B55b5B3JkrxSX6kPYM
	KpJtlw2R2hus/Pc21VqTCWquY+X/AgOiEwBbR6YiIzTHxdlEVE9w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5tc3k4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 17:22:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FGW1LA039133;
	Thu, 15 Jan 2026 17:22:33 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7fc1hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 17:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y36GMvrzP8BgjejfxJH+vFFDBZrbf9H4iArvftUO7BB8X2huqYkUeZJIaVema/dG9X/+1KUZvowFrif9E4xGWc3RBvdKEgzx5sf4fDo0gM+bxJgKkr+5JNfa/Ru6u0zcH8XE7aCrkdUf3AAwA2zwxlNa1i/LXcAtvblDXFXBa9nyKHBsjZ4ibAvqGo0qDJBgm9kOa3JiFrief0JECk8i29hPTciSom86Mw9yUZpO7pZhdO8UUfWd+AOfrA5JqnPZ+K4Y+WVpgAE6cDrSlOuHeDjy81E2NrslCcd28XFcSMg8er2aJQhTJ4c2CRiVlNKLIuR6olH/EOFDy+LVzKLmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRxeQY7IwbY3FbWkWqf1UCQHc68BB9udhvBUae3JkM4=;
 b=iGyxJYec45tN9CY4wdUauP+K4aM4BOnXKLbCM7dXuSBCqve+w/W6e8L+fYThzs72YjjjM85BVPADAnRTV4QoWH/NjfkNATxaw0sAVIADIQBKoI0vMiqca2jEeaJ+z4hQ9J8UO/iFQkLPohu6R9jpnmernf9BbKMeWJ4iZIyQfEOsSAYQUA7FspypmNPgZqUohax6RWC+lcu4etwCxMiiP+ipgoQaOy81bdPJGTVQDI4sBkLtOOt/jYGHMeiHIYUAdjYwQjLkbU9T176/jkaf5/DTLcsR7JdHHoHf6UEx02lBLT/326uMJXU2y4AogHgQ1DDMM/WA0qPivhIdt2pvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRxeQY7IwbY3FbWkWqf1UCQHc68BB9udhvBUae3JkM4=;
 b=UjJ52Kn2U14+tweF681yTs0RTw4WTGIW+o0ix6NwgL5SObcfiinqdW3Ha6tSEB7wqaBuwEmPrCP5KPAMfe8D06tCwi1W6mfQq7ic6aeGU/SXFeV94B8sOfowUaboLC3MnMC5WevIKjqgB7Z9887xgwCrNUfxuyZ3TaaWpc7Kc2M=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6109.namprd10.prod.outlook.com (2603:10b6:8:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 17:22:27 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 17:22:27 +0000
Date: Thu, 15 Jan 2026 17:22:30 +0000
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
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RESEND v3 0/4] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
Message-ID: <fa37f15c-e5a8-4502-ba82-c077ee7b8e5f@lucifer.local>
References: <20251223214037.580860-1-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223214037.580860-1-david@kernel.org>
X-ClientProxiedBy: LO2P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::24) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: d08773ad-a168-472d-8061-08de545aa795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoYokK6Ywa2W3xiPYDEDmcp/Fl56jJyDoAIeN3KPEomb29sncNJeyAjQqi8l?=
 =?us-ascii?Q?Yujz1z9TA7PK+3gFEJQ3aLZ4lZRPEyIETIhPJpZjVqI4nH5umC3kryQzPL2L?=
 =?us-ascii?Q?dn3DfK/5UE3gEXOAVjlgi1RN3SF+L8EWPBFpXVKEOywjed5OptQQcB9MwVLR?=
 =?us-ascii?Q?Re6fT44NPutYxnldDJa/lc8C72Pi6zMqSdl5zXpOfJVKZr6GKNOs0bKkrswd?=
 =?us-ascii?Q?qHURaMpdKC5iHuHf+IEPpG22dtaCRcIO0wPd3MtYXct3LzHsaiQRapLY9F4e?=
 =?us-ascii?Q?VU9bwHnQfcSnzd8mBLi9L1sVE0Ya86T4EB2Jf6XRtKRwVRzsDiWmFJyFL3z4?=
 =?us-ascii?Q?eQxZV9EKlKq3cwO2N0Owsm7liig70NP27u7NUN7UwwyWSSvTfMVne8yCUwkn?=
 =?us-ascii?Q?zG7PZ+OsrIpAweRama1/hTwltex0VybRHwMgrI/d3xWj7TLVDJaepwTntIJA?=
 =?us-ascii?Q?gO+/U6BjQ5wwUCBX/twO9eBNYHc6jxbsNF9BNGqMh5Jynky1jxp5tsPzkaOu?=
 =?us-ascii?Q?GHEiwYzfKnL7EVDZr4gy1ypkY6u5QdzCvVbz/AyFldsP+v74KLRrHFxnloQ/?=
 =?us-ascii?Q?VyRBadcUTkjTWVpbvusMHm6VjG5awXwD4uadyolGEgWVyEJ2sh/KRsd7IUjo?=
 =?us-ascii?Q?iQPT8FwpQquzwnDpzi6PG2C19PGad+FtVppbge6DyAtlK45aAd2BA+0PhnUy?=
 =?us-ascii?Q?0XRFG5Q1C7RyxWiuW28K+nV91Uv25a2HtLXMyuR0To9iGxPW/OEGPwlyuSNe?=
 =?us-ascii?Q?asQhgtZ9/WHzrlLZsqoJA95b6zInV4ZAtX+fXlLttEubzu0qRBrsrZ5a2gPa?=
 =?us-ascii?Q?/4FTcG25kelzZfoQGS8TUiTlFoMWvOYyHZTDuVKsE2zgWeeRXMH0yrkvWPBY?=
 =?us-ascii?Q?TMj9FniJRro9nFxuSfN6gCjab0D47Jmc/n1RQZqIb7AUE92qMXWZwyDNCTUB?=
 =?us-ascii?Q?sWyU+xxlDCjd+4Mw4SXs5CKksMcrefxG9q2A/EtMkIQZMhrLU7OOIL3Layr+?=
 =?us-ascii?Q?qqpePwlqdyA3X5fmhiSDHsudKYFq0nAxlTf2cM/8ZHm1GDSrJJLOVZNESCOZ?=
 =?us-ascii?Q?X6AYnYlQFPJJF8NJ2lBmMTMr4eIwuhwKSmShKm/blv68bOnKh0/NtnNnmnnH?=
 =?us-ascii?Q?JZCQp6UKPE0niIFucQEX97/cxxuMOl+5S5vznrdHjmv4xbizjVudpa9rYxsi?=
 =?us-ascii?Q?UzKerhrFyG85iosiefV7bV449+5bh+GoeRwlfdOLDSE9gHBlB2rHN+Lab32u?=
 =?us-ascii?Q?5e+OWPteU8aGrzjWDgknbMoURiPrkvPOfNwPZMNBu2FH4NrUrf2P8xebkDTP?=
 =?us-ascii?Q?iS892cG0GiJqtADac0P5m2pzsG9ykqhXlUJcCfyNkwbtzavfay8EmA8YurAS?=
 =?us-ascii?Q?BP9AjEJH5096BuefxPKUx+cxhfWE7n7Hn2HOylnpTLQ0jywH/4O5zRJdvTob?=
 =?us-ascii?Q?nsdgMAyQ5LG12KSz5nI/AC6ZfrPxkhnaWffcw19e2Tchs388fx0MgmtLDRQd?=
 =?us-ascii?Q?cCLJ4XlvBeGLkQ9OWEW+ng6+3AP6EH7LoTfLYbG+xCkNyPfZRfAWyjUUGghp?=
 =?us-ascii?Q?Uhkptb9+arte8f3IxDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y0tTSL3OhL342kSDFeKBLlKIhX6Fy6FrnNpSZi5Dqm9/OMc7WhPGLOEKmNOj?=
 =?us-ascii?Q?O8pfyq35k+OZ6fBzmmv7sq0LBf8Odeou2FfQc1G3d93izS5SdMyqKJP1F9Ua?=
 =?us-ascii?Q?+MbFn2y4odtkH/kb2KfArjPmAes6RM6CdL0iSFINQCoeNmDbyOVe5VjVUqUD?=
 =?us-ascii?Q?kb0m0Zyr1+Zyt+1MkRxCwjqutjCRE5hfl4w9Apl/kmeOq5N7lLmQfMh1YQN7?=
 =?us-ascii?Q?VN2N/hTv2jU3R2DzZKFBmfaLpC+rKJy1tsImUN+aCm0RbasPx0XovDHmn3cJ?=
 =?us-ascii?Q?gzBUydl9C3apQIbDzwZLy0WQxeMs2pk2Xo+Vnd4sQyo02zpm5RfWdeBxPKuq?=
 =?us-ascii?Q?yPXs8xOD0kuQ1Z/IPGXMc4ais3SQ5j0IukJoO7kadCP6h8LPiIriUqSCfYyE?=
 =?us-ascii?Q?CyAF5tesvs89j6bMdPaw05TOA4w7K+ewIiz/lyNr3MspQYUuW4AM1BjRauWT?=
 =?us-ascii?Q?cU98NUDT8vCIMf16sz15/ySxFD5S/BjLz1t0RES2IeW06cTlF5ZU02gQU2YQ?=
 =?us-ascii?Q?ibOgXuyIGwtcpyMOGA/tTX/lKrI2mE83H/HqRcVE49xesiAtDiGkl9Ik6TUi?=
 =?us-ascii?Q?EaXu/NdpMKAXrwK8N2XXl5fx8Emi/VHavCxjbBw4p7QVB2jLWPs2H9blSKpi?=
 =?us-ascii?Q?jlfP91/c1EqvYgO+TcM1HPT+I5dEXQGDt1fB5dCWYPhQM15UisnglYxdzd6X?=
 =?us-ascii?Q?cXgo9sk5nzLNeTAUPfqNjew84mmiduIqmJrkzoiBmTaufPXyn+klXEwMZZLq?=
 =?us-ascii?Q?lqfFFzyqpbqPkxqJk6HUfj3jYeoAA4OkOJ7wOs4JcSFs7JDNl5sl22RDUSw6?=
 =?us-ascii?Q?X8KDYo0Re6C67GS7anvHhHSL6QstZ9lpBIp0OjXCtfU4NhxsC9WpvezKZ9lj?=
 =?us-ascii?Q?JmlGXrEze9Lsig8vrVpRlJ+j7JBwCNMrJE/OMd3DPUI/zdV08YkTzyeVt8QM?=
 =?us-ascii?Q?GeR9vQPGAZOgmFX+yiyammFjNEvlpReYVCDeed1GuaWvp2su+rO+hLwIarZL?=
 =?us-ascii?Q?PHzHUKboh51LUWr3LQKEVBIBsTnYjP+TOi0dgkM++vnln16t5XyfTl0HFJlG?=
 =?us-ascii?Q?gqAMbiJWkReN+PgSrClwIunURdirv8D8ZcDTS3wUwTykIJ1+PsGN2/WmSY6W?=
 =?us-ascii?Q?8JeNkEtrhMOHdrDIg3zGDESL7Gof2c8pQ7Q2u540dUQ+Br6EFRBcyzuIQGLl?=
 =?us-ascii?Q?dm8dfs7/VQaJpQLguXmRTSgjFdksjVdmQWfWDS4g2g1+CuPOHHgl7qyjJlqO?=
 =?us-ascii?Q?N787j48lpDXXeQyu3liwG7fPKsB5BsdIuQobi5o4jazxuHqjzdyvuUTk0ePD?=
 =?us-ascii?Q?joRh+GDhOfo5VmMvCIrE4rEnvNm3PqWGDtpqM1XviugDwmcMgUdc/ZRSVmXs?=
 =?us-ascii?Q?0+GSYoVldyoox+wqLrx1XtoVDVDy3gVSFnzATvM3i2ZVcE+CAZglfWLX6gGn?=
 =?us-ascii?Q?ikop2l3m0ok3eSW6/EI9mjyrpaIJs0fyqn+Kj++BB5eVgfCMB7rybVwAjjuI?=
 =?us-ascii?Q?WLqPClcksi7nGUoZuzETa+FH7+JXF7qjoBzhcHDjuIEV2klZXew5YtIbrs+X?=
 =?us-ascii?Q?EcehoTff9U+c2sduyQF6POXTZmkpU013t8pxGLT91G/WPFMCHP5yjY3+jLg4?=
 =?us-ascii?Q?LgxStwu/cqnAzLh9ZlDj1BmVOeMDWD6Fxim2QVE1l+0StFLBIfAkNYhW+OGy?=
 =?us-ascii?Q?nAB/ugjEBLUCHqTZJT02f+e9JZxlTr3cno8nXk83zwrSyUrwWiPbHfsrmY19?=
 =?us-ascii?Q?U+WISbwbfJRilx12tF3g7zrenwEP8FA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cmix5CubHdsqPVO5XkP2D+IAfXOacfTZKVLFJNwr+ug8Ker+xZ9RPiuIXJXYX5hYEI78a8oXtkPs5rPTZ/ESAZaqft9LQQYji5K0hxEB2wqU2kpl+U7GGv7Uu2m1lhgFAUvmxtJUaZJI4smAKJuGwSq5UazLv0dg0dkh5AZRXK4sNI1cGd620uKe9ddsOUpate8xpTmsqsw3g5jPT1du6ledZJk+a/ZQf10nXmQdYVte50z5+8wOEPTGRN6lbcZ6ZV4e0ccNB2BJnfpTeCPfQD4E4m2bNY4TaSWkQK/gOEVlgxlcDmdGEBIWDmT26u1E+YEjgUp0UIIR52Gq0i+489x8JwP+5jD/8AQg+zRqjrKmhuwrBd4+NXun+BzscgKaF+jhYjQ9S/piPPRwxc3hOFAtz80ldtAfn63F56uau4BTfX2EHpz55PV+FojeeduZD3C+Ne2A25p2r11BHQxm4skA50PPgEKHpfe3QiydDz3oGqqCXwmMGSdzpOAKRRn7h+FJB50oMGK8VgNFqwT3HrJH1ELPrf3PVcuo78XjVMYplk61K+KlK9vo+RHESBrXGmJp7Lm5waFtY2fH2Vi6anEhOJFn/bH/G913XBwR7bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08773ad-a168-472d-8061-08de545aa795
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 17:22:26.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFVcREFfUdfOy9aUEPI0h+GmMH/9dxXRGfnuEkmqRMCdmdIlB+Xb4OXXVQbI23IugkXdxL2Uj48YANtRST3t/9OsYplHp1OFqSnzp04Yhxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150133
X-Authority-Analysis: v=2.4 cv=XP09iAhE c=1 sm=1 tr=0 ts=6969225a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=fwyzoN0nAAAA:8 a=20KFwNOVAAAA:8
 a=OkVqU9m7NFNb-lFjlXQA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=Sc3RvPAMVtkGz6dGeUiH:22 cc=ntf awl=host:13654
X-Proofpoint-GUID: 5353RquWYz82Si12ysINEhy7CBe34e0m
X-Proofpoint-ORIG-GUID: 5353RquWYz82Si12ysINEhy7CBe34e0m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEzMyBTYWx0ZWRfXxnxn72FwDs/6
 Wj9nciyiInoHdaUjl4n6BdipGCKjiEsKVm58n8ROggQajUZF+Fr7qIM6K2ox/1yFSsqM4GttvDX
 zYQADsV67ce8pgqkt+CFjHZ/kqvRxBFr/yxpCHzFk+0swBJ4VqjADAZMS0UnvT+qMZYOzNxBX6F
 H3czWS15QTsY6REd3yA7b3YO/o5dTk7CI4NFjcQ+zAPueHM15woRryXfCRV+bxhdxH5JTGa5Gr6
 3/jk3O4QJv6fkg3N+Ql1JcyavelAWjv1910kQQjnXplJO3pwUYBUN54VjjQ8AEnKkGrkbpVIiLB
 6zZNmFPe84/59vSp+/CeGAtX9y1ZAcAh13zl496UCnTudJBRBH/dAcOGNZA1Q6Rw+fTBzCjy3AU
 b+4luwDTb3l5XOLX2Y/KORSwD8Rh3lsQ7AMZCdTjD1e2eXtsS2Yt92tzE/Hlk6kzy94Y7Jqy3/S
 MmtveCWywsFZnKy3uVzhjkdrNmEcxGwr6QLQVXqg=

Hi,

Any update on this series? It's a hotfix series and I don't see it queued
up anywhere in either mm-hotfixes-unstable or mm-hotfixes-stable, this
issue is causing ongoing problems for a lot of people, is there any reason
it's being delayed?

It's received extensive approval and testing, so should be GTG right?

Andrew, David?

Thanks, Lorenzo

On Tue, Dec 23, 2025 at 10:40:33PM +0100, David Hildenbrand (Red Hat) wrote:
> One functional fix, one performance regression fix, and two related
> comment fixes.
>
> I cleaned up my prototype I recently shared [1] for the performance fix,
> deferring most of the cleanups I had in the prototype to a later point.
> While doing that I identified the other things.
>
> The goal of this patch set is to be backported to stable trees "fairly"
> easily. At least patch #1 and #4.
>
> Patch #1 fixes hugetlb_pmd_shared() not detecting any sharing
> Patch #2 + #3 are simple comment fixes that patch #4 interacts with.
> Patch #4 is a fix for the reported performance regression due to excessive
> IPI broadcasts during fork()+exit().
>
> The last patch is all about TLB flushes, IPIs and mmu_gather.
> Read: complicated
>
> I added as much comments + description that I possibly could, and I am
> hoping for review from Jann.
>
> There are plenty of cleanups in the future to be had + one reasonable
> optimization on x86. But that's all out of scope for this series.
>
> Compile tested on plenty of architectures.
>
> Runtime tested, with a focus on fixing the performance regression using
> the original reproducer [2] on x86.
>
> [1] https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
> [2] https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
>
> --
>
> v2 -> v3:
> * Rebased to 6.19-rc2 and retested on x86
> * Changes on last patch:
>  * Introduce and use tlb_gather_mmu_vma() for properly setting up mmu_gather
>    for hugetlb -- thanks to Harry for pointing me once again at the nasty
>    hugetlb integration in mmu_gather
>  * Move tlb_remove_huge_tlb_entry() after move_huge_pte()
>  * For consistency, always call tlb_gather_mmu_vma() after
>    flush_cache_range()
>  * Don't pass mmu_gather to hugetlb_change_protection(), simply use
>    a local one for now. (avoids messing with tlb_start_vma() /
>    tlb_start_end())
>  * Dropped Lorenzo's RB due to the changes
>
> v1 -> v2:
> * Picked RB's/ACK's, hopefully I didn't miss any
> * Added the initialization of fully_unshared_tables in __tlb_gather_mmu()
>   (Thanks Nadav!)
> * Refined some comments based on Lorenzo's feedback.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Harry Yoo <harry.yoo@oracle.com>
> Cc: Uschakow, Stanislav" <suschako@amazon.de>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
>
> David Hildenbrand (Red Hat) (4):
>   mm/hugetlb: fix hugetlb_pmd_shared()
>   mm/hugetlb: fix two comments related to huge_pmd_unshare()
>   mm/rmap: fix two comments related to huge_pmd_unshare()
>   mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
>     using mmu_gather
>
>  include/asm-generic/tlb.h |  77 +++++++++++++++++++++-
>  include/linux/hugetlb.h   |  17 +++--
>  include/linux/mm_types.h  |   1 +
>  mm/hugetlb.c              | 131 +++++++++++++++++++++-----------------
>  mm/mmu_gather.c           |  33 ++++++++++
>  mm/rmap.c                 |  45 ++++++-------
>  6 files changed, 213 insertions(+), 91 deletions(-)
>
>
> base-commit: b927546677c876e26eba308550207c2ddf812a43
> --
> 2.52.0
>

