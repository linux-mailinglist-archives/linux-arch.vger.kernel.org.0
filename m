Return-Path: <linux-arch+bounces-8470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244F9AD062
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731811C2192B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5301CDA01;
	Wed, 23 Oct 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1nIdR+t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aik1bNRI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B971D042A;
	Wed, 23 Oct 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700752; cv=fail; b=sRi1IUfGpnfd2SbDVfhs4mwba3dNBM/f775OHHZB2+Qw1e/+cmkuVuanRpJ77ZA23PEh9dpXap4fbfb1I9ogbUb7kJoDxQuPvLhjSn2dn3hE/xDueaJLPjlwGrGhgSCU+RqsxD69IphtLGPIIiUb4K0G3hQFN38WlXpk/J7fBe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700752; c=relaxed/simple;
	bh=0eJkbvUjfwgWwdrcQqvoEYnEkbWIIw9HCMeEXMNz754=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmHItXkJJkzdf+Ocy7nYpxxdkXhklxJadQJhDg7vKWkL+dnojtkE04CPqGY6KQ7n/toGzRaWZmyahcvALunqMsFOaeC3xZvY9VtqiCnCO5veDY4cDY7fxEIxv6j5Nnbw4a/ohlKblHYkYf8vm2+BoO6g4nMQzqM9sPhV4ufVE/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1nIdR+t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aik1bNRI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeb6012114;
	Wed, 23 Oct 2024 16:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rehhcD8tSJY8JRu91h1Z0RIYv4pfg7THxWZdCfk58+E=; b=
	I1nIdR+tHACsdA9f/p+9mGJSqonXPzF4pObzurnDb0hcA3xujskgRR6ZxniT7/6P
	eVWGcMUuwX5tNdLpXSYqsiXsYE3S9sy1/wZoX0rXkDvNHVJNKNyqiV5rGvimnB8x
	QTBmx3ilM8ipMwRNSDyX6n3Lf0CZ1wHo+mOnZpHfOQP9QJAhuRoQ+TzqMVxDeAyN
	AYGm+lBvhygXD3NvIteIUIyLRELBf4ftIeiD6G2LT7sLSxlyWAW8IBD1mu9o+FpJ
	pruCIZBVJjSY8ydNfuqaefRMp7VGXe83c80QKu0+KO3Rn6stziEhDOlJBFMZ5MT4
	gv1fZawUERoWXxXfvOKM/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urhtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NG7XfL027087;
	Wed, 23 Oct 2024 16:25:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3294w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf5ZDCNWf+byTinSjCRZBw/8rdrlJHEMVjA/qOMhT++s4Za7NzzWENmox1Yt7H37X3xsNH3Gh4vXRfOF38324tr5va+cr6NxRlPB36yszYey31fiBMBA4Arl+oqOfFYrCn4E8maARFnRp/mRInsU2OiDVg6kDfwS14DqQJbCrvcO4LxRu0YId9wDmbgJXtyxJHBB0UuUpmIuUODWUS1CrNjTosfAF63aUKU3xr2BklquuTFd7ndxprGjvSagozOrLutXlNPhoy579Lq5dcW08yxc/FNOxkGbHmFWqtYisebAzxw78sqJDQhIOvGLO9FrIP1Mr0U74PjUHU4s+i8kXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rehhcD8tSJY8JRu91h1Z0RIYv4pfg7THxWZdCfk58+E=;
 b=tv5oPxSg57/KWUpx7liwuMgGcEU/U9GXyK2QsRNFxHqZ3XRVnzju1+oi2mQElDWAJOt9QZ8JdapyYbHPQwMT00mHAgQq0W5Ep5X4eEF0jL2axKrVh5Ur9zwunf67nG75y5zqFMU99ElrbsjYrcStLKXAal2WCojKcyT2Mr5h9eloH1xCe1ns9KMH5mg5a0rl62pxqFde5QgAZh7qqljLzBAYNP0OtUJKM91yBa8O3bSUIbta0NZui2pksBPcojPOBkj7fkFKoRw41y1tCGQiukRdOyXX2nZDF/wfBK5MugRoNRPL9F6FBbgYT2GgWZzu3QRL4KoIAJJ3ZlVh8Ee7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rehhcD8tSJY8JRu91h1Z0RIYv4pfg7THxWZdCfk58+E=;
 b=aik1bNRIKSADHUfusStQ/dO9819zsK52BF2OCFdqm3iORqW9DnsSdaNlePIpdBY8DNSbCTRbFaTZLYtZ3BvhySIM0ZBZ3M8cie8ZNQbQnp+Mca9gRyi3lxvjGy4/RI0EwgiAWfvHcxUSRIWaKUBZ/XAxcm3crDdJvoaNAPyLkHc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 23 Oct
 2024 16:25:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:25:04 +0000
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
Subject: [PATCH v3 3/5] mm: madvise: implement lightweight guard page mechanism
Date: Wed, 23 Oct 2024 17:24:40 +0100
Message-ID: <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::34) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e9caa1-07be-4475-a9d1-08dcf37f3fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYZpdcwulA2MjzHVOQ1C+U8wt8EGiZF2TX7ULmvus9doFSub2WrTxElBkvxR?=
 =?us-ascii?Q?PZ6+K6nu310oFH03mGFn8COcZrF0aoBe/Mi0vt8IeAWKVgBrNUNAtIWS/7yu?=
 =?us-ascii?Q?i3KsgV/jCYWCCuUId5gAGl1i2DI7aTQtjwGvOuaH8Aw92/miJ5LjLhW1SXFL?=
 =?us-ascii?Q?OV9Huj7AgZxhC7RhYtyhQf0BHo9PL5Nm9+eCZYiO/+mN/Z0zLIggFxlPmakR?=
 =?us-ascii?Q?xQUtXrCVEMHIjdv2HLJ01rLMhDwJWDAB9irGMHWmubzdin84zKji7r9LfnCv?=
 =?us-ascii?Q?eXlRueeH5TqcxZZ/vHGoEQfEj7w3avVKgnCo6rN2hYn1tpfEym/xctRuqL27?=
 =?us-ascii?Q?cmrGWoQZvddXXM0TUHhWmkkvlerTrYfZRWbCcXQvWHx4yhp0dDjhtZUoFv+M?=
 =?us-ascii?Q?UP+KfoFgu7aWJoZ829dBKO5DZv/tN8NGeBkNVSymgakmOpRiiCHPqBpmlx/I?=
 =?us-ascii?Q?hYNGRt7/YVvnmpWn7xzFD5MArF6T+Avg9Vn+4W65BdM1KwufWtED3rXxY1dj?=
 =?us-ascii?Q?h0qAo/8MYfTSBcDXLquJrru8xN7ofxQxmuGKbSEYSOFbkoz8gqGr/06gPx7S?=
 =?us-ascii?Q?vi4jLarbYeo4GOZf+RopB0KuPbZYRhklcthczOCSAtIDvLrSTwfZrgcMZ/dd?=
 =?us-ascii?Q?5+SqLq7lyeN6pPp0wrVLvnL1sgxyepK2zPdJVto31ILldXVH08QUHJLd/3UJ?=
 =?us-ascii?Q?SRNlM3aqtd8hb8ti2BizAll+VcColPyAV3Jk6dhHFJZ705y9wYoLnu6FKLzt?=
 =?us-ascii?Q?PKO5UsAQV/LodQCvMOYq/VNt5iyHW6dGx+INLiCd09QIgFodK1/idfIG47in?=
 =?us-ascii?Q?wmSFaFe760a6yNYKMtfUL/KW7t5S05g/6LI9UAWu1PkXm3kH4DT167ivOAi/?=
 =?us-ascii?Q?duW69YMsc7eGffV+dHR4CLkooteQWHI7VMOpVMGtveGYuwOhMiNHQovaolz+?=
 =?us-ascii?Q?I6+qfQ1W8ErrkwBxBEgRolUa2/6B5q3dRCgy15j7ltQYXwrLdLtjp9ZUt4o4?=
 =?us-ascii?Q?4JLuNcZEad6xmKh1yEVBSfY7kOf1f5VYcJ8KxoPFzfQOeAF7+4aa7wg8qs7+?=
 =?us-ascii?Q?dGkAM5bo40wMayoRjFCq56gUDpyDpOTu65JGxDN02UKL14DGhr+EjLilkx0x?=
 =?us-ascii?Q?mGz1uNxIl6Xnmgc04n++lK7+WFP4vQcvFtKG4W/3lICsclejQhk+ClmszwRY?=
 =?us-ascii?Q?O0bi29668TzWLAuJ9LDw7pKThmXEFSLVXRawXBvHSEVF4GTh9sfP/4Hu8bGq?=
 =?us-ascii?Q?GWwQOCYwCV8ZXCBopQzbpzkplHXB64WdtALqst+V+X+MIU/gRA6wt1ntMCER?=
 =?us-ascii?Q?bGObjzjsbeZRimXVGHqt4pZY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rkFjLYOGJCPku7YbmDBkLMAdbf/2ZinmcphrWYCtL+4OIi7DlebS4VMcEWF?=
 =?us-ascii?Q?C5WAP0m1hgiiS/Uu9TDYhtpCa1zhBW7o+mNnOcsJKSY0rLCDDV4mc44D6Njr?=
 =?us-ascii?Q?07k801ysQvt1xniOOWX2vSInZo5mU53Z5GyHICprQ7pHLDLiv92NB2C0sJWG?=
 =?us-ascii?Q?wMTysXz3PmkB62Wj3H2Z4cdJWjnCdt3npnMcOvcALX1ZZKqqChJ5KYXCphqY?=
 =?us-ascii?Q?V5tiINalokQZCyKsJOabJtrETBsnMntVwemKFvTy2uEqIJYHlzP5Qoq8ZVzr?=
 =?us-ascii?Q?EJyHqJQ408toNL9jp0XNvp9t6/cwAb7nTs7KodE7VLy4fYyMEc6mclptctDy?=
 =?us-ascii?Q?KaP05MuzU6EX8/WcvuanZb213mziY8bDQV4zVAE5Ty7sOwiKcB0WDfFaScm0?=
 =?us-ascii?Q?lbNNsv6Mu7ZSyVWCph3kpKaauowRxvLZqHZMHIvZyzBX4bvPmF2Y9oXPRxn5?=
 =?us-ascii?Q?92cwdW60On2PuMvh85JaStpQD6b75189Dai+3aN2Pa+y7j1W1yYUeguUrN/o?=
 =?us-ascii?Q?lBYqwevIJSVmGvbbFp3aAwMq6uIdi6i+c3lbhfD+xGUHtCY2pUEqc1kXoEwl?=
 =?us-ascii?Q?lytHPgFL1T/AqPQM3jVvQKi1emi1Gbe2BSh7sevYWAMX0j+CSgU49qnymGvc?=
 =?us-ascii?Q?cUQTs1kvX8a8mm4BOLyt7FQrg8/qLweKAeU+uJ6W/ZwC5vRaqdBRO/k4x5Us?=
 =?us-ascii?Q?TqeO1JMBGEfkXFKP9TWbwdMyXBnPbl1t+0EWCQUfk271GkASB3T0OPmou4XX?=
 =?us-ascii?Q?ymf4jGISF4WlzVhEQ6Svo+H6SMsUUnSO4K3/w2N9EyocjR1ZefqUIbTx1vr0?=
 =?us-ascii?Q?DrVPQL621p8K8YL9aEU7oMouqrE/PMLRVKLEh3X4zRj58BFdJ4ygO+o86fy2?=
 =?us-ascii?Q?reKLe/6Dqqk+X9x1A9wqHXXMnXaUCfqTEOKjNWw3QSaVURd9iqa2EMBiJqie?=
 =?us-ascii?Q?8XSmBpv1dXBlvRQihX84+Ri9Lls2nFoYvyMAUwcmQwU/6pJA4qEFYVDmLb/8?=
 =?us-ascii?Q?/moPbx+/VmmUZhk5bw17itoks0u55fkpla5H4dGtgTl7qvXIutvScnqo2jaV?=
 =?us-ascii?Q?/OS5TY0OdgGKptZKUby9Px887+4cbeCagtCMcR5srLVnYf6w3lQTUxs7kA1v?=
 =?us-ascii?Q?hTqAkoM/RdSbM5P4DA7qdPkBHxHQIyHzNWviNlJHgatBmcHkCqignpL7MWBG?=
 =?us-ascii?Q?WRkf8WQSaAFeQWilUsEgAlyHQBxhWpxEsJk7R3mgEMXYEQ7mJ4wLbAfiEVF+?=
 =?us-ascii?Q?NPhkWeQF7IYvGMlwrDN7BJNdENRRTLgDZPtivQ3W1qjIve9+XH2IMkmLs2Bm?=
 =?us-ascii?Q?LTeZZjMsvYE2BUqyOFCxMPr/2m1roTSxHDHvH0D41Stc4fsHWqHIo0jG5N/J?=
 =?us-ascii?Q?fNsQvSUgBjABNjavmAUFupxNnYzy5AfZ0Q4q8kNGotB3P91aBwz5DcS/29sB?=
 =?us-ascii?Q?yY96XWGxmbjVc5SMwl5mR2fhw0osmR3MJ8OT5tEBLXqTri0Ds4kf9jtcfBRt?=
 =?us-ascii?Q?FPEsxNPuhqKtqJB55kJyePB0zE9rVzQjGnGbKEm0qVBhu22suOC9SDlONQbv?=
 =?us-ascii?Q?wIvL0qVaZUkICqRvvbOdwV827MkB83iaE52HGTIcudMwIPdCg/DFFDceZecy?=
 =?us-ascii?Q?5386ZzpO/RDyWjFn+bWxwRCxl6GXL4OQD1EGLFxPpg8LkyeUIoYIJukj5XN5?=
 =?us-ascii?Q?EjJBwQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	if5QiyLxD9rX40ghYLgbG41r8IUXlU04TLhK6maDJ4IuV1zSdPTvAwQcBY+OR/UAjxEv+xQcYwiQs1EDGo+2aKBFv4zdy3KtpCWlhQXg8oeALM6SrhCm6ZkKF0Z4Cf35SqyQstgf6+ovaGCY+dCUd05YLm8NPbWJzGRQeuuYROQn8Uq1kVsE6n5IiReY1TkPfOiaNIPSfUEj9i921nhJ8q+/U2OcuI0TgUf4QuKm60kSKCsQAA9sMF5VzxYrgD3ig/0/c7t+w965sDEo66BJwznvzZ/jyInnuPPCAC5YP0EFvN9J52B1OTYUrrd9wQa0SmITP00hs00EAANgOJKdMWhl7CdRSedBomapcPRtU9ftrobf2CqI2Zupx4Xkv205hqdw8GqPq2AMUOOaRMHp/5gxBfhMn5zglildTqEgC8L941G/ZViNfxGTdQC6EMpTLFtuWHto66kEmZB6MpdKWlTQUUtCR07wh/Up3bKO5j9bUFA/JNgisv3FC/TiATmvpIpifsqJjayrSkzOZuowmPgf3YoB/XW9WIWpmY4c9nzcU0gzSxYFtJ+sCBqP2NfhTTeUbHS9E/zrZlrCHmT+Xz5cCynUVu5ZHv/NmW1w+No=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e9caa1-07be-4475-a9d1-08dcf37f3fb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:25:04.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJs74We5nrfJsH4UHoob1kK1UzLechaF42hgOK2NzyK6Yx5PRTqpa53ugsqT9qTfTgGDuGs3sTKCf0LejDNwlSpgDvov+oIvPZlNGglW/vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-GUID: CDZ8coekquKxdI1ikuK1jM3uXG-RlJOq
