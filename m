Return-Path: <linux-arch+bounces-15566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACCCE5BEB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 03:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3773E3015585
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 02:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C068258CE9;
	Mon, 29 Dec 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A1oWMfNt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NrGlv84f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650C22B8BD;
	Mon, 29 Dec 2025 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766975509; cv=fail; b=Wu4Vd0N1I50IsuAAOb/msIMe/48k0HwcEzqByVwcPCxzZGPnOf2W775eb/7E8ecnlxBve4iwSoc2HV3agOef+Jhb2I5cvEnW6fRKAhVunSDthC88TcMT58XM3fiOAFXD7SVlm++Mfoyii+6hqfG0ak4qfxDvmljjLVuBxp7jGL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766975509; c=relaxed/simple;
	bh=Pzv4MyQjbTHdps76WdWFhkNKEP9CunR0aBMqseB0hPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aqyxsy41HzwiXPhDvRKuD5sSWCk4JYJJA8XMOioBC4CeDnLCPodUJOYk1+GryrD1aB34wY9JRo4cEbHXEYH4krcMvR34MkG00S/5Pg3DD6OZOQwlaQ+H4/YcfHW91NhFR0Rc0l9uI7DU41279ieU6rfyUmXRo8Ni0UeTc5N0o68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A1oWMfNt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NrGlv84f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT1mkNQ669995;
	Mon, 29 Dec 2025 02:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=X569ReIJYLpyBbe823
	qo9K7S/gR8t2k9kKBN6b4uKO8=; b=A1oWMfNtloDxUTY4/zlDYopCUnPF8szSKT
	rw+CbvZTcP774Gwv4H598AsuLZuct4+1vYiJ7QzZiU0YA5ee17gXd6AOBtN3H60I
	ORYo0pi5wc1E1mpu9E0TChQzgRFasRBVyKwdElmiIh/cakvIH7nGfICGDsuE0Y4X
	Dlvc6JendZdsvOeQH2ZcDfGJ/UnQ5F9LkP4zxfcBVGP7af20yupcr9Z1daVr3UAe
	RBDrprl56XsJjx0M7SKDQCwE54MRrZnU6cLRkzWgaWR7vee05TBTky/f4gCoXwfM
	KYCcTNEd0MhhB6AYgnqGgTz3OyyR4rh4I4lUTZiMBGlfwqQ7xApQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba61w96gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 02:31:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BSNMwq6036141;
	Mon, 29 Dec 2025 02:31:01 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6s1cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 02:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyN4KTrHM1fuSqXZgcYKM72OFeeCxietEBA3rQBUAOzys5GamhK1bLbzsDIo8TKFJwNADhyzSamw4gz1iO1s4azZL2yoHYbxZVb5gJcqEsK0HmK265L9TGJUKNLUcQenCOHNJeLwwGF7j6VDFC9/ufDQb5L0+2uCTm2zlrHWLylHDhzPAhG054SL4WQPCpr+rl4eNqyYKSDxNOaaXS1xNcG8PMCLP0CaCGnuKF60mrWBjDB54ZwcDoAhPqCCL8noOVWARS8CBwKwwapNLvHBHH7DtW4nElqf68H4x+OWAQnQsl5XrmNvO9YnSW9gN1rEa8YWorGe3HnZEiVrLM+43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X569ReIJYLpyBbe823qo9K7S/gR8t2k9kKBN6b4uKO8=;
 b=k4TrPG9WhoKb3mCUmFlkSsk6NMvtnsxL+unRhRSr8ggE+LB5jAjob6fY14iZYmYrh4auV6il6dqP/1PGAhKiYo6Rq6+zKFu9AafxaulBJiMG1odX35TjH4siMjtmqoyvT9gWWzxL6w8pouVOz2TXnsO8BltDEKAepDRI6sKTXBolk4uaZeEzHPxHqWZgOSlMagMGPt9+rfnKO2QLmTegEiPS+fxuXw1lYElecwsk9P+qQ/3v+t/VwCWQZoROVKHK66w+7BhApH/TgrxU6aCrHlxpJleVpOV4+igbmLGbiw8p6Tdgj31Qnqft4fYCnnW6D8mrI2DN3iwaTeV0mzpTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X569ReIJYLpyBbe823qo9K7S/gR8t2k9kKBN6b4uKO8=;
 b=NrGlv84fv8JRA2VvJmwmwW8gOXrTkZmobUeDonNc7haIvga+n4CHcwKiBT9YqluQTV6xY8C5m4VCiKI5OxIwPHYzjOSBBuNN+EP4TskkMJ7+pviGR38+LioLxZ3eCcUElv7pMpzaadEz7hLzyz07izhqRwObM9vYrwQDg8OxE5k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPFA632C0238.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Mon, 29 Dec
 2025 02:30:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 02:30:58 +0000
