Return-Path: <linux-arch+bounces-15404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4ECBC859
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBC93006A57
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE9315D24;
	Mon, 15 Dec 2025 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FcYKRRHR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qYsz1YYm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A342A96;
	Mon, 15 Dec 2025 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774498; cv=fail; b=TY71X9VAg/qZtjK4FobfgX35tzgsK/XUPHCUMV4GrdRm3R6aaMhqtRq9yv3VZnNI6GKrEZJW1hauGENqtlhO5/0s3O2cxEClH6qHlHSiDu0muTGyMU9a1T0MvAkZudx3ttTSgS/kWgWdflx9E/ow8fG3oOtvKQ8xYe47F82arc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774498; c=relaxed/simple;
	bh=fLzo2MKS3zcjLUWyddaAdPyIlMm7AdzWYGTGhHuTrXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Al6V07vy/ohMv61dzC8XyOJ/NBn2EhDxLvwJBXuuFrUs8taNChM5XtQbfJ/VygB7MNwC6ZPPGw8TP4Wa+KDjbidu9J47T92Y2rdycVXHJ94XwSum8GWvIKSdqtWls7yzhOoJgkbyX8js64bziOotZtZ4lhdu27eOBo3314hgI/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FcYKRRHR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qYsz1YYm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF31B3D1243278;
	Mon, 15 Dec 2025 04:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=; b=
	FcYKRRHR7YrC4fm/sFIdVUzQVAuSXi0Hl5nF+Q2khYkh4R0rMO4I4lXFUpR8mXX2
	pu7nIebPJPaF+TNLgV5aJw2kXDn4fSuj1HW0IORLpQC0IM8sie2hco58z4rw9Jg5
	ht/5vgbrCY/azV9rYOwqxDObeuHQz3t3bn0uIRF2QCtPZzkP96TZPdqgxmO9QeJs
	q7wWJayqAyYTbn8bWDNfUq6mnY4mEkyOLJq7sirt50wZH6zxhs57v9ULR2c5Nat3
	MJYwNpugygXzD2DYJTNmWNNpWRQT63h0M9PEWqArMmtKidfrFYu9zMFPp8j71kGJ
	xgOS4I/lmIfw5w+ZM2VRPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yruhaa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF20S8g022550;
	Mon, 15 Dec 2025 04:49:33 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkhgnep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz9dCWTJh9gB081BKgt1tdVgJtfgMXRRR70PRLhSkaRCnI8U5OfnZ/c9YHOqnlBhX3MtlGI9BjMl+OoqbpKVS1u/wjM3PVCFVbMVa5zztjsZ93ZhRSIcfC0P1f/cnWz5Sn+QbCeF2yg8WxIpmxPZPSwgu23w0bv8pnkqzcg5rfusmFrCFcjWokHWWAgrbsom4Z/crL+MeUZiNaCN+2e7/ysaP2IrgfPeO95HYEFFQWckgV+aNpqy6w8gQG67iBzrf5/ybQucbMtjq+KmrcPKZEP/e0YyYM/3Sjt6iXoqDJozhtiWoP+WHoQhDle4DRH71GksavgjRHS5LAN0SV3ixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=;
 b=pWJk59TjWCmFVPx/lULwW4MYFmbHyByAXZ3vKOeoFlP5bwV/z+MZ4HzWJbXc7O4NJHmYoGIE+JnIgLssY6ezn1CeM1ndKuUh3VnoiJjv7FagtRCrPvw55KsP6YQOBGqph0Q+5nUrwPelxsA5p0lv3SoIY1G9tvL6sgjsShrWV5+7lFdmEP/6M3efDb+f+CbyDTCv/tulwHeccBMfhaBE1x6eu8W62CSK7UxNqaE8YeTwjBj5r9NnKFeDk/myQMbrp7SYa8FNYLGOShzD5A8mQ6kWdUfMTraefGzChiIKHwkHhtBoNE39gSK6WFBvFZul0vuQ5pYsFHdmgyoFMfgyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=;
 b=qYsz1YYmSY6Wm6JbQ/qDyt1GmmjnU0n1PnM1V27nOFGmbCPxtN2y9VpymhfY6DopRJ+wYVNcW0dtc3VmrXwbhk7jwBGJsPmf0De42LOU3TYWyAJMfijMutKh+vAv6HYDru7qMIHYUmvn3M3D9T/6nz1LZ6bjZOmacDR26a2lmnc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:30 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v8 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Sun, 14 Dec 2025 20:49:12 -0800
