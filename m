Return-Path: <linux-arch+bounces-8493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7B9AD3AF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFDD1C2241B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB651D0E18;
	Wed, 23 Oct 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gWv3T4ba";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i8VuCjjW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615991CBE9A;
	Wed, 23 Oct 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707201; cv=fail; b=JC4hwUD4SRXXJyG5OQA6NCm9LCHdxEzWGAyQIJIZMzlkp6LESVdWxtKCBdMymVTSPX9ILUITg2L4VzaXiPyN4xXVeA/Mzq5FTpB6Wyd/YKHGC2uE45RFUHSSjY3q2HDujoOnUez3/5C63DCG9CpbwQvTl8W6upuWd4oj5uXm5BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707201; c=relaxed/simple;
	bh=WiBtoTwhA3ez0FUNTuBhUa6iOq+rRShMP7V1RW/R1sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ax+mKb4tWrEgNAimowVW0Q9VVnwjOpZMZuqJQxJgmuu9LgzxOy6/3g9dQmePCE/5jH7SDSccgfUKPvRxuyxPB/C8G1Su3KNuch435dtfRKcgT7dtfBe6Pa7kFsNq1Y+GuUTY7iA1W2Y1SGKWZ2ZZr3+xaRfOHERm2V3CQnJKH20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gWv3T4ba; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i8VuCjjW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeYp012107;
	Wed, 23 Oct 2024 18:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=uuPQAuFK+lt+Ogsirf
	MENIsFoYCW5oL3b9cqP0438Ek=; b=gWv3T4bavAfzLzPqHVw3cvux8T1lC/N7vR
	oqbUMJkaYWKuUiXWDUHNegwmOwLbx9F02CLedNMhd3fxYUnpNhXQtfZ0EM39K44D
	EVvgOapn5h5DA1fvnndJeTP+Xna5Do8LlEk1+1BjIacBqgejvDxYUf7ag7T4Ys/E
	V7EddHJevgutLxX12ZGTUn0B6fxktK2GMHGlCNkvMvkm6cQJDzBZ+6v04F8dlpCi
	xr1Pm5H1Kl8lT/HYuMhO7CdG1wV3BGiqDjVHBCCfFBj4Ex5Sb1XGXNyw8TC2KmSM
	Z9VyO/86BisZB9Y9AEH8aTzpnnMzFJM+jpJe32/EclY+EygEB6Ww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urskg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:10:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NI3dnm027473;
	Wed, 23 Oct 2024 18:10:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3690s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDpT8i9gRlGkMbbs+GHmFFLzm1LIu665XfMRDF147l/nYaq0g/W98xHLYkI/KoPsPb3kDDlIwwf4msxaB7NRE7YFjr1JeF0BUxIGHV9wgHamdHs2odhTJgbXVZ2ShQobKOyDiSq0RrGXIYNZl3N+Pir06uMgFpZXLCpvENPmhnd+UauWeaqh0MzS50Zia37xAOZ1MEMh8kngpSFYPAJyyrjv21A6NEE/+R5eZUbAfnfEDF0nxUAj/QqGPUOCxPD3eL8Vycn4DGIY6gH5xe+UzBnJHa0uErrWEj4pQP3D+4inQDYQMDxyjpV4qb2q6hb218v6uS037lN4Fbhe3P/kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuPQAuFK+lt+OgsirfMENIsFoYCW5oL3b9cqP0438Ek=;
 b=PBUdnimxg6jh+rQSceB7tfotCySWdMjmRh92QRrp/lJZJwkgbdBW8oqBfuC7IxTyFgd7QnPmk8czG6sE3XF1eK72HSlHcgEb8C3Im9TArVI5yeswwU16jWevaGVRud1intS3MLTsnjgv2p0qvUOVVTmhEw/AgHA70783fTQd0M9fArRR4zsCZ3sBQZEt0l98ezXbx0AVwi/GfQxSCfHyv/VCbZe02DFffUHrTS+6QMrWyjF908LLdAQQ+6FgVfLqkUyMyG7LP+ShaH970LuipDB0sJcI2k4D4us9JM8o0m7+OujNXO2geQPiIL0IEjZ1vOpzQkW5WFJbQFwDb6/3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuPQAuFK+lt+OgsirfMENIsFoYCW5oL3b9cqP0438Ek=;
 b=i8VuCjjWGZ3l2N/DZajtPQbeSnxalHc28mpKySKUlV97xBDuGuLAuyLEObFGaxdf//C4vpYWXIHCHAF5omt7n0rwJ+soy0jteJxcYMExIGK3QG/wfCgWUO201Dvbg66qiF9pchAZZI9V6kUXb9u74SpT99qVezq4vxJOL0VadV4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 18:10:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 18:10:33 +0000
