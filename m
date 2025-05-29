Return-Path: <linux-arch+bounces-12130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA756AC7FD5
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386219E2D2A
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC522ACE7;
	Thu, 29 May 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sduzvy9K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="INniX/KQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0F22A813;
	Thu, 29 May 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529865; cv=fail; b=n7N7Cqgk2PFYUXolPhGcurVsYUa0pK0o1ZyJ3CPFPF3EoQIxZDBlFR4McxImORkV339CbE/7wbSwQaMQ9hxGUFK6AcnrhzmL1MFiSDaijGTMgdIGW4a/jtMfFuiIisPlTGldpmRSLL4wcAUqLygBdyq/lGGaBRIthAJAReyxkaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529865; c=relaxed/simple;
	bh=Ftmby0cuhMTHt6l6eO0xhmmCt95WV7XsBvIcH5J4+4I=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=bcyt9n0G1a18ohIga1g7L982qdmOVUtSTReWk3so7MMoM+2INsBi3/LDiMznfprJcWHkTaBFIMMmzpCWRdSsSDmk1/tmu6n8Ivq3OIPlRwNi06s6VcVma1J7IF74Kqe4w1lkMIKF25uPOv6symWQiYILUsv4lZpWmwTzENBo/kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sduzvy9K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=INniX/KQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7u7HM027030;
	Thu, 29 May 2025 14:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=Ftmby0cuhMTHt6l6eO0xhmmCt95WV7XsBvIcH5J4+4I=; b=
	sduzvy9Ke5/WyF5DGdClQ6RnWwERO3eyNTxIsiZqycWVtzJuhq3suEWnZ9rGLkRU
	8ziUJYAD9qZICXNCKZLncS9qZdGi8kp2goFLoTqtCskLyb5IvmfnLiSwS9wqeH+7
	cjFad5ElEBxUQ7CrcD0eoXkzXW8Q92p5obC/t4q8k1X95CXX0dkRBK6YpPQA8TpN
	n+g852mFidY6ADqCLbyYvqp/Pk+kOdiFSW3nezSd9AkANWZvu+bLz+AMd3LoNc/4
	/eE8wu8NoNqpJbLhhVtEBvdxsyXhxtpEMeHGJ4HA//LcvYgCTG+rBfLmiSkeMLpD
	9YN7wU7tzW1nbXDUtedjCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd86gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 14:43:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TEGM2Q019192;
	Thu, 29 May 2025 14:43:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jc25qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 14:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNrXmI79OdS2HgtPwxhJZ/vIvgQxBl/toKrg+TaOvF+PhEp30IROo8+GI6a/2/UPa8BR5ONKY9PvhPqe95mmKJyvjEncFVVsWJYYKxkud/tg6t9thbde7bgQkOuWGjwuR+v2oCRsJQNzymh7au/2XZ0YmJVN55KmVIXN3Mnwv/lx6r9Om6j6DrFjVz6KPJD0qkZ7PVbjnJC1TEdsDCBiE5keadiW3J7uwd4JQis6vCxvUsRqN2x6WnsjXAhP9GSycs88pR8ybzf0D3961EP9WOdG90edtwK9JaE70z2w+jhkKEDMGCoOmVqZ1hOIkNDYIOjj+qY003oruROcWZ3tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftmby0cuhMTHt6l6eO0xhmmCt95WV7XsBvIcH5J4+4I=;
 b=Tct7ReGo254mOEMAD+DW2fcF5ie4nmClSZC0yx9z5BorWQArk8v0ofB6j1imD2xavVY8kOMTCBlmWoP6UzulhIwnK1dhTK+WOJQwDR0bPDymebj4VU8+wmIv3B1nHX5cAwiQpDSfwa4ErjAUaaWusrDZ6FKw0F7iV/mkx1G0/V1qZuan6O4h/YE6rQFIFxo1kUVGmUvaAZf4fM/TXDFhCjmxA4HYuGGt8dlt/kjyZh9KLwskvqY2zYyUq8FAxkXt7Io/O7rCNm0WOsKPtVJOH4uvrQJpIQteX/l+2fVuXxmHZ/dzusAjmujNk4wszw6z0dtC06fg1MKyMcszWvi0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftmby0cuhMTHt6l6eO0xhmmCt95WV7XsBvIcH5J4+4I=;
 b=INniX/KQdTwVFRtmxYlv1oJoDSOYchgbuCVMKmQdIju3eqFmt2pbN/Jcn2ZHr/724tS1X+e8Xtp2oSY6yjtj2GXdOqUIKb0SyeRL43BsiX7HZeT4eTjtsPYn+Ovk+Be95RKRO2qmNP2Mh8uUSLGbEvVCm+yQu8vkQZrtHoUV/EA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 29 May
 2025 14:43:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 14:43:29 +0000
