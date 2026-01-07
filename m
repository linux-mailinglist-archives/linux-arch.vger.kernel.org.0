Return-Path: <linux-arch+bounces-15683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128CECFCFA5
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 10:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1F1301E1BE
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC830F540;
	Wed,  7 Jan 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzIZavyU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O2VnJyvw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA4308F23;
	Wed,  7 Jan 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778978; cv=fail; b=X0VNWWdY7R886Fi9sIVVWHMo8m0kxNiZYLDO37rVC/uv1Nv9u5Cw8yIOMeV9oWo7cyR0kUonvT+nr7R1w8MwIGxCzNuzCJdB7u7MuSQuTAsSoD2Dc+iYVjgu+sQDNuk8XvYgIUpgYBVMuJUYiiNJn/2KsbgWoLTs9H8VRrAT1Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778978; c=relaxed/simple;
	bh=AZQHgQX9tw1YByE8UxrPRDk7ZnWE4yg3NpKdVxrOcBE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XTYrM+eBnjsZqi43MdeF7ruLISDPtf4qiagnLICiQE46jHLJnJTDxRGRg4Af02LITy+mzmeGANVfdSw8IGyx5ZPo20B5d+Sej2222mAV49wtHvNOC2NDj6bMe1YVmcPSL/jNoMnW1+YCyBIRR3jONXcUKO6HPX6Q5iBM3DtO8vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzIZavyU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2VnJyvw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6076Kp5U1431651;
	Wed, 7 Jan 2026 09:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=bij1x5mStrbguULv
	LSyuAFUPixxcwW3R1+BBpljqrVI=; b=IzIZavyU1+iV8U+1WbSpvP5Tqtj7siyM
	LArkZUlBoxca77c/KcXMa0u2uFG6DQigtiek33ey3776/IK5BW8jylIA+6nrJwO4
	39hTVmJrXHMBafA/PZdzJxnOjPP8qMlT+82FJ4r5CJm5ehFWQ3tpMNB0lbo51fz/
	vf/jBoWM2hBSPy0CFRn40e3/9kiLVe5N85grq5Ac4/WAAklvSxj1dr3BS0MWazXw
	THRkGEQNtAzRgGD2w2VJhYajfShRnXH67Hy75CcIJF8D7hbL8XO+ZgB3GMdo61cC
	H3OU0AAY0ywMah/HPAPZtR1vQc6Sedzx2H1fZQs9+3fE3K+0uWNZXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhj4ug741-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:42:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6077ZiWo015545;
	Wed, 7 Jan 2026 09:40:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9dd9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQLVWKPulOyMo4OzkjeacYEbIuCErjwV8KyXMUaRaFCiP/yw3p1KSu9oHEttco/TS0qwPY/1af60/BDTGMfgswwTT8TXj0l9NjSnU3JtXQQKIXbLcuQGrGQzwuluqkcWgLDB3DtjTkSNFNOtcBOgzAN/DFYX5LGS03YZHtjKhKk2ToLlzypSpfjpqwaxkI3hoW3rRPifBrovEmSyT9aqlBeclnGTNs0G/JAT8SGloP1hv/AVM2ZWA7SSg3uj69Sn4KR6+jIKhXahzcJ7ZxBXQYTHKo6+3isPqTvH8UmMwFBAvkC6Xeg0SVIuq0EPOLeJ9krGGilgRumoXBjVillaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bij1x5mStrbguULvLSyuAFUPixxcwW3R1+BBpljqrVI=;
 b=ElJsjfutjzdrUbGLHGJPZxyR2zZh6By3P7trLNlLjegt9iKgU33HbJlzqYNWRcBDvamMrDJ3gPnGzU7tnzDJBND/l40Oko1JPOmh/kVVTU2B7MmaikhvXG4AQ9ZBB6mF6NL646Da587hk9GOjfEbtsSu7v1sybsAHtFoMFgjRY+Fv5LjRV/fAPfbrdMrf2fvsk+H5m0qM7JXO/Cj5+q8U9hX2hiinvkzHrbjtxM7MFfDy62pCGLFokDG8sbsbNh2ftzlYB0ibKtYD2Si6kITzbr0T1fh7eOAGiRj0q9W04zarAUTmi6uENBWVu5u2u3flEmHjL4L9b1m7GWWXtPAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bij1x5mStrbguULvLSyuAFUPixxcwW3R1+BBpljqrVI=;
 b=O2VnJyvwU+4+COHok9a7tygTqbSrgdPz22W9+n1zP3bhMaY+KVR2U/9ivFnLEoOQ4JrQWJ5ot+XINGT9zMXko1pwW+4oHltU+m2BmZHJedGtH0mhsgdm8WsyPGi1pjmfbHWnzP1T1OC1ta7YXfaHf6CfgNQXqbczDZTTMyUko14=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB7479.namprd10.prod.outlook.com
 (2603:10b6:8:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:40:20 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:40:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/4] Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Wed,  7 Jan 2026 09:40:03 +0000
