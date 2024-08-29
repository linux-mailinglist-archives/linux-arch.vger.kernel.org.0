Return-Path: <linux-arch+bounces-6799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7048963F38
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0312B1C2453C
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 08:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8934818C900;
	Thu, 29 Aug 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LF6HeHUz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bqkAwQkm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDF18C90E;
	Thu, 29 Aug 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921713; cv=fail; b=hZQ3xfF9QB1P3rvc4KaTkaUBtTy0EqXqOeTGNVwNiDUt8nBg//1Iyz3NF4lBiRbjnCxtSqc7PcIkUbkEl+D5fQRyXrsO9J7bD4HOtNhYs9kzW25h2Ax8O/3SLS7UZddk2m4VD/AeCgpHDVnA1ruRmZzo1SgE1km1VqzJRRqsHec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921713; c=relaxed/simple;
	bh=6meTGLBK9WnvWlysNvvOD9vDa5GF5ClR1h1YHVQGEzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZJbP3IA6HzOI11+IGdMtBOIk6wsQutD8jTTtLFVOOg9DK99th+9g68A7uGOV9HULjUJjFpPRZBgIUogIotx7pnBSCUUa86iNB8ug++j6RqZPuGKpVF15YNmYSd4BVy//gn7LcjGWsho06Me2WtCGj8OQYmDLu4wjjQXC+b3Rjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LF6HeHUz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bqkAwQkm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T1fYTo030245;
	Thu, 29 Aug 2024 08:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+VxhxvK16Smwilk
	s8eY2zHP1D59PffYYdvpXdSP+71E=; b=LF6HeHUzx7wgOQXigmiPVhCbD7wMBBa
	WHoUOuxRB/DVhc46qLa5fDMY6gOKDXEqw9hONXe1FKtfbFx52YBvPw2t0Aw+mNQp
	u+xJiOJIp2qxj8h5qeVcrxB0KP92uPDLZBFXQPFJiHojLfqBnXG4GxedaIsvLCSk
	fz+7iBpqHx/6Q8Dw5nu+VXLGA1vnTKDnc0mTIIw8TEfuKhs3PksUyVZoEmLNBNb8
	+bQLw0xLDnnkLQJ74ic//Fa78QHZpiUpZBHAHferEUmhCK5MOZd1Hp72S2VXtXBd
	t5yREaNwQtS85dPUC9DjBPF3npWzoOuOAIs6qMmLmcrgWC8cqnJ3cIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup3qqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 08:42:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47T6eKYS031845;
	Thu, 29 Aug 2024 08:42:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0we8xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 08:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQsIb3atktslL6ra8sg98jf9Os6+tdQM6jRKJRehJP0Lnyk2SNV1Q2mVTDdiN5lP1DspVMUWO8J7wk/y8QPkSBmygZ23MOhpaGor7lJC3GosjfvNNtOauPfy88+Bru4mocf+OmVNiNfACri65Z54ADpyxmhMNIUFGNef0ug7XgU9xjn6MZUwqeceOpQNOYXNoNQ5TjPB7jvkqGej1hrW8rwtWjvsJ6Ob3mrsFYGXIKifJPMvc0ZyjcnL220258B54nm6wF6dro4f7CbIJcC+l5teZROjwGGO9RpwEcjfRWTCs/MOyStPGD6ZympNBurUHuxjpubkmqE63YrJky1/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VxhxvK16Smwilks8eY2zHP1D59PffYYdvpXdSP+71E=;
 b=RsfPTaPm3vcZ+uHx3kFOXDQnJeyxuzaCvgJSG2lCZ1FhJsTjLQAZoNTaHBliClEAWgKZ51xTy6a1Bnu41DAJOTNMFaiWbOgGysOQSMYnTzLoEKZRDT51mKyIX/4gTVmlU9m7/CtQtIHDi+qZHQooQpBTHSoomBNqP5b6qeS3Hz1uOK4GrmYWFpGlZKTCrN9BpCLTJutfYio4NKM+MLVyaF4XG0FIGOFefU8FqBTe6u91uiFkkzf9PAPbBz2+SX3b/9ew09J9ZTvOK59PenlXJU1UFK9ipo1EvY2VOlOdKzkT2eHAE/YbMtNh5tyXtDY9xax/Gua5mlIqDmPg/vaJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VxhxvK16Smwilks8eY2zHP1D59PffYYdvpXdSP+71E=;
 b=bqkAwQkm/SNOmkaJaFP5jtvN9lIezz/1rB+RbMEoC4Sbyj0yCSS7kkihP7XGw3eQgGVLOw+uZIzHsaJuy6M+KI++ni5QOoM6umpa9c2PQI2v5hfYj/caiW4dFOWZ6+1dh/0uE+AcQ57nT6zuv+wp0GqxyHaECYefhZ6i3JomV/4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 08:42:26 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 08:42:26 +0000
