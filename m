Return-Path: <linux-arch+bounces-15688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C0CFD11F
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 11:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2486E30E1A07
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB432D0EF;
	Wed,  7 Jan 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QHz2OCHD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wup0Orpy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63A32C945;
	Wed,  7 Jan 2026 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779519; cv=fail; b=ezi19rMMOB6E9WN9NEldVsASd6fpz/1OYwNuYsLwd8+FbSRNyuUVa8UiASQMx5OGs8MoUbzNRWWIK2PEJbzKETPVuTMm6SsfNprN79g2ie2XgfoqdYN4OG5tsQ8m88ekqKarlkt/mf3kS1W0IArz7FvGrIACQ1PJ32BcpgQMzHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779519; c=relaxed/simple;
	bh=/+8xd8Pezeovdwa1n1GTtqIf/vrKPwT3jg9lyPitKms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoAsLoPfDsehPbHcDH1IGDb2X1p6PBct6CuNkSrGQTSJdvrhw3LhQaFHsFWeQBNfZhbidHNBgumLp0I+UwjdsqtF3dm2Hzcc7/WAdpBZ53klhm5lkpO/cKPRoDE3cmSTBfpMcp4IcqJEhBxHxiRz9pgW88ftQmV/Co5yPYddT54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QHz2OCHD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wup0Orpy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6078R0tF2069565;
	Wed, 7 Jan 2026 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZXSN3OS693r3OY6GPk84DBcXzo/t8eiGsROwMzjXxy4=; b=
	QHz2OCHD3QMm2UUB2tbV64TvL2LmJHCksM6V7PA7tgh3bwTROAHXK81DhsMnHZ/E
	v+DKx64uxYeT7ZTdt6qoVFRsLXZb9/CR70zoAY5AjR4+yWI1wehuf1O6YP4GcQ7P
	4pOXuoepgz05Q9fQuQ4ntJHKoA4ipwufWO2zUg2XRrqbcrvTe5V05SRhOANNR4ov
	hpyHEdcNPADylRbkQlu3JLuWGTO5NAF76GvwyjOM55vUIVFhFk2DO9AlgmMAbON/
	seu2d80onENnXCG03Ym8rhWUYOKncxQmXtvOSIFDmJrA2EXfO6+D5G6yI5fvrf+o
	Df74ZwYxV/pxYLWbpXMpZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhkysr466-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:51:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6078qwfn030813;
	Wed, 7 Jan 2026 09:40:32 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjdp51u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ3za205r17+2b/JQpvUGRN02ui5MpDTFDM6bZ4nQLDo+Ef7l99nSXL5Ta9hmV/sJXS03sPDXaC3R1mX3DMl/pSFBwiKbUCRHOrBB1ghbcGNQzt5qjs/SdMstSHvo2ftsTlPQGhgwKNnV4ItAoWvunuqKVfKR+oVT7+uA8oZm5pQiOYYWQh55jDij/P4YyA/dweDXFB/e950ElXesjXSTKqRHqhr5Tx1bZYJzbciRbPjOwD/C8jEDjPDnpUSy5z5UQhSAIB1AImYFdJFuJ3sdOudsTJdOMSot2rmr0Cjj5JP+NZrxBpbXv6RbZDjYJu7oOpah8bpgWxi/juBN92N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXSN3OS693r3OY6GPk84DBcXzo/t8eiGsROwMzjXxy4=;
 b=rpbA6IS9h+Dx1xD4uwYTzYTMBrCtycaGzPa8ORroa+bzDH1dCbntpz+POjFi68z97sXuLuKYCeElZ5WzhRPlz/7GnJpIBLvx0Svdkrd4tslkMV7FyXE15Jt3TM0OnXrjRLyCpOmnq6QFFtUrHp6clgrewAB2zKDPvXaDAv+361hvWbUJEriKI5FNqx9qAkNNM+YbQ0Pw34WgBxXpkAgwYXdnk8dfVHa+Kggg1NuEB5ZKcdm7LTpoaMehkC4ppBje5VWyA6BwwFqEq3u3YXKqwkpx7Xs3qihpffTmws+lrGsSJDKfYfEVq4PcwxuD3BISw4ivwgBxVA5Nm6Amu3QHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXSN3OS693r3OY6GPk84DBcXzo/t8eiGsROwMzjXxy4=;
 b=Wup0Orpy7yKOG3ATHrcxrG4HYxCYcxXJ814FTbTJG8iD9DWVJUnlDCkHjs//6IC0Ut8RyjFPTMPEmXtyqX9Yp2ogcE19AhZjrZuMOPJuPrknu+39bcxIf1M+EP/0BlVAhCSTPRowUQ/tLXbew5AtC95x0s5f11/wUDgd82Cj6WE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB7479.namprd10.prod.outlook.com
 (2603:10b6:8:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:40:26 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:40:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 3/4] MIPS: Loongson: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Wed,  7 Jan 2026 09:40:06 +0000