Date: Mon, 29 Dec 2025 11:30:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 4/4] mm/hugetlb: fix excessive IPI broadcasts
 when unsharing PMD tables using mmu_gather
Message-ID: <aVHnxxOAGu26a5Cr@hyeyoo>
References: <20251223214037.580860-1-david@kernel.org>
 <20251223214037.580860-5-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223214037.580860-5-david@kernel.org>
X-ClientProxiedBy: SL2P216CA0167.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPFA632C0238:EE_
X-MS-Office365-Filtering-Correlation-Id: 16863c57-3855-4054-4ec3-08de46824cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWAifE7f5QT+IV9i7c/c65R0f7AarEVRYShS+37zyJWLucFAykFdG8aLc1tA?=
 =?us-ascii?Q?XSjlwmRSmnJZ+Qu4qlp7c4LLbTOFEQsdpHS5VNjMyiOCIPDzxGaOXwOYaKUE?=
 =?us-ascii?Q?LqEuWAhonVlxkVWXECb6dPoyH0p/bFgWuiCAeOJwrOd7MfOxEOTUzZfFGrwi?=
 =?us-ascii?Q?TeG7FmrvXblIPFLCg1/DxHxdR4b7R9U8+nNL+/ZHnMdfZ6mWf2aSwzNjAt+w?=
 =?us-ascii?Q?0iUytkomP1o5RFw/xmlAhe50d+2xlvVlXIg4eudOt2c/y2NhES8VjE5fnaRb?=
 =?us-ascii?Q?7wyW5uIM7sGOYuiBV2jCT2rdh3GcyDRz9pQw0gn7T4gJm5E6NjAag4Q+r/qP?=
 =?us-ascii?Q?fgANq0tG/Piu9fncRnd6Y8dOiHliqtAL1uJsFzr5cmajSQa7lT1shv/ET6VM?=
 =?us-ascii?Q?18s3pZZWKUz0/llWeSxwo08ggcJqV6BaMw64okK5YQ1lum4JOxaA2lktZnA2?=
 =?us-ascii?Q?GssRq6JtHF8vaQKB8JRulEenOjxAFCG7xZqDxQjqj+3nx+o6Rqm6m++iNmz0?=
 =?us-ascii?Q?cWid2npYDaxvdD1zdg1onaETdwbj2wemQtzksm22vSkqPTmEsblzHW9y0OTH?=
 =?us-ascii?Q?wgYohsSJ0ZB6Ry8H0VTl//QLO1ZIHM5j6S2XIybMSP34KjR2dgJDS76HFSQM?=
 =?us-ascii?Q?7vXeCGZMjGvFjOgD6LMpxs3LKkpBffULbqJy/lr03Co4iwxFcyzY8DWM3WJp?=
 =?us-ascii?Q?s9DbUlI0iTpTg1HXklAKXpZ/Tdt7Bkois3Uon9VpRZuqKN1gUe7Z20oR6DYv?=
 =?us-ascii?Q?SII/JALY8fC22ZCjuSAG71Z/187wQh2cMkqD4A6APB6zLW49QpJFwcwiwtmr?=
 =?us-ascii?Q?H9YUfoYWZquSb+8N7DIfstn5UGyPulohR5JMXC438sGWNfpsoiZi0cbbsG6e?=
 =?us-ascii?Q?FTnwLd5yTb/KNeia1r+js3GtFiLyum4isJQ7obzwovGQh/t7lMbGxdQrj8Uo?=
 =?us-ascii?Q?OmJ3uXh2FtyMHYPRB27Ah8Lj1zXdyx9529HYqZwSbCbCg/UF9P1mg5NFMYYw?=
 =?us-ascii?Q?l61z69U2xa52P/Si2Wtr3QyzM1nRYBZM+XE3x7x48za0bBuyMheQYLjgxaH2?=
 =?us-ascii?Q?fwEjrBrpWwj/Cek7T/yADf+LB5KfSwAs2IuPCQJhsUfeCAqBsC0FPO4kvih7?=
 =?us-ascii?Q?xdIdMDPtW9YJ1a0vUSbJxw4WjAtkkB0T2a1xrPeSi7/BcnN6aae+fMlDD07I?=
 =?us-ascii?Q?XEY4+7ZC2tzIrGuRe06f84Quo5SG+Ri48pxYFI5mXXUNW684WP52EJknie+w?=
 =?us-ascii?Q?1H7md9pWDYvU5TfQCaIriAPd/O4Eb2UFReKXd/OkCPGjRNIKp4chTOHyQvYN?=
 =?us-ascii?Q?YDJh6nvDPZqdklHnUlrC1Sa/wLCtIH/puBUC9Tf7QnCo7YVnjvbXUeZcynpj?=
 =?us-ascii?Q?yrrc1btkcl611F23LxxXHN8610HxYmy8QH6NqR5nf6tLFHq52EfYqGNvWV1L?=
 =?us-ascii?Q?4FfP8FJ8pa335xDL4WgtLulLcuTh4yJG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7we2YqsEyhLB2/QkH8qcq3QWa5p5nLMkfRF3Su3u88kFjOLuxXx8oGr9+ED?=
 =?us-ascii?Q?sHmP6HTtozSaNQyxQeWCKqNTIu9C9+/oC+WuKmqQqEVV5YxApCNDqDrq4fwd?=
 =?us-ascii?Q?iF7Wwqif34u7p5xI2IsoxCgvAQdWN1KdxmvawSN9K7G0Ri/lADDV3Wj0mfCt?=
 =?us-ascii?Q?D/mubsFEzYE0zgiTeJLuVnSkMN6335ry4QiiLrf/1jPI46GKKDm0FuqQWPaN?=
 =?us-ascii?Q?9CVTi4hxF57MsQSfhG3nN1hJ0Im68vIzBbjGtyy6HoQxg1n/NvC89/rrF322?=
 =?us-ascii?Q?VK4+mVRWeBLHR7orW44NPbRinYWPJ1Zz9dLTP9JviF0BPvkCVZ44m6guH7J7?=
 =?us-ascii?Q?C9C/r1RGWsMVFsI2DmkXxz8sWSSQWRWzanbORuEVWNw4KUeQ4RCxLwOJt8Nw?=
 =?us-ascii?Q?swucO0ipcVqKqL6B+bboJo15sWQ4iPxMmxMQhq3l7NKxOEaNRbapOrskjjsR?=
 =?us-ascii?Q?eA1iWIAjWPIIyVHmWwW5MrzBcqBndJona/g8RB9RvIE3StA/hgvjJL4CLFHA?=
 =?us-ascii?Q?h9EXg3wtPbcOZ4vZqI8YLAMhBzDOM8+w8qIRNWROQWrwY8bBY/zlMQmK44O9?=
 =?us-ascii?Q?qwIXHc1b2AKY8xEZyUa7ayJgMNj65PnSKwHOdA2a0tD4jG30avAUE67wlIWP?=
 =?us-ascii?Q?c80m5J+KDVO3TTS9FxKOYXJn0+4MkZD3Riba6xYRbXnl0Bk9y4eH7xxx20v9?=
 =?us-ascii?Q?g4nDsVeHNsnCt3saJNhAmnZcdYb9hWDUhSfUJ1O8iFpdzT4gvGP1EuibbrYf?=
 =?us-ascii?Q?LF2HAIBb5L5oChq3llUFucNGk9bSeSaUZhzg3W1Y5/YSK2+ViM2CDwV8u+/K?=
 =?us-ascii?Q?JoBZ2gX23oOdk5dYzUEOM2IgPFNjajN55JFc52o62CGwPMDrbuV32Zt7oy1t?=
 =?us-ascii?Q?+KZwVqk9Gb3CMEm4CJJaXLYhSAE5HbEMfTGyYrJS7QjPRo2CxjR9US7LuIXn?=
 =?us-ascii?Q?dMJlvt5I5XtANMQwZRiNZxkGnTOer9qVDX38FLMjhWDvHN5ANizEAGoHCovi?=
 =?us-ascii?Q?a8mWEoUESUg49zXMgSOm/dwTk+Mu7fEqCy/2AEfTfTcHWQ9EnryWy20lvHhm?=
 =?us-ascii?Q?cnyMZekWIADLltF18QM1RymtGU5DhX/mN5hvLNWx7YAVsBpiIdDAaV2hRpNO?=
 =?us-ascii?Q?tTYI4Fok+ixjiXOvYz3GPuB1FFU1BMntw7hAsi9V0GzzJQDp91zylQ+KE3AF?=
 =?us-ascii?Q?xdWfGdu3hAHsZC7rgRrI3sZEoetE//BSxNIll1TFbzjhOcl81oGjZ1oZfy7B?=
 =?us-ascii?Q?zLEQAtecFqrHykaofdTikWwIcSq53kHYBEmg2f9ugqpuQjsIqi2NPVFNsceI?=
 =?us-ascii?Q?7RnnIH/AQL0qiklrVHFx3JVx/FYmtGARdRyiDi19sPDJ0lNE/rz0dQ63C6bR?=
 =?us-ascii?Q?9LbmXjHV+K8cxBv9DjbepkvjRKUlx9rPKcS439JwJ/muUOWbTdUrUGb6/6wD?=
 =?us-ascii?Q?sJmv3JuBmH0SUQIIFIpFvV3wAr9n8g1eLE+b5jJAlhwfsXip2Qw2mzSb07QI?=
 =?us-ascii?Q?K+y+vwq9BczXcBCRKb+B0AHgB1TFmO130zAX/X2gSEGEtQZ6YJqL906OixSH?=
 =?us-ascii?Q?8nSlkGydIxoOKKPFTVs+UhjOPlpSv92KUlDtdzcVRI/fX1G0zEECV8FSMaUu?=
 =?us-ascii?Q?Pvh4J42UAE5V93bkpsykJwVyOZr7AO9bxl9xX4BPbrEaLljwrO9rnuHAsnXI?=
 =?us-ascii?Q?Y1qf0ST5lA5mTLE4OdPXfLLp8H0WsLgn5rYl6ONXeQDq9dhowANH/dhcRdAg?=
 =?us-ascii?Q?igS/QLsoCg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xR8qCHZOXt5DKPU9ZzZT2mSGDsUQ4PJNWaNfY35KigHAnc23mfGZIVYNr9jB9tHXwp4cZSM9mRDSYUZRbPAAIWcnW7lCbWUCFr6AK/JERPiiOzKn80sIE/JnLZ++CjRySplPKrxB8jEpwskp1SbS8lnz0e3CU8lZZmF8iQ+dxlFuGpGG6I29RiME2qn2Pt4yar7VTPFM/XN1XsG0gYulFD3yzgv7pYQOzW/CBjDhuuXSxYPHdhwpQhF+5QlQigsd19MaOshvl8v6qE5vkdad5PoKpHX94aDXYog0iGV2cRdr43QjNOL9Mgb/datb/VUYqVQg6tYaeCu+/NbuqNv4oJ1KtN6hi9UPJ+dB5KwDCgAki/W+surBwkKu4i2hCaQeQCsex0qE2QDmGWG25omqTai6E17Yrq82ntjhngeMPOZa6r1IqZgYOi6GIyuQ4RKFf2uMhp8ES8hxGsjQcPZEacaUH2l5C+p09YOb/lsHhCdPM6iGA8HHTmNXciAllC3kpHgfsekXgEZqTDs3ef+wLlgGiotcWBGQsWUu2JSkTE92RMV+w5pMXtMdXbWSyub8JJgNEzn/++tJw66cf5wMP3wEVsiW9eL/YEhm40jc8x4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16863c57-3855-4054-4ec3-08de46824cc7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 02:30:58.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4ejeldDKsqBIpra6w0r4SlyHCjQCMrjbnwblpQ2hG/0WbVEatpYJrWC3kHSfiCbAkX+aYeS/LabbGIHbv2b4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA632C0238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_08,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512290021
