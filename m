Return-Path: <linux-arch+bounces-13361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C1B40F76
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 23:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF3516A75D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F035A281;
	Tue,  2 Sep 2025 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jZDOZx2A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jQM/V4dq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26621ADA3;
	Tue,  2 Sep 2025 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848894; cv=fail; b=GwwT7sxS/CKhVaKGiHHDEFCfXYyifbgaF2t4tH4CjmyBlQRo5UY3kKPrlAZQiro+ypd3Wi+P0fIhXi9vR72TRHf5gMdrzCqvjRtAnlDbQvzKD33IocLg9ZHmIbLja4wJnr3rCDN5s46LeifLmoU3NJ2knlNi0CcaupbrQFCUrpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848894; c=relaxed/simple;
	bh=/f+nHNSvWuK4KHcIG9lf8q+cpxzyct5Wazc65azauOM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=M5QuDi+qW1uFHe4kL1id/8G79J6F5GoZxgdaz7t5or4OXD5v+dHADD4Fy4oencv/57Dtey8ozYsYaLUX9Oz9BGjpmM0Xe3KM2qwgQQiX+TDi5/KZPvhPxr4EHJvWQkhjKMCRHd5nAgJEUjit9hJP5UqsCVdBRlQHl0tXVgma/vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jZDOZx2A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jQM/V4dq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ki2HN014938;
	Tue, 2 Sep 2025 21:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/f+nHNSvWuK4KHcIG9
	lf8q+cpxzyct5Wazc65azauOM=; b=jZDOZx2AbyP8fvYqBglT7Np5ZneUW2VG30
	MmiO34/newubX8WUZo9A31i7qnxF60c9hrXtU3/JjxEAdum1OjXR3wJI2CR+yTjm
	xDIwqf6DykLmS0eU12CKHi3gSeZaOq1ZH9rUxsfqawdUBv0BkiEHN10D65oMnKkK
	BBeuSFY8E8YCVrjfGsiNDUeUdvKEALrpsgI94D7Jl0pH2eXy6G/LMgMAf9mWngcm
	yfE3i8bFFwbU6Yii3fMw8S1nplBt9xm5mTsDZXluhIeX903x/vI80gaNnwscVFST
	pdtvPjr33rt6w9HdbTR3imOtr105Wi6lNXIKUBu6zf10A48gCMnw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4mg0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:34:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582L1wG4032709;
	Tue, 2 Sep 2025 21:34:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrfx94j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtB/X1kUleQjd0Rygkw26pAG9/mPGP1zk9+T2DbiycXZ6zBqwndbbsW6OeCF/dS53pQQCQyNfHHqie29y5svNuIGz5zC3EMyCt8slJ/jrKQxstWeHueu/qtSrVRiUunMb7iX+jHyBo0fwiEVLdcYwubadEOQz+QfJU6HgCsjAcDFxYvGjMcPJ8fk7yoW24TBe/zVAtCZ7n8zuzpqVp1zzQyHB28QVd3TOvK0Mg78hTefkJgoydaUA0RRZ0ni4DDclAzST5ntLtFTNda9JbQ1bAe0LKjKCcI00gLcbNS4mof/hRSgqYVqXHWQ58G8o/Ui/6EerAl3yS6nvySzsrofJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f+nHNSvWuK4KHcIG9lf8q+cpxzyct5Wazc65azauOM=;
 b=fUl/8rxFzpY3yC7jCoPiDlsY6CuNEr4a/VgNvdvkDGnb94Lquj1YcLpzZADx1F65/NIZ+v0o0i5atIZCoKEsHls3BDcnX0M5m3nJ9WBbdLzTdA93SkJ2qFKXKVn9OIgXZezlYqbm61y/QZfQZ4JgiWEKbNDXq4mlvgl3GfHB6frOHbASz352XXD8XXnWqQOq8smJReRh0rjb+xm3U2yOAmpZ25THD+YP0mNU7Z+plOXebGZzkbn8OTOzO5ERcpCq2bgD0Ld+zWdpLT1k8t4wz1pWy0wnuq11QwtoqZaG3Q5siDKOyw0Xq7hgjU6+ZHZcqU6n5xfT/UrduF9NIFyUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f+nHNSvWuK4KHcIG9lf8q+cpxzyct5Wazc65azauOM=;
 b=jQM/V4dqcTzzZ52Y/9L1ruHOxlI5bHbkoibyQI7J4LRmnMKMwXG82/oFvFQXJDICGJsJ1Fdo551Fp4dHzSAJqAYUj7tAlQ9+snHEx2eiiVM+hXCTiUvKpboBl18nPcGgrmp1Bkx/5T9bVQ8mekNhqMrXtnA6ywHYNbfvpnGjQcA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB7468.namprd10.prod.outlook.com (2603:10b6:208:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 21:34:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 21:34:26 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-2-ankur.a.arora@oracle.com>
 <aLWDt9NpfYO_Utky@arm.com>
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
        konrad.wilk@oracle.com
Subject: Re: [PATCH v4 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aLWDt9NpfYO_Utky@arm.com>
Date: Tue, 02 Sep 2025 14:34:25 -0700
Message-ID: <87ecsor126.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:907:1::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc51647-8af8-4dbd-19ec-08ddea687dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3f8nnkOPWRMzYpfpij9M032S4SuitBIM/zl5otmwTwR8nv7+ONqx7KdAsKpc?=
 =?us-ascii?Q?pBoKapbVvCGxEdMlKqNA3AznfRNB1p0X42evxXxKcB0FpHjj3tinrxVObX9O?=
 =?us-ascii?Q?6RFswgCs9EiUdgO0A0jS2KJfm5NlxjbLPJDLFLGXctgEdIGXRCZDDNwORLgZ?=
 =?us-ascii?Q?Z+KcWicj1cUA7aRb9Df++zbIcUwPDpaCQL7MIU4CQpggKuUuajFW+mjQfmwF?=
 =?us-ascii?Q?oKEMUvUuNK35jyOr8Utt9ZKVUtTi4oMAMBSzQt8Aa2yFYPqNqmsQ3A3d9sLE?=
 =?us-ascii?Q?rfGB0B009GXF3BtiTDRV3hORcb6EiTeYi9pKCMjLhvrykTzlgOABgvBmC8C3?=
 =?us-ascii?Q?NDPxu+DWzfEtNNDROdk6DPBEwYjFJ7+NnkvDGlvSOAaRmaNvNE7ZRpdye2JV?=
 =?us-ascii?Q?Prs2NmezxY1Jt1n1bwRNMqK6XY13MQdsPGKa5H9XzpkEey1UXjJvUjAJbrhn?=
 =?us-ascii?Q?n8wnEunomv3a5BTg/JqP7hFz/qLAP8NZzCMjU+6Af5Yt1oviq7Zb94396yiL?=
 =?us-ascii?Q?pQCnZ8EJdWdhUxlczmjqY89npgpBWNclzVCInqDWFPc4u9u94l0sdpP40qFd?=
 =?us-ascii?Q?PaOG8en6aFhglyvILXLgk+G/9YrW3nprM3Bk11gJI92xuhQGv60Ydz09pIcj?=
 =?us-ascii?Q?J6eDJOSBCQee86AtfGm7GAXUHxzSSybDwEVjhpWIvyiFtdrzsObdQ0HZyqjm?=
 =?us-ascii?Q?ivtlm4grqk+RJti1scVsVCd1/avlcQlPhbnrZUo+7wRD8izeXKQVLY5rOEWX?=
 =?us-ascii?Q?aXkg8UDfvspoJNNeb+0Gcmh3uVtBSiXvV4XHnP0KZqgQCrgcHgb5eP3e0OuV?=
 =?us-ascii?Q?lyqADqpjtpQNdsJHjZpJAGrdaST7p4/RKSm/wgQkIGnOadcl+CSjA9Bobitk?=
 =?us-ascii?Q?/jGys+SXCrPfm1Xjs2Ywk0NF2cHERayQCUMP3ZlpzPujTx1li1JKhZKzEEVL?=
 =?us-ascii?Q?PZ0IqBkBA3IEg1ie6u0Y5zNOlO4RG+xcyK/+OOt0wMPJXgSDVL+h4jxsZvgv?=
 =?us-ascii?Q?PHn7KmrbVboJbD4X3+Jd8ModykE9z31lG2jP9D7yCSFGgIERKB+te9Kt7980?=
 =?us-ascii?Q?omvxgAbxrmHiq7Sjpet0HKqs/pNHU6Y1e/M1J2VHdD8y+mycJ6x7HckIRwpQ?=
 =?us-ascii?Q?oEBlF8hia4NcocxeWCEtWRlIQNBZgV06v0R7sJhKfci0Mnmrn+QK4xfbGQvW?=
 =?us-ascii?Q?16+JSIUhKbuE1chh3Acnfh4yDa4sEK7DKfBPofMUWvt/wgR5M+997v9NhM+K?=
 =?us-ascii?Q?KHsW8HFLbivsRqsRMH9CLScTWiPa2OQVXFCe4GK+MJToLlCgO6IosoWji/1I?=
 =?us-ascii?Q?rQmdvRB+FP8nNnd0YZDZCkL0h3fOWuo4D8vm/Y4KKxdrEHFI+87753dR/lRe?=
 =?us-ascii?Q?AObljG0GaK3WMM1ahq7SKTD2hFFPq/Jlh2CVNRESkPIaLjvvSiKUvO7xbwCB?=
 =?us-ascii?Q?AY5ajcv5A0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFe610uVLux8mTxX5x+sC9REebpZYC2QgFAQDDRkuBKJLnfcKoZgMaBt4Fup?=
 =?us-ascii?Q?fNAqtB5q97cNpNKsDrMmLc1mZued/rP3Qcv9vplQ5h7pYt26255CR+hPzIxV?=
 =?us-ascii?Q?/UbLA2BbN5bwIe2sszpquJyi3R3s6EcEMZ+XP0gNWeiBrc2BHqYgw7ar05Jq?=
 =?us-ascii?Q?NeB9xK8znv8tGPnqBQviybXzLnF2vjwUbokohyTl2ARMqotEmcVuL1Px++dZ?=
 =?us-ascii?Q?i6ZlQxHJ7zuGaouQ0zyPu4kwQSoE+J/Uu/TDoQK91fJvGYb8zysCgxWqiSJI?=
 =?us-ascii?Q?BDd0agtvIwueSsC0EdgHw+blp28F9HDMa54bEEE+05RFxh5qKdz0xNmSGnX/?=
 =?us-ascii?Q?XaJuemgvTdapHj0fG27JniR9IoywA0KeONWH1RBggeYB1I3Jzci64A9x+RgP?=
 =?us-ascii?Q?5hZGGMh8w2OCtqFwr9yRl4ORaemIshdexIvc/LbChQ1R0qkroAh9oSwQ4wo/?=
 =?us-ascii?Q?ZswldTamA36ZRTyADzeXtgvpeju4xt/lc+W2THifuoMECJwUPZaToDNRmX3z?=
 =?us-ascii?Q?EbyzR6aaU1p7qZgh12raGU6cGLaruhlQNl7GuLDmcmoUWtgn99zalVpfgyrQ?=
 =?us-ascii?Q?CxDkE+P0PL94nMQQYfU//YEFxWCI1Mu30c3rHp/DulwJZXbDcaCdP2k60iiR?=
 =?us-ascii?Q?Irgapg2CR1sdJteg6rntabSq5mco7mYeKQwKxarU4MrABJVaDuVQPPL3fHW2?=
 =?us-ascii?Q?0YhghCsKyHAPU2GBi/HSX7gvhF357HzoucaNB4PaSEgo3BQvMRNV+12ZXIPq?=
 =?us-ascii?Q?w9vkszlzPG1tvbEvbbyTTxBZ07AWQo77cCX8Yek21IGAJb0tFrY3cjLz5F4c?=
 =?us-ascii?Q?AqhfWONNMy2zKhBQIDv7jS9D8SakmVumdH6sW+Ef/qEQrVZyl9LTxANedNfe?=
 =?us-ascii?Q?B7R5b+ydI4RT9zIDx+IVI3zCg9TK9hL39gOrY5avdkd0l4vqqesSauWgXhIR?=
 =?us-ascii?Q?mF94/3K7d459RTvhHN1L4Iq6n1DNk9RE03JDVewCnNxc8+hPbGrIEgEeCNQN?=
 =?us-ascii?Q?Irn+K7QaTOFV6EG0RXj/VcoggC5eVFlO3oQbqs1HD+NE96xNB0C1lGC3LrE9?=
 =?us-ascii?Q?PMJVJfdEKL6RjiY+pcvIrO0yTErcDuhIxhMe5gXUf9FiQHcuLu5vYG544F3A?=
 =?us-ascii?Q?pjuXdaXMAGXEcvFxsPmYyHt6KUcyJcPZ/H5Mq2usCoERAFVfv+l84cucdxj2?=
 =?us-ascii?Q?1Ci2azYIbAM3dFqhDuf52wGd54ckNpwm9yIKHB1io6Yz7ykJuh+pPUrOnbbs?=
 =?us-ascii?Q?IFkgMaXHmcbvbdi2JQ6U9a9FDmOjvn1hFi1UfMpuipmQl7R6l9WxuJK+kzBa?=
 =?us-ascii?Q?6suFWbAK2yonCi3h+THeQkrG+Cqs+KMUi2Pjegp0wrRr3idpbXLLnOhvGlX2?=
 =?us-ascii?Q?o8M8hYTSLN1j6RDZOChxTbxxy0D3p5gNVRxYpMtgMeKm4P1FlLMBk9EwmGNY?=
 =?us-ascii?Q?EptRZDlAcqc7S1cyzGnTdSdicNZB+R+t+plYnRsIavj09pkurFXJN70CRk7X?=
 =?us-ascii?Q?Bc8VmMT4WtY2UJllLzcDD5bjxNKEknJ87ySa9xomiqT1dDDnyjtcDEzbOuyM?=
 =?us-ascii?Q?W7lbvENj2btCfnTyq9XvRcKiqHP8SK/3cyELYvNh2//IhO77buviVhxH8ROq?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tXDAZQJL+I4iHnf0djhztzsvKcf06eQ6Oq9UYDOaPt2DDgwOidpo734h6FMlnWRNsiTu8Ri/UnjOtGWul1c7uLUl+7G7B5l1KymRtMm4WiQ7epkNQVx8leLrkBu3Qgsk5Qe+NdclEnNF43rRoY9PZy0JIpNek1UA4dJcTSuTAKQWEM4YbGjxYAF4iUF8/of5TZJm+kHxUJtHtRWPGHIAUCd6PqqgySS5x0Sh6Ow/HrhJF4UBc7C/3XG/RFb9J0fKBlPQ6N96t5tvU+SRMfxj46epcHu3Dy3v/3P59oGtSX3FcuYkEasXORaLPVrZS5PMyOWyG2NlbjBqc2R6j9ixFPS9ETkL6X/Ls264H8K1hBeKGIJI6Dqn/svgHrujuzIxoPxG/cEch9+sTR0s6rI9YPgQdL6Du6REKXIz+bGIz4MuWocj1MhONEDmR7M794k/wg2x7rIET9B4Ru22UxDhMlfJIalwrsbElAgzfgj2H32/M9OqZB+LbMc8l1AwsfrpgCoNWMV7cWmbydu3k15DNWagMtQUsTnNlvkqwJryBwR4Cq8YZTh+IoQfsu4R1ZtQs5LhcvxYt0RYONxY6/d9g1wt5BdFm4JrTneQF4AowhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc51647-8af8-4dbd-19ec-08ddea687dde
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:34:26.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwnfRwezh58LUkBOVU1EReH2s1A274+vG8lM9QhhFUMnAAc++WM7BW9JIzaGDpbG1ngtoSEdxQ9cCFKoPz+nCRaes4jLuljP67hQAfl4CBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020214
X-Proofpoint-ORIG-GUID: 1TUAQS8fZXdJFDFaZMucOlwjSprqBGW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX8jnO8z9dWq3K
 +AEybwoGfmh7mY1dqU7mu4LEU25i3ya7cHdRyD900asttcTl1D11Ezj5/fGHu2tH7+I2C0HyyxE
 OlUMtSJ2327WMJe5I7rTNofxNncJki9QYmu0FFWWwvWkMjp82XLbbqdw8kWcun1/zIQQqSP+DjZ
 /PID2n1+17F1UJffJ5jqN4/c7Bts5VNBYrKrPmTjFpYjmZKJuxUQ9lTnj5Wlhu1HbVCxdPY5Pqf
 wUJ74FzkvCpDIYlWQjCWt9XG3HuNOUr12pKmCTYpXBjkAk3J/Sd5vLB7QaQ9naaODMd1Zlo8Wqb
 enBCzSuoT+3BDIptEcnb5JJuMko2rjquhwqLXmvKzaqHzrL9i795o9XzouU6vYxYe8W4CP+Nzze
 IA1YjklY3VEkm1PCPWbroaQ+IKmaaA==
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b762e7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=AzMQ0kuImwWvT-A7tbYA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: 1TUAQS8fZXdJFDFaZMucOlwjSprqBGW9


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Fri, Aug 29, 2025 at 01:07:31AM -0700, Ankur Arora wrote:
>> Add smp_cond_load_relaxed_timewait(), which extends
>> smp_cond_load_relaxed() to allow waiting for a finite duration.
>>
>> The additional parameter allows for the timeout check.
>>
>> The waiting is done via the usual cpu_relax() spin-wait around the
>> condition variable with periodic evaluation of the time-check.
>>
>> The number of times we spin is defined by SMP_TIMEWAIT_SPIN_COUNT
>> (chosen to be 200 by default) which, assuming each cpu_relax()
>> iteration takes around 20-30 cycles (measured on a variety of x86
>> platforms), amounts to around 4000-6000 cycles.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Apart from the name, this looks fine (I'd have preferred the "timeout"
> suffix).

So, the suffix "timewait" made sense to me because I was trying to
differentiate with spinwait etc.

Given that that issue is no longer meaningful, "timeout" makes more sense.

Will change.

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for this and all the reviews.

--
ankur