Date: Thu, 29 Aug 2024 09:42:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
X-ClientProxiedBy: LO4P123CA0187.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 483b1c8f-931c-436b-9cde-08dcc806827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MBVw+oXJzwTKjxbe7wSQxWMzBiaH6Tlp2Qp7WczaQtz+sj+Jimsr8RGMtZX?=
 =?us-ascii?Q?VCGkc9O69yRwzsJ0MNYTgZLmnaDkRMrZgNcK06MhwWXEVwIvh6iY8Bw8QaYt?=
 =?us-ascii?Q?GzAhnehzgQd2MjexUbSbW+Cy9SPTAl2XhVzMmPRqS2D1ohT1fCoFZD+nKvaa?=
 =?us-ascii?Q?vGjdU2Aqt5RSo3K0vkzmeRyTLaXFJ5asas6As7tDvQZgQuK6ADzUAzsxlOQn?=
 =?us-ascii?Q?7vw0JkPumdIOJidDcnmU3HATQsPMmU1pQq+twzZI0iHYB9klV19Ih4XZ6uJo?=
 =?us-ascii?Q?EjkzirFRGRLsedtGDJHK8IshaHlHaFUmnwWLOzMMfsp9/jam4a9+6zj8HBRp?=
 =?us-ascii?Q?1j9x9hOxuL+N5yWnXmHXukY6xca7dKrueB4B5xOTkltv9aZOAZQ+vFODqI5q?=
 =?us-ascii?Q?s3lyvue0kNFUTT9vjE3lSIbWbVCDHoDP4R4YQOx1CsM7uiSd2YEKWbHc+4Ql?=
 =?us-ascii?Q?PxrS7+PrMfFsEnPxcUcJRyjLKiZ3JOqCXjX6VCSOjv6oDFuapILhIIbjDwWY?=
 =?us-ascii?Q?mB01uhF0gxAuT8j7oj4EI3KZmKCQNLLhE+yIQhnUiu1y3mGowrNr/Bt3X37D?=
 =?us-ascii?Q?yMovWLth1Ou4Mx/8uTLE8GOXRYlW7BcS3cPE+a/wFMkg6Td+RkX5ydf6QxmK?=
 =?us-ascii?Q?V7NKUEsz9WGy+zXxBIIV9tpAbcNXYTiO2kVkk4xXnHFU4sS9R5vgR03uoyWL?=
 =?us-ascii?Q?bImLOiFxEtXj8DeusRFrEAzz8w0S/wpVIcUIBpmHT1cNqaHOO9iVeWKHAcfj?=
 =?us-ascii?Q?HZR1/+jlJIMRPh2teioas1mnlZBBRe0m8cbdcMhwM5g5QhmG73/ToXp9IYrC?=
 =?us-ascii?Q?SyZT6TN7IEEf3LMxQOrp/+S+WBgEt6/vlr/GfmLlBMky3WLbcPbYnx2R7JCT?=
 =?us-ascii?Q?5x6THY5OKocuqCj1GJYPosztyyEuPyXF3jXvxlJU2NtfnM8jvkXmins5U7M3?=
 =?us-ascii?Q?R0eTG6T1qCXswzUrBzGr35IIus78nUTkQSbO0g3IRi5FxcDUx9CxXL8UU0aJ?=
 =?us-ascii?Q?ghXlS8Z2HnQ9HrC8QjgW5ttvIp/qgzFThz/wpUXGntrunwJiER5G/fUrAaLU?=
 =?us-ascii?Q?DKy0sGx1/8L270IFtQqmxM4cSBVxmdaL/dov+zkY+pQ8Yl5+T7+YUmH7VAxp?=
 =?us-ascii?Q?7Bi0ujmIjOWt7hKSn/Z6IovaaZMWzDCV+boyHO25qqBV3qfuLilEJfGbSQDb?=
 =?us-ascii?Q?dQNuVfCExVLIcvHe8gW4t/8ITnpoVSC6ST/Pn7pfogSIquVU92UDLGL3JP/k?=
 =?us-ascii?Q?dV1VFiomzgNTj/fcvTTkOhkWl3rlnFZ4cqKzYwEAmhDDBuAKgtTucAJhyo1L?=
 =?us-ascii?Q?/hcJ689QbkFP/hfHEH7SJvD2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/W2WU7xKXcnq8Lw5Wyflqp7YYc0SsESGH2vLRB4jV4ECZNdBrtoTCfPubrx?=
 =?us-ascii?Q?Q95TLw51uOJzqZOj+kr0//zzg42g11rIEhKC7GZJrCxnfMk8rUUSbz5zWTCe?=
 =?us-ascii?Q?y9AGkm+JaDwBgZamhLSly0X1fxdQ3BOmaQ1ie4fgLHc30LFvyM7e1Ve0u8ZM?=
 =?us-ascii?Q?XYez4HeOF+pCHHK8OFK7IFAyJck0Ikmxc2mumJtaO6I42jJmcwJETP4/mFbb?=
 =?us-ascii?Q?kxyXmFsqdX66gDXmOP8HHE3HkqIDzbfhk2fFGcHZ1BCVWBKPwT0qm1EUWXj6?=
 =?us-ascii?Q?ykLhzn3nVskZbDuOBNdFnJ15gu4yE5BgdVT4x5GjFhwco8O3Puoo/NOgUk9v?=
 =?us-ascii?Q?g82hD7vU+DXp5Ush2fALJJTRvpgCLE182MPjTATK4BWgUK/Y9b3+eR3xDNoW?=
 =?us-ascii?Q?MzcvFpl5p3kNmMDdqFj2/0gNL2SlsiCPKv0fW9+vQ3a2VOuAY+lixZB5W502?=
 =?us-ascii?Q?HS+Hpdg5AMLSP1phnNFX3rEyHM93onbOsdkCShkpu8vZl1uCMig/Yl1htMM7?=
 =?us-ascii?Q?yqicqcFf1H4LtefpDWn8fFZ5cJ/+G7DJ8PfOGGe9GmuS4XDTYva6m1jQLQ4C?=
 =?us-ascii?Q?qWBuhtfjBQHh/WmHxnUbUHYTc1tjU4cMJDahU9Jo8I2P6oD5vSwAiuP354v9?=
 =?us-ascii?Q?axIg5U8K6y/ygdXAeHhuGOb1ybPjlj6m0fDGLX944JI0Cfw+jSsnu/BjXae2?=
 =?us-ascii?Q?8Z7kLgQJklgsEJfZJHLvys0S/UbNXaqEyeh20C5TiDCMr6sOy14hAG/nJ3/j?=
 =?us-ascii?Q?SXINOj9/Ie8R80ktJ1cflzQ0LSK5spq2X4avXwwRmjgLiqX3I55TH+9kkZrr?=
 =?us-ascii?Q?t/Yd4S/Kg967V6Dm5pNJgnv3VD6UpHut6jFELT6GaH7iiSRBUtu2JDkkzm7Z?=
 =?us-ascii?Q?im7qK9ez3M1Je9+GhYLCZ2SHUcWax1fd7lo6Ihq9YlEP5ZudRWz8JADOPcXu?=
 =?us-ascii?Q?WnwOeXlsu9YGo76Tc4exykzb/zvEoyaahKKMpDZdnTg3ws3c7RVepdCnrcST?=
 =?us-ascii?Q?jfAUrezETvpF4HYfH9LGskCtFQ47AKUed4iWRxZ7tAjrHjZJAnazWqZxFFIe?=
 =?us-ascii?Q?lWm4zsmu0O1d0fJm+f45SmWogapMDdowz3gIfK+SGFuCysDYc44J1Z73ao71?=
 =?us-ascii?Q?uj01sBaKJZncyQXsYvieT5ioOBOlSsOQ58w1CPA2ebiIKMPm3QH9vzUADrdV?=
 =?us-ascii?Q?f2eWvRkWPvl83/iqJUsgjrqU6tiJfB57mte8if5E2KeJzP4fR/xPrrNtaC3r?=
 =?us-ascii?Q?5P7cL2tZwS9BuXZlunbXs1NZg9qQstJfJgb7zPe0jqKPqCZGDSwc9FrFFLQl?=
 =?us-ascii?Q?pR2ifcxql+T5PTN1efGPA5xEXVvcHiLCwmXEcTDV8xo8AzWcuPmvKlMHOYAN?=
 =?us-ascii?Q?f6ZC05k/F6fA/n2x4VnhD7bxItALr3Z8/P6/A7Wi2BhjLh/1AVmMXpgQoE+i?=
 =?us-ascii?Q?F1UD2BgKu2nYGdeYVJXQH1dw0NZJBAD3WzK0B7VvPlIwuistvsto2zTo+IU8?=
 =?us-ascii?Q?6aO8MC52nE0byi3QucpPL2kOD3MZKa0MIfuXGcynyJcTc15tzXb6uRYfIFJd?=
 =?us-ascii?Q?63UTUxn75oTchURbbDYk9nr+g+4K3jipjYtCyXNsmkBEL7DJUl+78+axzGBP?=
 =?us-ascii?Q?sWNYpl7J9YHtNUWHnfo/t8FUVQJdbzAJt7snkUw4AcaNTCWu/kfE7Xozdz/2?=
 =?us-ascii?Q?9DG6Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hr/Ht6vVnk3uVgmUoQpDgty7kF4QojKrS7o8tfUZbzQuDk+4FMwBmtsI/+mQdT0lDay/nySZK9ytuVgyYuG1zSpeZHZY+HgyuzKu93Qfar86yjgiL6Xl2JJYSeZlKLUOeApWv6hIy/J01qhsNDo0R1sKNrSfmlfMiJ5T8RqCBc5S/fHSy/MZJH0rRu5LJ1SqWJFbKVWRND3q1Sryk4BpH0WGIyNj7u/xIQVw3Fmif7x0Sa8o1U975ZWKsimkxdjk1Q8MXV9VZEOhZht6MUIYBSTM0Qh+NcQF++FNFhql0TqxQkp829jSE0ZnHJnkM+LNPCDaLeSIrWaU+RXuR2k9NC3FckZMoR2UFVQjFR2sNxJwSeqVHlRkYH0sBjLq3r/UeSqlHKuTE/9u6SIWCUVVYaTKtm3GZjs5Z+B0L/9zcmDl4sadwlNcGIZRl9IdSeAhx8H39NB2R9Xd4cMKWoc5kmoyO6iy5x1dkhisUBaDwwZtOdOZBFigJnm5Q4aO4eLqzb4oiXG/1T5rrpB0PqfjfrnNKiAdohAwn0TmBGXLmfQwLp88UzAbAHjEOEWvfVZjBMIABUfsjyNcskBz/SRbjzHY21AbmCYCHGq7Mosqa10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b1c8f-931c-436b-9cde-08dcc806827f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 08:42:26.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7HMBmwZe64BeCBe0rXkETH1MBNACQqtKpwvO+oT/9RWpXspJ8H7NIMSSsYAJIx3Pw6pUCq7BRJiSFg27edmrF0FI5+bZ9J+6ERIVV7BUJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290063
