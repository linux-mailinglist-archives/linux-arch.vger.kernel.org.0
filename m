Return-Path: <linux-arch+bounces-12522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDBBAEE951
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442023A7B2C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8742246781;
	Mon, 30 Jun 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Il7fqQgC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HLBOruJW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318D1EB5B;
	Mon, 30 Jun 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317594; cv=fail; b=N3Yl8zW3WnCLzkP2jS0iY0I4HqSSt72Mq96Ouxsi6DYGgAcbe4CsEpzgGpOq2/i+RnNNAeaq+U2hFjHZnFtq85JUGta92sdMyLKchDNpZh2Byd6cMzoMyfXiB1sdxMgB71cbb728Btn4iWhFLIeXRmYxXKqG6FFjkQ4sPT8Fx3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317594; c=relaxed/simple;
	bh=ZyxXibjQDSMafHck9h3fb/Ib9W7f+O5LC9nwkKJgsrQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=pdI8uLpti8jZ2W3NhEjErsRNT/K50TCKU26BsKzORRVovcAtCt0XeHxc8rFOPzRON2d862usovLA2IyuqneRFGkeMGVp2eNIo8YYBn+uS4NQW6rcbXXFy53tnDLHtDBDIlBcE7U10Zn/yoGv7p6cUnbYC+SUNu4a1sfHTya3X6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Il7fqQgC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HLBOruJW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UIBgF1004659;
	Mon, 30 Jun 2025 21:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jF2XJJ7QV59/oYC2iX
	J2RoQOCqon/YFJvrws8F8VLig=; b=Il7fqQgCqRMKyd2avw/mzM/inEgtQhu8dG
	4UwvqZ2ccqPnSe6LeSfQ5ZvdWKGXTrzlRFA/2AH4VFO54n8CNOYntCiK91hFQ9M/
	tlOETfDZwTwItWkVIaN3aOrZGVwAp8eQprsp1iMJJejsyssOxDNIDmd1bUFfGQD9
	oe/wMOPVJJKURSs4r0kc2Gnah32GnRzuVogm/cZR90PzEAC8mfTF2+xoNsBiYuIA
	iHn+k5L0exPMPcYMWb38pGXYTdf+yYPmVSdokX1LBKut8epxQR0NjxNmCxs4wBcg
	uC8Bq2tc9EE9u8zxEy8OEZ+OkHico3g2QW8VeA/X9x2OufO2c8vw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7tq22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 21:05:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UKRXVh005828;
	Mon, 30 Jun 2025 21:05:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ug4mbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 21:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRK0Ecr6Y+xLZb7Jb0gMVVbiIyRTupeCJ97JlekC0ec2ueUr7S321LERR8ead6aYh6eCLPBO+8gUKEOJa7npBISu7sc/uxmqWluNSuk/t4Jbn4LWvfMOA16y11A7pnJUFdMDDokusObrEf1NFUp/9G51Xc4ZPUK9Vf8hub8QAujhqHvJv8SbcZj21vB/il6I1p78RYYZoMU9+/sHYv54NdxxtActyGSz7PxpDTxIuoo7PxWTp/3kgD79qvgqzadSmuCHSBozG6PJkLy9o2bgeHE1p/S2OlVbVIrhzly1I6xHECrNEX5UF80nlCGw5uHYN2qKk/iPHJOlOt7NSLBFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF2XJJ7QV59/oYC2iXJ2RoQOCqon/YFJvrws8F8VLig=;
 b=aUHbwBqrOsEK/r929tiOuTLkCOO/jjZCjKp1RKx3HDLY1Ff6F8kF8z0tAWuBQ+JwasG7CyOqXk++C748F5WH1w+q2NZQMIQD5ylpYV6Wlc395cWQ6+Nl5u8H1OfUzORdv23UJC2S2BLLTsTs1qqvW6rcZdc6V7oqNTI7xRF7dxPuVhAZj3wtLrK7LQ4MkjsrLOrgCOjJ4xlWRMfvb/2bJJx7zSjEbsKn6dvGHLpN2r5EBQVG7ffNUzg0ZFxrNbFz7pEZxvkfHzxpxeG0kdzT0ScVdMynEX2kKCTb54WhQTd+46dF4+YqnoYwCvm1Z5hx/mOPG7Mgct/TghezL5VORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF2XJJ7QV59/oYC2iXJ2RoQOCqon/YFJvrws8F8VLig=;
 b=HLBOruJWKV1klfQcpi3Gu+BK4g+7M4kGtnq13MZF4ZT80b+U1XDkrEti8Gz1rkiqJhWyVFNySG7Zy0VtNWo9scoD1U+V49Vi45p45QQPxV6InbR7WgZVwAB9GayM4ixhp1GgIrO+DFWov6hy5ky6xcFhUbJqTCY/DWpJ9aBgdMk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 21:05:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 21:05:54 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-6-ankur.a.arora@oracle.com>
 <e2e8788d-86b4-092a-37f5-286b776cc061@gentwo.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v3 5/5] arm64: barrier: Handle waiting in
 smp_cond_load_relaxed_timewait()
