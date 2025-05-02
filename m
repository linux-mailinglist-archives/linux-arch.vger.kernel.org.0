Return-Path: <linux-arch+bounces-11782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59404AA6D60
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E23465422
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D86238C12;
	Fri,  2 May 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sQy5+orf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RtyAoRfL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2E22D791;
	Fri,  2 May 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175981; cv=fail; b=cgMWqcPf8Gcry0yZexGJQMV5hDYpUAxykpR/MMykRZh4NIz/YIdK+8aKizIIN28f1nEBFO/LrxenAGS9a8H+HU+6Y7OTyaC21LTWbSv5qic77Nra+B34Vc5NYZuumE+G/12hDSU/OfLNlfheQDBJxrewyS7pMdfG24FQQKMD4I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175981; c=relaxed/simple;
	bh=b/3Eci+3vi8YUjfVbk9rCTMdvR/jVmbiCGRoCByII7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kj66tWw5H/HlcdULl5XSHj8CCT4D6jmlPhWLvZTc/HtG09wwj/vhxmg5RCl+HwgNM5cX17zR/96JZoiAjWLt7cKcYkOBafM1blXuLxBYJbqGgZsAOeUh8oHCU9nE0Q5pRjzVnt+OHIcGNT9Tt+23dZ3VIJwKD/wFZNSKUvTj2HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sQy5+orf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RtyAoRfL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WCU9015439;
	Fri, 2 May 2025 08:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KGops30G7DIE+snIR3gITEmmz/wKLoERlSlPKIC6Nqo=; b=
	sQy5+orfK+5srdDRCNbDJBap5tvxl+u/9aKqmDDuulKsLJUHYF9Ic554zlyCS1rp
	5SXXEaNWgboJMTXOw+LlQbG+Omd8HONf94FiKPCme3J4qnTXf4dOd/zfz+5g75qW
	/GV+WYA9o2m8v0B1Kc9qClBNqbLmnemz0Lrp34viDiI7/PtR5vyvKumzblyMrmxV
	bQBLkP2mNW1pqa/9RPyut5I7Kdz7uXiU4SkKYzwn3tj5TwX9h4NWvGMXIp25hNAf
	w2qIu2SIN5exdYNtgJy+xgl6syxuFySUjInIKA8drHKSHCnEUm4/ZGDOMdFMWvj9
	RXX7LkAcH03WT7BthWKY3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukmxgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5426aZSH033464;
	Fri, 2 May 2025 08:52:29 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdj4pu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZT/eCNsib5lLcR511Np/KI35mXDjDvopH4qWIaTle5DuuEKba3RQOBSzgREU4XXHtnJPbBOIWOTPZuQhUJhXCX7dE+1ciQ9tB6TcsvhFM2JnJjTo0Ylyi6wqvXLTSzLbxOghES85M4nL48w8N6p94uadqNVA0rMv0Luh0PrVmiFr4h8f5vUxHXAWvDuaDHEhLgIKr0yJaMU57bwAVbaXf3WI5zOTfbYFAzfxsK5Y+Ud6SP5bOHv89vwmkY0NJAFzykFDmM8lqLR6Xc9TS692u61Zbo4hXvXx58QvwjEsqKKIWqyep2ieSuEdaN/AcGQOKOrySIrjR/vZSApozD97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGops30G7DIE+snIR3gITEmmz/wKLoERlSlPKIC6Nqo=;
 b=sNJHnsQg3EsfRgJHN4fTtMqGAeQWPqYQhPgsCTVmmW01Zmo921p1IZcjgIyv0FLbhZM98QNMKpBheXjPsD5Og5Zw5MkjIKSQnJPDYHNVuUVKRzLTFUkISbvj80/tNXfAXW4UnAcZktLB417SGFVFYW4dLC8yEHuBOGulcYyHmMCykGUfTtZoX2X/ns4rkInxg5foBUA/7Il9wme/Tu93dHCLs7G6xkj3dIIMHzAPpTMOZ2RL0DaYLram84bgpVR3ZcJWYFUeuZDj3yZR19MYU+Or7eVD36F68jhdX0y0Btw5GJTY6/yo/LALFts4IDtjcmeAFI0lbMsNNPz8YnKUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGops30G7DIE+snIR3gITEmmz/wKLoERlSlPKIC6Nqo=;
 b=RtyAoRfLR754PGBqOoZg2KvTVD+RMerTgN77qHl1sE/uDbUkeFqBNqVaKquOGKv+PC3dQhz2EEr08jdGBnDeVyyNfCE8/rCHRtFVegXolR4Wh3VRs30zyLRMRwH/aVMp92q+MT8SHgNaJh/tlA09AZPH41eCymvffBKJTNuc32k=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 08:52:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:26 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 2/7] asm-generic: barrier: add wait_policy handlers