Date: Thu, 29 May 2025 15:43:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Pedro Falcato <pfalcato@suse.de>
Subject: [DISCUSSION] proposed mctl() API
Message-ID: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P265CA0220.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4158fa-1e0b-4b3a-6298-08dd9ebf2d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2VH6VizptZyAKUM1M2JstXUbiZ0ZSQCmZ4a+aOuGOCa9kHJVi3Wv21wYfBs?=
 =?us-ascii?Q?lx9YhcPNFDy/6BbKZKazo3G0M9ixs2hI7EvfByZLxMiKpRWxMTQh9Il03bNc?=
 =?us-ascii?Q?KWxzD9hycPv1z55g81sd3OiQizdJCtp8o/2nzn8HxpbK6jl4dOFHZPRro71f?=
 =?us-ascii?Q?JEnB1Q+jOLwjOLdnCAJs2WFWRm+aihYBuW3BSNPZfSSDhPZr0VE0SfxE9IP8?=
 =?us-ascii?Q?vA/u4sljlq0V9plLBtwkYHPpkFpxFmkEsvnalltWEkf/asiDqNyCMdm58kE5?=
 =?us-ascii?Q?0aOSWoEtt+MkmFZR8tt4nmDd9sX65drrd6MgNrj3SzzavYKpcCBM595pxtrU?=
 =?us-ascii?Q?t1K+pDVoREDD4Q3HSKqbAr3oDmPMNZKKHOad9l/dVcysIR7rdqr19A433oSJ?=
 =?us-ascii?Q?/VaJOQfxFPggmaZR5o3js2cs53JHSyoQFA2po61s2W2e6UbOzMBPQve9ohhD?=
 =?us-ascii?Q?2Qrl5VGyTmfNAGPzrYtva9n0Sp8F4tBVs/D+GKeZtNREhtKOjsZPcSAbGEEy?=
 =?us-ascii?Q?aWMsHqqo9/7D69n1i5Uovwv+DdDiY9obKNkNoKp6r2Q1qaxezQ8AIXirFIt2?=
 =?us-ascii?Q?j9VUmJMcRgow9Wi4Qix2U1qTFTgGn7QPcpUe3gmGMWYzFqoDhuK8Qr+zZY2H?=
 =?us-ascii?Q?pEgozixiKNl7NHEBfLuDU1o/wbEVFXmmfJCZ/K7QKSk/RkmnF0HPwb1lzFns?=
 =?us-ascii?Q?ybKsykea529khjbyblhgVDt3FSoc0f4N5K4z0jBC3yVGuOcA66QO6j6sxAJJ?=
 =?us-ascii?Q?Ny2URUBTfHIldx9NLHD5SnMPL65FQlTiTrcmVAxCGoyAs/ZoRYesQaicnqIX?=
 =?us-ascii?Q?6Bbnp8KnO+APeenkqhpHCP7cOb9e1EV1K9mkeL0NXtmxswSSuzSwTAyz4HGR?=
 =?us-ascii?Q?VT1/Jve2Yj4jjVjmcCX13vb9qSGH98qvhiYUvL2NBiTLlgVTLk/hx3F2/tWU?=
 =?us-ascii?Q?WHxqZSnF5MoeRweFibTHYYPURucIjOlRcQ2u5qo1WCUOXpLAFuqwvdRlEhWI?=
 =?us-ascii?Q?TdpmeeRE5ajdnLtGzu3alpb95DKO3Kj3eMmesnzw9TXvbMq4Vk3imSOMZx4p?=
 =?us-ascii?Q?lh/wc6LIHC407fbcY2Z/3LdyBCFzBqFArj4EUfB2eLnY6Q4PMzCvAssrvLr+?=
 =?us-ascii?Q?VPnAITWRW7LSLhBJ0uLj9BcR14oNpQUTvq4vvHKuIMf/eAGl4bbtqywTeVyN?=
 =?us-ascii?Q?HI1iCq55JWINsUmj/XPyBz5FHHXSoDnIwOGMQ0sHT4ANsAN30sb0hZbNWo06?=
 =?us-ascii?Q?01G5Z1rJySeVGJ9ellYk8Stp8OjzngvCEhdmZmiN9y29YmylsFwKLxsSQqf5?=
 =?us-ascii?Q?6rJ3SxlcRh6FfWh2LGLaWikCZW6zRWE/ksEzMJ4QHcLHq3/CuOxiBqCsmMyo?=
 =?us-ascii?Q?4K3u/j7W2h26mZxFJdnDIv+2nT1HIZdFUSpCbu0J2ulF56PDxk+ndYcmbIZG?=
 =?us-ascii?Q?TPxe2ZAy/NYc2QvoZRfaVzYeCIqyPdTDcL1kqsApdRoYnMeqIr/Z813oNnNe?=
 =?us-ascii?Q?qiUWMO7mFD+dR+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+j+keYBgs0BYEpmdEYXCnrP+z4eb2u/5b5qLIIC2RHIF85LfDUAQMSHdo1W?=
 =?us-ascii?Q?+KyIzPCUEpwYvWKO3CpWfAkDw90mnDAH+a22DnD8rE285D29XQYk+rP4h86r?=
 =?us-ascii?Q?8Vh+msUwOmadf70Vlh0gdL7BaxjVQzB7HeBTM1MG9erhZc/VW/TweXwURmAb?=
 =?us-ascii?Q?nIqRNMRYbBaG/xBXlDLZKb+exC2fdy1j9IIOyNum+HnZZNTJIBzEIX9MPLUX?=
 =?us-ascii?Q?/7f4MElhQo5mVhCMA5/u7jKZPYS8LZVmb8ODFoWxCV9sdUe1UWprTkA78S+i?=
 =?us-ascii?Q?IDKGt74KgVWtvgQtEFeOo2sCGS+dmPnnkHh8s+S0L44RkQmL3wjWJHh0LtPQ?=
 =?us-ascii?Q?cHa0ZH3CeYOTTCTNz4jp0ETZu7LFXY07pdeSqweImweyEq/JEGFiS36JWJjL?=
 =?us-ascii?Q?WoAg0qIpBFylfxwv033YRI+sqdeNfIHXpeOjpsnX+keVrvne0V3G/xxUhJBx?=
 =?us-ascii?Q?gDaS26JG1GupWxdDmDACaxn7OPbVJt/Iqv3AClyVhXyBv0E7qONPzs49EZTr?=
 =?us-ascii?Q?CK4/7V1XTJFGk4OBgkgG6Ojng6Q126t3D791NOnMb6WLqB8XhH4k5gmiNjT9?=
 =?us-ascii?Q?p3P5v0qXNGv7IELmBN09+DfcQCAdPbufwHoNHK4XSuPfunW9yMZXLFKddymt?=
 =?us-ascii?Q?x6X/9lVA/uLYVeCXywLW4L6B/WY1VjHAQUc8R7aWGf9HqTunO58ZsZhqybGh?=
 =?us-ascii?Q?VuC4xMAf9VDhyjcfepND8oGHeyZWeud/gr9zSagn5iwgvrzte9NkAZqj5KXb?=
 =?us-ascii?Q?ZjCer5Ogf5nzCObOr9ZTHB3SA1ckIoSOALX5a3/O+t+4VQDIJON/aIUMmAz3?=
 =?us-ascii?Q?K0k2t2Dsi7sJsh2yjXvv3JLt+PCcgoU6fkN5NvdgL6RNXV84iif3WnPrmRe2?=
 =?us-ascii?Q?X7r4IQCBNRWavihlYZkhnlsmxuEDzu7YzloSU5NEvOF+I+RxSVwHkGHDOPfx?=
 =?us-ascii?Q?WPnnPAepHJPfL+0zM0z/JIDwdgeJPNgkXA5gkWkqKuZMhFgr2XtJGT0HAC9N?=
 =?us-ascii?Q?vWMPku+JGDrXI60fG7C7aLN2hemSQiGDyiDWBszfKfSBVVDUX/5ANzxy3mrK?=
 =?us-ascii?Q?GXvV1oUSrQ5XBEzgsbWbTotKlpgyBgDoF6x8RK13hgKprhhvKy5nQdzI8m0E?=
 =?us-ascii?Q?agaRbOTbzkvzGh2ygqFAKIWmGSJ607zSUjc+I4+7VXumcG2XvZCOY0kzuHwz?=
 =?us-ascii?Q?uLVXoa82DE+P9hwavAwxBsUPURjQ9CvHq1v/lzST0suPPICbk3sw25EUJHBe?=
 =?us-ascii?Q?hYR94IwfcT/AeLaPdO6szeTixRbZytk/l/vq9DK/IbkUFEWM+/XkRt8Xp008?=
 =?us-ascii?Q?OB+0BtfuxFYRY5GYw/1swJoJ5mJEZwYyBUHm1TQZ8dErDtDGbV41UCDdejCW?=
 =?us-ascii?Q?lemYGZSa2f7JCaBC8Q0xpEsnOebRkmalZHky5mr8cCvkJEJ7VqNxzgkHwcVn?=
 =?us-ascii?Q?3fxWg11bRfmKQS/ktM6d/Ms0rJ3R5GrOq6Vw+4Zxe1Chvp8JxBYib1sDbtSu?=
 =?us-ascii?Q?JGRtK6gyQojj9xS+3kjUbpL9RdMMUjbyCSVAEUEjbPD5Tt9Be2eenLdIJYvV?=
 =?us-ascii?Q?yiyzTD1SeqokZTeM3PCc4ZZak0MAuJtiPkEPgwYPUJbfGPcdiC1HDJ63qT/9?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rATh+GLrYiZl/VtYnXgs0g8VN3seGkqbSke8u76urNYYyIck0oWe7Dam3WKQl/6qSpl08luQUSdpT+kgjLkmOp7swMrTUpb3jy4K6X8TPkjzgymSHmkALdlttz5Ul9tqxhkx7BqBOiFa6sSYeA+iJ7sBCVKPrQQgBgEGvePF+tjcKQ1VI8IwT+NFI4hbJtx/lsONsJxXkrRMQXhmal5/UzhO1zNhh9zfkYHGeJrpnr+urRIn24/WtVQEsv8C0lowBviBNuKTH/Fr38Kb4GYOv1MIVBKwJ1ydsN4O9SJ8lyqMvUAZMwZS0sVyBhiAeDmxZCmSX0pf8wqBk/Pa+jFvbOVYZw/DTjGbx8aFgwPbXngVq9s5trrAm1t4MKflkWaBVTOGBRt4eJnVIwxhz6IaQMnW8c0y4nvu8E+uikepjnciYamndpIbKwlj3VFGWxXEo7BIHtp9PoT/Smue/ZzeB5UIIjLC+RsTU3cC+amhLqHQA2X+lMZb2DCs10fiwdmGo3LiDjP31dZD6m3C0QoG2IdMojS3C7jNWrFUfzbzN+k6lfkCyWrdw9cOJA9v6WR19aoeistH5M3OEl6LkC+/bQ8M1rLi9dcJMuwmU9VPY5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4158fa-1e0b-4b3a-6298-08dd9ebf2d28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:43:29.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0xNUQWFh0Zpql/peN1SsrihKBJhHWSKJQLQGOAuTGReyFXYEkWS/L+1JvdYSbkPqWrr7naiGLaB4dWZMEHuGq9ZwW09eGvlI7wOCKeY4OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290143
