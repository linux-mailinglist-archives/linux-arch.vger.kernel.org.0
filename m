Return-Path: <linux-arch+bounces-14170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B85BE4BAF
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3813619C4A2E
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90079393DE0;
	Thu, 16 Oct 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECArqePX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nJccV1fv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B91393DD2;
	Thu, 16 Oct 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633868; cv=fail; b=ZoR8T2Cdxw4BmNaZj1I+zUqbt0Mit8SGiFMrBtD+0vLLw6ZSkAaeOnGR2MvpCLdAX1LD/YbORHMWXt+jyN7MoNFGHsU207FI1WD5ASSoJtqfCBP7ODMx5HJBOPdXlTWwY6CIBNC24Svh05fLWOlvjo0a4ft2ZDcKS3qZf/TetHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633868; c=relaxed/simple;
	bh=vfFsIycUXREY852gM/23KxQQeiqpGCaB579oQTF+ENA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TaxdpY6Rz368o4KhqIodeVprKXjgCPVnvVd2ZW+CVgoFRdku34xa1gcbXMyor9oBHVUpMU/rBQcx1wUuEW5dkEIlsVwAaL/bo8ZjlLthMSonja5bNXbuUoccur7sF9LrcErPuLWIg3cAGRW4fpqPZWEX/4HqCRc5MmYauKp7p68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ECArqePX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nJccV1fv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVJ83018284;
	Thu, 16 Oct 2025 16:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EMJIJGzdOjU4NxdGOkAIAjTqHPL10UujZ77myi1Y7Tg=; b=
	ECArqePXvy191g94Hs8ZuWqx6QLufpnhkW01rlZWQ9zKbtfFHUNLn4jP7LmP1MBO
	9XGMsbwPMa+7WJ1Sszso6b2KIEoAoCVmVt1s9fiHf27nNeHj52uvv3TNfu57lt3w
	Em1r/PRQDIDjdcklyZJatoTpBW6SJGRky6OjLDVFE+oYjopDbZazSxqVPT5PP+xV
	GK7kWdm+aCMYZGL4uC2zvBeowXjmk7JX0nlnncntKbkSNOribpclZK4FDp+1L+Bs
	COVYQWNz4xDRV4Vp+TWY2uaeyQEClvFvvdYpV3qDBNfPYNjzaT5eK5exqlXoLi4R
	3GXKg+8NJ50T74FPMfQQgA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtysdu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFOOVl000668;
	Thu, 16 Oct 2025 16:57:08 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpby3pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgkxc1c70lNpStx4cAosCjvLDrXKiegJcmr7lsM0i7ykN4b6OguOhTLve2BPNHIfN7Gwu+WIdEw0BAqCqSm6HQ52bpTN8NoPSubir3uCB7tD4PsC66O4BsH1reGuYU9y2OtodUv9+Mbsceyue2aztRYf/luMuQJrS4eChcMeBbOx98aOuHXqseS/7hB69X0Bh1aaN9S+mT9EFDmfPWLk/jRfWRZvhQpquh63dPb8Hhdi/9R2kBK9OflirE3NEnX36kjDn+zYbag1bCpEgAlO9xKCpUkpoQZYWhcom5FPxYe7xiGiwj6wEZGsU1MYUSqEKtdZBAzclntMZ2b03C8o5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMJIJGzdOjU4NxdGOkAIAjTqHPL10UujZ77myi1Y7Tg=;
 b=BuxfUK+kA/xXR27wG2aFQ6q0BdZcwu4zw0JafAXMTIMAiw6FWF6FskIBT/zH95pzMM0r5kMR3m+Dsb8lf+k7+YK3OSFIp6uEQ+2Cm2UtN5RxboQYjGxuksVfw+8+OHXA1/WGXjDkRTmXKoJaFwmt+SVeu/P78sa8tD6GdN1eR86ejwd/4ZNRDyhO7PoS/qGgGc7g9rs5ledKhgKocEyrYxvdQizUdIwctFBLjR1iFUV+FGT9gTgXFHLu/fOERdhnnKFIAhz4PlL36pFrRcGzx2INZWxmFC1Z2yq2rAIw/uuXSdL+8cRSyM4OBpq/ppGtL730UdOg3Ys94goiDFR3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMJIJGzdOjU4NxdGOkAIAjTqHPL10UujZ77myi1Y7Tg=;
 b=nJccV1fv+g1rC1yxniW8hQ0XYmQ54ufJA1/xEfUt1qPd7aHhpyej+kJYvl0sdwdwWECUUl8nMY7riOltIijUS5vGvp4nqXx8g0hGJvHPn8W9QUptYZiEHZhD8JJywbQ4S6jOt2mDwePLJiAdkTihE0uWBXcqQRIIPadalVcaE+k=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:57:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:57:02 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 7/7] cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()
