Return-Path: <linux-arch+bounces-14168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CEBE4B80
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C67C402417
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9013570CB;
	Thu, 16 Oct 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OOxtBDn3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DkXlfJoD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20593570AB;
	Thu, 16 Oct 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633850; cv=fail; b=bT4/wJBeBwpooYBRwSpTlVTfioNq3YcHrA+CCkafWUP9m1N2pHKWgcGto1yceA09QOw8moc+cMDMkI/91J8fK8KtOH4Dj+VAHW4qmXOgYXQUhU0uiiiBjZEso5taMJy2vC5JSlQ2wHE4EVcniXf/LBI5nejg8KybT06M5rLUaYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633850; c=relaxed/simple;
	bh=7sW8ivCtpqmOCCU0R9fEEa6cpAEWNAn8ftpZpcbwc7U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cypJwk+ugRLaZJyqj9iPnl0HCPxanpnzKFF0BK838iwUOixYsnlBBmZwOV6H09KOzEwM65eUDVXeg29BjPlcNMALGOG0u91Gl/WimWwHa0k198xZs2iPT6+ezRc/+mK3HosgtThe0iD1c3jz9dpcJCp8xvRLZgfsM0ZEwlTYeNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OOxtBDn3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DkXlfJoD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVL07005841;
	Thu, 16 Oct 2025 16:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=QKGgbCWOoe5txtha
	W5oB/1CGqBLDWP/8yNl+IMf2ED4=; b=OOxtBDn3V9hVuBn8p0PNfSuUevDa2fYt
	HZSDb+C1UBnKlgYanR5X0Xcltpn+RVzAT8yO0CVXWJg70ZkaiJkcoFbWO5/onyGg
	Dz3F7I5LdqDSdgjH2fcq5/yBWh1KE3p2GFKuNuWQXQLpKpi+R5UNM0fmygxwoRSL
	kwk1YmCrAiK7CJd4jXqyUvHHR3/XLALfbsvL+A7R+rJsLMySu4nreyBdCJlxnCZo
	FPcXEWz/Yu97xWJfAWocRFxh9wxw9mZQJd62GmdcfsSIsWuDHOnPXoLaSOCs0nUZ
	sUVwhYZzWlfgQ+kcfvRA9bj1SmBI4F46TsL/LE4kCeP6TJc1HaQqCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9c1eku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:56:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFIpYW002249;
	Thu, 16 Oct 2025 16:56:50 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdphxey5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0zVUVIxxEbt0OkQr/CPrspGYUsBgXLFB+O3AfXBhAQ2FRb2p8iTxcAzJuSmXOYaQuwzgFScEUCSGajqeyy9liQY8IJRp65xNVstOisVj6dMjukVOQ0oBkUE1I5ZfVkK7oJKSXB/uWQMU+jsPPk9xVlyQHHn/WEy+8NWC8nv/4IdSNJbkW+zUTSganmP6363XqHIdZnOEyrZhOLLY9DSfMk1m8w2xmCY/h2n6V9sLuJfBjl3do8kNEprhSIuIW2JhRsQNDWBtfQTUFdGeHeHPxEq9NgrxbkLP+MlgiZdYec9DMsi1fNcRZB4QiM1tLTxL9IejPtp3jjLOIxlNYryuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKGgbCWOoe5txthaW5oB/1CGqBLDWP/8yNl+IMf2ED4=;
 b=jHxGElX8bqMXLkH7YnRkNt0Asw+Q3mckZTWTJ0apjCIVndx9YZF6jBgBiVrKy/Fsc9fSQPH2glHYjU+EzI3ygtoZqJBcqEN76saYxzdYSzLu1qI8AYx0k6dXDICdiO42fED9njQZUH5QWBoTlpdHes+nyFUmCrt0qsERAWTJJi/PJ7uX5Q9AlfilO1DROWUTYpoVzM1kjbIzjMhVCt59cNvsHtzcKyKdK1YpcBZUmuI51hCLDnCs7pqTSSuj+Sj5PfE7l0EyKWvv7r4rRNemsndBkSyFeTqlWRCQWgqEx7v0b6/99GXZVGVsw7uCnmnDQSYdnjnyNlGos33xvNbQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKGgbCWOoe5txthaW5oB/1CGqBLDWP/8yNl+IMf2ED4=;
 b=DkXlfJoDe0suWKHpMur5Zk88FFvVNMJyQ0cqLIV2bL4ro4kIpUtPUu7TF5LqDFI4R1eNbZ6RDb19ysOBY2OhXaEDxxEESW4NginlF7CEAb4RzmuhCKHncjWMZXu5aNPytUfh2k+wR5v2jxrufVNDl1r+8kqXR4Oz9bYAlTG+Ouc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH8PR10MB6648.namprd10.prod.outlook.com (2603:10b6:510:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:56:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:56:47 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 0/7] barrier: Add smp_cond_load_*_timeout()
