Return-Path: <linux-arch+bounces-12478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0CAEAE1A
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 06:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2B84A6B26
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 04:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6961DB34B;
	Fri, 27 Jun 2025 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KiqQFgYj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bDQCUmjX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58A1D5CF2;
	Fri, 27 Jun 2025 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999754; cv=fail; b=qqEfr6vg230xyCDCQA2Zb5v2xL1A5HJFLxgG3c75AsUMl7ooX8cXDug76rOMvJ/QLZXjnKX13uwkTQsHl4Rh+TwNdhEOZ6/iiSG332V6OFUq4lt5Gth4+BjI4/YcenFKL7/4tQre0eg1YQxMpwM1TSRtcDAaY+LbBTaUuzPqNoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999754; c=relaxed/simple;
	bh=zoXWNZClcGZN9CCjFUUjeayh+OyPjiE557+NiMfxz3s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GIoZ5Jr+G+pRqv/nR+kObT1e2zdk6bWGxa4+Xdnk/ePlFfK1j1fpK3TQHstnA95m21rNVUC1JRHqdZp7D31XeyjtHhxbQW+mtuIX3Qt7fMlniGSFenxB9uEbsPm39+odWQ37V4T1xKeQLjAHjroPJdtCmUUbDr9/rb401BE4Z7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KiqQFgYj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bDQCUmjX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFtijK013718;
	Fri, 27 Jun 2025 04:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=LjucTprz2Ul+Ygjx
	EHJsmZAgGWBZ9twgceAkY8xWhUg=; b=KiqQFgYj9YzAblAhfWTswl8LH5YvHW6A
	f80Ue/kHbohFpsrVwEW7QBHwq6bYlejE9ewsg7GFi5KdbLXagBYR6EYaI1FWhTCC
	gNdycfKLM9zm4djoJZe4T6qA19OA6dr1jCTTPYCaatx5q6AB2AUF7KxZKb5OqRif
	BYLsisUgiyZr4bMuodO1vSrD0TUcC6229dEW//TDI0h08g3RxeSzKXMETIrJV92R
	8V+gr4tN+j6B+V43uchaljK+zoN00tkFXTYfO2AjIbxJiBbefrjIAHXTJWzo1fuo
	LdO15Bpo8iHg5Vzu0Vo0Moko18+wKiCGVWwmcVb78Ieuc/YeR0I2wg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8n325h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R3mtnR002627;
	Fri, 27 Jun 2025 04:48:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0gvt59j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJb5PqqDVyDWO4piXb1Ny06mUjpYGZoQb/eACjE1y1/Gj7XVi+/4saG/TbtAB2wtZp96nWSKzeMd5iJ+gSO5eUD7LxKAx9JnbWwKXS6YMre+wMuoNioxMgGy8Z/3Tqsvm3uzLuKoZqXUEGH85cz39e6s5/43d7vhg7VNlaz3ePeS/870tM1w880fFa7T97J8ZC5Dw3PfzXK6kodCxyAkgx8JuWMk6EjxeD7sSwxofPX+s1bRXQVQ7+QkrYTf9LFVzPxi2bW2OHffOF663Xk3gNhi7nAax7B/2Yzr4gJqgBTGrIpsB44AbjtBXPSjZBtRfVGf5SjkG9fKsVFdyZ/wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjucTprz2Ul+YgjxEHJsmZAgGWBZ9twgceAkY8xWhUg=;
 b=T/wCAemdggA58UK43F0ng5m0Csd2izE910uYiT4/4IJsrda+1OcuSoaooSMzNwr5iQ9ZOIfI8I1vj38oLZon3rB7pK4EZvwlo902KhTpA4HScaXzdQFzXKBDmlszuQxAdykvHkNZq4JQswv9kwNer28thQJhVWU35rXxEZU43cBq2nLT2NAFjF+bgPVlpPmBXVoHAkHUUCs4aSk7uzIaSht+ZZZLjr8F/bht+NbZF8MlVsvOoVFONseBn2bd/8m838pL3Za/7I2DoJ7WM5waVPhqKRQ56/Tnj0EjIz+Rb00B7/aCypgQAJdk+gS0d1MBafBELtRL4j7HiM3507JzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjucTprz2Ul+YgjxEHJsmZAgGWBZ9twgceAkY8xWhUg=;
 b=bDQCUmjXsHuVLIA25dChHkwr3ve4burFFgyC9ZwVAvfZT36bjoykXMDoKj9GQc3SuIjT8lkRD1YeVT9xsdmBQqCZdN12TFXpBOhEKuSn6Ld4FmOrWiIghPT2FD+ytBCY7iUipfEaAjWX4bLyIkiamfnnGmTT+3y6zIoxEUbwBS8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 27 Jun
 2025 04:48:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 04:48:06 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v3 0/5] barrier: Add smp_cond_load_*_timewait()
