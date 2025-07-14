Return-Path: <linux-arch+bounces-12752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D46B0445C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182937BC11D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D8226D4D0;
	Mon, 14 Jul 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="htwfB2n3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KIEnMCe+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215D26CE1A;
	Mon, 14 Jul 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507298; cv=fail; b=hQWLv8qPG2pJub2l4LP2FkxabGmM89+wMKjHiuYH9K6KFqNgOtZ/rp7kRjoUHS3+HH+ZrD9glKQqtbGYmD/z4lnGYHOsoBBOLvv+UTKPHvSAwaL9DGm1f0dh/up56s4Ya/nFOf6ueLsApRubcTxq+kYfX/t6uVKK56Or6jBSrM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507298; c=relaxed/simple;
	bh=7h4K5y/bZB0wP3JnJr0tW39QmxsqgjcXcDZB9SUb/Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qWyCqb9u1ABPBdBPzTaFXOc8aQY7A3TqDnUaCtRR7wgfm2YbAIYBVCoX7SeERPQq0Urbc5rJw5vC/9QfTBPAL5QPuS0fWUBN6u2G3JbpbAOwGQOdVgqd7RZzIZXdaamMe/w58BK7jK9gCN9vO8hNq0hXZDjrLX47YupzyepxZrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=htwfB2n3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KIEnMCe+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z4BL004569;
	Mon, 14 Jul 2025 15:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w5PomL1bAb5qi6ajRU
	ytbmh0pV/yei9ZBVoiRb45/nU=; b=htwfB2n3vv6vHWovcCNl9IuIzVyDNnGNlj
	ecJy/ELOHpOQNTPAaCNYPPTkM5+fO54AgDfPgpQHOJqYEqMvf5ZEERVpf/mRN8K3
	LSLXYC5R6QgCeVfYweorINf1gwI2WabtPC9Ft2DpCP5urRQSJi91Qv8C4D0poW6d
	Rj1hmaldvn2lbFwPBy8YNnyz5lpKl7S5tL1bzFbLjdOQv1pLJF6t0uYavtIsY8wN
	0UTspFtJmqKymUPdnmy8yMoC9FLbXU7sz36JlDz0yhuI4JZpFrOz1ubR9BS0oCYf
	sPgNMuhcz4Q9r+MG97YuweqEQzYj7SYmeHfuYzfPo9CtjTQpr9tg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7vpcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:32:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EES5W7011570;
	Mon, 14 Jul 2025 15:32:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58nk4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZQzHtVI51HsjkkKexohrQQHmef3nAvLxgT32OE5Zzl60knJ9LtW5ugfTf+uaCBPv6faS0vgUIY6sbn/snrLXeXxNw96bB0xB1glihKMwnzok9YMAkRLF5AA2V4Jr0TJ5RkrCPtDD4gKFsCxbOLO5wRVmzQkDnTRf7jwWob13HLYNr1FtEesif2+LXzKYJZ9aSTkJUImXoUk5UT9Ko2pWqmBcLLg02UMIfm5gGzKcQNwrFxYr/ZGu8rHsSKZXUaDGyW9LoFvpIuZzSCgLxb6Xv6nZ6ekEY8zqT34YH2KTnvcuZ7uZZJK+8NRS4Wn86Xn6Qx0B9u8MsYvj0i3CZZD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5PomL1bAb5qi6ajRUytbmh0pV/yei9ZBVoiRb45/nU=;
 b=F3/4nZzbXIizPQIrJZfVOOsdlG6vkFK9DcBuy1q7NawQOsi01OknjOG6CmFRMqDwMNzesm+3VDZc61KgaME1xDsze2aY0VL1rHAal+a2373hjtT9dtPYmo6s8E/Vu/Nrw/iYBezck2lVOsD446ZsWaXOlgvxjS0iLl4hMzU4z3TBAdnDkunHgFJKiP4hrAgyxbwiK4SjuvUGCfnR9VGQaVb6z8gU/O0xwweJDQmRzNhfuPA/iDof1ofhGSUdk98LUSGkVrEwvITQ9vxV6rqKOQQ0QUUireqY9UNq0Ns40itvNKIXdH2H8w6rmYhEh8ZK8LDceP9I3qVWisB+BedAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5PomL1bAb5qi6ajRUytbmh0pV/yei9ZBVoiRb45/nU=;
 b=KIEnMCe+nOqQuZfYcVSIaUuVp/pSrjllQ2fMB5F7E3vKBSnGtmAd86Qmcs75Rf+5KnHgekeYAlxuecroK0W+ZMSLKqbKYSiM5ryRG5ITM7fTy+yEm+b3IqpP6lAPOtfUEe1wsSlRZFmNeCQiLPqZ3KLo1valCS6H/SmMWcTY/sM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPFE2271E76C.namprd10.prod.outlook.com (2603:10b6:f:fc00::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:32:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 15:32:19 +0000
Date: Tue, 15 Jul 2025 00:32:04 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 1/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aHUi6h4HPAbq_Err@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-2-harry.yoo@oracle.com>
 <02146c79-a4de-430f-8357-0608e796fa60@redhat.com>
 <aHObCemGNrGakq_b@hyeyoo>
 <aHPzOrS7ZfO-3Wf6@kernel.org>
 <aHS7hK-BDC3miisN@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHS7hK-BDC3miisN@hyeyoo>
X-ClientProxiedBy: SEWP216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPFE2271E76C:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf27382-9c60-4cfc-bba9-08ddc2eb9e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3DJ7v06vfCp7/0p9rJbuxmQZCn3V2Dbj4P2bb/d75pv94ATk/in6w4m3dzRO?=
 =?us-ascii?Q?BL21GFBJgtPd/UlMEaNx8lDR+A4/nWszmi84gTPf2QSflTqYGQtsr4x2Kjzu?=
 =?us-ascii?Q?sYbyIfX5mgWoZn2Qzs1orkXweTav3prcG6dSpDs6Mhlu3bQvA7/p8hLWbOHr?=
 =?us-ascii?Q?F9cFqZSMbUh+cQtUi8Rf5jRa4k4GEm+lwHfPrN/ZHvK7+wOaZz/Mz8G4tCi1?=
 =?us-ascii?Q?ICeCBTalIv2O4kFEeazdCl8jpjc8yyvn/AdUa2n4tFpcDoU9ClAHO6AAbfdC?=
 =?us-ascii?Q?zaskz8J9fRzBa3f9VQHrOKVNGlU+dpjTk6b0dW7GoIOZ68PEU9JJRJbOoggs?=
 =?us-ascii?Q?0qFYRcih40pf3U6wwQjg0uFO6nhskzci5LDjkSAfMQqeckdr6Ssk4XvlWMXi?=
 =?us-ascii?Q?VNo4Ikmykg9LE2RR2Nhywua7SVuEPiahv+BrW2QYtrQIanUR6btMkJ4ccvAv?=
 =?us-ascii?Q?0EkHGxOaMT3M2PXdEtnPa/nWm9jMkrvX+apXuias5u0orerFnGlUiaBSWi8m?=
 =?us-ascii?Q?USUqOsVJjmh1D9sBd6gntokyEv0vei6T9LbCsO+nHrhgRrY2tjRNPfnLqrmv?=
 =?us-ascii?Q?ZIZXQEEGWptum5/+tqq5Jrl5RuDgEqAtzCnXPe1aAaNuFGwHuMmI5F4CzAjo?=
 =?us-ascii?Q?fyE5pqkXeAmJNOemyUqWGw/0VE56f1xQaYSgACge31csyjJ+sNX3qWSnStJa?=
 =?us-ascii?Q?KelNtSN2TgI1OfBB3L8PP1g36GUbp82VmhnS9JmWHmbgkeGgoY6oA5SypORT?=
 =?us-ascii?Q?emJi79fYpW2PI5+bsDvKCVBn9Sq8XTUJDNcCcp9TPsPt2tQnE5FGiMnz3Qic?=
 =?us-ascii?Q?7OkAGKcRwLAHCdFM70y6A3083vrnuuGBeOGAz4BRWmf345m3L+oAUa3YzIME?=
 =?us-ascii?Q?q6SOz8piSH4N3RRuzzp4L55Gx8A6vFMI2abildKD5KRMaAobWoTfBe1KSy84?=
 =?us-ascii?Q?jKKzebpIt+a7alrMrhMizG5yFOGm2F6wgDEoqkg+RqPhh7d3AtiM/GuCl+GS?=
 =?us-ascii?Q?FXbe3kdhW8Gnxp+hBUFJyL4OmdELmqYd/OZaFwRyCFGkH4aU68Oqbd+xSj5r?=
 =?us-ascii?Q?ebnZ7aVvAsfeApanD2a2i919YpnmntB5uPTlDx7jHehDuRQI2Nq/fashsFKP?=
 =?us-ascii?Q?Q8CjW8CdIE4MQ9G0QgOScaMJsOnCdOrLuTxLV+9AJjpsdVjpuFaS+WMcIs1x?=
 =?us-ascii?Q?2HMEU7z303WYU93yiI6WSdM2iZ8xOQGyuFHmnSVRKBtOYqQRXUO4eKLweoNs?=
 =?us-ascii?Q?nOG3hmrWiFrItS/nSkWBwhwl6t4LiVWp4Q7Tibsij+RphHGR5vqPd12Nxylz?=
 =?us-ascii?Q?df2oaAfV29suOEc9KDZoosOOFYZDkLR670pcQDHaSDsPJGQpTfVZ99OrrVji?=
 =?us-ascii?Q?HUGtzcXIJ+u/ToBLsx8RNGJ7NNXunK8lgbTCTITvxwmCzMTJuZEs0vTNSWs9?=
 =?us-ascii?Q?JzvlRcXGcdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKEdwWn/20UIQ3u3WDMLk2dx98XTYcAyZkivaw1JxJnHKusI0l8Ice3UL/y5?=
 =?us-ascii?Q?54zYIYnB3bVNHW6FFBpS1p1Y+CiXv8GoP9mChHrUhoxaEqcjn8hf8Kbs4aRY?=
 =?us-ascii?Q?Gx4ZD2jdzuEakMbUF6OtBSrnDN0b03ltjh7YYxrs6CX0/5qeWdwOjFHpJ5bP?=
 =?us-ascii?Q?ZNeyGcoFNdVZAeZxFLLfes/dXo5UpyCfed8Br7vPp46uTHlQQ7kBwq920jrn?=
 =?us-ascii?Q?1XM0A46zhYauWVJkbJgosWvvHMGEwOJY+aq7scoqKEVIf7rmrD+XAlAZju+T?=
 =?us-ascii?Q?2Hu8oX5thMXjtTW/lA3yNt5UJZhWN46Eo4CWtpy/6AMn8QRau4n6JYkFa/mJ?=
 =?us-ascii?Q?pT/TbkhQ8BCqgj/49+60YkedecRICDE9brbOPlUFi4eSm7QSkE9ufyD33vIz?=
 =?us-ascii?Q?pA5w6LZG3volrOS/x6Q9JV2KJD/9kkX6zxznO6HPA3UUXa2rfXRpfuNixqR4?=
 =?us-ascii?Q?FWNoSbb7Pr/zyhBeeTLzEtYpARIoTKOc9L58jelYg6QV6teaxXYFYYjYC33U?=
 =?us-ascii?Q?T0Uj/haDfBz+v46lnH8kKiYnMCkyUdjruvV2btmQ4lA6Vy1C9d/P56IFIkIS?=
 =?us-ascii?Q?G8L2prsNifxo3f/xs22KbeO1hSz+iX3ngFSd1FAN92EuPvwMboybn2U0rzE6?=
 =?us-ascii?Q?7f1qT/cWpfwg+If5lfXkCy7gUfQhvT2ZH9wkhlGGu/tArw/DoAB6f8KHCrBL?=
 =?us-ascii?Q?SFiIcLmN6D7DobOSBd2+kROQcY2CA/NvwC8owQfX6T4ZA/dlRTSMPvIprT7A?=
 =?us-ascii?Q?UZvioRCP7msHZ0Ct4jxBUHK/QZ2kw6Q4vHGQMLo/qLCgZw4+7lCOkoZTGiQb?=
 =?us-ascii?Q?ue+AV0kJpI7lNA2Cd1JEgIg0ab0g2naS+e0Q0z4hnrwpETPeKbAVMRXp2emg?=
 =?us-ascii?Q?3ahiwuFeKYAf5eSit4VyFy2oJf8SVmwlxBRJt3B7Pa/Vb8qZPJLmxMspnKLy?=
 =?us-ascii?Q?j2qVmzbFSAr4nwjsUaAiGTmct16gCmAoesAxPnkX/ZuAPamDxgdYJz/INU66?=
 =?us-ascii?Q?ywQZl4iXoEsXOOG/TWKvfECclmHHe15QMSuNXlfJQnYIAdyZtzHEjCEyo8wj?=
 =?us-ascii?Q?N4b0kAI79XGseSMJMip1eFXPQaDImV1jLIUPU4/TTgBvGBh+Q5W5svNOuqX0?=
 =?us-ascii?Q?pmduB4xb5tk6JLGD/4tKo8o8O7DI8/pIX2Zr7CzgCwkUmlbI9+Etq5DlzPbu?=
 =?us-ascii?Q?CQZ9z0Yf466vBJVXbomEqApbJRP6A36nWRCTeRHPlMfwawyWvetf7pOkvnhI?=
 =?us-ascii?Q?c3x1iD9FH5n8d3njiCWc0LYHmoqtvTEuQNB4FHnD+JC0XjU6GwmhbVSFXxZ/?=
 =?us-ascii?Q?WhkiSUyGnb4SGhK3TtJBFrTwbr5zTPzBezF00P8ifABL51LBJ0ifhi8lRjKg?=
 =?us-ascii?Q?eKcpjau4NnWU1GI/Gy/0+FT5S0+4Q5hkdG+yHxs4sbNgZ96QFNFpydmg4zPE?=
 =?us-ascii?Q?E0SQ9+SShiv8fBkXgDX2nQUJ9jREMnkMgdHkfk+fsPnnVxkkf1B9JZ8fc4X4?=
 =?us-ascii?Q?W3uOMLPsydsmxlTtZNfFMJ01wVi0kLYc0RFKzbQ/bqFWE0pA7jyrFayJpsNS?=
 =?us-ascii?Q?yL72BnGex7V7veVsJlI1o79qbwy2htx4wXBh9Yc1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZldfJU6dvLaalzrtQ4Y88a/uxZdnM0jLBPIfGUR1YATpSwW5vROO0W+unLz3ek5PF9T5s7KoeXdCyMzU/KfcG/mqwpJyGhDrNqtvUWikP5zOebrZcPLtvZIEnVMJXho716Eywlyz4c4tMg5QfVTaOvgsfeNxnhhX0o68aeUtM20yXAdfkmxRUJT6Xa5gKCn9fjgcaOir/renHWBEz2lR81S66NCdqICARu/P3Ya3lnuRWkEe5ngxaCnJLK+LTNkGxTiJl2y7KSWuWIuCWK7DWCV+5tpOEM0QA0hxi3k1OYkDOvi4PkGLKC+C2Y/SrdnR0FrNLzLIdnuiJ/w+nos6SntbLepZYqI6QoZhM+6xWtuCsdVDgkXHVA/7bRfRlGmPfowA1/Bj8A92t0Iax6Pv+wO78GRAqRBaktBcRF+1y5zLbN+Q4dj4PM1/bM1iRI261gfCoxKHaigVcDaGoe2eTsayy7mN0JR/RceXpg+UPTDDQVsUQoSCYxfE4WJiLok263XcaWzxVQk0V+lSL5OgMTfC9F+rGwpfxSOzcD1DxCONfvSgf7RcYpY+f6hTwj183mpNISiTdPXZl13nGO5lt/7uihZF6nVL376CO7Fkcvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf27382-9c60-4cfc-bba9-08ddc2eb9e70
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:32:18.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN9OHfXPRcuiA/RIlj8XlqasX6h/Z4SS4UHXuuJaNwSt15zISRflYunLImNisYNS3pnn7II+4tcBdDhCdLYIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE2271E76C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140092
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68752306 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=tA7aZXjiAAAA:8 a=RonsrDP5plWyn8ffeooA:9 a=CjuIK1q_8ugA:10 a=kIIFJ0VLUOy1gFZzwZHL:22 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: vK-tQNvd15c15iTIMixWwtX_rO1pr5Ji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX1YWQLhYfLFHi nqn6tg1tNp4RpeqLHxxzYmRXylRGW4DAqtLE2Y2MQS5pgpT4GDMGUsjg633fOsap8WMmZ/Dn0Mp mcfwcXF3wYTflxYzHAUZabSpHNADlFEA1RxsqU4m+gkO//hNSwRD/xmJ6Ux6YGmydNNgPEehjCk
 ee+ObbIxqJFCvCZC4Vx32JTAEIxCZ0uAvlkDon6GRSQ1UzbtLMBtMqlqbDgljrCbLKMxGC0ewwP r6fL1Gs6BdZkWgkWmxsbWSpmV87ec70j1BEUZNRxSuo/L6gXYeamSIZ4T5x/9iiTZ+X8HJqhjzu s/OH4QjeAQ+oTld4/As8idvWd4tGeJJWYBz0uJ4D9/MJ/j23PC9qSGgo4ZKtICMFG5/dQLR2yeh
 UQ8SvLbJ0wjGJ62VDVIilMsdkWn/Qi357rWQulWTZNRfQfSy6mq0vmGyuVbZgtDKHG0FXmKg
X-Proofpoint-GUID: vK-tQNvd15c15iTIMixWwtX_rO1pr5Ji

On Mon, Jul 14, 2025 at 05:10:44PM +0900, Harry Yoo wrote:
> On Sun, Jul 13, 2025 at 08:56:10PM +0300, Mike Rapoport wrote:
> > On Sun, Jul 13, 2025 at 08:39:53PM +0900, Harry Yoo wrote:
> > > On Fri, Jul 11, 2025 at 06:18:44PM +0200, David Hildenbrand wrote:
> > > > > population helpers that invoke architecture-specific hooks to properly
> > > > > synchronize the page tables.
> > > > 
> > > > I was expecting to see the sync be done in common code -- such that it
> > > > cannot be missed :)
> > > 
> > > You mean something like an arch-independent implementation of
> > > sync_global_pgds()?
> > >
> > > That would be a "much more robust" approach ;)
> > > 
> > > To do that, the kernel would need to maintain a list of page tables that
> > > have kernel portion mapped and perform the sync in the common code.
> > > 
> > > But determining which page tables to add to the list would be highly
> > > architecture-specific. For example, I think some architectures use separate
> > > page tables for kernel space, unlike x86 (e.g., arm64 TTBR1, SPARC) and
> > > user page tables should not be affected.
> > 
> > sync_global_pgds() can be still implemented per architecture, but it can be
> > called from the common code.
> 
> A good point, and that can be done!
> 
> Actually, that was the initial plan and I somehow thought that
> you can't determine if the architecture is using 5-level or 4-level paging
> and decide whether to call arch_sync_kernel_pagetables(). But looking at
> how it's done in vmalloc, I think it can be done in a similar way.
> 
> > We already have something like that for vmalloc that calls
> > arch_sync_kernel_mappings(). It's implemented only by x86-32 and arm, other
> > architectures do not define it.
> 
> It is indeed a good example and was helpful.
> Thank you for the comment, Mike!

[Adding to Joerg Cc]

Wait, after reading more of the history on synchronization of page
tables for vmalloc area, I realized that at least on x86-64, all PGD
entries for vmalloc are preallocated [1].

But in this case I'm not sure adding/removing memory to/from the
system is performance critical enough to warrant a similar optimization.

I'll stick with current approach unless someone argues otherwise.

[1] https://lore.kernel.org/all/20200721095953.6218-2-joro@8bytes.org

Also, vmalloc and other features use apply_to_page_range() are not affected
by this change as they have their own ways to synchronize kernel mappings.

Perhaps that can be unified later but given that this series needs to be
backported later, I'd prefer to fix the bug first and defer cleanups
to a later time.

Thanks!

-- 
Cheers,
Harry / Hyeonggon

