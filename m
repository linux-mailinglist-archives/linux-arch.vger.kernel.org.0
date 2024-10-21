Return-Path: <linux-arch+bounces-8377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6639A70DA
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89BBB221E4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04F1C4616;
	Mon, 21 Oct 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8h3wQMr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fmeLE9bs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708111EF090;
	Mon, 21 Oct 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530990; cv=fail; b=MCAVyxCXvD1dkNyVhGvUJNSrY9Abf+ObDfDyF1NzK+w6Rfs/tFA+6EegJJ04GYmh2GHO1qW3ey+1cmU+5gqHregZTFE1XYFcERD2wW4VSgJfrFFJDb+cTVN5upVKd5c/gtyE5Ccka8J7fcReTkffWaECH2iC6NWGJ2rdGbN6utM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530990; c=relaxed/simple;
	bh=CjhCSS1K8LoUBxSMTevumnjT4IqJfxi9wlqA8VY0yzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLpCTdtZJ0gqfPm+ZikNL8BahNp74vxX0rNfFy4+bZnGO4UPsKFjjZUv0+ajNSNrvR5DNPi6DSAcEtsPzp6derI2W3vLlaG8UcBO4nhAh1o4RIuCYlmle4n8KuSvyiR+O4UEKyzeQMubpZTWf0wEM9jJj04eQrC5M7B+NmOFwig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8h3wQMr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fmeLE9bs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFu8Ll002988;
	Mon, 21 Oct 2024 17:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Py9LAECna5dO6a/yP1
	Lz29Sg/Ygd3job6lSYUVs6IgU=; b=G8h3wQMrjhrmwbwZz4rcbukBVsyDDGVjNi
	FufwXYkGsZjYbA5J/tdkwZpCXqSi5HMWvFfJU5fpAHp7sf26ZRVPUfz3FGdMeHKD
	nst/CXLjg5HMdk7c3Jet7FHjAi3aEY4i44g90HeALG1VtzafjLYsRPGj0Gj5ZzSo
	Jj5ZZrN99G5wvBhnxrKPHfy5yY3xzk/H7LRVlpK5+eMwEaETTJDUlw4FEn74lV65
	fpRR9MYkU+xiVnIJqFoFv9BM7ByJwedmmVz88ub2oPBuMoPax/pUUcm4ELceMekB
	4+nXPyJcHfY4NT2a+f3P5ISOSAuKEz/qIPXrkDJ7+Sz9Ic4sq2Jw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3att3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:16:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGGurG008275;
	Mon, 21 Oct 2024 17:16:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376mfk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZy8s9zdmG93qZjcP+1XR9VVXlrdqZVNFz7u3WFqx86SURIThgVhv027VIQrkz9PoqCc9x79Zo9mhqjSXqFc4V/YBQz+5dMFmzruUXoMrPNxXcWAp2ypL/5Z7ntN0lreq/OV26wvHhU8cPhPqvbyI10sUUW3OslOdOmpZs6ERaSScSjFgPxVUYBhel+B6Nqlu6d+LcVwhaLCHBXdSgJ6i8fdsE6lngSUsVyisk+NeDKHUFHutGP3J1QB+afC+7Zf12aoshFJ46JjxCEIPCj8ybRwmaqzM4wQFB7OZF0dfMeTeqUpRtLfrwyTHG/vSEbQkFF49T2xlEyRRUoMqbmLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py9LAECna5dO6a/yP1Lz29Sg/Ygd3job6lSYUVs6IgU=;
 b=JiT8JEw6E3hGC7dMkcQ7j7gT33IWFB7/TqcJrmF8veikzzAvf495xMeie/9qMs3ytK214eOfuEjWL+2xumoqZ9NGZspwQJdL5sYAECNHvl/qOupNxYrcL+piQFW7fAd936JNkeL3Ke60ivfAEjsGzF54b1kLeKJ2RVL4t2fcv/4WSzwiVOi8r182km7wdFCbVA74/QSKKfrM3U5MIEfz2LedEgR++DSGsdbXsiMoqPLUUY7vcyT8bdF0ghgmWBf4OeuPXIpukLfEzlIJHiJCNCBSNmng6qLKviRAfbBabk+86UHvz+X26674WPJ7Pp16Fz2T67EDY56dHzAhByemNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py9LAECna5dO6a/yP1Lz29Sg/Ygd3job6lSYUVs6IgU=;
 b=fmeLE9bsD0g8ORLkn6v6+2qmqkV0kdFjTTAtqyh9H4bnAJowgDSp/Zgj6nExXuyvI7Oh+fJi3JM+KSS6MEK9aSIP5Ena0dxWIYneZOcwFaeVG6Lqt6ResMbCGiNMEM0Wl/QLrcoFQ4URiDJ5Ni0ieFQa2U0/4Q/CZ8zTkq8KbMs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:16:00 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 17:16:00 +0000
