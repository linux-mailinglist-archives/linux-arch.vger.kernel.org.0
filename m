Return-Path: <linux-arch+bounces-14171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7BBE4BCB
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7AE4FBCB6
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2A393DFD;
	Thu, 16 Oct 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyBe+E4P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uAxgm6pX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887F393DD6;
	Thu, 16 Oct 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633869; cv=fail; b=qprZExT7ln+Tw3W7znfsDjmC4W+yenUh6yjhNgDoLaefka05eg+L8R0ufqoq+l7r5dtlho2hOu04tcTPRob+DrusqtJOVkftkeRLZ0mwJHvJBlm3kTMXsF1IN9FFEsxwfnUTOxqU2XLbYRyWwzzHpa6sE6x31W63YvTEc5BSSrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633869; c=relaxed/simple;
	bh=H1cM23bVozfscoufutmS9avMsWHkXRzo8YGLy3j7HdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsJD3oQAsI27LPYxY78h4/pkEtTe4k2MiM9Gqn0H2D/dP+dkb8FnlFnyXGtxZvhowWsdps9QIE2GcymwwLD7Y1qOIfIEX/p/XuyYN+yZqsSMSkTew8qGqY+iLkzlBOE0I8IbP/tkuFCUUumMhdppKR8MAmk2IuMpSyN9DnPZkAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LyBe+E4P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uAxgm6pX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVJu7019841;
	Thu, 16 Oct 2025 16:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hITPLeTfQnbmf/3ud/kYhMrZhFoc/o7jZCCMEQffRBA=; b=
	LyBe+E4P5XSyaSU3EgqKk5fSMdGziXB6R7loqtTZ94DdvOHMeQK0ornJiUsTKKlF
	J1rBIos5z+T31sdIOf4eaPUR6ypSLf2rzH4DQOBboUho+XJF1mOL7M2U2T+LDjAu
	jp05NF9z5ECcULeNGockO10PdnBMokF6Z6PE5iB9RFhtxmbcMG7qFYk+kZcHyKrk
	AIq2bJlJ2RRdzjxlizlSLsU4LgdkxYoBfe8G0Wu84n3ffhprtjj/i+1a/u9NkgeQ
	RvUI0HpBshVE09Hc8AeOW3qicXYFvCd3Guh0PIiGne00n4PbePsi+yaLs80fThzs
	1Kf+3rOxq/dj02EpGKK9Og==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut19vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFP1OP017915;
	Thu, 16 Oct 2025 16:57:05 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbqh3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMUksnZbSU7qAECQyMGzV4aYSKmyhuFObritJJhpWi3/b9qwflvGwFYaX2SkcSJkXAi3AXZ9tHft+o7GiXTcbIuBnyV9YQks4e/Ek/ScugcKi1xHKJwqodl0vFGBA2/wDHya/uHg//j+YE13ruszrE4luM7amY8vLf/47oifE3HA2BZL+4rlh/sNq5abHy3KZybPUEXE4v+QlGRabLWCK9HAURfte6xrHi25541lH6wrHoaKEz7mEnAaebGF5antrBA64iIscBC0FVty6fs8zfW1mM14XkyrU1yhKzmMfWpzA4UWfDRvOpCRvlVY/iiui9j1zjAQl9TVPCo/5nVwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hITPLeTfQnbmf/3ud/kYhMrZhFoc/o7jZCCMEQffRBA=;
 b=ylVzDX50BZ2AqiOtByRS1HJRaf8w0FQ1QcyaOyzS+taPWT8+uvg4zE4CPGASr+bE2fIwDLJKnUZ1b4MR+xaA+e0vTU+/P8ttvGD3lrTfrOhmwcCv4W4TlXnRBQleEotTcL+oekysrfXBf/z8XZFs5304LuzFQcB0qVqoS3N7ub3QXaJQT5HkL2BujAMX2fokwbA9PDHwS7URP8YeQ8+v2wzbjsaSZGou3i7x1F/pqQAFQI/OUXK4Hz09UPnIgeibYidk7V+e5/l/Foo39wnShlLimJKZ/myipfLE18DQFk0EfmJJXOLuclp46A9VXz+1K1cQyLpd97YOZDaY+iTu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hITPLeTfQnbmf/3ud/kYhMrZhFoc/o7jZCCMEQffRBA=;
 b=uAxgm6pX9n7xf2GCOGFfI7ebRWYXCPtH4gfFqT0dUGtJYbgQWO2NQEHxYbGIXzIob9JFvSNmj4kh4nJWwzcLZ7XvR2bvGMOBdzWMz9dTcBNKtaM93IamLM5uDMFkelduWDGCYzjxlMmA4skVxKpfSRHe4uZBs13MnaB8KcoGAeE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:57:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:57:01 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 6/7] rqspinlock: use smp_cond_load_acquire_timeout()
