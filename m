Return-Path: <linux-arch+bounces-12651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCBDB01210
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 06:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35C516F3F6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031221A08A3;
	Fri, 11 Jul 2025 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8rY5Ozf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TgqPYDFv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F12E406;
	Fri, 11 Jul 2025 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207420; cv=fail; b=goay+ZCleI5PLLl1RQN6BMir6BvQXXlQbzcWnRDCIKIXteroZ2a6i8B4myiV36QP3vxmJ4IrDqW0nSF3Bz0mgI/5krttzA+MiG1qhwCaAzA61LCeqet7I9DBCLNxB69zXqHwwetExtlY8TUeDM9T3AXWoFIQYJY6gDdQXEtQkqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207420; c=relaxed/simple;
	bh=qYixB7tx1QuF7io+n426OIFz39yGPUJTDr2uAZ1F36I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8Fk0ARwYVt5AtT5H5o7wpEMRjwBCUJzO4GODVQxnRExI932AcDdN8IBUJjt0mkCMaEfwKG4HRj3HgR+bF0K/cvMIaO5Xx02yz0j1F8x3l+TO6y1byrFy0R1JUFlUr5E9a8ixG+s4ABFMQwUaZXrqcgQzbf+N1XiIepSTkEXH8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8rY5Ozf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TgqPYDFv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B42D52021426;
	Fri, 11 Jul 2025 04:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cFbsINWkrIhbj88Qc1
	dl5PkQz9qweemPM56Zq/EHIyI=; b=Z8rY5OzfZdvsB2isosmd7n3bA0INvoC7OM
	0nQlMxS3zFN3+nvU+jaxbZh+/N9Qh6HIO684Cnp7DD6O+lH5FTtnfiyRO4ekHYXh
	GTLbo/HfD8fZ8dYxG+sC9v6KgI2xFDMyQrY2JW2HQNu4FylOKpVUYeKdN6K0USHC
	k1XjzwWpK0JFXStRRYF5oXgjiZAOfEVhSyiCUDST5kF1eXBSqNTOVYRNoReDllxk
	jcHpC0hU3FnxncM/nnXaq6tKiijANJJapABGr2VzEHIdDD+3mJj8hIeVb+lkwVbN
	scQAnN9g+7PNOIwWPPkTQ13NAJmVOlqOFlY5w7N4djTi4hYkIURQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tu7sg0c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 04:16:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B0opHV014439;
	Fri, 11 Jul 2025 04:16:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdv539-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 04:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTnYba34YAVF9esgWBmyR40nFTXRH6/CsvIndzT0n8U/HofK+ib6vc7F5ECNrkIkNV4YUbLf3YvLjQWerBiJliYs+YNOVxkm/ztw8I62xm9ZuDalKxJ1ScTysEnU0g3cIo80yc9x4DmT12mVnk7k5E7LTA0SIz7ErtZn6MDlfVzTDCdMSoIEZ5URximMtulzs8ccHh812Miptdq7Ib9ZROJ/xxmqlaIpwtaZlZGneSF4oXwArccdIfnfG2FmPUE31OR1GaCYOsuqb2K6jY+UPnrUKeFiJEfNDQsmyOVhBRo56YS1ev5OSXmItCzi0DpwrwAZznXELg8/H09ou6JS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFbsINWkrIhbj88Qc1dl5PkQz9qweemPM56Zq/EHIyI=;
 b=lRMo8sbSEvo5mKJK3RruooZzMmPCD7lhFEWVYNuKk5kge+y5zDC3a62E9o3b65QqANfFCX3JZVI6sO9KRcZizo8OMcti4TCc7oiwqWeO4q8YUgG/UTLBSBtkSVdF7hhDQ8InZIHL3fiTDi6ICDBaPC2eS2HcpyM114i5aKskTA73vOkt5yXGThfb5XdOwUjff865hWVLVsIj1XSNy02jQfM4vJf4Q16iCVJshLX3uPBxUOS8ulNW9d3tHXtKv1zoPthnkc0U6o12hcN75I7j5heJ/RarNvwNwSXBHZ65qgu4YlatjPY2i414ircF+kDUH1gURsBCaZ4t0JDKJ30+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFbsINWkrIhbj88Qc1dl5PkQz9qweemPM56Zq/EHIyI=;
 b=TgqPYDFvajObYnbu/mIuS0J7PH/MHPBofjmZ+Pb86Xp25MPZ5oNa69V8rtvw3oj8xgKqe8/+tGP8f9Y3GmPlglbfJhyapQn/ss6LlQv8lPHbVekBVRK2IhomWjVCmunCjAGbG3hReMnnflcHCFS3CUnq8HRI0CY8/jl8diCo+GY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7901.namprd10.prod.outlook.com (2603:10b6:8:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 04:16:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 04:16:10 +0000
Date: Fri, 11 Jul 2025 13:16:00 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 2/3] x86/mm: define
 p*d_populate_kernel() and top-level page table sync