X-Proofpoint-ORIG-GUID: NB0M-wyOI5ljrbmLTwn0rinsr5HtN8Id
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE0MyBTYWx0ZWRfX36WF4JTR7zVf s6+deNJw/y3pqPb29ShxPAjthVkQNTum+WcUrdVOQwvwjnlVCg4Jju2F+gixHbzKfGiLLO7kM2o iCiecTekWYxAZpUno+o0Q1XeoIDGfzTULNbeyjyV+zIBVdB2XkuG6H4/TzQxl2J18FHOojSv02Z
 Ajhab05j5rxdRVT/qZM3vzcW5JrOIT0Hi0z0rFYreSjSyDZpJw2GXJHzKvUx7yVbYNQOEtVOH0E sCaS2WQI8rX+phbgMCAvYZxxmlQfmDk50cNMN6d3gEu7DjPestur1Pi4CUikp747yFc5LxgaN9J VavCaRxrhmBqYXojCKRQbURtgLYEdUtlXLVZELttlNNdIq7E4xKTPcK8RyoQvGXE8wfi2VOJ9AQ
 EIroDCWgkLeihKOM2VQ0ko0a5iqY8xkqVJBbNPM8TsyQO+OsLrMzG0Xz6fO8CwTOSne+ChTy
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=683872a4 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=_W0dXSgXZTXSL6DKvR0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: NB0M-wyOI5ljrbmLTwn0rinsr5HtN8Id

