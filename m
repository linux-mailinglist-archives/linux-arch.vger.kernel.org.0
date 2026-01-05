Return-Path: <linux-arch+bounces-15653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB5CF2E7E
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 11:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B100B300DB83
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899A2F4A1B;
	Mon,  5 Jan 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="baxOha27";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ARqMKLP2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CE2F3C1D;
	Mon,  5 Jan 2026 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607644; cv=fail; b=fl+Sla47kpZWmNNO42pfyiHglGJjSb8jjuyEYgzTX8EmPE0Rd66+wfjEVH2qYq1ThdofKgN/exTKaYPZBT8qzn0GIm9lMN69ZG8NPLVO5nF3Lg/Nz/MVrIwZbYU+Ds+NrLkq4Ngh7Za4YD/T9zuOw9K7eWP75okJO5JNWONLWeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607644; c=relaxed/simple;
	bh=mEuqy627ecY1utJ+nAQqSGOQ1iaeCQTMpKHHOWAPg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7httCBkO/fyoUSxSMWcKl7AWX1Mh8w1GSYlbw57r3tZaaFboIpx0iMYbCWtvWuf+INBYIfQ91og5672guqPFtcLkjAX8cNm/iIaf2vUpmV0urGsB4oDYztOAM0PB7cIx7BNOH5Fjy+R8vpYtcm8N1fzSWm9+jf0EFX13MDplwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=baxOha27; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ARqMKLP2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NZ2oR151566;
	Mon, 5 Jan 2026 10:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lG4YEcZQWwMfEr5/+P7+4kN+GCE5HCls7v32tQnemjE=; b=
	baxOha279ibNWiuV/U0vXTCKjxQ6GaK2Pa0P9S76LzWiHP8WlXak6ya3t2+KFZeZ
	DzeBs/bzFGadoCh/4KLNzoH3hI5ck7X9OC6ZtkjrqXIIj167mJTXD98IZDamGxmr
	AzFL1vAEWL+x1uqBEEUcDkPm1cfGSuqg9/kgN5x2ANKzFyz89VaVB6lu3GgkCffV
	BzsKTpZ6PZFF3u7NzyrGH2B9zOB5QjfysThsni18ftnK885ftSn2hXew9as7lUhL
	4Hb1JOqe4TrPdnZ1GjNn6E+flUwRT7l48m40fqXIICy0v4gUkUFPqwOZXlFfnm6o
	9oSTww9YY2UrJa3xB+jkpA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37sgej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6059SNjU033958;
	Mon, 5 Jan 2026 10:06:35 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj775ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFPQ5PmtOHENoSepWFfRPkw8jKoSs1gg/X2O6mSgxOTMD5lDYoNQhpWLIJ5rKdG5pvbJ4GlSoChXLxXTiZjMszBCzBFQrvdHvM+AgDUzxGvsgCExG+xWIqOJomUd/rPJ9K4CVKBTyKpwluogI6YaZwZlrCYAiHb36bvWfC2sfSNYVSzgcxzLu1sBMHoj6kwVamX8oc7EvyYyCNcs+c4s700vPrxchrc5JooQmGNfBl6vKkPF6v69vXN0cKZ9h+sDsah2an7GAH7S/QAntCFjEZ753LRyvEG1rsMvU2wWYAY3FfnvDbespXdiP+98MgPn5xeZKAatqdHnG8zp8zIi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG4YEcZQWwMfEr5/+P7+4kN+GCE5HCls7v32tQnemjE=;
 b=UV9z7DGQwPUNeZ97ebe38kOQOos6S1m2lTW3Q7pML37BFAirr3YH7yWiFj/e7RuvetFglYrGN7+aWZj0SHXv/Fb9gyiXdEHGPCuNEGbkmeCNm1PNKQ7SONYRTTpsX2YxmZ5mqoV0HmN8oGrR2VvFlgIqdnk41M7g7KaTgHSOm0XJdg+Q3rEWDhw5enVranearYAwnDrVqIWpY5eTKXE3HzWWdD0Yf7qGft0ZdHrtUlsKVaAQ9Mwka9hgVpngcLT0pRFZ/1eE4+CyHwMAXWpTg9ak3Fnc0DmnQCpH5+XGdlDC0UakcbXtLbBTxECSKaG4/mZMBoLPlLpExPYhYINHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG4YEcZQWwMfEr5/+P7+4kN+GCE5HCls7v32tQnemjE=;
 b=ARqMKLP2RtPC8CxwLeT6xI96K4/6OvSrvv4TRQF1TTFmRkKaigTD8LH3Z5LIMZ49mn2uD9CsATjqabzYveeDRCD9quEPx8EdouFVei/qBIHDBB3Rk4nRbawGPSjcYuv3Tke2kcqNC2ZI0dOChmlu103tzLxhZBaOPat6WpFbjoc=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH4PR10MB8076.namprd10.prod.outlook.com
 (2603:10b6:610:247::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:06:33 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:06:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/4] include/asm-generic/topology.h: Remove unused definition of cpumask_of_node()