Message-ID: <aHCQAPuD06y4vKTE@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-3-harry.yoo@oracle.com>
 <20250709141359.dc03e32a2319d85a25faaf32@linux-foundation.org>
 <aG95eBlgTIDUKX7e@hyeyoo>
 <aHCMwOqzLrO8tzaq@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHCMwOqzLrO8tzaq@hyeyoo>
X-ClientProxiedBy: SE2P216CA0131.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: f4401101-7c1d-4862-1753-08ddc031aa2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZrWB8GRGqrpqAIrW3lX3D+EpV9EGwu21uoTWBDK1lL14s9wWUCXBNWPviPV?=
 =?us-ascii?Q?4R1Q5eyGy/JQGQJ16TJrGcPCHlRGF1qkvL6clJveBu0NRB35c1cxXrGIteZJ?=
 =?us-ascii?Q?LUHHAYnnzz1GUohiJwHjS25kakmmFplqULYTjAnwyQnzdzo8oBGNBIEzmu4m?=
 =?us-ascii?Q?g3yYnG8v3sFJ/8v7NoHidid2zE0Lu44LKSTlFmYWHChz3C03z8xHM7+ZtDMM?=
 =?us-ascii?Q?zPDJYQUzLpsbu3i79ZwmrW7Xp2kMiq845kCHwzeeIalde0X95Ul8eeIDxGob?=
 =?us-ascii?Q?nvvSCjjpW59aGC7L+Oc+l/U/yFXwZ7g3bqxO/gdLEqAd/MnyoAht5vsXee8p?=
 =?us-ascii?Q?jw7SZi+zh81/DHWOewa+0kSuAjcssstuwxVJ1JUsqfAk+Ct2mRczrtjFryr0?=
 =?us-ascii?Q?HL8JXVHYyrqvOXl+XUFLUvEyXYdIz6qEiHg81O4x374KGB1frGK1hO5+Y1bo?=
 =?us-ascii?Q?M0ve1pDXELPD+YMNpxI1vnYN5/vkDJOI5cxMrLIyLp4CXVT15kjSeHM84qKH?=
 =?us-ascii?Q?OjR4zFnzVdV9V122rC2qmn0mfIbwViH5Zc03pyjIpnQ8imXU1keLZgSpinbG?=
 =?us-ascii?Q?dzL3QHgod9gT+2tG6FsH+LZITuPm/AUvY0P/RNB132Kb0NUy+A8wCcMOIorK?=
 =?us-ascii?Q?O/V/CqsCGUq32ujSW0H3T5Im4shqjOPSSKYfMo014qjNE/qIIlkpcyWLk/Rd?=
 =?us-ascii?Q?GwBzWDMOu5o+/QUc6ktf1IbFZemez+nYCzWpgEyBPd+eP4qlNUiYDlAbFgkR?=
 =?us-ascii?Q?sVpcui7EafxoYadupHp5X0mcXp4+MVi6ah5cxjYAKE1FdpKzJnAeSp+Bl6g6?=
 =?us-ascii?Q?b7+CB3347SbknUMDFM1XIIbIPu601/K/IAEYvupizQSdEF7itnNkelP4dvVw?=
 =?us-ascii?Q?DgtexEgSIIVI07rLWXKzuOu1zn3CxxxE2F7FsdpI4wrHNO2/6FIypBZy3utt?=
 =?us-ascii?Q?jba5EJ91PduHh9eTqlae4TE6RMppfDah6g5YlV3YNS8uPH1SdteUjPfdc693?=
 =?us-ascii?Q?BhU5Ie/3LFan5JP+WqXfGPDAF9qN9rImbu5sWKUEnTKG6xLfM+IK9KxO3zRs?=
 =?us-ascii?Q?99ArDD7moM8llzbKL3XBlfp/RoO0+JUYuW5nkaoR08G3xxGVDGasUroXeqXZ?=
 =?us-ascii?Q?IzpTcZPeJRMTL1pwhJr/PsshZUhZl6CnkdXvbokIqj+AribpmVCB14zF6w40?=
 =?us-ascii?Q?snjRiHtJelxPVnX/gAF15ZACxQy2x77EkP0ql8EN+0XfDPLn6xza/dwNr3Hk?=
 =?us-ascii?Q?VwX9lr+rvR/swFjD4whvPh2YPFBTHgJjO2Dd89JLhv04GMmpX6U8IYh23QZX?=
 =?us-ascii?Q?a1uUbWaKoDt3tGm60o8flCroyNKElTHH/zz3y8ZxfZx4lB1aGDHir3wzR1HV?=
 =?us-ascii?Q?EuGQDcZLqkQtJP3HSVLM0E4YKukZClvcH0xlrMdU+KJHLJeIVXX/b/kDyb8i?=
 =?us-ascii?Q?O5ZLM3PkKMU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahawDdI27czYwhiGmiGvAe+Bch6DWSXtdRz3anoxOXiZl8qMin+Ftzeo31t+?=
 =?us-ascii?Q?thi5owWyIExmIn4epGUDP1/53NFeyEPczSuEpZQg4Qx7oJmu5x5550KATFB7?=
 =?us-ascii?Q?YKUHm8VUeOTYGv1gqogzK9gINGos6pfP0Az/5b/3rKsM/7ynLLlS2IQCUxMb?=
 =?us-ascii?Q?MQsEikFHtdrqbxkes9SCdemeBS8z17JRKVD23JnH/Va5aICCyw9pDhLCYV67?=
 =?us-ascii?Q?3mKk1jq75QJrIFBIpKQYZ5EJZPJkD6+gYHO+NoXshe4zIBBJxJkxITqgaIwa?=
 =?us-ascii?Q?dtheSM3rB2GvXw4ZLfCr5lGbIUWNNFUY+P51n1MFo7lREtcA6MaxxQ4REQga?=
 =?us-ascii?Q?ieUzy9Lh/BFFsisxj6hxHLOBfk+jOBnBjFPRJNm/6L/cjCWi1n+H7sxmulpp?=
 =?us-ascii?Q?pliJbOK/7AGlYR/eczpE7/BUyNNGdnKv5S9o4QgG3eIeO9kYjlKnrC7tLo0C?=
 =?us-ascii?Q?0ggEpvUJJrRZ7VdOS6Hxk0281Zp5uXf6l4sZu+1LLwivtEfGTCwAlOdDkqQ2?=
 =?us-ascii?Q?cNo/w6X1mAtKagT63rmC8Qfhq/NE8LEGDhWROjcD8Rt44LHL7BItC6iMmyfU?=
 =?us-ascii?Q?ylqqFfembsEZZyp86SYmlNZB3X39KSP9/uCwtpZbqHGq3/HUTWzpYPil3brY?=
 =?us-ascii?Q?kpcWg1w7/0uBHFzGYxIrpF1PdZFOEGsPuCviX55ox9jCIXOGQ/qjRiGn1/Kw?=
 =?us-ascii?Q?mnJJQqFitTqbDu0RkIiqxf616rxDCMpprQMWbr2UbxkqXMX2d4iCGS+jRZKC?=
 =?us-ascii?Q?VwZxsXcHtgiG+ANmIAfroZKdELf21EWq3wEq/UWRtaTODGmy4vI6JtU3Gu2L?=
 =?us-ascii?Q?LHn0r46XZsIVijBYt7Yj78+N41GymvqDwgCA3sSFINODJjsnbkxr6IvTBW5+?=
 =?us-ascii?Q?Yh+fRkdg4plwwr29+GsAH4etxUyI0ZQJr4V6tjF2J624rch/It49yvZoUowt?=
 =?us-ascii?Q?7WPYr8zAe99oMBDeAGK8ztKfJVakHWAByM4CKDzyZ6Frb145a1kLSGZfdpXY?=
 =?us-ascii?Q?cIKdFK3ppP1hj8PM73Y6lDBcrKjaQ2FQp1Mj/B0W84erSrhfQtejnT1nk42X?=
 =?us-ascii?Q?Ru4llLPghx6S1SrE9pkX3XCobMlUnC9bjv0M/mXCBJgvoICUxE/LmHfiVwu0?=
 =?us-ascii?Q?3hsmW/EoDdYzITf1Nm/RDRoyBjTyYvXlIKaF0wBFpSVh3mKK5QUpcOpdcX7S?=
 =?us-ascii?Q?stuZjO2K8KNjKoCDA58MZOva4zQstYzdtdZN3W6MWgg8ACChrJyRB8nIQ08z?=
 =?us-ascii?Q?HMrjIzBcdnFkpblJuNYTiDWCenQu3q/6ErGQ0XN62PioJiIsghSVM2XYJlkV?=
 =?us-ascii?Q?7oQUlc52XY+HRpuL4CBJEOsmffkeHLyVxSsJhu0WGcgb0tvDtqlhWBrTmeEL?=
 =?us-ascii?Q?DoJ7zXUEBiqDHlmBSeHztfPOtUK6CPtVJ8PjGgj7xQm5srN2ZMEeupUCNiID?=
 =?us-ascii?Q?I2QkJYnqeS7yHFv3pNXvokFn5pC5f30ZbaHrWidCplLPfoGVAgRajLWXTh5f?=
 =?us-ascii?Q?z5SlBaOFvdfApWJbkQdhNg3mou/n2jxRHBm8KQPxtr87OQT7ghbkeVt6Gr1d?=
 =?us-ascii?Q?aLoliYR5vJ7LnbLdPrcvmd53gDaSVRmtFnvEi2FX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JULQjAMUIBIv//TNsGKAxF/NE/9uJAm3c9S1ON+Dv0iGbSXtzo/iGeoILzRKcEH9mhU+T2/aPhrdvjQJz2meSuwCevUpY2UOK0zdoGmEwhI70u3R1NERpRdvP+IlfIErBmdhggzIxfCAjN6FBDWaCjiil/Bmy7E7uLA0k7etnK8CNAS3be1CsjS3XDTjwiwjPTrUxnxoMk82iETGv/cydT7r7LW2hSA7kAWPLgW8sztRWROh1m0feXRXyO7DnGex6TjnQ+Ac6GnUvwS2iFORCHPHJK1/Nbgd0XOR5Z6R9eYcV8Tvyh1li3dT1xR6BmTIqCnzxSrSfJs1R4DYVGOqpAgInSkOg8Nh1y1TzKKdsoGe3NJNenGNcCBD8yqZjrVaAmw5P4RfnsBMFDcltem4ymmDuXo4JQgIs6Gw5QZH1C2IjYLogiwxz64GwjTHcchmilAeE1Qbe1xa/VlByS+e8MEvEizDXWv/pPgZeAYRUUawgPgYHKCp/XqcKokcp1+iRu97nuQBU4Y6eO2ipGsMZeV5FY1J3Bh+0tKVZYikVXB4y+N+ZT93hcJBY3FGXGLtoHDowB4sgfnuKZW6ZMVF/UmzgJKWeeLJl0nCHNv/Pjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4401101-7c1d-4862-1753-08ddc031aa2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:16:09.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7ikFscqky89kRVG2EOgK4XPICgKzuICFZ8REgq1DMSWLkWxQArxKRBC/Eq5VnqWzGxSOo2gBrMCbkDQF4cuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110027
