Return-Path: <linux-arch+bounces-15685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F0CFD04A
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F4A3137C54
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD0325496;
	Wed,  7 Jan 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="huG+q+hx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nYqC5eF3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127D322557;
	Wed,  7 Jan 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779033; cv=fail; b=u0vzNxUB3U95SoXpJ2DwHECIgylgGyeSNmQsOroriVavVJi8Jv+ORFjZcAIGHJaB6n33P+XV1xvjviqykUXM700GqcMp+Jnd1oCTcvL90h50HU5DoHWWWo3A7Qt74K5kC/wpLp0024ekx/mHin6ZaHsO5Jc8uQyYLdOX79JIkdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779033; c=relaxed/simple;
	bh=mEuqy627ecY1utJ+nAQqSGOQ1iaeCQTMpKHHOWAPg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g++2qWaW0s0B7HeYzMdYQo0lp52fHelJsGXOHI3/f1xRj4gggxVMyUAuR5YntBfbOKOEcUa8PpqAa91GEYJ73Eo9G5PhsKmBJXqVJo1lFK+KctwAvxYWqi6WsoWjZTpVfFn93AmONkb9IsulKHRyK6gCArv7j1Mq79MOkqTQgvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=huG+q+hx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nYqC5eF3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079OYof1612706;
	Wed, 7 Jan 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lG4YEcZQWwMfEr5/+P7+4kN+GCE5HCls7v32tQnemjE=; b=
	huG+q+hxx4ETNwLJyFE1j9wxYE2QGEVWydexVF+lz1WPIG2mJBPZR/bDT74UYTMZ
	pPw2+RpuzPSz0aK6hjtLIhbiikSoUXt7IxxLm0M4JsC2XcWcVrSprWyOnaku0Joi
	XQGrQFnDHBqVZcmI8CK8BowuXE2z99O8Udqi25aKQ8t08EbPlDtGddqsiD6hE4C5
	BWjOgSmgzAiFhQAgsgOH2l1Ht20IBo5/74UZt4maJ9IFQY3T0eJAAWFOaVWr1f8E
	umy2Jgpsom52fwMxnvs8Ma6Bp45OwX9XHACE3Ha6nFsXQBSLtHAi1hI+96NUiAdd
	Quab8WNtiPxZeEXJthIqqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhmhp02qk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:43:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6077ZiWp015545;
	Wed, 7 Jan 2026 09:40:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9dd9e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejaYuByJPwxpcxTUqEFn4RUS9RRdvX7RrbzAVxoTHJNRebjBhN2rR7VKiVDM3Vc34SZJIIlOQ6XYYKF3H2IVIcYpGUNxDRB8vFffSDA2Z2joQgEyy3PqLkP8TykftTdv1XKcsCfVNlYYxbBrbi+P9ms+XOQxanl6s/6Vt1XbNcLalzCoUtvAeqwSqPsLwbufEAxfU9Wvf5I2ecLsfkSlJ4kef3rhgBmu20T7/HTkvbQOBqwugtBexMDsi0LWyrdGOlp1pIJysho48nQCMQyBYjiP0jmIPTY78GBPNV60li4nsT+WknwfWbLh+pCfPdnedoFV9WD0BghNy7wIJmLrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG4YEcZQWwMfEr5/+P7+4kN+GCE5HCls7v32tQnemjE=;
 b=EJorchtbEzuNWEFF5NFTWFWUTIEnx9NqsAziZJE4NyHqsJndiugtG8xfhis23Wym5q/OFnzzgwH5/WXIGhhT3Q7/aWViO5nQmqGFjM8YeckVtU58krec+CU7tKzR0PtTOOT4zjwkGVV5R81Skx7rbW4/Uh5/2V2vO2/eZPC93IXJRGkYi9W39uqMjmcjWTOMQ7ZVvbztL5xIYdKv4jQNvohCu6/8/5UKS5vwRHcFg2CM+9Sf4gqZf+9oVq2NMOiFxAnQAaapEUZrTFDIBpmuVjp5Ds7G9REWx9PEsyLkQ0vjId6ACfKXpzTT1Kx5sJye3QpodFJRjpOTYyK+ZwCCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG4YEcZQWwMfEr5/+P7+4kN+GCE5HCls7v32tQnemjE=;
 b=nYqC5eF3+/sFaUSC6JWgrCX4EjXtOm15eWIOhNiHWkDRPQ9R1VgPIfPvtWp95cEjLJlNWWQxun2/ewEEL2yhixbHoswn+8QzaeFoz4rBjvHuDV2RYWCQiNoM/OjNGU31aim6YLo6NNr8HTKXtPYlRq89FMwlPO7xdu4LH/QhbpA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB7479.namprd10.prod.outlook.com
 (2603:10b6:8:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:40:22 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:40:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/4] include/asm-generic/topology.h: Remove unused definition of cpumask_of_node()
