Return-Path: <linux-arch+bounces-13108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BFB20169
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F18C161E3E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C852DA755;
	Mon, 11 Aug 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bTaLh1OR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u8IoJhC8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199562D5C9F;
	Mon, 11 Aug 2025 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899849; cv=fail; b=Cd9aSRzwaimUu5vW7p16khNGPowMyZqTcSf4yNhXSmlhQl2AqjsQ/nRrNRpGb1af3BQ6LX7ca0+1gjR3ksLPzHkvXogr1C27Yg7QZ0tRfRxk2EREKjuckGp4YKNcvylvf60LmZSlURaYNgOtO87v9zzlMHJHh6ull+T2Tt5Jr8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899849; c=relaxed/simple;
	bh=tCkrqCEwgn6Xdc04tLjy7HxGfk9Al9zn8EuhYdA0ahY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KOj+O8XZOQOkGBzhX0YKZIFnmSChBpp7913uDxYaDOiP3oz5wa4c/ChT5OB78vy/IzfMAqKrS2Un6siB/hI8pGfHy86yMwPOXmH6reXIt2N+wZkCyTFN/AhIMunVAyGIMRtgJEnayFm79GEvU7/m3d7p9yXnhWH4QYeh0EIFQqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bTaLh1OR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u8IoJhC8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uCa1023566;
	Mon, 11 Aug 2025 08:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KmeeMkVYjnLUoqB/Dx
	9D+VBmx1hqkgW4Emv8azJtTHo=; b=bTaLh1ORkOIwwu1pyhdmMd302EegLjNCLJ
	VX0N/k4aRv6KOa7d/uxeF55ykiOFh5ipQbM05uHyylaNAFXu1g6YwOR6fTBh2Qz1
	ZJpnJc+Zw4j1Zd8XQiO+uxewNXWj/1PC5H6OhPxdjXzUvWPfga2Eag8OF2OxCaYr
	4eTSHT+8tLOtSCgoEyPeExl15T1Wp7ZF4mhSZVBbC0op/i+cyBcEcwNFf3RcqlIV
	IGIjaUiQy0lRjioLgrnqQUHQR1ITVr1w01dirVGKgVnEY2xqqFGOkQEjh/ECqMMG
	7/EHRylEk64ACU5/SuwviCKwF2Z7bVHjPeZ208mfbdeu0kz7j6Ig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwswfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 08:10:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B6jH9W038545;
	Mon, 11 Aug 2025 08:10:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvseuxex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 08:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq/2xsCFcBpaLlzZzY+eE99/16GKZamC7Z6glQVy3K/XhdZT7hBt29HXiKAhq6nMdq7G8O0UVfg3HPfSuq40v1QZvsVQc1jiaDH7J+ANp5YRDbhJ0IZ7b2cd5bC7POLGFg8bQGWNu5LTaYKDpPHpHlFsJgM16Lfmk30/zHxQYBF3Xdoer5+ASomEKLnWpQAYiyTjVdsQKQKPJM4bjZTDnQ4NHpiqRaHFddL3mdaXHreUL0zslARijS5YY0hZsWvwviqOU9sXa8BjO/D5jgIYpesoGBCDECZhwPtuhYPcF1QAlEk6V7zAofImB4u/mWTIQi3vSzX4iBidfmRkMyoh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmeeMkVYjnLUoqB/Dx9D+VBmx1hqkgW4Emv8azJtTHo=;
 b=VlJkRzPf+2TJeh7tFnFGmCkbZQXLsZR3K5VlPPoyZfEqhyJ9REdXQTdaBO1mLp7ZvQ+7jAVbRxK6DxhHVGlbOZCTCsJqkdjq1XprtpsEkCeL+ZpWzW3RPcEKLolmYAh3KtABe7Nkt/YyAJ2Ufd9kx0YHpaGjXtkpve5ngL4OJNRTrEzNtuwC9GTT39ysNEx59uBGUusoKC6PX1hpC0WqNtaOhzztE5/tLPDY3BhmGg99P7OvzOE0S5kpB/mQrheyOg9M6lBcKw5qveNpHMz0Jiqz6LbKydmAa2CB9fG8LI4uJ6ejyLaqHwZV5XLQ5fY1+4fhm4zmbX3gCi+eRt9HBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmeeMkVYjnLUoqB/Dx9D+VBmx1hqkgW4Emv8azJtTHo=;
 b=u8IoJhC8pAh0uaosuy+2NQbOuOF8Zd89Dh+c+14RZVN3nq0Ti88vlBw920Hs+sQDoguXoLFpIVg7ZgnbBjMjTq+BebEhAcBSULSEYPbWAsSNaDn1Vrkeobrqg2uxcXC+/yVdwYyduwdZfMVpPuZfMdws3qR9Ofz5xbVi/Rh1Zzs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 08:09:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:09:59 +0000
