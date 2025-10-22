Return-Path: <linux-arch+bounces-14245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3BBF9C87
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 05:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2E04E559D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 03:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2B2222C0;
	Wed, 22 Oct 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U0pMTdVH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQPQ+Ytp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E064BA3F;
	Wed, 22 Oct 2025 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102487; cv=fail; b=W/nGUi/l0FjQNHWq7p4R1lrV/5Css4OaLOmmVS1+4/wqJCePj8Ek69fO/NCG+GVUl97Nwi5Q+lFnEHswdL4CBDU0EHH87wQAQIE5xxcNls80cZDE4Vm++bdAVmRoUYPnzw4ZqjYMGH96kivUxt+au8QQtoIsNzB30eHwVsJ1xRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102487; c=relaxed/simple;
	bh=CMsosvfRRbtNJplJoRaKi3kkiTOf2ydWnNKKTdZU7Gg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=hTKSJ+mWJR5z/BbdxMj03JXhXjvbBgxyF3Rxp/h+GqjWqv9el3nu2Wdphh18UOFRu45GDPYFb6KP1/PYLY0YiFOhyjIEp3bqPZKV0ghEZ0HqKKoylEZjjcTEXT+O4djEbBG64UptvPsKAz6Fm8e/LOSe45LibOr4YKGPAA6Bd+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U0pMTdVH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQPQ+Ytp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M1i2gr010648;
	Wed, 22 Oct 2025 03:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CxS9mrXoRJpySiRcQ+
	LF74jvAMuhg9ovKTItHVdKnMI=; b=U0pMTdVHDqlw+bFqNu8LR3Ln86eecMERWa
	taYQENB+MmULcfSEk6V8ht5QdsvfPLD4GA7kTicL3ZlTBD8hejDyapotLNjZKHy0
	8hona9DyhGYqWrS/8S688l30VzPPSsQXdJRA4zUu9I6d15VHnGOOwDlns+wwfVgm
	t1s8k2uAx8o59ZS3HdX2tVkLrzgOXy6alUO4lW5ZbuiTfxatj9/ehCbrR3vDQBT2
	FgiU6Y6W1T/4DnaHjc/Sf3yp7OYxMSg2CU6rtDv1L/uCNRQzCMtnCZYY5Muv4O4E
	GPMw/WiQRuS0hJfYLe4krAnxx2qQBXeVHyXQnooihURtYKon54rQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvxt9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 03:07:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59M12XvH009376;
	Wed, 22 Oct 2025 03:07:36 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bdv6rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 03:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQycKn7ipeGbA7hg6BziZzT7tNvUOLKw7DGrcmvbfXge78dS4GdaxqKHeXIDnERT5P0FHUPjSQkVR/nudN+wcAQ4PKr83PyazSld/iH44n58TLO9pI/ZO0FkUeZ70GUyUrTDH2zXoUmZXpi9jxldnWGB+0w3OZP0LzjdsI16ugMhgkcJxjbET4w6hqapgAxk8sVgKsyKb5Hc+58++Ebs+bFI/lhOQCmHbrZwrXsC7+MVTXPjf0pbjJZgT6dvU+TxsIL1PWDHrNQklpxaRwRT4o848xQAkVKKbP9sNkTm7fYTPERvfLAvHIvM44ygrbKJ/hTQV/Q+rdUAxkke4xpMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxS9mrXoRJpySiRcQ+LF74jvAMuhg9ovKTItHVdKnMI=;
 b=pZDdSOTKYpJvyEwVEhdufeNQ3cdznrvZaNjE57xoyM9W2KfmFVBIVX+ErglZGS6NheJI99DqEBdUTKXTKknzVK/4ByW/jeEnZWV9QmteYEnxgVo1Md32ZYmRceaSxgFS9OTUjju9ztYD0PfdI8o+I5ngCQ0Q0Oo2DrRxo54GXMIsGg5Fve2qkziZ5LGeYTjeFu/y3/CaClJU3RqFPO+nb/rN6UUZdArEB4/8/Lds3SAfC6o8kJizZ0xPXKv0thzk+djMHpvEyW5+J+k9WCCVwvZKi6KrKn4vdi/zKXgis540s9ZGf1NSgaTxdvRxR4A5x6e1YhnLrAG3/2glhH1iVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxS9mrXoRJpySiRcQ+LF74jvAMuhg9ovKTItHVdKnMI=;
 b=AQPQ+YtpQgLBMXlv+PlUBvW+U4okr7kpUuoJ3Os0Nz8gOIRWM4vxu9buSkJnu9GU5yT8CTUCtFGbsZOUmibzA3PJlJMTDIQCIg4+wFY+TUrAfeN9cK2NcCT8onEwHvV5kL+3ySCo9Yw6E3S5DOK+zudqkm2rQxL4P2jqSEjwVS8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB4889.namprd10.prod.outlook.com (2603:10b6:610:d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 03:07:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 03:07:33 +0000
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
 <20251017061606.455701-3-ankur.a.arora@oracle.com>
 <c8be3663-42db-4c8e-cb5c-b7f28aaefc04@gentwo.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <c8be3663-42db-4c8e-cb5c-b7f28aaefc04@gentwo.org>
Date: Tue, 21 Oct 2025 20:07:31 -0700
Message-ID: <871pmvws5o.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: b88498ad-3bab-448b-73f1-08de111824ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlKasg0Oz2zY/gJ2mmquqJLkjgvGXqWvslaoNjHgvnk5KzvbizXAfXPakNNc?=
 =?us-ascii?Q?t7wcNZXEb7EVAvGZCHjUn2G5a8DjRAjijQrAKXoiKCbaSvA7HXZVBw7wU9LK?=
 =?us-ascii?Q?jpa3kv8e36qhfnRWXy0e+58wnV99sEZCsV4uFJladAIGs+yPcxY6NyCCpGXI?=
 =?us-ascii?Q?BIM9YrUijTBfLWSJIyMemB3EoGZHJYyuRqxoFqrWascmG45tbDkjUOGknFws?=
 =?us-ascii?Q?H6Nsdxb+8iP1e7cpIx7C+lIc/SBCuEuCT4IsHmoXA+1x4vP+HUZJQScP96Uh?=
 =?us-ascii?Q?DTZNw3zgbXn3vh8bWFZN7pJI+qO1ICD6aBj+jsRvmxwtCy1CiBoQDmga6kwC?=
 =?us-ascii?Q?O4k1orHjZXDMROlRKmi9RhoEq3QTWJrZGT/dZ1tSp74yhmeOh1ZvjTObgYNM?=
 =?us-ascii?Q?f5Y8rnZ8s6D6596As/r5MDe6zs/njkPZme6FVKdAi1e6yZMfc6fEEc0CZy1q?=
 =?us-ascii?Q?OOQxKEmZBj2+mpKon/6r0GLtaVONvULrV6OZ8nzzb1ikPvyfZ5xVJJjDQ6qI?=
 =?us-ascii?Q?r5YFF610VjQ3079ew8q5baCCzefGsQVzL5dEGdxmO2KzwuXFKx0UfcDWwsG2?=
 =?us-ascii?Q?B6urp6xiN15XkStVm/LvXmpE3SIIOpgYuCN7lFi/phEni52SdAgEoPTtRRBg?=
 =?us-ascii?Q?NVsz0BxtQNENgLahdKxfZyhr5CaFd54RGE0vE2j+pEYCn4bnH+LsMJRAKG12?=
 =?us-ascii?Q?MZj/7Ymnk4EbJ07kB/K9oK+iPhi+ytnwXJNh444dW14vK63joEaMuPRHRtUB?=
 =?us-ascii?Q?NaLIpQ/wvRYxl6Nj6cQtLLBYnOV3/4t8OKH0utu+mdW86Yb7GCY/bvcrpiqa?=
 =?us-ascii?Q?AEFBSW6sCcyxY2/3rdkFqVWF93iWrNIn29YfH3IaamiUxyF7A3k2PbGTzHHQ?=
 =?us-ascii?Q?07LlnWs9cj3Ubi1zCPrYVILUR0C3ELBqeZRh92ODLSMk126rUvsLYUobo7+z?=
 =?us-ascii?Q?uhjDzrfpOWMsx00MkzvvBpwiJJAmqkQ10isvfYiqwmDYF34UqRfKRRkIxLwb?=
 =?us-ascii?Q?6fYW44h6PWsezkOn3kTX5heCK+thcYs4bsLdIv8UdLDME4RAblIKtT1RPPlU?=
 =?us-ascii?Q?yrkNlrJZczZBmCbhc0sDxO+3Ne6EDVcvfanaGHRO0Q7r/p30lnCpM0kvAHtt?=
 =?us-ascii?Q?9QfI6k+Uc77y1zeGqqYMHznPHum2BrezAkTzWdo0CY35W+35gvAFXghP5vsW?=
 =?us-ascii?Q?wJN9BE2Z0dAR115lsR4OP+UZ/nDSoYV/sxIKFPZarAeQHz6dFRBgzwQVWTfR?=
 =?us-ascii?Q?PgnC6lz1+OTZm0H/Gq7qYIQgarx810ZseqUlH0T4jA+cvEkWmUE6r0KHPO8D?=
 =?us-ascii?Q?LnodvBaNDTzGyeGd1egc5HSv28WL6Gl7CJ4PQF+9+8DutDUKg4Ne16Lgi4EL?=
 =?us-ascii?Q?kRjfrLtK9jRrSSA5oaynASX/CSGdCUh/qKg9yin6dbaBoAfNQM0h+JtGb7tw?=
 =?us-ascii?Q?zU4PyS6W4gnw7Z6bO6eLuw0iC7ZA/XVj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WFPe1M1G8EnFr3qHGG938bY7snckxjX5Am/6yK6tdEMcn/tLap5mCvubZVxT?=
 =?us-ascii?Q?/67VmKUBSksdVeTq/wl+0++gCY7dKhNZl0RFaOm92Iw0M3eMna1fT1uVxsru?=
 =?us-ascii?Q?+7hZbheNa6wmCXAzPgYafeOymXfycfYVaX17SNtY9LeTGgZ+LgWetJTaXXR1?=
 =?us-ascii?Q?klnTJVSc9M9pMIOkpTP1y+xx4Dx3sjpFFow+MM7N9HaJwXpZmBrthTOn8QXz?=
 =?us-ascii?Q?hbX4TBPdtAkv81GcAWrfW3SrOKm5f5eylOepPSFKsqMN7+rhuX643tTPhN8s?=
 =?us-ascii?Q?TbIftA8DWtlICSvTZPkEEfDyUvL3/YhzAh4bkD3LshXx0s3POrD+H+3CC2YG?=
 =?us-ascii?Q?Xg8Qm3GVeVRX9KLI/rGc8Xw5FKia89YGIM6OHAWCcvSo74IteZWX+6LiWHYb?=
 =?us-ascii?Q?ztzy72w8mwhi0fVDOBOFcKtLafe//5FPaCT8BMK9n022ZUfZoJN3KNx91ifY?=
 =?us-ascii?Q?+EWClg7mGA5DNqXpHFZK10Ewa7G/MQIZAlCTWoaJ8GB2FWYwapam/l7rONgo?=
 =?us-ascii?Q?B68RxCERykj3V9Cx0bD68R/k6ERmsrG4foWt898qEsaig2hqLZ+ZsLWLiw4c?=
 =?us-ascii?Q?GrzubwgZxDEDb9DxFAkNAeYBatlu/xvFCxt/fVhgNTta3PAyP/GiGnkJKCR+?=
 =?us-ascii?Q?U7Tt7biIAT2Gx17AaNyG/WuBBA1mNUZ84VQDoHm4HYJPZS22+8KmUEy+NJ3O?=
 =?us-ascii?Q?Dbt1d1rkUXB0kDMw0DPJV3OJKP6T2WOiJ2WKF72PhLUDVHqdQMNs2gs9YS6Q?=
 =?us-ascii?Q?WXEPPRHMPINOyzR+ROlXlHpUvXCdbMktLgZbPhKAyj/ZFkCMOhkEe3Md1mKM?=
 =?us-ascii?Q?+Lol/JUW22kyjztY/ZqBkZRsza8Xr2oilV+Oh/0iTePIh9lRjYe7IYlD8xCN?=
 =?us-ascii?Q?mlreYTTITccMShr4VNb2LHH4Ezwf8vgcVBUvOcsjFV2KkmC8jMXYj3Klo9wr?=
 =?us-ascii?Q?OW95lsj3yW2YuqIGQC/wH/HXhONFQStbjBOJlHNOCtcuQUiTWzp86DPcHLVl?=
 =?us-ascii?Q?R0n+6ZJWcyZB5P8uFXUIFq/lREo14Qx1cDmpGKZLl+PHODpoiB5pKz1OQMm8?=
 =?us-ascii?Q?syNU6z7TTTe6gMtRky/6/4N02AAEVqfrx1fYWoa7yrTwdTNk4GOkRltbIBMq?=
 =?us-ascii?Q?QiUo/m/NCFDvGyTgghhjYZ+dId4f2spjZBA/M1Pn0uB+OBrYQ9uo728rPEW+?=
 =?us-ascii?Q?+NSWzSUDds+qMppqrvFtNZEL9JqZt38RJ6+pB3D91Ilmv/IioNZYzWFuNSQG?=
 =?us-ascii?Q?Q+tjflbnY5cKt14po2l/WHpCXpYk1MmbYIasRotzBGkbglK61qhRq5WK1lSd?=
 =?us-ascii?Q?giFSKnIHNtAl2r7Z4JOKnaNtdouZ25GmHuN959ONT1/Nk0o5jtqCZ50SFThp?=
 =?us-ascii?Q?KPU927AQCh/Z3zUFf5CSNVSX4VMLOkeisrV8oyLTx/JVfT/Q4MnHsBT7iBj2?=
 =?us-ascii?Q?AFS86numCnRM8c4gwBtUeWT99PlsdZP+7nw3A/pFaXvRFRmUFNfxopPtJp6b?=
 =?us-ascii?Q?SQPTCARnyLAuzUDEQzoxE/W84kd0nSC+iPy+if1iAL5wMTr27IDtauIMdZzz?=
 =?us-ascii?Q?JNkRc3FFUJokxKZ2gN7aeQWoBxp016+SSO1CsRQ7f2LXwbCCiOaS8BduKpYM?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PdR2YFzJrg5NLctaIo7La2/tlLKHTx0F4udcmfX7VRpAnlHNNAJe/Et8endLttoLRyPmMxdZKNJYkQ4KnHPyqmnzxRwo17CbucUZqa70f8TWZzZchXAtiuVt1KCmkbocy6mB4hTS+yIlix/mAihOcmUSwmfK0EQkYgyWActx35qh75esjxObfE/SwJn3oqJniMpgd4JxSkJHiPNDL8GDFhV0NTflMzgDbmIvHxppL/ccKRoGLfyUtQ1Q6FbIXf2zRqiYBwZLgF2wDd+RCasw0lel6DeuLBFJspsYX27z4lwZARPY+Lg0XW6QUFSbXc5+/X47nCjbv2Y/bZZ/SM8yJLDvMGt/5rVFzABb+92oJqG7k2TN27Ogw+k3vj482NDFsodaN5YsQAmnvIwZmkpmhUICP6duP3xnRAS0mDTpC5h4VbXsM5UneVSLovZqLP7XFKQAZCnAqDLbTskNBWoYKn2NEU1PoIZLUv6WCFQCoj0oCr4fLE2dGbHvw8KblACtYlHUW+pz5D5eoys7DiwuByZbXU9Tdp8UOMncT+VNDuZTyuF3b+hE1GVMGJ1vZZmMjgnkfdn/Y60KfRpivfl8iXVwyu8ZoiTn3kDeZc4tnyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88498ad-3bab-448b-73f1-08de111824ff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 03:07:33.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eDhI67xqJdMNd7R+Ly2P0GolD4RmJHwYQ8qZP9/nwanE03Tl93N4SC4aiV3WaYTEsWTbfc3ygYbqKdefngnV8lYCMnClLMsqqa09YGo13Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=686 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510220023
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+v5sbOdhP+Wf
 OrJp0ZjkXbchNSr2jDY/toWltO0GRd3CBFAi7vu8kNQVuoXVaHv/pxunF67E2iCqz2qRfKtwkNi
 6wuoTPJJtLctkCKLYKuvXEi/XWKITzofe5UQInMvCQGatjLPSnF+DycPeiSVR/fnvHS68mMZ3sr
 aoYaMVfqy/Bbq2GCiLgaYYMTVEzbKzVWgowQD5c8reHZ2P41CuInwisRwtVdpxSNk7Ah4DWUAKn
 EdFw0tFQI4onjs8j1jDIckxGUjnyIkh37hhC9WNExibl6jKBxmOsk9W1lQBg0ek7ElOJtp07ots
 sp6H93bdNgISdNquV52Fie56RBwEr8GttdKyelnLYATf+3/ldmE9p9R7bxTflhFOjMQY33PrAwg
 Qa1NxWf5iyALiqTjJ8xVCwd63adf3KuzqYCAbtBDq+KDApocWFY=
X-Proofpoint-ORIG-GUID: U58n2dBEH0CO01cegmghlOzTNGxYdkX0
X-Proofpoint-GUID: U58n2dBEH0CO01cegmghlOzTNGxYdkX0
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f84a79 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=PuvxfXWCAAAA:8
 a=XH7sup0yooXFloLmMzwA:9 a=zZCYzV9kfG8A:10 a=uAr15Ul7AJ1q7o2wzYQp:22 cc=ntf
 awl=host:12092


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Thu, 16 Oct 2025, Ankur Arora wrote:
>
>> +#define SMP_TIMEOUT_POLL_COUNT	1
>
> A way to disable the spinning in the core code and thus arm64 wont spin
> there anymore. Good.
>
> Spinning is bad and a waste of cpu resources. If this is done then I
> would like the arch code to implement the spinning and not the core so

Agreed.

> that there is a motivation for the arch maintainer to
> come up with a way to avoid the spinning at some point.
>
> The patch is ok as is.
>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>

Thanks for all the reviews!

--
ankur

