Return-Path: <linux-arch+bounces-14365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB3C12F17
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 677A6351FC5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A829E0F8;
	Tue, 28 Oct 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUaOKaFm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ToN16KUl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7E29B8E5;
	Tue, 28 Oct 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629543; cv=fail; b=EK4aT2bweetRuQWYwUCGSnLNOep3IkYOPWzLQpuVWcAqra62dCXsswmaUU8UkU2Yc+bKq9X/I3r/uwA5mrGGo6TtaKuilq2EYs5erVmBag3DO8aJOIR3LC/7/9Hcj02/HFYezODon4RTR1YJjripVGfHDxgoif4wbQGvAOZkZ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629543; c=relaxed/simple;
	bh=FNBBPkd4C+8kMWKJhQnjvIR/0a56KaQDaeowZzbbH38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMnTpQSABuTId7I/LUS+Nn6ZuLFu9n+urpsn+IkpkJred8EP2KvcRspez6TnZqBoatGu/TjIY9i4seOt1HlLRuhPP7ii6BFkh1BgQujQ4rXOoOaaXXE4lI0v2qPhe+u9InihN2Z42i3XWB+WKQWEWuXvrIr+eYiwqdPNM0rg7rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HUaOKaFm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ToN16KUl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NMfJ025771;
	Tue, 28 Oct 2025 05:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O8RVxnbvgdfuSCM/DiRWjegJbz99rDvkC5TsF4Qm2pU=; b=
	HUaOKaFmEyRxYnP0VScJ/O5cYQmS/5ElBkLglWsbbOd9GbuwATKhzIpnDFYPrmCo
	RWMy51xJjr+5bY/f3T1wD3ItFoU1yqAmTVr8M7r6v4wzTS9nMwGuMrqM/ebOMLiu
	YeVHaky1OwtR4IS1f+DDPJ5YHAWvly6DKFvRQBaQCiElWOwzpVDcnuW/i6Hc7Kc1
	tvtrx5N82vXVk9VxPtPrpID56u6LJis3R6PpCzL9hOlqNXI/q6lMq+bx2Y1za+4r
	1jVfnh/bde0GznjYDIF340oXIi6BrrWFXvI6gVgHTENjA6tiNyCho9+rACj21DQQ
	W6iKg1ZpdqwJ9PU1KOUaWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232utn63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2iEDo034916;
	Tue, 28 Oct 2025 05:31:46 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pf3qn1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+XGEKlbHVdeAwo1/Tr7pjhYn6mae2GHS+y2aP4g+91Hr6+4Jp7X/MCv8w7mC+KGz62W5In+KOQDNlxLl8iK1sQ2ml11jfUTsRP/yzhhib63AR0HSLuFAG+7QXjzYs4caDTYN5uGkcxwYInonvsH2Xsg3rFyYgIKcsLyngSdeA2ybMOm2mlt4hPZqdqcNA2diTc6oa4/+Slsfm7IUQsO+QPsNjusVGTKU9RH5C7VTv8Z3bJ6gffNT7w09/bT0Rl6IrmQ+X8fiNmINkW8bwCXc7B5Qi+KYz5e9Gfi1K4Q3pDA87yXlAnajwqJpCwwWHDcfbn4pV/bb34+LI6BtBZO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8RVxnbvgdfuSCM/DiRWjegJbz99rDvkC5TsF4Qm2pU=;
 b=V0uWaZIMRYG/TTEMhm4I9p5uY52Mo9LqipYvW2KgZmZuOYKrEWl8Kn0bcsEXmDW+KmBG/ad3oOZPTnFh1fdHnyRfQaboF5U1sxDxeXkor8PAC0mYpQ6znFq38Z75nEN5HMoRlbZ6phn4A6IgZLFEOj8+qsLUXBCzveHlv/Tic4ojZvWD1L6dQT/cMPdaysu7S0GZFAAmE712ZsghRg6susrsYFXfkMxocQDE0lrYqvgls3pamslUG64TxDBAgZDRMUn/yFzTyXUtn+d4LBhNivP7DMIvhGzHWGpQoH2MbjC/86XYCNIyJwz1nKPp7uryIhdA8yrCmdMAQiOLtvCgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8RVxnbvgdfuSCM/DiRWjegJbz99rDvkC5TsF4Qm2pU=;
 b=ToN16KUlq+TQVJSBkqEs5ux3l+CCVCYaQerh5I64OKi16JS4l2iPzjlzmaHuzIlBz6mkpMuoIUq2W+173aUrm78wYGhWSP3rYjQUzsRiw2W/e3XYNlp71K9REnLCF5N5qHB57WqwCruIf8OcS9Q/HgtFIU2WedPiRG/rsJbjx8A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:43 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RESEND PATCH v7 2/7] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Mon, 27 Oct 2025 22:31:31 -0700
