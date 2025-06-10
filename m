Return-Path: <linux-arch+bounces-12318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5EBAD3E2F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE6D3A8E69
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D623E32D;
	Tue, 10 Jun 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3Y6ceVf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PxW+b6Bf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A823C506;
	Tue, 10 Jun 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571366; cv=fail; b=bFX403LPQDbW5OJ/KFwsF033mvORCvHGk/JaSnYn2IRo5k4TMBG3Y0R0EmZsz1M0srQTC37sn52o1i7egtPA2lDYI/P9Abox+sU5vmwzGhRh1lXLjE6RyvT8backMH5g2fZoZ033+1bbYCEdyi87weu+9M8VhkgXd8nrsmWPDuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571366; c=relaxed/simple;
	bh=XvrHsQRLO58ndYwiYh5MWF4xTMCHef7iXXDogF8G1WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7/HRcRUWlhQnLBysSS0oWumT3EqKmF+y/GjDUoz4SNEKFRocPAgq/Bvm3qABDNfaIv3G+LKyrOKybRqKmXkPP7w59LZYbq9rI6nxYsasdUTR+GdWe/NNMcEEYBN/rkUiOp+vsguwcbtziLVlvlrTr0/h9Y6DNdjn8N/AfXIRnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i3Y6ceVf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PxW+b6Bf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXZK6029090;
	Tue, 10 Jun 2025 16:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XvrHsQRLO58ndYwiYh
	5MWF4xTMCHef7iXXDogF8G1WE=; b=i3Y6ceVf3pAHXd1fJm6wpFJd84PRX0YEuu
	6jSGOy2eJE2AiYxREjccNO2nSja5K7qURCeNOJeN89yrPQZUboILkTrISOXCeSmU
	IIDyBEWL+mojBWReNjHaqVfmCOPI3YYnrNRegO63KnI01iQviHDTlZq2/YPKwsFL
	XSfv9MCs5Ix+70bYmOq7LfRT3os3iATdea8OP626gzkfPazrgCgB692mDhHTNRbd
	KDV2S/kyrfjMHmr9v06eGrelpM0oJcyOw7ldDRZOdU56jswjpENUaqp5Bk0RjiS/
	gbV2/AE3ffWcFH4dQy9fJvO+aLDTx96AuTlPo+fMlN0+ZOoX4A2w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v4kys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 16:02:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AFakY4012187;
	Tue, 10 Jun 2025 16:02:12 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9wmc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 16:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTjOLKuDo14ubiALweU6Sa5QxcRyV+Hgwludbu4y6xLMwFh9qLI0Z5SvzrHhJPNqzerhuzrVJ981Dyz1CdQiehROuRqII3tNwIYD9fd6hyDgmwnhIHopoKQ2pF8VUAT0FLRS5moeRB84YrdqxRx1PlKUTWulSt4OOVCNgyk4MHLEp82EqgASuCeT2d83qQK2z6NXAWPvbjVJGaNSGu4sxdR3CJObC9dWFV6ZJfQQSuJsfJB//yNMw+F/8sBuefvLggra6XhYcAp7reCcrntubbXqyJwvmAKtvnXW9oNiie4F4fEEjG5Cc8rOUc34SustbiHxFHVTdAELY6t8wfoIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvrHsQRLO58ndYwiYh5MWF4xTMCHef7iXXDogF8G1WE=;
 b=rs8R/YgSOOiQiRpZGLoH8HrV13PMkccJD/En/LW/GT4wjF7qSomktAKqvIMcSlHLiRZORQ80lS+R3l5Gda4gMMp6vqcmbyX8tqtn2DX1obhtfxQ1CnI904zgGE242EKH2u1OB8ERs96Wy5fzkhQVplcvtGCk0LmbAUUpkHZE1FD0fB54nGJIiK1coHDB4Xi6XDSrOTTvI7c5ZrEB3fEtQppS4UKmLTWMPCQ4t3rBJRDGCNR3Nyfo/ZSRlc0LjSIU0QaEbq6UAzcIzCpdRgsC3n1RQDsJqoA7bgcktitrVqNDUepObTUxAwaG+5A/5PbzDcsQuSKchO1E47+Gd6ppIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvrHsQRLO58ndYwiYh5MWF4xTMCHef7iXXDogF8G1WE=;
 b=PxW+b6BfttntvOSW98K+Vm7M7Lhq2naxeaPv919ZQY5AAe0TRnk4NzCzxsJx6+F8qPAAomOqp4c9XxGwJqTGjD4RSPHfkBVtRUhaADAahip8Qn8Pj+GDp0U8mf7fYfkaLyUgioJiNvv98pNvdiImojoIWf2UazKihpbuEYTit3I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 16:02:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 16:02:09 +0000
