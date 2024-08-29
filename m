Return-Path: <linux-arch+bounces-6798-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36290963F04
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BC61C2433D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B618C343;
	Thu, 29 Aug 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FaJv0rQT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TMHlTalZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D018A6C8;
	Thu, 29 Aug 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921429; cv=fail; b=uLKVf7PufQktda/pq0+Ee5j1Ukv5qG+Yu6fFDFHMEA5YxYVcF2gFQgc49l92yS+tcinvbkbOLVYQRJteeTZNypTJHvhSz+3t/OyeYSu8bHd/TjlKeQNXNe25m4FS0jWpyQaFN0G+0yi9Cb+QS+AduIbFh8f/IIZ5IzD/Z5PEYdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921429; c=relaxed/simple;
	bh=USHOhFN2DfJRwQmVPWNd35007WvGDbVtQXQ+RhdX1lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wg4ONR9xDMHR3hGmK8dNekfPFQvTBPIerbU6BTHBiiv69SfTBvz89mlEm7AiMggYIrQAE34Xo4f6r22iUsDA4HrgKxScpL3jzkWpxus0/wfxuINJMKPuR+84yJ33h0b4VA/8PBtIeuFjPavUPHrc2yBPBHbQ+qv4R2TckOeka/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FaJv0rQT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TMHlTalZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T1fW4R030195;
	Thu, 29 Aug 2024 08:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ZjY+Gal+JuiiuZk
	e/wxRVKYdUE8m4xkM1AngoOjtdGo=; b=FaJv0rQTdRWjZSTjZfyVtvSpwl6DCde
	stOkRrN1XgUa9RdUXMG3uZAnnQ0j9r2WyPGhjkABHxDucgty8XYh4hNKNE4aBvng
	wi7Msipk+Im4YKltDnKhhdFB2OalyAq2HY+UURD3OyCWv1bAhJ1Pf/lFvN+c3Xhx
	WB2tIlXC8wA5P4ryQjsJTkbLgjQvDYipLfnyxA6ofFDyfmLwJ+yq6JFWS97rW5Pm
	NQs1cEVhsQuHtWGLEOZ3LGE1fgoyyI76DnYRhJxhQOVasiuM0kkQfR21s10xjqhB
	51mSJCWRcwGkVH5P9VIa6+yxIz+JGTtxAugC3l3hOoM5/eyVLpopTKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup3r4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 08:48:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47T7klur020350;
	Thu, 29 Aug 2024 08:48:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8q6a4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 08:48:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPtUQtsYqiu9S19lkv139Opam7+dL3cbHdIKQtR0HpRIpGVkEYCnABitIUTHK6+IP1GebgphUJ8LGYer2dnk8fANCUDjwH5t3JUc9JK892JBN5Z3s+ff3NA7IY2ctJ5vtMa8FNmeatql/0PdPjiKn7hnwwBidF1dIsn9MtDEfhK4xi0PqPmbpKb2OlKRilW9D7gt4Qit5tMWdzFqYtFqaPQhsnPeC/ElqQd/gq324VK7oHiRA7Xb2+Vx7ehAY2QBcLUxd3zgbICkyfhUso5Ht3sj3bAzWbRqbFSQ6Lbbn5YMBZU7GZ7DJY5RywcUeWi0ANEKGm6W55yojdiORwhqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjY+Gal+JuiiuZke/wxRVKYdUE8m4xkM1AngoOjtdGo=;
 b=r7h9Mqhn0BNmfJMHa/xRhSBpGocgES5NaMS8K0HPGTvIoug8OtPlToXnZrkT13uSJ9SA3d4ZetX1rwNlcWFZPplPgAk5m9xWCNAr0i+W1NLWmGO3wnnWA1xrszPLvbl0qJlOiToiPmuEOh6mcHgQ3iGVgau7hyR/V6QGRgm0lxZ4DaLO4DqAohxnz9dJxUYU9zB7aYc8BBc0ZNUBp7XNa1LtW6a5LP6FGYJ+oy3kM8WymL0uatMx3QXmFi214xekVie7jdzEJ5QJ236y3Zcxx6LGPPAFun4wXpGfhc6FxpvbzVJKurhQ1UpRo4DNrjVF3/dxM+P2wAsB2efcsdaAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjY+Gal+JuiiuZke/wxRVKYdUE8m4xkM1AngoOjtdGo=;
 b=TMHlTalZ5PZH5B7mQhDWAhu9Kc46u0RsBtd63DdYfGUjMceWM2Bicov7pbQ4WZF91ZDhIlBZJkAjuq98cSxYqeQXv2XdtkMGJXhpGMNUagLAK/F230gckiWSGI8BpZGxLAz2xd4+psB+aCfOAimZDiX+k3NpnTiLR7FG/amdN5s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 08:48:47 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 08:48:47 +0000