X-Proofpoint-GUID: Ln97Hvo0vyHSiSN7AHl286P9ziPw6JX5
X-Proofpoint-ORIG-GUID: Ln97Hvo0vyHSiSN7AHl286P9ziPw6JX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAyNyBTYWx0ZWRfX2hluTDAPZT9V ULgGQf7NUPxOHx7b5V/e4hCTuOmChnvBEzD5DrUStRqTNS+3DXyQJcEuRV7CEl8LsI65x1fWthZ RTc6RpBeyy0GDmK/1KC4It1dHJQezEMhA2XWNgcg1lIUoRgHRaQXADyyRfKP4KXL+p1uHSgEQNb
 GSGFkbNHp0omrbiLjATS9blX7np4FPCcoOBi/21Evj6aZ0R2y1NVBeNrSHQ60Ne6/EOnMmpoK/A 1y8brphfSzsic0ThBmjMgH9tnWAdGslctNilHtkjwP8aX8oYJtkYrvDgBzNiZmqhIU1iXsBevSV Vh0tCnsD52RQKbWJqWq1s87HzkKM6GeLwdD8eBmAxfweM9cxrEHuyaWUyKbq7Q1cI1ibko4WYJq
 Nn36lYECxR7KSXVVee79djetpQ4F4qsHAVySWs+P5qvHMlqIYBp0cl4c4YcbDyGVJ4Pcvd8H
