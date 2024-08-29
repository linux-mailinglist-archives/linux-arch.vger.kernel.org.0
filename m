Return-Path: <linux-arch+bounces-6801-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0F9640B2
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 11:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67821F226AC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773518CBE9;
	Thu, 29 Aug 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5OhFZLd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VHyhVsPu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB7156875;
	Thu, 29 Aug 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925419; cv=fail; b=rF+FkYU/9vwb+mBaPaGitPQ6B9jzFj+cHndE59xZGK21lU7ui5QXyXLr1qid7jZd5yuMuroHbzX7CkqfaoqkvGNGFuBLaQ+uqkcuK7fIoTcrttgWsEhzYFqZ9YDMTUYkIf0FNsqCiuQEc6ldPC6mDHtGUyStydSZdo315mlsBFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925419; c=relaxed/simple;
	bh=srVzhpRAUZ/5Io1hU05nqRwDmBCBB/NVG6S2mqj49KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0NeBe5mnf5KfBHnzqXFiv97enDDNnCLM4J7xFFvPUcSBKulzytmExFf/MDUXgO0j/TI7OLC2EXIVv61IS6iEZnJomx6bRNXlHHcIIm+KkhOrbZO1lkAuZ/5xVCwoLThCd7S3ROtMFyi2ro6u3YzhOXv4aTnnrj5pjCkXk2SJic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5OhFZLd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VHyhVsPu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T9oQkk005930;
	Thu, 29 Aug 2024 09:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=eSFFryLSvxZIOwd
	fAhhiZ/tUenNluUoPv3LuzdRVDkk=; b=h5OhFZLdARF+gCQXT3pzmKu4R7vzw8g
	HaDgm+VgMJQ6Q4t+GI7wqCVdnkcm+ojQhEp0R2XXzyEla6F5OVoDDo02W77Y/4BU
	jqJIxRUvJrTvJQssekiTKRifM4Lyqu5hh/eIAdz7voOmaNHxUvc3DWiSmv+5R0Xa
	e9tg5fcEereuEf8U42IyRWktx97BY0U3Qj1pJFD93KZgD0dB64MXJ0jOS/U2uUh0
	lBNQywEBMXMjLpfyScwG859bBMBjX4aMXyzJF2+MAPRLfiamVlxKYGIjy1mLWD5z
	iIyU1/K7jcbhw2bgQC/bWtBzRZB9iKW6Z49VAFuaKnG00LihSVCfZeQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ap12r2y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 09:54:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47T8cjAT034855;
	Thu, 29 Aug 2024 09:54:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189svrhe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 09:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbIz264LwWoejAlg/zFN1IP+HUhvz7/EHb54B+b6SG3HYufFDC7oTSInR8gFyuctPwjWownYEsSi2f/pdHzPENcGgsIejpB3bm5JdHnsgc7nr3LMGr9emAOvTZV44ekaKpQiM3/iZBtDcwyfskx9GXB47Zzt3HJV1RKJjuYiR86JbQkmsy/kn+YtuvT3vMnwNr8eLcwgeyE6sPNX7LGduCcWTxI2Fshxin5/wsw5l0M7/toboKlZLMWIaCdsWhBrgst5JmDIijofqTtR7adyvHPztANW+tTunmsgd0BL3Pzia43Lf6IsADKxklKIeD8zRZmSnyS92j/jDFdpMcg/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSFFryLSvxZIOwdfAhhiZ/tUenNluUoPv3LuzdRVDkk=;
 b=Pp4yBvnF0Jfi1pvxU0QgAGJyCuSEF4Au+hAnB+i8cm+ELVVI5f4CzaAjpl6snoZx4WnsnlYKZ/8YPCzP2mpufMZPHwPY7dP9f/P45KGQPLskKpR9xKPdoiuXPJ6Cnl8kp+L9JwnKYvPgsOOoQNy6mZTjDC+plrw2pYuCIVsShUM8lujo9jMw4/ywlF3yEAb9vO5AVzKQq0mGOWtzcU9CGX3FEtlmX4IUYQjdcJNhveJkJ86bmCALI23wi6Na4WjIgafwhV+Ar5Os91yZAjBP2ow5L+UelumeSbkGqiz6iWR9TN5tVWoTCb9rb7uTneoTss4KUWjLaUE6A2O6Lhoaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSFFryLSvxZIOwdfAhhiZ/tUenNluUoPv3LuzdRVDkk=;
 b=VHyhVsPuRcjFzt307tEycO/0TSkxwo2ASUEKmLx66Kg4BUlTtqiFDlgfc7mqiHtHpN0zfyQXY5O5Fze8xLnr4DMThtIYQbzDaUSqg5kpyHPT3QbM3E2PSeLbgH7q4ibj+4SkrSjf5TZn/NHFtaTPkbQEsLoOkH7GeXlAFwOUdqk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7348.namprd10.prod.outlook.com (2603:10b6:8:eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 09:54:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 09:54:29 +0000
Date: Thu, 29 Aug 2024 10:54:25 +0100
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
Message-ID: <4e1e9f49-8da4-4832-972b-2024d623a7bb@lucifer.local>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 614732e6-3ddc-4de8-8ce5-08dcc8109302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3HMAIuZghDxCJ9p+0C72nUJqTn04TWZ2mfcJGeZ/eR23npr0uVxi3zzcCc42?=
 =?us-ascii?Q?EbSB3U25Pc6SasfoW8i092ljGDK5lXpusTYLOrUiIR2MmKpMsWI6aKp2M2Pc?=
 =?us-ascii?Q?4XwzOXRbfULeFeHCT4yBZKylqIDW0mGa5UOvQCb4l1eRf+KFcDS+de4V4FoT?=
 =?us-ascii?Q?1MwDtnnqoyKys8ASCMBTqpcnCf+Vp5JHHBVLHJwDRT27eL/8mmuRFe25EzVS?=
 =?us-ascii?Q?3biNBxTYick0qfRBHVowOX12NktG2NCensYH3m6HzD412NX2z3Qro2S2MoAU?=
 =?us-ascii?Q?U1dHDVCnlWnHUkH4x3O1zl4bn1TPzyhSukOh8abEHRnbj1Sst2btLQ7Yjavb?=
 =?us-ascii?Q?UCZE+3zOHHLa394xyBPcK2xvdJNRmKsp39qOHgzJviP4q9VCVeVedCtlGSCV?=
 =?us-ascii?Q?Czx/r9tPgTxVicVxyLHpgymViRuKGSTrP7OHGDSYztU+Q4EjiVDYyJiLnE4B?=
 =?us-ascii?Q?NohejWed81SNxw3c+Gubk0DIeI6U2gViJu8Erf8/nEhMjXAhlOC2K9uAFSpM?=
 =?us-ascii?Q?MN9bKoDNvU/w9wOk8xYu95GoMr6jwncIk28H/a3GOJ22ENXDzhQC5XByfg6U?=
 =?us-ascii?Q?mDymSn62iUcufo1wFph7H7wErrGdDZvBKxkF5c2lhohlAVwvmeChsgx7x9jQ?=
 =?us-ascii?Q?nf14ywQ6daL5rhfmg6hfbtUWCmjRSQmstHmXp8KnbjopdlsTlWuqPIbfarqq?=
 =?us-ascii?Q?/Z2/SxH/BcAoE3riEXAV4sMOE40xUKQ/Pby0YRuM5uLFcqcHcevm1cN9iGAF?=
 =?us-ascii?Q?v9QBmaFuD4JpwSXH1U2CBVlvcAF2PA/albs8JV0NMpRQw2Fo2XbLNBrEzJYy?=
 =?us-ascii?Q?vlVjWU2laR2X8yxJ2UwbSQ2Hv8SttZ1ppQT1CI33Okz/AXvVqr2adchV+OyH?=
 =?us-ascii?Q?0YvADtU7wBOi4Eh3MRaTLaPK2yWj6mgrsNSZf3XpTw4O6WBlNLSgVkAx2kU/?=
 =?us-ascii?Q?6rwnzCrL6Loq6RF+t3IyJyn9yKCdHrd/qsrw+HsIbY5VD/HGlfOeuzgVuS3q?=
 =?us-ascii?Q?MSmporeJXXDr3qkKKpmOkJbkIDXrI7E4p8oNRKPZy28sattIj6x1HH874Y9n?=
 =?us-ascii?Q?r0n1GBKX+TU0411IOW3WlpzDnnhNa2U5DRWq6a3P8Pz4oF5i2DucApE47a+b?=
 =?us-ascii?Q?lqVldU5W6IX74k+miawrpF7NGZIJOnMf9HO7UfByg5gn+h3tfRGTMULil4sL?=
 =?us-ascii?Q?JaQC+tmcEOJAMxsepl26PvZQdn1YH67mx5TUKkbYT3ysGFqS+YYBXL3NjowD?=
 =?us-ascii?Q?IZonAuNcggqwISRt1zz9L8np/5kqG+tjE7yTrbXAuleIMVXZNqkKPlip0Z0b?=
 =?us-ascii?Q?aO5ZB8Y+2q8k3jxewA+wpbA2dlgcEitL9Bm+/RSn+0VPrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCS8brIso8nqkzWNn1eYEy13rW06EajJFaP+bHhxyTqxILpKpQVUXQYW/zdz?=
 =?us-ascii?Q?3SHJ08kp5TzlZAB2ACljoE86pbbwQq1GSK9CERpAYtPXoNpb0fz92henm/Fr?=
 =?us-ascii?Q?IOQf4nYm5QhrWmaxtNgptOWLViVEqTBLjYW+BNk7PAaX5beyOmy7CF3tGRgy?=
 =?us-ascii?Q?jnl15x/oMo+n5g92dkGKuQRHCIrDoO4t8M3F3al/uswq7Qt6b1bMIKmztSsY?=
 =?us-ascii?Q?1b2Hue8zcVANFRR+gGlsweajugHdfRrCIivBPlxk1M1Co4o1gzKu3rR7jIjp?=
 =?us-ascii?Q?9XWln7ZrzsAP4XcudeMxEWL3mh+CAn2tTo013Q4MQkJ161hZ6UT9nSdOrLhR?=
 =?us-ascii?Q?WJD81tPFZPW7hOuFODs3BdVPcHGVO84R4YVxFtysRGb3f3x5h9N+U1lWk1J2?=
 =?us-ascii?Q?wwvLid1XCJywefKTJ4ogFAjb6wbYoPg0IOpEF2RTgIUeeUvGRfQ0mQga6rB5?=
 =?us-ascii?Q?sqGt9sWNfK8hH11HD+ByHg3+uow6kEwCmHiw77dtz+/Gra1FIGX/ql1s3YdO?=
 =?us-ascii?Q?PEDhu/QfiRBKcQk7ET/5nsM2bYuOdw3B2yB+QrUrApLlhID6l8aNHbUgZ+N9?=
 =?us-ascii?Q?6wwUYDPDQvmwuX+lmrPLsWG4olOIkLcL3BparsuKuEf7z8IEYqutXmcjA7IS?=
 =?us-ascii?Q?mPDoqtXqORgQtt0NQlJ/JSbXAkUAtYzUVXh/b+TeFlnHQ53/hFruwUf4IByg?=
 =?us-ascii?Q?b9yvo3+ntoLZ+tgBda0vN2gdZgBQxR9QokjaY4KqWW+O5Y5EJLGONM0VZzqt?=
 =?us-ascii?Q?AjW+sHRx+XPjVwPtBhih/+b5sPYJ7Ft+lp95rIDBVCrMLMXAhBmRog2Cg4p0?=
 =?us-ascii?Q?oB3GWVbZHMSEaXa9KuvVnNq/fW4GX7u3jKgiHugs/tkks4bEhmJ1pOvs2xl1?=
 =?us-ascii?Q?BnqoBPd5Ej/q6TJoKq8utOY0DXu7TSICzHXtzdpL1Se5FkkBuSaPeDRRDIV/?=
 =?us-ascii?Q?aKenUKW9KMs1SM55Sge1RX4tWKT+LVu4U3gYiIpxzjlMuq3LArWTvPgvxnuQ?=
 =?us-ascii?Q?DKbzX4MhCcCbCHpdu815QGzdlGpzLSQ11ZkapLUFJJh1d/aNGTHtuDw37n2R?=
 =?us-ascii?Q?eccn7/B/ALuPMrUXixA32VDuNw604osrOn4xJSIQ5jgBQL/akHNjdEyOfPGf?=
 =?us-ascii?Q?RZRsiTLJtdSog4WHiUFqTrPEWBMhCc8AklMsDay/gmv5u7WJDt+MZlKBfCue?=
 =?us-ascii?Q?98tfe8kEemOCk4KRA3YYGjCj7IvExzharLgTtCwyUikBlvoFxaFu7PyL3Lst?=
 =?us-ascii?Q?aKkpnqrB0s9DdIVVRo0c8oBiTIWzMlgJyN6dddDUXGqmP3FtTpvQMMqVdAVI?=
 =?us-ascii?Q?1AviZ03wQmdsNUzLfJ4QvbDTuy8HVOcEOeFzyhQ7BB+Oy1fTGeMervC/YlJL?=
 =?us-ascii?Q?qMPwrXmvobhPhBkPoHZSfDteJh4Fqf3QPpQmoAvA94TetxtxXNuExJIhBPt0?=
 =?us-ascii?Q?UYvNgJUVtJdlQfw1pkBhCBgq+oVEvTOd1y9LneG/v2wvgMx0ziwpowyQWcH2?=
 =?us-ascii?Q?yDNNr4bVN8I/2CNn97NknnUeTHQtt/FCRF+JayQGNlr1oxqQR/kSuqeb8b0F?=
 =?us-ascii?Q?ZQqHApetopeGBrwgmFIIjOJ6+byP/6l4dsWIhfBeRlbznl7PBAa0+lgFF6ST?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqPHPZLSXkBiE5/d00w1heI/SVyAloUH0te3LYa08RMbI9KN9ODEGrefbtRpiXRmCf+UVN7JsornI2PTBpynqcdbmv8JZh0vg+B1GD0VErPd3PjiOoI1DgkKcBS/35uqgmhOgpIrzfoLo8OvcwuIAdzNykpI+4mbiey9wTV1hjNKcRKQw+1vAKibnKWUgknKP4g+LZedyPQzsAktHZmOiZXiv5htJWGNffmAYuzidHrghOE+l5q6PWVuEm+gvtlIJSyC326+82jgOGWkcjWs3Akji9LdcYvasvpKF4MP8LpNDn9Ob7QlKRGXu6+wnIvwdJlKjr9FaiSHSatLr6r3XPJsVmVi9vOvJMK3sV3kOM/9sNdZb89CnQbC//Gz7NHgXNTtVVbE9BSO4YhoiixIFZY5nHManAAIVZQT7Q+R637gjWF8VjTcpXAq469XLtFM92prAGkaAqv6Tu5YUcQO5DiSD4aLFQpv6Ga+NJ5P3Unn4hqluox3ZSVM/Bne2DvW1EGQ2Q7QR8cVkGBiHGSz6H0SVxMCWcOWVuvKT9JJ3gOEyZHPIzrLwNxCR8vaQh00ij4Iwt1g23iHIZLmaBFfAYUn5nOJiyTW9fd9LOAi5FI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614732e6-3ddc-4de8-8ce5-08dcc8109302
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:54:29.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esU6Xvcy/7BPWwjNDVfXQ01u+yFzOzDH+zY8BdobzuNIAg+7XPI9HsQMR4f0AcO8HIwFi2jd+Qw/PPc8lt0exCv6bAnxIHp5zeZFSSe9ams=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=852 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290073
X-Proofpoint-GUID: Qt3RPLBpw86mbKT8mwyMiIsXqcR3bVSO
X-Proofpoint-ORIG-GUID: Qt3RPLBpw86mbKT8mwyMiIsXqcR3bVSO

On Thu, Aug 29, 2024 at 09:42:22AM GMT, Lorenzo Stoakes wrote:
> On Thu, Aug 29, 2024 at 12:15:57AM GMT, Charlie Jenkins wrote:
> > Some applications rely on placing data in free bits addresses allocated
> > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > address returned by mmap to be less than the 48-bit address space,
> > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > for the kernel address space).
>
> I'm still confused as to why, if an mmap flag is desired, and thus programs
> are having to be heavily modified and controlled to be able to do this, why
> you can't just do an mmap() with PROT_NONE early, around a hinted address
> that, sits below the required limit, and then mprotect() or mmap() over it?
>
> Your feature is a major adjustment to mmap(), it needs to be pretty
> significantly justified, especially if taking up a new flag.
>
> >
> > The riscv architecture needs a way to similarly restrict the virtual
> > address space. On the riscv port of OpenJDK an error is thrown if
> > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > has a comment that sv57 support is not complete, but there are some
> > workarounds to get it to mostly work [2].
> >
> > These applications work on x86 because x86 does an implicit 47-bit
> > restriction of mmap() address that contain a hint address that is less
> > than 48 bits.
>
> You mean x86 _has_ to limit to physically available bits in a canonical
> format :) this will not be the case for 5-page table levels though...
>
> >
> > Instead of implicitly restricting the address space on riscv (or any
> > current/future architecture), a flag would allow users to opt-in to this
> > behavior rather than opt-out as is done on other architectures. This is
> > desirable because it is a small class of applications that do pointer
> > masking.
>
> I raised this last time and you didn't seem to address it so to be more
> blunt:
>
> I don't understand why this needs to be an mmap() flag. From this it seems
> the whole process needs allocations to be below a certain limit.
>
> That _could_ be achieved through a 'personality' or similar (though a
> personality is on/off, rather than allowing configuration so maybe
> something else would be needed).
>
> From what you're saying 57-bit is all you really need right? So maybe
> ADDR_LIMIT_57BIT?
>
> I don't see how you're going to actually enforce this in a process either
> via an mmap flag, as a library might decide not to use it, so you'd need to
> control the allocator, the thread library implementation, and everything
> that might allocate.
>
> Liam also raised various points about VMA particulars that I'm not sure are
> addressed either.
>
> I just find it hard to believe that everything will fit together.
>
> I'd _really_ need to be convinced that this MAP_ flag is justified, and I"m
> just not.
>
> >
> > This flag will also allow seemless compatibility between all
> > architectures, so applications like Go and OpenJDK that use bits in a
> > virtual address can request the exact number of bits they need in a
> > generic way. The flag can be checked inside of vm_unmapped_area() so
> > that this flag does not have to be handled individually by each
> > architecture.
>
> I'm still very unconvinced and feel the bar needs to be high for making
> changes like this that carry maintainership burden.
>
> So for me, it's a no really as an overall concept.
>
> Happy to be convinced otherwise, however... (I may be missing details or
> context that provide more justification).
>

