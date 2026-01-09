Return-Path: <linux-arch+bounces-15719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3BD08199
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 10:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0F8302F92A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C17358D18;
	Fri,  9 Jan 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsnGE27r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bLNMT73b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA92FB632;
	Fri,  9 Jan 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949600; cv=fail; b=GPgHsTler2uzQqihe7r+rwI9CJYZx1pLBtsL8oY8IROCO3auXK9dFC5dajJzkZispnbQ1A42S3xkk2wER0giZgCupy4jcyDFyO/8aDhvElBET+75njWWGxOKXtC3SzrtUsOiMFPfurMGdPt3GcLOI9iG9iyDpr3n3lgUOoCwekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949600; c=relaxed/simple;
	bh=hy8ovSrhGSua6ifYygobEwpQHbOn+y480s/xJrSim5I=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=AoAhE6P/GtV94rX0uIy/eSCKpFHOKCtE9LTNJx5Wic7kkW+iTwymj5u0M87nfp67MXUh9/zwHMkctsbHCwVELW1j/7p8qdj+dOBcpoHhgf0QinHJEPjygEyxoU8OE9D7s0x0G+IbLy9PniowTLFaR9AQzsNgmbclBcGLI7ZOo5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fsnGE27r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bLNMT73b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6097Cp4x2533826;
	Fri, 9 Jan 2026 09:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PQy5z+RIcfMlHE333z
	a1g9b6+qQA5G4J6ydgVOS+8ts=; b=fsnGE27rqOcTrF3OpDx8syWlHzjCTXvncE
	noO8rL6okWuAEyFD9mePp3oIK2MZxz5Bu5IJPfOxhv861b2UQQk1I1gqe3oCJUvs
	Z1y6NZL6tzBGCOy92rPTjh6Ht9jeQ9/WwzJiMxc0+m3qyNLCuPZ2B5zq6r/D8/z9
	E5E7+TbZk3SrYbkLgaODyNLW6/IFNSrlHjqSY6wA3++xe9JHR4rn8aSZZhpwxz+J
	ZE6FW8Guxfhq0DChog+xNrI5cX1dSonRvjVsO7+WLJH/zG1Kt5S/nPROO2Ayb+wg
	xRE2C132uIGQeJN7AuNLoDCFIzDkdhwJt8yjUMbj2PVCW45/8y3w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjw3bg3gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 09:06:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6096l8W0015607;
	Fri, 9 Jan 2026 09:06:03 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjbw3x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 09:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0MmPkSKdDef/BmbcAjzbGSnef8SsSBhSq0oZsrI1icoBxxPgHm1Zkg/1eVxSipd0m07jogHxoT8uf3MZy+OtCaVWobyC8ISZeLLnSh8vpFu3GBIODljxsQmc44v6uKEJB4PNKKdo250wmxsqiTtqqjpljHgw2nk+8zHcSFHz+8ogr7dlO7Zifkngg6UIU+0wb1QXwLVjvSJVuGziJ++c4r6MYZ+lnGX9WDM72c5smVyIQ/cw65H8se4j1R5Cn6zD0EXgGGB0SkpRTDdURiM6+Pw3PLQFFDroOSoVCHA5caXsHfA2We8YYRYdTyrcUQxwL4cQQ22RLJPfm8Tsp7OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQy5z+RIcfMlHE333za1g9b6+qQA5G4J6ydgVOS+8ts=;
 b=OYSvw/cUr6uMlb+Rx9M25ZdaDmtd2hqQwjrQkY9/i+aCVzfAW6GhOGJXeI2iKDs3lWfqBEXSjtM6qRdu2AMyNRes7N7ohxWQrhez6U02r6CPOQLjWycCreisM9Q7BS8iRQrP63jpx5xqXws4D6AyNnmYV9cOQreiVrEe0DEuc1o5WEdcFWuWmf//y5YcJn1otVoahzPc36erEtA1lgvYlmrP6IUhwWoTBOd5lSrzLQ4bV7ueZkv4j+7IRjbFGKlFE4+IFNVcpqR1HyLgbs4s2UaWSEey8YF+dJP7CDD84bY28YAJn7+KRONM+pBEUreJ6p0rGO+fKYbaiKZCTEF1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQy5z+RIcfMlHE333za1g9b6+qQA5G4J6ydgVOS+8ts=;
 b=bLNMT73bgNPNVQJ3P1xyBYzc6FIgqMaXpw4IBKMXUf0D/4R4f67YjF6Naj9lJ6kpA6Pw0+7glUHB2EhK/NtqXdJONX/hwQ7wGbDGTE5I/h8c76lkG20tZmxCO/Yz/+x4vBMGa3hKx92Iu5VBcs+hOlDInnWHofKjO2pu0VUySjA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 09:05:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:05:58 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
 <aWAjMbSqN2g7v58Z@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in smp_cond_relaxed_timeout()