Date: Thu, 29 Aug 2024 09:48:44 +0100
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
Subject: Re: [PATCH RFC v2 2/4] mm: Add hint and mmap_flags to struct
 vm_unmapped_area_info
Message-ID: <0454187e-3e01-4af7-b193-07468ffa8934@lucifer.local>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <20240829-patches-below_hint_mmap-v2-2-638a28d9eae0@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-patches-below_hint_mmap-v2-2-638a28d9eae0@rivosinc.com>
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3976c0-9a69-4ad8-6e71-08dcc8076574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xulOywrIHM01XoFvoqDRx5aZBw1SpXp/hl+HTllyW57uumSvgJS/9BqlIuW7?=
 =?us-ascii?Q?riM9GcwZ1IvzTCBB1euLSfKxSl+BHxDHvPXmqcCcfqg7N89F5vv6aqzhWMU+?=
 =?us-ascii?Q?eH2rzChjCFDMlgpefF2XpoU5eFrGpuOh4g9toor9USMMZCwcl6uyx0GgyuiO?=
 =?us-ascii?Q?azBQ7KlM4xZZXe6Dm1PMKNrGroh96We0CanJSOUKZveegao8ym1CAcTucYuS?=
 =?us-ascii?Q?AKL/4ioFq2dsheg6k8qG+JkJz1FkbRO0VIMhs94mcfebfrzzI72ZY+4IC8Jv?=
 =?us-ascii?Q?pvjQuFvPixwiq4wVdEtSYSY2NiqkmBzQitpEYZ8NRwacCLZ6ij87oFtU6QZf?=
 =?us-ascii?Q?WCp692S/0Lk39C/MFGEMXoCOsRHKMiTRjn2aFt2bb5iZWE/QQuiARefStD4z?=
 =?us-ascii?Q?aZsNXtf2wK3zx/wkZgELNBJZ1eBPGAP8Ff7dInwbWsgk/M53zHzR1OwQa9r/?=
 =?us-ascii?Q?JwP1LWlrVLCX+s5rxjEn61GnTNpMgNupJX+/pT/b8O2GXqfCgnRAghnVPwGL?=
 =?us-ascii?Q?oStA2hP/uIZOGOF4eed269knr4TmPYt2+n9k7P2tM4qRPneB1cCLKsQxFN29?=
 =?us-ascii?Q?utJ8p/ozZQnisAtEOR8CYmoINfyxvBgMO++Ya2fOughw7rL1JHs8fhebfiXl?=
 =?us-ascii?Q?3G3P62Nw0/Glvvv0lNnWc6scmGA3hwO7pCtJJl5OAKJZrzYE69BNoE19wWLJ?=
 =?us-ascii?Q?MsI2PbWEteDNPKnYafcoTbjSTW6+BBDN85++HBZywQkiFIIwem5GSUDoksYt?=
 =?us-ascii?Q?qMr5GRdPEJFyRoCII95+dtj3sQCtAwXi2J/XV75FHn4tbz+rRnNh/HThbTbn?=
 =?us-ascii?Q?+EWbt+vM6mf5wSF3y1f0y0q3ALL132pQA2Es9wBSttRPczW41v3qbWvT2Pwd?=
 =?us-ascii?Q?dzK1FMIYqD0TItokQAqz+uyo1SjR3uLAgxAPWtY53vOJjnvAWbz3FgONlZUf?=
 =?us-ascii?Q?2/BfKsQmMrSSUqtZKbRKYW0Ev/dEKOqWJqpRSFgncy2m+9U8xtOusWP4Anok?=
 =?us-ascii?Q?RMBG8qf2N2pwj0pFcHF6LmUIvcdYYIIhZkT/+Kh3K0ZudW90j0gMJ6S0NlFT?=
 =?us-ascii?Q?yY9UJaMIiARjHHWrE/w26rhsW+m72kHJpfuWQFSR5FnIRqfyNnzbUm+ftzmD?=
 =?us-ascii?Q?sVtqt+3e3MXtUsiMT2n+jVEYwQnXkSnrfzEleClMdnJ82xpau9kFEjYtzkz4?=
 =?us-ascii?Q?09yHHVtFOIHZ3hTN87n3VBSwQ5C7UFRjsBzOWrC9dOPB8rAJmMxDwN76at2H?=
 =?us-ascii?Q?0RwwT4FS6x/46RGMk9Qcs7J/+x62zTURbRp2te/YTTWJHB7JOT+sSEm6JuoY?=
 =?us-ascii?Q?w6htGeYjCBpN+L6tCuOrLRiNOAN0FCFhp//zdUV43WhWJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsz7Q1RELbuFzgP61WfBRxbm73sGK8bLWeeQ6Uy9OQt4+Qf6ivaQ/Pf0GcB5?=
 =?us-ascii?Q?vhqHqNqHaZRSevRVLfgb6EOoMdOs6JoprBDXwsfkwC8DeGyqUa9Js0WL/9fd?=
 =?us-ascii?Q?K5m2TAYGAUQiPTLR62Ykg+r+9NB/8Vow9DPfFLzMvQr1WBsD1KefY9Uhl/8I?=
 =?us-ascii?Q?rzve1TvbywHQGGjIXD9VWARC7XqkKO1K55XoiQ/8Yy5Cqt10JKCVVClDI+LE?=
 =?us-ascii?Q?VhECyxqUXzG789EWSkL1tW/liGbsmYydb14IV8E2RCwWHstq2hJAr+8tUdu5?=
 =?us-ascii?Q?hTvLliAwbh5eUdRIwHvQsNP9LPCO4HmI5Mpt/38AR45cYaoIBzQt5Rz2652L?=
 =?us-ascii?Q?WCXL2dky5Mc6YIRn4kl95t4osQrk73sT4l9D8Hgt1VWNSb+abkjKiMhuu3g+?=
 =?us-ascii?Q?eOTEG/xERcFKeF8HOc4a1U5bCPEI+At6JQzz9PaAXaqgf6b7ec0VaPSDJM6Z?=
 =?us-ascii?Q?H7lzo5M7BAZsugJI+N8L/Iv7du4ZzWzZzHkcA4rF5sfKR73uhrUiWxzTt9sp?=
 =?us-ascii?Q?uxUdNb7hrFwjaRUWrqxIzPCTNw6wQ5ukCaOv7q/UtivoOVHknm65Mi/8sy//?=
 =?us-ascii?Q?rmlfk7cHDyGyKuuFE9kYafNqnkf/EMZzmSx9kV9WlKNk+agIuJ2D7p6o2dEL?=
 =?us-ascii?Q?NZQdJyh90ndWDh+/CQeA1SJEkb1Zbp9UlTW7iMAeQ1aEn9+hCymveQ65yNML?=
 =?us-ascii?Q?ShAF+4JYoEDq3JAVJJGkYYcGjXyikydt2jTl05RAP+M6ke9IqxMt7eoMxf8B?=
 =?us-ascii?Q?zoiJd4vncfyd4CV/nB8lzrHK+NxA1naA9w26xJLSN2+5QTLbRZLcBa+zBrD0?=
 =?us-ascii?Q?mo35l3/EjqD6dyWAqRbMwX88pqKU+bVWdZhgQqaKg0JZxQLDu0JjOTbtE5+n?=
 =?us-ascii?Q?ChY+qqrOpTms/51cuaSBOOyRepZx4a6Z02ea7D8X+U65zLQePje7dx2cMDmK?=
 =?us-ascii?Q?QaHrI2F1hYP8wR2dqNyWArzpi96xmpJT6fM01nUIW8MeOgAlVlALCK5tRuD9?=
 =?us-ascii?Q?0XH8no2DfE4gxaXMjhlZNZWLjXi3InbwOk6JkJA4IE4BrVYVhttuhKynRHJb?=
 =?us-ascii?Q?o8h6+BWiC8DiUIvgTzPPocDp/scOaIoDI4i2rTIgxoElFPkFIoPadGB932Fv?=
 =?us-ascii?Q?jhdEERkfNIu5eyv1g5/Pd77gxmjAQc1omkl4MtE1FN6yRcu1c0FgdF6e2ws4?=
 =?us-ascii?Q?ohjuZIxhzJQOOcx1UBuQadF2TqBvSCQTEW+O6I0v9H+e/NyZhyPjkHBrVXkc?=
 =?us-ascii?Q?Z3eSVpztmXKUOof0G9ZPrVwO9N5dg+dOeZn/X8cby8tC3KPrMyx2AiFOfAaP?=
 =?us-ascii?Q?sKOurvWgKGvxOU1TxwCdw4q+tYBDVkGiCI/6qgp2H+D0YL3KHcMIFfOnWGmf?=
 =?us-ascii?Q?6sp6Bbnz6h/+hmPyNBKoh52MT25DgeFicC04HFY27fHQqZPW1h7nrOqXt8sI?=
 =?us-ascii?Q?AtETm/RJIOxVI/EnNz1Q++1oPBA4gHxlfnWbxA5taA9xVyVWwRyyRHb1IyNK?=
 =?us-ascii?Q?GcpWEooPwfGTLJNgIGxLbTWuWtmj/bh+B4BLewshPswBGrczJH0NBArp/v0+?=
 =?us-ascii?Q?XHizbo6wdLrGPjtbJ4pK8iwqxIVri0QEokpNs0b5j8TjvUJKjTnqtiX8l+lA?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IlUMYcUolf/GhQq2bU1F4qzz0myQoIqirPZOV2SQ9Bz8bIkJyga/PWLiEWTt8M+yCDh9AZEe9qqclzOK3pVQl3jrAuoyo+ssgLwZWgy8SazfqkL1ymTJjD3z3Py3VnSnz4i4pv8LWiWTf3QY6tqKiteQhPhpd4dYkk2By7dB0fKDFhYIKnJa3InJS9H/fOqoJXpE6c2pQdV10yihy/vvuBAyOtx2W0IQz6bhJQmvfe/ZFvAdPkIEUMtcxBgAFHmQZNTeWQdd4yeSD840yecBCoQgfjwPtVxVOcdlSLfPrhHI3eSGTUxj/NbKofU9kia1yt6leA/FDSSw4sRNDbOysErpv3xFxwNbNin9Bq8r6cldJcs327S3+SwXBSAZM/bK19CPr1l2LWSheiUBp3mbDJoZMnVVg1ygasIdYbwHRC3moJ0aW6blg4c1Pu961p0uXHBoKP17gf03VJGNtRoRrlIR6DAmTDm5BKPXr6ALoeqaMGAsC5tyMUOFzcwsXys+ZoCs+ncVTQueENIeX2ORHFMUXQkSfvP90fFDStGTkTstN8QhHRBazvMe/ihAHmq9bmH2dmilhQs3X+QVfh+KA3OTZG6GXuorXF8e509Wuno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3976c0-9a69-4ad8-6e71-08dcc8076574
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 08:48:47.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DIWJgm76U6NmjksxJK0goXWUlhnD4sC8LQvqHIwkWhkZDxU3cOp93m4/4IlPrlg9T7UY6qOLVVyfXqLwUu7AEQhbCMxRwa68dKu7srM6JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290065
X-Proofpoint-ORIG-GUID: Jcm53v8D8rgkSYhXwRDolWqiAUaEviCj
X-Proofpoint-GUID: Jcm53v8D8rgkSYhXwRDolWqiAUaEviCj

On Thu, Aug 29, 2024 at 12:15:59AM GMT, Charlie Jenkins wrote:

[snip]

> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..34ba0db23678 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1796,6 +1796,9 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
>  	struct vm_unmapped_area_info info = {};
>  	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
>
> +	info.hint = addr;
> +	info.mmap_flags = flags;
> +
>  	if (len > mmap_end - mmap_min_addr)
>  		return -ENOMEM;
>
> @@ -1841,6 +1844,9 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>  	struct vm_unmapped_area_info info = {};
>  	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
>
> +	info.hint = addr;
> +	info.mmap_flags = flags;
> +
>  	/* requested length too big for entire address space */
>  	if (len > mmap_end - mmap_min_addr)
>  		return -ENOMEM;
>

These line numbers suggest you're working against Linus's tree, mm/mmap.c
has changed a lot recently, so to avoid conflicts please base your changes
on mm-unstable in Andrew's tree (if looking to go through that) or at least
-next.

> --
> 2.45.0
>