Date: Thu, 16 Oct 2025 09:56:46 -0700
Message-Id: <20251016165646.430267-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d4ba20-3090-4c78-c6bd-08de0cd50781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zhqh780TJWnmN+KQmM7BIr82ZvJ4VPTb2lE+vNpJQtLEiXp7vFB1sRaVZ518?=
 =?us-ascii?Q?OHOFju2oEPsI8d4dWq1hCF9RO7YA1Ev3avyrcZ933SgqKmTJmILKvQkBeQJH?=
 =?us-ascii?Q?jr3IhDsZbZW8G31g0zBYAoqzOtfcl2pzt/wOhketx1fLbXw2zXht2OznE132?=
 =?us-ascii?Q?RpEuNvMgKsUAcxvyLZwlH3bf3NEa+VPHTwWvFdDufTeOr/lbIFAhctEaLZpn?=
 =?us-ascii?Q?gEZKsPHk7SQfRoh3/ObXLQhLfTvASIpJJIZpE/kKYY5jRvEDmrFJY63wnD90?=
 =?us-ascii?Q?Unhzs7iRAtd08RL8Y9MLH24U298yZNDdDVi/TIoCDc4IIkyaWia7e+Dm8SC3?=
 =?us-ascii?Q?z9jJ8+rt1pq7DyRVZfsnCJ7c0K2vYZUhtb4+diH4o5MYIWj2cRXnw09wSGrA?=
 =?us-ascii?Q?X05xVMB1GYkXlbrVFMGj6ZWprgcImZvks5TSqNwZTrG41LiQKqsaNjBkYhjn?=
 =?us-ascii?Q?PWArfOmVfwL4RPwot3PflS6ut6Z3kOAOiMczFnZmrp+XLD6u9LfM0XAaosxV?=
 =?us-ascii?Q?ks8zCL5PT5r5kkibYVtTZ1ZDeNCzqxHUkOsezgcYSjpwbWlkg6vdlcU+WEip?=
 =?us-ascii?Q?QRKbYlRX5HihvY1woHJuU5+CVGA2xT6NcHfgGUw2H7c3rIT4+C83FmXKmF1b?=
 =?us-ascii?Q?l0CFfyWl9Q9bh9RJ3DxJ2Cn7IdVdQseJZHqfSqgCB74BHvrORMRAZ51TRasD?=
 =?us-ascii?Q?xgqcTeXwVvVZ4J3+Hfm1NzHrhutANzAJstyYOfLObOT9TkgnTwGceUxUPpHh?=
 =?us-ascii?Q?ZIMxNPAzr7ClZjqYdtySMXsuprhA5QDdwfoDlmkG3PfCAj3n/BzZb5wdVMQr?=
 =?us-ascii?Q?6Twykw7qkj/r+ASh0Fh7q3sNk/W3XeAjzbPDj2LMBlKpAfDpJqs6H6mz0mN8?=
 =?us-ascii?Q?QGgYpIp4Z4RohdxNcnROAM4W7m3CSgmkAvQT+3O4hHxAm5cr4IVFfxsChNT2?=
 =?us-ascii?Q?OVwbwszkqCGKZMdFxp+vzV4Rt2uM0lskKZ71AWkjwaTL98SO1MuyPWbDPePT?=
 =?us-ascii?Q?krkmEhSRKzlTUlwSwb9CGMkf9scjnET2jVl2tgW7AWG33tCrvMkpSQta0nX+?=
 =?us-ascii?Q?ecA4sypOn0WbdTP1Adk5N1uLG3YbOkKadH8yvfHbOWjPZGgNSd1g5XkigDpI?=
 =?us-ascii?Q?s4NVd7nx5dJeK4FcjSMQGVy8QzfoY8mA9laf8gsBSsvgf/3jDOa4n+DJqqmQ?=
 =?us-ascii?Q?VBTDyJ9HTtuTznwBbGe8f/PwVepMvoKfXI9+xwim6G7TksSbNFaxNkKEsu08?=
 =?us-ascii?Q?+UvLbNq3o7klshAG67C2v8WCDog5DpzSDR1Jxcvo55IH4BDKVtVpJTizs2JE?=
 =?us-ascii?Q?82Z3KX2NG85nVJORhFBoWKs++bE8qrlmQmcbbvHmT9G42tKDQe0uBepTCspS?=
 =?us-ascii?Q?mJseSTOYqkMiJjf4ThdvGgUNQjZVR/9mAbfXpAHMUQFl/p6mOVQCGmu94+vU?=
 =?us-ascii?Q?ig/WBNPvVIjGYiPDJ3RFhrZ4/teKaCVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odsCHriFsE1+opIebj3lEnDIUrG0mIlSY50xqA/b/0Z5k8Fp643BP/lhqqH0?=
 =?us-ascii?Q?BhFiiKK76qeMw7iqJsGCeAIx8azJ9SfqkAE4cNy7HElAokzLK5y6U8BKACtD?=
 =?us-ascii?Q?fq1d1C6hh4DlGosxMA2suOI8KB1VMrdEwdR0RGhonpA2GcWMriIORhgWQAj9?=
 =?us-ascii?Q?hNZN+kgmXbb8D3tw3zBj2hxgZouRjaqvKm2IVWPFLHbrSpX+S7Rizca+78gH?=
 =?us-ascii?Q?KLC5BkVeBc0Ed31m1TPe03JDnC2r9dfDmP9hVXrrQym80/MfX9j+c20ZcwHM?=
 =?us-ascii?Q?bz5pJjUvxzbo4+ra0E/LaOCrahzRpI33bbatxnVxZ24217fx5SLDOJQ1Q3bV?=
 =?us-ascii?Q?QKVPGcEXi74G9VEVk4HmZ3JZLlOwt8C0oegokreSqMZH2WiA7vvfBBYPHdG0?=
 =?us-ascii?Q?Dz34lR0ISH8q47R04WXy1azyXVPiivrEGDGf3TxWIZlTJIL17iQ8fmWVvl+T?=
 =?us-ascii?Q?k4qpjd7cbPi9awq4xVsKUJBYVpUl6jp1dxJfhEleu88ZSHqGhsdYcTOP/SoK?=
 =?us-ascii?Q?GBXd1a3uQu00j+UyN+dQVNvJdPN2wAttB9g6qNtvKasYtI3DpxVwFv6qRo4x?=
 =?us-ascii?Q?x1XHzIAHtOZdXBug9o+TeL3xxP4phXcsDBvkAgkV1K1+0pmUnHzRsKglTLhr?=
 =?us-ascii?Q?BWSrCMM9XBk9fOG4y7Szbk3Tsq//sRpdLfZpr3c6kSgok8qacah7gPLt8uaD?=
 =?us-ascii?Q?1LfrGVpy4fFTjZWYlX92dar+meS4QOIwIPGJqnYTAjajB08OAjKIvnELixeF?=
 =?us-ascii?Q?bcF8jF9yUMWhQ1qmLFncjAbYQqo8PTfbORCLP/cYoWc4P62GmyuHG/F5uzXo?=
 =?us-ascii?Q?JtoIi4iK0fqxe097Y8d/CQTDoe6AO9BKh1fx34vCadXBjM81p9fczfzkMyUg?=
 =?us-ascii?Q?MJAi0+6P254qfaqJly19UNzDNN8nTuzsyu5jTaOwuCqoHaC/5gpL+WBBIwdi?=
 =?us-ascii?Q?voEUlfK8OKFGCvCAGN168MchJBgkdHyHiQuUDvsCN//jAgG8AFEIiAj+jmCS?=
 =?us-ascii?Q?bRGS5Yzh9z5LdLzLrcuM3joee30F/y1XuMLrklOU59TumJRs7Zf4nMMrxRmT?=
 =?us-ascii?Q?X6V58ps+u9SZOsOChg8kBZLQzILiqTWI6NsI7yAtolDhHS8xBQ2oFAnC4rP4?=
 =?us-ascii?Q?tTDizpF00Q3t9/DH8gXjJWpLICE/AF0JKmsTym8/EngigdxTDFvOzGYOq+o1?=
 =?us-ascii?Q?QVVPU4kqmGQOVqdtnSaRCpcSksxMfyUew8lkZDlhqumjoo4NBIIWkZb06qr4?=
 =?us-ascii?Q?Ug0y3mFZZlXyEuf4Nz6lIOzU0/KYEUrcat8mmLadJ8suDUOM2lt+lmQ2N9Um?=
 =?us-ascii?Q?IUAk2Sgvuy7mhtOqoqp+rZ7PpgMaDe/C25uhF400BnovB7zJpCcT3eyWIkrY?=
 =?us-ascii?Q?BMA0YLjgqhskxxmUmwouf3TdJqtXvng2Co200FZptV/8U26fZCRVWaiA6V76?=
 =?us-ascii?Q?XMbnCTMHhcuMKPFlqu6KM+WTqF+GWO6IrahL7I/kBdXCQFh8UepoVUdyUYBm?=
 =?us-ascii?Q?rRsn42QQyXfpe6Tz6BoyH3yoVNwZgyoPyc/t4Bxtiq4wi5LZ5hr1e3twMBDF?=
 =?us-ascii?Q?qfS/rzvMf1amIVKcThkhYP3OQdGaNgCLnIFYlu5KER122E9XnvM/Y1/TqkHx?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/47/z93mSYn2qInXwQ85hIGUpav8i1FjwOkPchQg69Krx1o+6DlRsU6Q8x4bmSCtscb5Oy1JH7WrMYgAk5IxvhHh01xg/0HJaonCovICOCnhZsHT652SGXQQDf5YA+3nfmp3tX3qOOqvgx8xMyMjXD7qKhgrkbLSJ+g1WwbFhveRRiUzbFIjvF2B+zT1cSZ4E0+ItAruHv5kYHwHujZN8MYxHGN2uYGnsuIBiU8PEh5f46n3MCYYE5WCsVndxvFVbxtn9frU2vIeNR9mWQYNzbu6V0Jq59N1nvBZuWpRf9BsZPqQ7zjIzpDMR6cvWYc0HKQOvg6nRAI17tr9gUgtwRwZcl21UvvSntAwgHf+giE+4ogiLyEJz1P1PXO6H1Aeqica9nkjZeJ2plzmEw1OGTBMOfzhmHKCjBA/xw1TasQFOEOW0G+6y9IZi/fQe/+mpQBUoeiGJ9o/dfrs7mipAS4UvouUHWWhEyy7SEHVqTV0eyxycOmS/HN0y+X4zXOjdiYBtSHVVshjC4jExThpMpxcLtLU5uyYCH5Lhyavvhi7Yul/PfxQyu3C3L9c2tqHLjvDAcYclDpM/T4WTrb1x9iwZdkT5r5vx0o4bteG2nc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d4ba20-3090-4c78-c6bd-08de0cd50781
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:57:02.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS68IKFBW6+6v7sY62H1cdHh0IYvEeEVyqQBjnpyzts4XI1Xz+TpqpHnS3JNzIMSkUeLX2EuuIgELSgcAYCDaEpD7AiZlrW2RPNQnWuLxTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510160122
X-Proofpoint-GUID: USwSCPoTQhiYGiRfBYfCTDv0b2G1stvP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfXzJd1rIsjpqwJ
 +xQIDPLNQpIa8sEF7zj9KXSQkeEOKvjMsmn+iiCzpeGc67+9JlQU/TVdo8hlPhniABU6ZpZlYLi
 t9XcJOqeKr3CxyFd9qW0HyuuwbCKa/EmvN/5I2kEivjEKQW/AAsGYfkEMWcyBo6VjeimsP0ELp6
 JABIiiTClk+6YHcT3Vih/Zvzkg5LWUhjzvJq5byI7WybPj2a5NCIzHSQSs0n9JPAlwtTu6ZkW5O
 pA9FOkcRXvKmoyvDdzSNpSp2ZwNMgUSAgpIr8JYmv09WUmPj3Yn8EYW+/3AOqKf0zCHfiIBsUrX
 8nM6dcPB1ZyZmSmVojZTrlYQAOr9/wo4ptZeK91RcqUu/zHyQoFJkXGcAn3Bs4XThzrVuAEoI+G
 CyWUAnYEeX3uzA3zhDL9nKZRkV7PVA==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f123e4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=M3kmbseIx2tHGidxfxIA:9 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: USwSCPoTQhiYGiRfBYfCTDv0b2G1stvP

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is done only intermittently (once every
POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

This is close to what smp_cond_load_relaxed_timeout() provides. So,
restructure the loop and fold the loop condition and the timeout check
in smp_cond_load_relaxed_timeout().

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..72d048c8ae7f 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -8,36 +8,23 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
+	u64 time_end;
+	u32 flags = 0;
 
 	dev->poll_time_limit = false;
 
+	time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
+
 	raw_local_irq_enable();
-	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
+	if (!current_set_polling_and_test())
+		flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+						      (VAL & _TIF_NEED_RESCHED),
+						      (local_clock_noinstr() >= time_end));
+	dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
 
-		limit = cpuidle_poll_time(drv, dev);
-
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
-	}
 	raw_local_irq_disable();
 
 	current_clr_polling();
-- 
2.43.5


