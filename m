Return-Path: <linux-arch+bounces-8904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D439C0E95
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0621F265C4
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A621C180;
	Thu,  7 Nov 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyPh7D+X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="esS9d9Fl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30121C17A;
	Thu,  7 Nov 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006580; cv=fail; b=XnDaRD5WdE2TRD5H0e0L3NR5dHDObhT7yshY/C1hS8+m6jikfTBHy2f3Nh022Sx2Xf3R6zXTpEInEAX4eZJLCY4+kIPZ4JcMnH6EuNDgkJaD+NFvFA0wN7sOc1ik+KuSYvXDLiZtHe74qoTUwM2C9b0CyywKW8lc9oiMzXRDB0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006580; c=relaxed/simple;
	bh=h+s0zPrbvlVnDP7LgdMF6n/gdbD2X+UkkYRVL3akutM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlrR2tWcQCbokWYhXpXrVwqn5SfMQ8yh3M+8qVNOA9LSkXpYGxQ9bHenbDTpW/tSI464k1tSkywnlsmMt+8C4mCcvB2IF6pKmoo8Be5vZcQaZJKsKpOQFnUR959i7hAhFV+gv+mt7qxynGD8+ZTenke08EdrLb9vxk+ojXdBv2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iyPh7D+X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=esS9d9Fl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBuGY014259;
	Thu, 7 Nov 2024 19:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tuXMmugSwWVSw8iGwCPMmmKPajF8YRsj8SWgseskxsA=; b=
	iyPh7D+XfdSmXL5vEqE4RjOvI+aKuf1YY9vOd5FcxQfz6wsRsWi0L7W/1rQCAo6K
	HkZ7MmR4WftfUNKX5flj5uBtCOelXPwBhwRhUGX2hH/oQi/Ll9EQcQPzHhUa3p9x
	Y6h3mcs4lq6qPdD55dbVPZezB90K4WQ8atUgl8Xqwz0sfunpOzyh/5PIxtz5ZbVd
	ORbG+YWow8XqWlg7x8ZrDwaSRwVVMG4zW1CaxssqXNfPovU+/2T5MMdQET0Sf2uF
	Pco1nHlS1HTSIC0yTC94uFDu43jy77qwjXiiUiPtqx4cbqlnL8VUoYZDleq1FfMe
	uV0HG/mCgi1wreJNbQQerw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsubqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:09:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ho2IX009141;
	Thu, 7 Nov 2024 19:09:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahgt646-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmO8yJWn/dV1q+A3Dpc1yH4IRrQBV8h/S6g134SQuo5K2OdgdVEpW6oR7OJyMkOqFwqXtYzHrT70Iv5aS6pn/hPEA8M6ZQx/2zKM5Xe2zUa6XrEdE8SBpO+KScppl7FuzfMR4/9kCFp1eINrZkHG0TzbEC+NjyWw0f9unqweeQ55eccxlTIiasHzMGG+JR9SB/iDJb0z8xyUTX4xsY5OAJ95I+zmbo1kM9gLVjAyGvJ2lEeu2w0aOZyZj4X/NRwAOAGPNbPuheKmPsHrS3izwqOSnlTTFs0rzuVLUdHTXj6H3o6s4JedPrbMHG4RpCfquy/hxPR1OnP/r9cA0Nxccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuXMmugSwWVSw8iGwCPMmmKPajF8YRsj8SWgseskxsA=;
 b=yMscsV9bK8SiUWzOsQce1Nt6Mf8pD0cMnV7mNHbhR+zN+9kXP0KqZ+qzo7UPp+0ZIUU2JotE89T63Ee8kd0oU8GsTtA6zJp14BNApTHcxat03tpBGvlHPsT7pe79K3aKCWnXDgJAoXE2Hc4dYNnfWOZU0P+twIBJsDDqtsSDFyTFzeccSqmUIZWE2d/Q2iNiWpipsiD3f705Vb/hRZoO2Y57DNIeVbSUJoYu+7anjCHOymnIV14Y0mKvxwxNT+PZL8B+QgVrvPMTDX/cq3k41uSZwS6QAFtvYD3fcxo0zDi7wmWyBlEfXvPYAkVrX8oJ3vQNyoqRcZLp/nsodAdCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuXMmugSwWVSw8iGwCPMmmKPajF8YRsj8SWgseskxsA=;
 b=esS9d9FlNE5+Y4uGf8bveVrujUN3Pa+hdNmC9YHDe2Kxp86xUJDUe/J6LMPZq0E4Q1VXW2Uvf/G3X5GHMcKG0FeCZcTK1H7hAEZc+EQpPp5kZbUk/Ziu6uETF1GQYiOtTKlVivdvdL31VwNjTG84jq79yNFTAFl/H18Tbr/gCP0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 19:08:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:56 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v9 12/15] arm64: idle: export arch_cpu_idle