Message-ID: <20260107094007.966496-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260107094007.966496-1-john.g.garry@oracle.com>
References: <20260107094007.966496-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::35) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 5055ae4b-6047-4676-3284-08de4dd0c9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nCy1J1gxHEmoHgp8C1apFWKMrq+2iwCTJvdaV2DLFTUqtiASOzil52K1CScM?=
 =?us-ascii?Q?yFhN1tWJuW5QY8oXjiypq0tV7PDcB52fRkxD8kGnMDRWXc2KK+zJ2limSnUg?=
 =?us-ascii?Q?AbDmlBbHdfALSaFosc7VT/+oKYcMaKBGTNipkENZE1K/gn9pAPb9wfdwpLVy?=
 =?us-ascii?Q?XlyD3ijswuiNKASuYZvOeQtS746BwffyyKa/0p96GovsLmW+FQ800jN9cYAN?=
 =?us-ascii?Q?h8iPjnl+6pbHFVuKjpdXwepS1QeotiuqXKcllRmFLR7NbqkRnwmoDL06Qg7A?=
 =?us-ascii?Q?IkI4x0FhMZSP1YrDEKyVbLyyTrVJaaWtlKZTNiUvNCyF2Oo9dXFYv2iKLhmk?=
 =?us-ascii?Q?kvT6b+Y9nIQ1MX79qqN1l3G8mdFYa0/O2FGDVQ629UBHpsZrguO9zox44snI?=
 =?us-ascii?Q?n5sZe3flxAsnU3LcvDYWtQ3Ul6RycUP+7Q99GMfg7kVo2M6ZmRT/EIwasCdw?=
 =?us-ascii?Q?UZ81Kd7DuNMP5SyOLoiENYxiiZFMVck6nzC3khAPEcnb0aH16uJ7c9hcJSvD?=
 =?us-ascii?Q?qVpfwrLgWJmGpawHweTz7K4wgolD5dKeo9Xn7HSTsRBS1w3kyQP/Dmrp5FcL?=
 =?us-ascii?Q?dV45Qkw+Vl/wvApBaTr8Rpo8zrUu2JLivUMPwcsxa7O3WHxoEY1BR7uI+YOX?=
 =?us-ascii?Q?sMtrPMxhEN6xeI/XbVAUiVYQYXesYeyu4RHkJrpLNgR0c4S7alI1R/NU6BG3?=
 =?us-ascii?Q?grm9f0q1O+HJu4uPAL6rNJEIEGMDqi6+MmDIG9Zim23iHPfA+FR+zMUOsKjo?=
 =?us-ascii?Q?N0mjepWeJ44RVXuD5c8epCYYwe38XWoy+dNQt3mePwaQBETm76z/ouqFkF+l?=
 =?us-ascii?Q?Xb+R6TCHQ0UZZJrTxqB0vX6lMYehPj+Bi1roy8xzf5nRlYh/Qw/TEg+COaBa?=
 =?us-ascii?Q?IIUrOcnsTeVhl0TJYYZSys9co0g5FdtsbeWXJTx3rk0SVjA6DjcmBP7p5Z1f?=
 =?us-ascii?Q?5nR1yV5qfyScrYtm4WYj6dZ7IhcnRwmQyDK1t5gQj4bCGjFueZD1Skx8r744?=
 =?us-ascii?Q?78hKfz4d31HFdZbkqhquKYDUytZ2P2XeUFKEUuqFuVWIs4TKw0lR51vVGXLi?=
 =?us-ascii?Q?5cMx0y4kM1Vlc+eZ8hOBONm5cUdkLBGjzvT3QBJmaVEdXJaYILik7QLybyir?=
 =?us-ascii?Q?M8W1TXqIUx7MlcSvNVxQWsJZW8d0Cfr1OnPtaw2Cq+OPIxc0jGWWqpo5Mqse?=
 =?us-ascii?Q?7yGuzLyMAi3uDIPZga+gr30gCl0z/8WR7okWvxP7hiWBQ2cpUgEn3ir+sDf7?=
 =?us-ascii?Q?fDMaE4l76T99jhrMjwX/bV73L72cC6S371dp2kGQa6hUSTdtKfqdZB/syhNm?=
 =?us-ascii?Q?aHeq7jfxE0zQLoyyYtWlMEw7jo8/mEBomfmK1o6945wdkeeJ1IRssMjnAMyB?=
 =?us-ascii?Q?LVW91CNxjmXSC1VYb47kyURhDXRT7hX+iAsefxh/1p9UG7o+opiAnJd1HyYQ?=
 =?us-ascii?Q?/sjug8Pa5ykyVzAo9rtoO2HIfhmPLsrHUOtsniN3iSWGrFf466fq1vDENi7o?=
 =?us-ascii?Q?AcSDrFBLxHxhc/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SwHxhb+QHptGstuWZ8lpoqGAUTW29n9wWz2SibRwUmPDdM9o3Qk3KC25iDHJ?=
 =?us-ascii?Q?FtJ/UkN5d2cO/BW1UTiMz3m74GsuzQeiFURfhw1uGwI9t5L3w03ndOVBlx42?=
 =?us-ascii?Q?kWWiyPefwnse1SJ6zM0nr8fC7A2+pdWzcftf3mpb6mCd3uo+7u9Mj7vYa16A?=
 =?us-ascii?Q?sIkckj4HImubYJ2l0JB3PZRr2FEl6bdD27YBbuTuuP99oDF3rfPw/E0G1Orc?=
 =?us-ascii?Q?VKO/iiFLnIw5k7RjkSx2hDul7/0YVmIZo/FmrBTn8DBeOnbcFCVxH9Ep3Mk5?=
 =?us-ascii?Q?ZRsdbicEUibw57kWrc1m01M5djLXLREOq1/9I/ULM/MEtwlLfIKALxoutCsn?=
 =?us-ascii?Q?TUtCXXBKLuQwPf8fqgWEQBYwEdNaMGheezzbxNfYRBs5yyUKQ+1bxCKj8HKp?=
 =?us-ascii?Q?hE9UoqBDZxXdEs7VdhUBUZJlfLaJ2yoFgELR7OnUdGoU+BYZKD7AJmkywEma?=
 =?us-ascii?Q?k4j3EoAJvYS/bWw6zAQofeKa9MP4C3GazuPo0DfW/HOObIvhBNvIjAlVix/+?=
 =?us-ascii?Q?bMvpqdQZ2OeM2rzFEHlrJzQZlsDqA7Qb/sInDFdupu5+1/Z5Li7Uc9fiq14F?=
 =?us-ascii?Q?iKqcQNepKylcTxEzOTAKjFcqYXzl1G3La+nZyXVpT2rnWBKFh4Nk/bWYOa2g?=
 =?us-ascii?Q?ZrhQokwvfdet9Va4cJmBxT2JkLqmR0gOhUVSoeh9R/r5uiAycgx5yq+PC63m?=
 =?us-ascii?Q?BQWAnoGwUvFQ2mVelpZTwI2TiTADe3AIC69YAREfNz36S59bbQabXqE1nnGR?=
 =?us-ascii?Q?okGi3KdTiMR3sliFyUD2UjCtv4wPycESiHm5e5MCIgpujM7+dv9703WcOhdX?=
 =?us-ascii?Q?YWEqL16YiRVh2tCh802gp2yWHVDvNe9NE4h+YiW4m9tK/4iI4yQQKHHa6DcV?=
 =?us-ascii?Q?jexwNA7VmlUkAuEdnvqDuwAn24sGxqd0dxIy3M/aF8GeD21nrMYhQTZRfGul?=
 =?us-ascii?Q?czK7KZ6BAjqzRiqVQqpSAYZYXXqvwZnh00Mz7KUAag3xQgmP5xkxjVvjPCUD?=
 =?us-ascii?Q?M900QLNIeW4Q6cNIU0tX+gcaq6GkV5J4S2pu82JXtkIvVvgeGZdwFv7wtqqU?=
 =?us-ascii?Q?Prk4AASNQ2uoV2dFuNM9H/FZVnbe/jrnj7AQTTr+Opy5LtO8ZC0hTnrU478o?=
 =?us-ascii?Q?Evdk/EuCXw/lFOnLld8xK+ZiVCplvPH2EGH3RZ45ZoNqnFfnY/G61JQjlcBt?=
 =?us-ascii?Q?WgZrLeM6aqK+KAoLGMKkMwE74PFwyeBny+MC/q3tS1yfEO0AmhSeS/6ftz0l?=
 =?us-ascii?Q?cZZEQwAH7omEr8Du9MEcHb14BuT4TFWT0eHMYdJ8xtgs3tqun6mX7SH/r4J7?=
 =?us-ascii?Q?ZfChCbfV9/ZJcHjhe2k+YyZ+QimteMVzWGVzr0WV78bBhdU9aw+XYvgQckCm?=
 =?us-ascii?Q?GgLQkwLBFSmTtp0+XXo+N5y8I4Pj3Awpas8xMWoeY8hLyi6m/8eYMl/SNvXK?=
 =?us-ascii?Q?KiLOI0N32DJN7xFisxGbReqk/NkOe0+Q3ZJI6tIFCvSic3N5PN07yxdDvEMX?=
 =?us-ascii?Q?oc3ERtTG57I+XJ42sSXkdnGq4XMLCpKN1UjqV9xZigkgbQvS3DN2rp8dO2LX?=
 =?us-ascii?Q?y89Cm8xkRcnVWic5RToCVXm2MgYfpJtfF71wQD/engSU/X50HBhLqHe9c8r2?=
 =?us-ascii?Q?/YXhXvtvJQHKomdARcFZmQ55tERvJyQmZc0SI8E8hWxCWf3H50VreqTgc3Ee?=
 =?us-ascii?Q?fA/pUZhCYnT9VMld7kjCYCPrDoDc+jQksDMp8T3VgNWWaHNSPYyFqVXAU5zy?=
 =?us-ascii?Q?F6xKrQjyyg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oq1KhKLMtWOujo3I4jyrpcPd/HSgzRHvdCnpYif+P4lY+UAIj5EDBpFJCujBl6S+U+WhqMQbpIviYjAZaiqvN+4K6+pVqxL9bxD/AL0ADqvPLqqNayujj/3PfBS1ae8q9PFI9lW+/js7PyURPpdoQIsTlfEdIhlveX53ia87yfZKd8ztWPP9GpoRL8Qf+ClQeepMDiVgQbC8m/GoALgnH554yO+xnK9BDjhdsXabeLn26uGkp/GtITwzjhIWFxQHLcq9Gxm5DMz/NwdXPKjgP0zIEGrzXCL3igSwvMHRPeVrIry67TU5S/aGqTCUOrE7cf16ib9aZ2nOPEj+MFvgVLTsGJNzdYXJO/CLMAy9dc7i2jwFSU9fTjJtqzeSiLe3g62I5pYy8adHwCqHVOk7o4JRemGwXgIGJls7N2WaIcLcPO5qaHpGcLSwulwzOZpT08R17fbJpgidVjIe85jNu0SZ2S+UWCRe/eFlUs/ybB6s8re1PpTa2OebDfxW601kDAiUa5KlbFe0+IWn+co3G7+Pr+tOzfMR4f2jSx7Ba4RBq8+iG+CrvOcESVXDQqOjivYBZplGfafvZdMXTTFbxUl53gJad4zbFVo1IMbxC1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055ae4b-6047-4676-3284-08de4dd0c9a0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:40:26.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTuhf4K6IxUUg/qSPUMobmQWreKquRRwJK0Qn61BW8DLqubQUn4p2I8FojQmMJQvHFjNOm6D10Fm4Bxmj04h4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070077