Date: Fri,  2 May 2025 01:52:18 -0700
Message-Id: <20250502085223.1316925-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b58db7b-23c6-4383-7faa-08dd8956a9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXKojoYzz50isEWa0V0w4WJULESkkto7D4reyayafGK1B5PFYhBCAQbmUNr1?=
 =?us-ascii?Q?CsPqrXlRsUMqcxJ9eqKohaNNW0StMfp0chDUkMmNVgp2FprcD8Yb9znsSCFy?=
 =?us-ascii?Q?oRWwsoEGpRRX8gCmMa4hFXncDZ9bZCgqaOP1TwQpD0HlaWzWfIyodLwFpxWq?=
 =?us-ascii?Q?BB02rmAobu4DRtJIyX9HNm6AQeR+pNRvcQyponnPEeMfj7edmhe9wjW5BjfP?=
 =?us-ascii?Q?20ERbWS89rJfFGYm4l5cF2A1PL/InP7IrNXthfswwfF0U23+7BkWZl3G/383?=
 =?us-ascii?Q?2yuqhw3/Bu6305qzHtQ/tHqCROG0DZBXH7VtJCYa2OvlU/xwRdMzdUQmy4VD?=
 =?us-ascii?Q?G6Vqvc5v3P8tVFMRrRtyLHP8SkE9Z++ZGs7/EzA5+1xAx9cbcxv2xt/dWquJ?=
 =?us-ascii?Q?plTb5Dsm9DGNebU6iENApjRj4ZBMtv+z8WBfSpbgCFra5OTL9UWEPOqIiQhh?=
 =?us-ascii?Q?2csfuzwVVEqCZNOdY+J9tr/UhcrNkCb8/LfnYLlP60dRhh1/W2UmyMVKPWln?=
 =?us-ascii?Q?dlJgD1ojRo7zrYbDeaeLtlJHJQ/RMyn3UGVdtxLKzXJ3L/UsP861rgH6gvCA?=
 =?us-ascii?Q?tjro56Z3MKn11/2My87vh5c7/m6M++Y5lt6iZFMhV/1ZpeKONoefKH8Q4KCa?=
 =?us-ascii?Q?iL/Zd25hcTmtAgC66/J9JGUdOsbY5xJ/ZGHJLLaGejjwrj6Se+MAXADPp9GD?=
 =?us-ascii?Q?fmDA8rMklN7bxCOrLECuqtMDiczaSR/eqXYBZSg1lZf3MV+Ji8fIZp0+4rA2?=
 =?us-ascii?Q?NCUgHXCK0VEIONuQhVJPd2KGa7rueT/gqruUNaZqsKrFbzzdJBE5GewvZUEA?=
 =?us-ascii?Q?W3GKKP70q3E/6y1nWQxIHCEWJ/Q+2NMFWOrUsREjZLJjPvB0/kStyDafENhw?=
 =?us-ascii?Q?5WRxK68UFxp9rou71JH5hQ7GHSe5C7d1+VYyEuohF0JByhP4P9lbZdKtXO87?=
 =?us-ascii?Q?aFO9DGo1p6pif8G8JOPJcxFa119Aat+XltIKWK2TncW5hfVsswNZUnJi1TLG?=
 =?us-ascii?Q?lq2EOXmQzwa4KNGYc9kmqzYSJKYccH6KrsjcHERw+28r0fD7Ktg1mDO7FM/Y?=
 =?us-ascii?Q?My0njcoqZQ7xP5p7vVDV2v11i3b9x3PnCprdi5KQwkbA/p90Cd0fjRvcSKF1?=
 =?us-ascii?Q?S+S+z5pQLddt9aCJgO/6DqxaHCz1/Ao03NTqnQsshLx5MhA9euCvCLM7FoLD?=
 =?us-ascii?Q?eajzmwobjSscHDpNjYYjJlJLCEDKafnUiirxps2TYPei8kfh/QfaYx+yb68v?=
 =?us-ascii?Q?6M8vUO3BxgoHglsyoScqCqGPMcnWQG90CB7zMnZya56Rt+iibc4LkBKjTi0h?=
 =?us-ascii?Q?Pw+oPvgUrEUcdXDWDN1RQV9rH49d30aFPB1dGTT3Eaev8GrxW+5o2UbVHXZ0?=
 =?us-ascii?Q?wYK0ONhiurUwgstQuE62wbVjo+Zikd2u2V3Mnwu032yVIsQlys2UNSzlWQ4G?=
 =?us-ascii?Q?H14gKkeq8xQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76kQFqVprxlBZpjVMKxrkthO/kyypXNZ8pwflGFR5ydowcdIDp8wh5reHd9y?=
 =?us-ascii?Q?ZOloWSj19yqUPlfvFgxPzJz59XxYN6v8LAQNL0tsLLVNltn2/vzMCGgI64Oj?=
 =?us-ascii?Q?EbRjDInEAiTZ4Y3mQzO16csWuDjyEIeh1g0schCSSVKQYDG7a32SVTuVcuPi?=
 =?us-ascii?Q?F/vwp1kkvbfI9RRAiK/7XCaCMFxB7VSW7I+TjZ5daBDkB76BIRuxMD4UoGMp?=
 =?us-ascii?Q?pzMharAc56MVTzXpxcaielFeiNgFgUk3Tt4uKgZCL68J2/+XT01DkSK2esZ7?=
 =?us-ascii?Q?1xV46nMKf/0AueVkVm3S/ogwKmAY6HDuhhTA5upDlOH2pDkarSQeTTkbdowp?=
 =?us-ascii?Q?p5X3FbeCcI6Lzuhp7QxMD5kYSK0IG+FvdXqFTtoOTL+8sVpmULlUf71nFiDz?=
 =?us-ascii?Q?8WSYGoUoXkyOf1uoY7+U1JjPAOpi1hVSKADBcCBLpFDoWQRiZlh246saMmSz?=
 =?us-ascii?Q?Mk2xwvXZbtmOWxH4j/1FEVJQ5FFmKDV2VnO+nShCTNye5nGetGKaAuQLh6Hk?=
 =?us-ascii?Q?R84+LTe0TTBY7olw+eAu2x/ftdX31rdK+0lCb2S8EzErvwp6x9G2iLJDDn3k?=
 =?us-ascii?Q?1+DbwWva2LzC0pOjaOJxpZXXcIYGn4PdyP9S+i18rECzjt/Up3EyIlxjEC7g?=
 =?us-ascii?Q?VOTXmKMJ3EVcuf68p79IfkiEAwccJQ/8bq3aopCVTj2v8jnZnr4c755RYUU4?=
 =?us-ascii?Q?yNggQP7ZF36SHTkjqNkMHcg3Wxmqjh48gcA0ZemnDN646TcEAs4nt7Gm7+mZ?=
 =?us-ascii?Q?f6lw2lDDHPDSfvoYllVI0VIoRSS5Iu3/ujXgFUV2d/Vpv4YPjrYV83TFs/iA?=
 =?us-ascii?Q?Xa3mGczy+wjeYmtRhB9bLHdXUOBFLj2pcPT4+h+2VydGOHBIzAwj6foBsWf+?=
 =?us-ascii?Q?dv5BozGW9MBHJc5Qa+oNmKvPB6IlJ9P5gF2GhTUEOQtsgMwtEpUzPerqpV6L?=
 =?us-ascii?Q?vcmTc1j/rGbFlh9LWcTJ+wyq9GwgsaUgeUzsNKVrRVbzEo3YNSqjWJlVoFaE?=
 =?us-ascii?Q?xXtMxINRxezZ/tb7RQ1v2r5orF8xvkRn/RJblVqsN8tXtHt7H1DNXTBF2e3U?=
 =?us-ascii?Q?L7Y8esJ4Q87BoONbhF7Qqk2aJPXfombr3+fdQbT6XRkdQgrOmDKTd3+jkVob?=
 =?us-ascii?Q?9BC4geIB096z9cG4mjSzPyGZavnYjmOwclQa2aiGkRBJUz4mp30GJHXcKTWm?=
 =?us-ascii?Q?J8Kkj1YAFH+XpavFUpGJlRFhlqYn2yIypWQU6u+X3bVDhTIbAX7uVSeCcu6M?=
 =?us-ascii?Q?s+0DFsq1yho+Z0R8Dw/RIbsTEC//9t9Y1C7N1adQg8nLcbkcbGbp0C3VdZxw?=
 =?us-ascii?Q?JH/WOq61NT+OlgA6CBRwY41WD+k84U3gJTAwbP5ac4C9LNugmgHvIc3+Ynf+?=
 =?us-ascii?Q?izchnEXyT5bSnbRjIsajEEwWPSqFT7PYB+xdKWaX7jWKhmuydhqdTF9heiQR?=
 =?us-ascii?Q?m51mr3aFl+v6mc0fbgRYPrAuZJmcY+pYuiAYeWR6EfsFr8M8SiVGYKI30ayB?=
 =?us-ascii?Q?X25blBIgB8QVHqzVk4lsofhzvzWtVpJYt5rWlYXNsKk/yFIqO8tYX5KAwsGI?=
 =?us-ascii?Q?wbvAZFd8KtSCp8OpHlEOlhpumvXYrERO5KPQ73kcEd3YTKru9lLV8B+1XKEB?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vd2LpBHbZ3r2qn8IDLXL8GXucIWHP/0esWTcJWcCNCR3DpMUaEGQDC/0ENEhEXlTci5oIQDwofewTIj632BdgI/5rQDvJRySDfZQb1BAF7adf5G7l/QtfKgxh8aiq2xyaMhIEllGfmhsY3OnFcH7yY5OePo0JepehPZ95emyijwanTd97HV/iK3sSq/TEWEcBqA0+CZB/moPYOFUZsN4e0gCE7awUB8bG+1Z1R03yFSFqEHiyhal9uH93FT0bo6LL60Jl0vy1BxTc3cEty40qwfFSIdBlE2iq5I6AfW3h+AuP8qYH4+Pt5/eYmqveb13k/biWm9dqlnostHP8HiROD0GQGvYHYlnloCb0mSakphbeiPa72zE1k3zYVc4a64LhsbLuvOABiMAUc7aUEOpsd5dtUPnOOTePtPUIsGCy9sP228reH86oLyA2xKZDRsnVPayIXsmsqKyBaPJ7p+Uu07sLvSEnbcUNWqgD1VQv/Ckw+N/djjW9/b375H39uSaJic8d2TmJscxO6FZVXG1WkborzSsJZAeO8yfvAu6az4U0aaqgR8c/ALiAOyMDxqjHXwGJuVVRlkEfJ4RjXZrWkMNc8vno1aU0QfjdW4J2vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b58db7b-23c6-4383-7faa-08dd8956a9e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:26.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M6SKpTfmKNF39ifjEA899i2F5x1KPpEZd4L4FVwTqxgHtSgEis9Fd5s9NQerbQRD5lRkZNs46d75McCVyceolesfgCEqvD2X8PCLzZUrzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020068
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=681487ce cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Pz8WANXY-D7B5XMkspMA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 0pqCMfrGPuKQoPY22PHQe_O2MqQZ_4Gg
X-Proofpoint-ORIG-GUID: 0pqCMfrGPuKQoPY22PHQe_O2MqQZ_4Gg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX8znhhjX0FMNn jq9YmqSN05nnOihD2gljG6u2RDOCL0LLckjDcvJZAmRT1DfNJhmjUFsl3+SZPi9HF4GUSBPmhic mwC1jhUGR1iedLuHhAWgMKQXCcs+qTvw0j5ONbwHoRiGos7/3H64td+wYDu0SpuWM6C+VlkvKp3
 i1TmBd/6PNkjQ5IaynZOxEO2jaIzPEP6juPGD3iDmQYeCXnDhVdlByGK8CzpcY3dc9wFOLt7239 GzYYBaYZi/xqSvhj6k1Vbtb/y7zmJIWSY+q1x5UKrnrdtmB+Q/O0cP8Wn1LdRsz8+YRLjNszBuX k0DhKrZFb5yQ3XplAhC7KzgbVxmc6u7rDq7XV7GzYikcau9MGmyZASniUy63Nju0brm9VFILQyN
 wBtP44t2HlcVpV3bXo8FW8iZsWZEVVqQdzjjN5p6Kx9sFwjqN0KL1bOWZt5dUS5Q7cvWhdJK

