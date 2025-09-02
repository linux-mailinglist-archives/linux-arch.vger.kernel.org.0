Return-Path: <linux-arch+bounces-13362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A51B4101D
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97E01B25941
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B52773CB;
	Tue,  2 Sep 2025 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i/17NOuQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kjErZ8m/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F354274646;
	Tue,  2 Sep 2025 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852887; cv=fail; b=JKtBIBOTNGHNB5SfamOyQ24f3IMHD7+eXrdNOcBI51sgBPixZtqC75jCmru4rGGIzQOVZ/VF6Uj4bFQENeaCEyE32QjcAFmjMUaVPpTLKxmuR5qt15OdHSwkQJgAsYmPMGV16agVUmcZa4PIxqLQ6xWlfqyl5rC3bWq8t2O01Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852887; c=relaxed/simple;
	bh=RDHtC58ELcra9Bv8hkJmhnx0rwunk3bQqe/q1woa8TA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=bpyupfo+8pq/8FHtXTfePqxVmMb7RSVpZ2/MjT324PpIagnPKK4p+BVM7/Si449xuF66ppoZjYYvy+9UPtTfEtk6/vOjafuK6PvLoiUExrQhsvfCUT7VOv7YdRGaSLsOc0jQyvi4mGX/u4RTufpHozcEdjn3cnRUzXgtTPBOyw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i/17NOuQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kjErZ8m/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582MN6hM012625;
	Tue, 2 Sep 2025 22:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yuUe+LgnpsT4BFvkwh
	T2vAKUiLzk084qf7yfZICTe0Y=; b=i/17NOuQcOP9ZIYYPGh+5QveGORKlGPKdF
	yEJrYo8qMWp00XlRIfxDET3Q/s6QCj6Lxfu/i4+HscelcuUDIJ/Z79I4aJWJjWtc
	7FO40lTQerEYaSNm+3OYIf3pE2aX/aMHHsABhsbf/9JmaVqORJHas1HJsIZ+ke4k
	LNjfPZUD/VH376Y/Rm/7WXmBoVTz9tuP1Y4IdTod+UEfqJtldo+ogqTYxwFg2k6W
	ReCYqt0tWNO4A9UwekUeRRdIQ6mZFtvLkLHboY5MLVtGWiotHVTfb3AciJshT76h
	T6MWW5K4EYcZIOdC4oH1N6Ngq6M3VwNt1AEoApY3srM5VBJmH7xg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgw4e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 22:40:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582KRAXa040691;
	Tue, 2 Sep 2025 22:40:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr9dvr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 22:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnhgsFtViYBaVJzUpa6+65uGvI7NkXjnMqHiKJibbD8oHI6V7p8ZA7pUFNCSkW912Z0TbDvqF9JIseo7zV1H/Hn87zHabQoonIKsTlVtVpXgaFUGRFNX13Qje2D2Nv5RsE3NFMEheH1kwJwQ+Kv0azcLHjbvPUKyUSFWe7JMVVPZAz0QqkbvDOy+MWxhKiEYs/54DRiuCMlgCR0u+Exns/inLwSFXA0ETPapEmoH8d37T6XUiIFnxP8A0hrP1piVG9UDGilXmWbMgbnB4r3utjLnsouKdtLjaMUG9pvzeZaAs4J3E4Thw2ZEm66KaOp8YmvFRHxVaK5efaIWJv0rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuUe+LgnpsT4BFvkwhT2vAKUiLzk084qf7yfZICTe0Y=;
 b=JAUOSbsVUX6EkHemNcc+Ab9IzJRFEXpKzaFj2P4n8Nwea/3cV8ecIpmlHXs+ctpOsE72VoDxCplffDgeuY5dSes4l1ZKns1xrtPZy+KBDkgDvJRepsr6AXAPuQsL+f4S2oU8Bk07cxo0gq9JYHfoQZXSmBJdrNSgG/RKB0Acf4FcSod9jSmmKsVRFT8ctYRJqUreMhdwe9OogGy9MJ7/GXv+ypI7bW7xoM2xTE8lohxN40mUPiY2dtf880T1I1REktEp1hU3qebutEJ2ZlyhmiYeB4a5fqGTU6SS49SMOq/KisRFIPqGiYOszU7eS6ENnDv6ZDfJk/m2rHfocv2ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuUe+LgnpsT4BFvkwhT2vAKUiLzk084qf7yfZICTe0Y=;
 b=kjErZ8m/rlqtAX9+M8+3IrP6nLhoD2DeV8pYpaFPFy03bOjZxXhO4Gny/iZxfyo1Ci4MUiS01B6QlqCU2Nrtehj4G6YLhu7MiQzDPBRhU9xDVJjVo+XwBmAVGL8T+WxtOE051VLgV8wVnI0KJb77uMsPH4ldkM9fV3GgXb5MhiY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 22:40:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 22:40:54 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-3-ankur.a.arora@oracle.com>
 <aLWHzEAx_-BozA4V@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v4 2/5] arm64: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aLWHzEAx_-BozA4V@arm.com>