Date: Thu, 26 Jun 2025 21:48:00 -0700
Message-Id: <20250627044805.945491-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: d9950ae9-433b-4a5b-38df-08ddb535ced9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mn5BtebFecV8g8+dRGbSDuChGrN4f+bnUnEOhuuHRnE99+1QG/YWJkXDL6Qv?=
 =?us-ascii?Q?Qz9nDSU5B9w+1Q9831ubfiaRp+fdiUICfV0os06QC6bwv2atXF/BZhj2D+gL?=
 =?us-ascii?Q?K0MaGtj6iEMaqhQS9oUemO6SjxWq2iLo2rUpT4AOeWVh8WVVc8Ac42rh2r1e?=
 =?us-ascii?Q?IfZv24UCnYwDr5feWAdREQaY0/JOkri37u2C5uPFEzPUsQmcIIVoi3iFRmC2?=
 =?us-ascii?Q?PC3OvJoF9//YwVw46pMraNzKTm41ahfzAPbEPldV6mJpZDSRQg/L4BxxUqxz?=
 =?us-ascii?Q?MXBVPeM4s/DjRnSZHwqDeyS2dMSWi7sQ3eNrxC9KigYBZ4WGdgUbzazbXeTz?=
 =?us-ascii?Q?YbLiE0jaIi3UIU/Rz+vG29L5cqtRKvfl1yaJhJms+uzi4ck/mJOwMqM2omgJ?=
 =?us-ascii?Q?2XDaJbNlrl0yux1syg71s5a8iBhKY4HheCjiQkcUUS7e8HR5b8MUa9MVhnta?=
 =?us-ascii?Q?2ZZsyt5d5KyDH+7E0WlIl+6cOB4CdyGbtZBwoaKqIn7Zf1g9bA0RBhN0++5P?=
 =?us-ascii?Q?SjYHps//npKWpzH4MpYQqh9e6VWNNcO2MhgigHtqtnFaeMflyxpmZhkehN/N?=
 =?us-ascii?Q?kIzGoyFRGe3tNo+Mrr9gcWE/ox3f+Ox1LRyqoyRSle8pVr/xoofj4bqk4FEr?=
 =?us-ascii?Q?W0Wc7GefUtGjnguALZw0IW1qS4qBOsjJlYESC5h54eZt/FntOk2r9+TBiwGH?=
 =?us-ascii?Q?LrWJ7/nau55Oes4ahqiJxrEqqWVh3HyWpns7DI19YAa9cHrQpx/y3BaOZI/b?=
 =?us-ascii?Q?ZygC47qX1jnNUJEz26e5l7FBuUXzYEC+VxIFxCeGoNfLNIHo3vk/RABW8i1S?=
 =?us-ascii?Q?QbpvBTQkzNDuUxAL/ZNJ/6r4wDOk6oeHT27UfRwKLRNByLANJxJHX+FbQ0DS?=
 =?us-ascii?Q?UT2VYKduwdFXffOwA9WC3aaAjzcmW1Jh9ImB3rKdm4W1UXAb676fnZMSd8ud?=
 =?us-ascii?Q?BIi2s7VyOtGwa8q8Ajzs3e/HkQVYCoQEdAom5pXrIEN0yAzcZa0QIT+EBCpn?=
 =?us-ascii?Q?baku5Nmx8ShoEKcEVQ68aSUmcv0au5UgTyHRUG3r1g9ts65jc9PEwlWzz5ZN?=
 =?us-ascii?Q?5shonVjYbHozAMujm1sZTGvTOpEBVEryFvUX6WpnrNHQEOOhYw7SvidBi7j0?=
 =?us-ascii?Q?Rn8PbQlayNUsxASP/SVUFCldpsbgI0M86JJtKnA3hq9cEZceWRL66I9LjIYe?=
 =?us-ascii?Q?kV13JXYCHQQ/kXFj6jWqKz24Lbb3PW54rwsfkmysoOWEmRhtX7Xh5N6/z+lo?=
 =?us-ascii?Q?lhcLU1toVeDKto44E+1ZJRFsuootwD/zLCk/S/F4c3/AQl16SSy/JHE9djYX?=
 =?us-ascii?Q?VwUqpUtPB1wbpkdR5kumR59NkOu7jvF7LOC6pbtawd+PWEgKP/8HVDit4PX/?=
 =?us-ascii?Q?XNBTvwCmH6g8RjZGseL+Yb1ZQUCv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Scb+zyWe1VUoYFcQBho58YATGbwjXDlnI5b6Ai927RhFnpqG1F7EoBZyzun9?=
 =?us-ascii?Q?SpLwsWW7N6KMa1WpbVXGDEpuX7vtlohllr9NXskyKUFxG4/ylhYSuDsjKskM?=
 =?us-ascii?Q?K1lL1Kk8whqt6CPOTi5RnitgQ+go1yPeXxNa0kac0GB12GNOvnlJZXLW3cNm?=
 =?us-ascii?Q?NBbhWARIYur9fJU1y2vaHHn96NUsDtBNd11EgT6vhwcZR/AEIJvdhE/blF1w?=
 =?us-ascii?Q?UsUSyyLIAPIvl39mPz8+6Cj5pKe5W/UL+BcMpEqsH3R0jrciwzwG46sfBPYu?=
 =?us-ascii?Q?2QYPsEdgaHkfQr8WhplHLskgatmCjwwhv2jjg71qzuscf/xFIEk066VCP3fq?=
 =?us-ascii?Q?cz58fp26wkSku9v5jpdxushaXIN7yAc6Z8Oi83L6GKOj+6X028JJQiz4Y/4Y?=
 =?us-ascii?Q?OfjTnT0Rao/DEKABpyI+hihJ3fZ0CEz5B5X2+zL54WkRTDaeSp2gRxFHOPAN?=
 =?us-ascii?Q?RqWC0rUttUTXFUYin222TCVf8+rxSzIIrVd/CqmeZ3HvKGONQOE/9Ctg5h8r?=
 =?us-ascii?Q?1Qj9ZL4umSXP6BDxFkzm3IsbwPnnVNifdvJzM3DSCeYrp1+ARKK5JAe9fYaY?=
 =?us-ascii?Q?hXqGAwxp5J4WZjCYeYSxUiMoXeZ9C90w3gyLKE/Dux8763+XnhGh1yz65u/f?=
 =?us-ascii?Q?ZUB4iBED69wlYE69qEMzp+hzRCj23oZBq3oC2EiZEis8gLbElHwfJuWI580W?=
 =?us-ascii?Q?dTfcvJdyXTKLGJu/AeM0A2rJZaYYyS1gFE4TQa3vqvdczcqiFPD+hyALPEGk?=
 =?us-ascii?Q?MPys56dikAw2/Z7jPKK3UDIaZE4ppiZ7jUAee212VqIeetnxWciGUYfyvCnn?=
 =?us-ascii?Q?5jHYKHjDvsYRzUpHOvsBVZqKGIEc7kXfEP8a1PNZc56Wii+iJJCAqn7khJUj?=
 =?us-ascii?Q?rP5fhCwi1iEzss8vxlphCGXBQ1DLh8UtgTw83176DaZYe2mHefPEQq8911ER?=
 =?us-ascii?Q?+pVRy7+fYmgMO4W3zGQsXIDLW7HqX4E4f9sgMFe5N2SXv9QKwE9RE66DuI1E?=
 =?us-ascii?Q?6UjH39Cet5ZkVI1J3X1F2uh5KHx7nNXwSUDwOptgPlIJsFo2YoWFykqpU6Il?=
 =?us-ascii?Q?fefL69WjIDg8L1AVoV+mxBEuauJyCcLvghOwd7yWJYGEea51qcXNgknIS7EA?=
 =?us-ascii?Q?uTtM7ksKjmVf2XbtgeEe0+dqRZ5jtMf2xPWur2C4TWjRHB8IYa3KqCcbeaWG?=
 =?us-ascii?Q?VZc4P3FbDdAnYDCpyV7n/lCa50NKdkIvisbJP/LswEkrXBACZUvJwN2Qpm2O?=
 =?us-ascii?Q?UvY/reGoNdl16Z/Uo470zn8gt5wKHdEdYkaj3lX5l47aJcf08YtcMP4+a6uF?=
 =?us-ascii?Q?MZykIEsts0/TuJ44cwi90jxIzw/bKJP7/p5JU1tpS8NdvUUyjf6xAJITjuqQ?=
 =?us-ascii?Q?SmJ0SgSECUftlAPD2GhQz/YhBqwqOAL8E8RAlqQRm4Sj8IobskyXFHfllM+K?=
 =?us-ascii?Q?/O8l8kKtJQ23niDaG32vl2JqjzmCdefZ0p+MLw89JsqyPt394usHJWZXM8fM?=
 =?us-ascii?Q?gcyPFO8r4oJ//UIQwISzBj4iD2UmNAxTpH4c+BHzp+G0ZRfP/tO5qgJABhNf?=
 =?us-ascii?Q?2PDuSnh2AXbOy3EOhyTnMsvg72IXDodobe6A/eOH3eSZYlhNFoHG4PKdoaGd?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1EF6o4UmRL01kxHbh7uo7iLpWojAeDqfQF2KN8iUWnV1WkM/dl35rvrKDhGJKV9fINmUuNMnuW9l1mLtr0jRegToBOi2gu/nlC0JTNj17r9vhEpFUOiq/A7WiH3Rai/4i3qSSQAd+wX4Y0VuhjDqKlZSIrAwQJn9iV7wDykqGDK2ooctboohd8l7BphtZ5U2wff0heK6RA+5+vLQyAec3VBz8chvwlD254cyFFWsUZOLG1MRl/Ez11esePUUyDaeHpr3S5LuZzehfNOXDHj3O/5h/ivQUuIaCuGSzhYNuo5HU+CswBKcB0Sh22KJLyHkfX0SX2Kooa3bujVGfnUaq0AnG4i/0PbRvjslpscI+f5ZFDJ6ceJMFuR+gQjBgp7ofZE40VfhZTNIWWsL19z4KCYuOgUpRxApiaqePlMzCwu6ISGgDgzkZPdooOfRTVEDLVMXMZuaQU65VvCMLivBf6h7AlalZYPlQWhXI+7yIHMk1B2s2fQWsJXCysYau18SDbKHUJevUFMNyEaZ18PcgwBAzZ/ZLRbbUVa/Remhd4rYUJwisn42e661lxWbWnNoLKvdGEjAvwzpmbn/bTKnTeIfiMj04XE3IK+nYcehD2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9950ae9-433b-4a5b-38df-08ddb535ced9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:48:06.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLMzoJaQvBRbJNXJ413uQCKQX8HEQoCaVq49hDPjo7k5iTG9cpCyR+4yHleKwz5+6kbvjUp1z2hIVpnzvIfgFKLH4yEM8JTCg4lxcso06Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270036
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=685e2296 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=sixQ6WRDSDE1znmn3xAA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: VeWOuck4cfHuiKfQoAqFkg2NYRkKkqGE
X-Proofpoint-GUID: VeWOuck4cfHuiKfQoAqFkg2NYRkKkqGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfX9RifXGMYRnLQ RwB72hwIHNihoCdm9k21OkByABIUI92Pj+VZlRdkahLk/fdLoLEQ3IpKh7GyudoP0LjU1nrPC/m Wgca3mPWi4Pw2qVbECE5MANSHlv9snGUAppv5c/1MvHfkzcJzRSF6pRviYx6HrlFCPg/AtBSNbC
 FskwOhy+AYisKO38s0GWfoRSEGEs8Zt5ITzTqJvUpZlg030MQElVsuEnxMwX6zk60MaJc/ssAmO C8aCgiVJC7SNtKiPjocHd1G6NOFh66+XxnP3IbX57pFlPRlx51fXZkbjl7c7nwv/sN12hmOzeCX AWHovCzrH7biWutr59JnkLerWAOS/51ZXCPqgX4Drhlo26uB5A9x4bufFl8FaSYmzygiKI+J6iA
 iEOG9dgAQmdUAYUxZV/H4OHKCKlTQZ7lufUjHUWnSZDSTzmK/BQSxzMir4wmEZpSB1Mv23xr