Message-ID: <20260107094007.966496-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::21) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 4307f793-8a0a-4480-e9d7-08de4dd0c5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0Eh5/hOBQPYtZ19sqlNf7v1FYTulCasJLKgtcwijKeJ6ZX1fxfqfWmxfok5?=
 =?us-ascii?Q?FjG0z8ejfP/r2S6WXar9YZbjIEVgzFscp/Gd3+lWNNm17Qaa057TDLBcdn/5?=
 =?us-ascii?Q?UBdEhzFVZgL59DlbfRWQueP898Zvaw3svPvSYWvlxGUmKfLfCLM33XAWDfU3?=
 =?us-ascii?Q?JN1ZOh/I1zQ6cK3sepq0eL3apB7Lic7cmJoT2C0ukHGegG2m08szFdD2RPtd?=
 =?us-ascii?Q?rPogAbWVN7A1N+lwsuV786pBjvRPctxRFA0AT/x9+Wp7uwy44bNuLQKrEaTJ?=
 =?us-ascii?Q?6JLQD+u99Xc4Ed+i0ewlgu+kV49yQJbv2t4L9cDqK5l81MGBpRByrkBRMNzq?=
 =?us-ascii?Q?8idWgSOAR26JBHP/i6i38BSnaVHo14qEuvYOR2fN/YgSbEcrY33sKjGYRoRc?=
 =?us-ascii?Q?y7PR7lokqfFwWs3nkY9UR/tJJX0vrnqzQwVbC8wIpSEPsAHjRqmftKFkPte6?=
 =?us-ascii?Q?ZE/EYPz/JglYBWbgf0JFE2sj7JzAdxMHndBJf6+p+GsTO/GGdc+0aCl81dGv?=
 =?us-ascii?Q?55NW68L6jr9hVhmcHSAqLOn7TzNeMzQggC8EdxI/eL+qeX7LWPslXnDooTws?=
 =?us-ascii?Q?BMTkEibr/SkZdOan5J078Mq6pMkBr7sLlIvX60bVzpokFYXDaxJcNfKW8M/h?=
 =?us-ascii?Q?E1C+hQbncy5VbNj8N87GIqkPSbJ7r7kTyR2D9oFSGt6d+DBAs3ZjajxAvCQO?=
 =?us-ascii?Q?Ki0Y7LQKoaXif4ynyqm1wdxaTraA7dIAfCc/6CAiAqiQlg7dCW9TtBx+1k5o?=
 =?us-ascii?Q?BLkltp1qZsbY0w/QCEm4ODqz2xA0t22fiL6MHmfr0xyXebQ6Bp7mPFUrqZeJ?=
 =?us-ascii?Q?3DFk6EhP8Q4UhelWbvLXAEnz64jPVvxdiTbvh7vcWKUfhya7oNjO/pfnkaQQ?=
 =?us-ascii?Q?x+BA6aneAL+Q748ZKpyL0Ls2uw9CtkD3EK58RD1prQEEHNdXDUPP+ApDQo5B?=
 =?us-ascii?Q?Cf/qyJ/K6BPJFiwa5AaavmhSy4VCfuzoqFTB6xcBb+oZ2obSrtWAmQySauuy?=
 =?us-ascii?Q?HvkP5KUIhndO88zSq+7URgQhxhbOH2wxEbQ8VACprGEz+L5I8bdSTAG2jyaG?=
 =?us-ascii?Q?Z41M3bU8cTwFjhlyLmmyshLvltlvVXrIoNvSgMX4oasD7/VelaACNCEz/Qbs?=
 =?us-ascii?Q?TKSQmKn/Jcqq8+XhRZSp9/3VM9/gfOdSk2SHfRENESC1MsNzSM3ZPomS9ZKE?=
 =?us-ascii?Q?UMZ9fjhrRLpqwwdBeJ5DdClfbJBW0mKmB49OsDFoEHO0e+bO7yWx1mNxgY6O?=
 =?us-ascii?Q?KwCamLfFpW1FuEtLC+87YiqEvRdZNW3QiPsQFqjKp9EsGSQBfxZeXxfE+KCh?=
 =?us-ascii?Q?YiPUJrcIq0jHd/eQf6JDYJThJalQUezdHdmm4YynJfffGJr/SATzMTz/tsaj?=
 =?us-ascii?Q?M1/YCKyEcX1jucbe57gOjzKwasAX03Izz/92ATxoIq4vjf+hi8qDBdvRVc2U?=
 =?us-ascii?Q?CcPiRh+JCXfS8x9ijFF4Tq2CtFsD037E0UPY7O4kOgt+J3vvjQFEHfjQ5HdO?=
 =?us-ascii?Q?4FOM87McAArLDvwmJz7v4UJ2zU2FPwevaAwm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7cuzIZvsxXQ4nqbiNB47N5zw1wPhtMHk7+xJXvavrqrmx81UV/KtXgtPiHG?=
 =?us-ascii?Q?bBwET1hxJPAYBRyzLy+BItyJmrJ3dN+D2k2mAFoec4udHG/nazdImpfFda/M?=
 =?us-ascii?Q?GPDfzr/GovY25fWW2sqq89sja3jPd4Nqu+2ok1qDU4TCErbH/6Iwgw7mLrUm?=
 =?us-ascii?Q?fXwpRpF6la3Ydsaa1+8WSdfsqtUHgUxEHY7f0VFc56Gqca1bBcw6BlkWpv/D?=
 =?us-ascii?Q?NgxcsW5jeK6uajQoq43kODk+o6FL+wYVoyRQfIWjbQVPijl+TuI71e2ZUzSH?=
 =?us-ascii?Q?/s47X8YNhQrcP1hiMVHx4L0zGjnpo9S8XXJ9hbwe9GmlLutJDeosQqT07hBT?=
 =?us-ascii?Q?3gtT/KomDG5zDg0Fba4uvNoC/VgwfYMsn7WloTFgPjjJKpkQ5MwV/0vpT+NB?=
 =?us-ascii?Q?Ubxm10IFyoVOh+3O4WpPRShTmadNwLec6jxiKjfiP28jNghhMseAD6deZFi1?=
 =?us-ascii?Q?nxP3FamkIHc9ynrFfz36Lrm6csTS8eeBprcRaWvRX3GICUZrlGCBdMIdRFOH?=
 =?us-ascii?Q?xHVnwTVqXMr7mAx4CdssskSgN81j6G8zdzIprz4jYoyc3FiJI5+3ziXa8r63?=
 =?us-ascii?Q?nYEO7YIlIGEM35TIbT0Z2iN6tbzhoQC9F6YhrGkBA42J4ZB9/GT/5leVXBmH?=
 =?us-ascii?Q?ujoBbFDWwl9e+Xjfq/vKWvQDOoievF/zIrVxKHZtMLuLYU1kCt5egwZKqXLQ?=
 =?us-ascii?Q?gRg84XlGnC7zNUrJH9ISqORgx8BHvgfc/XTitxS0ry4RTxXdf7x0dQcOofsx?=
 =?us-ascii?Q?YQhX3snu1jHKZFI+6Lz/GrHFYRJPBb2uojVNQQ3PLnwVP50oUmNmVkEV3bO5?=
 =?us-ascii?Q?/0D2Gh7SLepPVOo1Ue6389IWRsBI9/5rBjHGKapbBRKM/hwgj3R7Kz05yzWO?=
 =?us-ascii?Q?/5tvY8yzfCgKeo1Olb8Wf9N/oe7A/4iIgd0FD1kSvGugNupFbmqJ65sDW3AU?=
 =?us-ascii?Q?zhT7O3odDUteAcjMN0FVnJsg983mU4/fGh0VFDwCgP7NB9jrYobnQv00DAVQ?=
 =?us-ascii?Q?VJ7DjJPVGnAHGid/4S56wxQ4LSWsGbGADcG49+EMM+hRmIJszbEFWvOJwnGG?=
 =?us-ascii?Q?QrdgOBdDDQwZ4TtX8l9wrAS9b2F1ljXFgiRKwKuOw8ztKtqZQ4rtxagthhsD?=
 =?us-ascii?Q?S+b3C74PxZNR6AP51LlGlRgwmhjXYvXhYW2HQy8hdrNT2FcL3akBnV8pvN1n?=
 =?us-ascii?Q?euSIOQzb16s8b+HbUvUwfJFxz1DlcBf7hcx9DCxZX8cCOaQy+4SzfNzFMqha?=
 =?us-ascii?Q?O/Hu5Y2Qgjdm+7cUxYUUzpaLSjpoXDr+uMOoMuWn88ZKu95C4WZoKZXgH0Dy?=
 =?us-ascii?Q?saC6y+gS9luQbqnOD/7/Nrns1fa/LNfHVA0K6YdSn/hqSWNA8sDUyHs+FZq8?=
 =?us-ascii?Q?LLGzYyDT5P3WtgRa9ieERr313FaZ8TUbjqAMTGJ2K4pP4PW5DyfOGzVctx4Y?=
 =?us-ascii?Q?uNuhsqiHWFWiEvffNZG/qzsHTAojxTKqjRVsznI8PgtwUddDjSpQY4LSBs3v?=
 =?us-ascii?Q?docuYzmS50tIN3UX2HdL8TTHrquWyLZrns3QQXOdBCUdD9IDyEe3SNMyP6UH?=
 =?us-ascii?Q?vy1bzgEHKlZ8qCtkDE6e0932iKc1QRj7Ox2xxQ8dVPiXb1T0IXbq/AG1NDrD?=
 =?us-ascii?Q?c/LGWaRaDwFv0Mr3V/HLL0TSHO09x9s0eD0RCUay2y2JwO2hNN69ukkWQXPX?=
 =?us-ascii?Q?e7CyLS/hYXuTmKOYxU6oKrdXGaLffXhHQjgGa9J2OoIAcuNjPkwhN9SGvt/g?=
 =?us-ascii?Q?lzg8tkApSg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7JmVu1RF8WPtAcwC/Amz087Gl86RTGykdx6cI7if/H7vPiOcaVxJ/cFAoc5G10sh68ySiANysgArgVzYynHIdKepDbmscjfY2sZU6sEYk0fi9lwI+A65RendkV0gvw0AJqtB5aN1c9bkaxII6eYvXmZDduE4l/qvBVVH9YCjlDKNcfnzD8iOAySnw9M6cJrEt6HJBwQzox+G2p5p7gbn6WBWr45zFzyfiTqT+pAITLndJfLa5XoIG2d3G1tjDrF551By68oKFcKnLldxgaZURBkr8ji/ir0+AQ5QTbj4n2B2B2rmDvBm06rbg6IAMJ2KfvJonjQfvV3sVj0h/7lCPTQbKyOlJnFVh6Ss/iRxbzhWWqfFyoApCMCKot30OdHZXo6xoTrQD+RHrLT7wIILYxPWTsKJMG/KZAw9JygZiEiHx63koNOmxjcmSQn8fuMfiLCD6jkAvwL5bTxbqwP1LXfuUxOyQDXurIUotnEV4xqQigZYv3iDC+XbgHpbKwtZvf+cIc6qIf2xLKlfzi3Dhp59zObs3F9MQbGcRd+Q+MXbBNaOsbfv8NubIszmsMHQIPpWVm9cqy/EHYNkmZfjQnqajd+sMDUimA3RDwgUg9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4307f793-8a0a-4480-e9d7-08de4dd0c5e4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:40:20.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwLl4RmZLZMc2PCFk3hewFJP+OjNwyvPJQMkeNt8INkcHAqoUMXAW4mwCShYLCn1OLD34NDyee7lsPaat9cHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3OCBTYWx0ZWRfX0CowO6KLzBjN
 Q9V2PsXpm3H38FqyRkMOU9L5RZhaLXTCA9knavPUmmTk3YByiGJOvBgykrJxq9yMX2aKomW+smL
 0dDbBtJ0vAdOuFP/OOXblRNX7smNmIlyZHf1f4YKxU2KKrNkbCeeato7cqPi6HPEWIPb6t1qRg2
 x+TGZhA5yDemg8lmfrkBFOytDtul3kUhqntyr0RKnU6yBwjLdDBQ33l6nXVn/bMGcB5ijwHPuDq
 1YYuezNHnNbqxfhCZbI5B/jA7+1qVIHmqKfDjl51mX2EWJrbwEAITDInw1mMYqMsgGpMRzG3VE0
 ytF52AX4fAG0AZkwMeB3Obsedy1aZFCbu1nlh1qhXk3SZfuqW7mVTOvNE9CMW/C0LlPodFJjgpe
 VtakVQmM4FGItkMhKgCtDhKt+t4vD94EYDXRZb3roshMG+VtAZOYgNZ3PnTGj2PrDGkgXwqY/dV
 fI5INTp/73XU+Bsck1A==
