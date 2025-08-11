Return-Path: <linux-arch+bounces-13116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23FB20760
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EB63B8113
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743B2BE7BA;
	Mon, 11 Aug 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ku1TrKJJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Chvc3ltS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A5243399;
	Mon, 11 Aug 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911166; cv=fail; b=OI5cVmr+3w5CvX42qCr3dM8VgtsMIhB9UlwqqYcaDkBkdFTJIUSLW95hcgRWfDGla4KppNBx6z3an/aeK+gkLWKWbJWQXryWQpzIty/pr4vFOs/57K59iBxfwb5QhhIuxb2nOzU/RauwGKtyIXkw8gnxJ9jYny3msfzjV4GzHtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911166; c=relaxed/simple;
	bh=Z0E4GDa0IXU3oTUVfcV3/4zpSzmsyeKLyNHTSY1Dj5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r2qvueB9pqC/fjrt740OzRJvr3Q2SHp/EtTo1YqSgfLLVGaAzJaKnkkc/5BoAKeMfvdlU0nkP4bCWbH5DRTwyDIH+FJpdVF8eKNkGHWhCHslpJ+NJ5c+Q1sMWNH4nlNAC5Gt7bAnEZUNliZ9PpS013o2IXnlcsDAOpHKaywPtuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ku1TrKJJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Chvc3ltS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uCk8007909;
	Mon, 11 Aug 2025 11:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ChgID222U7AyEZTdsq
	mAYzdsQ6moDMyw0Vlv3NeNVEM=; b=Ku1TrKJJcE2TvJaLpooQryrLPnDGG66k3r
	3l45DD3nOt6S4sXoRwGSN4l4Zc/bzwsaQ2/BxVtyXiTGxcG3I4Ze7phhJTiW06TM
	kpZIf6I8FfnZTQPEJeB13VxsHACtqcLmKq2MzZzJ+W4A+f/THF2Pq35zUZHdYrgP
	Hpl3yWfIGvjJV6Zd19M9h+KOtVDDm+WYh5sVhkl3DCu7RM02iHIkS9MelKR/M5mr
	WV9vVdHQKBUGpSSReMMZcG/TKKp/yr75OIYwj5QBE62STwT+DRDjChb5k4zFqMfc
	rrQJTDqzeYSi9Pb40PNgyD7a/MRMtbqqOMw5jqSTBzvkNNSTsWJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8ea8sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 11:18:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBA9iA030150;
	Mon, 11 Aug 2025 11:18:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8gpa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 11:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIAT61y32qt7NhwQXmxTmZHE/TFkgE3IjZat+i+aWJh9IU9oZQ566CDaLpfxoap9h/cBssg5HQGNZJhrQ3hclBgkfYXaFUU3SH3LZcFMWKdaZWeEMIjxwi3xjc4yVnDGk4LwV3DOjaAK0Hm6vp+69zHrsw95As3ZLsSFxo9zmRPuXmlQCzbd7l1TdEtgmiJ8NjXamjXU95DzHaMSDYsVxd12zxlczIQ/pWDECQUrrTcQUeLDetoHWm2X9VZdRpp351+Btf0bQwT3rdSos/DSjXkDf+oB+qZJEt1UOHDhzR4gFDXJxzcF2yM6osrMFd4NNdvsgIJpBh2M0azIpR3X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChgID222U7AyEZTdsqmAYzdsQ6moDMyw0Vlv3NeNVEM=;
 b=lABUjL5O2GD4LTeiexH56o901JYMvqO5cR/xs1SaXum59fJAsiruiAwYcA/SuVkK1Vp6LyvYqX3ztPedbcJDixTniAUFmeBPreBOBbvOrMo9tR3G4sWusxH9I5cX3SRP7Bt9ieLiPrXaBrBPI/g+zWXw4b9bsNi49/umIWiSyR7h6mI0gw3UIbvZ5TTzaIWQvGjl+VTcco7ijf/cxMaN0CPULwDInVKhWCTU+kG6SIjOOwjkl4og1+fMGMFF0lqTLN/qpmxPjL4Vn1A5cfBo8cPj7OheEVgVXDtxg1+ERmlx5Ya0/lfEM8/hF9vonEeLUttZp8aeouGApjoqcgIw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChgID222U7AyEZTdsqmAYzdsQ6moDMyw0Vlv3NeNVEM=;
 b=Chvc3ltS4p4plrOeaSuTK2lLFKrWgXbfRmy56R+iryseLR/h0a9t0P0PteAwKEpcYMHla+InKX8vADKdnYD/FLvVWZEyYafp+SpPY7QHsniWjTUuo2uef4NAOM+yGIihbLodyQBjfnV5UmLyALqnXSp5d5MVqfMwVtIlJ8MUUiY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF6ABE13187.namprd10.prod.outlook.com (2603:10b6:f:fc00::d24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 11:18:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:18:37 +0000
Date: Mon, 11 Aug 2025 12:18:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <30545fd0-fd5a-47bb-bdb4-91246379b97c@lucifer.local>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
 <1e8ca159-bf4a-47ab-b965-c7e30ad51b28@lucifer.local>
 <aJnHvvb-lViNA5EQ@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnHvvb-lViNA5EQ@hyeyoo>
X-ClientProxiedBy: MM0P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF6ABE13187:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d18096-0fa0-4715-b4e2-08ddd8c8d110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIJd8VeXTjQtcXwo/8tRgg9jqCOCVys5TeJ4F52glLNzhjBiLet4v5RsEgCr?=
 =?us-ascii?Q?7jAixDEfzg9Hv4FcnuSS9xuQ/nUw45FiJZIu9JPDD4TPX/6IpoNFiLUSDgEl?=
 =?us-ascii?Q?NJN91F8aJT3ShX60KQpVUvM7bAxlPz+L49mBEnJMS85Cg13iT2rkJOOaqE3X?=
 =?us-ascii?Q?Ccj+hWZuqH3N3NvUz2D0HwDW1AOdCyIArVxgbCk7X/iynZf5Ah6wqcqgugs7?=
 =?us-ascii?Q?oNy80ux2nELAM9BtI3wgzPt8flQTLk9JI6FPx2x/2v42cD3DoHKgdRCBfFJ9?=
 =?us-ascii?Q?VBCcKjv32btor3eJBoFkhT/8ze1cIeMZI//sRVZZiiQ4ttuPgo7L2R4xew63?=
 =?us-ascii?Q?3Y4gRcdHQQy/G2NADJvTgrQR1ERKWqPYoGN4r/W0hhXFakV17odWXfN0SHMQ?=
 =?us-ascii?Q?k6Wb0ypP/NvBU9PGwI0n1nsMUt9Z951IWnBSi5DNri4K+CChdy/+VP9uVgGP?=
 =?us-ascii?Q?9AqDyKvu4YNwc70BtvfLYT7YWwVEDnl6wKVAtb+9jIS2wSsulmxZYPy/fWf4?=
 =?us-ascii?Q?CRG4SAMtllge6Eb6/xv6yOqPkbWBwwmMI6/YxWscDvusRNwcIasIoekV9rSV?=
 =?us-ascii?Q?yCY6W40rCS5JfSDdMjNZXZdJyLUlF+QRAuVT0MWxdx0caQ8FgeQ59hOgqXk5?=
 =?us-ascii?Q?CSlBw3wEovoy8aZSKEnk50vBzwTJ0VyAEgVmRwRa+AM6hBWJd53h7Sf6WLrs?=
 =?us-ascii?Q?mVocHQAXi4dlbdvdIUYupaGPolfgyf14/W+Z2VIN/cRrNHe4wi0UPEM9g2S7?=
 =?us-ascii?Q?tjADuHXfxom5/GtuqG4Ietqth/jyJ+EO7/8QLnNzKs1/a8wizP2jpHhJal/Y?=
 =?us-ascii?Q?eNWouaX7zWOPP1o8nij7gfojCNXsEanUHoBrrA/RoFo45AQill1vf46WtxEt?=
 =?us-ascii?Q?ZoKxVFk9xNy/L7dvP/fPn9dFWf+Zl+qpMHUWuwLBiTjE2D/e9PoIZVU1G7Vz?=
 =?us-ascii?Q?9vLSzxzxXb3X6pP04y1350q92ldAcTNzVvwhG95bfQmPL+YOTAZSRYIy4gRn?=
 =?us-ascii?Q?gAFi+gZj3axAsvebnK7s9RKx9SCqPRTe7eNwofZZxR/llvJ5Z7j0Jz/eYCkJ?=
 =?us-ascii?Q?WL7wO/vJROKHXdP/RPoTCQ/doV56CvOkShSWD3umwtQlYp4Z3k39tpMV67E1?=
 =?us-ascii?Q?o4/rlGfhf/gjHtVP+2qlbbdFe/yrrb7spgCgWCqJ/mey+N487QF8n6byf9hr?=
 =?us-ascii?Q?IMHWxvdwzOvq5aVkCT8s/jj/AHBOSrJZHm1HIQd0MRwW81DfQOERkbloNYJq?=
 =?us-ascii?Q?Ga9JRhJMLEo9t0A6Q5lrARonVE9Iz95D4Bkzv/Ox8PKMQ6ag280Ww1ZZ5omc?=
 =?us-ascii?Q?NMEaaGdR0HCEEw+E/XcosPvKuP7a6UGQoHR4T8EHKq7e/2e9rOcS6D9x7puN?=
 =?us-ascii?Q?wRVDphG0VwokW3EKgf6n55JooSZ6syOZ9MXViAtSCE6YcC3TZh8qVV5cR3kX?=
 =?us-ascii?Q?g8zv521T+b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdkrLVxilT7UrptVJZlAnDlM9rbMRBAzQZixXsNgu1HAoSNJrmMQSnYAzwi+?=
 =?us-ascii?Q?VFpT7kKjNfhRzBxX92FHHvO94zRAYa2VpN6KfWNPRMoMWXwfwg+0/9a7umY/?=
 =?us-ascii?Q?tE5ldnepT7hBTOtobbxhWhGhFLRiOpcLt8zoAmBIq4kvDONp44K6HZ0Rr9nL?=
 =?us-ascii?Q?cQO3AjtkOeTUnZq/T6drU4MjPnouRf51gRuvEnBH/DI0y2vZsRv0CWDUPaeL?=
 =?us-ascii?Q?RgCVwsDKPIbNTlwE+HgcZCAl5IYHf+RlCWKhWMlvPYM+ZN11OkrvrtG4UdpW?=
 =?us-ascii?Q?0AmuNuQpa8KflO3mwy4T6HcF+1seVy+L/1Y9xYnyhNZnsHopuRyUQBLBsU/2?=
 =?us-ascii?Q?Iby582xl07oXKO+T/c/rBXBf+kbz3Y2xwK1wjhZQZkhMNe4LEmr0p0/gANr3?=
 =?us-ascii?Q?d+t2PvlPfeka21jTIQePhpqoMcMFGGsrG/nC3V32YG5jaVjAPfg3j8rfB7Ht?=
 =?us-ascii?Q?8jsCcGVZgfmHWLYgwH0jGvOvse+wXa3IZDpb+uRdrRhJiInQXFMvqqc/4632?=
 =?us-ascii?Q?TZkeAMCheH6HaRp/pULHVC9K8jG2zmNP1xfgJWPuMli5T+0CyRinQgyyA2As?=
 =?us-ascii?Q?43DDVAWkGnB92ToEaSLizHQvvq2Ywo0j/SBwwqaMZjSv5CoqmIs4mWZl3MYD?=
 =?us-ascii?Q?tljIgTdqqOUBhkwVJPLjCKaVza2tyTuwPxNURtImWTjZWWIfSvTrY/SxZHq8?=
 =?us-ascii?Q?dQzxTzZwul0vCHTLMhUGqEEoyekLeApT7CNtn5mj7tjvwhGcdAUkDb7lTZPu?=
 =?us-ascii?Q?oW7+ejm7p31Ed1nyZ4I7RKcf/sJzUNkBAt7yArOWr9Z5JyvU67Ydr82MKY5v?=
 =?us-ascii?Q?2aRsv2TizrYocH/LgSce93U6MzL8GL0/MoHrFywGRB4k2K4p2BRbNV3uwNly?=
 =?us-ascii?Q?bLxp6olPVFlCim6nS8QYLuTKscaGhk5UXFAWsWELjeG+mH+9RYjLOvMq9GRf?=
 =?us-ascii?Q?WBxZ4XjPXoFWQEbQyj1owEqoH8HmclJSwobB0NcSPaYneiSvWkn8+RtTRo/J?=
 =?us-ascii?Q?Kl2UvLLPDabEw41szjYDzO6qDQhn/IbvQ/ycwwSPd+UXQTYRYxchYyK4t7KP?=
 =?us-ascii?Q?RpaZYUnFJoWHtU5nttiQoJ9kt34M1k2G++uCNbYCbJ/0jBiN3JZjoUYF5JoP?=
 =?us-ascii?Q?gBI2OSS5ZyO2wyNqFXXk8XVCVps1CbSoA5NBzkvmM+Y5HB7l6cQgybYGTTaR?=
 =?us-ascii?Q?ZEInonU/HKKLMCje0n15Gg4sJujKRVG/7hO+kAFYNfu3wZu8AGrqM5zlrqRt?=
 =?us-ascii?Q?VKCw7rtjGL0M7qBYibB6he7NpbufJzRYGKXg+inNn4EGzVKdknhb+qvTS09z?=
 =?us-ascii?Q?mboH2mVrql2PAGrOMYd3fFH3ezQ9UJF0M7HlYuHeirN6vFhd6Q8JCKE60KZk?=
 =?us-ascii?Q?pKSDbqNtk1qE1NLd+xq9po3+9BcJRexzgc3faYnQJHbhcXqbL3gIzC90/n3L?=
 =?us-ascii?Q?m+oyRX7Jl/Z9uj2YQRa/NWv/aCUMaIR4aUiMYcLoP/oQGqIrMee5ZD7AuDQG?=
 =?us-ascii?Q?qAxSAKkW9cStm92FOGc5Xg3UDzuweYKOls3ZNrhMXvn2MD0zMqqVWBfX9GFS?=
 =?us-ascii?Q?JrrJyZA4+cUhrGqMCGEYkF4ybibAiKMP2QJBVm8rQ27qck+JUuieRM5ZZHWa?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HV4Emffjq0pE07DZ5JcIQuYcon4EPsiJcoz/mKxnLXmJXzW/E6uKtdXcg2rdDMkWRqxnJl5yf5dyzqT/fdOYim5+GfAMK5J4KG5cD+RnQBWZ6APnIYrWo1eMTR9SWVofB++2y4jBlrIl0GMS8EVhTKAsQAdyAIWRZwg0r0/0VnjpKEDU1roogwhaasMXh91n90p3UuFRSmcbiphMyUWuXShVjBMRS9WY2pNMO9x97YOrpDsGGGWnSuQ9PWh3szliyADfF3NO508lOZvpiRFlhLkLj1z2ZqsVPYuISKtfegTLpvrX2iDtuWgj9Yh7NCeUmEHQGeXs+ruRTjJ9VV+NUUPzonHxrnqMT+0i2kFOS2gVHkUX2FuvvJ4Xb7MCGZeMIsXGk9EHoBxFh5xL98ZYYBLRcnzVCD0d6SnkRYLLXAvdq/xKJICVqd1ojirz196TWDFwzirJ5Vny0fAgLLT4kvzNs7knIdc6cMomk0ISpiGh15PVlAKxYtzdkagOwNgfwm/wZ/1j0QPfrs1CA56lHJ1XHliR1fAoGAV1SRPtHWEonjDzVpBwB+NtpHWUgVy5sbAUWUjRia7+/0mrdDYRaYd3QfbE7HyngulnHo9TGfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d18096-0fa0-4715-b4e2-08ddd8c8d110
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:18:36.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiwMVCbFp0CH5FRcPenj046cMa20tRyMIFMBqzqwPBWgkrcX7a6xvOdjVpt5GC3hJNMrcXMhHABdm1zVm+jnvp14k9FDDUELm/976/Om+fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6ABE13187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=796 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110075
X-Proofpoint-GUID: O8MGFDAShaoRuteVKLrCIJBhNwboh-Tz
X-Proofpoint-ORIG-GUID: O8MGFDAShaoRuteVKLrCIJBhNwboh-Tz
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=6899d193 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=LVX5BnHCf0ildCi-QIIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX8LR95fI2+ACM
 +5j9Q+z5R38HWIgzJ2TclrzlUUtO3jXWEEB4NV0xT8XPIwHAFSHiCuqPU80YUEHV4u7VrXpwUO9
 S3M/0Tx0vUHLNgmbp3Wy5JeMD5HYjFdRQxNwcnL/NIqZ7wEcfD9b+2ramCXABCs9rAvXba30MUC
 GV3G2+WZPWtq7l2zpIN/v7rJ/9w4Mt9oWmSIocw2LbR52ynCrUlQrma4ocbXTQv3YWm9kTiyxl6
 RNcmiug4YhhZrx6eC6RTc7JCemhGEt1U3psVFfTi214bfujg/L2Lij9++Vm602bHUGhhLEIUWjc
 L12EndH9aEMuliEcctQF1nY4Rb09UY0wiIaAVnDImYUgNk5RknuXaayPGEL2tzCvN9BRadaJGXe
 wKSbEZaDJC2h9/XITxxCfWYX5iQgzpJ7P863/pdD0Nlwd+peXXlqC+rwV3oGv2m75nHe7AXA

On Mon, Aug 11, 2025 at 07:36:46PM +0900, Harry Yoo wrote:
> > >  include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
> >
> > Could we put this in the correct place in MAINTAINERS please?
>
> Definitely yes!
>
> Since this series will be backported to about five -stable kernels
> (v5.13.x and later), I will add that as part of a follow-up series
> that is not intended for backporting.
>
> Does that sound okay?

Yes that's fine thanks!