In-reply-to: <aWAjMbSqN2g7v58Z@willie-the-truck>
Date: Fri, 09 Jan 2026 01:05:57 -0800
Message-ID: <874iovp34a.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f560ce-d613-41b7-a5fb-08de4f5e4dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBkZ9LeNphKz6Mi9jDjnzUDWQKO/6yabT8OEj+22zDa7CQl8nUDjrWAwhgju?=
 =?us-ascii?Q?GR2lY3fIIce6IK2AUH3tzc8If6RdAgc9KRWz1Up4xPN6OYRpHQ89qCksB7cN?=
 =?us-ascii?Q?WO+O4vxgnROx9EbuaFPyRSGkPTasaNEaAjPC9jVSAMM9ycqdVqqvfD49JjIr?=
 =?us-ascii?Q?qDG3ds3ZsJFX7VUfB0bMMQHUrhcUrfDoh4wb2nJnO0PuaxbcJzw+5DETBSsg?=
 =?us-ascii?Q?ojJxv5pOC4pFSl0DBpf/eaheTqHuhLJv00qsUUUDQ0/yIxxlRHvWWC599s6/?=
 =?us-ascii?Q?B1G59YyNTO8GKMcsVkC8oefaaTntzdJMd0zetRekW//6R8bjwN+B0B2PFPei?=
 =?us-ascii?Q?6+6vylpilZxgsihhWqimoRK1oJ1r9m/R8OmrWbNCRim5HZgu+iYzLk0E9OxV?=
 =?us-ascii?Q?LF2xXN/5h7/Cml7WQXKt/5fqL1ebH4G1kC++Qkq04PuKkzNpQu1swMsqqYe0?=
 =?us-ascii?Q?mQoEm9ZeFu44J9gG8MI+lfRkI/J7W5sowPFmHpnl53x3JcTe1C7pZZ5G6l0W?=
 =?us-ascii?Q?F+XXEFpzkzACVFSHZMYH10Vy2AC9bj8CponIuIPpldkanljT0rZGXtVgdSi+?=
 =?us-ascii?Q?O+VWEqYnyqQevWq3ImMqhe4ZJuZsneGnN8wEU5TxoDGilUFh1D1lyeW/RKJg?=
 =?us-ascii?Q?SWWRRCw0uwtiTdI0Y2eqE8xGjS1NOsLsfMex8SSqHW5DYvnLJZdf2zFf9dDA?=
 =?us-ascii?Q?cz2JPAYvKoun1zS1S9308NOmEkCTJe3GbakIMYOOrMycRV0+16+qQUYkXvOU?=
 =?us-ascii?Q?GsnUjn3J90oahYoi8iNsWk1IQ9i65QcvjkVOB8OBrvrkfaMqQ1OJgZNy/qzq?=
 =?us-ascii?Q?XGrTWx2ltd5+FhTH9HcreU9F99QTDugds5j6+J+bVFAR/Ax8WFA1AQ6DrYb7?=
 =?us-ascii?Q?oQWsz+gqzfJTecQjyEQKGQv3ahms5IkSUhXwu/YDGHC4oQCBlWtv+5apmGtj?=
 =?us-ascii?Q?GYqtwUrzEcwmKSPlF+4fgvAVu5uLSoqnjDo9bqkH+LSs1ibld042L06mAYAI?=
 =?us-ascii?Q?A5VRplXXkPyuXquNq59aN9u1a8FF8TUvnZ6F4ExFguygXvxcE+ofhewyYj0Z?=
 =?us-ascii?Q?+CZhss3J2yOrwHMban+mD3/Ubt4oe6j2O8JjTYIjJa4CAdzkZyCAdf/eJlqd?=
 =?us-ascii?Q?QFgtG+X2tUT2u72DsaqklyWnb/1R8L8kfxvoebTV5WJQX8/i+XeVKO1R2hPz?=
 =?us-ascii?Q?3498JR26vwRWiTxE7l0TByn1KpLIA9+lVm/cUpi7g7ZkJOTI9mBKSXZScaRU?=
 =?us-ascii?Q?xaab/m2QR+JgxZ6lAU1qEbj82U4icIoDY1XcNWQDsJDJ8fwPQM4rYtqH3GKN?=
 =?us-ascii?Q?8qnUvWMglc0kkNLe2qBrt25cg4ehn01zk6BvsCj4tYc+bi3MwDeWHRnLCZr0?=
 =?us-ascii?Q?7RlYW1xpwZu0vbv+CGtlM2XhzJHHdlYlnoTRQ4z4nM7zsHxpywwztGJcXsOF?=
 =?us-ascii?Q?V3T3FeINYI+CjyzxID9YHQ/8KwHFE6Hz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wSf4zYJVPY6WnXc3GQpE74jZxG+8+GXqyqNCOwZ2J7Aw0fdEPc4sni7Z0qP?=
 =?us-ascii?Q?vgOtsnbWBWMJxJSXLpVMRdJjmfZNh4rSGy7tJXbnLiSaCS4DUn21llqQjGm4?=
 =?us-ascii?Q?gvyLU5GfZ9FTYpKrmpKEp+Nn+FQyKyAixnB760tYWSnvEiYy3taDxxmPTsQC?=
 =?us-ascii?Q?efsRRbhkjUiwsvKMY3wtNAZrN1Z30K3frSG0kdV4nLJ5PwFIQ+T6+kanWszy?=
 =?us-ascii?Q?J5iTuYvRLmLNPiUiBxkEjlmwJkH7L8aFKxPnCisrXsUIIEj66Den3IO4UOkM?=
 =?us-ascii?Q?DMRMvjvXANgOeNfkBvNv9mJTdj9RcGt4Hz8r6gT1Trl80kCqPaGDnYkS17uX?=
 =?us-ascii?Q?oDyx13gEtKBx1jWyDqzN+6iMtIJ2yce04x3l0YgrdgUHx0bt3Cy54o+lwJQy?=
 =?us-ascii?Q?M/L3q9qD11D43qYpNsBphKk4/639qp1WwEI+qOFRx3wzhiwci8YUueT1w6NM?=
 =?us-ascii?Q?MVEnpxzfl1ownimoGBRxQv0v/zUolZkGYxUu2/T9c6+6XAIV+eKyRE5Bl2pa?=
 =?us-ascii?Q?AW9vMKZObOR7jCqCVmaMcX8zeM0idIsQv6QBdPCb6aZQKVFAz8+cwZ7RCXAw?=
 =?us-ascii?Q?/Sakvov3hx/KiOrTMTCE2WjVvrYJqVX3FH0AzTf9emxn0Cnw5VjQVtZqsYFF?=
 =?us-ascii?Q?XIBQ2y7RuT6Mc/ik6s9s8FWIIMPvkPUsvVDWtdUnQJFqVUuZ0hxBiCG7Kuyd?=
 =?us-ascii?Q?D803M7GQIZhbd/YWlRUnlBjjmGsYsJrIRL/3gwcRUiQrDx4IzNY1NrJusQf6?=
 =?us-ascii?Q?pxNkJNrYUnJAEFBknD2YcnWj8cKMc7RqRKn2xR4BPXI6c/4Zrv7LbUaXsZTC?=
 =?us-ascii?Q?YKvjgNszmvvyuQb39uJqObrVTMR7hwgAFTkH+R3utKpJinmNx3TzB5kcD2qe?=
 =?us-ascii?Q?tWfVA1edwGuQraroIUJIvqRPgz5LcPjmZcn/o8Ssc+jZD/yjgV4VFW105LOL?=
 =?us-ascii?Q?x0dFN5qhaCgXvQKJpOWvEs6g5Q3bhNjvPOSnRFYiBEFgYBPYEvojRxXOgYAl?=
 =?us-ascii?Q?nAQP/lE4+Ix5oW8HTrXnWi/KJIE9T7P+WoZOJqYjFyt7Cpmbk3x7/quvHbjv?=
 =?us-ascii?Q?oWyAbhXZhSgj2ydwHyhMm+1sPajnxJ2QsC1GX82yiOTGKJ0z7Lnq5HC95yio?=
 =?us-ascii?Q?tQ2JJxoFv1wsMW0LrMSNx7TY3NPRdFy+lvVsVhmd8G52UkTFHykahBPZ8XbO?=
 =?us-ascii?Q?o+c25tS0ImkB6ssX1SdIxQYnz5AUGI4oyavpKo7gIzbUI8Sa/Jd9k00qMGCk?=
 =?us-ascii?Q?+0l/WeA+DFgaRxIc2uVkX4DQnjoYyX54egYIbGxm6qwRfgl+U6K3226TKq7o?=
 =?us-ascii?Q?j7FRCwTeTsV2F0Bkjgc/B4erlsLXU7bAAb7m8gtkGSEisR6/AbI+A2+QB1Lq?=
 =?us-ascii?Q?rMmzZwzuW/B+v4Jsufj3DnzfpvNDeUjSAMXWLr1N6adnmWmFR36wou2lwKVW?=
 =?us-ascii?Q?KWhKZFC6fxfA9YlFIyLm3zAdHcRY5OU+J6IuJrfJe1wL3uT8bbBM+M1C+KVW?=
 =?us-ascii?Q?A5dOX7HKZHxU+C3BOR7fzV3CPlbIyH7i7UK/DTfdLK2z4hLdJ81cMoCTzARh?=
 =?us-ascii?Q?IgGkneDgyBhZou9elHYowdVSpVMaJqzqAZjhZzdlObw/0zSLWlcEaNu5hmb4?=
 =?us-ascii?Q?6Ax6BqHpMiqgm+ys8O28q9mw/ucSpLoxA0GiuEvYnchwxarMMioYwwo2rxS7?=
 =?us-ascii?Q?Txl5C+8nMLtuHAjfG98eXHnB5HV5EAclGkjpcw1TS/2ZUBZj4DYewsHgQPmQ?=
 =?us-ascii?Q?uYP+sHZdViAppC5OXsOMVZfpcnxXpUQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	izd7hm5WRUZOU41D4vv4wX/QQzlcY5LEkPZNEgspHoNRO0n/T+3g3FfGjmaa2QjvJhYPijeteZVOsec2En3PuH1boT8lzzu8jWbfKxZQoQ8YKhdGQVFm4Ol1IKyazKb8p7g65g3DsBnuy4WCMTaFrt2l6ig3Glrx207w1qW+xhCMWeVFAuzwGqiZSRIT/zR03GajPootgZ5o1r/5bbE7YoIwH1dwOB9ZmxPU9y0Y4u478i/2eSzYAkylBxXw7197dFthDxUl5joU5yfcwx8gqCkvBTybJnqS84joOe5BYIEoyZJrZ0gMw90RSQzKt5c2y5z/NEQdBHLyXN0otsjDymzS4BDFTGXycu9GeM+hQYSH2m0eV08ZXrzzO+muj7Uky+uazkyIueyO4O198ZmV9sSn7fq3paWBbDJadIHO2kg/ec/3MuMo+TfEoeC0RVjag++Q+eMIknOCNwuZa5oH8e1gVuUjX00Ss/WC7UUS+sYrvKqq1oR+U/FYoauBG1PnnAhLRSoks3iKgg1Qe70vocjqSlRtmVNsRijsTQn6Kz+lzl4C6AX+Rfksn99CFwvlGNd5Tpu1Y/Q1bQtHn2Ted1Op34oLdwMOuWpR+JNCZUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f560ce-d613-41b7-a5fb-08de4f5e4dd0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:05:58.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otFtjFQxNmy/R1BkihKtr3YiGZ97TC0j6UnhaCGwg+Afyfw+Z4OOMH74ApxdARjgDf9vgZ6fBKIeI/KD/ybAjsS9s2rWc+eUm3cndYlScJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=950 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090064