X-Authority-Analysis: v=2.4 cv=LL1rgZW9 c=1 sm=1 tr=0 ts=6951e7e6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_oB1eleuVPsKR1BtrXoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: YVUnNebNM-0G1FsgsbJXxy0dF3T36iVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDAyMSBTYWx0ZWRfXxhA97bBXrA7k
 B8tbffWy5UtvKxIWTAoAD0PZQsMFjGF/fS3x7xv88r2+PqVfgpQjyhpdwZ7BbWyz5Kp9ScLHaBb
 zVynyFT0ckeVBKgKUAAO/TCwHOnlBkwxgQTguZyIFLTmy0/iQeF4eYnYWiYn5vogRx4hwNBcpie
 U/FtpBYOokePV32Pl958QUE2TlkJyrQZYI8Kd6x5MRkFnl7v/Ma/TTXj1VQEC7JfarnEGEMdtPR
 E4hRKiQakoX2AiR61cHZ0NoPOF7fQiP8dx6Rtuu639rdoqJs7AJ1BZH72sIbBBVosRlUXdh2IUB
 4m//zG/lm0NjzhvA5ncM/JP+EZzgvgNn3N44apqtkRB1pFA+V3hShFUwHeaVB//L4OJJIbSvziR
 K6dDAc1U820qShVh5dLujSWw3GxTPO5pPT3LjlFfR3CbLO/4N09jfPMa7VoX8XB8JmjoVQhDDRI
 W4kF0DjuLz8Pk6lWmPg==
X-Proofpoint-GUID: YVUnNebNM-0G1FsgsbJXxy0dF3T36iVF

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
> ---

Looks correct and nothing jumped out at me during review, so:
Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

