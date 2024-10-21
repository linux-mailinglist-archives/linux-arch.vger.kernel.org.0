Return-Path: <linux-arch+bounces-8401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CA9A91D3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF5E1F23527
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FC1E2312;
	Mon, 21 Oct 2024 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OzhBIUz/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z6JzDWqr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150E1D1744;
	Mon, 21 Oct 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545242; cv=fail; b=Vh4srJbga/ByDW5IXdlrE8SH9/FsIiqchrvK25NUQ1/bkYxxLfGigyIHRDgoqEX5BTAM7Ws+2YaBoXYsWMOxwGdedzK8ADmkS6cyACrD6o8n6+qRN0JLMgnP5tLyFFxMvEpriHF8SeZ69oS5zsH8zn/uxBVOeuyQGNIsm9mUbbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545242; c=relaxed/simple;
	bh=lu53AdXXnyeF8/r8OpdxL99LxeOAfsv7rta5aMHUvXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GQ3AbQy6gpivFGFA4tlXrCq3MMLTvLo9iKxXsAiQ0nbjRuEOrOBDS6HuPpDByaN+SvLRiEvl3se124r6g7ku0ZfDNOFUtPb798f3eVtxgncIPkYNalSRKFbYuT/HO2e1WNOtKn4vROG9ZXIrdXow5qVUOlZ65siwpZjHEUtDMAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OzhBIUz/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z6JzDWqr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKff58010208;
	Mon, 21 Oct 2024 21:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/Af53GPFTluL0BLfBS
	CQew9uF2+A2FUN7dDeYp44Ut8=; b=OzhBIUz/CsCvbyJzDZ3pjDw9dQXbGVi7CD
	eJ07cJUJ8ZRr6A4j9UqGjbG6B2Dv8h2f9bhaRb/Xjjs7eMQ0qaxwruf/uVCa6dZa
	C2q6efUPhG950niCyJb3UgI4Zh1nrGMYQ/iiItvi1uFhWF57n/lve9nJh/rggcAW
	OiWZXbVt1zuenjFMTSYd7UVBo96nIKzlXhllyI/0KLzZYMRAfwijb1jpf13dcW5a
	hqcMP2985nv8TJtl+eujUUfr1AOcgIawabpHhHDTn1c7E00qHJU1nXrRQRIzlW7W
	0rxKykSBPNLa58G85nuL8g1uonPIqk4pfKP6d9+HbH66tutD+2IA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ec522-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 21:13:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJonm0026174;
	Mon, 21 Oct 2024 21:13:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376v475-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 21:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOSZhrmUGB7rALdD+GSonPk+VFadYt+yNs02OZLeubFgv1yuUGlOMaWtjEU8hpzmdpszeH5ND2rnsvDSpne2qwhxbFIF1nIBDU0g928P176UC7I3qHaEn0gakh8BoiY6+CbgtvLxQrP2+ANLWR/4Yvboo/t+/MjCpLrAn43a6QIgQcT5K5HafeEyfO4u7hkoV5MagIAimC7WClHF905Q+mZfs3o5LI5Id8Hh2rxfXTKMBbn7Yf57SvvSfWVe6ByZH4JMAIu55zZb8dJKQnqohFj3MXF1LvCYaLteLybkyGZYs9nu6MLasDZkIUchZX+DtP72zUxYNEF5XFrAuu8sJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Af53GPFTluL0BLfBSCQew9uF2+A2FUN7dDeYp44Ut8=;
 b=kMi5YBYYc0FYLnsU/dB2MvfcHFBTVgwIMfkBWD/Z0MPZDWy4g5zyS/GD/AZf5YIsyp5BZMgwllqB9QD5x78SqSC1c0YfKtbfopkwd/n35GuPJhhGUx88vG1GZMVyGc8p7CNjL2U1p9qC8Q8nw4DRlADCEFDdZ3vWq4LThpZqFV+cZAEORsdl9Z2Q1HCM/SKn01KNLRAUrz7DCyYYiU9QKx0QtZvYCDW9R4aSSd5fcAj+ypqqbvRUW0uNGwYOPnQtTAwHEwguKHi851k3Gt/RdigK6UD5GBmrS5st0WVH9hEr/JpUq5xa1OJoApRaB33Gpfm/VudcSNjRW0A5vEJr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Af53GPFTluL0BLfBSCQew9uF2+A2FUN7dDeYp44Ut8=;
 b=z6JzDWqrG3T6+YN2urxLmuMTqu6NpV5UQ4vRL8KlAPhSIoQMCdYqbQ6Nn6B+RuplJNqKFfgqrwz7biDZGNmhL4KTfyoeYJs8Byi/Fvvt+BeRGcNpWq6AEFHVh+ao9TjeZHeBg+l9lFyHjklcNpsfHGb9Lg3xsPd2YVD1T+xhMA4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4268.namprd10.prod.outlook.com (2603:10b6:5:220::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:13:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 21:13:15 +0000
Date: Mon, 21 Oct 2024 22:13:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <5ee11594-c40a-4ef1-a6c2-f1e38da0e9a3@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <9c0991db-9bf8-414c-b3b0-446023df2a7a@suse.cz>
 <69d1e02b-aa15-4712-90f1-6166b551b992@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d1e02b-aa15-4712-90f1-6166b551b992@lucifer.local>
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: a65cdc1b-88be-4e52-54af-08dcf2152d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KXqJWvU6QL5bDZVnGbkV4pd2Lchu7pCuz7mVPDJH00EMywank8WWZG5vsrs?=
 =?us-ascii?Q?0a6J2ljCucfdAZgojFCk7iCYyWLgAOSuoEyEXPO23i7xyMLyGeh7mnXXe6uM?=
 =?us-ascii?Q?TOjjH/EJxlxuCj4+eDWYkFuzBbudy5yS1wRIW17TADNY8iKBld9LMlkblOGR?=
 =?us-ascii?Q?oArQp/mUuHyffAjZhhAewVuOaUUygghNZJ6OrIbh2BwWZPrnw/JPvDmrAUWr?=
 =?us-ascii?Q?DBiz/wJiy3ksK1+DHvjJNZ4GFkwZfZIHcDjUlKTuVvJqe0pXrGAVOmJbTGYm?=
 =?us-ascii?Q?GeIE1J3TUwt4moyFvzUgZ8mH45lAS8o057lFaazluh+bmR2ytQ77mGdAg8pO?=
 =?us-ascii?Q?sVE32irX2d2GEgOu0f6FH03TK+jNOyT41NhGAEVLDcdeq5jIqLXDraAFuveh?=
 =?us-ascii?Q?AdEPsfFQNYXXNDf9g8NUPj+AC8/dg1T1s9Z67Y9ftsn/engQ6B8kYIyp3Paq?=
 =?us-ascii?Q?eH2Ne1a4TP1iea4y0rcjKAw/+76WhEQ2lFxi8IT7hwnYtt7T2PNJISLK18Nb?=
 =?us-ascii?Q?g4R/tTYAr6eHoak24LvX9XSuqzeCQyMt99JwuXRztPr+HzPfTiYvpfWwwLy0?=
 =?us-ascii?Q?s0u/WqNKXAQEMbmmG83YrvuVTF6gQkzEhuYEK44b/DwGH+TKnQldNCQGfX/p?=
 =?us-ascii?Q?r7iMJaWSeQ5TvTWGxRRJNcU84761npSuNy2OvkJRNFaIiLMtXuMAR/8VhOOh?=
 =?us-ascii?Q?VwQUzhLIg53a7wqkhwdrh/TuHhwHev4ctLTn6BrwTCpQtq49lnQJNjrOcdTh?=
 =?us-ascii?Q?KtWfkOpy+klWsCD6S1+cbmEIHdGARoEvUuFIteejQuOUESDkUcqh1dmFuCUj?=
 =?us-ascii?Q?/+IoXV4DXmXOOhoMhLxv5WVzkEzl1DoDp7UYbcJrO5TWogYV/Hre/e1SII1z?=
 =?us-ascii?Q?NX17mbgIZEwXCN15UD+UpF7pe6nb38A7QI/TiY1oQzHkiJlXzUUXPns8l+PG?=
 =?us-ascii?Q?dtoHXOPAB1M5ZmF3+JUeBd/bydT1FS4KVDlyggu46WAe/Jo6uoPAj02IRHBA?=
 =?us-ascii?Q?ZumJhDJYKl84mbwvSVI6yL5AnW3wd2xKuaRrWJ1pJ739bJLND0+sfLuHFnsH?=
 =?us-ascii?Q?b2Z0FxosAvufWq11g+egdSN2Tyai8Ycn/sVTsrl3zig/NSusrGVyLAs2Cvcx?=
 =?us-ascii?Q?jI5gprOO+V4klBha0JJYd5C4XtiKwq72bnbIWuCkhY5SiK7q0/D2FxT1JZDf?=
 =?us-ascii?Q?aE7yUzxQwMIGZWmZtTpQPWuAnEO8SHrF0Qmw9FnFWGbaEXBbBlS4Mqp2354p?=
 =?us-ascii?Q?JV4Q8mmAAhuAeLasDH1596Z2JzxVDoxFc0VR8+W2KucpTbBjUBcMD+4GCLop?=
 =?us-ascii?Q?ZQOXKVBj2eJPwNnz3Iy7zNMi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9Z2vIz7bTnFujuGBc0mGm+3K0Din3yZQJW7kM32TC/8dNq3CmOsMFItbXjV?=
 =?us-ascii?Q?GuTTeSBmuwenmwzn6N0eWPIpmy/Wi+dp+6PKv9y6KEB2FEVbmmrhoOm8YCK7?=
 =?us-ascii?Q?5ajAY+oEx7iwHhYnuftR4e020q+TMKyt3GizNOytIctiEcYLv3mFOQH3zCda?=
 =?us-ascii?Q?ZttWq1+wFA/d701dZCPCJo8rluhqh92S+MiOsQFOFTxtyLo57Nm2QGJkiXe7?=
 =?us-ascii?Q?R8i0DaW+Cs0sb6k5WDj7Fcic0gnLcUitnbZ9nuVBJZgc4cp2lq6htFGDM4en?=
 =?us-ascii?Q?20Nx9Jw+MR1Aw9Pbexmx4GgcCYjoOUh0q+KelhepX1MCw9CS4IeiChw9Mrjs?=
 =?us-ascii?Q?tNE+vE45769P/zaz7wDbKAYn3d2AUYX0kzM7p0zLsPrzaBkJmlAb7t6ik4zN?=
 =?us-ascii?Q?Y71C3+UdtXpsfDvDXAtwPR5WrCDURSRoEUsaJkteQMz/Q8AyXvct9gooIOjY?=
 =?us-ascii?Q?LT+cQFP8NHty7wDgQt8ZPLFD/GA0ZQK9HrgrenBx6fBUopAPluJElTVjvw3i?=
 =?us-ascii?Q?B43jDqT7Egscj9zfKxyBV/JwBLXffBE+2qDn4fXK5uCI6tNS9A5toMulvepS?=
 =?us-ascii?Q?roLjTt9JDM61yQ6rSGXVxTqADXBxfmTfZAUB2EA8tpuflN9xYnnvf6QoM4/5?=
 =?us-ascii?Q?CeRjod/nzaqD+3D2BJ0J2M6o5HaL7chcAGOPb+FXtWqGqJ2pmTl5ZFYf1z+p?=
 =?us-ascii?Q?TbxXx6DdtVE0LXZi5WU1t1LjzA/TVODwBmj54/KfNsIkElqGM0Ig1mZia5cV?=
 =?us-ascii?Q?MvLiHGD0ODSyeu9qgz54RHxs1iF5M8XAWUGZCS4ysjpVtcFAYl94DsWO7qcJ?=
 =?us-ascii?Q?ZmQqjnB0cbZ1gzilgyyUhuMT4YtkudLb07SB0s4paqjcsCdE5SZ9ng1HTLre?=
 =?us-ascii?Q?5GxMiiEOzeqUglEN7EoCnpIJXtrfpu+uIXxex6Pw3YOpg+TDfZSP6w71/pEY?=
 =?us-ascii?Q?xpCYvxkWW87CsnldHSUnm1Q2Laq/h/1Tqy3Q8Lx+rbg6AlNnRBfqfVR/+4T2?=
 =?us-ascii?Q?7ggCZUYRaaq1x4bQH5v/pOH5TeNVcbaDKWvnw2ZL//biTs9kwNUD/gC949xH?=
 =?us-ascii?Q?PkDZZ8NQjdmW01egZtjZ1zMyfR1L29esnRCDFci3ys2ovecx3jr8nFGnVXYH?=
 =?us-ascii?Q?xwJhz4+NLllKXoTrTNjT48y0XVnfBnqtOe45IhtvU5+mVuRiAmDHNDni0L9/?=
 =?us-ascii?Q?QfZpIurRl/IFf481zgMOy/e2h9o0OyWvARUiGZRwWG1PYP9XISLDKudb6+zs?=
 =?us-ascii?Q?dwa13nSEryCfW6FQsNmopxZKwdDAYrFd7k21h91bV2ULMhVY04xUTywNpq9i?=
 =?us-ascii?Q?f9NbEHbLc5T2RUyIbvsQNey5H+McjPZn0juIxontcZrjL9Otl9BrUGOWbAXs?=
 =?us-ascii?Q?EXfmLARkLxkelqMcgvMfmj/jKG+3F2VjMkrDLsjgGveVGcPSv+qJ1oRhO25S?=
 =?us-ascii?Q?X/Bl8bfSHM0BjuRIKah5VLaORDcCpWKN+64161DtOHXaERhl3uBWXR0LkTK1?=
 =?us-ascii?Q?8OA0f2iDgBCAl45tpePc+vgp39hVSnPNFG3aU6QA01QZ7YBKLJYN7VDxqSHA?=
 =?us-ascii?Q?HCOKqIvhmt1PixSZ85v3nSAwxaadT8DjTK2SyMKskXfxDQMg4g5jB4AiJbZC?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YX8DTSGSLqC2qg4ny6WTpS/mNTZAEHRtFQq65RmBlinde1rUTPZJiIIKnRlfRwgkxOzqZdA1IdnlAz7ogttz5nQ5sxDkY7BpzmkW9tvrSV5iK+VafPOa07251V9KWJdLQnwZwFG9lZUFuWWtrJUGNNuApfHaDxFRZZ/ezKYVjikn2FTRAXRjhLD7e+Z74Z8QOZu3XI0ZfZvOkhlaOUOh7ys09WWsbnUoZQu/HeBfbdnP0+NFfofKMQMYhzMbno/ZU8O4r4pkb2FfdVtlc07Ri+sla/i7p/t4U5xU2/S9kz13logEnkuzZfP7Cyz3kx18X4GDreOEqgFfqWugwBUO8ymIIM3KU7cq8wZD79Rdc8jjyufCv2YsmiP08xnZAv5ibzvdp6xn9FRemIxVZN7TfyLWTcRIRPZ6+oagNAZ4YzMkisuC2uaMunkpJ5g+QgnwcyHiv+EV3Bn88blFkmQG5StT7TKNcJqW+TWvV26ZMulJgZRXCGz4HBwQHY+HWVUDr2xUx/jbmS2E30FgTWk5paKkgMPsq8Y1/ZESzVS3dNTEmkgVBXhpHTUQPrsuh0ft3Rn0gQrXA4J5Ov6ynYn2y9tJ9Dzs71GPb3R0fAD5eY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65cdc1b-88be-4e52-54af-08dcf2152d84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:13:15.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGu6dj6gfTMDXPeKcGe4QE2uMEuFLxuMXU8kt5491+GE1pGnAViQO7qSuz1cEWPfqPe6GqRxCPcimikNHbBzUdwkts8utyE6bYmPCJsh4O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_21,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210150
X-Proofpoint-ORIG-GUID: 5Vh_vNk2JaZieDUvQmxvI60n2GFqMXVG
X-Proofpoint-GUID: 5Vh_vNk2JaZieDUvQmxvI60n2GFqMXVG

+cc Dave Hansen

On Mon, Oct 21, 2024 at 09:42:53PM +0100, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 03:45:31PM +0200, Vlastimil Babka wrote:
> > On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > > Add a new PTE marker that results in any access causing the accessing
> > > process to segfault.
> >
> > Should we distinguish it from other segfaults? Is there a way? I can see
> > memory protection keys use SEGV_PKUERR, but no idea if we have any free values.
>
> Wasn't even aware that existed!!
>
> I'm not sure a process can do anything particularly useful with this
> information though?  Hitting a guard page would indicate a programming
> error rather than something that might allow meaningful feedback to a user
> like memory protection keys.
>
> Do you think there's enough value int his to warrant digging in? And indeed
> I imagine bits are in short supply for this and would need a strong
> argument to get... so yeah I don't think too worthwhile most likely!
>
> Thanks for the suggestion though!

To put it on list - Dave Hansen commented on IRC that it would be safer to
avoid this for now due to this being an ABI change, and reasonable to
perhaps add it later if required, so that seems a sensible way forward.

Thanks!

[snip]

