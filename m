Return-Path: <linux-arch+bounces-8654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4089B3308
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07341C20490
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F21DE2DB;
	Mon, 28 Oct 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XRymvCF3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jKq8zzXr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEC1DDA39;
	Mon, 28 Oct 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124888; cv=fail; b=GCj5uSPxPp+CJZpO7Zh9eRel06PnjK3dqr0P2aMPs6nPNip4unUjI33R/BXDdRJ+Y+PU92TT6WEd6m5TnRntThjJc8CJA3ktqnp03i7ZlZzBLtbMCJFK32LOZLEWNJA06ePxOqaUqD04Mzzig0T0webEqcWq/mSg4dXsOEJ0ipw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124888; c=relaxed/simple;
	bh=jsccdrM0ptziF+Wm7fNiZgvP7YDffP22jwCXcOMzd9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3Ep4ycRd01RXLLJC1HxuisCkLDzDIVnVr0ehjzIh5/VM64BkIJqJFiQnS8h6sNHYyH61ZijyjzLm9Wnx4MEmCjOc4JfsIIG273oe7uvRVVC2e1+3pn6zwAIUsv53IEJV1t5cWRhwWX3537bl3Fmuz05W8SXCHhQzxR+M/zf5tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XRymvCF3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jKq8zzXr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBTGnk024845;
	Mon, 28 Oct 2024 14:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UqT2CVmVCpT+D5QlLXoeGeO/AB/2IlXG/SqYjtZ69nI=; b=
	XRymvCF3ZZ0enH6XIGHeCkGYI+pJ3lwSwD4SKGgyGvBh0FwdQaVVS5WEca+/4G+F
	A7MKSbfYR0fw1Bcw+z18GPHhujeJeWPUZlkXsBP5Jy8UY+FDCNxUQad2q7qHFivG
	M1LKYYi4Um374uRIK28xmP7ewvsP1mIdvWZmKAvKvpCgbGwvt69+dW7Va0+BmhHL
	kldGK7o5Q/cEIu49UQJLhgn71/jQXpYSWWDFGISo3Dlz8vqpli3IyUBEewKM2sPB
	k63KQEvrY0RMx5cG0Eeaenc/T3wIyEB5wduvEvVt/u/wyu9tX3k0cREfTGRSLES6
	4kLJGXl96kNFe0BI+HsKfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxjymv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCvIaC004777;
	Mon, 28 Oct 2024 14:13:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2ska3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffGlYtulRWCoJhjveaqHi8iGQIuVh7nB4EVYOoR5S49SE6QrhSgcgwcGkGbNUptTXa00C5+cXl3d98L1USfer7/CX7S+AVw66SZPqz/kB1loGHhSynjMSXQTPV5CaDhtyDPD2L9XL4krazwZDqO6r/mNMK7IVJ1HLaTNr9WU3SfnF27iC8PfgzkGIAMTvp+vRkqPSjx8xMU8VgnOBhF9MBNu1CdkzU8j/jO0FNXypS6KY+f8UlFfFnTVcbiE1QFptirT9DH64y8eCTNEcaWm1HroapxgW1Qbt1AIVsZafZnd/X5qTFJJhDJJmEhrzjnVp6vXtlNp9IUaOrhn1Y7/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqT2CVmVCpT+D5QlLXoeGeO/AB/2IlXG/SqYjtZ69nI=;
 b=zR3Hk9P6AN+dJ06Ccmn6yeKeNtL27cB8udgRxppjMdU1yNglMVfEsfFEgmRNkJWLZ3NjOu1TUt4jHMmDCjja/CVtNVJ+jtWnRBFW1HeVkXbdqyLrKRqKnFm2za1h1erBK5zO8M1DvikT36lgoYCfttWUOj7HFBV2l8GogcQxOsubuF+jWupTJyFhFaHllzoIiESyMeVghGzF0++kIN8k1aIhEBZmjHst0KdwfaxfJ4RPbvEnk5O9Zm0QWS/4mKBjyHeEpK44FZgINuc2qUwp90DTejIzPUMf1bkDL2eHlPw1/tX8mNLkmV2facgVqTNFQzkgttD8YjDSOvmaZCcxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqT2CVmVCpT+D5QlLXoeGeO/AB/2IlXG/SqYjtZ69nI=;
 b=jKq8zzXrCOF6bNv9P7+k+pUNE1+LE8btGSGOwz1QkZzNIG7Erd/nx/T0tvMG2tXEO81sumbBvSXF8qpRSPJF2UVoqi3kXyHHwusQq8izy6hbtQ+RjOvFajeAh9jxvZIdQGf+j7xhnY8or6x8ZJsY9JysosIjI756+5FPd70dCPM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:13:42 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:13:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 2/5] mm: add PTE_MARKER_GUARD PTE marker