X-Proofpoint-ORIG-GUID: CDZ8coekquKxdI1ikuK1jM3uXG-RlJOq

Implement a new lightweight guard page feature, that is regions of userland
virtual memory that, when accessed, cause a fatal signal to arise.

Currently users must establish PROT_NONE ranges to achieve this.

However this is very costly memory-wise - we need a VMA for each and every
one of these regions AND they become unmergeable with surrounding VMAs.

In addition repeated mmap() calls require repeated kernel context switches
and contention of the mmap lock to install these ranges, potentially also
having to unmap memory if installed over existing ranges.

The lightweight guard approach eliminates the VMA cost altogether - rather
than establishing a PROT_NONE VMA, it operates at the level of page table
entries - establishing PTE markers such that accesses to them cause a fault
followed by a SIGSGEV signal being raised.

This is achieved through the PTE marker mechanism, which we have already
extended to provide PTE_MARKER_GUARD, which we installed via the generic
page walking logic which we have extended for this purpose.

These guard ranges are established with MADV_GUARD_INSTALL. If the range in
which they are installed contain any existing mappings, they will be
zapped, i.e. free the range and unmap memory (thus mimicking the behaviour
of MADV_DONTNEED in this respect).

Any existing guard entries will be left untouched. There is therefore no
nesting of guarded pages.

