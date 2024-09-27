Return-Path: <linux-arch+bounces-7467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8152988588
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 14:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD59283E73
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005118C922;
	Fri, 27 Sep 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWx099h6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HOBiU7q4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F80F9C1;
	Fri, 27 Sep 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441539; cv=fail; b=m9djbk1V3UdwsBIxhqSoUHOvWope/uE0SfdAtod9qYmLPlgGRPa/H2YTqhO7dysvI0MJeHt3HzWTs4cUhsZgZNN9uqdafJ7zVn1fs827lck3az0dqLYagTwMheZsnnI/I/Sz8p0mZTvIJKD+1B2QNSlJ60uc45NVXZoW0o6ISk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441539; c=relaxed/simple;
	bh=JJ0syywZks346iX3343ipqA9nVnqNorbEWhDbdKy50g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFbiAfyc+RIDS3xU/sPIMpnSKfrl2CRkYTnYyoOINe8QvZaR/ctprqAnvRSMgcwtKd38JzZUQjzViYeirO9WlpPnjLN509PjEIUm1OZdUdE3BQrUvrRUDxjWW46W4oL6Mo97SNdqYBo9sjgObCJuYyOlWtmSTbKC3K3lmUFMqYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWx099h6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HOBiU7q4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gZN8025994;
	Fri, 27 Sep 2024 12:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=meQWsa6pqi4gRe3614XH1tchOUd5jCH9YSDFm265TZ8=; b=
	JWx099h6qd/XB92eMPNpuGjFSwqrvobzGWP21/J/25u9HvibT14t3ri+qAKt4oeS
	Y3NgrRWzeafem1mdpn52jl3SeScAhYNFCzyhomh9tVwdt5jppCYNtN11Uh11vWya
	QOlaMh8PM1NgG2XCPdcwYKX37N4XyTK9OZRvqyjNnxP/9nBkJWCentk2YUp6BNpY
	VL4DI8J2+sNuggaL/SyF394YeccRQYtvBGD6FovLIxgRzKR8P4rQ+HiOXA5ZavYT
	4nAWM7DPFyAMBsWs/HkCIE1I9fSKYCv8Nb9ffqPjNJlLIrm9UDcoT3XrGtKOU4Zc
	EtFi6TGAFDrxQwPSKzuSYA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx3d4gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RBmmkC030416;
	Fri, 27 Sep 2024 12:51:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdkc03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiBBXtTSdNDUQHG/XNLMKspR2kllJ1apoeOA8c0atQNppoTT/xNf6VUSlNpsKbLbKvCLVfI1r0WulGV0DcvMdYWc0N1yzLov5exxM2Aabat4iGx9D0HKyGCYoZodfeUKTv24kMaoug0BLwOjKSmdx8RVGl6o6sk4A0WckCycZDwTBoYcsaBNcHOTE4LEe3xbHYRA9jR2kaM8hQma/OtDG4QZCAiEMuuroXaDQXjgg8UkaKjE6/2LeUXt33Qh/Xof9FMBrwlne14vYMIrSvGLuQNIOZMb6kL5zhprbCiEHiYS1VcxgMT4Zm9S0o7La/ThTBgKWA4dt44jgPqu+RG+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meQWsa6pqi4gRe3614XH1tchOUd5jCH9YSDFm265TZ8=;
 b=v4Uw/If6qgPU9bHnFCpEaiZ1iKt7tVmRIdI/o5qIBL6Pr+519QnULMi66I4qpOUbhNHeVoQAlF2+66v22lMp4kXNA5FjbFyvExGE78ZbfiIiNBx/wYkS98TNVPY5Q2Pi0kMXFWXI1pU0ZeA8I/UQ/EjuJ9GCOiGAB18Z6r23uPYPl2GilTcdCucchtlBfaAmBysSbOftcVeyDrab2rxDj7Gcj70xPV9IXBP5lDq1ZJ+dCBymUjcrmoex/ToDQ/Pida/R/8h8Ttc6pkZfWWJuA7etmNy5lFp0f7Mqzl8qIkLfaz+uxER/pU2WxErqEy4RueFlUmDJB8+ygS95NBQHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meQWsa6pqi4gRe3614XH1tchOUd5jCH9YSDFm265TZ8=;
 b=HOBiU7q4/Y3zCk2/ovxnoTMYjgOu+kR+/nEHNdvKKI2ma4lZSyu5/luqN8AxNVIO1t04/x1c9NLuc6Bv12X0T1UDBCDi/ofTaua8Yb1bt+sl0rANnJARRiKtU4oFiAIoJ9pHDgrBBhfNPFM4V+P2QbIJHrVMpw9frMRL7d/R4Gc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Fri, 27 Sep
 2024 12:51:32 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 12:51:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 2/4] mm: add PTE_MARKER_GUARD PTE marker
