Return-Path: <linux-arch+bounces-14387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F9C16600
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33AD18863A0
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27034C9A3;
	Tue, 28 Oct 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XTDslkzY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UtkEJRlS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F934AB1E;
	Tue, 28 Oct 2025 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674515; cv=fail; b=my7iErJP/wVLtBdBZtY/m/fHt/GsDvvcrgqVhd4/uq5IDEwKz/BeMGe7hhTMcaXW9JkuLc6KjjS5zE5CK135vQEQihePJvVcXqZl/9IUaVqM2y5VXP68hH0eNosa345rzTPvwzaWAMO6On9GBrkFFuGqtBCjxD5bCRAZsYYu7Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674515; c=relaxed/simple;
	bh=nr331rRpkPEU8h2TcKTeveAtkkOZzsJyv9VHhve5vFo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=AkBbTCD5KUJ7PHHJ5SMT49Cmub4zPKpCY9zJGfVzycDDnzC6FxFTMyEyrkh9FJD8VZ4Y8UZrqsao30Z3gNs6ojM5chvMMNroYif2TFvPtn13BlVIReFEDfCWfFN7Rtcro7+5zs0qvwx3mmW5wJNythQSE04jKd17OQsbub7gyOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XTDslkzY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UtkEJRlS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHYN3i024432;
	Tue, 28 Oct 2025 18:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UDfhcWFzSCu9yBN4fL
	D3PumvC/82PC14Hrc9djg7wNI=; b=XTDslkzYBBaajJA7u1eDDPUGxlrbWjvSeF
	feAqteg/XvY/TW1tmB4rUd/E+OEbLBYe6tV2sFRcSYQhhcsDyuZtpDEYNm/NhZGt
	jsHQku/PhYBXQJXntxh4+yH4wwCbB/B9Nw3h3Ck9/Js/7I2ahRWcHtxQA2vJvZC0
	5NMYkWwYaVlwyPQNWw+5b3UAkJzT1mnd5Up4100G3tNOrN3T4AzWRJ3+HBQ+IhPQ
	NTHfIPu0wDGX/Kh66Ax92w1ibTlqqz5Glcu82y1x7QOVakRJAeq6iTvHuPTz5SKp
	5ITQLh0+4/0G3rgjYJls0aSiN8yesTVULo5UazZn4HJ+9hFIJuyg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357ma4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:01:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHUSB3015008;
	Tue, 28 Oct 2025 18:01:27 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08ju7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czYKdShW5qkxLro/pJlil0Xf95c61WG0FXTCU+zaxytbD+YgFHRoNZFAURJTi1ULza4HqMAc9EO5QFpGMQH8n6gIPASA+A0Ng9nxH8TM55MFTE8N+l6QEFrWfSIKEVKDlCs8biNewQ28X8bMX+9CZeAWC1b9IV4P3booWYwpZflANCx3Sg78CT3CH1GQW2+l0kRQHUCfQImbpU0aVr3c8PKEnr7f2pnoFjVzYuupwc1SZqwIeA4KdqBQEZRncYKa5b/HMcUpm48xB/ubB30QvqTpNArWyVQoLS0NwLYKvn4RW9YVVUsmROyXCNMBl3L8CXvtmvijs8PctjDkid2aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDfhcWFzSCu9yBN4fLD3PumvC/82PC14Hrc9djg7wNI=;
 b=lNU5ePN94NWmYnQYUo9Tbn7dHfoCH0/SlxJnBGJb/nFD3dwf6dZUjqZEAxx4slGYj8GeLmkgVtmgy8AewNAisKgIGAikEVfsMk4XkbmaEdSsMG2QFPteB5xNLrQrFcZp3W18UY6xerMsWLSvjXaEBlGXfMH4Z6G/BT79c7Y1csHVNcv84Onxx6dAIMnkpB5HJmn1ZwLXGiJQShms1Q74Gejr30Feq066+v4JPbekXESTzB7FcUTPx8FDV3zM68I6DGYktTdhOc/l5m95R+bC7IVdI+rTAZfSSIPA/2rFWgv8B4+752yS9ijK0lvfYsNjpQ4RwA0JTt1NsytqmuDXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDfhcWFzSCu9yBN4fLD3PumvC/82PC14Hrc9djg7wNI=;
 b=UtkEJRlS73hpRzMyJmCYbgBgGrgbBhRbRqE8h8mSAzYYqnb7rEQTb67QiDGy4pzAOva11dB0xH3d/R1J/ZrKeCuw8a3iLTjf0Ay0f2YASRt8N04Xy9ndEV1BC512ZJKOGEuC3jf4TlkOm0wrr3mjETPwA6XIn6lbcv0BSgDel3U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 18:01:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 18:01:24 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Haris Okanovic <harisokn@amazon.com>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
