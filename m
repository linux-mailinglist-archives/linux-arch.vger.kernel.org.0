Return-Path: <linux-arch+bounces-6729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2496301D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 20:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51E91C20997
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB41A7AF0;
	Wed, 28 Aug 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOkGxwZp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CP+KOIUy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711914EC47;
	Wed, 28 Aug 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870009; cv=fail; b=n3RHqRp9WDtesQQQMDeJw2yruVUMlvrSVwLBiahIyBox4BbSt5pusogKSoMiqzqBhzg8p8meB0fg37ygBGyABsX0GQWlNBwxjVOGCaEPEGu7UGwWwEBOGjpplLMkgus5ZQbcyjBjpXQ0Arox59XWjttUdDnVQMBLfoAzdBNq0sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870009; c=relaxed/simple;
	bh=KUb08RxYvW00qwxesRAseLzQFK7qtsHErRC/4TmA5K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qh+p9yM6fcseONkTJBR6FsM8KasOpgBOUYGvr1pUouhN33VizN8vBuUqZpPeHOaQ1QzdBJavV3K3dF0M1Z7gOhiSDNqyb/X2G3m2WxeK7k1m0ZRCpKlAdjKCX8MlTPjz9CarWXitI7lMlH4s6afisFxFGxIH2yS5ZJ2VaOGnjJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gOkGxwZp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CP+KOIUy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfVp1021897;
	Wed, 28 Aug 2024 18:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FIVQsn18rlBSkpP
	nvNuLhvwxpBhdeYGKE4nE6gegqfw=; b=gOkGxwZpxjQErHduKWkVWLQkZxEQdQ6
	8djzkQ3dCv0uloqDZUTBIia3wqZrxItIpUSPpf6Fj0fWqRMAk08XdW0pqtGUEu4x
	eHCoWrhPDg61IvqSuVOtiw3xNeMqtWlZteJF3fy6irV49O8liEPLhcH1leanebFX
	sAn7GFc8W8T0Dss7bfuaNSS+4mFfw8Qdu+zITJhxdfvNHQRc2XqkGABiYKGuAIoQ
	O6sVM9c98jUnOlTVvilZkFb1F+p81BfUnIYVvXKeHHH4t9Wg7Z78IcEAvacue0PT
	QZzlyFLmvjuDXrRN/73curVkcAeNwMEafvhhkaM7n7HOm2BFSUjnD8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv21t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 18:31:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHes9J034855;
	Wed, 28 Aug 2024 18:31:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189suwc42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 18:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn/T1G7kU7iSAgbDId0WSCI1Do1OQr4HK0kRX29qSvJbyjucp4SR1ii3YZbmIQupi9eOBy2P3uLNVKn0CwemirmQWxxGTu5Ty9Ya2L5jZ5F36mgTNDo8h3lr6B39UJVZMOawsJjTxHouVgRWoKjmRCuXBAZX/7VeAN0hEe4uKUSK/13lO43PON4EGOCcunuDWNJ/vakL9MLiF/kD43w+QK6qdCLPsE5yMe7aA9/La+qxBIBcukKefPE2tRGl9UynHlaivNCXhQQT+7OVgy+KDRW4bB45nTspOQoapO9KTBaQJQWUYCVhyc09IjTUvm5VTG0OEn2TtxzYvEs4lD5Xdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIVQsn18rlBSkpPnvNuLhvwxpBhdeYGKE4nE6gegqfw=;
 b=IF7qFFnxsgqLhMqwmF9q9SMci2mThAOo48H7n9bwWtMIJCv+k+j0HD0957ZMFxtDwl2Ys7nRmt49cxNXwk/AGIu3grRxd7eetmVmv3LtjHIPpubAHClS1qEkzZtKgCp0x9YttP3Ysc1UN1tD12S+VGGFlgrqKrIfYTp8YtTPvqpTjei+ywYPDg+rHePC1Dd6N2BYAoq7cDhRxCkcB97I2mc5Ndj1XvfPGDjBDd6JGzLZ6gCgiGGjs71WWAC1uVJsHW+pYqJrM1ATxhnoxHIi3pJiAITUBTzcphkSX+8lK0pWSYuu240i+MbXL7PJS4XQfUsRyV6uxtVdsog63JIGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIVQsn18rlBSkpPnvNuLhvwxpBhdeYGKE4nE6gegqfw=;
 b=CP+KOIUytsAQ3P1uH5AGkDzHdEs2udVDBvbDGVcWfzO2uhH0esMDtCCKJB7UojqFKFwn1sIqRgCIyz6qFoWEZ9P+IM4xvrkP4i4A1Mpyu0bBC9tB84bV5hAGsU4IKs5Qxdla+uJHob5oS64ffj7zvW+Qau8TsX+2j9VsFRBMv4o=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB5712.namprd10.prod.outlook.com (2603:10b6:806:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 18:31:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 18:31:46 +0000
Date: Wed, 28 Aug 2024 14:31:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <dbqqojpvqodfxavt4fxugoj3a2ppk5b4b3sp77qsmbg33sc2em@fhjccbxaihrh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d16676-a6a7-4d4b-2f56-08dcc78fac3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bUGwSA4ssicU+r4l0kNu2JknupTM+UfocKmHihVtXcoXb9upUVtIVPQ5NJF1?=
 =?us-ascii?Q?s/xs2VpkoR04szTWRUTWSjU8CZdVwLp2SgLwsRkCakesBPYz1OltfJaPaQUL?=
 =?us-ascii?Q?kDVdUp2/CqVT/vPwOQpNSzx91p5gqamaNzlEjm9fTg5gBGfKSQjheKnOuFJ2?=
 =?us-ascii?Q?PRq26+vD5LejvXewEiYEyQG1TwDaoDW7rlqEmgc84QinTw5bHajmcU5QZKAb?=
 =?us-ascii?Q?xmnmTuj9be5YY0fA2ZeGqoB9uPZqeomwPVEjxLjJL4IxIdb8taEaWs334abz?=
 =?us-ascii?Q?kwNoj2eYxP2d2SMgLI+8vj7pPmxwyFYfiDNPQPL8sShIvrEv+VFpsG2ouRam?=
 =?us-ascii?Q?4PrOM1uZvdDRnfOD2Ea1vdi/4kp4+E7YYaazX3o0aUg69E0/TvzXabHZkBdF?=
 =?us-ascii?Q?Cbv5p1eDVX123xHndWMi3SvbM+KaG2vKs1bu5UFUGzxrtlFCAINCB99XP8GI?=
 =?us-ascii?Q?Sj5lpQktTE88phxCZO5G8CxVh9WrOsgvp3CBzFPBvuugT2Lrht8iOZREYymS?=
 =?us-ascii?Q?+83C3KZ9WQ4WZ+vRwtIYGrfygzbdPL8ftyjbE9c1rtzqVmyuxDdui7R7Bwc+?=
 =?us-ascii?Q?mOQncN4B3sLvAE+id1p/NZa5wA6LEqu7+hZMldaJxgyOG6BqcocExTmQrn+r?=
 =?us-ascii?Q?ogk4CdKMLhSbmfyDL1+HS0NfZKvmffxGkVn3C/2kYCwwJqlH3PBJsTK8K+mb?=
 =?us-ascii?Q?XJVUjHM4WsC3FTSr58iS+tY7Kd+0bw9K2P9O1UZZNZLp659L4JRpDxGiM2+w?=
 =?us-ascii?Q?3kv/8HhqvRupiaOnBScEDFrgDL6h1aVk2eSZevqzYif9VMn+Nla/V5HOWWMf?=
 =?us-ascii?Q?danapofD//yD35AUMnAdV03go5CUhOtzI1zT+zWq0i/v/pDerUkRDgYfIb78?=
 =?us-ascii?Q?Hpu9/zoItvXmXscpB1mcxInSsibpeLddsrfmNRXkyIzpkN9/X00HSoASPDRS?=
 =?us-ascii?Q?4aX9swWdHDr1NQjihYX3xD1iuO/ei62B2rGv+GfIbPImh+Gl4e8x6aYum3F4?=
 =?us-ascii?Q?rKRx6v3psPH51C3PZJTV91pYYiMvWcuaH1EjxvTWu/WgmLtsDTe+h1anxEh2?=
 =?us-ascii?Q?SWpVPTAYmkkGeK1wWdIaxJns7FFh9wcLv8dvmo/2vrAi+wl1CJa5u5829EL5?=
 =?us-ascii?Q?i79j+DpP0+izcDsjJjoeJWoCIpJCEAMDf6DlJtu8BzCmCf0tvUqwWYffcty+?=
 =?us-ascii?Q?uoB8qXrkH7PK68XohSuumRHnSD1oFw2+oVtAcLRk+ziJpuPEe+dI1xCSptc8?=
 =?us-ascii?Q?TCOM0hB02Mvsox24J3aMg3NvrJ+0xplMad8RELJtZRVD+jPFzjLI0EwIzzdz?=
 =?us-ascii?Q?80auvAlRfCtbhSReui+m7kCKCx6mNMzr5fkipg0uyn2PDiGD6c29neeNZC6f?=
 =?us-ascii?Q?Itak85U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMQCY53YCdvl0izYGSLpCniBsW5YNDeYn3TL2wYf1xOQ71LM6SLcwcprdmWk?=
 =?us-ascii?Q?MW9vqvO/mtNCIGbwZBv4/+iaFEncUtUEqYh0KDQ9/EnISucjBRlTJ5sbVr8p?=
 =?us-ascii?Q?yWU2Xry/0C3pu4LB9sgTtPgJrDM8UKOU4RTfTs/hcNM7D9iyPdBTM+9u6ptS?=
 =?us-ascii?Q?0eB0g6BAMWRytSHyR8wU2aVTPF/tqpmlTR/PQFKg1RJVewTVYZMLH2smSsUz?=
 =?us-ascii?Q?4+sj4pnXKAece/rM/KmwUre5G0F4lv05VwAyc4nO5e221JUaD9mmJnIgIg53?=
 =?us-ascii?Q?0Uzdzpes+AGuKFXWMzFUTiAvBfrdyfBpjMONlEdkz9wnZ/KxsSeyE+KjKdOu?=
 =?us-ascii?Q?AyPKmpfcJIbywI+rj9IEFi2PqY/nwvCIcLKaN8S971Hm7L6+8Nn+wIQlM1i/?=
 =?us-ascii?Q?09Shj0gSPiJfRLFmZJWyilqoPgxP2Ham9JY2ISrar+rzsiCN1l9dWcmbCAzG?=
 =?us-ascii?Q?g66svDCmgHdvPyqr8iLxzz3qf9Z/NongQVOOi9BZX/z0p/nm3MWHSBY6/x6e?=
 =?us-ascii?Q?bc6iY6nh6tBiLGu8LDs1EKjrczFhi47Oi7vK7mGuI1cVrS25x/QAOtSpOwVe?=
 =?us-ascii?Q?eRv09mgouRWo2WzVJVrGeWXql3SYFByaxr7n4jhXEW0v92BJysM5lpsZnsox?=
 =?us-ascii?Q?sLjhbaXOiWxl6yWsKs5Kd18Wkmo1/jr06q2WqgStQc2ki6DC1j0nxOdzv8Df?=
 =?us-ascii?Q?D/fePekeAi8BRJ3c42V7MGJwzVRf+O2I3FD3GX8HnI6WczBjLtaIkVKsGN60?=
 =?us-ascii?Q?fbXeoffQgXwMXRGg6X3Rhur/dWbcmlXnsVWFgqmUQGG+kQNvTPE/c4Nk8Hmj?=
 =?us-ascii?Q?hQ+gkw1w7XpFCYyubKHiFzYm6uSOHfC/oDFsHJefNeqDiQ34yn7M+LC7toMh?=
 =?us-ascii?Q?ZHYQ449CVEHvLL2koqmcuIqZqc65pJXXlsdL6odrO9LrOk2CACmAzVNnu1YG?=
 =?us-ascii?Q?zIwgduKQBq+rYhrMN4v3fLjoFtor5JG4jxsre1PtLQIxmL1ot671ucZSuvbW?=
 =?us-ascii?Q?ePMRCsWp+k9SZ9PepH5NJOmK+DxHFOc4NpsBFYfovgVnRMFGPRQwxKqYZHcF?=
 =?us-ascii?Q?9uwVUpx37Ynqed+4SB95aRjrs/L2+Pe/P3Ry7JGENie5d9+RykwDIaAi729+?=
 =?us-ascii?Q?pTpOVYmpPNItZ3PCv27aU9YXMU527aQdOaeV0Xpa52nBYi9EO966PdI1luCb?=
 =?us-ascii?Q?NloPHrT+4xar3Uw5QY0Gl5pCwbtyIfEfTtqk7sVb7EA4IGbhy+tKBjOVlwgv?=
 =?us-ascii?Q?z/Q91c9Jq7//LNfFwf5urSKxkOJzctbnM/6WBL0nPA7aRPPlwOhzVdsFQCI+?=
 =?us-ascii?Q?QJMXoxx1zNcXDBOTbUw9MOMro5DqaPg1kf5aB/b4aj5ECvyxqavO8Jugy9li?=
 =?us-ascii?Q?RdOsmSJ63EuO8IRc5TQNYSXotT3QC7emXXVqmB0UKyEQGCOn1LmsxfZicfWV?=
 =?us-ascii?Q?SWmGHJPl/RdZmo7kU1wPP7fY8GC7VYUiETYNf9+ohjRKGpTq0NkNw7cxAHsb?=
 =?us-ascii?Q?R3DaUktTK/dD7752uFHuce8Y/ctv/+/wdGkr5an9dbuLckVBpNj2D3ZsVLyv?=
 =?us-ascii?Q?wpTGM9rWXWspDvQysJvn3uCsK16q5UWLYWPwxUqG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nUy1fCco4C+bto26Y4wjpW8tuE422XZLlyxcsIqPpTgBTdOUHvAb49dTxpY7AnKtAqIO8g81Hw24yZ39GECDHeVlwgW0vI89qczj3zPaQ/b4ZdgcR3qAGlh7SPWuTAYvJeBRUNVoeSoeD5cPHoB9/h/9z3NqMnoSxlY9lclF5QfVWwqjFbCnU02cjfez/H0SqJ5/FQxMGKLzt9D8qfAUJbOnXava/4QEXa4gYCKnKi+AADmmksZ89qO1PAqNbRiTKmRWGp9FOXx20xER/vxsdXtbrGkSGdapNs5rYNzu9Rob1qXpzY4tI8Ec7asyqIrcer0AEBBtGAjZdp9/V5uHQ9Y7M3jPYDHIoGtxvfimKNJFVYqZXQ51pOI4bhj7sjUfUiS4/aAJEpGul+K3WnTPZHGoFhUukjS7eLXecJvUPd/y4t4gBVQsK60W5YwhW/4nKttv+7Cy4hn3LiEs1zjoTUTGeIbUvJTHDqCd5xTLyQEl/HlM607KC5f0nt9m19XV8nM+hbcr9hC5qGh+9iDAZLZ95cwEgEJmJMvQKk9KsKOW284cM488uWhku7tS2VS6yk2v92ApKLhDi2a9Z7w6umQDgLLOBecZXxBV1UdDis4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d16676-a6a7-4d4b-2f56-08dcc78fac3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:31:46.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEPo3PNDuOhZNGZmVkgh1jSsosdCW3DdCY/g5mGH6mmxlSEYHmy856wGVF3K928ELWhdzcQeoeh0fWJMy+2M7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280134
X-Proofpoint-GUID: HA0XqB4aPZdxQHaOYUy_Tr6_5YdCuDfH
X-Proofpoint-ORIG-GUID: HA0XqB4aPZdxQHaOYUy_Tr6_5YdCuDfH

* Charlie Jenkins <charlie@rivosinc.com> [240828 01:49]:
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the maximum address space,
> unless the hint address is greater than this value.

Wait, what arch(s) allows for greater than the max?  The passed hint
should be where we start searching, but we go to the lower limit then
start at the hint and search up (or vice-versa on the directions).

I don't understand how unmapping works on a higher address; we would
fail to free it on termination of the application.

Also, there are archs that map outside of the VMAs, which are freed by
freeing from the prev->vm_end to next->vm_start, so I don't understand
what that looks like in this reality as well.

> 
> On arm64 this barrier is at 52 bits and on x86 it is at 56 bits. This
> flag allows applications a way to specify exactly how many bits they
> want to be left unused by mmap. This eliminates the need for
> applications to know the page table hierarchy of the system to be able
> to reason which addresses mmap will be allowed to return.

But, why do they need to know today?  We have a limit for this don't we?

Also, these upper limits are how some archs use the upper bits that you
are trying to use.

> 
> ---
> riscv made this feature of mmap returning addresses less than the hint
> address the default behavior. This was in contrast to the implementation
> of x86/arm64 that have a single boundary at the 5-level page table
> region. However this restriction proved too great -- the reduced
> address space when using a hint address was too small.

Yes, the hint is used to group things close together so it would
literally be random chance on if you have enough room or not (aslr and
all).

> 
> A patch for riscv [1] reverts the behavior that broke userspace. This
> series serves to make this feature available to all architectures.

I don't fully understand this statement, you say it broke userspace so
now you are porting it to everyone?  This reads as if you are braking
the userspace on all architectures :)