Date: Mon, 21 Oct 2024 18:15:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <b2bca752-77f3-4b63-abe9-348a5fc2a5cc@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <b13a83f4-c31c-441d-b18e-d63d78c4b2fb@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13a83f4-c31c-441d-b18e-d63d78c4b2fb@redhat.com>
X-ClientProxiedBy: LO4P123CA0391.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 873ff9a2-acd2-4ea6-5f4c-08dcf1f408af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dww5+2S8wkthH8OVcnZEV8dRtwOwHfBKAxYRYJVydTQIneAI8FlDLngAJpOt?=
 =?us-ascii?Q?MnwfM+PzPCyWamSeZCCJ9XgGSDJpFuYiiI6crZHfNxx05i7LTHZgFiVhZQw+?=
 =?us-ascii?Q?EP/1K38PlCAnwjffOhtZBlt7QRb0hWdWt6Tg5C75xAKXSuBm+gaUe33mlwbK?=
 =?us-ascii?Q?YnklOy9GprBxA9P3wy8YdVNKuBd111oC4kRyNxTd/5iImXMmUnf0MhM9x6/D?=
 =?us-ascii?Q?EhRVeALvbDqqpWWxXyd0GXQy4fU7GCEk61ET0MiSFxZUt5N+lCsPVvxlLTkd?=
 =?us-ascii?Q?YniS1zcFvv14V9m138qJAsb0Mz5RwvezaQ6Qn9qj43PpqJjWE676aePd4WL8?=
 =?us-ascii?Q?xEM9H5f6hfxxGluXQXMSBNQNBTFdaTCrGcOX6w+9rKLHI0h5SGKF+yLblAIb?=
 =?us-ascii?Q?dYQu9Z3456A27dP+Gpm6ohXUrecu0SYDCx3/TSW6vPwP83vE5kJx29AZ8BZ8?=
 =?us-ascii?Q?UW0rCjyZveurc46YuXlfrvfKs4IJDQAFDcS0DXQ/v6Z5TJgArreL9bqRVl7S?=
 =?us-ascii?Q?Vf5IByBjhXBAWwPyoWFNu0bnS4Spw2oCAT3FhfzDSkNsEqfNSoSXhxykNcAT?=
 =?us-ascii?Q?WNbe1iIxBM7YBgpRqBHKSonC6Ke7jWrp+Hgq5JL+GAZLgXv4cVcV6S0/lm4b?=
 =?us-ascii?Q?mkqHtaEru47HVSt0H7ioGUZgjpmAm7R3d1L6JTq1/dSJnpTLdtxZ77ZGqcFz?=
 =?us-ascii?Q?GP6bsvE7DTr7vBUlLEp6EDZ7x1cz6OlK153kRPvFvKnQ6d62DBb2EmJKTee3?=
 =?us-ascii?Q?eoea17imOkvNnqaYAYue/b0oNUFOvUPOq1WCtCR3Yxf+QS5EghONnuuYddqa?=
 =?us-ascii?Q?QoXw9GmO1Nb12r4Lvj32++WioYX3XFo96H5Kw1m724KhTrWsRW50HJ6zmyX0?=
 =?us-ascii?Q?YG3kgX5R50QBGdgO+oEEgaIcBR9Ru6lPZSPZjkBWc6NVvUEeD+Cm0EhpKwE5?=
 =?us-ascii?Q?10g7npBPlUdGdNBllwCt8E9tPGW8oOlv4SIe9OMliKYbhKaEwvOhNiRlvacq?=
 =?us-ascii?Q?Zy5FFPkDRQrYIhTaROG4TxzDcWz8n2cP7Khk85L3w/7dVOl3UraiwFWMhMUf?=
 =?us-ascii?Q?axD+oRaSnZvjv8XAPcE2v/UkJS+vcb6XR2qoTyPbXHmx1mHwdikCajjSgkCi?=
 =?us-ascii?Q?BvhM9NAHNV5d+gfYlBNObSCMZK4JvvM/dA9cuwElXFpPVW89I0YO6+6SoS7o?=
 =?us-ascii?Q?ygN6YxHVUK+/QG92Pr4T5+zreLyCGDlXhIMMwMzKP01Jj8UWxKWyGR8glWf4?=
 =?us-ascii?Q?Ei2IY2EQoU26HMFSW7Nrblunx7mRSGr5jxgiv4cExF2eve5gkWXGWfagyrGA?=
 =?us-ascii?Q?EJfXkHtJ5VZvrx10xcERZXGj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JL3rribjhF173Xq8BrOZdtB248VyA8wvnMdIeoA4pd+pnoToIC4Md/WZNila?=
 =?us-ascii?Q?mdH+rXVttyda8Ffvji+egSI31UgAKpjsBkfC4FdvbQSLMhM2y+1J3hkyTK1d?=
 =?us-ascii?Q?Z66upb38WqozSnlkDeT+SmCczER9tQ8FO77B/GzHHWozP/m1UyolveBc7Y33?=
 =?us-ascii?Q?eebLN7KrFTpjam1VZ483d/Pn0HcWCX81cWyHuDI5VyvPoe4RYpkqdTM+1N3z?=
 =?us-ascii?Q?IP1qds6b2RvPWBLq5vUI/13ZfEcR/QL5XjsvnIl7lYdLwg28D3c78yACTYbJ?=
 =?us-ascii?Q?ZqGLSeuz3EOBF84soN1S4KhobwbfqfFDIry3bXc8t4Q07fMYJwv8oOp3udij?=
 =?us-ascii?Q?SLX8+5FbojtdogAtD2TtufyYlNM4CxLdmtY8K1KqZKh/bCSNFx+B8vfRdsk/?=
 =?us-ascii?Q?6VtMgLbJzq0wRxO3GfVwNqTvye6h9P7WewrYiEAzaWzVa+9Jicq6vL52UdhO?=
 =?us-ascii?Q?5uv/QMgttoyz4fwW8D+4XJPENCNDg1HQxEkUHqBljhz9+CG+nMUxxeFMLkOg?=
 =?us-ascii?Q?Q1bmb3uy+Zohb7vk9i5dp5FAjrWuBO+LLegKmUjt4ZiBH2G/9E23mshG5T7D?=
 =?us-ascii?Q?U6OS6u0ZNAeFAH6585gheCHAfEioPFCYhdXxnf4k6iaF/HiIiK8EWZX5t7hI?=
 =?us-ascii?Q?Sibj/XeXB5Cf5AlGxHqsP8FgPjwBO7jWbBmPkvATVDRElCOM0HQgTuH9Rawe?=
 =?us-ascii?Q?Gzzuevjg3FrBDN+iKZOUWEH4N/zWvgwUiUeMxcX31qJdDrw8GxmxtkDkPZyr?=
 =?us-ascii?Q?Ws5R33IGFYISFTmiDEvOzyvW/JUNSVE3PlLLc5ITIun6zZMWcj4LcP8bRwgw?=
 =?us-ascii?Q?oq/wXChPrnilNo661GUIuUg9OKExkH7qyEDQoq8uTjudkI5/jPqQ9IxpDx08?=
 =?us-ascii?Q?jHin5HiFvCWaJb+jYf2xkXM+dBrHyUvEoXO2pWSjrqu1B/FEu9TXfHWyESz+?=
 =?us-ascii?Q?CUd8r1GuJAxYWzpIjOf9zE+cwO6aQbyAL17n7q75v8+WUyWgjYvIbkDD9dTR?=
 =?us-ascii?Q?zx7ZJ/z1gJYyGqZEf7t0XIbsx3ffnDlR9HQs1A7d3PPwlZ8azMUhlfBgIeZ8?=
 =?us-ascii?Q?8u+92wg5PctZnjIC786FvqGxwu+eU5GwR4Ps02I54YY8WrL/re1lh65K1pi1?=
 =?us-ascii?Q?U4VU6dceHoQxu6P3T9sbT1A8P7K9v6QK6DuqKR+G9CTJg0EcRzc1Ac67VGSh?=
 =?us-ascii?Q?bvnH3cVW/TZfYStqwQaPVFXE8nuBI/1VYnHs1jYfwmZtv/pmzqaIJUxUFTXX?=
 =?us-ascii?Q?YIXUtIaESsGIjUcIXCB6twco2v59heflmYxVpeTeWdVRInPNH/0EhP12cQv8?=
 =?us-ascii?Q?kwR1BrRUl9Nr5zIuuaUtAb7f5wyI8VXOd+i5Zt6b2ccRACTwlSyTuFKxuQHv?=
 =?us-ascii?Q?3bxlfgXhj9VAQeqF+kJU5VrpZxRmiW+lVLjP7OUID+5nHciVPByyWXmjWZkh?=
 =?us-ascii?Q?BfgBbc868PRO3f0Nh7KC7ADEzjZUgjFo1mnvgjRLZPvdH44UzWPNTLkS6JEd?=
 =?us-ascii?Q?iSm4kLqGwvysahqnwyIBOKc5W3DlBCgt3R4inClbSHor+kfoq83SDn1q01KR?=
 =?us-ascii?Q?dnaISJnfQHnJ3j1J+abxzyrgxBgGISeU+57EiVUNp64GivK1C3TU1/zS8W1N?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o5EJ/6thvfHYii6wO/jvFs+6HKA+hc9a85Sz3KvpORdZD7CFQlPWlaY2s+EtnL2jY+ZOhhSQest4PNv5BocRtv6kiAumaqcoKSBGp++uVU+3mprPIMCxueVgxI7ZQ6B+k0LmKILUdWxuzpCt8XeRUM20yLLMj5sV4/9Yfn3HaMSxE9oa1xX7AJaUN+snp5nRk4YsNyGuitkK3yXZ8ap6CffBscijVFFxVi57LND957DQh12+7yq6vCemSGihY5zre3IV7Nat5U6RdIlSH6MDTCxLhj4TEXRUAmrLRsRoNZvV52irWTNF0nZni56NDMuiWVIuJnuIIIyv+d1nRz4IDjVhkWsP78iyTKJ+1YTH3webyFulHxVmofLQugYIhVDzI4bn0m/WUfudAmuvJmzbJfqUB+21XIQQtY+dt9Lx3z0nkzuzSzN7Es8865OyWdLvH06fRNXzLFZL4Jkq5owbteKyBsyEjZlOvqvJ3n6hXQcbUwGwEud0G1A/4mLjtJLYLsNztiOzL2DYaLwkWo+uXuT8Awb/KX5ggx63f8FHu44CObjKUWTQs7EXzbjQbqpSz7ahrTMIOEl3fPf5WLbipUI3cYXn1trmTXxYTgCjdRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ff9a2-acd2-4ea6-5f4c-08dcf1f408af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:16:00.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw/xc8VlsuJuikxi3Z31VOSONN7/PBPD/3SeTAH3VHE3Wng6khEsvCOaHJswcb4txkZIaKLP63o0/ag7ZLrYisc0K5EhMYtCOPZIzOIXxSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=664 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210124