Message-Id: <20251215044919.460086-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:303:b8::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 5942d0d9-26ad-4684-b3c2-08de3b955535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0SRNt4mHhlRHHxwhGU73FmXmyQjMYW90zgAfY4fzxYPwMMhRCH6v4t4zyAGA?=
 =?us-ascii?Q?X/CGAx7BdWZSbxI1M4d0bT3TK+nHlwh0b8xy24C0cHRyzKxj8K00BOAxCCQ3?=
 =?us-ascii?Q?/3BNt73ar+PfPVgXGGAl5+cZXPW8boyic7p5NnGL7lD1zEznvEXhlSz7O5OS?=
 =?us-ascii?Q?zKz2aJiNuDT+B4kFTKrf+8jcnHVq/GZa5vGs7sDmajG/qEXRuo0TGdFaGPAl?=
 =?us-ascii?Q?5TNhTyk4jgpnxJ5afYxXDFd7etFsWjZuCvogOBaEKr3lFMxfV2b+vzWg7P2k?=
 =?us-ascii?Q?POk0NY0fuaVFTwaFLok/MzL5HKZgMYpg7f8lK70ITgbdPu9Kfg6zmtluiMxh?=
 =?us-ascii?Q?C+GizTLNgbr30UDNmeA2B/jfrtD6DtEmAdMjT27e38kH6jSDiiech28XXGwv?=
 =?us-ascii?Q?ASFcuMpTp0YZkOp8A2IQSq/MYJueGK9f4vr8H4LjgMPDioVL5vtR9ibuVYLi?=
 =?us-ascii?Q?FK+KRtfDuBqYXKiyt8pjp8HOhI+OF150NqSTQPmCEV9doJO7C701BAejisNW?=
 =?us-ascii?Q?YYj/3XX07lY1kzU19cGNtOjx+PGp3RoEHQ8aLBsRFgqd/oIfGyhCn9JPIDrZ?=
 =?us-ascii?Q?14pK//KMkD84vzb6v2M/y2qyrbPkDASUZU3XiaFYg00NBrFjdfCa2/ZVaSd/?=
 =?us-ascii?Q?zRI+1DeGgzEmlzvDkTxH42pPzzdZCUPnPZKGJaQDToH+Nh0TQ4isPkgqciYW?=
 =?us-ascii?Q?J+AVooTE2zjQPssWeR6DpFiXlmqvouSKj39kEsfnKAb9TTJMtht3Xh/EtGjf?=
 =?us-ascii?Q?8xlr3hB6OaMD4zxkaYhcUA/1/cyIUj4dPoQEtKpes14JFpuPdpm/8hmMb+Zi?=
 =?us-ascii?Q?0Ql1nCCmB+qJjHiJqEJ1fvPDiDwot3lKxVfaAYItOVBHZpQ7WkweIX+a1kOE?=
 =?us-ascii?Q?P0dWGzi5nrye1GQMKVsxJu0ngwv7amnBhM6DdS9XYVX8dEcOqU98da9Lm4gl?=
 =?us-ascii?Q?9Nyg1IqnB93SlhKXYN6w8O/hGKK+tolDmkUytX1zMN2mPVCJEarWNw6z3Z8j?=
 =?us-ascii?Q?S3sPYQVrZwO1ADLOJQuu7VgWpEsHmvnv/ZyrLguQkEqIGhv/uT3A2vCuhcFs?=
 =?us-ascii?Q?pYyH+dsgSyZbWdYwFEz4OgXksioIDtllzPevF9rkhuzO7lXUfZf5Ttto4WOS?=
 =?us-ascii?Q?SXSshgX1yca81r2O3iXwQGPNz/NAfVw7BQK3htBnuVmLB/jW3Xhc1ptNFlRi?=
 =?us-ascii?Q?yj5wZtHMmdFAN1CGRFmQhnY7v8RTI+DJL5sftN/gBDNE7YT2yALxoOfvCFGZ?=
 =?us-ascii?Q?m+c0UJdqVDyUgMV7kN+RyHDxMwLVf3CLQX7NNI+nyGHgy4NmFarxdt1qut3/?=
 =?us-ascii?Q?4TQ6BCVhgmo4hprd1AM2WmW8IHPfCdoRQFhvc+Qvy002Kz8P2OzvpHVdUYNU?=
 =?us-ascii?Q?ZpE8TJznOiTmQSnHA5l4FnhQDnS1gdfAhEth3Qh10BEMKxtkpljrMEq1iNxb?=
 =?us-ascii?Q?abLtCywCOWlL3b8a/XLrSOV+VJgxc0+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZjxh0zTFz0w5AsSXs8ONBGwZ30p//Ad9vwmqy2BhLHpFz6P77RamTZmMR7f?=
 =?us-ascii?Q?ST+gttdlgLkdRH2XPWGA/uTEhl7VbeyVRnFc0LzF1ZW/9E4LXSyiZULAxM29?=
 =?us-ascii?Q?LCt9ml9z4/F/e8+tpKlf4gX30bS9llNyqJqaWwQLVSjX5QJcDop80Jy/iWdz?=
 =?us-ascii?Q?q1p7OnOfKpgK5PuE6+jmRGBiMlF5rHtjHkMb2XZDwRC45WSJoEOnPj6SJzGm?=
 =?us-ascii?Q?FutRhIaDKOtXQVdQA23ykXTv99CGE/kAkUsp+NzimLJMWRQbyi7PECc3Glbt?=
 =?us-ascii?Q?SJjPOBc+oS+baWKF788xvHTKKwsoYPHajq2lqfnsE1jBrLpm7bZdv823Pun0?=
 =?us-ascii?Q?L+w2kXRy1UfWq/MrlVWhkXYGP2lQJnIYn5YjqB25/QAsgqXK/bvFwLJ4gM+h?=
 =?us-ascii?Q?RknBBLHmN0AZgGVo2GHznbVrX3ReZ5dJvIteRuRxnZMDqO8s8rE6LDQL3akl?=
 =?us-ascii?Q?9Ko2HX2Aw9ItlHa82k4O67wE+PbIdxNfggEh6lnwuII6g4S1UjP3yL6GzLPB?=
 =?us-ascii?Q?OPCjdsYkBnZxHRc86W9mxB+9F6ubbCcYxOYUIPq0hMzt+hk3qDMEL6p3+oi7?=
 =?us-ascii?Q?5TWLYm5vPYxSxNWSDNoDDofA4Ckc5FoZVHI0oJTXs3jljH7aKtRaQfD3j6nT?=
 =?us-ascii?Q?nU40tLpK79q+EY+Mnmx2x+k/Z3cRnJRyWybZ0OQpWUzHov/AcPZIkBhcBpUV?=
 =?us-ascii?Q?K7De0OpHZNnqG4czcrRF1DZfBPqUB1AaIwLjsY8lRAwpevZ0o8u+k+3m/fde?=
 =?us-ascii?Q?uxBmO9ZtrEozT9aUIqsdAaykG92KKpmMU70BNuwwxE9gxtSZ4pfokntHsYtU?=
 =?us-ascii?Q?W7fWhppxOubDvsaQAzZID5c+XNBHP37nve505prikTaDrIXTKfY9O+M5cEAy?=
 =?us-ascii?Q?BebA/GVjpTOt/8+3hK3y00WWWox52//4O7LK3DRQvy748qsBRS5Q6HGGx/Bg?=
 =?us-ascii?Q?0tJGMVnlsr6S3eHYKwMcDZNgbzadDma+4gp5+MHmLvYqXhP2+T8mf8GmY+cJ?=
 =?us-ascii?Q?70rwiV6SOU+LoDQkSEC9n9IZ1k27M12hWAFhEbe+kW++YF9s2SggMneKy8dL?=
 =?us-ascii?Q?UQ6/5RpWgPELdly6TUXT5B4fLYCRwD2raiTufvPGervaBGhkTUQF7ClGR0Op?=
 =?us-ascii?Q?+ieWmS57Xa8ukmK+CuQyQcE8O2UB9qp4geIMm/iFhxOpzm3y1XnqzSjDYF41?=
 =?us-ascii?Q?OOEnTpss6sYcw5ABB3+V5XjzmdFH0nicnOIAANuhsrYR1cGubTb7EeaSVlQF?=
 =?us-ascii?Q?V0EAgAY7saq+xOeN0FhND8KLOsGJTNQyuAUivU9qpYn6mVSwKGgP3WP/ymOY?=
 =?us-ascii?Q?gjdNKuiq5YKVsYZL1jRixBEAi1M4TRlOoMxaGIvZ26cmxKaxeFSgS9hT+q7o?=
 =?us-ascii?Q?efbIrsMLDnDnDHy8tBtD/V0/DV2PlnU1ZQ98D8EYYS21nUTDPryzjMOhjXLJ?=
 =?us-ascii?Q?gKs+2dYJ5lRUnrt7TQV7aFdqhga0r9G8yaQ4pJtO4ntXCjagq4cjzH/m5obs?=
 =?us-ascii?Q?SIrKPYESpefCO7MATP6UqgROthE87iuy8kQZZK8/QweiX+n1pvERSQGUGNlH?=
 =?us-ascii?Q?LG5F0Q3zSVHBX1dPBv2n983MrzGujsrh0qJrjxEqHmzf/dLJ7mfCtOXu9Kff?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U1M1l2CzA0c+czpfrGXMHSLO7etPMsKzFhaMZgi4kgGmbhW/Kxr0le10a9HpxxuXNs8QmHvkYIiFUlnhuMLrtL0NwBChuKzcidbbTyUXk3ENAlLj7LmpGxHSmlAzF483sN2sTsJKalpsiDo7hW6n9KcNUYQZ+5wCup+9yxbspw+vHjkgnAnZc9O/oi3fnDxtInlsHcmJhuxIgCR/1KAzFfBiC0b1tAs76Rr47Y5eCzw7nxND1MRJ6yzyfyk7BUDUKkyBZYMw1YGT43SXJLt47xiGiGVaGOsaz8EqMaNAPvnliE6QWfSoom1bxFUWxhkQI2Dw7cZWfXxAT5CkCKBNJTU5emm0NHpmXAaRJwDZZCQjSHJ+0oJdj33ZXUiaE62Lp7AqFts6bcCpel8IhFWL88bjMMUm/Z9Tn6huBVG+szeK14lC5cuJFX/ysf03hHbCIJzCjZEsJgQuNnshqVcOQrWl/dFaf7kQ3hClkG7AA+fV/756dd52JASIF5CLzDNmssTw8KPPE7m3otLJMIAPkiV+NATlGWnFVocHEZ6x4EB6Uzh7jwmt/bCUeYZu/RDYJ1hH8r/4jt6MF+ke5FGpDjI6Mz38YkxMhLrIMpZwqXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5942d0d9-26ad-4684-b3c2-08de3b955535
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:30.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEEwNm2y8HjapvNoS5LlAnFlkHOSU4tdyKbgqs6JbSb5LkJFg1yVjwWjyOVDnhuQ68yZAcJqRm88t2U2u79NuZ8WpKdD0HzgITijaz55Vbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX34mEFa432qff
 NmsjMDztjIxsX4wgD7ZufJgaOCd/RVjwwU6ngaZwISL4xIx59N1t8erxdkx7pW6sUP5ZOBs9soq
 yhHhmcnWnqLTuNX8fupLq8NFeeCZLpV5AVkSnFrTEfWF1KJaqb0HZ9rHSQqe/bAigwCsTWThCDP
 oTws2e8M4XpgO+rJizyr0DHettj2l8tG0gkBeMnnz4Su7KilNdfyzx4SVMYlBPM6Z9iWbEnUbiV
 aczJ9IWTkCN2stwvD2HIM8T9pG+adaCThowoIJ+bMSNqywms6uMBhqTljV9UdIkgcb7qDNyAFIf
 Hvu35EGfjt4YiIOr5KAo8q2AGcOC+gDlfZ3BN0OHo6B+sbKW2ys6WIN6QNwMWuxhvFfD9WKeTwc
 lzquPxNEeW30phimNqdFBsVVBaPLyVZb4U+9v15tUT15+GB7BfU=
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=693f935d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13654
X-Proofpoint-GUID: TMFlC8qa36Xmc25xHjF7EJ30hoeqZHT-
X-Proofpoint-ORIG-GUID: TMFlC8qa36Xmc25xHjF7EJ30hoeqZHT-

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.31.1