X-Authority-Analysis: v=2.4 cv=KIJXzVFo c=1 sm=1 tr=0 ts=6960c4fc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=oAwlwhGTAOkQKmTHlAcA:9
X-Proofpoint-GUID: LPEtVpBKxWKVPEv0huXfbRdRRMPcR_XW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX+HeG1ZJfSJ9n
 dd+D8GyEZBHxC35N96D14ynhlzRqjwuXpAs944rUycrgYybh12UG+Q6KyIp3acwcUmjjpKaMeFU
 2vgmJcIEDsK+2dPSJbp74BRXiiA/MnaF9ENghWxRFP2u9Nfg1fDJJbHcAQ+jLBXyjgpR5eKconW
 FXFu3TWI4BeTA4Blve7+8+dChYhaZV34wWOwl393TbDziSBay/29unie4HBIoV7E8U1KhDTeXqa
 9ucyFMXxt7I2U6XzqLujGtSwCJTUnishsMT/a4fFlBpcqZq/2yiRpZN9Z/abYX7WBnpuiiJjU8m
 QluylM7X4Aw5aLBsNrwSol0Pw8y2gHvepXYmRDlaq9kvAilyhBOofml02pRUzfsjLhTT1dmpG+H
 8KDt7aqb/KCL3OlfIgV16l2PoBkwXIHoYJG0th7JysHaHmHILWgErqycIKLMpOlf2m7rNFRZiOb
 1OC+A6EeuZwfXb7gYAQ==