Guarded ranges are NOT cleared by MADV_DONTNEED nor MADV_FREE (in both
instances the memory range may be reused at which point a user would expect
guards to still be in place), but they are cleared via MADV_GUARD_REMOVE,
process teardown or unmapping of memory ranges.

The guard property can be removed from ranges via MADV_GUARD_REMOVE. The
ranges over which this is applied, should they contain non-guard entries,
will be untouched, with only guard entries being cleared.

We permit this operation on anonymous memory only, and only VMAs which are
non-special, non-huge and not mlock()'d (if we permitted this we'd have to
drop locked pages which would be rather counterintuitive).

Racing page faults can cause repeated attempts to install guard pages that
are interrupted, result in a zap, and this process can end up being
repeated. If this happens more than would be expected in normal operation,
we rescind locks and retry the whole thing, which avoids lock contention in
this scenario.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/alpha/include/uapi/asm/mman.h     |   3 +
 arch/mips/include/uapi/asm/mman.h      |   3 +
 arch/parisc/include/uapi/asm/mman.h    |   3 +
 arch/xtensa/include/uapi/asm/mman.h    |   3 +
 include/uapi/asm-generic/mman-common.h |   3 +
 mm/internal.h                          |   6 +
 mm/madvise.c                           | 225 +++++++++++++++++++++++++
 mm/mseal.c                             |   1 +
 8 files changed, 247 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..1e700468a685 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..b700dae28c48 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..b6a709506987 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -75,6 +75,9 @@
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..99d4ccee7f6e 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..1ea2c4c33b86 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/internal.h b/mm/internal.h
index fb1fb0c984e4..fcf08b5e64dc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -423,6 +423,12 @@ extern unsigned long highest_memmap_pfn;
  */
 #define MAX_RECLAIM_RETRIES 16
 