X-Authority-Analysis: v=2.4 cv=T4iBjvKQ c=1 sm=1 tr=0 ts=695e2c9d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=03khOLM81ZsWC1gh8zQA:9 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: bTGvLkFgu9FU7WliVlEqR8eAqO1QmplL
X-Proofpoint-GUID: bTGvLkFgu9FU7WliVlEqR8eAqO1QmplL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3OSBTYWx0ZWRfXwsq/LfjjKZdZ
 Alkc9oIIUKqhkvLqdRCiYabArKpVVZrtgj8yDALhba0JxNB9seHJzB0lI1dQCwwubyYrffgt+aO
 Upj/K7YC1FdUz1OZTUWQifxLMhWRmU7asnIk1k+rsJeBxSLQYhN4zePLdrPHuefSnTJyjDTpbtr
 yld/g+dFFmSZWn86ovdi1es/4IV7G9cg0qcbjkmKS8gwjFC+UJsDTTe5VagVMwG3iQNxAkil6Sj
 E+lxndk9i2RSdIsXgYc06N7IWh3uyD0aeMFzwcY67r4d90AQ9nzPFOKYA2jQPnk/CC8FLCQjzko
 oP0Txf7aBE4bsjf1bec95Y10L8w+Bzsb39Rb07/yen3Zhg//KN0Uf2KdhwFudPJnXfn6ZCuDt92
 FOiI8DRaB2KDW+yMMXFL6u4YAxlmNuZcw3sfNF9r5TtnwlJMpUiP/93S082P/W3/hb6U7nWrbFW
 pV6zDWH1Fx++xK0IZd9wMM1dG4je078MHIe0pRNY=

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
is a valid index - so add a check for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 arch/mips/include/asm/mach-loongson64/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 3414a1fd17835..89bb4deab98a6 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -7,7 +7,7 @@
 #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
 
 extern cpumask_t __node_cpumask[];
-#define cpumask_of_node(node)	(&__node_cpumask[node])
+#define cpumask_of_node(node)	  ((node) == NUMA_NO_NODE ? cpu_all_mask : &__node_cpumask[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.43.5