Date: Mon, 28 Oct 2024 14:13:28 +0000
Message-ID: <f47f3d5acca2dcf9bbf655b6d33f3dc713e4a4a0.1730123433.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0451.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b84c7-4d43-4e19-5567-08dcf75aba37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a9xmdxT/Aa2+Z9Xw0HdisOm3Q/fFMHk+M6DvNninGY519qEwkRqnYCWiEtEj?=
 =?us-ascii?Q?jcg57EmMTTnj838SucR2YzC0miTZX4kubXEliqhJn+YnkAkvV4OAcsGchVQA?=
 =?us-ascii?Q?PXKAENvnuPN9cSsHiT4GwaB9UUbDhtipDM3Zeu5mM2QAFgrZLT/psEOvAyYU?=
 =?us-ascii?Q?qbYJiZRrV9SzvS6wIKCnDMtZtLcLVTounTFOJVQLv1FMK0EwcJxilFga/6KQ?=
 =?us-ascii?Q?iLfSiogKNTHJk9OnVdRnmqg0kBuZx5eOY8fsrJcm5WLK5+uimdd4SgNR9pKk?=
 =?us-ascii?Q?BckxhDdMnY7dKOLdUuta6g1WbIXUM+xrVkNQMibtmo9Q/MLIBasLw451v6Pk?=
 =?us-ascii?Q?WA/JWlA5upgsqw6T43Bawis5o2i63aUy2+jL038nXRpjMD14pQRnXniHFgyZ?=
 =?us-ascii?Q?ZOxxsvu0Mf7dpMu9tvowTHrYnpTKpKb0yf+H1le8mu8aFwmiKmx7fOUT5OTn?=
 =?us-ascii?Q?pF8I5Mlyu6WqCRvAbtNITFQZqt59wDoN5f4c/QnU5ulieo9J9Yu5Itat+WZS?=
 =?us-ascii?Q?JIqiqA4a0bKtZYYVUbI7/IOUzuK+g5qXsZMp1AU2/LdcYpD1JmNeih63XTkt?=
 =?us-ascii?Q?ogJew4xRjiFQDZ0hAzyjPxZldtwv1+rWSKVuMoXD/5Az794dCc7ZnGs9Xlla?=
 =?us-ascii?Q?9xCau97vALlkzBys+lzrEoqgJyjmfLC3qBoVqfw6E0/AcpgJ6xtPH7+gyoV2?=
 =?us-ascii?Q?NmgCyMKV8UWqlXyPLqhRs9MkXv5uvzoJuNeSO3InxOzw/RkD0D9hyBOxSPWf?=
 =?us-ascii?Q?TMShSTlSOmBLGq14OZOsgfELkaaX4rJaU7h7BSWhcxYwcnADyX1XSWtvkh+U?=
 =?us-ascii?Q?rc9hvMroMU/H68gPDblyhpKLIumQxuUJDzCmIKrOXGffbkoQ09AjVgGhbpd+?=
 =?us-ascii?Q?0bzh7vMpb4+LJ5Dd+l4ekozIulatzNbtSfPF2inLqMN/N4Q2IZEL5QBq+Fmd?=
 =?us-ascii?Q?iKGuWlPksEhvo1T/eEkwosGOfJjpkMr8HBc6U//mIOX/USkpV6CJLKjEeo5G?=
 =?us-ascii?Q?/NMW36pactzE2Ywl/8BM4nip3tM3m7+YMiTRh4RyjXb0QPRb/r1qT3rTGRad?=
 =?us-ascii?Q?REuAnZ47QwR1YBDythMX+n6h2EhgKsH1R9laeoKhCit8a6mtHu78uHaLjhmO?=
 =?us-ascii?Q?R0WLEZTqmLF+I8uqJycTHE8pl6z+6fgclcQjjUdiKuMX01wRsJcPNRKMul93?=
 =?us-ascii?Q?IQE9mM7nPbZorwWRk+nT2oGqh/YuF/ap+ADmxfs1Tht7EtSnzAtc8gbXco9O?=
 =?us-ascii?Q?3CgZGbbIqWkZA9Og3bq5mNkULHaf3fdeUhoYbXpM+CwSr1GIbzZbdU/Sps2X?=
 =?us-ascii?Q?63M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C2Z1HHx7dZGn2tFDqi6o4VqXRVzjuDfmgkIqBfiDMwMLq5ntHTGSU8O4mwEk?=
 =?us-ascii?Q?Y1zvNRwtE53LZYepUoCajfnM1TmYH4zfVJVD2OvCd11Pavqh2xLG6XWKzv7B?=
 =?us-ascii?Q?gDL3faFOgxahh/Twsyq1i7sVgwvOJ7JJpp55Fhci90mh2DBT7Zf3FePw8xQh?=
 =?us-ascii?Q?2ScsXyiDG+LvDGBKpcUEwprI++TigT1BlSn2OKfUDeGBhErm4iBZjzaTTDkY?=
 =?us-ascii?Q?bINFo6T6uVKXUeaCxmC2t9IiZ/f+Y3PWQ/Vk3BNEiCXudOdXGCmIMmIksdVY?=
 =?us-ascii?Q?D4PA9HOLr576zQ4sRI2aoyKIDjUdNvkwemGca6fwP3+fmv1EdX1TvAkD1DiH?=
 =?us-ascii?Q?RsFgH7z/pQ3YC2fjQMZl9xbgZ4SNBeoREgw8GP+/26iY8pKkP0j+r9dIg+zJ?=
 =?us-ascii?Q?pnkynIuaVLjAPReeRkVHf/GHUQUVi1c/Jdi6rQe+DUPTYSnebAoFoLWAyQyM?=
 =?us-ascii?Q?OCGMO+UhDknRaTOUIofnIsctlQxTKPxUkG6sCKbCElB3f2KivS++YAYKIA4y?=
 =?us-ascii?Q?hnKqyOkkIR3MMRiqn3dnb2AcV6cN/Jn2q8y6Bhkb5NScAGyEhp1bjc23zXV5?=
 =?us-ascii?Q?/gusOdeZZz2F9Rijcl7EZn7shrmOdhJWFSzmzuS/QjXZ8wgC6L1ffhL5fe5j?=
 =?us-ascii?Q?PyoFswvcdFsPdhvId8u2ZdX3HcSJ+T4t6Wq2IJ7eB9gRoMHrEu4OszhQs4sk?=
 =?us-ascii?Q?S+r/fAfQsxTd3ARWGWp8qUVszqbqTMoGwy73duCRlC4tWGbHbXobPihuVOIX?=
 =?us-ascii?Q?2LjPlnG5mLcu1e5iSfCEyFoyVhXf8xUq1C6wOLALC0A6OQ/aNSh9EP4YBGrj?=
 =?us-ascii?Q?jo9B45f49Gyj4uFMc9fnn0QBpf5TpPnd7F8WToWoiNqDAa2vnKWXVwqMD2kv?=
 =?us-ascii?Q?YySyo/wwJ/iGahKqE25gJTkmhbLlXUzcKzFvwHfam7JP/QCanpkRGEWYWtm0?=
 =?us-ascii?Q?J6L3ZP44t8W3aLNXWunFmU8dFmm5HKFVqv/1/MoI9Ty4WjRnow8Qzv8/6JSf?=
 =?us-ascii?Q?uq0JwKzxAEdlFyJMMkVVg5eZfoN9K9zj6yhla1J0/Q8u2PTCqU3pFLzkrRZ4?=
 =?us-ascii?Q?SzlPbLO6K2yGdbx/fbOvAHey1mvp11KZpij/htScbTrRsemZ3zXEbja1kJFb?=
 =?us-ascii?Q?1kVXEkvXS0oE1Jn7e2wDex/tCvU86IOJ+B4EkbJVnsY5f3i0na4+eQLleRu5?=
 =?us-ascii?Q?nEvUlARsvvNIkANyXd/wB32HQuhqoxsgplmfW6gIiQHFpIMy22tftdhT38v9?=
 =?us-ascii?Q?qFI9rSFkhj1Ar3SlP2xWyq0mS+HcIiuVgiYmqMfT9dLk3N5/JEwI/Mlayjnj?=
 =?us-ascii?Q?yBdHhL/AOgpMxq6Ci1aGiJdyCnS+LYrDksXH2GQi50naGKvGXqSvBwijfRIf?=
 =?us-ascii?Q?bwvY/yP73Df/sQ87Dt5D3O7Iv1srZcFQs0sYwOpsWUJHMjPCLS3jujHtBRjj?=
 =?us-ascii?Q?uNCY/y7PWDkp7R2JnLdYhQFPuEnM9GPeU+3WWPltG9ujByzeEuF69lmU/qZC?=
 =?us-ascii?Q?nhEmxCPyeKB52ML5NP+Oqhi14F/VNBK+lNfIqZHZCrgcALRwmqi0CmIIAb+y?=
 =?us-ascii?Q?nh295CWPcdBjjo7fPsUACU2uqWtdDl71dPPtJMr+yANm1qdDC7xGc8/z4Ftv?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TXhCBhqRrFIvaIKZBV8hptvi2TSst5kqnoZaBavkTsSeU9PmrRZueFrD69Q/JWpVDJWqYb4EVk3TmJEY1s8/wP+2/oS3a4NBboymaPaPHi52s5J/ceJZZe2o6t4dhYUJxu0xGKGhqfHIbEriGIYygRJPK6WdXGE+tHDYGlOQr6tHR8QvgdK8eyEvruxxRC8VoMp0Anl2jrMQDWjApFzunZ8HfXXeBHHZR8Yf4oIpwP2eN3XMVbEdv2nK5I6pES/3il5T+gxKgBRs4pyXFDMER3IMIFSVyRf4ZFaM2c2oOOrQRRcmEkMsSk8uC2wAWj34unAvVxJDKCJqqrYxm18a9XP+qqDjK9MvKyDLVinJRqK1PxfG6MvtYnAk1vVWnSsu00y+3lB5f2A4z9MA9CGnlPfm9kIOBo0sv8BLM0zu3n3jBalyKrGUeXmRLnFlKLQJyVTwTJUuW9IGodMtE/bRf1S98GqO8KoVAjxQaaPbgNy2LxmWCal5YyWShfPWsq2ehJWyisT35vyM1hxeYpCaTrOvhey2CRlYig5R8hagQV5QmHOq5nR43nYLTZ6bdFHat/xVgo1yi1HEDNnZIsSrzfZo1/o2OKi7rgXeO8gT0Uw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b84c7-4d43-4e19-5567-08dcf75aba37
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:13:42.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWVeaT8jYTaCZrStXvasEydF852pbFF7Njrd/ZQp7JABjFsKW7Kl6vFHNooT4/x741sqWaRuq8XnQgtohhRcXhEGBHt0VFFMZht9z89u6dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280114
X-Proofpoint-GUID: anEky7ilylRdCvo4SPsMd6iJo0bzrgj3
X-Proofpoint-ORIG-GUID: anEky7ilylRdCvo4SPsMd6iJo0bzrgj3

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
MADV_DONTNEED or MADV_FREE.