Date: Mon, 11 Aug 2025 17:09:46 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kiryl Shutsemau <kas@kernel.org>
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
        John Hubbard <jhubbard@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 0/3] mm, x86: fix crash due to missing
 page table sync and make it harder to miss
Message-ID: <aJmlShR2uCkJbKeX@hyeyoo>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <qsprh2qiisldfsielpx6inuiw3rrh5owr3urin7maxvwtlhipz@zbioc6hgqe3r>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qsprh2qiisldfsielpx6inuiw3rrh5owr3urin7maxvwtlhipz@zbioc6hgqe3r>
X-ClientProxiedBy: SE2P216CA0083.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::16) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: bcaa4f16-1ccb-46b4-b04e-08ddd8ae76a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5b2pFQR2puHBomkTrtwN6Qf4Q51R3GJjIBb3oHIeBrPfT37bngrE0e/PQVQe?=
 =?us-ascii?Q?+AQzrH14FkU1Q8txZEc/7fR04Xp2lHAL37QniycOe1gnm59UNT+BFztw085/?=
 =?us-ascii?Q?1gLWuSj168MPAm025+oFfFiuVqi7bBbk9OMiIhu0m4/6wjL/wKxBmsPWAfpw?=
 =?us-ascii?Q?a9Emt3Y0jpTKiJO0LbuJl/Te0y3qvCk4HZ8FyF2pTTWCMW8eEUqJWU9K4xRB?=
 =?us-ascii?Q?5Dm8P/Kc28zHo4nuuvAdi2rJJzxO28sSpEipR0rZ3ffhwmK2nqNlXoYco6Az?=
 =?us-ascii?Q?RWoFCIIjyqp05F+ia4zu6T7sQDqu52Rqbolni1RzgClFw38wSJl2EyJ+GZsY?=
 =?us-ascii?Q?tbjMhPGsahMC/tBx7ydTQTqTeJSEr6AbxpXyDLFGMcWGJCXUWChJe7Fjf9pB?=
 =?us-ascii?Q?YbLfUOQgQmyHs4veys3HT7P/Bqsnuyo5uqPP037eCDyrutTknB6/Ti7qHBZY?=
 =?us-ascii?Q?bpD5bYaalPDAPzEZgKQt/RjjX2UM90if1TGlHrAhpfbtoc04oKZPBrNK5ttb?=
 =?us-ascii?Q?VznXbDF2yzBy2ejBbWdP+BG/n2oJu3yVer0/aqxg9stVb00ePLjrAyN0E3dg?=
 =?us-ascii?Q?OSYx5RbYiCjyOOfiDBs65jPyBgrKxAzyFMaBQHMjv0Bx9lunOmAQ7pKAR2NV?=
 =?us-ascii?Q?yaO3gzxWSiRt5D7mjlbc0GTUtJJiQL8ovXps3cbo6oBhz14sBQzmwvEiOp6j?=
 =?us-ascii?Q?wLtgH5ODudaiU33DTiDjr050HQ8sD7kLB3UQoo+2ZkdaGRjHNfLaD2NvtQaj?=
 =?us-ascii?Q?8UXCA8OVN6j3Mkbed7psVrZEBZ+FJCiLwsKRoftJgD3e8115Pg6zWkGOoRcT?=
 =?us-ascii?Q?TXh+aEbsP0XmrqqXmdmg5CEDInWJeYx7tFiEZSur0SOrzjYCHQV6uSuxUIn9?=
 =?us-ascii?Q?Wbu8mej5m0VIEhM6WGI2HtfDXOFAPTFFAsS/Ab/VP2KLa+HiJxD6OhF/Juws?=
 =?us-ascii?Q?729pMMILU0iRmbQCK6fj6OvzHcgilc+0/4lfW3WWJDb3lO3vxy5tcFUNLxy6?=
 =?us-ascii?Q?DIC03eQ9/rroP0k8rGUutiAYnUdFMoXQ9f5syrFKVR1BOaG/3p4ePka0LVqJ?=
 =?us-ascii?Q?B9dLc6m8/LJxavrif8rpbL+Z1vLg2Gz4yQqA8qVDmLY9A4vgV0iMDDt96Erw?=
 =?us-ascii?Q?VGpljQ2S2SvUVf/P6q3Me5jAjCQWOS9HOD32ewvHRlb+hUpfiQNo3L43okyO?=
 =?us-ascii?Q?Wn4b0l8xQz+9Lbg2BwqgnBTbT3Iv8UNqZb1WF6VS1P6Y51iQocx7hheQIs7z?=
 =?us-ascii?Q?/oZF+IR6gqJG3MncubyNBYZ0wMOGCPstWmWx6osDLBDSVcXtvTNdGsyvmw4z?=
 =?us-ascii?Q?c7cdU7dTydEpc9lJ/CBsX/NWPNfaHkl7YIEghz/QOlKf+iiZNND+FQDoI4TZ?=
 =?us-ascii?Q?2uE5gX3f+r78N+TH8Q/g0TYchzEANSp3BpaLb7u1jAXvEVGR9RaQfW+owMYs?=
 =?us-ascii?Q?jCZHLFSh7Lo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlSQjxLtaFEu2+fIM72nJW7FCL+f41IhymM6RcA6zcj2YS2DgDEDJo5/SSsQ?=
 =?us-ascii?Q?1qhp9r43xa/gBvJtfQQp6pNkbA/VQpUQ/z0Wvim3lzIBEn7gQEhLW7Pl5Nae?=
 =?us-ascii?Q?t8ERe63yVUnUGOqOYA+EX2lyy7Kek4Bezd2nNwfg3SIY8r5/Jrr7wqsLWjyG?=
 =?us-ascii?Q?fx7yceo/SANGyyscn13ej9yt40kAH+VIHe3/WMhNJzkZX5Q574tpRCKFM7SY?=
 =?us-ascii?Q?vGDtOl/yce7lksnNcYZxPPylQw7seMh1zNVtgVSDmwqXj/6ixLkTkR5rSHPd?=
 =?us-ascii?Q?8a7bqA4HvvZyy7B6t6z2frNR5BEvWbiGgj3CcUZlbEb3r0qv2vMyZnIkXuYq?=
 =?us-ascii?Q?rso229PZsVyaQt1jrpS5UQyzJa/15So1ockl6mmm+dKAe6CZh86NpWthyzDa?=
 =?us-ascii?Q?ZnLmFAQmHF8hgp16SCJ9aES+gSPRyIpwm8+2CDcQCNBhVZdjqZzcV/OLcZs/?=
 =?us-ascii?Q?SIgOjYDt/CVoazHLioTIqrhO86M74FuKbXPTHcICtiyZ7AaqMkksWZW5em9F?=
 =?us-ascii?Q?nZPbvzOSeMU+3M21GAdncXZ5NCS4N4eb7dZtDAmITaAGGAWlL4WPd1qbm/nG?=
 =?us-ascii?Q?2itElfhqtOBHXuxoUi3mQhCZh1M7BgfyBVMtCUTUbKCrtuDF1s1CBDEbBfV2?=
 =?us-ascii?Q?xJ41u7w0JxjL4w6ZDPiLwdhN9T99wNKdR+OA+ud+dJCKCXQzQ0jUWETW6kQG?=
 =?us-ascii?Q?5XuNfyC3sJHKIcKbOp+DL5mC1m+06DBNwvVWGb7yK3mNAxIdp8/RSbk6SUBw?=
 =?us-ascii?Q?Qg7tzR/TpyzZa2qrW3t94RTTuLRskcD6qW6sgebf4UaczvjTVkccmxJdA4yi?=
 =?us-ascii?Q?r/QwqI8osVF0f1aseHeymvDWSZ+cseZdwMVs8dtKTZSDejtsKAbcRk9s39hP?=
 =?us-ascii?Q?TE9h7ecOh8dCoEVTnmVpsO91y8ZxbQVvhQIWduO06ZO7Ex3sDXKiqtGpEfRM?=
 =?us-ascii?Q?mkTHng4yudJe3iOzVrOMcnYGliL+t/QShpI4YRLug++JZbzWsf6fqwS9ApoN?=
 =?us-ascii?Q?S1NS06cHMx5PmS4rMgpgs6uEO9QQVFB5xacs19FqlcKY6ZahvY740RBVAddN?=
 =?us-ascii?Q?J4vuouhDWADrfoNFvbjqAC27yYx/wq7OZYHRPz4ooQRUYfw6dG36I1bsQ5o7?=
 =?us-ascii?Q?OTBrMpypw3Bb6iypgSce/rnCXFq8jmFBF/IjoOvP+izbX4X71dgnAF3ki51k?=
 =?us-ascii?Q?gWIEVBQYKxiaHEDJZgCrzoM0rFDoQ6CPEBCtld8Keo/RDJzSei9SleybDLbh?=
 =?us-ascii?Q?1PdbrTnh+fO9AqwVXqm6g4sTnEvMgwvqGCCg0qkY7GplIjdQcEvAUtrm4bY3?=
 =?us-ascii?Q?tAmgsU61U94RWEfKmkN82NZvFhf8wCo/1Npi0iJYdFdbbMr6OMAd4uKKHFyJ?=
 =?us-ascii?Q?H3c72w1broz0W1MgtPLouZ1SIVdKi9iyXOVFUP/ecIJ0TNwPicIKvCFF4vwS?=
 =?us-ascii?Q?51T7AbkeUiGtw05JlL8DCq9HdvhhT5MdtfrRx2JnqTtlvzaa87M2ot8VJROD?=
 =?us-ascii?Q?IYt4DR2O/yDRu2JjIA3qauFMgOuwUW3WSui4uoftKau+waySgJiRrWTgwo6b?=
 =?us-ascii?Q?HSwWLo5yDVQKn6DXERveXUz9YfOMOjJ7FKNAiuEG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RB7iwxP6cyFyjLbHQRuBRU5UdU1qd/zO6qWblF2H5clnJ4EtsHav98aCWXhYWERaZk7fXK9A+1A3yS7DetPfgwYspcCNJ/F3gBUMrcBywkVdOGRyy6kK3I4YTarNsNf8hxtwPJm+EaoKnB7gvLPVdEL9Q9fGlDIDzzVS4A4t0Sy3eFaobHGzotR9jp+cZaXrNIX7THfgfgJZbsmKl+ampxpsIihHhs0uZl+jMfX9DJfewSbgsBAlDEjjN7hbor61HhrDlCTfEfmdZxFh5QcWA4EUW/CMiZNSETpkFm24ii5+mKwxYiOW+ZVxh4n43+o/cIdK+AJsG3Mfq8JoJoe549PO7TJTCU/kYMm9MrMBRev6E13z2q0Dk6nDdce8jwtp8kNuKJK8dN4ne6x/h88KtreVe/64d2czp4QFiK7QY7uKpkEDCU43Ond/AxEGCY0ZBKe/Uo1p3+MrewTm0gN3LPur9F/D8vl1DgoakYgX02Iah5UzU0tCBZSVYFog3GwWKYixuuUcQHkmmYftrGvpV5SxVaqBRBwOn+Rqx6gZz2oFrxm2AbwzWa1DXG/vippHHboD5l3TbhleVFJyg5YlURDKM+l7xqD2iZwki2GAjcI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaa4f16-1ccb-46b4-b04e-08ddd8ae76a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:09:59.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXUA9A0hse5Czf9lrXurYJx0ojVdh+sziCZxps2mwqFjuaPQ3lpmhwKkohXKHF/pgtNdcjwVNxAZCHnTx6b8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110054
