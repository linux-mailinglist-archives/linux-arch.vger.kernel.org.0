Return-Path: <linux-arch+bounces-8359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856FA9A6E7A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5CCB2233F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178451C3F38;
	Mon, 21 Oct 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RI1ZyC84";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bWwOUI/N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3A1C3F3E;
	Mon, 21 Oct 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525367; cv=fail; b=QpodvitLhMfLMfusCUSjJ0bA4eMhlwDoSp9Ud0F1NLMaGUybkiwpNnQmZrDwbxNdLeuYr2tNOpzTzoKn4/KdkZEZSZ93m4ssxn9XVI4UqBEjq1/Q6R0srHaTLBguJog8uSKmmmYY+PgL89icY+lmHZT7mEA4N9+DqE/3d0H0J8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525367; c=relaxed/simple;
	bh=PNqmyJEoN4+W5U9jT6XJEmGHv7964JkwTreinJ0/wKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y+N4/u1ncT0zchIBEE1UeK/O8SL7Ozvc8cUqx10+m/sLomKtbTUtVG/K4lhSwPek1HXzBYLn5szavWL40QpbjpQUY+zREGJM+W5kVZBv77/KrBUbQuIE8fyiNOXmVDyWJqGhK6izf6NOhkaRXYn/dgrCWrTtHVuEEQeYlNWo1L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RI1ZyC84; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bWwOUI/N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEtjLb005605;
	Mon, 21 Oct 2024 15:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0nTKdhBUlc3fDClRol
	dSu9t1YJbh2gmYTzIZfCZXTMM=; b=RI1ZyC84sw4cDv8RUwfwZ/Ic/a5hs8Ypoz
	5uLYd8uFQPtAm41it4Uk/wxZiC2tfb9OJx6H5lUCQ4YbDB58WqRS5bI2pLK1XHds
	ml5nIcqoWhLyoSxCGbmVCaca4zAdGsgDLO7nCHp5Tp1jknfhVxy1XQbBDAabl/b7
	+i/fV1wPerGdFWuDm0h2KCU3iUTwJCLVW+Rpz94n2LFq/dcrjQymc6Vaa0XUwU7+
	OuIS0sdljNQZs3dTzWXvzPWwws3aiQZfAUseasXZjTlsPgPsPFRfZpYDAgoLnu3q
	nHxUfjXgUMksqu4fDj2rcbwYQGG5DIdGlA17cQhW4uwtZz7+0vOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ebds9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:41:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFEjs5023530;
	Mon, 21 Oct 2024 15:41:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8eubfyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:41:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=af/6N4CUIoLWhH3NxsgIQgecApiCtRnT8wpH7el5DvlVpyZ1Nu6awPtpWY4W2R//hZ7AVuydsFWz3KvzX85ltr22dQFdDYj3V27brb1o3PE7MgJv96Slo0XefB9p1JXqra/ZRXHAX9ZpvwelgCnQEa7RoehSD/+OmAgC3J7S94SM2+w9R+mB6UJygI5WGq9T0NWwi4Udr+GvpO8uNx5rvWWuhzmSnWqQpq1OkKCJ+XpNpbBLD15lVvzugLYVx8z6a1P9nLyqlxAW+BuQnMvwaMN6EtHFzOF15FhYI2N9sFArqm1m1/2IPIg0QhhY5A7RpFoGQb6X0yZ75PIUV11N8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nTKdhBUlc3fDClRoldSu9t1YJbh2gmYTzIZfCZXTMM=;
 b=IrgsZyCCc9bkievSBn5J8jjs19XfzuRhviwPEVWgbtcjwW2kKwTpBVkBklWSUE05f///qEm5sSba6rZpzN4Qe3BnklZHX4FNg100zugaYTZdhqkc8sSkHDNJ2w8mJxd3aD0gCoL4yJ4sPv/xhsUe6yb05wzTmg2faVfyeItBubrtcvgTFr6hkJEwDRsOU8siCkhRQE9aYZGPHr9lVv+R0X0YitGNhQyAsCJDl1VvB+qrrlNUrzl6mkIdWgWAHHPLT0pBloEpkTN5O6CDpqCTUOcWfB4YxGahcODxDeACjlK7m1Xdl5tsyuw9ExEMjPkt/BslsWDfiNO0CZq9JP+4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nTKdhBUlc3fDClRoldSu9t1YJbh2gmYTzIZfCZXTMM=;
 b=bWwOUI/NEWBOm/XhopAo4ycDpOFayYfeV694YCCcm5ad8o5oT9GEqySwuFWIZGI5NMdc3WQBDVWBTTl4AUsJ4Wo90UPr7HpPBC6KNvxDJK5Mo51rplELH4ts/9BH1IlYxC5lxS3gnmaZw4I0XtaK3VVV6JZvjL6CsSWVDoBXpyQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB7754.namprd10.prod.outlook.com (2603:10b6:806:3a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Mon, 21 Oct
 2024 15:41:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 15:41:47 +0000
Date: Mon, 21 Oct 2024 16:41:44 +0100
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
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <f2c5ae69-3547-4118-ad30-9e398b2513b1@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
X-ClientProxiedBy: LO4P123CA0146.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 316d02d3-ecdb-4070-858e-08dcf1e6df2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y05rHg0cnOyZRsS15Y6cClR4/22bppTvbvjW14OXhiwLj+Ho/A+lTBWXQDSR?=
 =?us-ascii?Q?o1zQeAzUkvMHExLp7xjOywE/Mji7a9MyMBhGFIjBsiEYdeEsaw2zsuQIxW8A?=
 =?us-ascii?Q?sgC9JzlMHwEQgbVO12oyoce1EtKrusmV3cEjvfQ75QdPHkuXCTNHMNsZ3zGP?=
 =?us-ascii?Q?UHC0rcmzykVIZZLrdcCh2wll/efWi4zx60orie4enj00ht9qFaayj1WU1noL?=
 =?us-ascii?Q?qBNIfC4W3Wji/x//eMFxJQYWQRwRiVmy0xhP8gHykvFiFTGoB7A/ulYvpG4Z?=
 =?us-ascii?Q?JWDE0b8PDsn+iVvVg/cEIbQbQful7n6CgLEIXYUUF76Y6zypRgT7QHmWscgj?=
 =?us-ascii?Q?dPKWEBFjMzLaCr2i8WyUWfkRmWdD6Z2zEq5xZuMY1ma1nNeUuV5PBT5aQaWU?=
 =?us-ascii?Q?t1CQqEPCwww76CIU+zcrqFn5W8guSADTsSXcljxDDDRjlF5wz71UVaJBH3fx?=
 =?us-ascii?Q?+4Kx5YpypNbfVQDYrjGggB2/IcEFeuPyztJISacnL006U6qordCMQLcCtui+?=
 =?us-ascii?Q?rpN2SrVrVn+UT/EDbxy4oHHUURkqk6Xj/lTtI+ciTWQNactPDIxkIX9WMsnf?=
 =?us-ascii?Q?oBd7l40X7fDL1XxJlzQnn8J9tjvaj4kON3hmdrQ16ElDIo/H0eAVsEHDiuqS?=
 =?us-ascii?Q?lcuXDZxhxxoj/XW4LI8oQ4qiX3lBe76DX77JzqkUaJNX1NQMw3AjwRCO6z3r?=
 =?us-ascii?Q?/rSkhC+xKXKSQ+sd4EruPXqNKvKXfalTmyu6Px/LkrZwrbZum2hEk8xLTmZ1?=
 =?us-ascii?Q?OZOY2lQchoJFx8Y0RtBLin3TO4QqCLjldCWuumsUuWNpmrPOPJGwPGE4edLF?=
 =?us-ascii?Q?8Gwst08BmBoMJDmvkCF/ofkmQ4dZnzpdjZJNdVCgKJa1BsboIEl6k35tKBGx?=
 =?us-ascii?Q?pLwG7d553a8cS/4R2ZuuUER9zXhULjUJTuwCSHc808zyTHIBhw6TawKcgD+0?=
 =?us-ascii?Q?1OZ4bdUqSFcFpxjbh5nahMlFdMohEnhXnrJCVC6KyXsT8Yw14DRXLrCkO/jI?=
 =?us-ascii?Q?7oiLZBOm7RnS48ckeWiOswEVamJ/6fL8bEx3KvafHUSONXfY/SqKfLlrNtM/?=
 =?us-ascii?Q?NwOn/4gh12Tgbrg4a+Rf13V1zNsfVpsyZDqR/1ZPeWV4xX19XgRWTI2YG0Vd?=
 =?us-ascii?Q?9m9j8mUpKRFmbERpIZO9Wky85ToRn9b7bddJYGvLgRLvZR50qcx7rICYI8Hs?=
 =?us-ascii?Q?npKN4IUi4NP272FPOOseVOj4qNxSVtWQ4j726Eh2uUP9mffx120Z8eL612sb?=
 =?us-ascii?Q?o3E+pGBS2fNtk87bXO7pWThoanWqc7M4mY39kOgolImWQ2RSebytOMvgYFnw?=
 =?us-ascii?Q?eYsJifl0pxfgSvlX2dss8oe6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFly0YnkH9ia+4hUzO7Sg10x6ktKqpOzWD/W9LSep5bfKqW9NOieCqJylFZ1?=
 =?us-ascii?Q?eyaF9qrPTYQIrt3sFdfJudGBX4tmOfJ73WlQJoUX7Y/KldrdLzVTn1AKpj5F?=
 =?us-ascii?Q?B9UIQnfYqW8tgxVAvgspd5CU9lXhETIzTBFRIQUgp3SKsjo7kvCHG6tgwYPG?=
 =?us-ascii?Q?x8jCBOzMQMLsHhbrRmvzjrSjRB1FAqd5ZMuGgC/b4uqvNBFsMx8qyeek14wL?=
 =?us-ascii?Q?LuXkIpHiTDa7Fc/bffmiY/L0oaCyOtVDof12LysA2sLqfNI3Qc5EgGQDE17D?=
 =?us-ascii?Q?hpZHbuR8Sxq4f7ENnkfAhuMUUDlXR0iozenRUuw3SJE7LVA234pa/CCq1cnh?=
 =?us-ascii?Q?bsNBIDhEzTuRnDqc21YvAtYL3OxUgKNhoYqmQRYTnKwshe5sgz3dZDrvAasH?=
 =?us-ascii?Q?uhyI1blGFc7kA9rn67j0TVTpVBd0rHwH12ZREwio0LwVy57p4rLvtJ8TgGGS?=
 =?us-ascii?Q?jJtK5sOOucH2IH64Ik/fCnNba8BrEZ0YE9ttZzsSpTRg/DnCzp8k+4WXOFBt?=
 =?us-ascii?Q?A8BpTvO4RvbqjPKubHxtdvFgTp9vrMGt98DpoFfhE09q0p+oefxH1knXbc0U?=
 =?us-ascii?Q?+M+oG1ftJxlx4MRm7j1+uMmTy134gNvW06t00QA8O7f6eWqZ8mn1AbbJehDk?=
 =?us-ascii?Q?KYkeDoNnfGYkauAX7XbHBiU+h5uiv6sH4oXfwje+3r7InhKuR76Ol4yHHW3p?=
 =?us-ascii?Q?uQMcXLzlP5iYz1uE7rf4mcgvGYmK6GOaMCHGovk5eQ047kBlx7DhVHUnW5fb?=
 =?us-ascii?Q?6ElnLJU35LGE3UPsUjSPz2SbK7WOYvLPtloTrcWcpNIvzaH1ngB65zmYGi9N?=
 =?us-ascii?Q?RphZ2YiqsUZJWlvGX1tuUynP+mCxkEWL9g7i8geXGQ+AmvC4YaIE4j23PxzQ?=
 =?us-ascii?Q?h/YkU3icfwrRRreww84jkMY5I7eoPthn0c3o8D4OnW0lBc9VBt7cqtSiMaf+?=
 =?us-ascii?Q?giry7bq+ZosAqRf+gqmTjiuvcp47TbOsPU07q6S0XZQ9679qdv7XhVx9Q4Zt?=
 =?us-ascii?Q?IR5+5Y+vzRDHxw277ZGLHRguDMWKxKtIrdGEPy2EIJBw2op9dgQGdQHcY0fO?=
 =?us-ascii?Q?B4WrMpk2Njj5Sbyx4YfA0j16iEfxs8TQQLHdY91j4JZiMw5pnKZr/0Rzsj4S?=
 =?us-ascii?Q?1zfijz8VOPF5W1QhhuncUlSHh8cpgbc/xeBP+kvJoTZ0dG797Fj2NUHaOUzm?=
 =?us-ascii?Q?8s2TeCO7CiKVDy6TqB0KrMVJAeDustNoYgQIamODK7x8uwhLPZHFbRuUklsY?=
 =?us-ascii?Q?mZzmwONGAFSjxSnQKty/lAH6lFtZIs5Qhi1Uj9nuspSAP4OlEsoh7XJXJXB2?=
 =?us-ascii?Q?z2mR8kjWzRDYdTOwUfsXcqTxwt6VJNObIGpnWY87XTNzi1Dwy/884ELyM6LO?=
 =?us-ascii?Q?JWnOOjLG/uHHTYsZOx2JN2rHEWXhttxg6QLlA+LpVZityPd7lDJyOlmNCHWx?=
 =?us-ascii?Q?0spe9KtDnbSxITx0qA3flaUtWrqmHy512YhKDQy386tFMOjQRx1Pl+OUtPX3?=
 =?us-ascii?Q?jlgTa/9EbXtbdA8Le092jq9sRGelHgThEFj1JgOqlBOuDUIleXF2IXvT9N1M?=
 =?us-ascii?Q?G3MTyGGL19LIrkCvFpDRQJibfaE9s5DkMOHyEh/kLKlZm7/i7xanRB+mQ4pn?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pYEpgC1x670qzn3BifhWUO817V/n39K7w9mpOfhFo04X1sb7DaLNMp7NiRP6VnGAIeP7oaiGVNbOCQaA4ehC96Fzmd5p/VVPVZ9PylAtGad3WeVC5tEmKLF/rpfiWbxQlZ/PW+AAmGTVlE4HfQh5Nh9DinKVrnPYDc43p/amNDnOvkSYjaQGZGRGno8051YgRnMuuu1WCBC19/wqZmROUJV/tb2rdN++0VnoJUryZI2QIxtqnvnf89kaYW6jaMIQoc9pJywVAUq3s098pE25oQh0nBlMckXvRwhhFaPngjgHOLidA/GBqgpHVJaEDYLsfeGhy7V8/S4AVj8MUOQFHyhkRxUL0UhqbkRRn56vDldo36rVDBMUPLPyLrKoiyPKgtATLvbKtM6dLegZn7iZGHWCk5ILk7BDi/hmJNUKkqMrfcuw1WqfhrNyvPZ9kJ/+T+5dl4WMlr4XKkBsfIalFuoXKnVe2/yRoz0qttrKdrhOcML1KRY3GPfawyfQK/bTDFs7k5xplGK6cKkWhocY2dI1UhjgprbmXziGIkex0qUIY2oXtdoLVeKzxq6QJcddf9u0qeIwY6WJTJTZgb+aIxargX0mJfVySRCOhHi+jHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316d02d3-ecdb-4070-858e-08dcf1e6df2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:41:47.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDHGorgBLtxoeSJkZzN7wLyjDHgrzPFAGJamU9cuytteB1QU8w9RC9GOZxAPnFU11bBR2K0eIm7sMkCfDb8r5wF+cutc1lU635zw8+yM8Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=821 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210112
X-Proofpoint-ORIG-GUID: ky63Ccy9p1yhYklC4sgKszPLxBrhiWrM
X-Proofpoint-GUID: ky63Ccy9p1yhYklC4sgKszPLxBrhiWrM

On Mon, Oct 21, 2024 at 04:33:19PM +0100, Lorenzo Stoakes wrote:
[snip]


> * For hardware poison markers it makes sense to drop them as you're
>   effectively saying 'I am done with this range that is now unbacked and
>   expect to get an empty page should I use it now'. UFFD WP I am not sure
>   about but presumably also fine.

[snip]

CORRECTION: (sorry multitasking atm now I have a non-melted CPU) UFFD WP is
            safe from MADV_FREE as it checks is_poisoned_swp_entry() which
            this patch updates to include guard pages, a change I will undo
            in v3. So disregard comment on UFFD WP here.

