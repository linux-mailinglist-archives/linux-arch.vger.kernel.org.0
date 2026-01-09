Return-Path: <linux-arch+bounces-15732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEBD0C013
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361773024D4A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979152DECCB;
	Fri,  9 Jan 2026 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akk++srQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TxKi3pMs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C22DC789;
	Fri,  9 Jan 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985602; cv=fail; b=iZYE7u/RAjyNTbWXwbdRbfC30XarbmR7SiiH7z8lbSwOEK9H571BaLw9mybJ7h4MtFuGbxjTj9EOmbH7+SRmMEYqxDCS2DKeoAuFJNGSJaTj4DkkN0RM0JJsGSAKLWpCo23MQC3rcZm2qYokvjAfvQkJVaDMndTIIXQvL4j8kkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985602; c=relaxed/simple;
	bh=sWFl0TvCmFhoPKcq9IitoC/xNEEje19Nn4nsL8+3Rq0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=aWsKX1g1XuYYSv5Gofl1Fb0vmS7QdTF7MYGwlVCTPNTCdI09bu8RBxKdBmYWu+PbbxylS3sxo5065Kk+A2mYfG0eT23MV0GVpNjNSBM9rZlVnGL8OK340MxXkcd/f/ouHM8ZKg/TRY7H8QdVzW5w8F14HOXv8IGtdD3qvsabZeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=akk++srQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TxKi3pMs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609IQTE43578453;
	Fri, 9 Jan 2026 19:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cXSPKm5oBqX1V2YhEc
	Pfa4H6HqnqpQN9Joryw7W4LNI=; b=akk++srQlafyAl0tSOhVM92JxAlMu6QvUg
	V524yNJ5JbLuhqg5nmN6W3Ro/d4Bocy9seRMKraKfk/sOZoeBwbMnOagDARKtrlm
	Q9HxxUg8ZxoC1CJiPe2YJMmQ+7Ywc9DIOnn4aYVZTOoXlQ5w8AolQpU0bdxzKiux
	StUN4BWcTfkHr6t81YL4H/0R6UrybXnj1/vX07LLueLvEeeYyeqQ/20P0hxdNVOL
	nyGBg7jeNeUiqtzc83cfn618GdlX1Zi0UVQNE/3n0dvyrC20iiJs1IGp3iPh0zbn
	Yzw1KOlzrOINdu6BJx71JqFK/RQiDcTyUXpi/9KVz1OpnSsIgE2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk6y401u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 19:06:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609HqRS7020426;
	Fri, 9 Jan 2026 19:06:19 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpr1bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 19:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bulg5WgWiJa58ELcpHUKtfYmB3fT0PB8+0vDPkEXsCCInFhb9vFiSMt4n69CN3FIZM75EKR334bvITgdL14vWwawQwsDUcWhQDZPsL8M88YOGNgc9O+I+q8PxY3mYcH3ekgviENLxQLPkOqCtpWh+U2LpG1LB4/JcPYLANj7+E6LD7RI3Vl6MpfRwIowJjzAyWEIbfO9bN6IeNoz1hfnsyzqy9u/WVUV4k+rDde8G5oO1+nJr4o2XO5rQ0TftDPzqqiNDjoCG/QjkNHhOJHHQ7WmHBir3CKmjtuA8PTFp5bV6GF6Mg0bwC2BSe7SAqHkFxfxstu3MdUMAMho135CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXSPKm5oBqX1V2YhEcPfa4H6HqnqpQN9Joryw7W4LNI=;
 b=OhLFAsGF/xGJRg370UahSNyoRRjHsNQwoxIieq7vK2mDCgPAXt0QYQnSr1vVDCGP/+cYVZaNZDRlJ9VQiGZWX+20YKED7qa/SgeTchjuwLOIHKCj+RbtCTBR4AyblJ79ezulJhTPhCpKcZuW8G1ANXSfvPAHm1nlnueWKyRvLDvK+F6b9tSvfeJImM8EMQJsdY3vlR92gRTbGK1u/a9ffoBeGG9h5oITNvl4IgvJQ68slexCj2KuP7wlTWyI+Ah8dLGCMt1WPZgsjWk1pLWkQW0twe5Vp9Bq+gdLbD9oPw2vM8wVahzHaM1yLyqx7OqMyleQxeYqDH7RL0OEizHJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXSPKm5oBqX1V2YhEcPfa4H6HqnqpQN9Joryw7W4LNI=;
 b=TxKi3pMsVJlXgLxo1DLCdonnfYYDdJwLtOPxDO2lSIst+7yp5eYvXalJ1LKigfAfAN8L2v3Yy8Zn0e4xGw51Wu4UqKJGYScMczpfShLKsD9MV5Abs1gnDpMIzPYY6XKGDk/e0Lcba2z/xTz/1tDEDjHe6ZDwMRVBQQSLBSe/rCQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 19:06:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 19:06:15 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-8-ankur.a.arora@oracle.com>
 <aWEMkHbBOgOkx_9f@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v8 07/12] atomic: Add atomic_cond_read_*_timeout()