Date: Tue, 02 Sep 2025 15:40:52 -0700
Message-ID: <878qiwqxzf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: bce3e047-1ec5-4e94-b382-08ddea71c679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99vQK6unZzMW9V5Y3wOq9In2uLE2Vnjyy+N5fy36V2h4Wwz66hDhbuEH9d3a?=
 =?us-ascii?Q?4Ri2X8Maeb2RA8mMBO4TvqwWDJyE2IWQcI8RtiW0QyDBVWu3IRhZmnl1Sdae?=
 =?us-ascii?Q?yHJ2bQu6hqNS/2g1wZMbi9fuMCfdqarL8V59Z7XRmTspah+l9is1bGMsPHuY?=
 =?us-ascii?Q?xO4E9i+5uqjaJBHdCTb/d5f/LGkW/T42FJfT1F/0JHm2a8RABr1PnIxBwQKn?=
 =?us-ascii?Q?WKBzMC3/iP3UhydMN+Pd1TU10iGEoJrGzBXf/O6JsCLq5XIPLoTgL5g8Evf3?=
 =?us-ascii?Q?K3pXhEDIOak0gVZhttJM0bMt5YghJ2dGEGzZy8rr73L8Dh+9oV3yl+W3UPHL?=
 =?us-ascii?Q?yGfD6FCHaRIIrd0DW/6SElDT+cPAzYl8H11+ibiTh6AMP721tKeqQ0WLYL0U?=
 =?us-ascii?Q?iF1QwPcJK+HZdW9/I1M5f/mZ5mryi4+TADLOuAEzrMuE+29p6BqwarguIoxM?=
 =?us-ascii?Q?B9uxK8872r6dE0g42jHRO3+WQK9FMptk30431lQaN+eGDfw1f4jkAVS0mSMj?=
 =?us-ascii?Q?iriwIBQJrLusLaSCCVnBIEmxOPvUUupdqvgV/j6ZIQoUiXe780H6QU6PfBEX?=
 =?us-ascii?Q?Z1Sqy+4KyvpB+fuRJcIRsyr5+Jc6aJgELA7/UongXAS8Kzp4QR7gnIj6xqPy?=
 =?us-ascii?Q?EpDwq1BR8C6uu54k7HFCyuSyKB3PhrA039QtuMMbA2/tNotYjv/G7XNUpTYR?=
 =?us-ascii?Q?84oRoaOA5OgWWeO2EU1iJ0xOZAX3m27GXYIE8qH++zth7UA9w8YG76vIYMJV?=
 =?us-ascii?Q?JqZXBuiqNmQba5lbkBVk0RCtRy9LooX9k5VCYFoR07Sm1bLyWPjewGD5Xxd+?=
 =?us-ascii?Q?gt9RWO0fxtZGv8jfnFjNAxWGtYPJg2pjHH7B93pOsv4JghCFEF2iuNMdAcsK?=
 =?us-ascii?Q?J7YrN5WTgCmSG08pTB4gUXfW+Qfel+iiADT9fsd20aYQTm+cYGqFZIzl2bCk?=
 =?us-ascii?Q?mxLbioIuxt5LG4yB0xnuJ0iBJBP2yRdIIAmO5rt81sZQHKmIntOvWoDxPDZg?=
 =?us-ascii?Q?hKsYgFS+8BxPcYm/LG1USzBipp7IYHFkHz+qi++Pzd+iegT1yYhSNJfYreI7?=
 =?us-ascii?Q?Qnww8bxkBvOMpB/12PN1/Emo5iWC4kVEPO6btXRteNe0ZIEQEnGI+ZTRmhmJ?=
 =?us-ascii?Q?DDJPPhbInwfdKQI3jstp3K6DX+Cpp8W3sVLQhN0lkbHBN4M5dEbGIjb5hOm0?=
 =?us-ascii?Q?c0UI4itC4pEnSZVesGjlkSK2NEGP4arc8kdEq9wzGoT6Gu7MhirdFrMAHbC9?=
 =?us-ascii?Q?X9F6eXGgr+BtsLRJJr85SiU/ip9ghv3JKwooZt0eiW6p/FpyNdEIWZxcTOFM?=
 =?us-ascii?Q?FVX7h+YV9mKEy1WfgwKpJ18mjhlkol0LORQWk0RpX6BVEljohsxPB8MqBMjs?=
 =?us-ascii?Q?tjVqZ9qaOoujUfF91DKjmhJMtOeEKn5u3dzssbKnKfHu8yOTrUHzxGZ/wu0L?=
 =?us-ascii?Q?jcm4gwxKEB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R+G0Ub0hOj8qnQHSC/w4sAC8YepG50y21ZbRTzBzGtsyb/Xe6L5c5NGfVyvV?=
 =?us-ascii?Q?XOSKx5M2iVredJSIaDMGxBnJQ0SMWf39NR0v2bnbI+F02VtRS3qJlWJK8E3m?=
 =?us-ascii?Q?hE5C4frBAGIYmiKMN3zZsPKufEK/PnAs8CeV0ME3e0JSCI1lF6GeOGbydz3A?=
 =?us-ascii?Q?1RfpEr7K2KEYeQBUqDxaNTF/5iE3EqKRwVnYh7nXPSGjKJHVGkdGqc7E9ioI?=
 =?us-ascii?Q?KEkkkBXb9Nayknc+cbv3YcMek6VZ/UpKwUH1joAODALnAWaH6OY020erNa4R?=
 =?us-ascii?Q?6DeIqFp2Kt3VGolPKvRFFiSPO/BZ8aRBT/Kk1XSPS5OsrXUpAp4uoPSkovXo?=
 =?us-ascii?Q?PywyekIXoONhPUIK8+1uh5btKW/+kuKKHte0hnclGn3QtU+ah+CMohAa5oBe?=
 =?us-ascii?Q?6/Kvzw4yjem4fwZA39d/B/Bp1fDd2dc7Vr3dAktbKYDiYvC/cZHf93msDR+G?=
 =?us-ascii?Q?bE0EPxGbYeVyMNOr7X8ZFe8urhJA7FgvBPgNDKvS+k/Ces6SrcxSwPTJVkZS?=
 =?us-ascii?Q?cvjTJN8mttUXwSlb+TZG/MQFeIdwVXymI4HtCAvPbuqCBSzkFRFZJulSsGda?=
 =?us-ascii?Q?zXnab/oiIEDZaSQy3akhFnMHB9DyNrPFLdqbXhkQG3x2Y6f6GflvHr7cS+mQ?=
 =?us-ascii?Q?xXuSIy1IbchtfH1UZ2f1rIsGlNZgEDgISwmRlkOAPt5xwXWapCgpONYYyozE?=
 =?us-ascii?Q?LG3HiKn58LVpAzohZZL2ZtTycFQUjGAmEMlF0nUiBODxkpb7TFWhrFQekmeG?=
 =?us-ascii?Q?k9HTx9muEzjboEoLmJWQGks5Ee/fJ57KZ+Lsv8O4Mx7W/GMQQRs9+C9HhOJS?=
 =?us-ascii?Q?vUzsIFr5y9ipHXp/zQT/MVUZo0vd27fIH0P8U4CgYJddrerkDROb0FrjK83d?=
 =?us-ascii?Q?dQiMq9IzijeivUWy4gpJViEdLipsf0oytDNkVKhvSshIvzy1zNkGCs64RJn0?=
 =?us-ascii?Q?Eqsqoar6xPRzxjkDEfI25QkPXcQkZYaJmQ2A48Jgb+/tLurmt+QbKfay6oi0?=
 =?us-ascii?Q?FOzwuvMkq9TDrbIOm6x9GJGCCnpQqPf7FQNC7oXVOfGB4AtN3y3nLVdUpW5K?=
 =?us-ascii?Q?VqvJYrAHWMpIrJlsjAPEsO8nkASDuXOAWekMaT8wkY/8yhXWkOg40dUNmoN1?=
 =?us-ascii?Q?LNOcgmlnJw5qskIBllOHt9HQgwYN6N0DKmqnLzPsVkbQsC6rEmSebOXkqcSJ?=
 =?us-ascii?Q?u4s2oK4XB4A3U7dPDZd8t8UEj4jzfCMYkeEYeLJbL4T2jbafGkOTUxcC+AE0?=
 =?us-ascii?Q?pqpJIHKXloYE801qijMFXY9zMogdTIayeQ8TCJ4M3yg8YFbaUWRT/199UpCf?=
 =?us-ascii?Q?/sIM00CiikBOghWbrHdeOAcj/lPaNKvm9I9AdZMyZKKSLNdTNJRfM8Gv7ZOG?=
 =?us-ascii?Q?IDriDY29z9tGriz/usN8yVF8ni2ZHNyXNujusky55j3CP2TBIZINs3kCt//Y?=
 =?us-ascii?Q?iZsTdNwTYCH93m7U8pZKyQFNOmzXI2I7Qa3/zGdDfBNCRkPtQaTtXAfyD4Mv?=
 =?us-ascii?Q?2KuyDVX1Pe05W15Hy/uxwIfzlSKHIwALwBeImzdZ6cMtztJTfBdpfQXnCnn0?=
 =?us-ascii?Q?ubaGzGOsCBOUvUPRyjG4uagOBpGfSb/Ya34Wg9qCUXUIREKGPUG4kNliZDI4?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XUcy4JRWtX5qFxZpo8DU1KDMbCC4TdDgrlv/UnQqqIx8KluKXen/Cb33rZ87eNMtTVRWzH4Kp+9UmOXXsmd/uckhdx7ICUywhYhXhAsLHzSDhYlYyBvKdtnaGw3w6+rkSV2IWcqapLYXIaztqzCV6rWgUbUMqjIQrVZSjamwpX7ekCSyvylE5PuiMtZT3HCWYuvTZrc19BF3sMvij8aT0I9PWwC+4NPh3mD5vg6h0Gfo8w9VO0+mLtuwVUoRmVx2IRHH4QhuNuh55SU64KHxG/e8sRqzHR4eUsZtdOCSdPYPXvsJTiTMmPU+dAccpP80FX/wAnwgLjCZsXNNqwYnsJEC/FthMR/XfyjZOi+mZRjN5z0Oflgax0uO+IoUOw0h0BUyBk+AQ/CBwUbQTMwJuuVtUqqVsGSqE3md1TD5A2BtZPjFUy0bVA//KBZQEazK+9sORdiV/GkXTfhNWpElUkw+nyf3AovoHUKhCzkHVRu8sbI+Calo0vm5IWbRWnOWmkC+hnR3UoHoh9L/ICNaFD+draz456quSEbMe/nCFaDq0f5jGATnMBu2KDDTP7NeBMFFaElIGRXAEllAJquPA+IUcGw6CHqkE1Xi0+59NaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce3e047-1ec5-4e94-b382-08ddea71c679
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 22:40:54.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYKfS96d19gmnMwlrPtEo2TNhqm71EjcK//87ClqoavhkLKz3mnjdKR+pZ+oLhliyC9jfbGZ0QbSgtkcFcxbMVIgvZNWTRworMrStvJUH0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=880 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020225
X-Proofpoint-ORIG-GUID: YZHW1AUoPVCV-EAkKANxLDqUhvSCJhSb
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b7727a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=cVbU9XGiCNqCj4wCCpcA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7t0ZTNmbI6WQ
 Be6MeJ6w8TiUNVj5D1AP7DMZpXd0MV32yYA+3N/z3H577qnWrePXdwTmM8ITvAnhxdJjVpujbKW
 c/APTeDOtEAvIf0bs9Tox0W0ZYelAvoC7uCMJa8UioV9R2Afz3fASbszRS8y5DolSH9unuDmag/
 +Y1L34yVVouluzJ/0fhIVws8bBpJrKSVGjtHXbxfcMQ3xjQ7R3kV8HkykGBGgu1f+TKtgNw0euF
 w9laFd+k18hdvgmkB5kCXAAzBd0V/0s6sPvpBGVr77wHa6zrA8FIek1zgxC6JhnfECX7tbGp2HV
 Z2by0b7wkCiPuMiM+zD3DV7oVRj9/gXs5Qz/EGtk2/+3I/mFdtt8xzrqyXULG1xYzKvBx3uIGZH
 S1MaeHQb
X-Proofpoint-GUID: YZHW1AUoPVCV-EAkKANxLDqUhvSCJhSb


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Fri, Aug 29, 2025 at 01:07:32AM -0700, Ankur Arora wrote:
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index f5801b0ba9e9..9b29abc212db 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -219,6 +219,28 @@ do {									\
>>  	(typeof(*ptr))VAL;						\
>>  })
>>
>> +extern bool arch_timer_evtstrm_available(void);
>
> In theory, this doesn't work if CONFIG_ARM_ARCH_TIMER is disabled,
> though that's not the case for arm64. Maybe add a short comment that's
> re-declared here to avoid include dependencies.

Will add.

Thanks
Ankur

>> +
>> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_check_expr)	\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	bool __wfe = arch_timer_evtstrm_available();			\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		if (time_check_expr)					\
>> +			break;						\
>> +		if (likely(__wfe))					\
>> +			__cmpwait_relaxed(__PTR, VAL);			\
>> +		else							\
>> +			cpu_relax();					\
>> +	}								\
>> +	(typeof(*ptr)) VAL;						\
>> +})
>> +
>>  #include <asm-generic/barrier.h>
>>
>>  #endif	/* __ASSEMBLY__ */
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>


--
ankur

