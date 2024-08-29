Return-Path: <linux-arch+bounces-6821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9500964F1D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627C6282B4F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E341BA896;
	Thu, 29 Aug 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nAK3X7AE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B9SPjI+T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541391BA882;
	Thu, 29 Aug 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960315; cv=fail; b=MLvR/ieIQuYWWoWxev4c7Y7/yrwoqvfXCxe/mWL8ZlFAYothqh/L7WAmQjtZVUm6JClfcDZ0OS4pc6xT8E4LTMZrgVceLGmUktDf/nBblF3kfYxz+oN2D2rt+EJ2Y0rRka50RZMkmKybnyyuehpAk8vNH3ORo8wJyD6F5XMzKj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960315; c=relaxed/simple;
	bh=9v5RD/RzQ9ldiDfs5XuHJVkwrN0OdZzpXrNgvWBnJo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atMi8mhSrm12yw/sufKE8iUaa7OXofso3f/Ru78MUxRyUQtdPr8n1KCLBSS3HFJKOqG7tEC1Zb0xBOkarITER1Zk08jId1z1EN0SbAcEIY09SkNj6ZDwXec4oYUpnWmYlq5iJdzJpXkjN6GS8koMpTZ3+cJwBQ8P4o/rgBHmgUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nAK3X7AE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B9SPjI+T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIQVw6007780;
	Thu, 29 Aug 2024 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=A4bF0tv21Lzyl5Y
	EqZ91Xd9AD3HPBJOSyeHvQ0gLRuo=; b=nAK3X7AE9VTEcBQMc5rql9m7Zrbjlav
	w9Zn2iXpHrlMdGvmIzQta8+gUjvg8As+u8tisHUruVWIdJWtfJ5a844AmgeTSAqa
	jCa5+6SptE5HVH8wGYcq+R7Iy0BfZEMnXZpwAGFNuc4HrYtDuv/2HhMpouqoNSZJ
	fTLnJg7jIsscFfXQoeWMeXkV/0M8gwKaXMcFoxVA2AQxnzbT2FFFSSVh76FmOQHJ
	YkACAVa7S7FWdXAeEWdX5D1+r66YezCOweNP1+nkAsuYxqGZu2tdrStWVQjIzmZS
	dlc8rfkAOy9Y18kkYSpWFUpQOU6On6jgwT5qvofsvtRWGmqPQa+CUhg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukn0gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 19:36:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIkn0H009921;
	Thu, 29 Aug 2024 19:36:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894r6349-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 19:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z314/sfozdeL+S3V/5EXtelQg+c7U21rBZhmWlxgNANsYGC+eOG5zqboPHDANiqihKoifEuxCYosxCujSY/tYNjZUAv8uSQdtktSRuLexWxXnIFpNa1vRCwKAVKkE6yhGfOH9iMBsWhErQLTpja43paogqspeE0YCtrnpTdXcCZRziRvxSQ4m4P/fThPpeD2owlPKdVflOwhS91hBMgJnUDhkuS4KhThywdqNzxbKgGrCubxgAFzm2TIXIDBqERuoyx2zu/HDK/whcyu/e7jTuvkiVlPs/VXZK/8+i8IejC2fVvh8Vf8OPPhvHZ63WTUyTHv1S9iUfeLLLBNOhZBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4bF0tv21Lzyl5YEqZ91Xd9AD3HPBJOSyeHvQ0gLRuo=;
 b=M2UnAd270KhjFvMnH64Qeoo9X4rozztuRsG1BIvG2ZalBD2d8qZcogpYoOzwcQsfUzOvNHawTc9MAxUH0MuI8W/x7b/CZ2cl15Cq01+FcnhGIgPWuKpeRTwqHfDpwnrgDMeLiAnnEy2VFI38M4CWf+MRVOStyHJzhktDRWvscFKmcCoyfoOfFSrBMXM3duu//6XUU6VnvfpW5wsqki93XlobG04NqKm8fbDDkrPJM4lhiGTEFiLsGKzpTXwm44aC6893NkMV/qERCSREfNgM68r+KGXPru1ihMmC9yXv4sz/gv+MeANLAQKPPNHvfiKVpfRdPsYQTiAhiGFA1Czhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4bF0tv21Lzyl5YEqZ91Xd9AD3HPBJOSyeHvQ0gLRuo=;
 b=B9SPjI+T3LmS6dEjS3s5gix7Vrsc39XUrgJwxIJhm6Fyry44pwN5Q72KVSVv/c60d2LbrV7OEfmzuNJjiUWg31dA/PU8fttHwS0N2iL0CeEQSjL/NsYJyYIC3PQgGJfAOvhfrNWW4d3Ips4kcTVNt7+1/FMvb8GQwdjHHLtTVLU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6105.namprd10.prod.outlook.com (2603:10b6:510:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 19:36:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 19:36:48 +0000
Date: Thu, 29 Aug 2024 15:36:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/16] mm: Introduce MAP_BELOW_HINT
Message-ID: <pzxlpwxbrs3pali53bogsorwebi45ayqivxmpeagrhvdh7zt4u@ybsa2vnkze7v>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <fd1b8016-e73d-4535-9c67-579ab994351f@intel.com>
 <Zs+FYbII0ewwdisg@ghost>
 <4219f619-4b32-40bc-85b8-cb11d76fde98@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4219f619-4b32-40bc-85b8-cb11d76fde98@intel.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7e7223-ff91-4d5a-67e7-08dcc861ec4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8lvxFLTrJHtqzCQ6aCAPAvZ/2z4P0ry/7ebdrKgbsNzj92Sy+7OtLZWHKz8I?=
 =?us-ascii?Q?If728pyRmCLEmG1h2RSGBIkqqiM879fFPtxP0VE6ug4aqBfJTjkxXkDZN7T3?=
 =?us-ascii?Q?TywXkGKNrMuVapTEA3RwaH2Us1W1BuIToM4HABtu9Qc180DAo+1WmVXPmfwk?=
 =?us-ascii?Q?o6lQoh4BLw0thv4v7pOoJX27htETDzobGm8NLHxJ5LC3e6BuPcewx8p+96YZ?=
 =?us-ascii?Q?iQZvy13jazntuipmndCAiw32rj/O9IEPEPzboUaSWQ7/YCh5eU6RPBrTUWtM?=
 =?us-ascii?Q?wK7bfB9/Fm6e6w8579uut1fAJaycfO93exRcypNq+g4sDPa8xjnu6NVhKQOD?=
 =?us-ascii?Q?AsQ2UfJ8BiU94GPdRtGm3k2HB710UkIw2HpNVu2D5oqKBJXj8aIDTpJ8T625?=
 =?us-ascii?Q?Q1jZs7zcwIUr1BXVn96HZFoejKKagfsqCe8rWrcbkltilOMb914FOiQ5pyVk?=
 =?us-ascii?Q?2ouurqu8FiC68rfLNVpA6W7LM0HGMd/jFSpa3FZRebtUWlD8p7zqAlZyD9JM?=
 =?us-ascii?Q?Y0Lz8F6uJG6sx4k/gDPZevFti+nVj2wEnzXArNnCwzSUUJ4Vf+IazZeSBafG?=
 =?us-ascii?Q?9yxXz+kNmNSwND0rDW3IumNAN5iTllW4l2ZRzv1bcpgjQMHIL26Z4WXdV8jr?=
 =?us-ascii?Q?+mmkIfe0BWfbl7kjtbgcurmeUEhozhO+G9PaUZoPEI2/Vj1FhjEF75gbQjZy?=
 =?us-ascii?Q?SWfqRSOhZebdHO3wzA8ne6ydZS+e8HeJHIMGr9uMgv/xMBuN0hz4qMi0D7Pm?=
 =?us-ascii?Q?igAl9oe0aty3pzkSxCM78e3dhfOssBNIlFdtwBkA+GBP5T/sqpmHnhqF/hbJ?=
 =?us-ascii?Q?XbnYF/w4rH4EOSSAvWAeahQCkp+KSNOfx1YveolJtoNND9HUDFS9vRYqF0bg?=
 =?us-ascii?Q?J6rq5ZYAReTY5d3exrwqG5c79TgfatkGrg3NwOiSGd5FulExUqGIRON04Xj4?=
 =?us-ascii?Q?Jbz0ZSwv6xXu8fPWNvxCjWPEpfroWeGlMXqu+uGr9TQs6dYhtCH0Zdfear4x?=
 =?us-ascii?Q?RLQEUqvPQ6fyvpe7Yiv3Oj5UNAGzywZAOX9OH2WDCC07nF8wpCjzeqtmkxmc?=
 =?us-ascii?Q?flCoO/QMT364rj4ImeFwFB5LJ0w1iPKH/tNz51tGuYF30f1RftSajmq5A/mu?=
 =?us-ascii?Q?v3cC34zSzpPllAuEN4os3llQHkkQ1HbNwkmDubTJwdjw8b4AlrBUHIfiw+ar?=
 =?us-ascii?Q?wcI2zIvfdu9mhQEVOjyxdcM7IceURUuOnSsFOyTXXmcH850wx0ZF7qqBckSq?=
 =?us-ascii?Q?qd4BjxkRz/DXX3hBOCU4aG3u9+CsDtoCXTQfIzuAidzRrZHdlACzAWG4cH8s?=
 =?us-ascii?Q?xDak57DTnKW0WkgpMBlT8k7zR9npRsxDA8eVz+DHcAKORw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fdGr47NrTHD62dOMwXA1Xgr+hAR/R7pctSGTug+Qc32Y/62AAiE0HWnGi1AO?=
 =?us-ascii?Q?TFKbTvI7J/3iYD1VctjSFh2GM3zLfAd2+LkmJXdDFVbI7tMBJSrRY8hQ6DCA?=
 =?us-ascii?Q?3mMGTEo7pH8mk97L7R/NMYkoN+zRh7Z2MgJxn/pVFivfPu6xD+Z8CdP85BXv?=
 =?us-ascii?Q?ORa7za35AaRZvKsBh9WFAevGmAAmnVs5m420KLuUr5Z2qRVrwAqiAYd5jmOO?=
 =?us-ascii?Q?piJujbCr8R+k8Pv7SlkxuUvss5eFW4h7mnumSfbYoEa3BQvHJnVA+DbjD1G5?=
 =?us-ascii?Q?XFU4W81QOzeMrHxfqEGNDBmTl8OI2y8oFBVyJ7BHeLU6FB7feiMwWnBWK7l4?=
 =?us-ascii?Q?KYm4JJR/tZNGo5Ahoy+YTrlDV/Hf/VHwqiLtQEIMEJ5eieAlTaWfdsvzIsPM?=
 =?us-ascii?Q?rC30U370ONyLWW8GW6ZcLKQ7vwJFH07ytTH6cLLEFqy1EKb6GLyip753h4+S?=
 =?us-ascii?Q?mGG7e1YTiExVLcbildpxYUbRH1EmEydlKNXL1FWpQCYmelfHgMLzyL6ySFAh?=
 =?us-ascii?Q?YI18f7wNZrJVgxcBsRCcJIBOBwNu3rfBFvAQbXF9BrMSlOqOmCgTv4XkL/jT?=
 =?us-ascii?Q?qDxF2Q6ZIv1m+rla1DvokXjctzYpxKhd9wC7AVVGkdzJTDk6rYGQ3HiE+67u?=
 =?us-ascii?Q?dRRAo3Xno52WYDnA1kNrSkF4k7z03KRuFtWql6kDMr5zwfvf/ImgOwhSSJ+N?=
 =?us-ascii?Q?/LBaUIcBTNnYgA1owni3G6jslnjj3J5NkTW9J/AvnRjVUClBsHiNCoaMdyql?=
 =?us-ascii?Q?WmmondBUTxd3vpKGe8dXLCAjdMv34b3D5ruONaasFcsG3QpFoDGx1FJRRH75?=
 =?us-ascii?Q?0n5wy/saHMgMTDa2hXxuZGsWDB9ABwKZHCuMqp38sLIBAHPtBNBaIxfWjLiV?=
 =?us-ascii?Q?BQd6MMTSsJK+TKHL9Z8Ry/7jcw0xlG2wyVSK1ijVtuGMzCwBJIczIsPC0UwK?=
 =?us-ascii?Q?uAlmW2uQO1+GdcRvSDcQIexFFmeRi2JvYUSh7p2E6m2Xp4H3ymePS6OCf7Ui?=
 =?us-ascii?Q?vaQafVi41keJzhSEaQryAqz4H1MXfeN/KYxRVA4LJo+NqPSnxJK8g98iT9IT?=
 =?us-ascii?Q?nDfu18Y8vKMNGSKU1i11gbrboL3z8SSz/iA6j4y+mhnOc8U0Kb1W5BMwu/TM?=
 =?us-ascii?Q?Yj5jzECZT/3mT813k0Kp2lbq7VyNOFx6rYFbxeg0w+kuZ5xZG1eANp0TIfTB?=
 =?us-ascii?Q?IhscvTdYszngRVJ8jglhughgMFAPRily3Uj8uaylOskSe+PD47crfeXW3mAf?=
 =?us-ascii?Q?1s7Pzpg5nf/98ykQnZPvJ55Hd3R6ZwLwbt1cTm+ddeBDwYuQpeVsxP3qEN1t?=
 =?us-ascii?Q?GpwwUzXbKlCsHZ/0BqgYZ6MseqjIVwBrTIKrilDNDiHy0rZ4TpMIAUAKjo7g?=
 =?us-ascii?Q?REzhaCzoRPdSj1w1bRvxWex5HM19ea6Fpguz8mdpfmv22zKSWVf+g7CYJLCa?=
 =?us-ascii?Q?KYuccCCI5QSJkU6sI2CSFGOgoLUInkN+/0752KOi6jEC0N9ycBteJ+DXF1em?=
 =?us-ascii?Q?fScjbahJpVNEpSjAGml10424NGjxYyll9kcvOrTQcGIvWHxkZzl+9YoPJ8w0?=
 =?us-ascii?Q?I8fP458oGXAlJ2hafpl0St9xpevFqSzHlL4QJYwh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fx66r49Mb+PAL/WF2CfWk6JTRRMMKwINLbs265Pl961EGCyp77qCy5tlR+jFM+oVoTbReGCZIiHrE41h6a/DQgcD5D9y6hTVtFNVzjFkID3PE9Lki1XrnNxuDVtP4qWAegKrCxuIKpZthlCB2D6wnoHiBwjc7Zry2rL5E2MIJm6la1sfyMTAUCEz4XLrqUrNut1NN2ANCYxbE1udM4LfNMmJf/DNMlj81XHkTXLvY+9cRzkC7CHmtImjnez2MKMvHTpHL7yH8wFnV0rTWzzOXRv9+e+y6uabB7nSawqzMME+L5+9FeNQ0sM26ukXEZcOe05jHNhzBYNNlnH9u+w4gDjOfF9vxESe/yB4KmLGGk+JrwHaSWxx94XERwbBZwXjK485r7m0uRwI0MEcRDFdXTV01Ra/ZCEpTnoooXSaKXLrEoMiVdj0aHNY9DHvZzM8O2iZQLGRAmM0VeJFSo7dZZWuhmysUAZ0EaBkRJSZx4PC0OoWgFS8jQkxYSGyMC1jZHzNWGAjiQk2vsJkN/2M8ToGia4YYcwvuZN3f2D6FmTxfmLaU8aLY3ysDVO+FOr3Y6nqr1+qFy6GR5v6/+XUUunhiJK/om+nAhjy/p/H8Fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7e7223-ff91-4d5a-67e7-08dcc861ec4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 19:36:48.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHrtnWZ7ePK0OQcBUG9CutynZTBMqZD9bftB2fyZHjoT0inZWx07kwe6kiH3B9owkp66y7v7EPeEIH8PY8MarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=946 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290138