## INTRODUCTION

After discussions in various threads (Usama's series adding a new prctl()
in [0], and a proposal to adapt process_madvise() to do the same -
conception in [1] and RFC in [2]), it seems fairly clear that it would make
sense to explore a dedicated API to explicitly allow for actions which
affect the virtual address space as a whole.

Also, Barry is implementing a feature (currently under RFC) which could
additionally make use of this API (see [3]).

[0]: https://lore.kernel.org/all/20250515133519.2779639-1-usamaarif642@gmail.com/
[1]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
[2]: https://lore.kernel.org/all/cover.1747686021.git.lorenzo.stoakes@oracle.com/
[3]: https://lore.kernel.org/all/20250514070820.51793-1-21cnbao@gmail.com/

While madvise() and process_madvise() are useful for altering the
attributes of VMAs within a virtual address space, it isn't the right fit
for something that affects the whole address space.

Additionally, a requirement of Usama's proposal (see [0]) is that we have
the ability to propagate the change in behaviour across fork/exec. This
further suggests the need for a dedicated interface, as this really sits
outside the ordinary behaviour of [process_]madvise().

prctl() is too broad and encourages mm code to migrate to kernel/sys.c
where it is at risk of bit-rotting. It can make it harder/impossible to
isolate mm logic for testing and logic there might be missed in changes
moving forward.

