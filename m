Return-Path: <linux-arch+bounces-13178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75108B29579
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 00:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58066175F82
	for <lists+linux-arch@lfdr.de>; Sun, 17 Aug 2025 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8E23184A;
	Sun, 17 Aug 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SOYlgtQY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uVmB/rbu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA961FBE87;
	Sun, 17 Aug 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755468912; cv=fail; b=TvvLC47cE9vqSoSV5SvtQ44VIHfS+tEkWBEUAkzxTESRc86jGLR8LzzUEZcT/QCwuAkWB/39Boa5ieJTR1cfYQs7G46YuaUg1OFlhWvPZ09Sk1gPNcjkAhyqonAWmiftiuyUth4cEIvUkMlwC3DhOAj1cyV9Wbh1DK9KJ+4PbwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755468912; c=relaxed/simple;
	bh=UtISSQD/FTLnnog/MH6+no323NyoCBsgTEbKe6ypFoQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=cxhWL2lfD22sc8t+k8UgvVpcdkYrWQXlO4jedEv7tQ1dy0qsEqQ+mYDmlHDgONCcad+vM/LRgDFP/b3gXXU1Fsr3T+xQkm5k80Uqe/F3XocsHejkPNqJl3i/VSOOoZfGzjjg9Tq6z/gJM4jgoIRBI06SyCEUrmQ13CFau6sk8oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SOYlgtQY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uVmB/rbu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H5PSa6000579;
	Sun, 17 Aug 2025 22:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vcS2l9ZELKCgC9Ikfi
	31fJ9fvKDFH/4UQxlHl/V/iuc=; b=SOYlgtQYbdFjVGLv8IfaL6yZH4LRMqfyhF
	0eoDSm2ka80oN3e8NxRiO5/7sMUCvBidE2dUxYzhgVJxN1fb+tfTGj2HOsQrTA5M
	woQZ1+jHep9zW6vdyzAkJrYpORjcpc4UtxObvRP4CDqcFa7ycr8u3awVXMB9fmpC
	aSstxbnZUyGKFIPKA+flIAjm5qkYcKRw9vmxZsr0V8UTNI86qTHbU/vEIR60iGzg
	BDd/MO/eRJAxp2WGUqyGEUQ1w9/ESRNJu0BEsICUaH05G97a3m9PoT6cA0OZd85g
	Pmd7oeHyb7HxXLhv2lEZSJwmywR/enC/FEMx1OFz+6XisGkJJ38A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jj1e1tcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 22:14:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57HJRvnS011699;
	Sun, 17 Aug 2025 22:14:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge8fa7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 22:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL5X1dQY7mBdHZAUy5/lQlIXfbBPW7hVeT6wx+BbDORBYOwJjEpQ/uyAHvmT1ltSzmg171tWT7sdDlzM4th1vGSMyXePLfDOaojARTHopqHIpZ3v0KCqCN7Qt0ljSFAPz3VbH8ib9+MjCG4zeanz6TI/yQ5GQz82Y0bHpebUK9rmNIt7SI0sNZL4Jw4zuJqpESU07nBg9muqN4wjOlC9F5zCW8o+GhDnHFqz/diCJGccNyxOnsXki3cj1sskZzZ6Ai/bIhQC74aSsMn8AUiq8SjnFMtyQEx1qPcGQLS1yJHYmjwAGQGA9DP++TVL1lfPmIZ0BK7SbXoZCC9myySp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcS2l9ZELKCgC9Ikfi31fJ9fvKDFH/4UQxlHl/V/iuc=;
 b=pbDNzEfe9TTXXHm0xukD3qs369A4JB6L10mgG2TMiJjATeMO4CTa9vYDPIONjFDwLrgbJsPfKdrTqnXlyDdOAJGq/p85UKJKSjBvRoHYhj8XJBZNBjqY4RIpggh8cdrEoGSAJVdMvXy/iAWxC7NrEVRQgbHlXSMBUVsTNkgpjIXqYuKRegaNwDsqngpLJNDO7VO4qsf5PO9YdHC0pc98rPDN9y9VozJpSKqg1nQ+MyBwz/VDfqBddagNEDWTPdMwvwTWEHEeksrU0gGQfXvmZx4rP4DzU/u73SCksMVr3vMUc/UtoWXkxb6o/XYStnxKGTIVREnTZFSbTs5sNSanLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcS2l9ZELKCgC9Ikfi31fJ9fvKDFH/4UQxlHl/V/iuc=;
 b=uVmB/rbuHdPzjtj3+KAxkEvR/+zwsdJ9ikkiaVO9aO0ThshElxR34OukCEUwWJBgfCCgsewrOyvElepUlUEuzsQdyPeEp46KmCWSQxu8DZFN3vdLmJj5nbfwH/XNed7qFhnsz5sDxQV0RmeLeAeMcdhMHR1SARPdyDGYvOUYmqU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7297.namprd10.prod.outlook.com (2603:10b6:8:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sun, 17 Aug
 2025 22:14:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9009.018; Sun, 17 Aug 2025
 22:14:31 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com> <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com> <87bjoi2wdf.fsf@oracle.com>
 <aJ3K4tQCztOXF6hO@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aJ3K4tQCztOXF6hO@arm.com>
Date: Sun, 17 Aug 2025 15:14:26 -0700
Message-ID: <87plctwq7x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:303:87::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: fde01bde-eef5-4dc2-6bd1-08dddddb6e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oj5PRvUheXfJCmJdjeuyITU8QeyRthY1FHTPH3SZiM81FkdzqNOB7tZa8bOx?=
 =?us-ascii?Q?S63QtcwcATj3leOIMgQ06HuGTqxLiMCFu/ZB8uOfIDLkO4rd+F6lSakl+ZOc?=
 =?us-ascii?Q?wpEFiwN4W5wHjHr8y2H3GQ54IDyUE9FD1aZjCDuF7lp8fJt4SsbFspPMRf1K?=
 =?us-ascii?Q?CAKCBGTK5jiWEaICrez7ljc5igxhmcftAQ85BAjXJt+6MXkBLkWafd/6P1RP?=
 =?us-ascii?Q?Boaq/u53R5bTDvygaAd5vypQEzpZUQj5N8g29GXHJY1ahVbcE+m3FweJoLZf?=
 =?us-ascii?Q?lgd5CpyRFODqUwjNiLlMg1WytfDndAZkxC/XnBR9pU1VlfAqrIOX9n31mPl8?=
 =?us-ascii?Q?+T6In6TydITSHflC4MfXaBBaGpOfObBD413bfTeQpVGTqGimTI5ICG+t0B1d?=
 =?us-ascii?Q?2BAkUBP9tI6yuVWBePaM2UQiGuEa+VJL1Kg6gpNnpTnAacDMUn+h0Vnm2cJM?=
 =?us-ascii?Q?jbA8F1XCOykCa99THxrcFdW9JVheOYl4GelPPQwrq6AwkfQpVGm4bi24TrIL?=
 =?us-ascii?Q?A8D3yCUZ4kmdh0PyZAQyecv99rIrkrDZ+qKwWgUqdQhntpYg/pqaeNewgqqL?=
 =?us-ascii?Q?Qf4JW/SvpkCTNsk+10bMkYP4cntPtapc3pHEmTgAUmD7LqYF0Y7BEtJlHTqs?=
 =?us-ascii?Q?zP9HJqI9xlWlXikCQGJbRIrWgItSaHBTUl7qbhdpB7jnAw/YdC/CvuM3Vf22?=
 =?us-ascii?Q?BfWWPSIwnDb8vFbXJzvUrvPYPQZQUro/vrquiTEQtRULNBfz4Wxe929yvcfl?=
 =?us-ascii?Q?zhla+ikdCRM6UCybS3MtH75eJmCaAsJoIn5h/fKKa7siI9rNb5k1iXD6FQ+k?=
 =?us-ascii?Q?5ZtOD+7TBnmv0lgZobkdx4e5TJ6YbptWum5zo5RFUQ+iZkMg7OqpTyHNHwQm?=
 =?us-ascii?Q?XGPmU1rhIgWbQhhPDCjCnqcGZsp+SgI7p+mKYe4+JQadqJVR43V/9+zPrKx9?=
 =?us-ascii?Q?DSnDTfSNx6LzpqFbKezzMzbYpTzpZpEXUk586s8lrlrt2/QwM+IKckPM0QJ8?=
 =?us-ascii?Q?VQ7fzBiCxN5j0kW7Ph54yvQjUHUBwNQywsJSeco3wPpj5DnT7fQDZzzw0jQ7?=
 =?us-ascii?Q?NdkSJ45Sem5Rm7gi2z15nrI2e30SsTpcokNSiBCYX/0HaeQvARn/awF8h/UP?=
 =?us-ascii?Q?eGjNDBmek9lZgkcVp7u4lz8xy7atzMRu1cgEyvUrdRA4wXBi0sJl4bGwL2tT?=
 =?us-ascii?Q?9Qf7D83mWgVu6+hR6u7xZmmBejue0s8Y4aJhh/bcynHEeaHlLIFV3B0qoztm?=
 =?us-ascii?Q?gm/eAVchfJkIO7lVZdaPYwpByhHpkUfReEtz32ylvs53f7tf8tWt9Mccc7Ch?=
 =?us-ascii?Q?hsdqI6DCO8GOHH+uzqf+r7M2xR6MFES7kRSUCn5OEsn8Q60PMMnhmwoSOVkT?=
 =?us-ascii?Q?Q88MzLX6q5JXVGlwX/NgwaZZO0E5DPT0byzN6B/A3izVLt1vIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d4AEkMoSrVbwMKuZJUu33pM8MBAVgUhIQnECce2iZgR3MFWcq14k7rbT+DJ9?=
 =?us-ascii?Q?xhqco0L1mXtPB0VJWONripwj9VVhotxkT2lVoiEBHutRbqpj+eCVsGleXevS?=
 =?us-ascii?Q?eMulP1OZWmXaeVkrLfr7qTvS27DbkjgmAMtcNH5FT7ZBPZv6mmWwhLGlCGxm?=
 =?us-ascii?Q?qAc9/6jDDy69LB+7Z5vQ7IyXk59nYLZ+VfM8xIwViMtOf75ccLeckSycIr+/?=
 =?us-ascii?Q?OU04vbvWROtW2kAXIt3B+1AUbwBVD4cmqJ1phDGAeoGzl5A2GmeYe/wOLEAp?=
 =?us-ascii?Q?AKzXWa/byDXn2UF9faPv9sAcNXEh8ruv+Y68VPZl/3GKYy72KAr0zFSJAFLF?=
 =?us-ascii?Q?uPpzBJ9sM74b0ygaufcoUh2naskImGPEZQ/6e0q8dSTOo4+AxJgyZAfmAJ4+?=
 =?us-ascii?Q?rc/sBAeU3gPLEE0eYR787ARAP4Rzj2EDJ0EBkRkNGsMgkCd1tLBYvsH7AEly?=
 =?us-ascii?Q?jrc9jsf4gd91v+Sx3u5Xc/qw3lHr4GukHSHTlfHg1niij8Yy+VwscnNcPIAG?=
 =?us-ascii?Q?JCdTy6R9H7T1qTgFYxJnjqP2zeQwoW0hH0LexFGe+8s8AbPA13yiaWxph1Y+?=
 =?us-ascii?Q?B3SFzlfG0t9xgOmC5Qof931ve2MdaLFxCnnD6kQ75ofK+EXuWYzFmv9lm0ds?=
 =?us-ascii?Q?3kDBOW6ucywD0SXRE5twM+kGuIJ5CMp7HVhmIb6m+RU1fsaOoYUd4NU9ed6z?=
 =?us-ascii?Q?FjP7HZYnhKIiK/beW+UG4rgeNoAWXCXZBTjEOeFElOxR0jw4nidWQVNZMKyl?=
 =?us-ascii?Q?04uIx3/lexBqojYWyfVU2wovpbgy3dB2euvBUrIupO7MlyuqBWtwwZC4uABq?=
 =?us-ascii?Q?bn1S+j8a8QmkTkjUPGcgJ98UymcjiR7ZLdeou1eJ9WaHrGap8TfCeqYJy3se?=
 =?us-ascii?Q?QXlWmw7x5apqOjxPjRcJQGt6CoL5MNngDLawLm3XDXyVXhltQfvW+jh2fbGD?=
 =?us-ascii?Q?aprDNTjUjGq4PGV8Ci9kR8aTwiL9zoqDtvOYcGgaRWmGTzKRaoJGFyUmxyEU?=
 =?us-ascii?Q?G9U2kz7MQuRXB+ssFKc7LyZihJFtKZUlPnzg2NVY/tzqlxSeDJ1+Kz6Dz2hH?=
 =?us-ascii?Q?vwOTrbLB55c+EnxzFAzIaUQ1GjI9oSV8tm03jpO+fqWv1q+9B3Z7fzl1oTRb?=
 =?us-ascii?Q?ADbxhLJAZQeO/rWk68fYjQWiPMQqOSK3ZLRAfWY/4M1xdU5BrGBz19mzWCvE?=
 =?us-ascii?Q?7/HNvXaBRx1R8lX81gkrD+kTfD+q+yfwFJM8Ia8IE7ahIk8jjTJ7fspdzOSu?=
 =?us-ascii?Q?mUSU4Ye2laioelP8NX2MOLrOydSu7BLuMH4JPx3x9ry0lNp/HB35elgWthLT?=
 =?us-ascii?Q?5mUoXTYdRUMQAD05nrl+O5MBQqKEdoQbH3JFFhrYzcpDYWRfzsxM+Kk3SBJj?=
 =?us-ascii?Q?1JdAAdvM4N8RnV+W4qa2HYeaTgJcg9Gn4ZzUOJwK95QQ7qMuXOfKKniHaZWD?=
 =?us-ascii?Q?LH2GLa4uJ+5sWetvzRJwwRUG9zqFmCxsgh0d8WWn5pCJaM/t1Bq9vJivV40s?=
 =?us-ascii?Q?I1y4y1Q+2oyDAWHedWVUKDTyAaryB2JjWDtm8u6Jcc2p8on5ugWhQ9/pkp+K?=
 =?us-ascii?Q?muutu31RTPbzbkCIURAHITCtSo+m0tJBYX+WzSJo10brxQGAFHji0CrjIXW5?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XQXAKUMqP/pFAFd4a/vzMxtAMswPIK0Crdqp4rkv+cWW1w9EUj0NMr7xwhU6moty3S8hjy81zwYHvDBiRDTVNpWliq5K5E7FA/ybnz7ggQv6aZennpATe61DQ4p8GaQDTxSsWe0nIqFMtcfHeFOC8OomDQBE51g07C6v0wK3a0Wdw1Lnd6PJ76mBts8pOgpfUN+zpBYj8zbJbiLO5mZP8fTwnB6qL03ZkHM6Gdjd/N+HCEquw6hGlFl7gqHRaLYXQzQimQ2tMqln+rOEejLp75wOGD7JDRkLOsWXMabgD2GU4RUuVjjzGhhvCug2Err8vZBwhBwpWNh1eo1KqQFP3T9KIlpl6KPYygLteVmnHnt/uWrUn5bjRpImtcTObaZqreJF4L8aP6fLFr9uQonL28ErEoKIQfrh0TLHX1Te6Qwa9YGLbR7KXveHlh350SNfY83e215Q/2Q4nGD2ymdzInzJlsn1SQODvSB8fJLDpqBC4fs5VUgCsWBToBv1zTb99C8AU9ZrDw7q/wHe/RhQZqmDMPoSm7xI9mWI2hd7G+HnWAxQnCXJdpinfEMbizXCzSlo7e+S6vaWu3vKvLsWSh5OGS9l3Gbmg6HSfW5FlEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde01bde-eef5-4dc2-6bd1-08dddddb6e81
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 22:14:31.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTceipUuqoOQyl6CQRg//yeTXNmct/M2TjLOOknNCiEha484oG1KjlQooMND3pC5JTIld456ds9BMqsKKw4p55csb6cVZxe1jVO8yKvdYVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_09,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508170231
X-Proofpoint-GUID: nx6xLz4B6ryF8TukPodsM_C5eqXcXmFx
X-Authority-Analysis: v=2.4 cv=dN2mmPZb c=1 sm=1 tr=0 ts=68a2544b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=BVWbUb0om5YRCFPiKCIA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDIzMSBTYWx0ZWRfXzFd9uAxiuiR1
 9BVTR0jx2AsptczyYzaMY0Dxu4qaOzkwCfN/v8M3em2DA2VPg4XlIYWdeIsltuJryaRLkpNdRhA
 00ZuNfR6roonyS46/mmapZ1hOJ9VeMUZeJGNSliLCw2T3SinMRlHLo5u60DapUKdPZkpp+vwuu7
 0aQlGknHB68tqB5vibjBi0Otj80G6YyHeNTvTzvXkeC6Mjev7eZw0I84nlMzvDr5ucmneCxJqpw
 dgClLaTINN5vxtnyHssHoleKsrC53xJ+4acczDslot8ptHhmlyeZMmN/2Js3dQZn2qIhp7VVi/m
 cY9gwIydqrtNk/+kEjSWF9rhIjnhP9Hspyc+Sw3SYjyZs942/j1sRMJZfY6FthXox1aOTwJYQxm
 znmWhQPf43cUZ+D+hMAtOcwTrcOAqS7aZJM+DeDlu75xSefSuWAxJ/9aWRCuvGqC/5xJrvLn
X-Proofpoint-ORIG-GUID: nx6xLz4B6ryF8TukPodsM_C5eqXcXmFx


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Aug 14, 2025 at 12:30:36AM -0700, Ankur Arora wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > On Mon, Aug 11, 2025 at 02:15:56PM -0700, Ankur Arora wrote:
>> >> Catalin Marinas <catalin.marinas@arm.com> writes:
>> >> > Also I feel the spinning added to poll_idle() is more of an architecture
>> >> > choice as some CPUs could not cope with local_clock() being called too
>> >> > frequently.
>> >>
>> >> Just on the frequency point -- I think it might be a more general
>> >> problem that just on specific architectures.
>> >>
>> >> Architectures with GENERIC_SCHED_CLOCK could use a multitude of
>> >> clocksources and from a quick look some of them do iomem reads.
>> >> (AFAICT GENERIC_SCHED_CLOCK could also be selected by the clocksource
>> >> itself, so an architecture header might not need to be an arch choice
>> >> at  all.)
>> >>
>> >> Even for something like x86 which doesn't use GENERIC_SCHED_CLOCK,
>> >> we might be using tsc or jiffies or paravirt-clock all of which would
>> >> have very different performance characteristics. Or, just using a
>> >> clock more expensive than local_clock(); rqspinlock uses
>> >> ktime_get_mono_fast_ns().
>> >>
>> >> So, I feel we do need a generic rate limiter.
>> >
>> > That's a good point but the rate limiting is highly dependent on the
>> > architecture, what a CPU does in the loop, how fast a loop iteration is.
>> >
>> > That's why I'd keep it hidden in the arch code.
>>
>> Yeah, this makes sense. However, I would like to keep as much of the
>> code that does this common.
>
> You can mimic what poll_idle() does for x86 in the generic
> implementation, maybe with some comment referring to the poll_idle() CPU
> usage of calling local_clock() in a loop. However, allow the arch code
> to override the whole implementation and get rid of the policy. If an
> arch wants to spin for some power reason, it can do it itself. The code
> duplication for a while loop is much more readable than a policy setting
> some spin/wait parameters just to have a single spin loop. If at some
> point we see some pattern, we could revisit the common code.
>
> For arm64, I doubt the extra spinning makes any difference. Our
> cpu_relax() doesn't do anything (almost), it's probably about the same
> cost as reading the monotonic clock. I also see a single definition
> close enough to the logic in __delay() on arm64. It would be more
> readable than a policy callback setting wait/spin with a separate call
> for actually waiting. Well, gut feel, let's see how that would look
> like.

So, I tried to pare back the code and the following (untested) is
what I came up with. Given the straight-forward rate-limiting, and the
current users not needing accurate timekeeping, this uses a
bool time_check_expr. Figured I'd keep it simple until someone actually
needs greater complexity as you suggested.

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..e8793347a395 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,34 @@ do {                                                                       \
 })
 #endif