Hi,

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().

Why?: as the name suggests, the new interfaces are meant for contexts
where you want to wait on a condition variable for a finite duration.
This is easy enough to do with a loop around cpu_relax(). However,
some architectures (ex. arm64) also allow waiting on a cacheline. So,
these interfaces handle a mixture of spin/wait with a smp_cond_load()
thrown in.

There are two known users for these interfaces:

 - poll_idle() [1]
 - resilient queued spinlocks [2]

The interfaces are:
   smp_cond_load_relaxed_spinwait(ptr, cond_expr,
                                  time_expr, time_limit, slack)
   smp_cond_load_acquire_spinwait(ptr, cond_expr,
                                  time_expr, time_limit, slack)

The added parameters pertain to the timeout checks and a measure of how
much slack the caller can tolerate in the timeout. The slack is useful
when in the wait state and thus dependent on an asynchronous event.

Changelog:
  v2 [3]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in hindsight
      unnecessary constants.

  v1 [4]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic had tested an earlier version of this series with 
poll_idle()/haltpoll patches. [5]

Any comments appreciated!

Ankur

[1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
[2] Uses the smp_cond_load_acquire_timewait() from v1
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/rqspinlock.h
[3] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
[4] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
[5] https://lore.kernel.org/lkml/f2f5d09e79539754ced085ed89865787fa668695.camel@amazon.com

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org

Ankur Arora (5):
  asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
  asm-generic: barrier: Handle spin-wait in
    smp_cond_load_relaxed_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timewait()
  arm64: barrier: Support waiting in smp_cond_load_relaxed_timewait()
  arm64: barrier: Handle waiting in smp_cond_load_relaxed_timewait()

 arch/arm64/include/asm/barrier.h    |  54 +++++++++++
 arch/arm64/include/asm/rqspinlock.h |   2 +-
 include/asm-generic/barrier.h       | 137 ++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 1 deletion(-)

-- 
2.43.5