X-Authority-Analysis: v=2.4 cv=aM3wqa9m c=1 sm=1 tr=0 ts=68709011 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jy1s8I9EfRkhvHnbBRAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Fri, Jul 11, 2025 at 01:02:08PM +0900, Harry Yoo wrote:
> On Thu, Jul 10, 2025 at 05:27:36PM +0900, Harry Yoo wrote:
> > On Wed, Jul 09, 2025 at 02:13:59PM -0700, Andrew Morton wrote:
> > > On Wed,  9 Jul 2025 22:16:56 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:
> > > 
> > > > Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
> > > > Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
> > > 
> > > Fortunately both of these appeared in 6.9-rc7, which minimizes the
> > > problem with having more than one Fixes:.
> > > 
> > > But still, the Fixes: is a pointer telling -stable maintainers where in
> > > the kernel history we want them to insert the patch(es).  Giving them
> > > multiple insertions points is confusing!  Can we narrow this down
> > > to a single Fixes:?
> > 
> > If I had to choose only one I think it should be 4917f55b4ef9,
> > since faf1c0008a33 is not yet known to be triggered without enlarging
> > struct page (and once it's backported it fixes both of them).
> 
> On second look, faf1c0008a33 is introduced in v5.13-rc1 and
> 4917f55b4ef9 is introduced in v5.19-rc1.
> 
> I'll go with Fixes: faf1c0008a33 because it's introduced earlier.

Uh, on third look Fixes: faf1c0008a33 is incorrect :/
It's Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges").

This is the commit that started initializing unused vmemmap with
PAGE_UNUSED, and can lead to bugs when current task's mm is not init_mm
because as accessing vmemmap before sync_global_pgds().

-- 
Cheers,
Harry / Hyeonggon