Date: Tue, 10 Jun 2025 17:02:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        SeongJae Park <sj@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <0d2046ef-7ad5-4224-a34c-fec473a0f180@lucifer.local>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
 <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
 <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 705fdff4-292c-409f-bdb3-08dda838275e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zia51UnIk0M8bgMc2r12F0DG3m6PGmVGSZYd7tHmIC28H4p9vJH/Ho5OYDyG?=
 =?us-ascii?Q?i5pgZCzvPydZv6T8YN8V0hMZ3n2zxXJMwp9495OVXGK0tVAQ3be2e6ZwOdDj?=
 =?us-ascii?Q?rzyo/mHZNnQKOf3jW2/lxaGlGk9lu/Qr10Ju/nBRy5mjqnBROYUtgjCu8Oj/?=
 =?us-ascii?Q?+sbndnxJ3GbPZfsD5RS4RWxCKbiews3BGYO5zi5xrMGSCGhc87XAph06H/+8?=
 =?us-ascii?Q?1jwy9N3WZsuenbqzpu/Y2vhj52aVUxZbgnhnnQ0T3keg62rrsCd4jw1x77rP?=
 =?us-ascii?Q?xTF9U5Y0MOa/3Ji7W8R9TMYggc20p20f3DjKn7NYnXdm5ISXGhWjH/sY8+J0?=
 =?us-ascii?Q?a+i5/IiW3tKmzlsH+ktdSnsUPx/pbAwgXnrZO1m5W2v7I+RhEn7KPJ2e7wKR?=
 =?us-ascii?Q?uWVWpMAu8kEIeR9kHjWruKdQ8sfVnCBmJVAWh/ZPNx+ZZiKg5aQvzoZrf5rH?=
 =?us-ascii?Q?zjxO1sPi7sA//AZ1OWkgtj4fmxlTv/e/dF7hiMlyNCThoMXDcgvsncbsq04X?=
 =?us-ascii?Q?yqolTlubDZm7DtVwkVqqHXMVNQgD/aPJTVgoKN3UvbaWYkDGFKVkcqCE4oaY?=
 =?us-ascii?Q?srkc6EnUCfqQiZJHkXZ7MUMEdF4rpHzaHdiShbp2hori7jf7B7Bzn7rKbQ2x?=
 =?us-ascii?Q?T9Ow/3xI8YwQHv51AUIZUwmsxm79ASftyuHlBuaFdsE1THzbzRiEI+Hsid2t?=
 =?us-ascii?Q?BItjsw5yaTObMkPsJiGppbN2dnUZt4WWr0WsXk/85du4+xw0vw17ykp3pT3c?=
 =?us-ascii?Q?duHLA2VOaFgF1cJQp5Jx+kfpXaHqoJHyZk3NCjfAKEZ0iUUNbEXUZyZp+ss2?=
 =?us-ascii?Q?Vx9b5SnIeNHc6pW0D6o5CmmbcrSpBeYcAp3dPgJtiedKqIQPUaWrHHyJF6oO?=
 =?us-ascii?Q?qaAUky/rtS/i8CCq8SVyxDTmcDeXtbBSrS95WiOiLYRZs/UN9jpoqKmnwwMr?=
 =?us-ascii?Q?IqVaZunGMZKu+abF6tjxXX/7I56wLdHe81RoMh0/iO8BeTn14fnaKEORc0uA?=
 =?us-ascii?Q?30ibudOO6lqeZqGjBkgOBCinFY+Z0C0wwqyET3hQZ0YrPC79QyGPWWPoP7q0?=
 =?us-ascii?Q?c6fKn/V3pYscL9SmhmybSJxDsZKsl1IxzdzNfi4zYE4uqDoaJoCT3hRLHWxJ?=
 =?us-ascii?Q?+k3x+RxXzfWDHCyM+p4pkpIZIObs0fpXLJzRqkGJBfdDRTFSriXnpdrlRAI2?=
 =?us-ascii?Q?lChd6Db4BQ2fc8OAqlKjjhfHZbDK+imsyZD+nmlXJ6CT4IzdoeknAZhC620r?=
 =?us-ascii?Q?jpBLeEeo3+lRxS6nYidgxdSDvWY9SAeQbno8F45CYuJYvFaYZhKWsxZfWooh?=
 =?us-ascii?Q?ifc17M1jKaY++qvw9vmpEUTTKOJk+skOOQPblaymsyN1mqyP+5PfaxhEyKzx?=
 =?us-ascii?Q?tduYqeoFv/pEjDe23hBiiHnrppkSxBmt6nx236ZKZ5N44TbYmNGlSYL/jR9/?=
 =?us-ascii?Q?JfCv6SxETWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTvLG+0nJ6Rs5H8cXEZmb7zcGH7XbrZ/4QedKnuMi79JqMvlY5B8cjCyGbaU?=
 =?us-ascii?Q?DkERfkkQ1XDxixtVsM6SaOQ1nQAy0sehsjWTG/Z4Vi7XXA7C7dHIA/Fywu4Z?=
 =?us-ascii?Q?bHJRKQvSOC83XKT1XEzFJBpO0czfNGWU87jSLXhRGNtGQCTO91BdhxqTVysz?=
 =?us-ascii?Q?Nlv/zX/jYJ33TeoYiyFOsWz+EWsvEJf1bivDhmq40zvvm3118LRjAB7KwlLj?=
 =?us-ascii?Q?lnxvGyUqah5XFua8kfk39OTT59NFvusoHGljvC4pIMkjJT7Et6Q+V7F7cu7l?=
 =?us-ascii?Q?JfmFfwD+60pQ/t4WyxjqJBfU1TC51qP9xXeQC9cPCjyorRI423NL6G9U/lBn?=
 =?us-ascii?Q?v4kMJzSgrAMWKJqafeKVanb/WsCeCgO0WuAbaZFHP1pNXXXbAuC8Y5v6k+A2?=
 =?us-ascii?Q?Qfp4lq3BTQWZA0PtnTECwhcvYMV5vbCZJ7ld5WrVKh1CRTl+YCvqQDi3sHNj?=
 =?us-ascii?Q?djdvf1utCooKdkE7T4Ly6YIjCq/uFQ7NTwPEIEfgcAr1tCijYqkxtpwLqpBt?=
 =?us-ascii?Q?HaypguZy4t4BFeMJNkXENgnMK7MokcUvvr1pZO9aWW8mYi34SEvF8YEl5gC8?=
 =?us-ascii?Q?AtuXgPa2OnTRDtz7dQ8Ka5Gs66zirg/FP3r5ub1g15b7gODixj1mcFrEMu1y?=
 =?us-ascii?Q?wmJ5kXorvFt05E/qDF2SUB0EVRFEY/n8nnP4F5yUseV3BF1EgccPBzqXzxNO?=
 =?us-ascii?Q?0tYuhdvxsVXu1YFeeMqHkPBAFCU6Ne+KA8Xqn3LdZrz3wJ8npgKvdu4A5xj+?=
 =?us-ascii?Q?iqwbPxoPfCknrigZD16Xz3uTacs5zzc0T9RTWdW4pOzwt2ot+mz18ZMZ41LP?=
 =?us-ascii?Q?T2+iZOqNDFOsY88lkSQYBqUM1gprcoBQtC7S649aXu/gHUyXmDQnKVrwSjhY?=
 =?us-ascii?Q?4eema2ODWEGFfyq2CepDyU8Ul70ggtzEfFEo/3uFno0DYpK9tbuvP4KmneDN?=
 =?us-ascii?Q?8ajEUIkSRFAUjqpXjoanC6zUn/BWY/neD5QYgqsgE0bq0znoUxIZWU5eEnYn?=
 =?us-ascii?Q?KJonETAkfVCEWK3SshUA8ITwAG+LKlPgZAatmHQ34GHREGNpY59U6NjiVI1c?=
 =?us-ascii?Q?l7klM6KZH4nh/btJn+UOlGOLVWOV+x+BdTVBmRaWd0PejwFESv1y4GM22L7S?=
 =?us-ascii?Q?AGLZmkuhdkkkP5ANoCH53rqgPfCqG36NSSPiRfCDF9zYTsWGKY8tShZMpElE?=
 =?us-ascii?Q?dRvXNecSWWBzBtCY8qOdu1YsFe+C6thVwmojLbm38a0f4arT9HFu61++Y8CM?=
 =?us-ascii?Q?rEch5KTbzbRD+Bu+1n0jaDmWBHQViNtrbbhQ/err/fme84Bo2IUZaSSuSNtN?=
 =?us-ascii?Q?Tg35T43lKMMVz2MxVmo0lrvVyMvDwsmQTCyj4T965ziYLJa9LdPLwXk+eH3R?=
 =?us-ascii?Q?9unop9I+/a4dftUndnC0ddSy/oq/6o2BBkMiY08wcrcpqGjXZWi0gauHiktE?=
 =?us-ascii?Q?p1UEHiZTqd6vDSc7HrqupDrN18YLy8+NuO8rk+vHwIjf/wBmb1JQg39Jvs5J?=
 =?us-ascii?Q?7KhRvxNeqEOYqmKZcGXvTUpAOja67y4RmVwVHIMOiaWO4EWKXy47uLwW8cCo?=
 =?us-ascii?Q?qdO+T8cuIvEiq+6LqhoBGzLL3cfru4GhUwNA8Pt7KJt/r3haIsAexZ/qnN6t?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HGrAPwvtP4+8wC1Sl+7brjdPoN80Ngd1Ooqx8o6L+mY9F1NwWLUWnLP3acklFp0TuZSrL9yOP1jc7NRAcufBMSjplRUIRPmxrl+yC5M5PoRxnhOFMmj4sVyhb369DPk4aLL6lY5wYkZ0u3E+V9RCy0sbgT+JvAEGTfKjG/eUpDXjaRr9zgODLTIHAuEdNkPDglSJsdaYwKQIeI1qCsjNVlKK9vrwcALL54sx5NI+gkrFSH1tcx8BF85FEj2dN81zvn8JSxpo6uV8rmyfcJmHW0cp6X4AN5h1FziaeD+X/MOAeLkJE6LK/G/X6+Khl7LIuaiBH0AobLqN8j9zRq9AvZO37p391JxkLakFPRx0N44bRcSNra8NtgwZBkULsEywMclLy+JEu41b6UO1dU41JtzOq0zOEJzTkFAB+U9kC8sJUm9vJAWurnqAiMUZtxPiXH8kGeyeQ6FNyS8V/I1NV3/yqLBN2JZwm0v2CXASzAq7s6pe6IX9q+E2qdkZdDG/ptzfryzY2Ik8k5vxnRRNbc5x1ejlm6vSm0KAlupPrv59RBek5XxKyI5yv20kC8pXC5LMlEI8XrZNO+Bo/kbiUMCHScSCvFoATqgSQ44rYBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705fdff4-292c-409f-bdb3-08dda838275e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:02:08.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXP+H9yqLR9UzmFHREVBf4jZzIGVms5zGrn1t1ljgr2Nuro424zeQsdWuVWGZ6E3JTqZ4rmm2t0ziiT8E4c6RnUJZb3B7V236BrheZC5oa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100128