Date: Wed, 23 Oct 2024 14:10:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Steven Price <steven.price@arm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <gcyxymiqvxgkkhn76a6ksvevzcq36rridwakgyjsa24obcab3t@leqlqjcx3va3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Steven Price <steven.price@arm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <yu7um2tcxg2apoz372rmzpkrfgbb42ndvabvrsp4usb2e3bkrf@huaucjsp5vlj>
 <Ztnp3OAIRz/daj7s@ghost>
 <pbotlphw77fkfacldtpxfjcs2w5nhb2uvxszv5rmlrhjm42akd@4pvcqb7ojq4v>
 <b6ca55b7-4de2-4085-97bd-619f91d9fcb8@arm.com>
 <5u7xntjdye5ejjmkgpp7m3ogpzblxcztrwngulejdft63fzuwf@xcxfcbaccqtw>
 <07c5e292-5218-43ee-a167-da09d108a663@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c5e292-5218-43ee-a167-da09d108a663@arm.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::33) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7185ba92-9e44-466a-3c93-08dcf38dfc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqHVwotmyDeyyl1HfLP3WEiCLjHnA1JtzaY33mR7kl4SEqase8SRkUCfdL2w?=
 =?us-ascii?Q?RBL7ZAfKHkmtyCt/ZoP51O2OomwW1pHS0OXJ9pga2qxHBBMU3L+m8Deiidd0?=
 =?us-ascii?Q?ODjn5tk1XB4piZt+CTdFLQvpP6tHGFSusePacf7fDrFv10fT8jL5kmbq/pW5?=
 =?us-ascii?Q?WPT6PYCx7CtpSsYBJBzIKDbmgnp109lKA078RQV0CVUKqHIiFwJwUgINYldr?=
 =?us-ascii?Q?Pd+6jL1BUVF5FCJmlM0uR8giQCXXkC0Vvn1T7BQxyeugRW/xoirJf5dUwt12?=
 =?us-ascii?Q?PKxUA31sMiByZ528RIeE1tvUX1qkZ/ayKDVB8oCGB7SxkrUgYgUQAoXtVVDW?=
 =?us-ascii?Q?rJ0vLjk+ehBYhA0wf11H5B0kTzcfd84LXJvOGeewEYklSZ09+yvMXJKWpxDa?=
 =?us-ascii?Q?0I+YNqwzzkCtED/injO5maTXlvL+6wtdLSHozRzlpF8jOW7hcDSHByekhGcT?=
 =?us-ascii?Q?LG2g82o+FD4C0dBU3DRVchogYDMWJEWNLlYJ/2vwDfg4U0KkFdZ3T7sgdxis?=
 =?us-ascii?Q?5rdcNVo3Ss5XOboo5YXvfqNBfonlBfCqePdI4AJqxxNHqsoMgXGj5atVutEn?=
 =?us-ascii?Q?11wzsMZuJ7/7Oc6+dzSe8UmlTxl9Uj6QT2pG0ciVMLFvMwwj3L9d2D9fAHnj?=
 =?us-ascii?Q?5nVvNEo7X19cRhgKlp/TvwgnlNQgGMFMS2On1oBWtwmoOjaAF8ysuc2XjQNc?=
 =?us-ascii?Q?E1TRY8JjDl/lyjrMx2v90KYQVZjX6ABFiBzNzXPpV/9BDjd7u3w3qwh61Pgi?=
 =?us-ascii?Q?6pOYblspbizcTQ5MFEbQCIooMouhCfzI/ATLhJjEUVUn6WB1K+ciTj3bE9/V?=
 =?us-ascii?Q?l65zlddTRjwHXelVEso+/Bbv6nGQHQgXWDmdHmAWr+OYDDRvcQV51jSgtuhT?=
 =?us-ascii?Q?PBUCk7okdNmi5flrHthl8t8PhTHfHaJUGwTL8fayTr6igr5Eshez0NMrFCio?=
 =?us-ascii?Q?6MoIqYCrUlDdAFfxGq2F5VAo/hJAmHG9XKyKFpZ1nM5sevo281fl5/6lclZi?=
 =?us-ascii?Q?H1tl8wkrN9ACAnRzMKiNFz6wmmPkAPtrSJI+2QmP4m/2b/vH36SRsAmlJOCk?=
 =?us-ascii?Q?GRAQUmMiOJ9gjzrEISU9S8d4G3JyfbIcQz4iva+dowbzLycGCfjBqZB98s5K?=
 =?us-ascii?Q?uLbj1nBM/7TcW5SL6XLrUjPd8oRG2KNPKlnRpvkXNuGaYzt5VHvqTorSUhZk?=
 =?us-ascii?Q?/61+Ev/BmaUvbn3QtR1cHCBmjQJkRC5x03APjNQzZmuV7UHBBvUR6MumlDy+?=
 =?us-ascii?Q?MTAu3+nqf7/NFGwGeeWN1a43oD6diUuuWcQQFu62FUQeo1S1Y4woQ9FG2lOF?=
 =?us-ascii?Q?77EGE9EZX5LNPcSUZccn/Ykh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWT+XxLi8vQjzfh3iCEQoPYiNoLBZQa6mOw0Hrwl7CY8soiB5bfIklfSe6E8?=
 =?us-ascii?Q?mtoNJFC4jZR+ea53maocMvES38KnD7tuQUeELPZ2JBAtERMeZeb+HHW76/4X?=
 =?us-ascii?Q?8CP8yUA4ucP1uONI55fooDg18rXLsehcYVyy4kABJupikmRRTOPgdlPFQ4Bi?=
 =?us-ascii?Q?OzR05/6ZHQOeLDdzG8+f2uMV4Jk8tg5/f+G3hEjFNtEWK3Al8FtY6ytyMBKD?=
 =?us-ascii?Q?ITNXQlp8T932OHfcfqlsNaLhSYkLNOpzvwHsvqbQXxln37VkgeH9osXFwnXi?=
 =?us-ascii?Q?vyjpR6/ttZ3bwPxaAJ2pgrPsePnjXlEya8aSUUuthlon177x3n95x1XZ8HZy?=
 =?us-ascii?Q?s30dMe7UlFbBack65kbzDTtUItenGHNVrOicDNc4O5iwd/MUi7dG5RXYcSYV?=
 =?us-ascii?Q?pTNjFWt5vgyBTqzfymlRyAi6mH+XLL+bCQTyu96qRFShnffm5UOKAudRRliP?=
 =?us-ascii?Q?pAJCLjRZj5Me8Dui7SvYpgFm5xiFsWO1x8MrfNsvLhuxjCP/LZmRNBfdqzQG?=
 =?us-ascii?Q?yVgJ4d6B7prdsLvSx5zPINGfepR2BnPhb+Xgh7oE1JqdnJw7uNGhPZDiIPiL?=
 =?us-ascii?Q?dmFuuZqz5jLW5wypBDNIynvZba7QzEqrfu2xIxZt0hm97YT8FrmBnHE1Q1I8?=
 =?us-ascii?Q?K8O/2QycLPF+tNpQQfC6mOA+rhW49cWpFCoK1B+avaHg/Eczh83cokK8EV6K?=
 =?us-ascii?Q?hk/fZm8KMthSTk26sjG/oqJY5zZ7Jdv1zrY4Cebbq4wItBDnlBlMGBLbmqxs?=
 =?us-ascii?Q?Ihrv1Cj2Z4A2FjmngHSWG6WvMN7xpTZCa0OsLnOI+mSKjM4fE5FxMUzNNovq?=
 =?us-ascii?Q?my6+7nz5WW15RZvcn8g3Fe1BN535zS/7ZNH3r+a3WP7QGNLeNYh1o+ElnyAU?=
 =?us-ascii?Q?zIDBUDnZMsa3WqeRCOsgx9Udw2UpAzSuazM8LsBpuvjiL9WNG+93/IwIKnsO?=
 =?us-ascii?Q?16BZ6AQfU5ES/M2f6dplXWa/EbymjEj4jY+rmsqGq3cTKAHzooQmv5EGTX9K?=
 =?us-ascii?Q?tm8WEKIKpb61OMV6lg+VU6uZ/c8/jUC//aKs53o8TK01G3weQm6/8jTpH7Ca?=
 =?us-ascii?Q?DTClvuSnb6E+bW3aNz3Ctkf+BQG0ViKHWUETAZco4cz/uFR0VgDwKp84o4Cd?=
 =?us-ascii?Q?D+4JFb7nYjlWNahGUOLpY4Fs/ZFK6IrsnuLawrRw+C5dWvMoW2NdHIhuwbc8?=
 =?us-ascii?Q?OPD6AEnQZs5FH+hL/2XsmA8Wk+VAFO6TD8wGSPXd0mLhCSbqTHVQSRQcXF+a?=
 =?us-ascii?Q?V0ggQo4IO3vEV9LL+pR0FvAvVoOBXAKbf9/sVLYP0YFNvRa/h8ZSMaD2gPe4?=
 =?us-ascii?Q?XAQdu3evGF6Ix7TPFBWvJowpuT02fSZCRjNfInhjaZDGeWvTsy9Fcta+SJx9?=
 =?us-ascii?Q?WQRXO3olM+M10gTwxyOMsTUrKsP+sPiBp2sqJ7yNffVhXTdVNMml4IXepL2K?=
 =?us-ascii?Q?4WpDtu0jjhYtFPP7RLMpdDzAbea+JvPhTRJK+ZqYfm66kegNOOd/+7UdSkU2?=
 =?us-ascii?Q?uDzw/fGHXFR46WuVB75wJV3j+yGT3WkdM5c7Ws54Dlu8JkpxWOrSQ3UOOYvV?=
 =?us-ascii?Q?90IbkHGbUiAt7DbPWW9qZA8wFaaFSUAhIHk/osqF4LFTCs2zpz7rdyeYZIcg?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZJOQWnPNaWS0TspfSry8brUSRPTapyEkwCIaAf2QJnLz5XmPdj/zBVr1lZ6/7ROT2io2UlgK2SXbrDMS1ATp9TDInTMnnMZk1fEqJhiBFlqFReyzkreZF2ifwpzHjtwfS7TwbP6/elo1L0m+XzDvaHcthlqBEMB5Wykl6GvyEhOAskYDlalnRoncOqv4JF9KJZUh1ARHIf1lSu9Mj701N4VUQPJvGY2g/NrFFP7NbB+JWIIrsAYjdxbJlWX33p8V55IoGIT0hKf0s7LDyZwtSr+Ie33tv7uu53KSdMDEZ5ZyluEBaKt9f5NxzRKG/nTK4VZ5ntkKYyenzEFGkem0d4WmznKAgbEwLxPLo6A1lOK/n/LWTLE7KcqNVZxF+5eyMGzlP4Z0m8WJpwCUZvXeAwwNd+HGSGidoUz6sBf8OixLTZ9x/NTnXrCnG9vTxk9ke7ZEAvF3LkVsNFzE8Ox0k3EkMl/yfBhBIgX+KvokDl0cgWyBVxt84naZkSGw7E69w8gIPHYU8CAEI9RpAJF3p7ehAXP8N8camkq3N+cptYfDpqdleBtIfGo9ZQsWBIPt82KX8sryO8gESRyQvKFSl+lJWWpCOhTZLPUh9xsKfeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7185ba92-9e44-466a-3c93-08dcf38dfc3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:10:33.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTSx2bimJqK3rynH7m7ypMortOuQECQ6S0TBwAkJsdnl4W6vPTH++Y++O8cwCEbXtkWqB8wMN4qz0RUQN0qD4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230114
