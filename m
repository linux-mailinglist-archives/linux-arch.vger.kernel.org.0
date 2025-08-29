Return-Path: <linux-arch+bounces-13322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E14B3B580
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539833ACD76
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF0299A94;
	Fri, 29 Aug 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j1HovHtC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HcARSC3c"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7B2874FF;
	Fri, 29 Aug 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454892; cv=fail; b=hf5XW1ACDc9lqsLRe9UG6lj4Ds8bHKGR6H9rmsnMhWz3vURerJDxCUWhzUej1h8Lh2QrfV0RPAxALdqcVUuYTgM8o2zpRjOE9e075CQDErLAZxdUhZTjQsjN8aXREJvpJDG0Fy+PTYwIoa97VDA82m+vpGt3Q9kGeTh9+qDGVsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454892; c=relaxed/simple;
	bh=AZFsDRG7V1xzJKjRtLVPX1ywxUwfxQfktEpHuvB5UyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9GHCJgknUlXZrWbfwprayFHZq9ZgtixOFrkAL9EjhOjdof2dqzDX5b+hQxMhu6G0GPemh0bpDBPP0HWbVkPtDsERt10fYc2fHPQCtakuB0zZzS5smhjzPFSCbWIBxxOq2RBZhYMR+/Q4ghpilt9x4MHTj0uh0C3d8n1E8pKvZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j1HovHtC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HcARSC3c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T846Bm009459;
	Fri, 29 Aug 2025 08:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SkGdnV6zlhpMPfG0NF5qY/tSveGG9dns4peuxFUGnJo=; b=
	j1HovHtCD3LgIdPybb8JRz+wQrqo9A69KBGPFbzFlChPoSxH+ywU0drX9YZdEwYE
	ffRHTAcKFq+MLrqkr1Lzhbyn82LG2eajCLCRXiJe8L3lMakUA2E8jrbGb/EhDJgE
	uiOHrnPatOi41+jRI+ZLGikiymLi4uF4Xl2SSk5ADHBunYfhnp67mm7pS55eR7jk
	caz1UmaHBXgRwclHMktyB9B65Wo5U4wHWvnD3dY+8bkk6I+NUX5OPSl+8aRuty5v
	EYNiDINfYbayuG3GhJ2D1gnGEhq9Hm4ctEMyLZDZP7AKcZUNAaxlaXcr530Ic/Vo
	cy01kG/cDLXCsZY0NlRhzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twgqjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T7rp6u012160;
	Fri, 29 Aug 2025 08:07:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cuham-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg5Nuw3OGzsHR7TySDTvLTS7SVA6CpUJ1msf0yDQkFoS8/X0cHaPYYVl6nQLSyXspPResmeY3Fu2Yv6OfIvfXgD7DhqqaMaOlAELefQENNJiPKSUUX8WJM8ZaWfEk1cOaxoeEZhE5g1gq17KWCzenWBPNk9yaXKNTtueWwt/38qbbEw0k5Hs+lVbY+l9WMb0/aqp5b6M10k7u5V0sGmScrgqatJOUPf6byJh+gr3ftD/G5LY4V11gXNDLDwX6JfUWznTphrAVzkQc/UgZ/nq2P0SBsNZ9ZFkRr/yqRPlmCgQOSZcXz3LtnXJQhEDtQyUrK1SSHBb1qSno046Ju6seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkGdnV6zlhpMPfG0NF5qY/tSveGG9dns4peuxFUGnJo=;
 b=Yj5OoR6G8p5SlgJKlsLHmXgODJe15Rf5OQWe5POOW5ICPSgU9lOoW0SJCQswRwb2aYa3jmnl9ZR0NK3fIsfVPHlMcsLq604Oc42yqb8YlEZKeN0kSEpUorkkpVNfKwK9+JT2qVcj8Dw3ClxiDRhww76FlRdCUz3SfFMl9HnqZ1Jw7CrrO1NKdKbCAGd61rvzq9tA3AuwF2U0BBpmFSCNHvbLElk3hDpVHbQGoLpLHU2dwDIUwr/ecgvxqDkaPAUq0cbjsGIir0BL+VCfntgcLQ/f6veFCRA99+JrDsM8j6qvAsA3zWIXOdThDH1ELYUY0QTzXVSaxaV0MXNj/aod1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkGdnV6zlhpMPfG0NF5qY/tSveGG9dns4peuxFUGnJo=;
 b=HcARSC3cGqf50zWlXZ9Oy1xpJmwrUoMMAHr2B4DPX7KifyLlsN/f0HPewfcmCPByUyh3uvcfOzmXVbDWGykcsibgEwSKOOlF/cL9VyAo/nPfrKNUX/AEZ1oLDz1aZpvm+ZXgq+x/NTp7Mi7FgLvoRowPWui7Z5mlUrI4QEoIzmg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:07:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 08:07:38 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 1/5] asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