X-Proofpoint-GUID: jz-DOh-1FQ44DwCta39S2_56Kl9wfObt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyOCBTYWx0ZWRfXzsQZoZtd4gKy xUuLbem1nbXcE0Jui2atTs+ASjeFFOk/Fjm3bDGO6Uz+xfscW1a3Uc8H2gDYYeGZwpZXueIp7SA h00mcN9mGnl3gmVHRxvuVjGwxKn1+na+o9kVugtThV3GhVTw/R9DaUfX5L71jgFgCBds3gdhuch
 JO1zm1umhVVpk3hZOwZngOGNZqLUNJuIBrmsMXPfJ25Oxp/SKUtaUcLnKaFGofyBWKdE4MxKI5w fnS3EojYW6URLpgui4E8LSn2PHi9ipUZwr6e+tb+m+3HpAedFnsnxJXOn52a99AIrYd6Cfg3jjG qCYuZ8atKJvyU+eFQrXysAhOskgy2rvlJXu/Zeo/49MOmd0XRXEY+NFagKf81vYs5hlpEAFOW5/
 j/hNXb4ldUk7gPfdKPE+zfdvfPHrC4QwIjYR847Ly7925+LK9FxaQkQdbqosSjGCu8Ojx05P
X-Proofpoint-ORIG-GUID: jz-DOh-1FQ44DwCta39S2_56Kl9wfObt
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68485705 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=rJ3JA6tlf9RhPkKgJyAA:9 a=CjuIK1q_8ugA:10