Date: Thu, 16 Oct 2025 09:56:45 -0700
Message-Id: <20251016165646.430267-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c00a1fb-22cf-4ac1-e385-08de0cd506b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFH7vTl7vVi++IdM3sF4hbHvMbM/LFRBonu46/RdNL8xO1kSGknw7zLwXC/P?=
 =?us-ascii?Q?7zgdN6+DDL7adIE1KiRQICCpA/UajJ1xlxq39ABQzQmen/tBR3vpjGYibYl5?=
 =?us-ascii?Q?kOl2bfbn9sHteq1JUPPvM6QCI4R1sMfPUJX8IdD5wZuMtiNP2TeBGOgiCDIl?=
 =?us-ascii?Q?OTcNb8XbCoc2JJMAOVxCj8ApGIQ8k+pNiZLtFBWdcxXKDvd46QusbezmHI8F?=
 =?us-ascii?Q?/JjnQlhtwzUvPwj8CohglSUXKzATogSHLjq5UqdovxoMiOW2x+2s7V3/UjV+?=
 =?us-ascii?Q?Iq2IHO2syGEqiW5h5qZc37mCkqmfblNzDtdxDrTmtNDjhPF+wCUhyFxz0InU?=
 =?us-ascii?Q?lguhTcgI5NEfxO++1JkKJhHSiIzB2CMbsmzRMCDDrlXjROKLubMiBM5vkW/t?=
 =?us-ascii?Q?q5SbxSseBMR7+IrevR5JiSin6B3W9w7Rm50kg6lllGLxmXWS7Bx4QEhpMXyn?=
 =?us-ascii?Q?GwZ5NKq16Nu2MPxAbfo7LKaMMoi+j7VdyaD9JH2ncIAOVsRykJKBi+WawI7u?=
 =?us-ascii?Q?l5qo8cv5AItqL1RWg/h8eB1M3wQ79vDysT2yyokVFs7jSymmNukPNQHzo/z6?=
 =?us-ascii?Q?BSV70gRtncR6CIjImncdA9DPuWcwuvpV9oHobNJoCEAi5O2kidzVppGwve4x?=
 =?us-ascii?Q?hQBBK/Anb+hObTLyGkWl23usOaC6CbQ9f8pP6KT+2NULTN970VWSGItX10xL?=
 =?us-ascii?Q?FgoexTNHYmuT2BlB+CrKLm6xNJhtFxISiooIZ9jbZ7Eednf8Ns3yJD0fLtdP?=
 =?us-ascii?Q?rm1Qo94eqir6CA4kPgb89nDuNKQhO+Bj0lw+vvW4xvqUp5nNAw7U/BaoN9TC?=
 =?us-ascii?Q?I+I4E6/64q8EbjN1iPJCy7oHy2WtSPzH11MRtjrqzB3B5w8dJqM63QJ1rOqD?=
 =?us-ascii?Q?70f8dESRS6/7rkjjdz2G4zhdPIwpxa7GnXq5xQnf+1o2OwcVG53WN9v0kFat?=
 =?us-ascii?Q?vz+nZiBq3XpyENJrCWJRq6g2uHHrTQNIfCGKWYTKBc87OFash9DYskhAm6mJ?=
 =?us-ascii?Q?cUx7216Xl/o+ZnCJWkgCf7BZsj7HZnqEXjDNQxAvGfvGUtInrdhTg9v2qJam?=
 =?us-ascii?Q?LtZghGqxFSdI/qYkKKnOw0UZ718xoK0cZCaVGUqnL8ZLxGhl056XBlphZzw3?=
 =?us-ascii?Q?YET3g68yRrZ3s11OZ5G9OmSzA1Gj3U3HZYzx5zVQeqG5bHKG7r5oZWhbpKCg?=
 =?us-ascii?Q?s5amPz97Q9CzZBXSuKyW2LZjtEKK9yopK2XcYyWv5ug1I1TfdKUfYSCybGWk?=
 =?us-ascii?Q?FyhbvNBFVrvi24JK5AJuGw4+U+K5UlAHMrvZazczaHO7NdZa1F8UIfNx0rhX?=
 =?us-ascii?Q?l0axV0v4/EfO/k0AIeejIXmh46nMViLcHMzsUfuU+HQuNI5nUcHT39euDWiW?=
 =?us-ascii?Q?CQsLwaBChpHWQsP8zWTqQUBGvoDQgL5jOloXyUifGod7SueWAxUjx2h1WfWe?=
 =?us-ascii?Q?b5jUP8I14SDfkoq/L0prW6C/359L59FC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r6qK6vl5Xu0ZWxXt2IiXR9beKpfeoQhZHDV7QgfebLDyGbrzQtGE7b/KgFa8?=
 =?us-ascii?Q?WY7ghFsjd362Y9VGJ+uzLoMY5ebpJI1+noQvCjKkglw+H8fPh7LuaiWZqJvN?=
 =?us-ascii?Q?O0KHoAyhWsXZ+WbJJzoRQJliiI2r/lLTH3A4EdP1ge8eEaUmJU6hHZ/yALYf?=
 =?us-ascii?Q?NjigMU/u8yP8VdjNKDwKaV4iFhRCbFrVVw7I6TmDDCsoWHFp1jPrAouVjcP2?=
 =?us-ascii?Q?Zn2eeEwW3i2heOkU9VnYMSj/KtwBmMa3jYmYW11s+MjTFQ3LZeOrCxEL8RtS?=
 =?us-ascii?Q?a94eBbN/rJBMcRISPLbKYWReuZ+OmerYYXbdA3h5VMrz6XZqpTV86SkXkzXJ?=
 =?us-ascii?Q?QH6V5totKJi6lV4lg4RKD1Qi9qZfsaAmqKc8hp7gCWqO13DuTAQz9clP8a8I?=
 =?us-ascii?Q?Ij49WwrwcsZ3xIzIv+m8utGNdwKxSsh7epVYwemoNxtMdVKM+Z+5vAgA6jwg?=
 =?us-ascii?Q?zVzLRF7eiUZV44Z1inZUdmEL6+1qpvF/VI7R6Te7W2CTzOh7UWEASAPOi6r1?=
 =?us-ascii?Q?KLg3tPvbvxhQ79R47TP7+eLRerxeVig3YxAiFkx7EDJhPDahDS15s6NROciA?=
 =?us-ascii?Q?s7QBYmnH0rgfMaimFijehAeIXp+EpdyE0lJc6WqRMEOpNTMwYpjj4bupFnXL?=
 =?us-ascii?Q?MnJb1MJmaPZwr/Ld4MzRQpBpPrMyfRrfNqIAdEkWvVhASMoIpW/64l/WRtDp?=
 =?us-ascii?Q?ArCWPDc/dop3AOkekPT8w6LEeJjovkp29bgZY+9jAU7F3agSkBhes1RvmRsV?=
 =?us-ascii?Q?ss802vKtzwG7+nZjBNDpgH6OdJPlAMvkeQ9k3TYbya7GB9OarvXUtZw+nz1s?=
 =?us-ascii?Q?MfG9M8fmcg6edzXQGMOT25VVaprmGq4lYBr5xECGBae7yDJsYIMkH4FTus5l?=
 =?us-ascii?Q?SP3RMYD3ZHI2pu72yT3xSNS1FUpBKRlKh+61T/Ny7Ntdp0WZ+rnBSvn6tQVK?=
 =?us-ascii?Q?vuwDPpxa10UK0olaarEUJ06/P+8jPvdPNkxvWoPGtkZRlhEbcvqEZG02qYAd?=
 =?us-ascii?Q?76SJNK5oFzhpPLmTTsSTpgCL71Qx/02skgKnujmLJBgE9TyB4o9GUQ6iP7QO?=
 =?us-ascii?Q?XfgBXAfuq5d820sitwr4h4wIA038xcH1CHAG4To4T3vJVdKZtIjMuY4kzcxQ?=
 =?us-ascii?Q?6NY6qY2wT/uUBdGrZW/XdqOd12OsHXFisBBuxzPAYV+k71oJIRCRSGNvI6Qj?=
 =?us-ascii?Q?rMEY2XGgCLjBWL8xKFGSuIsgX/ijmHZdNNC5ASbua8u+1o5rWcgOmaEHGJWv?=
 =?us-ascii?Q?2IOjhF6lxkIOYbE0udmjQ/y1EpdKz8x+pZGcPMZWwSLucaXibw4NzcN9IPag?=
 =?us-ascii?Q?DCicCukLOt0XZnMv9B06aig7cNb+PNrfUHGHH3Rjdo5eJM1SbH8ZvxWY2+e5?=
 =?us-ascii?Q?v0SlB2lQyNfb5mdxplR05IoeEMRBnkpcgQrDdSN2oge4+N9CJYEOeX0/I2QN?=
 =?us-ascii?Q?gERJ2cAoHNjvIELuvbcgSg276c4NKTSLHnIi2oqxRd7/fcHgJz2T4fAJJ9Sv?=
 =?us-ascii?Q?BR7CQRTiA0unI7QxP9EMC3tb9zN5Ox5ZhDgtax2f23eaGhr64L4WLlMOne51?=
 =?us-ascii?Q?EGKwCBz2N1/kUUIEGR8hvDEBlfsGvOUAyQmoj+EodCCQDjighRaGNYDWa/e+?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ueLPDmfhbWqrsbZX8P2WY/2b8cNLtd7GKQtB6Sd6Q1ZBLq1iMBZ6yL+hioleei175Ob20stnveJPDaPjj9VlZwbcH435XWyF9pAfb38y/V+uVUItAe1lX5+3IL/eUMmeWsRoRmtPRf/+M7v9QT2EfmIrF/gCYaJgYlV9MFccV1ebcj6SOu1O7XpeJHxkFUXC3pXYaqAGghRdzAlmb9pXxG6JRiFVGCcxAOZL6daaKpISYkyhGWnQrYuiBQ7c3etPPrQiw+qi7iJOVHJYlAPpQb3151+iEsxLDhBA4tj6kOjp14+cFD9HqyxrADxybCdMS8Fv7tJcWTw8rxmidmIumBtKiaE0zdxYV0oTP7yxWd4oZ1UtrjEH/5BkxpfEm6oocJvjYoaMtn8shTy45fMcqAxZyIR2rQYax53JL/MKwu0x1ZOh3in9DtSY+dl2SStHqMXaJkci8QvHUwBZdk02Ha3UDaHNDo830oftCsR9+v7EPvJ7YwVtX5a1GXG69CPwHMKP1RXXiAX4oviTReu9hQU0BWq/JIKCm20JYDZ0LF5rFQnqOqN/E3xH11QboaIfbWaLPwBUqiIx6m7kmPJFmYz60ChtpO7IctKIXkayczI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c00a1fb-22cf-4ac1-e385-08de0cd506b6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:57:01.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebWZW9t18qv0UbYyIeoFNpbY+ml9tjp94/QncNMW0hrphk8l9cJ6oRq7N/EQGeL+fGr3U8xIBOC136efdu3SytFe1ZO2Y9Cg4c8KGOa/FaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160122