Date: Fri, 29 Aug 2025 01:07:31 -0700
Message-Id: <20250829080735.3598416-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: ac53c087-88b9-4401-5c31-08dde6d31ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/3y3ERdJ0bUiDk9A4ukTCRO3SUih1STQTOKgJRnLSbXNtcCD0T+jBp7NDwgB?=
 =?us-ascii?Q?WNVbVSX/Ov/Gw3g7Im7agdzCu2YHh86mtg/r8CfwIfy2eFkwCiDGO1v6afZ6?=
 =?us-ascii?Q?5ru+YYg7sDykA0BYWBRiepSMvRYIUQ9P54kGGemFIdBMOz4Vo1JBcbquLSUb?=
 =?us-ascii?Q?YiANcdL1Y2DrqdbiTS4E8XvwOUra/uieaHphn642NlnPonHdNI4ttAv1G1zr?=
 =?us-ascii?Q?5tlV0rYPO8vSmez0wHskSggsuOhVg/hKGjPOC76s1/RLOHx90KLui9uMaw0v?=
 =?us-ascii?Q?th2ABxwOZTJnFJWL0tY8mXLwLL2jOD4MgKLIptCTMxMx38oJwRrszAsPakof?=
 =?us-ascii?Q?c0FCQ6SSsDBnn+FtvIEjcP+Z4wUpPHdUA7D1drnvDgPDE3XREdW5wH9C+Jm6?=
 =?us-ascii?Q?caB7IyamWjXwTXp0X+Kj/HlNgp/zP8mIvUnPEEB1/3bFk4DTk+CSdJ2XLfOe?=
 =?us-ascii?Q?5gHOQaYPcqpVO7Xd6+Gx/xYBkEt6dOQdTiiJbEElsH/vxB7055gtj33xVeVv?=
 =?us-ascii?Q?JPhPpqMFYFGbNvAnLokv9y8qjxVy9Mcweil1HCaH2prEaYT5/wE4uSWXAbtm?=
 =?us-ascii?Q?4/ijqQdLIGj754UHvykmSh3PqNrJDjBNxgQOl1cUrB7NIby+Y6m9qJAZ5PHL?=
 =?us-ascii?Q?w6NrLzLVqstm20dQi9iBkrMT4geQpv8j+x+1+xMY2noe5TzFyJBD9rdWRNxz?=
 =?us-ascii?Q?lMrQvjpPa8PyYJ8IUcvrKY+OUZhOnapLzyHz5+wMf2RfjPjNLe0b8qClH4tA?=
 =?us-ascii?Q?RVmrodz68tyZlP489b/NOryBdDCAA+/x0Ovvk9+6AD82CPQeNAPKtCwYns5m?=
 =?us-ascii?Q?L0IUX8JjiWL/KHMMHm7kJAbTJnLxFC8l4wmsK222aErBtRiudzNv8HvsMLy8?=
 =?us-ascii?Q?22CHYzDptiZL5lptGLdDcQmHBTH0RVk1q++tpiSM9+KSJ07PatXsl7+Kvyz+?=
 =?us-ascii?Q?1Gf0UV36eTkpk5uEewb2yfEc2d6fFPYuP87uI2bZk72RqqTbJCL1vnql7Wj2?=
 =?us-ascii?Q?tgZSx7J+0u1RT1t6h+Y+vIyf+ZwwKFGlBb1f92tptSerbV/xY2/7Twt+ng4Y?=
 =?us-ascii?Q?o/5oBDZur96tcR4bXd52tlPAHTgVb2RKxPVyG6CYbaLgxpGRe65A1bArAvFI?=
 =?us-ascii?Q?U9Gr1budk3gjiBEXMCov+hsH+pRhhYY6q8X0q6FNLZaZLhP1O9HzSWO8tkL0?=
 =?us-ascii?Q?qehNqXio1bSjPxLFaapD6GlAPzS9IOwD83v3IlGSSJEPHFfeUb1JxPC4y25I?=
 =?us-ascii?Q?ZJrSyVz1uOxgtotQgpOd+AwUU21P5mF8yCSeCE58KXtoXlqCic7MEMzQppDO?=
 =?us-ascii?Q?Zr0qqGIFhzBe/MtshW4tPkcVZ1jKcKilCXes6GEcQ9N7C6rD9KvT2oA4zc3G?=
 =?us-ascii?Q?mzeQ1Kt444Mggp55HgVmR7hJhuCohOJnz9izb4S4FDK6rQRAUri0KZVpmvHv?=
 =?us-ascii?Q?jDEz4fitWD4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zDh8a39vKrgFdzJzunv0eCQlGfz6nIWABdk+le5gyvOSa8G3nM0/g/FSytX2?=
 =?us-ascii?Q?vub5Mxxhn4xbvqTy1Mag3czO1GsRIZncC31X9HSTdOmEynFgoXoYPJbcEO40?=
 =?us-ascii?Q?iaEFfXl1bDVBX7Yn7gxRH2ysjdSu15ADxQShSTTKusSOfmYhffPNI9JRAQUD?=
 =?us-ascii?Q?XhfDHwtP3WBhnRA0xhSP2b5OTNVNq9JRYJSmi/9t6ovbjdP99LPk07cFhJHO?=
 =?us-ascii?Q?46UMiP1x42yPaKGbkBWdWkXxPIxGfO8+FZE7ks8yQ2xT/9Nfj8l42rVA+7a1?=
 =?us-ascii?Q?HB7sDn2kuQJmQEa3B8ZB5+GdDlkcPDqDWa6RxHMKouHtvDO6eANGUGslP+3Y?=
 =?us-ascii?Q?TYykid+WZF4N0rgCWKNxam9oeKexLPb61+v3+PR/w/k2bloIoa7o1f9pCB2B?=
 =?us-ascii?Q?FW+TIabfdVJCsxjW+fTYcNbd6OsK6NAsAD74hzU1T+huNWmPoLlQZuNgBmSE?=
 =?us-ascii?Q?2XY4/SpALBDjw2Z8QCMQyvDzjneaoNXuqBH1z8+4QcD6ta5vIxgLmkayYuMj?=
 =?us-ascii?Q?cXYY1cg151ImACkF//kLp6iLvzfYwfpd4gw8ftZHfhL4PBOToqX7Yd/9AW0A?=
 =?us-ascii?Q?LWroZO2uzy4bRdRqymJ8DpNgDCAEAcVU6wJltP4VIUhU8vfECHibj/Xfqv54?=
 =?us-ascii?Q?4bF9usEGvPnabotQ8y3KjJr0EsTZa8CmhqQOqYlMb77FaFe15Ftl2ZYE0qJ4?=
 =?us-ascii?Q?M5DZreXQT8OnAQ2xvOY4b6wF47QijpGmKnkp3BWUG1866IuQiU6JMdgTOB88?=
 =?us-ascii?Q?o4i0VWG3pB2mmL1fv3xCaYGhr9JQAE126wg/MV4ObsRqC+1Y/Fm3XCWl7xKe?=
 =?us-ascii?Q?UIotqA8yrg0lSLaaEY3oumYYlTVFFJwZELCwVuDtHtGVwlL+ucLJyIt56ezE?=
 =?us-ascii?Q?tsOo/HMgVF2Bu3sMUpEbrAFcZWjfNSaKaruk5D+xwKbdI5O+U72LyPA7a2aW?=
 =?us-ascii?Q?GlMMpcw/+Ux+i2n0SulFctnyQWgZNem1L9cz3p9vKY6Df520VbrbFXStK9Gb?=
 =?us-ascii?Q?GtT1BQ+wY0yhEZH+JsWXCuyBAc9PM4yGMLB4n0GUhTSGqOb7JHyMEBsahxxr?=
 =?us-ascii?Q?TOFVx92I0wfCUTiny8G00nLnf0H4OkS6HWckTIcVhAFDY3WI1JmbdFZe7yUh?=
 =?us-ascii?Q?w1c//mWOmh0n2iBjdpWWCJMlO3URnOZJQ9TBeK8u/W+WxHGIt4l6bnK+iST+?=
 =?us-ascii?Q?30qEfRCntR2ymvY4amFMrCTlQPMNcRHs85LjbKMR6BG06d3oWtgZO3RorJcH?=
 =?us-ascii?Q?rgv4rMXkCpEIpeaeq1qoHF2sOeCq6uzM7MmFpWjGCFd+ReQS5sXTJs7lUdXm?=
 =?us-ascii?Q?if4ZSyB+sLU9JzoB5lGRujtM8IsvmFOSuZQWtxVeA0zU8YSXzNZXXraaHrmz?=
 =?us-ascii?Q?0o08x836cBEb9soseli9/jN/FJI4qMTzaJi5uYYjGK97om8StuFg20dXMLij?=
 =?us-ascii?Q?CpqWuWe6+M1kE9XOu6LRz6J1UDIPj/IlHjg1Zc0/kiRZxy123HnTP/+xF7yM?=
 =?us-ascii?Q?SI+tZvD6un3wJjm6MAT3N/s895ga8iuJGnnAtLmKj048I4mRGzZrbbFFA40c?=
 =?us-ascii?Q?D2xfYll5+qwCoxe4mFpqTtnaiAJMHq4N6AOqEKZLfNflgFuXKR6v4a+xPf7S?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q75Ok7V5n7GFysIV36+IN3SB9WgNSa143CPsY0jMyvd0Q3/pY5XPwWUNiBMLqIxE5zOVdLAEhT3j/e3ZyXxKkWW7z8AQhFa5lf10yXRZldxOTZsPlTUbDOz5JftIXDSt0D+wwjuuVNp1lcubb+fArjkDtsOIV5f15wGqs/ZEDB/5zforwE6XUloro0vTL6SRl513HHHudKfdaUrQYhhv9tRA5RXaqDp/MucHjfGO9W64+L9ETcd0CIZuwTnbhvqHjv9uET1KTld3Kc9ZRR//ZSSMTa1yyJHOGLbDApfdrxHurFT30zVK57q/J9GJKjPFZwW2xXK5iD5azNTHhvuNtA9YjtQYSYjFdByCXLl1Uk4gpK8yhd3wr7o3HKGHgzVpof6HU+9u9t6pB0HOcx7gXjQclRRq10PgQ3Qr9pohM9zMjBNGYz6m6O7sbbOJod+kFJbVetWOUQ3LazFBw7cYp1DOKpKzUVG55ERYDrEfk4M7OXZiHwLnYkT9PeZCHQhJi2SmChQJKS6SmIi0KT6uTnqzp/ECqRAR+A+3XBA3TMkvCJgtdmR0UIKRwjHhA5Gn0nwpIoP/T94ZK0o7AGIFz1Mx2sErFXpvrr6BItHfJw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac53c087-88b9-4401-5c31-08dde6d31ea6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:07:38.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ29ggwHTnjKBdCHqgsvsvyrG5tik7oKvq0G7X1hlsV3C9LqSbTk5pH1IwjVWAGerHjyUbDY30Avy4hVO2i65BBeGB4Ah2Ud7pd3dgu8Oos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290066