Date: Thu, 16 Oct 2025 09:56:39 -0700
Message-Id: <20251016165646.430267-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:303:b4::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH8PR10MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa4ec50-37b7-4159-06fc-08de0cd4fe69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFnJujdvyyMybedmuXpwUdjMFsi9Ka9DTjMXVIw13owXo8uB+AvoCI/Rve10?=
 =?us-ascii?Q?d3cAtFWzbB5Vopquw8lIU8Qjd8xGbr7aMCeZHuH17K7ALRdZaL0AwrPa4pJN?=
 =?us-ascii?Q?2U0yTDIew9Ac0Jcq48WuVUMbX8vxoLwJE7SJCw88rNOUkZNsZWwg5PdDhA3J?=
 =?us-ascii?Q?D/OaQh3dBIB+/jNU1k61FpqHyrw19j1CLEbMKOK+02ZHU7heRQMLAxPEKbMg?=
 =?us-ascii?Q?9AS431MKuwXs12IQ3R0zfGjSLZFfJguMRMysZJ7of53prODyktyTJ20yEAKu?=
 =?us-ascii?Q?Mu9mYUZnZmPq6WlyqFgQ3q8WWHOr0UFmFKE9vMq/dySKkmRE06GHe3OZme0U?=
 =?us-ascii?Q?R1pOkfsCfIHu/iJzsDk6xSwtgF8ITKYnLDX9a9OE3smZwbL4vOyVP9rYbZ5D?=
 =?us-ascii?Q?V/mrnRXsM9XZrHWQ7t0gEsQ1K19UB3EAqNl9dXlgdu4O6DP6HSx/3uVYoz/a?=
 =?us-ascii?Q?Hl6eTIbIi4r/yYfzlZbf1aYWCATLcijIsmLZb6iHhmPwvn5OUtWBzGCAEo4F?=
 =?us-ascii?Q?VxOE9NSCo3BqAOzmWukw0YdFd3iURH6p9IUoHg3kDQihMiqYUMfUODAlPvTr?=
 =?us-ascii?Q?3uObjRHvzd/OLTsjcoQrHXeffWOEgVZPTZ1zPep8wyU+tgiLoG7lCEXOr7tS?=
 =?us-ascii?Q?UPV3LGsceANBJC4Vacb1oCVI8uK/JjnrB3JyxG5rg3UvfEGgoEI4T5u52kI9?=
 =?us-ascii?Q?TJrcrQBamq51Sb6+m5nM/9P+OAT1lZBx4ypYA3gBzOVnLY3nL3oHXVmKCmGX?=
 =?us-ascii?Q?q8t3+NxIUxx+cL6H3OvMp4zDZeZS/Z7YZg1BDuiGw+tyBkLgZLbeyE5HKMoa?=
 =?us-ascii?Q?unYzCPGH4ie+Mpx71/5cO/EU9LJ4/Crtjod3f8Qm1u88tmZWqid9DdnQwDix?=
 =?us-ascii?Q?ohvDtTJfEBuQ0LDvqEYB0pX5MO4cIaGe3KaNc9gjgQqqGGw9B7kSRDlCCibS?=
 =?us-ascii?Q?KoS7KH1J4an9JX4ZxEbNRXoN82xNU1mk1covYh4V/VnyZSFUeK2cX2dABZzt?=
 =?us-ascii?Q?XoDagHJd5+UStSNK6JL5wJw9JNjeyP2Sw/ENiqVBvSY3TG1u+XhDeMNjD9y3?=
 =?us-ascii?Q?CZa8v5QVBx1tRZ+gglOFs2TPE9SiweuzZ3rugmsVGVkJHUwHbHxHSNZeGgXx?=
 =?us-ascii?Q?WLnnrGhhoAYPEzSUXSP7hy0s7YoRzUb3/QPMxLTHqfbleEonVmQlNDIfgjDt?=
 =?us-ascii?Q?PZClGfhFSGzAQlCG4qMHIjXaswwgBv2hBUf2zt91mm/lHIc5J4lUXvJQn7Ou?=
 =?us-ascii?Q?fU3TjP/tiPeX6Qu7kxuj/69hwiq00eGNcX0k/yS2M6gxuCE6F91TXrXizfcc?=
 =?us-ascii?Q?9NIXnq0ps4ISdmBBViikKcX6xcZpXWaOi8gEPk/d4qYLVidTZ+XWua6Mq3Yn?=
 =?us-ascii?Q?W+eAILpwPFEyLSVhh4UDD90rUfLW9i9UX383mK8Jr9tPzLRNf3lSG3CuWPK/?=
 =?us-ascii?Q?ZHBBuhmKLh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J2aZsZg7CHxfSjGyQA+z7gixW1i9A2VNwLmXkUB9H9sgA2JSVZbV318XQzHp?=
 =?us-ascii?Q?p9/h3xIlvehUHP+fEX9Iu/i2Dg4YTN2WXlrC33jVkQcoXGnkdJO+JtjEMV61?=
 =?us-ascii?Q?zAigOrlVtnL8BX0D2loCIAO1G6Ts9hbIPJuMRrZLtXTI2K3Eworfh1S9WGRr?=
 =?us-ascii?Q?RyE8XKt6Mw8wdVOt9ppuukoUzCY71to+6q53EwZF2tixhZQrCtXh4exzrNmF?=
 =?us-ascii?Q?YLANyfv/sRvqudfp6qn3PLE33DXYr+CdOIh6ZtXTcDaP8LZC6SWfiZdZnVav?=
 =?us-ascii?Q?L4HK8UMlWjwbSjRmzomIi2tkdzkzvEnOi0ObPhCN0QFAEpagQ2P97VKlzzNz?=
 =?us-ascii?Q?QybCezhi7fdX6oInhNIbmDeCUFT6fwjQ9MUDsI4MX9p1bihWbJ+MB9g+VjXp?=
 =?us-ascii?Q?c/uwvRWqxRRC9R4DDiu5MgOGLWKiHqmngILuzmbAaxT10FFmiCtRJv/7ivgh?=
 =?us-ascii?Q?lrEYs1TxD7lgSm4/Q1u4UHOr2D42kFuWY0QdKfR40IXwjek/yw/cs/x9RnI8?=
 =?us-ascii?Q?caHUNIMkwJvxsvvfvkzSB3LPTwsDY9mC61z3GeIAQm6UsSG+XxbBIvSSoybc?=
 =?us-ascii?Q?CtgrNco0Zg2pO3oFmacGUV8+kWrH2tgKjS19qMzPLr0gXAJfxA3zY6gUMU24?=
 =?us-ascii?Q?Ww3ZvNU/YPocENvMqltRzK6MFgagC6cPYC78bHIM2G8HvrArZAVrhcPiwdAj?=
 =?us-ascii?Q?E/E4nDpBWcNuf/sBUJG5bYuF7/+KUd7GHrNTgQoY89ggAdFWfa52py1vMrWS?=
 =?us-ascii?Q?hKC4uhKn2OA1A/etxysn7ZaEuvhxZ2a+g15/G/jjA6UxorK+Upym3sv7Q5mx?=
 =?us-ascii?Q?tUpqLuDFBbGoPrJZSS/wLyf5kJdoPxmKBFIE6QKSi0xm84xHm9Mm9zp+cLqF?=
 =?us-ascii?Q?NALYSf/pvcNgdA61cHNZWl+7vg1dK3wteTVpfLo3R91ej/2jPJFKC4+dQWuU?=
 =?us-ascii?Q?tpay65PhkbQ19GmwNtcaeDU6Afr79yupfRvVETYdG2VUe/j/00n05TPP8nDV?=
 =?us-ascii?Q?pHK636hkrtJF65UWPwoSpo1A9XyY/O+2ozF9wzN2sqhFI0lnfJKPkmpbiVR2?=
 =?us-ascii?Q?S45+UyZ9KPD97THsgiMJrrbyaePFb9Ty0PucAKvyTZyPi36PHOz3vPWTIIWU?=
 =?us-ascii?Q?f5CWorK4DGcOGMX913kFqhsYqi/phxvwp9K0/UVqEbC2A+or5w0AsW9eBGA5?=
 =?us-ascii?Q?bYJ/oUpHTLc52dgZudJ0EfqYw+hDkprJI0lp0t/OOz6laFNX8WwtxMRlgdhq?=
 =?us-ascii?Q?SgZpMSG04LlQmyyM7BkR6IIbEWZe7UkggbEP0iSdDEgf70ZfcjCnPnc1a3Lz?=
 =?us-ascii?Q?VpwmyhfjIPOHYgdrLcni5p+kXxZeYFUW4g0FDUbXb4x1hvh+hFe0vXhiDZGn?=
 =?us-ascii?Q?M4dDnC4nTKztRiLrEq2UzeyDUnysBlwl7fasyk++M+UZC7PJzNW4injuQHFw?=
 =?us-ascii?Q?mAI2pMUcF+rq4DY/vXUdVPxzxopCWTsFejVmPs2EClRv5+6Uyo3TiziD98p7?=
 =?us-ascii?Q?S0dFL6JkEtQ/NiLGi22ouJFdGdG/MB8Y7ZTiiUNWwsdqe+/Et3DKCz7oIxYB?=
 =?us-ascii?Q?kBPuxw88v96Qmdt645jM2OPzvp293NhJEz1h2UuACN1YO0eOejA8gM7lfbxD?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OzDXcF72Rd/KS/YZdd93QyUN0wPo/FAQ39qjueWs2Ihd+zV2Eby8vMm/pOSVkwFtP5fc2GpV5ZFdnGAj5IOFSlBjfDZBv1aT9TMiHHspk1zj808ryyHPdnqptjw9tffevtDsqObrL+QbcvrmslQUxk0tMNfdSNojl2L2+9Kjemf2GTcqh0AI9XAapUJIqtth3tCJGIPlCwPs6fFK1M/FFu04JXbwzrbe2Mg+SgzPUW3GGUkilbOwNOOmXETCYMD8TVGG1qz1NXnonZxWC+R1CdweMBYRoZR2dLk3nLUu0rk6HKnH4FkZfGntlleK2kUXqzzeRoMIKKoSvJuh3/XGNn/+dMn846QjGbZR/yC9ZD0tgw1KXOll4ztFGSoqmdCbBbnnesNv1cQ7pvUI2M1tB8bWpm6t1UUSQfxk6+3wcekv1QddKrbSRHlITq//DfzaC6fBWXWCDPPTsc1mtUb9kcfrqUY4d3nJmzieh7yOspBAKo5z9bubHXSbAjAOvj925YPGd7BOkZnpF52YGTI2Kck0nfq8lLsK5Uh+sZbV0dzvQ9V0Udp28wPNFgKAp3jqipOWW/4QDw9hnKleXJtxW86hRGcY34tHgZlVcO2ryso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4ec50-37b7-4159-06fc-08de0cd4fe69
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:56:47.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzNwZL6U3eFzybG8q255i/63d0ox0qiFCj/9kXSc6v0wbjVIa0LOCuHVcmVZ0fcsboGMsGk9NPJ29oRYl9QqHF+YG+HZGpGXA4EiybEiDe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510160122
X-Proofpoint-GUID: AecDsmtMu-BYA1W6Do5UAHCs-K3V7vS9
X-Proofpoint-ORIG-GUID: AecDsmtMu-BYA1W6Do5UAHCs-K3V7vS9
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68f123d3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=QXDmnoQuuVSgSO7tUmQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX5FIM3TeN1hJi
 uCJm9fkYyaxrcr0XcOIi+ZXd1WjzHSyMcAoBQb506utiD4lihNuM0+lhmb2zM91Fy0m6FJHRpm+
 fMJF//RMaoQjhY70dT/6NDUFiNyjIU/uSTbZUVyWUGTnOu6HepdQCH3ECMD5YPusqurBCj35UoI
 /I5+mXl28VeQXB60I7Fd1OzaM5KMvWaBvgQuvYOtg5rjnQqQGss6pEpoMgL/ErCrtMH53+yId7n
 ZZcGo2S0Jr+BCwB168f3XEhUPKOJ/dtyuyPtZG7VI+yJZPhinAAitoIuHxYJaQb7WbWyLMIU0kI
 XpWcP18TcMX8s2HgwYgbCOwTUvbxohVujxaDKMLctDgEt7w5NZNPnPvrtj+AsY10NYKomL7unyN
 uJMQadt75ddjpwKBTbklDMf4hSolkHVrX+5Kd21B2hPw51IYMAU=

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