X-Proofpoint-ORIG-GUID: WmHZAD_dT9gwh9heu3somWKwdsJUY1D9
X-Proofpoint-GUID: WmHZAD_dT9gwh9heu3somWKwdsJUY1D9

On Thu, Aug 29, 2024 at 12:15:57AM GMT, Charlie Jenkins wrote:
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the 48-bit address space,
> unless the hint address uses more than 47 bits (the 48th bit is reserved
> for the kernel address space).

I'm still confused as to why, if an mmap flag is desired, and thus programs
are having to be heavily modified and controlled to be able to do this, why
you can't just do an mmap() with PROT_NONE early, around a hinted address
that, sits below the required limit, and then mprotect() or mmap() over it?

Your feature is a major adjustment to mmap(), it needs to be pretty
significantly justified, especially if taking up a new flag.

>
> The riscv architecture needs a way to similarly restrict the virtual
> address space. On the riscv port of OpenJDK an error is thrown if
> attempted to run on the 57-bit address space, called sv57 [1].  golang
> has a comment that sv57 support is not complete, but there are some
> workarounds to get it to mostly work [2].
>
> These applications work on x86 because x86 does an implicit 47-bit
> restriction of mmap() address that contain a hint address that is less
> than 48 bits.

You mean x86 _has_ to limit to physically available bits in a canonical
format :) this will not be the case for 5-page table levels though...