X-Proofpoint-GUID: wSSewJYpBYSHf91FwhbdYMCmAa_vwP8G
X-Proofpoint-ORIG-GUID: wSSewJYpBYSHf91FwhbdYMCmAa_vwP8G

* Steven Price <steven.price@arm.com> [241023 05:31]:
> >>   * Box64 seems to have a custom allocator based on reading 
> >>     /proc/self/maps to allocate a block of VA space with a low enough 
> >>     address [1]
> >>
> >>   * PHP has code reading /proc/self/maps - I think this is to find a 
> >>     segment which is close enough to the text segment [2]
> >>
> >>   * FEX-Emu mmap()s the upper 128TB of VA on Arm to avoid full 48 bit
> >>     addresses [3][4]
> > 
> > Can't the limited number of applications that need to restrict the upper
> > bound use an LD_PRELOAD compatible library to do this?
> 
> I'm not entirely sure what point you are making here. Yes an LD_PRELOAD
> approach could be used instead of a personality type as a 'hack' to
> preallocate the upper address space. The obvious disadvantage is that
> you can't (easily) layer LD_PRELOAD so it won't work in the general case.

My point is that riscv could work around the limited number of
applications that requires this.  It's not really viable for you.

> 
> >>
> >>   * pmdk has some funky code to find the lowest address that meets 
> >>     certain requirements - this does look like an ALSR alternative and 
> >>     probably couldn't directly use MAP_BELOW_HINT, although maybe this 
> >>     suggests we need a mechanism to map without a VA-range? [5]
> >>
> >>   * MIT-Scheme parses /proc/self/maps to find the lowest mapping within 
> >>     a range [6]
> >>
> >>   * LuaJIT uses an approach to 'probe' to find a suitable low address 
> >>     for allocation [7]
> >>
> > 
> > Although I did not take a deep dive into each example above, there are
> > some very odd things being done, we will never cover all the use cases
> > with an exact API match.  What we have today can be made to work for
> > these users as they have figured ways to do it.
> > 
> > Are they pretty? no.  Are they common? no.  I'm not sure it's worth
> > plumbing in new MM code in for these users.
> 
> My issue with the existing 'solutions' is that they all seem to be fragile:
> 
>  * Using /proc/self/maps is inherently racy if there could be any other
> code running in the process at the same time.