+
+#ifndef SMP_TIMEWAIT_SPIN_COUNT
+#define SMP_TIMEWAIT_SPIN_COUNT                200
+#endif
+
+#ifndef smp_cond_load_relaxed_timewait
+#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                 \
+                                       time_check_expr)                \
+({                                                                     \
+       typeof(ptr) __PTR = (ptr);                                      \
+       __unqual_scalar_typeof(*ptr) VAL;                               \
+       u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_COUNT;                  \
+                                                                       \
+       for (;;) {                                                      \
+               VAL = READ_ONCE(*__PTR);                                \
+               if (cond_expr)                                          \
+                       break;                                          \
+               cpu_relax();                                            \
+               if (++__n < __spin)                                     \
+                       continue;                                       \
+               if ((time_check_expr))                                  \
+                       break;                                          \
+               __n = 0;                                                \
+       }                                                               \
+       (typeof(*ptr))VAL;                                              \
+})
+#endif
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f5801b0ba9e9..c9934ab68da2 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -219,6 +219,43 @@ do {                                                                       \
        (typeof(*ptr))VAL;                                              \
 })

+extern bool arch_timer_evtstrm_available(void);
+
+#ifndef SMP_TIMEWAIT_SPIN_COUNT
+#define SMP_TIMEWAIT_SPIN_COUNT                200
+#endif
+
+#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                 \
+                                         time_check_expr)              \
+({                                                                     \
+       typeof(ptr) __PTR = (ptr);                                      \
+       __unqual_scalar_typeof(*ptr) VAL;                               \
+       u32 __n = 0, __spin = 0;                                        \
+       bool __wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);     \
+       bool __wfe = arch_timer_evtstrm_available();                    \
+       bool __wait = false;                                            \
+                                                                       \
+       if (__wfet || __wfe)                                            \
+               __wait = true;                                          \
+       else                                                            \
+               __spin = SMP_TIMEWAIT_SPIN_COUNT;                       \
+                                                                       \
+       for (;;) {                                                      \
+               VAL = READ_ONCE(*__PTR);                                \
+               if (cond_expr)                                          \
+                       break;                                          \
+               cpu_relax();                                            \
+               if (++__n < __spin)                                     \
+                       continue;                                       \
+               if ((time_check_expr))                                  \
+                       break;                                          \
+               if (__wait)                                             \
+                       __cmpwait_relaxed(__PTR, VAL);                  \
+               __n = 0;                                                \
+       }                                                               \
+       (typeof(*ptr))VAL;                                              \
+})
+
 #include <asm-generic/barrier.h>

__cmpwait_relaxed() will need adjustment to set a deadline for WFET.

AFAICT the rqspinlock code should be able to work by specifying something
like:
  ((ktime_get_mono_fast_ns() > tval)) || (deadlock_check(&lock_context)))
as the time_check_expr.

I think they also want to rate limit how often deadlock_check() is
called, so they can redefine SMP_TIMEWAIT_SPIN_COUNT to some large
value for arm64.

How does this look?


Thanks

--
ankur