On Tue, Jun 10, 2025 at 04:30:43PM +0100, Usama Arif wrote:
>
>
> On 10/06/2025 16:17, Lorenzo Stoakes wrote:
> > On Tue, Jun 10, 2025 at 04:03:07PM +0100, Usama Arif wrote:
> >>
> >>
> >> On 30/05/2025 14:10, Lorenzo Stoakes wrote:
> >>> On Thu, May 29, 2025 at 06:21:55PM +0100, Usama Arif wrote:
> >>>>
> >>>>
> >>>> My knowledge is security is limited, so please bare with me, but I actually
> >>>> didn't understand the security issue and the need for CAP_SYS_ADMIN for
> >>>> doing VM_(NO)HUGEPAGE.
> >>>>
> >>>> A process can already madvise its own VMAs, and this is just doing that
> >>>> for the entire process. And VM_INIT_DEF_MASK is already set to VM_NOHUGEPAGE
> >>>> so it will be inherited by the parent. Just adding VM_HUGEPAGE shouldnt be
> >>>> a issue? Inheriting MMF_VM_HUGEPAGE will mean that khugepaged would enter
> >>>> for that process as well, which again doesnt seem like a security issue
> >>>> to me.
> >>>
> >>> W.R.T. the current process, the Issue is one Jann raised, in relation to
> >>> propagation of behaviour to privileged (e.g. setuid) processes.
> >>>
> >>
> >> But what is the actual security issue of having hugepages (or not having them) when
> >> the process is running with setuid?
> >
> > Speak to Jann about this. Security isn't my area. He gave feedback on this,
> > which is why I raised it, if you search through previous threads you can find
> > it.
> >
>
> Yes, he is in CC here as well. I have read it in the previous thread. Just raising it
> here as it was mentioned here :)
>
> >>
> >> I know the cgroup proposal has been shot down, but lets imagine if this was a cgroup
> >> setting, similar to the other memory controls we have, for e.g. memory.swap.{max,high,peak}.
> >>
> >> We can chown the cgroup so that the property is set by unprivileged process.
> >>
> >> Having the process swap with setuid when the unprivileged process has swap disabled
> >> in the cgroup is not the right behaviour. What currently happens is that the process
> >> after obtaining the higher privilege level doesn't swap as well.
> >>
> >> Similarly for hugepages, if it was a cgroup level setting, having the process give
> >> hugepages always with setuid when the unprivileged user had it disabled it or vice versa
> >> would not be the right behaviour.
> >>
> >> Another example is PR_SET_MEMORY_MERGE, setuid does not change how it works as far as
> >> I can tell.
> >>
> >> So madlibs I dont see what the security issue is and why we would need to elevate privileges
> >> to do this.
> >>
> >>> W.R.T. remote processes, obviously we want to make sure we are permitted to do
> >>> so.
> >>>
> >>
> >> I know that this needs to be future proof. But I don't actually know of a real world
> >> usecase where we want to do any of these things for remote processes.
> >> Whether its the existing per process changes like PR_SET_MEMORY_MERGE for KSM and
> >> PR_SET_THP_DISABLE for THP or the newer proposals of PR_DEFAULT_MADV_(NO)HUGEPAGE
> >> or Barrys proposal.
> >> All of them are for the process itself (and its children by fork+exec) and not for
> >> remote processes. As we try to make our changes usecase driven, I think we should
> >> not add support for remote processes (which is another reason why I think this might
> >> sit better in prctl).
> >
> > I'm extremely confused as to why you think this propoal is predicated upon
> > remote process manipulation? It was simply suggested as a possibility for
> > increased flexibility.
> >
> > We can just remove this parameter no?
> >
>
> Sure.
>
> > It is entirely orthogonal to the prctl() stuff.
> >
> > Overall at this point I share Matthew's point of view on this - we shouldn't be
> > doing any of this upstream.
>
> As I replied to Matthew in [1], it would be amazing if it was not needed, but thats not
> how it works in the medium term and I dont think it will work even in the long term.
> I will paste my answer from [1] below as well:
>
> If we have 2 workloads on the same server, For e.g. one is database where THPs
> just dont do well, but the other one is AI where THPs do really well. How
> will the kernel monitor that the database workload is performing worse
> and the AI one isnt?
>
> I added THP shrinker to hopefully try and do this automatically, and it does
> really help. But unfortunately it is not a complete solution.
> There are severely memory bound workloads where even a tiny increase
> in memory will lead to an OOM. And if you colocate the container thats running
> that workload with one in which we will benefit with THPs, we unfortunately
> can't just rely on the system doing the right thing.
>
> It would be awesome if THPs are truly transparent and don't require
> any input, but unfortunately I don't think that there is a solution
> for this with just kernel monitoring.
>
> This is just a big hint from the user. If the global system policy is madvise
> and the workload owner has done their own benchmarks and see benefits
> with always, they set DEFAULT_MADV_HUGEPAGE for the process to optin as "always".
> If the global system policy is always and the workload owner has done their own
> benchmarks and see worse results with always, they set DEFAULT_MADV_NOHUGEPAGE for
> the process to optin as "madvise".
>
> [1] https://lore.kernel.org/all/162c14e6-0b16-4698-bd76-735037ea0d73@gmail.com/
>
>

Yup I appreciate these points, and we have discussed them I feel quite a
bit :) I echo them.

Nobody says that the interface isn't sucky and THPs are not as transparent
as they should be, nor that we lack decent non-cgroup 'policy'
manipulation.

BUT.

We're talking about adding a permanent hack into the kernel that
force-sets a VMA flag for all VMAs across fork/exec.

I have simply been trying to flesh out the _least worst_ means of
doing this - _if we have to do it_.

That last bit being operative - I have come to think, based on Matthew's
feedback, that the RoI of permanently adding this hack is not a good one.

I think the case remains to be made for that.

> I havent seen activity on this thread over the past week, but I was hoping
> we can reach a consensus on which approach to use, prctl or mctl.
> If its mctl and if you don't think this should be done, please let me know
> if you would like me to work on this instead. This is a valid big realworld
> usecase that is a real blocker for deploying THPs in workloads in servers.

Please exercise patience, upstream moves at its own pace.

>
> Thanks!
> Usama