Date: Wed,  7 Jan 2026 09:40:04 +0000
Message-ID: <20260107094007.966496-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260107094007.966496-1-john.g.garry@oracle.com>
References: <20260107094007.966496-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::13) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e5a704-a28c-4a1b-6627-08de4dd0c70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rBFFF9GrfAIGDZ+GLQDIpRHpQBFTJM8oWMxqh6VitTHv522Iec9IQ0B6BDdV?=
 =?us-ascii?Q?z3O+bRkfAsoQdNLBkw+mVtZmkEjMoW3pe3BCQjwDGAJr8aoakhA+fz5lDzcf?=
 =?us-ascii?Q?lbCZKnB/gV1u73yDWhdy292x/k+2dT480sRHwSdl+jno/fgp6WTfgoT0qAXT?=
 =?us-ascii?Q?8XDpIwrt9S8uJgUmQnJsiFnFeXCJ2pONki7NIucmuZ4tKyLCF7ACWC+RuXzM?=
 =?us-ascii?Q?th3pa4OHwuLRaT1TL8QiIzikBd8xt5jVbuQTf9KDaQMv2URTOyeKBKTY2IRC?=
 =?us-ascii?Q?3K5dRmDFcMliYc/TXt53SC7Y4tQnZLE4ppYLjlUvqJT6pgsncRVLrdxFQ+ZV?=
 =?us-ascii?Q?ZuivkHPnqHdBsO0E5/eHmq+Vy3JFy9k86qLtOGg76DiHhSeO6R9zKm2lOIgZ?=
 =?us-ascii?Q?YAP943nLp5AN/PX0OFEIGV1zdFAlLNskZdY9gXEtNthzYX9K2gHJCodwowba?=
 =?us-ascii?Q?nWrklgj4RdoVqhZKIhEfa3cBirHotIoeikLkvN2OuMlAf0TvUE8pK4uL1jzw?=
 =?us-ascii?Q?iG45AIGVfnT2yKD8hMnWqHEelvLnTyNEycgVPLf7Qq7/733CWeyZWul+Ra8t?=
 =?us-ascii?Q?0CiWMRIpMPv+2yA0+p4CO2ixM6CkKcYvfMqVdONJ7byoRFEH2im15QQqVzAc?=
 =?us-ascii?Q?xdr3ieLQKBL0xLJ5gSBZjV5lVdGrlFKenFmrrFq2FfYUlbW+YnZ4E0CIj+9B?=
 =?us-ascii?Q?oL6fq80gh1f+kGAoSKoxA3vDMmr5B6xMGwY5R69hcIWQMMo4OMuG2E0upHvP?=
 =?us-ascii?Q?LIfFmeE3NOW8cc9VMsno12Wt7a82XaqholAKCDynkEN3oy7vw1o9xqcBrF68?=
 =?us-ascii?Q?3W6C3/3/WOUcBKdiOhdQjJk3xoZTc/dOX2yYbFpea6D3OO9JGD0qWRE3/coU?=
 =?us-ascii?Q?feTBE5AmJMn8HtzQX3AO0jJG5wEAMuIA/BMre/MP0HIeOASMhGfwBTmJh2s2?=
 =?us-ascii?Q?eYKYix0dDZkfy/hNZc63Q2e590RjGqWsnsoRD2vxs9GEm6XtUCfUGbbPn8nh?=
 =?us-ascii?Q?/6RXmk1cy7GHju0AKafAfCZ1BFt367kWrV/WcM33uEcRgmMc6+1WujEMvmTr?=
 =?us-ascii?Q?hC5KHPvIUtj3QH3d3fjpB/eFLEFoa3KO5M0VXaThzr7AyrH6tTe9O9auzlwG?=
 =?us-ascii?Q?JtZDU2cSaZuwyaufsBJ9koL4FjA6/6CdHVG+mZU1kJb0B0ABqEeiMGbxl5Tn?=
 =?us-ascii?Q?ZVyeSs24T3pkvvxNTnQJiNguMdlbktG1bX80CdDxGGVbrUapoDEPiBNjzX3z?=
 =?us-ascii?Q?0yiOwRGdoM7T8lHeK7S9iHdbA42CG24wWo9Wg4hfJKw+WWmw54nB7iEjAyfw?=
 =?us-ascii?Q?J5mlh10kPMMFSzmyaJYjQiNw7Ek29PlYNcyOmxpBR9rO59ZWZDcA1PxE85ol?=
 =?us-ascii?Q?kqou6N6nlCpm1+hvYkGC2zwP60FveX0X5hl1zc0v8bXsSCSQqo5g1mwnGByB?=
 =?us-ascii?Q?YDm8YSUnqU0/kkfUyIs1D+iuYkBSclkS+BNP/8pZkDEmuEITnSbyyOb4sCwy?=
 =?us-ascii?Q?d6Vu0pxUIqZ95Rc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFGbvTF5l+MMVrh2wgZqyoh7huWqN6tPp7nEINEdUSrCCFQBwdst+7LpilFg?=
 =?us-ascii?Q?FUjSXnTQWv/VE6BQ8VoGpA+Tyh5LgkXkjFxgay+i676kdQDfiXd1iEo2UcZ6?=
 =?us-ascii?Q?tMvu31A5u+jgJrAAz4n4f+jTc8ZiafGaK6L8AVHSFcoa/Vc1/uORlDOhaMt5?=
 =?us-ascii?Q?Iws0mNonxGmb2TwQPmsncVaJXgsLQn9m8aUnLrPKd48TforYGLyE2ADP7lpL?=
 =?us-ascii?Q?ykRMrc5ENzO7Pa7RdPZyxUJenVDVsVWI4GEgtseIuKy7Z/hLtYMIlKUpkWOF?=
 =?us-ascii?Q?LCGD7ufKxaw57WykL5OKU7Ha+ImrEI5FKKkRl05WPOoX6qll9JxXC5U0FbPP?=
 =?us-ascii?Q?TtQ1t1yG5RYsCa4Ff8tDNlNhfRsPO66WpKmgjtSRDye/nBdZDHOEMsm1YOoz?=
 =?us-ascii?Q?juUqmJWMeNpCsQ7gDD3cuOdBOn8lMxONlU7UJrA6u3hUuia3PQ3SDLn/0XWa?=
 =?us-ascii?Q?oBWaJisd55U7Vd9jJc9yok1jsRi7gS8ESv/Jw90otW2wGaCNq5lcx/HqjwC7?=
 =?us-ascii?Q?71vcjk9MZAI3Jo5nKCDmui86kQOBLlgDXABwhy6OeyDlVSkNWWSGk1yf+6Fk?=
 =?us-ascii?Q?a96xCx7jmDMBCPv0kxeFb0bBmZUQ/U8iigwMjA7PTzg+IYOEKShEXXNCvqer?=
 =?us-ascii?Q?YrVg9YtyCBs/903YTCR8z67mJwNQ+w2wkqjS3VCAA6QZb7SslojeuVUIWcKO?=
 =?us-ascii?Q?ZC70fBQwUJ9DCA7CEm6gXskNR80j81Onbhc0wi10JGrmZpn/23toBoaBFSjm?=
 =?us-ascii?Q?lmJkx7EP/4/HZv0/Mc5sA1WbQyzLajeLtnHsbv7oS8GA4BLLClJQRIfNwzVV?=
 =?us-ascii?Q?V7J4+TGkC/5xMO78/q0fy3Dmlw8DPDrClRp2AjRWXB8/AK38kaUo41CbWM5x?=
 =?us-ascii?Q?PnOx9ROdmMfSAXfIKXszTlQzdU49Qin0a3Rl5/EtDCUQRlj2Ab1svd35eJjF?=
 =?us-ascii?Q?XqzaISm5d1UzIk4Tgaz33MIFnSgdXQu8Sa6/sxPaZt7EpLINWgp9Pn4uSsmD?=
 =?us-ascii?Q?7N5X+pCu1si9IlRdhOjspZOjRs/aDmkwoGy+6z+KcJ5b8vaMCtAcS0dnDcy8?=
 =?us-ascii?Q?ISEJ1faAzrv4t81gBkpuV1C6+mDOmrOGZYfs1Rs7jPTVi3gn/+cIMPknECBQ?=
 =?us-ascii?Q?sdbAH8Bvmx/wgTUOtISaOkLC6zlV8fK7ciaWhDW28w/PCOSPeT71oVIT3KSw?=
 =?us-ascii?Q?RGjZ34jHGNAe4UPD/24Oh0zh0M4BfJ0ksKumU7RnVIvZbgf8GAMs/D1/oRPM?=
 =?us-ascii?Q?s8hKpI1vFHa/EKBAazWpkPUdlEuvI38cZi85exAO6OE3GuwzCgDWM9EySvQ4?=
 =?us-ascii?Q?5WZTkKrIPF2625+L4kZlIINhmhxRSl6hLgVYP30zagewuX/TIjpBo2PjqiBJ?=
 =?us-ascii?Q?U4OT+f6P+pc3YATcmE4V6pBqHT3V5VObWr/n9X6Bgf3JVEZW4RI1eCm2g/OV?=
 =?us-ascii?Q?DCAQtB+kP/6cgz7i2B0EgK9lrJKGmUDoryzhwmphrDQqcZrLz1NGIu1dQNiW?=
 =?us-ascii?Q?TRRr7R/CFh3OD6xEDjBEtdgd7JD8PTJDRZ5kw7VwX0q7SdlYVGAT29Cx+rjq?=
 =?us-ascii?Q?48KjA06AjWpeAnaA/jwxKfa7fnkZS+jXEN15xK+0O8NVz7u1Z564Q31Gqick?=
 =?us-ascii?Q?8pNYU7G1uemhCicEkOKRAhon7ef2pICdrdfXttYjtTV8MA5g5o5pwuEonUgB?=
 =?us-ascii?Q?J8eAxz44F9uOpiSM68jR53CVoEVSQ+mat2urpwZVfgF7jhbDFvFWLSO3KsaV?=
 =?us-ascii?Q?JEWVPiEfrg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nx/tSEFB/A8chlvr5nqESHroSEv1bOligR7eDaENdIUmZrqQ9EEbFDczb37ux+CdsEfoqmTSzfOfxJ7pZgysVFSpqvBBfBQWsC8vJCRv1UjVFYtV+lQCJpa9lBx+f5dsZBlq2x2EU4a9pU1mQIxTt48DqTQMyANEK0xp4iZyBnOSICpoqPflzEGt/BXB8jeIHjY0y3rLY4wUoklmfhcaKPMBmz2rFcWlV/PdgElrxhWHMD0q3vz5GRsgMuLi8TZsZbvHAJDaAGtN5A2h4F36akmNrnVCSc3pI+FGQ52TyBvuj6RWjtdfohGAZIH+vgrOTXgn8IAob95sFQ6c62W3OE5wzfuu+jlioEOHckLndETBGcRh4P8bAMgj7JKN9T0Y1gHK5ZdUhOlywFVyv0QMDQk2/6PSMZ3ipSDfXld3jaR4QFoGT0IKB16KIPsRO086NQmI2LNFyfJKwv2pRgCkHnrV5gtfBzXqzeVrb46cjprE6KdVqoByYOZ/ZYJc0zIPsI7y49265IQ+d6RW0XQuGC8rK3OE4/YV8aniM5wSLepW/L9fAw5GR+ZY/eYCv8rghwxe4xlYmU8MXJuDXML81a7vlghvQ1QurDjw81FpLBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e5a704-a28c-4a1b-6627-08de4dd0c70e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:40:22.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up4qbDl025nA0rwkMVa3lEgGO8O/XTn5VLJGOsiwyX+94k+RC6EKTAFI/u2CIjK9ETIWtlgj3pOp/L+b+DlTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070077