X-Proofpoint-ORIG-GUID: nPWxtXzebzdkxk1xusTw92fJTcXRyrmO
X-Proofpoint-GUID: nPWxtXzebzdkxk1xusTw92fJTcXRyrmO

On Mon, Oct 21, 2024 at 07:05:27PM +0200, David Hildenbrand wrote:
> On 20.10.24 18:20, Lorenzo Stoakes wrote:
> > Implement a new lightweight guard page feature, that is regions of userland
> > virtual memory that, when accessed, cause a fatal signal to arise.
> >
> > Currently users must establish PROT_NONE ranges to achieve this.
> >
> > However this is very costly memory-wise - we need a VMA for each and every
> > one of these regions AND they become unmergeable with surrounding VMAs.
> >
> > In addition repeated mmap() calls require repeated kernel context switches
> > and contention of the mmap lock to install these ranges, potentially also
> > having to unmap memory if installed over existing ranges.
> >
> > The lightweight guard approach eliminates the VMA cost altogether - rather
> > than establishing a PROT_NONE VMA, it operates at the level of page table
> > entries - poisoning PTEs such that accesses to them cause a fault followed
> > by a SIGSGEV signal being raised.
> >
> > This is achieved through the PTE marker mechanism, which a previous commit
> > in this series extended to permit this to be done, installed via the
> > generic page walking logic, also extended by a prior commit for this
> > purpose.
> >
> > These poison ranges are established with MADV_GUARD_POISON, and if the
> > range in which they are installed contain any existing mappings, they will
> > be zapped, i.e. free the range and unmap memory (thus mimicking the
> > behaviour of MADV_DONTNEED in this respect).
> >
> > Any existing poison entries will be left untouched. There is no nesting of
> > poisoned pages.
> >
> > Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
> > unexpected behaviour, but are cleared on process teardown or unmapping of
> > memory ranges.
> >
> > Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
> > 'remedying' the poisoning. The ranges over which this is applied, should
> > they contain non-poison entries, will be untouched, only poison entries
> > will be cleared.
> >
> > We permit this operation on anonymous memory only, and only VMAs which are
> > non-special, non-huge and not mlock()'d (if we permitted this we'd have to
> > drop locked pages which would be rather counterintuitive).
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   arch/alpha/include/uapi/asm/mman.h     |   3 +
> >   arch/mips/include/uapi/asm/mman.h      |   3 +
> >   arch/parisc/include/uapi/asm/mman.h    |   3 +
> >   arch/xtensa/include/uapi/asm/mman.h    |   3 +
> >   include/uapi/asm-generic/mman-common.h |   3 +
> >   mm/madvise.c                           | 168 +++++++++++++++++++++++++
> >   mm/mprotect.c                          |   3 +-
> >   mm/mseal.c                             |   1 +
> >   8 files changed, 186 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> > index 763929e814e9..71e13f27742d 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -78,6 +78,9 @@
> >   #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> > +#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
> > +#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
>
> Just to raise it here: MADV_GUARD_INSTALL / MADV_GUARD_REMOVE or sth. like
> that would have been even clearer, at least to me.

:)

It still feels like poisoning to me because we're explicitly putting
something in the page tables to make a range have different fault behaviour
like a HW poisoning, and 'installing' suggests backing or something like
this, I think that's more confusing.

>
> But no strong opinion, just if somebody else reading along was wondering
> about the same.
>
>
> I'm hoping to find more time to have a closer look at this this week, but in
> general, the concept sounds reasonable to me.

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