>
> Instead of implicitly restricting the address space on riscv (or any
> current/future architecture), a flag would allow users to opt-in to this
> behavior rather than opt-out as is done on other architectures. This is
> desirable because it is a small class of applications that do pointer
> masking.

I raised this last time and you didn't seem to address it so to be more
blunt:

I don't understand why this needs to be an mmap() flag. From this it seems
the whole process needs allocations to be below a certain limit.

That _could_ be achieved through a 'personality' or similar (though a
personality is on/off, rather than allowing configuration so maybe
something else would be needed).

From what you're saying 57-bit is all you really need right? So maybe
ADDR_LIMIT_57BIT?

I don't see how you're going to actually enforce this in a process either
via an mmap flag, as a library might decide not to use it, so you'd need to
control the allocator, the thread library implementation, and everything
that might allocate.

Liam also raised various points about VMA particulars that I'm not sure are
addressed either.

I just find it hard to believe that everything will fit together.

I'd _really_ need to be convinced that this MAP_ flag is justified, and I"m
just not.

>
> This flag will also allow seemless compatibility between all
> architectures, so applications like Go and OpenJDK that use bits in a
> virtual address can request the exact number of bits they need in a
> generic way. The flag can be checked inside of vm_unmapped_area() so
> that this flag does not have to be handled individually by each
> architecture.