If you fail to find room below, then your application fails as there is
no way to get the upper bits you need.  It would be better to fix this
in userspace - if your application is returned too high an address, then
free it and exit because it's going to fail anyways.

> 
> I have only tested on riscv and x86.

This should be an RFC then.

> There is a tremendous amount of
> duplicated code in mmap so the implementations across architectures I
> believe should be mostly consistent. I added this feature to all
> architectures that implement either
> arch_get_mmap_end()/arch_get_mmap_base() or
> arch_get_unmapped_area_topdown()/arch_get_unmapped_area(). I also added
> it to the default behavior for arch_get_mmap_end()/arch_get_mmap_base().

Way too much duplicate code.  We should be figuring out how to make this
all work with the same code.

This is going to make the cloned code problem worse.

> 
> Link: https://lore.kernel.org/lkml/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/T/ [1]
> 
> To: Arnd Bergmann <arnd@arndb.de>
> To: Paul Walmsley <paul.walmsley@sifive.com>
> To: Palmer Dabbelt <palmer@dabbelt.com>
> To: Albert Ou <aou@eecs.berkeley.edu>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> To: Michael Ellerman <mpe@ellerman.id.au>
> To: Nicholas Piggin <npiggin@gmail.com>
> To: Christophe Leroy <christophe.leroy@csgroup.eu>
> To: Naveen N Rao <naveen@kernel.org>
> To: Muchun Song <muchun.song@linux.dev>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Liam R. Howlett <Liam.Howlett@oracle.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Ingo Molnar <mingo@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Huacai Chen <chenhuacai@kernel.org>
> To: WANG Xuerui <kernel@xen0n.name>
> To: Russell King <linux@armlinux.org.uk>
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> To: Helge Deller <deller@gmx.de>
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
> To: Shuah Khan <shuah@kernel.org>
> To: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> ---
> Charlie Jenkins (16):
>       mm: Add MAP_BELOW_HINT
>       riscv: mm: Do not restrict mmap address based on hint
>       mm: Add flag and len param to arch_get_mmap_base()
>       mm: Add generic MAP_BELOW_HINT
>       riscv: mm: Support MAP_BELOW_HINT
>       arm64: mm: Support MAP_BELOW_HINT
>       powerpc: mm: Support MAP_BELOW_HINT
>       x86: mm: Support MAP_BELOW_HINT
>       loongarch: mm: Support MAP_BELOW_HINT
>       arm: mm: Support MAP_BELOW_HINT
>       mips: mm: Support MAP_BELOW_HINT
>       parisc: mm: Support MAP_BELOW_HINT
>       s390: mm: Support MAP_BELOW_HINT
>       sh: mm: Support MAP_BELOW_HINT
>       sparc: mm: Support MAP_BELOW_HINT
>       selftests/mm: Create MAP_BELOW_HINT test
> 
>  arch/arm/mm/mmap.c                           | 10 ++++++++
>  arch/arm64/include/asm/processor.h           | 34 ++++++++++++++++++++++----
>  arch/loongarch/mm/mmap.c                     | 11 +++++++++
>  arch/mips/mm/mmap.c                          |  9 +++++++
>  arch/parisc/include/uapi/asm/mman.h          |  1 +
>  arch/parisc/kernel/sys_parisc.c              |  9 +++++++
>  arch/powerpc/include/asm/task_size_64.h      | 36 +++++++++++++++++++++++-----
>  arch/riscv/include/asm/processor.h           | 32 -------------------------
>  arch/s390/mm/mmap.c                          | 10 ++++++++
>  arch/sh/mm/mmap.c                            | 10 ++++++++
>  arch/sparc/kernel/sys_sparc_64.c             |  8 +++++++
>  arch/x86/kernel/sys_x86_64.c                 | 25 ++++++++++++++++---
>  fs/hugetlbfs/inode.c                         |  2 +-
>  include/linux/sched/mm.h                     | 34 ++++++++++++++++++++++++--
>  include/uapi/asm-generic/mman-common.h       |  1 +
>  mm/mmap.c                                    |  2 +-
>  tools/arch/parisc/include/uapi/asm/mman.h    |  1 +
>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>  tools/testing/selftests/mm/Makefile          |  1 +
>  tools/testing/selftests/mm/map_below_hint.c  | 29 ++++++++++++++++++++++
>  20 files changed, 216 insertions(+), 50 deletions(-)
> ---
> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55
> -- 
> - Charlie
> 