As the name suggests, the new interfaces are meant for contexts where
you want to wait on a condition variable for a finite duration.  This is
easy enough to do with a loop around cpu_relax(). However, some
architectures (ex. arm64) also allow waiting on a cacheline. So, these
interfaces handle a mixture of spin/wait with a smp_cond_load() thrown
in.

The interfaces are:
   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)

The added parameter, time_check_expr, determines the bail out condition.

Also add the ancillary interfaces atomic_cond_read_*_timeout() and,
atomic64_cond_read_*_timeout(), both of which are wrappers around
smp_cond_load_*_timeout().

Update poll_idle() and resilient queued spinlocks to use these
interfaces.

Changelog:

  v5 [1]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64

  v4 [2]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [3]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [4]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in hindsight
      unnecessary constants.

  v1 [5]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [6]

Any comments appreciated!

Thanks!
Ankur

 [1] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/ 
 [2] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org

Ankur Arora (7):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: add atomic_cond_read_*_timeout()
  rqspinlock: use smp_cond_load_acquire_timeout()
  cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()

 arch/arm64/include/asm/barrier.h    | 13 +++++
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 drivers/cpuidle/poll_state.c        | 31 +++--------
 include/asm-generic/barrier.h       | 63 +++++++++++++++++++++
 include/linux/atomic.h              |  8 +++
 kernel/bpf/rqspinlock.c             | 29 ++++------
 6 files changed, 105 insertions(+), 124 deletions(-)

-- 
2.43.5