I'm still very unconvinced and feel the bar needs to be high for making
changes like this that carry maintainership burden.

So for me, it's a no really as an overall concept.

Happy to be convinced otherwise, however... (I may be missing details or
context that provide more justification).

>
> Link:
> https://github.com/openjdk/jdk/blob/f080b4bb8a75284db1b6037f8c00ef3b1ef1add1/src/hotspot/cpu/riscv/vm_version_riscv.cpp#L79
> [1]
> Link:
> https://github.com/golang/go/blob/9e8ea567c838574a0f14538c0bbbd83c3215aa55/src/runtime/tagptr_64bit.go#L47
> [2]
>
> To: Arnd Bergmann <arnd@arndb.de>
> To: Richard Henderson <richard.henderson@linaro.org>
> To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> To: Matt Turner <mattst88@gmail.com>
> To: Vineet Gupta <vgupta@kernel.org>
> To: Russell King <linux@armlinux.org.uk>
> To: Guo Ren <guoren@kernel.org>
> To: Huacai Chen <chenhuacai@kernel.org>
> To: WANG Xuerui <kernel@xen0n.name>
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> To: Helge Deller <deller@gmx.de>
> To: Michael Ellerman <mpe@ellerman.id.au>
> To: Nicholas Piggin <npiggin@gmail.com>
> To: Christophe Leroy <christophe.leroy@csgroup.eu>
> To: Naveen N Rao <naveen@kernel.org>
> To: Alexander Gordeev <agordeev@linux.ibm.com>
> To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> To: Heiko Carstens <hca@linux.ibm.com>
> To: Vasily Gorbik <gor@linux.ibm.com>
> To: Christian Borntraeger <borntraeger@linux.ibm.com>
> To: Sven Schnelle <svens@linux.ibm.com>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> To: David S. Miller <davem@davemloft.net>
> To: Andreas Larsson <andreas@gaisler.com>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Ingo Molnar <mingo@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Andy Lutomirski <luto@kernel.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Muchun Song <muchun.song@linux.dev>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Liam R. Howlett <Liam.Howlett@oracle.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> To: Shuah Khan <shuah@kernel.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> Changes in v2:
> - Added much greater detail to cover letter
> - Removed all code that touched architecture specific code and was able
>   to factor this out into all generic functions, except for flags that
>   needed to be added to vm_unmapped_area_info
> - Made this an RFC since I have only tested it on riscv and x86
> - Link to v1: https://lore.kernel.org/r/20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com
>
> ---
> Charlie Jenkins (4):
>       mm: Add MAP_BELOW_HINT
>       mm: Add hint and mmap_flags to struct vm_unmapped_area_info
>       mm: Support MAP_BELOW_HINT in vm_unmapped_area()
>       selftests/mm: Create MAP_BELOW_HINT test
>
>  arch/alpha/kernel/osf_sys.c                  |  2 ++
>  arch/arc/mm/mmap.c                           |  3 +++
>  arch/arm/mm/mmap.c                           |  7 ++++++
>  arch/csky/abiv1/mmap.c                       |  3 +++
>  arch/loongarch/mm/mmap.c                     |  3 +++
>  arch/mips/mm/mmap.c                          |  3 +++
>  arch/parisc/kernel/sys_parisc.c              |  3 +++
>  arch/powerpc/mm/book3s64/slice.c             |  7 ++++++
>  arch/s390/mm/hugetlbpage.c                   |  4 ++++
>  arch/s390/mm/mmap.c                          |  6 ++++++
>  arch/sh/mm/mmap.c                            |  6 ++++++
>  arch/sparc/kernel/sys_sparc_32.c             |  3 +++
>  arch/sparc/kernel/sys_sparc_64.c             |  6 ++++++
>  arch/sparc/mm/hugetlbpage.c                  |  4 ++++
>  arch/x86/kernel/sys_x86_64.c                 |  6 ++++++
>  arch/x86/mm/hugetlbpage.c                    |  4 ++++
>  fs/hugetlbfs/inode.c                         |  4 ++++
>  include/linux/mm.h                           |  2 ++
>  include/uapi/asm-generic/mman-common.h       |  1 +
>  mm/mmap.c                                    |  9 ++++++++
>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>  tools/testing/selftests/mm/Makefile          |  1 +
>  tools/testing/selftests/mm/map_below_hint.c  | 32 ++++++++++++++++++++++++++++
>  23 files changed, 120 insertions(+)
> ---
> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55
> --
> - Charlie
>