Date: Thu,  7 Nov 2024 11:08:15 -0800
Message-Id: <20241107190818.522639-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc7818b-9e33-4e83-9153-08dcff5fa086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Se6ZZ4UkrdvOLIiyN1L1xwF0U4g8UG9oZKyKOu2af6xI4TSMRyOuM4NBl1pL?=
 =?us-ascii?Q?HWlcYqIwmtzIYmDMVlJkucGkO8tkjZoyb1aenbLzjE9rOSTr/zPnYXme0r1T?=
 =?us-ascii?Q?sspke9odvtV1VHFpuUQwZ29WfYqyVo3NoxWtcsc+xV8mMcpAgIl+kE4CBO8n?=
 =?us-ascii?Q?arfVFUJ+gj/ChZdgjJCNKrwFZeVOhXPCxpKKLHS/x97OE08e9Cub9tx3gCUt?=
 =?us-ascii?Q?4vOmKyY9NGxJVPyDye4QHImgoRfFXks7x4gVcqPDS6aPQf6Y0vLXaCObCi/P?=
 =?us-ascii?Q?X0yrC/LFfD9jBaTSFfba/5H45TYJTsjpEVqIoIpuH0gQU8yj05pV1UVxNo+4?=
 =?us-ascii?Q?W+WJ1IXidP4gZoBhgWnpZmIphm5H2Eu/AaZASYlRl+gszX/zTOXn2pRVy51B?=
 =?us-ascii?Q?fTo5YmJOLWzxnhACozQGkAi57atCARk84B3DVhnPD1iKllCAuNjF0EpRJvVh?=
 =?us-ascii?Q?zqGutb6Z714cRfAuM9APnpOR/XnOGXkq/2Lz7D7YsVeiVkbSl/0OmfJyQVJo?=
 =?us-ascii?Q?6iGy9kQx+ourWZIwR6JXLzedEzet7Ts48w66/9SKGmX6lSLI79n6hBkC0at8?=
 =?us-ascii?Q?g7p9wtvjyjNT4/n1kIWP/rxEbYFSPUxdc9FnlVaeJrUpG8TerMobOkRooPQu?=
 =?us-ascii?Q?Xv9hW7NcrsH6P4rNAKKAKGigLyoWft+3UlL7tYn44RuPyRL9Z4L9TBEGPl4Z?=
 =?us-ascii?Q?ikIXp+suUL0N0Kf5qo4i+nj6+Tcjm812yzSi3k/VN7tPNLNAqahV62m9hTAM?=
 =?us-ascii?Q?0ZGTubDPKqQgEKxxy4oVTdNRZGwOxmnp9bWRVAPmlWW5DjYEO6T/1IFVajvp?=
 =?us-ascii?Q?RbBNP8hnFshgIoqGxH6CkQIYHiHKkNfK8SncHd07sT8BenkpwpNh32uOEpET?=
 =?us-ascii?Q?qpnUzm7/pE2L7JnnVHjW2+71TaHxFPb7fSQNEIvpXk7I1UVVK3j99o2OFPze?=
 =?us-ascii?Q?F62mjwt+SBlf+J8/USn94Q7DN3ARfFrZlx7p92Eudzbq/yZEgIbuQJd+MGeE?=
 =?us-ascii?Q?AjLeNYU1g6CNEN+fA/F7C8Jye3pch1f7l9a1eQuB8Uz5E6ySU3BUq50kn/gM?=
 =?us-ascii?Q?3nRgfEpA9N2JwwjsGT5evtd3UaAaV9YbUS0S7TBzps5s2/Ta6ppsB1oj6k+r?=
 =?us-ascii?Q?HkNfyejW9jGjlAQeqTRdzS1Ojo6vcDIt4AYpUvE42pFGUSxMgCalXauZBxUZ?=
 =?us-ascii?Q?uzz52XRFNEE0ynbUWHNhSNv+jB8/v9gbOh2v2GLqcfkIZTQ0sCau8rQtgqvZ?=
 =?us-ascii?Q?8DjAm9bNvJ+kMr6Yz0oE9itNekOxpopJ2CM6TONE8ld+Dolcm14ZwEuGAepl?=
 =?us-ascii?Q?4PVuycpLXAwYssgslq3oUn59?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAfNrhJZM61sSHpAadMW0Yh2czrUvcBMLZJ7K3qXIM1OADn+zy6AWSbBo6qn?=
 =?us-ascii?Q?7FY1b5qbUYX1uBKZHHKSx7AwcvieHXOw0Y+U8R45dgX53YjCb0t+k2teruQp?=
 =?us-ascii?Q?xiFSnV599lTmLZbon0hfM5oN30/oz0NYiqlS6lejdG8ZRaBIi0YQpav9Ofn5?=
 =?us-ascii?Q?mK/sFoxmqLelHhOZvrmMxU6ke2CMunbKVsK1z8+aXNzMF0MgaG5B8cfaBQHl?=
 =?us-ascii?Q?k6bWqamls+4dnfFIsHHtxX7QEConopofSdkEUDiYchyMJ8Cs0L8ibsSBBzgQ?=
 =?us-ascii?Q?+rLgRjAJqw7/yPQ9ZacvqsGHa/lXbjiWtQ/0Du8S0WLbIsojv9LdIgnF/rih?=
 =?us-ascii?Q?tY1SLGE03uvkYpNghdpZOVjvQFSLLg+WckBjAn98qelxsApEZJuvdPVL9UB9?=
 =?us-ascii?Q?RG31qP6QktVr101kX/rCsR43N4AT6DH8C8vKEF3h4MCvpEBADEnXCkubeKS1?=
 =?us-ascii?Q?WmUh4A3/sX8nWeXGEM0bENEWUsFIeWAdfm5V8EXjFahYy1yYzoJt3SGCc9lu?=
 =?us-ascii?Q?xp1aSYayZvYg010ZGS0/36gIAtnzOLrjKPc2s83vDFARuHNC/YCkeHRJrTBU?=
 =?us-ascii?Q?SnnGRFRQJkN8AxSoLzv7kRmrcZL3P7xoKmjvo80CAe0OiGj65cjmuhYbckNv?=
 =?us-ascii?Q?aV1vcDWeK66eZxwLL4hSx3pX+qMH818WiKSk6jkQXn3Yj8sW+1M3oxDp3/xn?=
 =?us-ascii?Q?sdC20DpvSZn+e4JkLJauCr1w2U5FH3gSAMNk+NjajBiwW0qU0by6A1lsLQuq?=
 =?us-ascii?Q?sIFDqld5qYXu/W78WUlqnYf2GONxJlhaJEALBqDXBomJZ0bjgmd5ad4AepcQ?=
 =?us-ascii?Q?4JuOMiqqzrTseQ7RdXXegTpQ+sVn2vTUA/iokzdrDBN7E4LNmV2oimj2ylNd?=
 =?us-ascii?Q?G0vl/qTu+3CeqmO+HPhAzAWT7vyZKOZ4kDH6oYvikqoTIlL5/yIjVDORty8y?=
 =?us-ascii?Q?PpOIt/6UIs3Up+T194gHh7KyuUecIm3uavAuUu2R2wff/1qHR11Ka91ZNSRn?=
 =?us-ascii?Q?wj0UFMqFnN9O2GL84cuI9QCZvSbaRk35BewYvaFxOFaCwchAh37MkOSGt2w5?=
 =?us-ascii?Q?5UAWzzcGJIypweOIUg5wIOGVp2xZpP1XPggO51fKIS3TGNRk0xTVZ9eO80XC?=
 =?us-ascii?Q?fbaGtbnc74w4/4ZdkP/VWFuO9MRNmxwNQELu9c6Otauxj7Wiw2Wmfm4elRxT?=
 =?us-ascii?Q?Y8xv2gu8kBhO3hfq+hdcAntXolHyhbwb2okW98Ffr9grdaXFoGaz+XdAPFjY?=
 =?us-ascii?Q?3hU3m8RmHbOgctjXd2cV/BHYKOAY8yFRcxlwJWKTBuZap+Wamp9gnA3FfaRT?=
 =?us-ascii?Q?L/AiQT0typjbfOvCxjbNehM+k7kEriuMOeVFg9G6ngFtf4EeqXeOCpx0+XDi?=
 =?us-ascii?Q?XXac/veP5gxbEX5Y9qvbWdBntQmICsS7vWhGEp2cj/its13GFQ4Flw5IqKbD?=
 =?us-ascii?Q?tmWVzw9hVbowmylpOfHCXYUjiElMSy4RjXBVVsSqj2fPgx2MmzESUBRCNZ14?=
 =?us-ascii?Q?5zItOJA0ycp8sua5LMUyzgCeaRkH7wroPC0wF53dnp1iT69WZZwLnxeDI3bK?=
 =?us-ascii?Q?MVIuMnUwdGAbaK3NfYXEXynDjQwGG+r1xUCZGGFzfmSaQrThG70QP4svjvye?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pfm4z0eCiTr7mH7GDKXhSYwsFSk//D7cZiXQ3T3ARLGSl9BT8xwvX/AeNAdUbF4leezO8y1U1cp+BmrW2xVWIw3pO0dhHGzSa+4AndETBvgcdgUVSCq+jm3XIs/FlWKmPpxYRm4bb36o+tMkifK6lrrR3l+fC0xO4CBmlJCqlojJBcYzuCxzfHlYDEH3nmZimRMLtTuHsdyJO875ed0W0RKJ5QLv5R8PTBdOGoY7YTTHuKDJfjja3aYeIxLTX+9BiGXzZeEG4NyO6R/9nXgj2bQezwTbEJouuzSC3LYmETmiFiKuVuRTA83rlyMjFGzPEOBlzZmgJMBwF51fwgi7x6mPYr8uTipzPetKPUIc2IDoQgBxHbMGizfwjJyYr1DyaoWa/BwcB4rHja4nPdTCj8/bC1UzsTDKxmeF8vOARcXKJbmbfSQd7JkQoWttHnQxyX0KAtyNPbXd/5/kgmJTrgH/7gI12f6r1n6rTaQ/iaW8w/TH1Wqfg5jkquF6OldBo9cdEm7ZZYmtV28MsYs05LcJ0R56vKJINUKQ2F6okuNxL3UCkvTVo5tohV+RH7Tx9dFwMKAFjecy+c/5BaXP0xphgAO8Srqqodljw+IEqKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc7818b-9e33-4e83-9153-08dcff5fa086
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:56.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFeWGxAFpwjkVqT//IzErFNAc5uyRn7S1had0WbQNF9PmxBmbfuyxMRUJjqUPrKSXMBEB72d1w2sczYEcKci9eiAQCCccj28SMSjtuGzJqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: frYy-i80U1jkbQ5KgQ9xaJEDRX3lkJBb
X-Proofpoint-GUID: frYy-i80U1jkbQ5KgQ9xaJEDRX3lkJBb

Needed for cpuidle-haltpoll.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/kernel/idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
index 05cfb347ec26..b85ba0df9b02 100644
--- a/arch/arm64/kernel/idle.c
+++ b/arch/arm64/kernel/idle.c
@@ -43,3 +43,4 @@ void __cpuidle arch_cpu_idle(void)
 	 */
 	cpu_do_idle();
 }
+EXPORT_SYMBOL_GPL(arch_cpu_idle);
-- 
2.43.5