X-Proofpoint-GUID: 8ja6RCgjbBdt33fSwFznXJRxQwD5iP1h
X-Proofpoint-ORIG-GUID: 8ja6RCgjbBdt33fSwFznXJRxQwD5iP1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA1MyBTYWx0ZWRfX0eSvJ/5wj+wc
 pNui7MWWbFzUJnDBHvIoV69Mq0nFuk5p+h8vGzLa4nvo/2Ib0Ve0SiAklEYyJ8gFDJmU8arOKPV
 RTMJYs3kBlUI4BJkFmb/TwujAfzaQAfQkI4j/Aq+MIH0Cmwfiaqxi11Vpm/utsvZuIKbblVlDLT
 uSXEt1K/71e0T+jFUpTo/jaPSXocjcjQisHLV/7zqZJ4uOwaycI7m/UEjp9C8WqvHN6RnYaEI5y
 bGXfDZu/8OlygOpZDz3ByvBI9WMM/2wrn+AHVC024YEgTetNI/2Qf/b6SSYpw8VPe+IPzRHyuwr
 BqWljudsAO1M4cit8HdzORMmLyF3kV4ByVH6xQ36fTH7Amy9Dea2SJAHWOnJYn/YiwRUklAMbBK
 Hvut/bhpwSujJ27WnzXPLW/R1aYeq1ZIMYp109sdFop7PdArjV132zuyS19LqT3B3rQy8Ev/
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=6899a55c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Ut5Sv_cQT0ioXsQQ:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=hIT1g5Ffb6u-i6meOioA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070