Yes, it is not thread safe.  Parsing text is also undesirable.

> 
>  * Attempting to map the upper part of the address space only works if
> done early enough - once an allocation arrives there, there's very
> little you can robustly do (because the stray allocation might be freed).
> 
>  * LuaJIT's probing mechanism is probably robust, but it's inefficient -
> LuaJIT has a fallback of linear probing, following by no hint (ASLR),
> followed by pseudo-random probing. I don't know the history of the code
> but it looks like it's probably been tweaked to try to avoid performance
> issues.
> 
> >> The biggest benefit I see of MAP_BELOW_HINT is that it would allow a
> >> library to get low addresses without causing any problems for the rest
> >> of the application. The use case I'm looking at is in a library and 
> >> therefore a personality mode wouldn't be appropriate (because I don't 
> >> want to affect the rest of the application). Reading /proc/self/maps
> >> is also problematic because other threads could be allocating/freeing
> >> at the same time.
> > 
> > As long as you don't exhaust the lower limit you are trying to allocate
> > within - which is exactly the issue riscv is hitting.
> 
> Obviously if you actually exhaust the lower limit then any
> MAP_BELOW_HINT API would also fail - there's really not much that can be
> done in that case.

Today we reverse the search, so you end up in the higher address
(bottom-up vs top-down) - although the direction is arch dependent.