We additionally add a WARN_ON_ONCE() in hugetlb logic should a guard marker
be encountered there, as we explicitly do not support this operation and
this should not occur.

Acked-by: Vlastimil Babka <vbabkba@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_inline.h |  2 +-
 include/linux/swapops.h   | 24 +++++++++++++++++++++++-
 mm/hugetlb.c              |  4 ++++
 mm/memory.c               | 18 +++++++++++++++---
 mm/mprotect.c             |  6 ++++--
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355cf46a01a6..1b6a917fffa4 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -544,7 +544,7 @@ static inline pte_marker copy_pte_marker(
 {
 	pte_marker srcm = pte_marker_get(entry);
 	/* Always copy error entries. */
-	pte_marker dstm = srcm & PTE_MARKER_POISONED;
+	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
 	/* Only copy PTE markers if UFFD register matches. */
 	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea1..96f26e29fefe 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,9 +426,19 @@ typedef unsigned long pte_marker;
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
+/*
+ * Indicates that, on fault, this PTE will case a SIGSEGV signal to be
+ * sent. This means guard markers behave in effect as if the region were mapped
+ * PROT_NONE, rather than if they were a memory hole or equivalent.
+ */
+#define  PTE_MARKER_GUARD			BIT(2)
+#define  PTE_MARKER_MASK			(BIT(3) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
@@ -464,6 +474,18 @@ static inline int is_poisoned_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
 	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
+
+}
+
+static inline swp_entry_t make_guard_swp_entry(void)
+{
+	return make_pte_marker_entry(PTE_MARKER_GUARD);
+}
+
+static inline int is_guard_swp_entry(swp_entry_t entry)
+{
+	return is_pte_marker_entry(entry) &&
+		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 906294ac85dc..2c8c5da0f5d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6353,6 +6353,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				ret = VM_FAULT_HWPOISON_LARGE |
 				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
+			} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
+				/* This isn't supported in hugetlb. */
+				ret = VM_FAULT_SIGSEGV;
+				goto out_mutex;
 			}
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index 2d32023d4eb8..75c2dfd04f72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
 	return !folio_test_anon(folio);
 }
 
-static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
+static inline bool zap_drop_markers(struct zap_details *details)
 {
 	if (!details)
 		return false;
@@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	if (vma_is_anonymous(vma))
 		return;
 
-	if (zap_drop_file_uffd_wp(details))
+	if (zap_drop_markers(details))
 		return;
 
 	for (;;) {
@@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
@@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_POISONED)
 		return VM_FAULT_HWPOISON;
 
+	/* Hitting a guard page is always a fatal condition. */
+	if (marker & PTE_MARKER_GUARD)
+		return VM_FAULT_SIGSEGV;
+
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f450af3252e..516b1d847e2c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,9 +236,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
-				 * because any access should sigbus anyway.
+				 * because any access should sigbus/sigsegv
+				 * anyway.
 				 */
-				if (is_poisoned_swp_entry(entry))
+				if (is_poisoned_swp_entry(entry) ||
+				    is_guard_swp_entry(entry))
 					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
-- 
2.47.0