On Mon, Aug 11, 2025 at 07:46:13AM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 11, 2025 at 02:34:17PM +0900, Harry Yoo wrote:
> > # The solution: Make page table sync more code robust and harder to miss
> > 
> > To address this, Dave Hansen suggested [3] [4] introducing
> > {pgd,p4d}_populate_kernel() for updating kernel portion
> > of the page tables and allow each architecture to explicitly perform
> > synchronization when installing top-level entries. With this approach,
> > we no longer need to worry about missing the sync step, reducing the risk
> > of future regressions.
> 
> Looks sane:
> 
> Acked-by: Kiryl Shutsemau <kas@kernel.org>

Thanks a lot, Kiryl!

> > The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
> > PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
> > vmalloc and ioremap to synchronize page tables.
> > 
> > pgd_populate_kernel() looks like this:
> > static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
> >                                        p4d_t *p4d)
> > {
> >         pgd_populate(&init_mm, pgd, p4d);
> >         if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
> >                 arch_sync_kernel_mappings(addr, addr);
> > }
> > 
> > It is worth noting that vmalloc() and apply_to_range() carefully
> > synchronizes page tables by calling p*d_alloc_track() and
> > arch_sync_kernel_mappings(), and thus they are not affected by
> > this patch series.

> Well, except ARCH_PAGE_TABLE_SYNC_MASK is not defined on x86-64 until
> now. So I think it is affected.

Oh, you are right. Although they don't use p*d_populate_kernel() API,
changing ARCH_PAGE_TABLE_SYNC_MASK affects their behavior.

PGD entries for vmalloc are always pre-populated so it shouldn't be
affected much. But apply_to_page_range() is. Though I'm not aware of
any bugs from it spanning multiple PGD ranges and missing page table sync.

By the way, I think it may be better in the future to unify them
under the same logic for synchronizing kernel mappings.
With this series, there are two ways:
  1. p*d_populate_kernel()
  2. p*d_alloc_track() + arch_sync_kernel_mappings.

-- 
Cheers,
Harry / Hyeonggon

> -- 
> Kiryl Shutsemau / Kirill A. Shutemov