Date: Tue, 28 Oct 2025 11:01:22 -0700
Message-ID: <87qzumq51p.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 152e9eeb-c31a-4e97-8867-08de164c01f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3bIj6rxBvyHVwY1CguIBP18vLXt8Gmg+ADydtSQEHOxYvpyM04GNVUdwQgW?=
 =?us-ascii?Q?FLXWhrlaYg020NKryv/YxgdMve/xKt9boVlreOU3+v49+INnze0ClgXKVQLo?=
 =?us-ascii?Q?368OGo4c1JSIofWbM69LBYhCELTW1I8Tl3YSZVh/vDJWKJSi9PRUBtPKJcoy?=
 =?us-ascii?Q?2+08GduY8HDmRgs1eWgcsGkBe2nS4OAtdro8QoHblbXRSjJefGVHA9AbylRc?=
 =?us-ascii?Q?DQBWAA6VNBc5Fs+FPYc3hvjZ3hbAc76mVrsYwb9GNn7cCrKs5Ehrj9NFTeR/?=
 =?us-ascii?Q?0hv6WlYSsbY8abnZj+gXH+kfatPN2WAtx8Y7Y+v4QcgXeFIaQlAfvqLVZBbh?=
 =?us-ascii?Q?F48WVNanQofXDJCW3Gj8HHqMCRQh+GKsrWYyrOQykPwERFjvE3os9jg2IaYl?=
 =?us-ascii?Q?Lxkt3Cr8vuFT3BMQXLN1GKxvo74CJSDi7Dsumn3EoRKM1HkNi23UYHGxLTUy?=
 =?us-ascii?Q?nLMWv+yNW+jNtK43cjj8SP6ISCffev7duYx0R6pebiJe+ehaNgNo0atsSf6+?=
 =?us-ascii?Q?owjqJBw/ZoRUVeKTX2j+HhFyBVZooFFoDWPon1ZWEzzEkAyLvKeaZJqTQQTC?=
 =?us-ascii?Q?i8dAkKRKqD4fF4dL2x9T0GBO2WrjCIcYD67GIdeEyTnm9oeAaqLybNB7M7lp?=
 =?us-ascii?Q?yzzvDRTu8VR+pErMRVpv3U4+Vf+on5Ty6/rBKEqqkP74OXsevpOeLbepq2Cz?=
 =?us-ascii?Q?7PTyad5Rt18h3K5LoonRvSQtNzKR36jGN0pDELvSLlVEmCLwZQwl0geCgfV6?=
 =?us-ascii?Q?U+9cT51KgE2x9/jyHiQSxQjOBtp2hnqrfKs90Mv3zrRSykC1vdN/YYIuKg6v?=
 =?us-ascii?Q?pg4Ey98+MsrI5688VNEg+OEfdZnnz03aGih1u3C1U0XFP67aYLV2Ky2A0nNT?=
 =?us-ascii?Q?maWVD5lJti9KgcypEftj1BJnJ6jB4TbbPatU/Ewpo0KKS5+R7q1Phf82V/iD?=
 =?us-ascii?Q?caK5tJDEb8J6beAsFVMxLyfbyOdS332yGLrtDvVpZiqKb9uej19j0L/yW/vK?=
 =?us-ascii?Q?sjph3p4jNLDKXNulpbLNvJSBH0iH5lnbFGEtF8OpK4/oYyZlHbjxPbKftf83?=
 =?us-ascii?Q?ebhXIFN0bZ6C4evpCBXlQwY/9oLda/iE19/XmajKtR+QJTm0asf1mY5KZ2u9?=
 =?us-ascii?Q?YGMDql3hGD6ScQPxOll6yMLhrlojZPrVvjr9AfWWlETrOobxyQdcLrwm2b72?=
 =?us-ascii?Q?yMo2xjESx9YDmZsJYl6mTC6xWxzk7YVI4fH6Dc7QwDT2UWWsUIv3VXtFx73O?=
 =?us-ascii?Q?YSVLavcH6lBgvmffciq7JVy7MWMi4V84a+6q299NxcImLve29pf5sdbLb5SA?=
 =?us-ascii?Q?0UzvOyi/J0eeeK/MuHX7YwIqrDECMp2ICSGCBgZKDjpb/XqkRb3FYCY13ECl?=
 =?us-ascii?Q?o2yBFfRWnq5O8Vy+wXVHOzFcwHC/PPI/9HksM65dz3+r0YhzEgojwTSusstO?=
 =?us-ascii?Q?Kq2deaU96owu/TYXdJVpcHZEYwNquyNezUWioAT2K6VSjuY5PgCbzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDfFItEt0mk+tkxD6oMHIZJiKjUOKEw7STpHPAoA1L1Wlema3rRgpeIOkaZm?=
 =?us-ascii?Q?rBopTYOxRjy+wEbXYFVf+8oiQTlG4Ve7OhLjzFFCFkpxHT5PAJf7RkWWkEco?=
 =?us-ascii?Q?s+NsnYJRf+F9hgicmWB6lzinn/4io7WRJBRbRGhH7g0MkRmRlP8CUfkVo1Dx?=
 =?us-ascii?Q?bBX3yLkAu+hH0t0BgNS5IaAr/jX+5xEuGkhMjxiBGGufTRm/pSgwGHsfyAi1?=
 =?us-ascii?Q?D/upkIK99AfvuXQ/J3qxJETMR1LxLO4VKCsAAdCWn9vccdX+U2+tMnK22vA5?=
 =?us-ascii?Q?BS+UgUMcoMklnBKn8TLs7oRkbtz++YZHeVp5jFD+xCBmwUpTlggLQMwgK0ju?=
 =?us-ascii?Q?+AioZmp6R1EVmzpFj6SDyD5oGQN5YbYeiTh2LOrnld1pxy2lJAuoueHRgDwy?=
 =?us-ascii?Q?4MinUCgzRDhfMrxAD7DaC7681Sj5QZyG+zIzmf6AXtWYL2dCERifHd1jY0au?=
 =?us-ascii?Q?2pPAFWAJGtA2Ez9eMk4PBtpsPk/Z6/WVy2ZOgAfGmpQdiu3rhPGmIZAvaPU0?=
 =?us-ascii?Q?tr9fkE4wMpiqd6q3ZbkR37rmDrMKQUU9uX2imfzGK3dTOg9UuFhOP+lk20U+?=
 =?us-ascii?Q?GgE8UVfCChg8S73vWy7AQl8nRuwB5WzJ9k3aiL4OUDpRenO+sLPZhVz4AXXd?=
 =?us-ascii?Q?YgQN2U27E6604ul6+M5uYYg2Sall7Yl11gtqZf7l0OQRp9sQq8i2lkKcg4HM?=
 =?us-ascii?Q?kVCHcBIC9a38OQCgKHgwdbX71cvr3sKIdeZ0kUkIAIG+vBWVfzEFr8ZPFau7?=
 =?us-ascii?Q?4DGSzHUMvU4InrJXOjBJbaGN6UgrdkZV3xuXnWw6DO85tm25jPmH1n8sUmF5?=
 =?us-ascii?Q?8x+Rw9jPqMcvAJhNYV2Z+TS58ZbaosyllYcJ+t36Z2fkIkRQKOOfoIyxm+X5?=
 =?us-ascii?Q?+S6gzwrpC4VC3LRl7QvOYCmoJTJLT/kGDG+sT3xhbWfYEemjDrCboLt6cRcf?=
 =?us-ascii?Q?7oNu6d0AnsMDTHzIZd2hgXYoU/BK1gC36zI9E7mQFfAzKbMH6GpcwcfHtTEs?=
 =?us-ascii?Q?8sWJuQoyJMHQTDJrakhbj1eoL2QWF0visOvOOUTaKUdfv14sE8tNU3Sb/8N8?=
 =?us-ascii?Q?dPUU86mxo6WskJTS6hb+r8+Sw4Gj2FrUKrZ+WS8x/GCoEXy7shGOaE7jEJls?=
 =?us-ascii?Q?8BYf+Ay4bEcYN1Q1/ZMijAHu/jVA7OldfJjHh9WOiq4Hfogxw8oKN6NOaXUa?=
 =?us-ascii?Q?c94RPBt5MwtRuGMaxK47IUArwCo581puy1RK0IG//V0XvCEUoSLaVT31nYec?=
 =?us-ascii?Q?+WNiONj8jYE4vTR3QvTp8qF8MZqSE18sBhFj9LsKcRxxaprAa/U6ySLUwmgQ?=
 =?us-ascii?Q?GRFxndzORvQuW2u5jytV2dbbMPEpMhd+cpE8DpsDrD6k0MONPfKbd5c4/WvR?=
 =?us-ascii?Q?MXv1HaA84fUil/PapqPEFqb/3/XmmceYVBwG8P/mdHnIDoVNzO9dRAIkiBjv?=
 =?us-ascii?Q?xzle+dj2I+hy5EtHXW74+NvbR4tHzLVZt9snIa3N1ILTKONtOuvWxENbk3Kv?=
 =?us-ascii?Q?PsOMochEznXE48X4eIbhq9CTC1ZySiqC3IF+UsNzfcsZqpuMEn/LnKwUqD8h?=
 =?us-ascii?Q?TS3156JH5wbQNVmYFvScyaWsxGwJYVUKDll295ZdgKPRPYIyUBCaI/yHO74N?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hs31psGqTVRLuDBx0CVu34A8/n68Ju4IvfE+x5OlPIIOr+Qn1jsr/VdBseoKxEPmN7aFnUPrbF4m7uh54uhhj4ltY5dBzJWXpA7NFh4x8+PF1nKYrJLrzz09eB5uIMPfq1DNRj98FCNGZ4A/XRd8BWWsJAY/PQGj11o3SWNR0Bp2i5MKdj2ALBW3LMvyFLowYc/6Iui8Bfq3iTsD8TjVw4fbhBYBFpB0/iD3Kt7NBl4Gvi7tbIDisGbkqIzbw3IJxCkB+7xl5G0UBKQE4dXzu0/2w0V6lWUcj9+mN0YDaImvaAzFiYkaFR/kWfBP0rrR8J3FM7QEgYtb+2IifSYaog+vnQbOvaCNxBlClk4iIrgmfs7YuKyHKpswywGZ8O0uBPyD9oGTL6aDHZ6ZpuY9FAkl0REl2EZQ2EptKadN+1wIcHMmYMOPKtqxuqBefixgrsS+0TYJSwq6YHmZXpztLZZ0CVs2tD0nGcL3URRTJwABxF7uSbqDce/gDSdhaed3g6lNTqraETNW3u3Br+fcPl5+ojARPS1jzw+90ApXDwSgknkREXQwg1tiphJ1BaYvOiHqyhpqszGuIZgQ+tJ6/QAmVPJQC9czhQeuxlDm4sY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152e9eeb-c31a-4e97-8867-08de164c01f8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:01:24.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+gmphpUrFjFDbwLDIum/Y2F5PBfr9qpNknGmqxxgTJAf7E7RkFv0E4ZB+5vfN4XvhEyjBoo2rV1dhdZM+rl/ACAVrWsPxtegtsZOKN9i5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280152
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=690104f9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tryrKIeg8lcIwRkrc0QA:9 cc=ntf awl=host:13657
X-Proofpoint-GUID: _gsmcgc9Tqj0JZLGkUDblORafU6-KrTs
X-Proofpoint-ORIG-GUID: _gsmcgc9Tqj0JZLGkUDblORafU6-KrTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfXxdpMy6ThVeyX
 QfIMG3X1V9tIcJ7dckaH54OXWyTdzNbnnZWtIk4x7pUlnVi7Vtv3VbuKzw1pq+ic9NQzCy3j7oQ
 AKxGKYc47nYc/IwB6dsBnoPOfp3uAUVpX09+SYzGrw8MCCH7ZyWrI0IwHdmpgn4ULhepgqgp252
 a1wKGX9vntP+7s9SIvDMtpVybcD8npdeO7W3bEXwDbuai+s+LmGRSflaeksYe3dA6tXe3KA2Oej
 lrct0TtdqQxYBoRFsqSmlcwAf2MtMvaUhlCHx/5hBlQ8HeMhOwbyeDLMxU2r7BgOx8K4lpdiPn8
 sPhcMJj/CZ7++l1eNk2USeeUSYlxlWvcj1G1hpm1DLYmu2t2hPXCD9RPcRT02drl/jPIjpq90jC
 r7OcvY3xRdwUVQF7P1ch6/yZYbwsnYltGtva7onjo/Z5whgfOAo=


Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
>> Support waiting in smp_cond_load_relaxed_timeout() via
>> __cmpwait_relaxed(). Limit this to when the event-stream is enabled,
>> to ensure that we wake from WFE periodically and don't block forever
>> if there are no stores to the cacheline.
>>
>> In the unlikely event that the event-stream is unavailable, fallback
>> to spin-waiting.
>>
>> Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check for each
>> iteration in smp_cond_load_relaxed_timeout().
>
> After I looked at the entire series again, this one feels like
> a missed opportunity. Especially on low-power systems but possibly
> on any ARMv9.2+ implementation including Cortex-A320, it would
> be nice to be able to both turn off the event stream and also
> make this function take fewer wakeups:
>
>> +/* Re-declared here to avoid include dependency. */
>> +extern bool arch_timer_evtstrm_available(void);
>> +
>> +#define cpu_poll_relax(ptr, val)					\
>> +do {									\
>> +	if (arch_timer_evtstrm_available())				\
>> +		__cmpwait_relaxed(ptr, val);				\
>> +	else								\
>> +		cpu_relax();						\
>> +} while (0)
>> +
>
> Since the caller knows exactly how long it wants to wait for,
> we should be able to fit a 'wfet' based primitive in here and
> pass the timeout as another argument.

Per se, I don't disagree with this when it comes to WFET.

Handling a timeout, however, is messier when we use other mechanisms.

Some problems that came up in my earlier discussions with Catalin:

  - when using WFE, we also need some notion of slack
    - and if a caller specifies only a small or no slack, then we need
      to combine WFE+cpu_relax()

  - for platforms that only use a polling primitive, we want to check
    the clock only intermittently for power reasons.
    Now, this could be done with an architecture specific spin-count.
    However, if the caller specifies a small slack, then we might need
    to we check the clock more often as we get closer to the deadline etc.

A smaller problem was that different users want different clocks and so
folding the timeout in a 'timeout_cond_expr' lets us do away with the
interface having to handle any of that.

I had earlier versions [v2] [v3] which had rather elaborate policies for
handling timeout, slack etc. But, given that the current users of the
interface don't actually care about precision, all of that seemed
a little overengineered.

[v2] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/#r
[v3] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/

--
ankur