X-Proofpoint-ORIG-GUID: 1EE2afppU0UaRbhBX4vTvmNynbxR2pHd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX6c6zDeHXbvVO
 Q2f0kUKPBLIq0KE/2uCMc32JKexgjEo20e9vyArDP5Xlkg6U2V+OsosoAwd6wxXTTeAJY/Uu1nZ
 Yi6+9KsAyz1L2Q+c0E93u02NLPS2dIxBHBQjoAqz/M7KZmfpmRWEpOy4lsD5YlVEDCtsIu34+BV
 hi4TBMonSMz4LlA1I6OW6yLDajyDQzCRyXusjeoblf9Q1/eZBbSYEQuh2xHGcs9X1HhOjEpP+EW
 i03ty2xQDF7F7n44RGPRed6GBzU++xJp14GAxwEQIlegvJqaFtlH5rrbOZTutrGW6pd31hrRQs8
 E7oBpgdem3ftnUzmWAHkidFEc9hx024HRFI/h65ICqTLmahnddRsjDQj7+nLKf32RxVNOWyZnZh
 AA+zpPiRjpFQxSxhdn8Dk8pLRFOjAw==
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f123e2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Hj5KyUW9Q7wOCK9_zGoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1EE2afppU0UaRbhBX4vTvmNynbxR2pHd

Switch out the conditional load interfaces used by rqspinlock
to atomic_cond_read_acquire_timeout() and,
smp_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use
check_timeout() directly.

Also, when using spin-wait implementations, redefine SMP_TIMEOUT_POLL_COUNT
to be 16k to be similar to the spin-count used in RES_CHECK_TIMEOUT().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index a00561b1d3e5..d9c14387ae45 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -241,20 +241,14 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Amortize timeout check for busy-wait loops.
  */
-#ifndef res_smp_cond_load_acquire
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
 		if (!(ts).spin++)                                     \
 			(ret) = check_timeout((lock), (mask), &(ts)); \
 		(ret);                                                \
 	})
-#else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -268,6 +262,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often check_timeout() is invoked while spin-waiting by
+ * smp_cond_load_acquire_timeout() or, atomic_cond_read_acquire_timeout().
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -313,12 +314,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -418,7 +413,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      (ret = check_timeout(lock, _Q_LOCKED_MASK, &ts)));
 	}
 
 	if (ret) {
@@ -572,9 +568,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
-
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       (ret = check_timeout(lock, _Q_LOCKED_PENDING_MASK, &ts)));
 waitq_timeout:
 	if (ret) {
 		/*
-- 
2.43.5