X-Proofpoint-ORIG-GUID: LPEtVpBKxWKVPEv0huXfbRdRRMPcR_XW


Will Deacon <will@kernel.org> writes:

> On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
>> +#define __CMPWAIT_CASE(w, sfx, sz)						\
>> +static inline void __cmpwait_case_##sz(volatile void *ptr,			\
>> +				       unsigned long val,			\
>> +				       s64 timeout_ns)				\
>> +{										\
>> +	unsigned long tmp;							\
>> +										\
>> +	if (!alternative_has_cap_unlikely(ARM64_HAS_WFXT) || timeout_ns <= 0) {	\
>> +		asm volatile(							\
>> +		"	sevl\n"							\
>> +		"	wfe\n"							\
>> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
>> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
>> +		"	cbnz	%" #w "[tmp], 1f\n"				\
>> +		"	wfe\n"							\
>> +		"1:"								\
>> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
>> +		: [val] "r" (val));						\
>> +	} else {								\
>> +		u64 ecycles = arch_timer_read_counter() +			\
>> +				NSECS_TO_CYCLES(timeout_ns);			\
>> +		asm volatile(							\
>> +		"	sevl\n"							\
>> +		"	wfe\n"							\
>> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
>> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
>> +		"	cbnz	%" #w "[tmp], 2f\n"				\
>> +		"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
>> +		"2:"								\
>> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
>> +		: [val] "r" (val), [ecycles] "r" (ecycles));			\
>> +	}									\
>
> Why not have a separate helper for the WFXT version and avoid the runtime
> check on timeout_ns?

My main reason for keeping them together was that a separate helper
needed duplication of a lot of the __CMPWAIT_CASE and __CMPWAIT_GEN
stuff.

Relooking at it, I think we could get by without duplicating the
__CMPWAIT_GEN (the WFE helper just needs to take an unused timeout_ns
paramter).

But, it seems overkill to get rid of the unnecessary check on timeout_ns
(which AFAICT should be well predicted) and the duplicate static branch.

--
ankur