If the allocation is too high/low then you could detect, free, and
handle the failure.

> 
> > I understand that you are providing examples to prove that this is
> > needed, but I feel like you are better demonstrating the flexibility
> > exists to implement solutions in different ways using todays API.
> 
> My intention is to show that today's API doesn't provide a robust way of
> doing this. Although I'm quite happy if you can point me at a robust way
> with the current API. As I mentioned my goal is to be able to map memory
> in a (multithreaded) library with a (ideally configurable) number of VA
> bits. I don't particularly want to restrict the whole process, just
> specific allocations.

If you don't need to restrict everything, won't the hint work for your
usecase?  I must be missing something from your requirements.

> 
> I had typed up a series similar to this one as a MAP_BELOW flag would
> fit my use-case well.
> 
> > I think it would be best to use the existing methods and work around the
> > issue that was created in riscv while future changes could mirror amd64
> > and arm64.
> 
> The riscv issue is a different issue to the one I'm trying to solve. I
> agree MAP_BELOW_HINT isn't a great fix for that because we already have
> differences between amd64 and arm64 and obviously no software currently
> out there uses this new flag.
> 
> However, if we had introduced this flag in the past (e.g. if MAP_32BIT
> had been implemented more generically, across architectures and with a
> hint value, like this new flag) then we probably wouldn't be in this
> situation. Applications that want to restrict the VA space would be able
> to opt-in and be portable across architectures.

I don't think that's true.  Some of the applications want all of the
allocations below a certain threshold and by the time they are adding
flags to allocations, it's too late.  What you are looking for is a
counterpart to mmap_min_addr, but for higher addresses?  This would have
to be set before any of the allocations occur for a specific binary (ie:
existing libraries need to be below that threshold too), I think?

> 
> Another potential option is a mmap3() which actually allows the caller
> to place constraints on the VA space (e.g. minimum, maximum and
> alignment). There's plenty of code out there that has to over-allocate
> and munmap() the unneeded part for alignment reasons. But I don't have a
> specific need for that, and I'm guessing you wouldn't be in favour.

You'd probably want control of the direction of the search too.

I think mmap3() would be difficult to have accepted as well.

...

Thanks,
Liam