X-Proofpoint-GUID: MjX7BIK80NKhDYh4GP6h2BOpUn3Z_Jx8
X-Proofpoint-ORIG-GUID: MjX7BIK80NKhDYh4GP6h2BOpUn3Z_Jx8
X-Authority-Analysis: v=2.4 cv=WP5yn3sR c=1 sm=1 tr=0 ts=695e2a80 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=PYnjg3YJAAAA:8 a=eZ1SEBxhpaY0cYSqAbIA:9

This series aims to remedy an issue that not all per-arch versions of
cpumask_of_node() are robust against NUMA_NO_NODE.

In my view, cpumask_of_node() should be able to handle NUMA_NO_NODE. This
is because NUMA_NO_NODE is a valid index from the following flow, where
the device NUMA node is not set (from default):

device_initialize(dev)
	set_dev_node(dev, NUMA_NO_NODE);

mask = cpumask_of_node(dev_to_node(dev));

The CONFIG_DEBUG_PER_CPU_MAPS=n x86 version cpumask_of_node() would
produce an array out-of-index issue (when passed NUMA_NO_NODE), which I
think is attempted to be worked around here:
https://lore.kernel.org/linux-scsi/cf0f9085-6c87-4dd5-9114-925723e68495@oracle.com/T/#mdedb68052e419b4bfca9ce45bb33b58988018945

I also see a CVE which also looks related:
https://nvd.nist.gov/vuln/detail/cve-2024-39277

Each per-arch version could be picked up separately, as can the
asm-generic change.

Differences to v1:
- Put mips and loongarch definition on a single line (Huacai)

John Garry (4):
  include/asm-generic/topology.h: Remove unused definition of
    cpumask_of_node()
  LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
  MIPS: Loongson: Make cpumask_of_node() robust against NUMA_NO_NODE
  x86/cpu/topology: Make cpumask_of_node() robust against NUMA_NO_NODE

 arch/loongarch/include/asm/topology.h            | 2 +-
 arch/mips/include/asm/mach-loongson64/topology.h | 2 +-
 arch/x86/include/asm/topology.h                  | 2 ++
 arch/x86/mm/numa.c                               | 2 ++
 include/asm-generic/topology.h                   | 8 ++------
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.43.5