Date: Fri, 27 Sep 2024 13:51:12 +0100
Message-ID: <03570f8a0ad2a9c0a92cc0c594e375c4185eccdc.1727440966.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 693c504e-27f9-41b0-c70f-08dcdef31cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7nNrvUvMBna91H8v+DQSvY4z6loP4LzHg4gg76Jahk/HokFHpk1KGMwZruv/?=
 =?us-ascii?Q?GvIZ8dDdB0SmZ1JwIXUq98R1ed6Q/MLn0zMRBCu7aZCSevKUDapgjE62wdtb?=
 =?us-ascii?Q?ATCzxiMh30+L7VmUjgLuT9fYSbpXkYmgBNJt33dzE0fFMpsMm3/26MLQLHMi?=
 =?us-ascii?Q?yTgHLmfFoRniQJYIJYOsYCMXCA60flRsmJJ2CTVWV0KfSrgGnaEiTo7/mrLy?=
 =?us-ascii?Q?bSWPH/tG3FN7sNj3QGbAk955s3QFp++f5ELSwupvb8Zkm44ZaqUanwjGxLHB?=
 =?us-ascii?Q?LWUh/ojwvg/KRErAThsJe9/xLd1iwYIevdTwWuzIOgXonxiS+BEHwJ0dLZy3?=
 =?us-ascii?Q?SIq+WOqvvcbrSLmXvWlIt+wStPuspfW4PHld4XXXV9kdSNBflEW35Gg0UHJp?=
 =?us-ascii?Q?2lpMoehnd2TX+w9QKWYZsg5xSI/FQ12DWC84ZvpwlTAPOscQN0FoS++jkW86?=
 =?us-ascii?Q?51ldiTw9hIBg79+V5c6TSPKSFpFO/eyAJrTJfxSPgmUKACBHzoBpte3IGIXL?=
 =?us-ascii?Q?dliJoBbFO1cEZCHuEhoQylttuAPzBBTCHveevNyGqbjkHFc+wthuy3uXoBLA?=
 =?us-ascii?Q?C3YFHlLuwVPSUefvaioFgOsmspcnArDn/0I0wSiSCUJtLHQOF0ie6qqlf1Pz?=
 =?us-ascii?Q?IaoDQiyWyHpYMNk9fxA+QlXKwHL07yIiXjQSML0KnpVnn7pCQFh/C1IWKI9v?=
 =?us-ascii?Q?xla0mtEcRaeCj6LNk8m22qQ0WhVxnajVIeSiyvp2i//wPflCc4P9nhYSTuBE?=
 =?us-ascii?Q?UC6Kqe+ejexnfCY0rIiaRj6swzyTvrGOIBme9g9J4w8KLIcMU6N+CW6KqMcV?=
 =?us-ascii?Q?pcDkVM8DVBI9dvwq8VDQuuxh7HSNP6X7XnoyGgaW0fKr98YsrjuyQHbphUkt?=
 =?us-ascii?Q?ZClNzui28ovN1+5DOk7jGRA6aHRfU6vqPP9QNiabrcB3DiV7ETcPBuwrxQI+?=
 =?us-ascii?Q?cA8R1NF9IkT7VqMQijolhfLtRuyEMWDRIv3sGqZJeiS5GR4j5FSGLlULVH6o?=
 =?us-ascii?Q?wJhIORsY7s0eCF3lsURCYGIGICPyC2n6Et8ozmoYdnxeVISAcJfteWYVsUvD?=
 =?us-ascii?Q?05/HC9tqCqTugwOcSz7gwqyGbSWhlbCpZwesjnOH86pdjCJ+J2YDahuKAyqn?=
 =?us-ascii?Q?JALXnYwJdbJ5Sg20E6qdF5BFynoU4RN/bb90G+2t22LHIcvhl3cUN6iwjZ80?=
 =?us-ascii?Q?aUP8LXoldhqtKV7U1UX80X4KJiCz6gN6/SLqCXJDwT+tniDTOt0Ue9paKYgj?=
 =?us-ascii?Q?JXAk+zn0ILedLh3KoCjcBaPrxxKjYeNrLaWuBC5rJLK5+U4WXqvWOGSknlIl?=
 =?us-ascii?Q?77Q2xOs5gDsdqG1NfSQVKtQKMMkAxbA0AeCtOwM0H/MUuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fi0xQ/qb2XAH2fFLsVxurm4LxH5F6mXjXMCteANE+cExBOrfEijS3SxerrZ/?=
 =?us-ascii?Q?MGltRLGSej4tksKFdfQJBp+3hs52fgex54t9b2mnQMxNThdIZIVqqMUrIaKl?=
 =?us-ascii?Q?41TRYy8gA20bHfLj+KePe1GCmZG6w5P+oB2uBl3hljxUi3eq6b+39Sx9moCB?=
 =?us-ascii?Q?nvsIDx9wjNFHWgPUTVCuJWkJmzDh0OHtuAfPoqiFHOWJRsMilx1dpQ6iC4jG?=
 =?us-ascii?Q?IZxXyMo7wW48WsUIHb1POBIT/bUdA1XOhokRVjgeR+y3fIu9cAtPH9vmfaOD?=
 =?us-ascii?Q?pMGnX1CSgHUieZYpcMxQDkgb59JEgChLOCGbCbDcZIsfvH4b5MYI+4NuqmN4?=
 =?us-ascii?Q?ohRGkGHHdFABC3BosfrwvZhsp2086L+bw50s4Yc4IJRJETSVTm6LrkYI8v3K?=
 =?us-ascii?Q?NMGS7zDyqJ+q4kgEWSK0dkhtrHiRmC/ACRm6ZNnrKoCBvKmhhYK/0tjUpYCs?=
 =?us-ascii?Q?qhguXfEeC9Ul5/AxONTH3R06pI4blpJZpoLfJ2C7UZgqM+g9ZqHNESoeF5V2?=
 =?us-ascii?Q?U7/f2oXeujAjOdq9RFHRgklbYGzGldiyfC/ctOfNhmRL4n55jONrBtqUlYEr?=
 =?us-ascii?Q?uBLdYpXlX3NL4iH0JwQMbs03ux9du2n8/pXJNuzV1owx9kcMgLpZwYiTMRVH?=
 =?us-ascii?Q?l/CrvnRiKVNwE6jJY35r9lT8+t31N5g5XcAqqtlDAXo8cmXxWxYAcXEb5knH?=
 =?us-ascii?Q?Kc0dttnSjTPIzuQKl0+dSnR0liOf50JRd5DNf+udMCgcrPzUY1AOwXCDJr9I?=
 =?us-ascii?Q?YTlz17zqkrEV9YIeWDT/H0Ieg+7+8I07SmppL1dx8XJmpKkgy2kIdBcs6Jg1?=
 =?us-ascii?Q?PNQjK1e0r8LLPX381IohFubw4U/WXghb8xKHgYn5GmV/pPxQuwutVSh3NuNX?=
 =?us-ascii?Q?xFtFKlp8EpxoWYYKmPaVYbHonHwtCs9ua7Djh2OEyk5FAIHX487mZITA9CeW?=
 =?us-ascii?Q?It5wRzjGjkQ18lNR+bY/YR1ZNUr/Te1qpKsv3fJcNNhG+j3MV6gphoCTJ+pK?=
 =?us-ascii?Q?d7LZcDZUOK0pseUv4DhamACuIdQwd428z5Vf06p1W85iDxs+0QQMwpw5Skoj?=
 =?us-ascii?Q?128We9phTP5iKatmRBDYSRTBaUbNBIfLjKbMJKuEev9vU6mgANYABBM1axi1?=
 =?us-ascii?Q?khGXu78J7yxT/ZUVhhohVepVYydOK3OwxAxP5eH//UdvJtYkCsoDzRtZMVkm?=
 =?us-ascii?Q?QBlwfZO2yRsf0igclftK6+Vc5iyfyTk9VnI2JVD66HcWMLikqjQjqsUJ/9Wd?=
 =?us-ascii?Q?1OncJyMPNYTzVOMbGwPWDBMVwD1yXpxzo8bY31YYKuIjNrr0p71B8PbO8Ecx?=
 =?us-ascii?Q?vqBzqZGc8B6vEctB5hvbCQBmhTb5tlm3Qbg8+u1Utr30XGSkijBFOJDdSqOb?=
 =?us-ascii?Q?8HPVjy9Ub5eHlDUMBPlIqxoXUdclTYVopQzUvtS6dFLJamlBIyYCJCWnc3uq?=
 =?us-ascii?Q?HUX6gj9UsbfLhr+Dr9O3KcScJjz8s+6XHLfcaya1OqkB+XM/LRhtjUnFeasB?=
 =?us-ascii?Q?NjpyiRA8WGDm5TVfJy6MZBHj2qjsmg9TMuiV+DgFCWuAMvf+Stm0uyGkNg/5?=
 =?us-ascii?Q?78TZnLOxzhaxYiJoH4IgRRTlwCVV+IUkKvXS73Zp1yBO2rt51kS10897uiB/?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oWSkn+uyv6NsOaC3xM0VX3IVY5rTUSWrhEv8oaek3JGI+V/UjHFdmkOxt0l6dXAWvDCmwZvAlKMepxsAu7xMMSLYPJV6FVqzw7MfLQlW3kLR7JIgDFaWdAHB95ZbIcEJCAasaygkRlF7afmqcWpCB89MvnfjTquYj88QvUWUBrNdb4dU0M5VfgNRMnj2QPLexsGn2DfSnLpRr6SZWqewqbxfnafIeUFKvkjiaPP07uXobo2eweZAhia0RPzO/GXraLiR5x0oi7eY1/k6J3XIFjhSuOTwEnsC8j7IkhObI989svzKgY/Prsi4L7xhKq3eoy7Y9RZQIwZ+TZW6jk8obGcHRh6gTwbCIHSJOQMRBecABz9HcM/xa75Duy9EOzXUmpUdnc4R6VETN6hxn/4Cv+rZ7CyXvfCLlqK41PyQj3/FnyQ5x5gO7DOVRdjB8KcpyPsPY2YN9nt9NxWZHxECpHLBLj+6smz0SdTcB7dfRg53ISzvxrqCszsmon2Uh7TvhZbEHdpahYIiSHL2+TITydWYmjnn5GZ82X7VedTm90zSWNBGsvo/ka07cSv9lw+x+qf0jwe9jpnJCWgu6bv0J0RIvr0SDbs70REEB/fEUQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693c504e-27f9-41b0-c70f-08dcdef31cb2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:51:32.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eng9sAdM/DpV++rLe9HKZxmQ4cZKgEX62aZsn3Gu7yFre3XrckD6CR1uYthKT7DUV91Ybkt3i8oQNEkdfIkNEUeP6DDAaU/P7Lsw4OSrmQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270092