Some more thoughts:

* If you absolutely must keep allocations below a certain limit, you'd
  probably need to actually associate this information with the VMA so the
  memory can't be mremap()'d somewhere invalid (you might not control all
  code so you can't guarantee this won't happen).
* Keeping a map limit associated with a VMA would be horrid and keeping
  VMAs as small as possible is a key aim, so that'd be a no go. VMA flags
  are in limited supply also.
* If we did implement a per-process thing, but it were arbitrary, we'd then
  have to handle all kinds of corner cases forever (this is UAPI, can't
  break it etc.) with crazy-low values, or determine a minimum that might
  vary by arch...
* If we did this we'd absolutely have to implement a check in the brk()
  implementation, which is a very very sensitive bit of code. And of
  course, in mmap() and mremap()... and any arch-specific code that might
  interface with this stuff (these functions are hooked).
* A fixed address limit would make more sense, but it seems difficult to
  know what would work for everybody, and again we'd have to deal with edge
  cases and having a permanent maintenance burden.
* If you did have a map flag what about merging between VMAs above the
  limit and below it? To avoid that you'd need to implement some kind of a
  'VMA flag that has an arbitrary characteristic' or a 'limit' field,
  adjust all the 'can VMA merge' functions and write extensive testing and
  none of that is frankly acceptable.
* We have some 'weird' arches that might have problem with certain virtual
  address ranges or require arbitrary mappings at a certain address range
  that a limit might not be able to account for.

I'm absolutely opposed to a new MAP_ flag for this, but even if you
implemented that, it implies a lot of complexity.

It implies even more complexity if you implement something per-process
except if it were a fixed limit.

And if you implement a fixed limit, it's hard to see that it'll be
acceptable to everybody, and I suspect we'd still run into some possible
weirdness.

So again, I'm struggling to see how this concept can be justified in any
form.