+/*
+ * Maximum number of attempts we make to install guard pages before we give up
+ * and return -ERESTARTNOINTR to have userspace try again.
+ */
+#define MAX_MADVISE_GUARD_RETRIES 3
+
 /*
  * in mm/vmscan.c:
  */
diff --git a/mm/madvise.c b/mm/madvise.c
index e871a72a6c32..48eba25e25fe 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -60,6 +60,8 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_GUARD_INSTALL:
+	case MADV_GUARD_REMOVE:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -1017,6 +1019,214 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
+{
+	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
+
+	/*
+	 * A user could lock after setting a guard range but that's fine, as
+	 * they'd not be able to fault in. The issue arises when we try to zap
+	 * existing locked VMAs. We don't want to do that.
+	 */
+	if (!allow_locked)
+		disallowed |= VM_LOCKED;
+
+	if (!vma_is_anonymous(vma))
+		return false;
+
+	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
+		return false;
+
+	return true;
+}
+
+static bool is_guard_pte_marker(pte_t ptent)
+{
+	return is_pte_marker(ptent) &&
+		is_guard_swp_entry(pte_to_swp_entry(ptent));
+}
+
+static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
+{
+	pud_t pudval = pudp_get(pud);
+
+	/* If huge return >0 so we abort the operation + zap. */
+	return pud_trans_huge(pudval) || pud_devmap(pudval);
+}
+
+static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
+{
+	pmd_t pmdval = pmdp_get(pmd);
+
+	/* If huge return >0 so we abort the operation + zap. */
+	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
+}
+
+static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
+{
+	pte_t pteval = ptep_get(pte);
+	unsigned long *nr_pages = (unsigned long *)walk->private;
+
+	/* If there is already a guard page marker, we have nothing to do. */
+	if (is_guard_pte_marker(pteval)) {
+		(*nr_pages)++;
+
+		return 0;
+	}
+
+	/* If populated return >0 so we abort the operation + zap. */
+	return 1;
+}
+
+static int guard_install_set_pte(unsigned long addr, unsigned long next,
+				 pte_t *ptep, struct mm_walk *walk)
+{
+	unsigned long *nr_pages = (unsigned long *)walk->private;
+
+	/* Simply install a PTE marker, this causes segfault on access. */
+	*ptep = make_pte_marker(PTE_MARKER_GUARD);
+	(*nr_pages)++;
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_install_walk_ops = {
+	.pud_entry		= guard_install_pud_entry,
+	.pmd_entry		= guard_install_pmd_entry,
+	.pte_entry		= guard_install_pte_entry,
+	.install_pte		= guard_install_set_pte,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_install(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	long err;
+	int i;
+
+	*prev = vma;
+	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
+		return -EINVAL;
+
+	/*
+	 * If we install guard markers, then the range is no longer
+	 * empty from a page table perspective and therefore it's
+	 * appropriate to have an anon_vma.
+	 *
+	 * This ensures that on fork, we copy page tables correctly.
+	 */
+	err = anon_vma_prepare(vma);
+	if (err)
+		return err;
+
+	/*
+	 * Optimistically try to install the guard marker pages first. If any
+	 * non-guard pages are encountered, give up and zap the range before
+	 * trying again.
+	 *
+	 * We try a few times before giving up and releasing back to userland to
+	 * loop around, releasing locks in the process to avoid contention. This
+	 * would only happen if there was a great many racing page faults.
+	 *
+	 * In most cases we should simply install the guard markers immediately
+	 * with no zap or looping.
+	 */
+	for (i = 0; i < MAX_MADVISE_GUARD_RETRIES; i++) {
+		unsigned long nr_pages = 0;
+
+		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
+		err = walk_page_range_mm(vma->vm_mm, start, end,
+					 &guard_install_walk_ops, &nr_pages);
+		if (err < 0)
+			return err;
+
+		if (err == 0) {
+			unsigned long nr_expected_pages = PHYS_PFN(end - start);
+
+			VM_WARN_ON(nr_pages != nr_expected_pages);
+			return 0;
+		}
+
+		/*
+		 * OK some of the range have non-guard pages mapped, zap
+		 * them. This leaves existing guard pages in place.
+		 */
+		zap_page_range_single(vma, start, end - start, NULL);
+	}
+
+	/*
+	 * We were unable to install the guard pages due to being raced by page
+	 * faults. This should not happen ordinarily. We return to userspace and
+	 * immediately retry, relieving lock contention.
+	 */
+	return -ERESTARTNOINTR;
+}
+
+static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pud_t pudval = pudp_get(pud);
+
+	/* If huge, cannot have guard pages present, so no-op - skip. */
+	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pmd_t pmdval = pmdp_get(pmd);
+
+	/* If huge, cannot have guard pages present, so no-op - skip. */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pte_t ptent = ptep_get(pte);
+
+	if (is_guard_pte_marker(ptent)) {
+		/* Simply clear the PTE marker. */
+		pte_clear_not_present_full(walk->mm, addr, pte, false);
+		update_mmu_cache(walk->vma, addr, pte);
+	}
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_remove_walk_ops = {
+	.pud_entry		= guard_remove_pud_entry,
+	.pmd_entry		= guard_remove_pmd_entry,
+	.pte_entry		= guard_remove_pte_entry,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_remove(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	*prev = vma;
+	/*
+	 * We're ok with removing guards in mlock()'d ranges, as this is a
+	 * non-destructive action.
+	 */
+	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
+		return -EINVAL;
+
+	return walk_page_range(vma->vm_mm, start, end,
+			       &guard_remove_walk_ops, NULL);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1098,6 +1308,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	case MADV_COLLAPSE:
 		return madvise_collapse(vma, prev, start, end);
+	case MADV_GUARD_INSTALL:
+		return madvise_guard_install(vma, prev, start, end);
+	case MADV_GUARD_REMOVE:
+		return madvise_guard_remove(vma, prev, start, end);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1197,6 +1411,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_GUARD_INSTALL:
+	case MADV_GUARD_REMOVE:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
@@ -1490,6 +1706,15 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	while (iov_iter_count(iter)) {
 		ret = do_madvise(mm, (unsigned long)iter_iov_addr(iter),
 				 iter_iov_len(iter), behavior);
+		/*
+		 * We cannot return this, as we instead return the number of
+		 * successful operations. Since all this would achieve in a
+		 * single madvise() invocation is to re-enter the syscall, and
+		 * we have already rescinded locks, it should be no problem to
+		 * simply try again.
+		 */
+		if (ret == -ERESTARTNOINTR)
+			continue;
 		if (ret < 0)
 			break;
 		iov_iter_advance(iter, iter_iov_len(iter));
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..81d6e980e8a9 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
 	case MADV_REMOVE:
 	case MADV_DONTFORK:
 	case MADV_WIPEONFORK:
+	case MADV_GUARD_INSTALL:
 		return true;
 	}
 
-- 
2.47.0