smp_cond_load_relaxed_timewait() waits on a conditional variable
while either spinning or via some architectural primitive, while
also watching the clock.

The generic code presents the simple case where the waiting is done
exclusively via a cpu_relax() spin-wait loop. To keep the pipeline
as idle as possible, we want to do the time-check only intermittently.
How often the time-check is done -- which also determines how much we
overshoot the timeout by, is configured via the __smp_cond_timewait_coarse()
and __smp_cond_timewait_fine() wait policies.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index a7be98e906f4..76124683be4b 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
+#include <linux/minmax.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
@@ -273,6 +274,64 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEWAIT_SPIN_BASE
+#define SMP_TIMEWAIT_SPIN_BASE		16
+#endif
+
+static inline u64 ___cond_spinwait(u64 now, u64 prev, u64 end,
+				   u32 *spin, bool *wait, u64 slack)
+{
+	if (now >= end)
+		return 0;
+
+	*wait = false;
+
+	/*
+	 * Scale the spin-count up or down so we evaluate the time-expr every
+	 * slack unit of time or so.
+	 */
+	if ((now - prev) < slack)
+		*spin <<= 1;
+	else
+		/*
+		 * Ensure the spin-count is at least SMP_TIMEWAIT_SPIN_BASE
+		 * when scaling down to guard against artificially low values
+		 * due to interrupts etc. Clamping down also handles the case
+		 * of the first iteration (*spin == 0).
+		 */
+		*spin = max((*spin >> 1) + (*spin >> 2), SMP_TIMEWAIT_SPIN_BASE);
+
+	return now;
+}
+
+#ifndef SMP_TIMEWAIT_SLACK_FINE_US
+#define SMP_TIMEWAIT_SLACK_FINE_US	2UL
+#endif
+
+#ifndef SMP_TIMEWAIT_SLACK_COARSE_US
+#define SMP_TIMEWAIT_SLACK_COARSE_US	5UL
+#endif
+
+/*
+ * wait_policy: to minimize how often we do the (typically) expensive
+ * time-check, expect a slack duration which would vary based on
+ * architecture.
+ *
+ * For the generic variant, the fine and coarse variants have a slack
+ * duration of SMP_TIMEWAIT_SLACK_FINE_US and SMP_TIMEWAIT_SLACK_COARSE_US.
+ */
+#ifndef __smp_cond_timewait_fine
+#define __smp_cond_timewait_fine(now, prev, end, spin, wait)	\
+	___cond_spinwait(now, prev, end, spin, wait,		\
+			    SMP_TIMEWAIT_SLACK_FINE_US)
+#endif
+
+#ifndef __smp_cond_timewait_coarse
+#define __smp_cond_timewait_coarse(now, prev, end, spin, wait)	\
+	___cond_spinwait(now, prev, end, spin, wait,		\
+			    SMP_TIMEWAIT_SLACK_COARSE_US)
+#endif
+
 /*
  * Non-spin primitive that allows waiting for stores to an address,
  * with support for a timeout. This works in conjunction with an
@@ -320,11 +379,18 @@ do {									\
  * @time_expr: monotonic expression that evaluates to the current time
  * @time_end: compared against time_expr
  *
+ * The default policies (__smp_cond_timewait_coarse, __smp_cond_timewait_fine)
+ * assume that time_expr and time_end evaluate to time in us (both with a user
+ * specified precision.)
+ * With a user specified policy, any units and precision can be used.
+ *
  * Equivalent to using READ_ONCE() on the condition variable.
  */
 #define smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
 					 time_expr, time_end) ({	\
 	__unqual_scalar_typeof(*ptr) _val;;				\
+	BUILD_BUG_ON_MSG(!__same_type(typeof(time_expr), u64),		\
+			 "incompatible time units");			\
 	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
 					      wait_policy, time_expr,	\
 					      time_end);		\
-- 
2.43.5