X-Proofpoint-ORIG-GUID: PF5f5kub0HJcgp19TOds1_mVvYzdTsrX
X-Proofpoint-GUID: PF5f5kub0HJcgp19TOds1_mVvYzdTsrX

Add a new PTE marker that results in any access causing the accessing
process to segfault.

This is preferable to PTE_MARKER_POISONED, which results in the same
handling as hardware poisoned memory, and is thus undesirable for cases
where we simply wish to 'soft' poison a range.

This is in preparation for implementing the ability to specify guard pages
at the page table level, i.e. ranges that, when accessed, should cause
process termination.

Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
purpose was simply incorrect.

We then reuse the same logic to determine whether a zap should clear a
guard entry - this should only be performed on teardown and never on
MADV_DONTNEED or the like.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_inline.h |  2 +-
 include/linux/swapops.h   | 26 ++++++++++++++++++++++++--
 mm/hugetlb.c              |  3 +++
 mm/memory.c               | 18 +++++++++++++++---
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f801c7b36e2..0d97a14bf051 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -531,7 +531,7 @@ static inline pte_marker copy_pte_marker(
 {
 	pte_marker srcm = pte_marker_get(entry);
 	/* Always copy error entries. */
-	pte_marker dstm = srcm & PTE_MARKER_POISONED;
+	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
 	/* Only copy PTE markers if UFFD register matches. */
 	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea1..4d0606df0791 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,9 +426,15 @@ typedef unsigned long pte_marker;
  * "Poisoned" here is meant in the very general sense of "future accesses are
  * invalid", instead of referring very specifically to hardware memory errors.
  * This marker is meant to represent any of various different causes of this.
+ *
+ * Note that, when encountered by the faulting logic, PTEs with this marker will
+ * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
+ * logic.
  */
 #define  PTE_MARKER_POISONED			BIT(1)
-#define  PTE_MARKER_MASK			(BIT(2) - 1)
+/* Indicates that, on fault, this PTE will case a SIGSEGV signal to be sent. */
+#define  PTE_MARKER_GUARD			BIT(2)
+#define  PTE_MARKER_MASK			(BIT(3) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
@@ -461,9 +467,25 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
 }
 
 static inline int is_poisoned_swp_entry(swp_entry_t entry)
+{
+	/*
+	 * We treat guard pages as poisoned too as these have the same semantics
+	 * as poisoned ranges, only with different fault handling.
+	 */
+	return is_pte_marker_entry(entry) &&
+		(pte_marker_get(entry) &
+		 (PTE_MARKER_POISONED | PTE_MARKER_GUARD));
+}
+
+static inline swp_entry_t make_guard_swp_entry(void)
+{
+	return make_pte_marker_entry(PTE_MARKER_GUARD);
+}
+
+static inline int is_guard_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
+		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..daf69ac46360 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6348,6 +6348,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				ret = VM_FAULT_HWPOISON_LARGE |
 				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
+			} else if (marker & PTE_MARKER_GUARD) {
+				ret = VM_FAULT_SIGSEGV;
+				goto out_mutex;
 			}
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index 5c6486e33e63..6c413c3d72fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1457,7 +1457,7 @@ static inline bool should_zap_folio(struct zap_details *details,
 	return !folio_test_anon(folio);
 }
 
-static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
+static inline bool zap_drop_markers(struct zap_details *details)
 {
 	if (!details)
 		return false;
@@ -1478,7 +1478,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	if (vma_is_anonymous(vma))
 		return;
 
-	if (zap_drop_file_uffd_wp(details))
+	if (zap_drop_markers(details))
 		return;
 
 	for (;;) {
@@ -1673,7 +1673,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * drop the marker if explicitly requested.
 			 */
 			if (!vma_is_anonymous(vma) &&
-			    !zap_drop_file_uffd_wp(details))
+			    !zap_drop_markers(details))
+				continue;
+		} else if (is_guard_swp_entry(entry)) {
+			/*
+			 * Ordinary zapping should not remove guard PTE
+			 * markers. Only do so if we should remove PTE markers
+			 * in general.
+			 */
+			if (!zap_drop_markers(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
 			   is_poisoned_swp_entry(entry)) {
@@ -4005,6 +4013,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_POISONED)
 		return VM_FAULT_HWPOISON;
 
+	/* Hitting a guard page is always a fatal condition. */
+	if (marker & PTE_MARKER_GUARD)
+		return VM_FAULT_SIGSEGV;
+
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
-- 
2.46.2