Message-Id: <20251028053136.692462-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 37940a22-d32b-4131-eca6-08de15e3476d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhHBwnAx1IsiQwXEMYXVUQZdw7cNT76TvNg07jxa3eKZ6lOwfgPhMpW87sOf?=
 =?us-ascii?Q?8en6e8lHVMu1e7aa0leON94XemI9dfZgu4iIfuw9Rd43xNki29eKLrynrYJW?=
 =?us-ascii?Q?LNDopV+u4liII0joydSQjzfLJqPsXURr51DXJkAUvvDmvRXLrHJ3B9coM6Oa?=
 =?us-ascii?Q?h29gS9AvmLCitHeXC5YEy+gcPChWCHgR3T7v26AUiBQZQOxWrfBbMRu0QQL/?=
 =?us-ascii?Q?uUTXfmkWGNv/nMpe1eYACWKPMHVZcAjTkIqH3sOA7H/1oiFGGEsc1SAn7OiU?=
 =?us-ascii?Q?n6KP80hCtICkib8rjMKTEVtCVKkRvev+WbRlvTiDgLWjJkWokBGQ04zAyPrd?=
 =?us-ascii?Q?CgIvAIM3KyVtcCPXVC62lLExwtfwh8X0x4oEid/mJSioWR0WPVwiGZaGBf9X?=
 =?us-ascii?Q?Yx6Z9vo//ZUoz8I7qxfqeEhJDJXOhDCFpDbN33+ldEiBZSniGGi2Wvi/adHS?=
 =?us-ascii?Q?fDrkOX5y1Fi7Pkis0CVEHl478rMzz11tXsPgCXxaUBCgfyoyFmQ3wbW/m6E4?=
 =?us-ascii?Q?mYfqsps9Jpi8bPHDvveFdfSAkKnwCOMrmcVNrrFVBce+B4F/IV800oH4YWYm?=
 =?us-ascii?Q?/k85ge0eQur4irPyXJ5WpSDpn+pkjuvh/wlT81q2funyvtjNS3o7iWnT5e5m?=
 =?us-ascii?Q?VcXm2ZMQAdsl71DdJJQuOWup2C0eALrireRu7OjxpaRsZNj+m6KNEUAn1Ja9?=
 =?us-ascii?Q?z0DShRX46cDUWmKfkKRRTuLAZeV2iT5t2FGh6x8e0MglKDpbgg/2EGtjV6ed?=
 =?us-ascii?Q?gEKzM5dFhY1v44ZQEvgtEiaKfQsfzJWTceM2grIvm+UCPcSXjPNi6E+/DfQf?=
 =?us-ascii?Q?5s+Q8GRc8NeH1LQDPBS+ktGnydTsD/vtRehG51qXvPo5lmaUfLwGT/s6oWRE?=
 =?us-ascii?Q?hodoG2Fg+HZFsZgT190vhysqosV9LXsaXbotizrdRtF8Yez16cHPyfQAMlDo?=
 =?us-ascii?Q?VAorcp7esGiTRRBF6tIjbngdacu0+Aq+dBo6pOlJNlThzsdBLG1rV5NOYoCT?=
 =?us-ascii?Q?Tql1b73F7q5ku0bGR1v9dyMOJER8n3d6dsEOn67WnKYWxvMOThoacJ4ycKGx?=
 =?us-ascii?Q?Jmeox4jz0TQ8G2d3oVF07Yj3nddBSMJoEF6lTKEyczo3sN6Hvd6TNhCKbAen?=
 =?us-ascii?Q?DwmXPrQTc/+yfQ02+YbOGzjBHS5+uUHcbnozMR0HYkC+8adnYHahWDGppvg4?=
 =?us-ascii?Q?eBk20tQaxa8LR/+Kw19wZZaT9ZpOzWG39GKqX2Ses0tUUqP/9njxfT9YKsTM?=
 =?us-ascii?Q?pMll1nh9c4ik4WVGb6DSwh2Yy3z5rcijUvBqaaMXxKiWWEczPJ/2GOQlH0ky?=
 =?us-ascii?Q?0wKByEewZCniyhSYT5L9TuEHSwNqnh8BQUs/h2h+toJuWf0kY3l2Xg5JZXKE?=
 =?us-ascii?Q?57/hhyK2ReiyM4uAxuAIg/oVBzjA6ZgZfHWg7ogUfNvTo95EhmaiUD0We32S?=
 =?us-ascii?Q?umJK08nFFuqm2ocDnUN0mU3chOl1gAZ7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2asDMj1nccWdRcF3fiGztAozK88WMYpai5e1plrPz5VyJGeDmgB6SXm6X2bS?=
 =?us-ascii?Q?uXLY7sdFnstcAUhOUEkVG2Ihl/vqT4JQmju7ztWqBrFNKRjfNyIRBnvY0M9l?=
 =?us-ascii?Q?qpmJUWbxRzxJTak0c/eOhVEzoPi6O5bKCq5Nv39Z9Vp64yNzGqt7LJjTI8hN?=
 =?us-ascii?Q?P5c84T57H00RBQAxFpRxHYjoy90HjOejmKQefWPQdBTqVovlxE4lnArnREm6?=
 =?us-ascii?Q?Xx1lSRNtZpv152vZyyNnMXZEnOtJ7ZQ3jav3VL6p7v2LeZnerUGUatoT09tk?=
 =?us-ascii?Q?CHEr9Mtcdda4bwAAKbt9PCOBfCW9Tkl2BgNXzMaocIJpg9dVHSBY5T/tDnNC?=
 =?us-ascii?Q?DKUUhAo2Q7+uE2vW+a3Ud1XR0dDwa9wUL2jPGQGBE32DYqw192B3lJmPFzRI?=
 =?us-ascii?Q?g51YGPRVw+7eZ7BHVGjqsU/RKUJSyfFRFdBTsdGJl4orTTsWMJf5rtBwv0o7?=
 =?us-ascii?Q?yU8frx65f/y/uX9CnsqUGv7Vtof7Hf3f6w2gsupjUPQ3FUQbvpWoMy7AoxoO?=
 =?us-ascii?Q?19TKcjMB+GVISbdIPVaTBGXRroQ2YFXfNFI7m4ceI7q7tsAfsgw/x3tvb6AP?=
 =?us-ascii?Q?4JDP4T2K1u5wGpIOud3N8lXwCtznK0CEwWpsIMNxkhetpmX1tc5BfOoPQa12?=
 =?us-ascii?Q?vkSSNq1p8CqsKVmFUD+H24I9EX49nHluX5SjQAlTknOL6BTu/T0+v4HbTCnE?=
 =?us-ascii?Q?dlNLS8ANixP8R5XLzAw1zrGdnC//J0nrEvT6eb9+SKYgdJEoLQrhe536fKRp?=
 =?us-ascii?Q?HK7NrY+H5c9g0D1AJ/0tgjhVZ/PN/7vIXYaVZVOGjy+MaMMM87p+ob6vhAuJ?=
 =?us-ascii?Q?5EWQgjp6v7qKMWHMF1ddEYTrXcJzouJePfymqYFTwEzEg31PUc8IvI3nsrw6?=
 =?us-ascii?Q?W13Z3MnwqCLrfgZP688uvqxO5g8T9MRyVyyFrjfi8844PnT9wIBJYxv7a0G4?=
 =?us-ascii?Q?btYNmWzOHCUvCnnSrKm80Na/2bEdQTpm6uv0xubuORh+gMewLMQa9S4t8FUo?=
 =?us-ascii?Q?N3jspVqu6NWHxtEqe1CCWBGdN0e9qiklX4/L2TIPjSv3OJhLvUFNsFq3XjPE?=
 =?us-ascii?Q?L0ECsCAuYwW5kh8Q4DCbcyojBniT0ob94MNxlIa7YZNi9Qb3vUKM4IB/Kq6G?=
 =?us-ascii?Q?LgVJojxrLRAG38x39MheAN9WaNMu6qJXbKD7+cOPr2qfnXjl4dEf2Yl18YG/?=
 =?us-ascii?Q?TNRHCxNsw0Xw/98/7kU8cgL4bgCXtKjYFUILWbHDIyDkeEXYK4+bS61FTSBD?=
 =?us-ascii?Q?bwzg1Djxf+iqwC00ocZDM3Bm8ml67Q1XGJBwyvp/XBAQzshhp2TSACO1hBD9?=
 =?us-ascii?Q?1MGgiR9mz7zf8CceexaVZaskouB+8QNFvl4QIF7r+ml+f53SICuK+t2CAQhq?=
 =?us-ascii?Q?NSk46EqDFERYiArGPUvaNlt8PLqqJgOwKhsT/Qk3jhYl3JPVPZ2CKfit42bK?=
 =?us-ascii?Q?6LCQeRcak8jN4V1n9hIcEsOo+tv/fjzp3AkGi8adj9u1ve1RmSCLYJP4Rxaz?=
 =?us-ascii?Q?QQiWm0ywL3GilY7eMt17SKUoENYjoESMO6myPnshcfI7moRJzMTOMVPIpr01?=
 =?us-ascii?Q?Qd15w4jCPnL7rwFkKR18oPnei71ZpI2sHSrJUjZVqI0Z9Stt6JQ0R3WZYxc0?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3AJR6CTrUHjW7YyyrKnrWi4OVXTGtRrZKrygxFoJcfQSJ3XyPd3xHV6ZhdB1YctLWImD8L86FI/roRmvjvcrdq6PNNhvd/Z/+GjuqwD8MRz9t3bcRjusvFav9x7vn769eHOjLz7vgm00SMeZjfQlhk5VTaMxbFhd1Be+xlLU6U97vvyMl+NR5am5t4SD/nB3Qn/VUptVR6Izu+WNmo+i0jaIiXA7+EBZ7dOdbTFHr8/J8axPE7qx41902TUtckbKtwxy9xWio5ZEpSNgQN9DOeHS5OANvZVcKqpUxo20zmjE3zqON68AOVCrUOHfjItQZStKK2AclAUuQpa1oiAFQENo0QgmM2/Bsfk5FCat/SJZ0ok073mKzytieP7VMD9LSEjmPWBgQ/9uKfWs8S0W7m9uLYfbmjR4H4WIQOS+jzLoSzY/hayfeNP/QGxwPay8G9DJQ6Y9OD76iUdDzdqARJrYpIeE4GJ4fvvpDB+wNL7RyQwBYxmCgXnzqQBvdVa2u+IwyZN3Yz2jD+eDiq2NOIPQxoyVlE/4o3NON18ZkFtax4nhjXvXQTo4MW8kjdDowyCWymsi/JlbMFWoKD2p0rS9VVOgC+jFbW7HpfawinU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37940a22-d32b-4131-eca6-08de15e3476d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:43.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: redgCABiyFBm6eFw9MW7gu23HTVgIN3N8EnoAt3c32Ebmevzne7u27kVrT4zkQj15tJufJSUcIs1Z9ufdpHrnkHaxmbeHvlq1A/o9Ct/HQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX2h2AzV6byNPD
 CByfi4w8DXgaib9kCfeqOp+9nikUZHUaA6wj0jnWUTQw59UPceJm6oopMcs1tGY14+zBlDduF2G
 Nuini/c76jLnzfuDBA/sO87cXaEJlUJTTG/Mj/CSaVmPcgpUaeL+DU04qclSyB3XJsfvVUcWUWc
 2H0KK1Bc3SuRxL6/D0aMd+Wi6PphoTX0rZv/1heG1qFcWnCOkJXlEmVYy7clC19iZTx/vRiE1Q1
 l9ze79homMHgVwvq60IF21nq3EyYGmGPFGHYgd09kF+n2QH8By8sIHNgve2FEEPENTygKQ5e4iZ
 XBLf/HnHq2PAsCdT5qLYOB12oYauO/v02S5qyKwtRAOZsynn5uNob41A0htbrgYGCBAnTuJk12T
 +xXml47sGcUlh/mgvvoaLc2ZcQnHNevlwOqYem7uz+1sdrryjtQ=
X-Proofpoint-GUID: ATAChTvYA85nWj6krc2-s1s6ELRBNzDB
X-Proofpoint-ORIG-GUID: ATAChTvYA85nWj6krc2-s1s6ELRBNzDB
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=69005543 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Z1HUBbmx4UX_vy3hcwUA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12124

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). Limit this to when the event-stream is enabled,
to ensure that we wake from WFE periodically and don't block forever
if there are no stores to the cacheline.

In the unlikely event that the event-stream is unavailable, fallback
to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check for each
iteration in smp_cond_load_relaxed_timeout().

Cc: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f5801b0ba9e9..92c16dfb8ca6 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -219,6 +219,19 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define SMP_TIMEOUT_POLL_COUNT	1
+
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+#define cpu_poll_relax(ptr, val)					\
+do {									\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