X-Proofpoint-GUID: ATZtOi1GuGsKR40Rh6LMhdDQcVBJXc0o
X-Authority-Analysis: v=2.4 cv=O8Y0fR9W c=1 sm=1 tr=0 ts=695e2aba cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Kep9LRqdJN2lsUto3TYA:9
X-Proofpoint-ORIG-GUID: ATZtOi1GuGsKR40Rh6LMhdDQcVBJXc0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3OCBTYWx0ZWRfX/CFBRmJ71BAL
 v64uau6jK1OB1tK/ZES4X/UcWuvaGWP06r8yRULbgBrV/bbgL/OtWL4z0BI5Ddl2nQXx6M1wGll
 evqnBIXdEO/Dmicf8okQ+3FJgFi6YbUgxMlhtey7v2Pt2dpL3Bh8orO42PFpMaXHDZkiI9EWa1p
 ws4eNTsPkSqiFiGMKyYV0sqAeIgSq5sB8uX7BOPfmstYTeCbl4dagUKRlZtrypenMfSRTv3Fpsu
 5pGadkuhRKpx2D9n6AIz7VAPtZaPXeEVGvkHkqySUDAct3Wr0UqWBDbI5Rp+Ce/zTm8O0KNdi/w
 Dr9j2pTA+Ny6cejbdrc6CljOKLfgMNfbujI9XBr/iXGwsBBkWXYT85mE5bPDOfxyGzOF5JiM3hN
 YRg7RpzmxaClMKVXhVJwypN0cHg2pEezVbi76bu5O9kM9c/qyFHKkJ7obdZ+NR8H6eP42NIwx6D
 LfrPAs6j7jBotMnrdNQ==

The definition of cpumask_of_node() in question is guarded by conflicting
CONFIG_NUMA and !CONFIG_NUMA checks, so remove it.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/asm-generic/topology.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 4dbe715be65b4..9865ba48c5b16 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -45,11 +45,7 @@
 #endif
 
 #ifndef cpumask_of_node
-  #ifdef CONFIG_NUMA
-    #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
-  #else
-    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
-  #endif
+#define cpumask_of_node(node)	((void)(node), cpu_online_mask)
 #endif
 #ifndef pcibus_to_node
 #define pcibus_to_node(bus)	((void)(bus), -1)
@@ -61,7 +57,7 @@
 				 cpumask_of_node(pcibus_to_node(bus)))
 #endif
 
-#endif	/* CONFIG_NUMA */
+#endif	/* !CONFIG_NUMA */
 
 #if !defined(CONFIG_NUMA) || !defined(CONFIG_HAVE_MEMORYLESS_NODES)
 
-- 
2.43.5