Date: Mon,  5 Jan 2026 10:05:44 +0000
Message-ID: <20260105100547.287332-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260105100547.287332-1-john.g.garry@oracle.com>
References: <20260105100547.287332-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::23) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH4PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c462948-122b-4f75-09fc-08de4c421a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wbG+/Dgg4px3bGR6uVbLGIXu5EUlzyYvYxYsgLYLDVq6UTkQWFHaGxOldV/4?=
 =?us-ascii?Q?FP/11YWBqWj5Ye/ExJqHs22f9AsMPGsCUHykKI4p1XLXqq9vt76uhmUtKv2Q?=
 =?us-ascii?Q?LBXTyZL8j8PEYznUqQwoegeQcxN8yJi0Qb0Noq5zYRiehTA/WZ/ibFd9EZ4d?=
 =?us-ascii?Q?9xXeJbfw7+XNMoRtVANMW0FMci8aEPHMSFGkTuv5/aI7kCriHczyNLOjkeWI?=
 =?us-ascii?Q?49Bz/T2z3i7Qs0UFPqc2Z3AOrVltL31YWNIZYFmnwTMQbyx4yDArtI/6fzVS?=
 =?us-ascii?Q?8yEuOa/GTRQgN+sIqgtn2yvE2hT9WFgoRIJCXw8X/bJfAyRrAMhrapYXfayy?=
 =?us-ascii?Q?NZ7+zTV/eHWrLiXdYVny6YtVm51hqLg8Oe4wskxWy9jQ9RX+RB8oOUOyDVHj?=
 =?us-ascii?Q?0rI1EX793yrt7dgni7PURv1Jb/hJ9kWnQgH6114rii4oBfpU+hNmSawE+6Zb?=
 =?us-ascii?Q?Jpjox++qD7bTsOAA13EgvQG6rFgVQ/7B4Uw5tdxq5WiJaXYYZSit1XOebzCp?=
 =?us-ascii?Q?haBOxotTOAt7g/r4pVBpR7sbHapT27DmDVCZ+Caa/khKoPHZBjDrIYYY1YOW?=
 =?us-ascii?Q?l3XU672zqOqAv53CVCoeQLDzJ/wJKP1HRwfdWA+vD34p7/rUvoKPugC3wTog?=
 =?us-ascii?Q?ZkrG44zr5gEV1bUTfEBKo/wodADW+L/CBhGyXSwcx/5PmnnFXdzn9uRkHa1c?=
 =?us-ascii?Q?KKH7HEw+wXORtT3Gye1UpC1yQVaqjv1Jlx2UQ2oP/R5FYNJWB4hDeB9CB6xp?=
 =?us-ascii?Q?boDQJ0i8yabayEzrtxLGjdXtXsERt4QO2QWZ0LlCjHa1D4B+hN6uOgOejrou?=
 =?us-ascii?Q?nZwjcLTzFipvXLPxzfWwAYsVqCG34TcTiVxr/UPi4O6+81hxBTvv/fFJtaMN?=
 =?us-ascii?Q?sFNQx0cm1NswVmnXEkNaERMvtJK+9AJlmk4F3scTdqVS7Pw71sj/OfMKLn7W?=
 =?us-ascii?Q?73TrQS0whFoOESrjNOM2WswCq7NtYGajMRa3avFa9BG4zgvPhqXw+/ZGswqB?=
 =?us-ascii?Q?lxDF0Y90k5SMGuMYT1xOZMslTi0f6FH6PZwFdQM/EYImCLYtMdKADI/7wEBR?=
 =?us-ascii?Q?SVOOsMQn4ga8jgvzYhMfEebQUiD9rWHbV9xo+dXdP2ztwmmwcO3yW5X5CoSA?=
 =?us-ascii?Q?LcSmKBo7zJUOE61uL46yF1vlezMCCKKZ3CvmaNDeMSyqfZhzxz3QUr9ucKw/?=
 =?us-ascii?Q?RvTekrtwC2GqaXZiBxZGXjFx0K62B9PJdGn/iPQ/QW0X+u0XJIWo/OU8WmrS?=
 =?us-ascii?Q?9lFialb3jtpk4ifvbfYZZ8c9a1DbGRlu924IhlqOyTT4US5FvXANDB7G+snh?=
 =?us-ascii?Q?ze21JRCnJaWXylbpZ/Hwnz8x/AjjWmUWc9xjNK6Vs//DVLGRo1GmZbrWxyz6?=
 =?us-ascii?Q?sVVlBYV6mBhhxXOW/VUYPbhaMaiTi/Njf7WlFIYuE+SeUKvGk+NeNtBm9hNy?=
 =?us-ascii?Q?xwO98dheKDbGEJOjz76CKLwSCQTyydu3M7cyRDeT0B4bWpVTKvsk5L0i8i6h?=
 =?us-ascii?Q?Gum0kT9+GdMDujY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viJW2+AtyQJKwT4FW+8Y1OWWbCwvidhrqja3FWF/KcVwNBUp7uncwbwFu5PN?=
 =?us-ascii?Q?i/rQdLInEmGUcYp2j9ocwjzHuimrlk9RLEo9SwcsdGnrMRLt1m/hrH7sB1nz?=
 =?us-ascii?Q?3yVgL4i1K74CN9GpDD34wIVrnKJVibI0EqTmG9SDRZIjz1+rtOO1UoLn9NhT?=
 =?us-ascii?Q?2gsA5tXOVZPQNUVrYK/yMeDoAkg08SPvh4qbEVg9QMBLvSCk/jgSpwFH1+4q?=
 =?us-ascii?Q?oiAFpzZAKE5S03rK9JGADpv2J1Xf5gYjZ0BfB0bAktvzW5uIRLIJQEfN/46V?=
 =?us-ascii?Q?2MYwTysMLxMaVqBNzDzAB4T/4UxH3pXFd5VQjbAvE23f8ROPobSXsNCEWID4?=
 =?us-ascii?Q?C9mHI2u3u4JEWpR7lbYHHFvCAC+vTlq9z/o/67YfSIMGmw6n68cSdlJmtNE6?=
 =?us-ascii?Q?oFhKm9MLkp/DQ1yS9PWtwYBo0/Kb3DvxHolqnx0EBmPwWh/Z7anJTm2fpBz3?=
 =?us-ascii?Q?1UhD8OxiZdDIxwu+Ts5ZR9JTTW7mlG0eB6Osiz1l7wARHowClwHvFMUT9sZV?=
 =?us-ascii?Q?jjNV7iLNIn/5UWgsdLxPKqiFZHvxEHL/XI5I1HIwUWnvdembS+J56SM3/AnY?=
 =?us-ascii?Q?6WAWHsWv4JoZdosjK/l7ljMM/bQA2/MQc7uLyEHDXxaJ2HaHoNf6Oaf/djo+?=
 =?us-ascii?Q?6EDvWOIQqh1PrAPIgENIPMqqqGdY8SvoCUVes5tdIfvYCeC/DYQyiwfAPjVf?=
 =?us-ascii?Q?Gwnry1+FBcIzLDeD1fhAT4WiVemYmppcFoInuuRLabxa5rkKWSZe8x+PmWDY?=
 =?us-ascii?Q?+4V6EQXW9JOfGEdTP/LrEc6OyFMw63lJNm5mSc2nbEtmjZ8c54xAgXEl+eOo?=
 =?us-ascii?Q?oIoW+janpkjashgkNKnOU9+jINYXZM1zglRqkmiMZjLWE0i1DAzeFJjTXKzD?=
 =?us-ascii?Q?GfdQ/mn2vlNy7IrkYzcE6m/johFLa34CofywfMVPG/0Rp+eE5R9zbbLnY1KJ?=
 =?us-ascii?Q?sWHjvdVAZADlWFJm2DxJxWWvV/BTxxz33mlY5UuXzHskS9rXlpaaReInKMFG?=
 =?us-ascii?Q?vL1nF8GfdO4MzbLDOHV5wRdSFEtUv9W/in0wt0s+NMAYDiygrifgCfP9C3/z?=
 =?us-ascii?Q?jZAso1kKtNX/+87qD8lfbp+nWCqA+OYRKE8ySn2jSKFNg3cDT7G5neCA4U69?=
 =?us-ascii?Q?evble4xbtZDcapX/Y5HBHwg8LuauiUBqwrXAJLUPnR9PiPE89vv2Bq8PhVry?=
 =?us-ascii?Q?aArRvFLFLZSdr07f8kJ4qzwmEZZloeHEhkBBRny+H978kF4fI2OSSdjsBQts?=
 =?us-ascii?Q?H/AB/XOSEUagABDQDptmAub2F+7PnJ3yNRXmIx3Y6IsAsguIu8T37Yigc46x?=
 =?us-ascii?Q?gOkGt/caJfZf1rm07OAYRWdc3tCjCg8OoKohFjrHey6VZr1BogaiTqCDxSSH?=
 =?us-ascii?Q?ECZu+fK3kXoTPmdk7lTReDPWCS/eQ/bHIfYGDTtJJg9wnb2r0eiAko5kXCX/?=
 =?us-ascii?Q?l7o3wAC4RE057KlgxIxGvLqZJA4r6Ux4BdbHY9IBaDYiSugtQ5/boqxv5pdu?=
 =?us-ascii?Q?InIp+QWJxF0WoZxG7cHIqil4xzxJK93nre1b1jbMIlz8m2Tu5tnW5DcnDp1N?=
 =?us-ascii?Q?CT//+KVs2n86jzhFZ5vpSPdXkpz60Eu3ajjeP8k8e32URLaZPrHfHCAPMUAR?=
 =?us-ascii?Q?gBuoWT/6mN0cUt4uCEG7rRLD2qzOjo2a7f/rnTJr+kN5L611ZIqxkEkxUeR7?=
 =?us-ascii?Q?ifEdRQgWqqLW24S9Ak4VkP/iJ6YmEEffSDBprDCihhHuIMPe441/HKc1zzWS?=
 =?us-ascii?Q?F/Y2uReRrw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wdN91je3S9QJpLmOvxvYN362IkV8idxTk/aoTbR72huO+mA0FTbVTNqfNg8Yva7O143ijHZp6H1xAUVUUXDMlwBOOB2bXYIxDzoeIA9m0Qof9bCGqwz4YmYQCGGdpYFy5UituqT1kk4+P8CJs3hsdzGobsHdWHv3IDeCBPE/iSqtr2+qwIEKXhV7jvYBkMmX8pIgdm7kSuXJSuApUyUK0PW+gcKNosMInF/O+PFtVU/JO2GUi0ye6OzCJUU0B4s7F+1l64emVrlHNwzuY+4eH7SUucHb1oVy6oKTpFgjPqadXbh/v4YJ4X0zhwM5Ml7Ur3NNPk5uV3KQU4M+hvksS84YVsJYoXeJZlGeyZkJFiokgvg92FtmszZCT/PAHRcHmkfmR7EvfZuHS0qIJXTI2xoN0SuuVfIoN+ZKFG+Ra44tjfKmvLahiLv7cxBYRZzl/eCDtetS0M3sL6PjBrXRIJYfwzg+YfOZDltuwWMkULSbI6YOcEJbnRrGx9QA6YB/7GXGwsX1Mtr/VndsYd60asiDeSIOAjeA3BuOuIGlHW1QCVMVHEcf2fdZwFT5sGvFaYENh8UiTfPOYy5XUuVf5Y1vKbYClAh/a/cel2HqGjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c462948-122b-4f75-09fc-08de4c421a71
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:06:33.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY/v8HhexPPVEjezbI7ijiPUbUibI7jrmLDOkKpFFDgn/WQ0lYFTe35XTJQ/D32Wmcmq1h04rvAamW993DNtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4OSBTYWx0ZWRfX0XlJ5ZO1wRml
 S67c+4RWbjlTZEWuyguJZjrJT2U8rEq+GNSWAFO5eEvcKuoL1ygXbx56HPFjE0rnFxsUmeDjuPD
 sgzOwi4XoRK0NQw2rLM/JCMzqZJPTC5eTteV37n9J7iDMPOkE7YDIAvOYk0tDTGBF5NIC52hbeu
 3EloM30Ui5qAFpo+kLTEVHdTg9jkZ9rO4UCDV/FNcSNsC0LvJD/6gfZZSKSgEnkTFpsbm7v2ksS
 z9FiZ92zfIWIDRymUtvWS8TbMnAZQgePrU1onwnrv27qPztYNSEeaAV6YAMtlygBq5vhRsIzKCG
 9fCszsz6qOvObbGdRK9MRsYhA34ZONHQq1Qfo84J/G77Jdj3HwADD77PpUxCaeVk+a3mt1xstSX
 SvBdI9V+dKA1pes1sjz+h2BEco1APbzmtkBL6kqBCz6v07IumVYXn072vr+JOLEI6Isdkat9jY5
 lP/cpfCHb0R6rDiDdhg==
X-Proofpoint-GUID: 5kxYCjYyrpSvBBfgBG_ZPY5xfrXbJLd7
X-Proofpoint-ORIG-GUID: 5kxYCjYyrpSvBBfgBG_ZPY5xfrXbJLd7
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695b8d2c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Kep9LRqdJN2lsUto3TYA:9

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