In-reply-to: <aWEMkHbBOgOkx_9f@willie-the-truck>
Date: Fri, 09 Jan 2026 11:06:13 -0800
Message-ID: <87cy3imwre.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:303:8e::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e45982-4a07-4aa7-5225-08de4fb22957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FQzlTsOdvq0ki27RhH5Dz7PK8jS5yIfBKxKD0V6bklykXbT+jfTiO7cb2SCC?=
 =?us-ascii?Q?u4Ct2foYJswEaCBiMLj4Xj1ZIztBtgUNCo4IULDHXJe8YSGgdglIAEaJdqEm?=
 =?us-ascii?Q?iL4uoeNr8yBudd9NLpkv4jYW63h8D9rTRHI9t/Wv52PCu9dkITdSzEDlkalS?=
 =?us-ascii?Q?1AjYy+tQlDutWkELzFI0Q/gfxd7IbTuKSCEMPm9mF6y3/oWcm74lynDTMY/Z?=
 =?us-ascii?Q?puWcKnNHJU22VX2549SPlynu9+HviLnK4EXjX7QQH9LkjgcEo8jwNBtWT5i9?=
 =?us-ascii?Q?QoMiUWKCYD7w1i9llc5X/3IBsCE5NKMq++okwL3CCo3r6yFof/8Gr7DxbxE2?=
 =?us-ascii?Q?MlphOqVGsjDyBPTiVl0bjhzIzUrBxQt66BhmH6U95W1ZFuapyArg71Njcw05?=
 =?us-ascii?Q?L41+4WVfb87rr4DEGMIwS+qF3WYX5Xe5ToHj5TzvHJXojy0tloUEOa2dWBI7?=
 =?us-ascii?Q?IMPs6/SXD5RMG7o1k3sKromAALa03eGDi437yAL/F9Evs8pCkq/irdQ/BGOe?=
 =?us-ascii?Q?3T1UIHzSWcYMnJAi0PI5RXDYdJ+z+Ufs5OX0FfWkr992CI+dwwzWxLgdpSV+?=
 =?us-ascii?Q?UONcMMFnvYHiHYP8b51YoeKdi09fRgutgb414NxkZMpaSEJQhVm5QFO6d4Dz?=
 =?us-ascii?Q?gKwW5Y8+tkfCK46fMtj3yg0Zs32IGQDdzYRFk3dhLKUHyQEVjjwW/GpmYrEL?=
 =?us-ascii?Q?YKBWqbtU9UJfShJLwf8rZMABqcI3S8L1LDoRgAouz9fq1ZYQUNH9+bjtryDN?=
 =?us-ascii?Q?c5qzw5XRTc/Kx0H7evwO40NV0F0W2TpgLTLHlqTbVjdQyhQLMtStjv/KLiZa?=
 =?us-ascii?Q?RbMAzq1yets0ZIkqgGUzpGiOcTZraP1F+F2RxqLgt7zpb2f5NVggq1owRbUz?=
 =?us-ascii?Q?z8z1KYT3cAhXGogfaFnFe0OKipMRnwcCw5kHvPKuC6Z8uLNi4DF6OV/DQXnz?=
 =?us-ascii?Q?/VV187262PZYqiKO61+slprMMDLC1yuDZ9xhoJkH1S1SMmxqRJU+CSKnfHoE?=
 =?us-ascii?Q?mErPHrzABlfuQnldvgTDOw5BXwSDXCBrAdYkTeOMSgx28S9twXPKSQJwWKOi?=
 =?us-ascii?Q?KmttVA42IElBQcYiTFc5dYH5ZNe6lWlJH5Ja+hh6K19PgqNV2AWb9ay8+5q7?=
 =?us-ascii?Q?wQxKET1KccU0g4eGCeoOqq3636XDj1P5AXL/n/h1i0SbnNZXuVmPw5/o+Lu/?=
 =?us-ascii?Q?f6l5eXTjlx/enEBzk2fBmC9AgMqntdv4jHbn1HTrmOK54gAkCckOGMB1vdHE?=
 =?us-ascii?Q?KCfOlEZHz4/0XOaXCCEafY6yGR7s1ppsyeVft0TRmljgdv66E4YGap2Sx7v4?=
 =?us-ascii?Q?igTB31gitXcy82x0ZnuMdg4yougiwTwIcmre5R0SAUZahy4zJ7WVHEc7eqqs?=
 =?us-ascii?Q?kA8T0HmfFPhLBbiKX3oH0xVBXzgFhpKSIS++9ZWDyB2qzMQK4FMQG8G2wd1b?=
 =?us-ascii?Q?o9ltGSq4SlZWLLdI5so1ZzAAbnTklzak?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yw/xa/grHOWGyjUuwEtGOqeZbPQg6ilGkA1IyC1eFaUMXYO9AyrKGLV6lwFJ?=
 =?us-ascii?Q?X4VgrOS1ez9GanP88Lq4s+3UXMm6yG2mT/iSQyGw9aM99Th8PU5AMnIadE+v?=
 =?us-ascii?Q?ODyZAryaFsa0kdpGVHQ/C2zY2wl9W+tJrNk0RbivmghUc45DSFHXT5Bl8IE3?=
 =?us-ascii?Q?yr3Zq0lE2UpPX6fhuNBLh9pmZD6A9ctFHI+WbLyVDSHQnUxFtcnfzj/5/F40?=
 =?us-ascii?Q?QgLZfEuoJQbWb1RHSlIFgWDIOXwKK/NG9bni2i/jTb1XSVr7yP+kNU1ly8A3?=
 =?us-ascii?Q?cdZlzbu/AL9wHbWyRoYRHw0m2m6tvRCRq7NExmyY4DdKH7GN7B6eW47UdOB0?=
 =?us-ascii?Q?QpKAVR9EwKsQl60UYsLuUGlOJYfXBfmGZx+pFAXuJDpzprzcy/Z+2nlbvx/Y?=
 =?us-ascii?Q?T5Thbc1EYYUTDrph8Q0CNOc3/rclPAePPwrylW3jXUoXaLlN6VTFk8N3XnCk?=
 =?us-ascii?Q?DYWRz0KVgqJjKJE3miPmDJGp/YJQeuXNhCzwPwZ3keIqtRrtryHwQdAJUSzu?=
 =?us-ascii?Q?q2A1gOI5IFGqSd8OMDSG/ZKCjyGfDy340UY9zIPHVMxwIN2bV0Q/hHMi5KYA?=
 =?us-ascii?Q?bGKBx+6L41ZBMgxK12Gek5g9TqDlKR09LE5M++BglEC+gKSM3LN/skZArNA1?=
 =?us-ascii?Q?Uf5eH2LBaJbStwCm3viq5YEvqkku4y/vRwAoAYLZHC7tNMz1ln48N/akWR1z?=
 =?us-ascii?Q?ZN1jcjuYA0Zjw4xtOUtWRBv4k5Hz1eTDAz7zvy9zaXX+1IeIJDUp+BXsnvmG?=
 =?us-ascii?Q?xKkGBQIKQBjdpMAynVfxiVElK3kUqT8pzDZoBjSc7/uyy4GKrrqw8pBv3r6f?=
 =?us-ascii?Q?4LevDeXmxm3/7gIij++X9Dz8UAqiW+iAngJTnd/fUBIV9yk5R2YocIkV6+pw?=
 =?us-ascii?Q?IPRmezHfeBN5APQaVLK2eGfOv8H7M8uI3l0fPJUu4EylzIi62+ha+5/Yru5Z?=
 =?us-ascii?Q?w1TGWuzUu1LrbWSxnFeWT1hH0MuU57nKmjVW2/DMX9z5e52iR7BHbpXyy/Pg?=
 =?us-ascii?Q?GQwOr4Up9KeHeQUyOU4MiackV4TXUHHj6FG/3GTRp/gXqL2FIwwrKf1ArUW4?=
 =?us-ascii?Q?tC4CrHND9dKFHIJEYmc949nE5/jVCkMmku28zYCx1uLANDMMstJVI+tC84/t?=
 =?us-ascii?Q?OiH+adIxRcjIVpKbQHPPxlyZCVp9xP7MUdXgHAi4a7AVgUbDsliuiZnmAz+r?=
 =?us-ascii?Q?qo6v7zQUglfCf2uJmR9H479i2DCpWVTTkRUwHM97wujHhPWlwzOjz2cw0Zht?=
 =?us-ascii?Q?aZujBMRZpF77+bjfMi5X2BA7mnEH5ijZsHlzTUzgvqt188tz327gCr5dGGn+?=
 =?us-ascii?Q?DGF0wvp5iYKZ1xGsIZ+bw65Ib1pSjbO+C6Pks60RS5GqSKapzOcLUCcAG6Ay?=
 =?us-ascii?Q?nAIxOVyk011r7WhLFFdJVBjCwEW+8kF7C4Uaqwc5ehxRzlBaSFQoot4dqEVj?=
 =?us-ascii?Q?qRMW57wetDzTNQxgpZIHLhzlZNjxoOMg4qKske9zRbyMP8Nj6w2Vh/OWQ9Kc?=
 =?us-ascii?Q?wp5AFn8P/qRQ0qNRK0wdOFQyKaTBggUJR1UKnQByUvqoCtDcJJIyBZirzdno?=
 =?us-ascii?Q?iob1Tj2NC//uR7HKVupxG5rsDlbjD8HL8/C0OfuJYULDEXIDtv2u52lBmQm7?=
 =?us-ascii?Q?EhKu9IfCk74fbtwcIiG5AEd1tQK73/Ms8+L6X7YtaCrhdH4bRoEwjkNkDuIL?=
 =?us-ascii?Q?eJn7NuNIDDLcSdp2vfLdfkw1P5BsG1FrANHrXL1+KG+mxygYc/nPM6ERohNW?=
 =?us-ascii?Q?dPcU7KqZmRTT4Xsr8C98pm6PItbuvtg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oEybkPbo3dkeJiWC81HWlMATJcuybmTfjyIgQFtIl8mqWJQ98OZ+P28O7NnTVDenUv5PNFjBU8bT/mjBuZpffnjF1v9wrYT0moApT467CD0jd8o9P052E/Y6O/brnOTyUAYGKEbx5bdopX8HK1MxXeNliP55mapHowUH/K6txtP1h2k8Ifg9B/LvrBwDSX8SXFsnAYXzx/kULMdgbBeFtms9mT+VJSACIOcFRRvaKDIAZCFBz2V8y8ilPd4p+Iz0sEDGliTewZO5itZcHYlBqpSu9nkliXP4peu10hltbV1PqF7zO1ktbNWHz/3+YwP3oGTHxnWdD1mYnIScEJBbqtALZWAIA6p2SjlJhUw39Ufvd7U69mjoiVBZSa2Xvd/xhhWoje4UdeOG6Qs/DMzVlOF/N12Kv5bV44riJqhT91jPm8UGwdJgvHP9J5e7ULQq4rbSiZUpoftqsvD5H4BPy4nXgTtNvIxn8SbhH0XBuc0PzyiSS3YegScpU0uWTQT45TlHcHS6guH2HE2LpBY2SrsLKUmjs8aSKdAoMY9SK38QDCbNW0Xb4XIlqPwI21xA/5QISAwTBuX+/txzQWbl4rVi70tMLIqvJ4XkSi7eiB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e45982-4a07-4aa7-5225-08de4fb22957
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:06:15.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPf6dzOGnPewdF2xEJSrpvshFt0VlWG+fEu2vkhZqWLXdJxb3nlxdo53e46GyEVT45Vv6Kwd169reXm7RPCdV449kL6K+l9LLgX+AJnUcoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601090148
X-Proofpoint-GUID: kQ_qqfmljYNM2yCTuLmdKW5Rqq9uldgm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE0NyBTYWx0ZWRfX/umgY+nEjX07
 ZGUZeoI/emZiBsuWg3J+vkboeXrxWuONi35oTWzSIpvhNTtGJMs9XnxZAN4gWccMRZN2+1IUprf
 XTl0AtCdGEkk3UFBH/HR2D9j7jlVeabyhLYITD3lLQCK8sdrIp0PinfIjM77CfYPS+PiGPfM5I6
 tj6wzKzaJPPeAz1T7qx8PT7CxEvWhxVMM3+lSzFRX74g9QcJHnv/gXR8JRDW2QsLsDSzwPtnpir
 /HsfVVaqy2SsrxDsjyvJu4T4d4vNRDRVJM6cLAjACKRLPJdyI5QRmiJVFTWBEspaIQbKQ7sG3vL
 mM2y0zAZh8bJ8tgINrduKVMuwVOu3sTNlFR/+dvC4nOkZ8cw2ox9ijGsCCevrp/3/wnxthUMyXN
 51WXAFWerOMe+d6/QrtHil3kJUWWdlOwyss2K1N7LTpSLavkJbQhULGruVyYBikBkGEvX5BB0Sj
 gnLsIKpvup7SivR80RRyGxodv5G1CUV7OB6uIK7A=
X-Authority-Analysis: v=2.4 cv=RovI7SmK c=1 sm=1 tr=0 ts=696151ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VGb6wELbmpxW6DPwO4gA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: kQ_qqfmljYNM2yCTuLmdKW5Rqq9uldgm


Will Deacon <will@kernel.org> writes:

> On Sun, Dec 14, 2025 at 08:49:14PM -0800, Ankur Arora wrote:
>> Add atomic load wrappers, atomic_cond_read_*_timeout() and
>> atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  include/linux/atomic.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
>> index 8dd57c3a99e9..5bcb86e07784 100644
>> --- a/include/linux/atomic.h
>> +++ b/include/linux/atomic.h
>> @@ -31,6 +31,16 @@
>>  #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
>>  #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
>>
>> +#define atomic_cond_read_acquire_timeout(v, c, e, t) \
>> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
>> +#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
>> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
>> +
>> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
>> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
>> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
>> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
>
> Please update the atomic_t documentation to explain what these do.

Missed that. Will update.

--
ankur