In-reply-to: <e2e8788d-86b4-092a-37f5-286b776cc061@gentwo.org>
Date: Mon, 30 Jun 2025 14:05:53 -0700
Message-ID: <87h5zxrlce.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: da0de146-a177-4b9f-2511-08ddb819e717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qxv44U+SyfdZ8O+Xmv9N2UBwPuFbeHbJcElMNAGhSxf9DkeQLcbhv4L7krbL?=
 =?us-ascii?Q?H2moWbJLRj+BFUJWl/iRBVxQ/DxPBWTyD43ccsFrgjUfVSaFgZ9fSGK7IN/a?=
 =?us-ascii?Q?6vziGDVtOrew27HwViQyjvLZPsgQLsFJWUfnUG+ymMbIGhjTKOG+1bg41MSM?=
 =?us-ascii?Q?NEOZq2PJHzTTluJmaiLRr85yqrpXljK+1TD6SygFd6CoVGj85vaqAno7jYJ2?=
 =?us-ascii?Q?unoVNug+hyRPoILsCCVumDN4aaa8bZyDHRCWAM3l9aduxv56lxhnr9YFbd53?=
 =?us-ascii?Q?c/yFwkDGeoNT+s16Jm6KMtIhh+bj6VTLyWZ9dEmibwLMXjkZXuf4jB/0uKy8?=
 =?us-ascii?Q?ac9vHKktblXne/6V0HwhbPpkIp24KZXwjXGvPBOvICJ/gfAvv4ehIAHvu6u0?=
 =?us-ascii?Q?i7R4gLZPCOFYMgYn1m1tmDKbO0QbFd5dlMralEZH2AkaqGJJqz4at928ksaG?=
 =?us-ascii?Q?sZElEgHPb8b2h9z1hNsbD1M/yxA1jHZE0Nm/uEPhK42WdQZwRMQjLKVMIWKV?=
 =?us-ascii?Q?TE6p66m4voFIhDBfZIQCTmyINlJjrz1j7rxhQyANlXAYqVn46FLKtoTFUbH/?=
 =?us-ascii?Q?FH+xWoWQflDobrYEIdZ7Bif9cPhepPhtiZZhXN9TxyEIwTbKoEUk8qXXjMy7?=
 =?us-ascii?Q?m+dPbzTRQ7MPu+2G5UDMyXsy8dhe/slh8BVhMoPV+wgqAi/tZixAI+wAmXHy?=
 =?us-ascii?Q?6lsxU3JRCX7rl/p1DYyszJHZofzuCLHpEyobYOq9K7pelW5c8kIw//AdS1GJ?=
 =?us-ascii?Q?jNmEQQKmsNVe2qFf1mbZhrnqS41rMPtsw9RE9/kYtoWjOXnbnNh7ixIrsR8X?=
 =?us-ascii?Q?/kYV9ptNVE4CGA1dFAm59BGRWNyNg2CrSWvPr/eF9Awc3L6qQU22IcrihinV?=
 =?us-ascii?Q?j8j9kTiO3HnROBV1FWU6G0VIOcaWFqwvYiGruHAfd+jaTlzu/eDSCRTOAuk8?=
 =?us-ascii?Q?nQvBMHxuVhSM23zZ9Ziot2Yj16z48cnhuNj38zgirKegMcEOfv1PruywAFLR?=
 =?us-ascii?Q?+5YeItXeilGGJIBFl4IyvD/3q53Y3kTnQv+gkSCiOmi46szewewUCMtEk/oz?=
 =?us-ascii?Q?mmNRjYSZ3Dy4Mx2VoJ1QUeR1Jn8jLhSmLJ6KsIXQ9mYle1UACwx2N4PethN8?=
 =?us-ascii?Q?0mrTUmJV/A/mOqEJm7D2L0LyStQkBjr6vpqHqNY02UDgZnQGtVAroSEAsiQt?=
 =?us-ascii?Q?C9bK9CRTRQy7eqQ31V03FJ9ySY3B2VjZAGIVXba8wipG4nzw/E6cuS3Qxh2S?=
 =?us-ascii?Q?ZX4Lfdgw6awzo1XwPJ4Yz6qK/7zuwmKHcioc2zvzrC6AiOc2itiu1g/RtrF9?=
 =?us-ascii?Q?DgzZF3pEniKGQm/+sVqSqJ3njF5mWniaX+auvvZXDBvW98zgJQ4MguzLMJ8n?=
 =?us-ascii?Q?i0Z6fyvWKkU1B6jSShn2dl7PNHayT91HqemlOaKLJf1f93+rjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Py7oDZa+egQIS8VSWZ7+vEMaE6h9QT9fsB61b7+PiHVj3eSFxZdXqypNdnfd?=
 =?us-ascii?Q?10GMAny1AdVs6mqzrj8Tz/2AIh03OVj9utehrMenWqCLwCbJ/5E+EJ8zH4e5?=
 =?us-ascii?Q?ufhYdRHJbnI/x8UtEbvIMwsZKn6XTYfLShvkew5ARus5k3XedDWOsxHnlA30?=
 =?us-ascii?Q?+cyJdQyxYcTkZe4HcOJS9oGI5Scx696iiYctUbaXKTJ+THj9bR9+Os/183QZ?=
 =?us-ascii?Q?Zw34snDFPXqzOKy3xGEX4tbXvUnbYnx/TWyONOKNI+hyBKsXCIjsMNj0ym+f?=
 =?us-ascii?Q?XJoqcxr67idIwzgZit0Iyx8GqnT4RNfAh0VzaARZP+NQ5uoeEPhviiOf8bRK?=
 =?us-ascii?Q?DOe4WHXAy/IKGaOQ0muiSxMngSLeUTx3GI7hfRRKLiLTUXBEEqtMPb7MHG7y?=
 =?us-ascii?Q?pg+91V8fY0Q0+TS/Zt811IT53KJuOStBUc3akhRCYVQOSyNhbUY8/8JVL2em?=
 =?us-ascii?Q?of0G+HrKg2dgrLXmVuWxT5+bB+HkInVL/ExWOX82yLK3QeWzO5XaJAJ1zVMG?=
 =?us-ascii?Q?Gc07LoY1i2rpFG6e9YaNVpxKEeFt6JGIFdepsF1I/K29U37fy6KPhmpXfPLS?=
 =?us-ascii?Q?U0eEou9ljyGbrPPGFOxFaLrNYCn+VE0XA1HrimS072612+D2Z+s4ceAr57FG?=
 =?us-ascii?Q?VgeTiq/ZTje9PuX2LGtJhFRSIWDICQ9BTOgLmbYQT2zAH+3Ll9r1GIfNCDAo?=
 =?us-ascii?Q?Kl01hrRnwBQBhaNmjGjs4U0//LTvDzTUp1YsOJO6j6hcCaeyi7WCP6IXDn0y?=
 =?us-ascii?Q?5vXcOqjU0KLnsBvxBC5LEQH5sj/Ftoa5fRy3sHG/PGhFFsFIzP5DUsVxvd3J?=
 =?us-ascii?Q?bvDD1GNj3JK//wV0a9DsRUvQ+z5EuITWcqqrkgJ7Hdn5YUnku85xHHRL9T5a?=
 =?us-ascii?Q?RR/y+9VuDiC2SK2826yQAXzh3wVm3FfV6812ef7hDH3ouh083WvKTkcsp0AT?=
 =?us-ascii?Q?wm0H8o+rCHaEHDNvb/3dt1fAfDNJUQgWRvAovRRldWZoB/ad3C2t4/7OooYE?=
 =?us-ascii?Q?9m9HD8qZo4lDgnboGOQZGKly5hVzSTAWMLw1q4EYwA726B7OYCaoQ04JPZEb?=
 =?us-ascii?Q?SFYa/G2okJfg0i0+e+J34alC5fVsszkERIgMYObzK6K/3RklRMWlEVgDZWL+?=
 =?us-ascii?Q?GiaRMiTJd7Q4wFjW9rF/RPviMUZTMPUEllYsZTNDfDQFwi2cAxsyMlI1xDID?=
 =?us-ascii?Q?09FJFdeSjmROphtDJdfjrcjYDBjrJxwX8TXLhCUU1XHL0daY+WhE16LAysM7?=
 =?us-ascii?Q?IqEIe6sVFnD2lSpVzd1dE52R0+VsiqHnWp9metzeANOx0w9D8DWkn4GXiZxO?=
 =?us-ascii?Q?gKZ8JBzExfZPTAcqA0x4+zlHEndYvOLN6+AB6UFc3vLiC0tsHFQrZH/WJY/q?=
 =?us-ascii?Q?C53+Cw4JaREBKFW2qPDhDi9fd22oJ8DEJ0BBWzoQXqmB4asuccbDXZfe6giG?=
 =?us-ascii?Q?VazXKjbEOzJu/5VpMDI/BwCpZ7WSjfC3Igld3ZKgpta7hhz9mgUyDyaTdMo3?=
 =?us-ascii?Q?P3QA+6pLe3plFGZPcYJjy3M3ub8TDKcK8Cfxzmxc81I6fFlNddBYV4BC85v2?=
 =?us-ascii?Q?/lOpY9QzbMHD/x7TYXrJFyfT3MnRbXGgadTt9lkvyuFz3af8WyGDZjvIOZY6?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a8mzHAwoHb2sWL5jEm1UMgWo/KA48hZA+QdNYZbkYuDZlRKQxLh7gzNGtc4Go6EpNwyODqwc6ZlTgrOb6L6W1oNcRmwvtBWhCoOILLRlZ26YwmzsI6ywtrmf92K1EF8l9HqZGkcOCL+UJL3PeyAiwBLjD/0mt0xGjKrYqQalxBPS8vYn417fP/e7w6BJDH80kRIkYOVQMj0Y63BZEeo6jEEsEl1relntQ3wJYgDxaLuKvMSUny3hPfy5Ze5wRGcd+T7luluU+Rf6vfFs4Ct+d2pkucTKa9ZE3S/EbdfLHiYbyHUOcX+uIYBqWsqOVxaolXlxMYodzL6/P8o0q1CZp0RRnej1GR9JuwAhjBdciKCPXPLF6W1k1YOUPdGyT876LcUJfpw79LJbnRSMyhY7CgtyVi9Hjp/+6yJqSvMaHrPu99USWMCgyQYJOY16GSENUjUc4dUkbZyRSZDgb0W+JahDsvHV8agHWQPD0v68XRT1XCUv1nFCTruG0uCWqxTZRKcT6vFyGzu5tSNl9ICpKgysI/ch9Ct0vgvs4UxcA+bIdSdMACXvEwaQZ53i62aVRmmC5LU0brW+S4wJAGwsQ7zgRcCrzvzrHDMuUC0I9fI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0de146-a177-4b9f-2511-08ddb819e717
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 21:05:54.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTDIkE67Zj1nHSgsKFH7warzveBs5ZjA6zRqHnGTuwDbtdO2yj/kIm2+oWmIxwKnsUJ0BqWOCt5Tv66IBIU15E1KHpOUdLqJSbE/toY9wBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=864 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE3MiBTYWx0ZWRfX/gkp7TG88DZU 23Vz7rjXx+6Rsl8/CKlaZPk/yDN0tr4EpK4fl+ngeFHQfxihQBnnh9VjrKDzUb6ySdla6t8Uhln hZJ91ZCUFJb/bkTCuWwt3Z8T1E3Peqg7htI+45Ha2B1V1kdOfqkuy9L1bZP+gjWuX7exOQ6PtBT
 QgY6AVVxuxNGwoC4EGRRQIMuH23eJSPY3spcK5bYsKB+PyNNx1095HeVbuEA+92aumvxWC6Mm12 vLlYNCPgrun+G/9DPRw0MMG9zWQ3uaxjxBm+lEUDsYBnPvswrnPv4rIxjfq6qtNz81UYGguIBV/ uq8AFwVf8A+8ssrB5jhCOutr6hI05mxA97e3PVSjYrsykIq4mLAaBE+TYo5eV+hCrPLf5qZDWYu
 Ee2MqnYqZIVA4v+RnezAtk8Fy2pmtpid6IHGvWtNxzZTeMcvWCg8lH1RAe36AYuOiZzye0zp
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6862fc36 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=PuvxfXWCAAAA:8 a=xrmwW8_VouWvE-3chaQA:9 a=uAr15Ul7AJ1q7o2wzYQp:22 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: 8cibHSSUtW3Y4OHE1ulIs8VRlCFIE0ld
X-Proofpoint-GUID: 8cibHSSUtW3Y4OHE1ulIs8VRlCFIE0ld


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Thu, 26 Jun 2025, Ankur Arora wrote:
>
>> @@ -222,6 +223,53 @@ do {									\
>>  #define __smp_timewait_store(ptr, val)					\
>>  		__cmpwait_relaxed(ptr, val)
>>
>> +/*
>> + * Redefine ARCH_TIMER_EVT_STREAM_PERIOD_US locally to avoid include hell.
>> + */
>> +#define __ARCH_TIMER_EVT_STREAM_PERIOD_US 100UL
>> +extern bool arch_timer_evtstrm_available(void);
>> +
>> +static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
>> +				       u32 *spin, bool *wait, u64 slack);
>> +/*
>> + * To minimize time spent spinning, we want to allow a large overshoot.
>> + * So, choose a default slack value of the event-stream period.
>> + */
>> +#define SMP_TIMEWAIT_DEFAULT_US __ARCH_TIMER_EVT_STREAM_PERIOD_US
>> +
>> +static inline u64 ___smp_cond_timewait(u64 now, u64 prev, u64 end,
>> +				       u32 *spin, bool *wait, u64 slack)
>> +{
>> +	bool wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);
>> +	bool wfe, ev = arch_timer_evtstrm_available();
>
> An unitialized and initialized variable on the same line. Maybe separate
> that. Looks confusing and unusual to me.

Yeah, that makes sense. Will fix.

>> +	u64 evt_period = __ARCH_TIMER_EVT_STREAM_PERIOD_US;
>> +	u64 remaining = end - now;
>> +
>> +	if (now >= end)
>> +		return 0;
>> +	/*
>> +	 * Use WFE if there's enough slack to get an event-stream wakeup even
>> +	 * if we don't come out of the WFE due to natural causes.
>> +	 */
>> +	wfe = ev && ((remaining + slack) > evt_period);
>
> The line above does not matter for the wfet case and the calculation is
> ignored. We hope that in the future wfet will be the default case.

My assumption was that the compiler would only evaluate the evt_period
comparison if the wfet check evaluates false and it does need to check
if wfe is true or not.

But let me look at the generated code.

Thanks for the comments.

--
ankur