X-Proofpoint-ORIG-GUID: gRIDYCJCCzMxUuBRXPYrpaXSBA_-L0Re
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfXw/2Dvz0Wicuu
 1BezwNjDzgtE/j7FI1/2OgemTnRfy1j1Hz9CrhWY+213TedH7BDftjkyyu7vowVgPpi/RE0WnJU
 DVMxtscfQ3DJSx5C1bJ+NVXABiGC19PO7KxOMalTZ1mHjhODitOYNoqWZw+6cgQSzRabgdb7YbG
 8RVfDiNYjm8hd/i7fxWWiCtdYgLNB3Y4zbicQ0VQp3eSvoUWLWo3tz4PbWOGWgG+Pxfo77TjKYO
 BvRE98pyJarDF2tHf672WK9+U54/wSNTPyioWJ4ui62ueMjTQq4FFffChtvB7/yuTGSb2FiAo4B
 MPDuCD93oMZf950MSMo2PjnFaMPXlSNlGT4g269mAB6SXC1/a2iV7kDO7GYa9Y6cj1GexDOUKQQ
 qbY9l0TXa8XavPhJPhloGmxEtU0KCg==
X-Proofpoint-GUID: gRIDYCJCCzMxUuBRXPYrpaXSBA_-L0Re
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b15fcf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=5P5m-dSjHkuG9PJidxEA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069

Add smp_cond_load_relaxed_timewait(), which extends
smp_cond_load_relaxed() to allow waiting for a finite duration.

The additional parameter allows for the timeout check.

The waiting is done via the usual cpu_relax() spin-wait around the
condition variable with periodic evaluation of the time-check.

The number of times we spin is defined by SMP_TIMEWAIT_SPIN_COUNT
(chosen to be 200 by default) which, assuming each cpu_relax()
iteration takes around 20-30 cycles (measured on a variety of x86
platforms), amounts to around 4000-6000 cycles.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..c87d6fd8746f 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,41 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEWAIT_SPIN_COUNT
+#define SMP_TIMEWAIT_SPIN_COUNT		200
+#endif
+
+/**
+ * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_check_expr: expression to decide when to bail out
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#ifndef smp_cond_load_relaxed_timewait
+#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_check_expr)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_COUNT;			\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (++__n < __spin)					\
+			continue;					\
+		if (time_check_expr)					\
+			break;						\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1