X-Proofpoint-GUID: y1FxsZT38_CsZows4z6A-o-mW95F1XX9
X-Proofpoint-ORIG-GUID: y1FxsZT38_CsZows4z6A-o-mW95F1XX9

* Dave Hansen <dave.hansen@intel.com> [240829 12:54]:
> On 8/28/24 13:15, Charlie Jenkins wrote:
> > A way to restrict mmap() to return LAM compliant addresses in an entire
> > address space also doesn't have to be mutually exclusive with this flag.
> > This flag allows for the greatest degree of control from applications.
> > I don't believe there is additionally performance saving that could be
> > achieved by having this be on a per address space basis.
> 
> I agree with you in general.  The MAP_BELOW_HINT _is_ the most flexible.
>  But it's also rather complicated.

There is a (seldom used?) feature of mmap_min_addr, it seems like we
could have an mmap_max_addr.  Would something like that work for your
use case?  Perhaps it would be less intrusive to do something in this
way?  I haven't looked at it in depth and this affects all address
spaces as well (new allocations only).

There is a note on mmap_min_addr about applications that require the
lower addresses, would this mean we'll now have a note about upper
limits?

I really don't understand why you need this at all, to be honest.  If
you know the upper limit you could just MAP_FIXED map a huge guard at
the top of your address space then do whatever you want with those bits.

This will create an entry in the vma tree that no one else will be able
to use, and you can do this in any process you want, for as many bits as
you want.

> 
> My _hope_ would be that a per-address-space property could share at
> least some infrastructure with what x86/LAM and arm/TBI do to the
> address space.  Basically put the restrictions in place for purely
> software reasons instead of the mostly hardware reasons for LAM/TBI.
> 
> Lorenzo also raised some very valid points about a having a generic
> address-restriction ABI.  I'm certainly not discounting those concerns.
> It's not something that can be done lightly.

Yes, I am concerned about supporting this (probably forever) and dancing
around special code that may cause issues, perhaps on an arch that few
have for testing.  I already have so many qemu images for testing, some
of which no longer have valid install media - and basically none of them
use the same code in this area (or have special cases already).  I think
you understand what we are dealing with considering your comments in
your cover letter.

Thanks,
Liam