It also, like so many kernel interfaces, has 'grown roots out of its pot'
so to speak - while it started off as an ostensible 'process' manipulation
interface, prctl() operations manipulate a myriad of task, virtual
address space and even specific VMA attributes.

At this stage it really is a 'catch-all' for things we simply couldn't fit
elsewhere.

Therefore, as suggested by the rather excellent Liam Howlett, I propose an
mm-specific interface that _explicitly_ manipulates attributes of the
virtual address space as a whole.

I think something that mimics the simplicity of [process_]madvise() makes
sense - have a limited set of actions that can be taken, and treat them as
a simple action - a user requests you do XXX to the virtual address space
(that is, across the mm_struct), and you do it.

## INTERFACE

The proposed interface is simply:

int mctl(int pidfd, int action, unsigned int flags);

Since PIDFD_SELF is now available, it is easy to invoke this for the
current process, while also adding the flexibility of being able to apply
actions to other processes also.

The function will return 0 on success, -1 on failure, with errno set to the
error that arose, standard stuff.

The behaviour will be tailored to each action taken.

To begin with, I propose a single flag:

- MCTL_SET_DEFAULT_EXEC - Persists this behaviour across fork/exec.

This again will be tailored - only certain actions will be allowed to set
this flag, and we will of course assert appropriate capabilities, etc. upon
its use.

All actions would, impact every VMA (if adjustments to VMAs are required).

## SECURITY

Of course, security will be of utmost concern (Jann's input is important
here :)

We can vary security requirements depending on the action taken.

For an initial version I suggest we simply limit operations which:

- Operate on a remote process
- Use the MCTL_SET_DEFAULT_EXEC flag

To those tasks which possess the CAP_SYS_ADMIN capability.

This may be too restrictive - be good to get some feedback on this.

I know Jann raised concerns around privileged execution and perhaps it'd be
useful to see whether this would make more sense for the SET_DEFAULT_EXEC
case or not.

Usama - would requiring CAP_SYS_ADMIN be egregious to your use case?

## IMPLEMENTATION

I think that sensibly we'd need to add some new files here, mm/mctl.c,
include/linux/mctl.h (the latter of providing the MCTL_xxx actions and
flags).

We could find ways to share code between mm files where appropriate to
avoid too much duplication.

I suggest that the best way forward, if we were minded to examine how this
would look in practice, would be for me to implement an RFC that adds the
interface, and a simple MCTL_SET_NOHUGEPAGE, MCTL_CLEAR_NOHUGEPAGE
implementation as a proof of concept.

If we wanted to then go ahead with a non-RFC version, this could then form
a foundation upon which Usama and Barry could implement their features,
with Usama then able to add MCTL_[SET/CLEAR]_HUGEPAGE and Barry
MCTL_[SET/CLEAR]_FADE_ON_DEATH.

Obviously I don't mean to presume to suggest how we might proceed here -
only suggesting this might be a good way of moving forward and getting
things done as quickly as possible while allowing you guys to move forward
with your features.

Let me know if this makes sense, alternatively I could try to find a
relatively benign action to implement as part of the base work, or we could
simply collaborate to do it all in one series with multiple authors?

## RFC

The above is all only in effect 'putting ideas out there' so this is
entirely an RFC in spirit and intent - let me know if this makes sense in
whole or part :)

Thanks!

Lorenzo

