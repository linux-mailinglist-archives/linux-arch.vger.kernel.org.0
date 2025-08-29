Return-Path: <linux-arch+bounces-13324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D6B3B586
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34B69873F0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA72BD5BD;
	Fri, 29 Aug 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="na6Eql09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vvNYZHzX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2261296BB3;
	Fri, 29 Aug 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454894; cv=fail; b=nQkJgiR2bZsAyFlr/sYLf/rZHjq1aJZEneJXYWeQz2E2kt4ozf8QCGdQbbdWHaU7pNjQekZbxEwpm3D3UCMIpK/ETFCY5tPpVfuilLQ3wR3OhQUPgcZ599dkJ2KWDCtksukK7CS63D3U1HilXm8jBjuGcu71MdlsQJjpvEcwpqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454894; c=relaxed/simple;
	bh=M+7UxqfePaj88F4bea6nfIHsRNFXUTovbUOM32ArhAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gL60IB6FOr+CaULBVyJCAo4KX1Xh113nkvszwTkFdrCXu56twLN0yGSQ1FOyEkXXwIveV+P6LLCN9+xuTmH8tlJ6BsnGZQi4pJPGLtbjDwYxagnjwRSZKdyHqJIsata9WitdW+zx9KYWI+Puxm2YJUHkkhyfpFFRheZYkMQFf0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=na6Eql09; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vvNYZHzX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T846ax009457;
	Fri, 29 Aug 2025 08:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RrwYTCMj6ocpF4FW2OoeU/4/CqzwCJFpaFBTchbimhI=; b=
	na6Eql09rdxLWopkO5wmdoqHsZwLWrX7YMxQaSO5c7DsdFz2ywP9z0NkJhEXLzPI
	X9jfSK5p76D4w7M1BfnU5vJIPBzEbqNjX8j3Y01ufuUsOV42xfpCA4R5PsfEdb9F
	P1VqggLpwM3QhXvqJ2cs5e8Wqu5h+/S6Q04Dl4e6Ff64uhQr7yPW6CBGU0PlidZ5
	mLhcbfiuTDbx372yP7SpeD1OUWJCSwAL5XCjqGOrxUEMIHwygdu8lpSthcdKI3S8
	AlY1k+ghA5IFmbQk50VWRpn2r0MCVsPfR3aolRNG3kw7kG46QSrdMzyMkbjQBrRA
	GcwQ567hQkviuej5hHrg8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twgqk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T853Is026712;
	Fri, 29 Aug 2025 08:07:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cqp0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+ubBgEfWZxOlZTgViIAdzc/T71eBipnxn9UEID2JXWx5OzPMB3kJX2YpFR9aYMHbRkJqRMN6K4KY0nIcpOU52LO2r5Co9qvcncULmScx+J4qeR58LaVjjNuQXZ/EMQgaLTiAqwsFEGewn89AHbl/0QMXe29LZe1rhDlrYsQdE5prrenaLSaCa+uC9WR7X0L8dsnWUp1Vv5dyV3XaehemfqwuaipM4Imqttv9JuxIAs0v420IH8bdqD50hb7ZToLZ/1sxfy33NdtKEOma7nNu3OrPYWpxUalo3d1ieeXIL/somyzE/0G9YxYNLlKMZYOtPqQF3ANpnLL8ip42OacnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrwYTCMj6ocpF4FW2OoeU/4/CqzwCJFpaFBTchbimhI=;
 b=XzSK6dClP53HTiFu5GxWcKDKE9R/AVWRz44PQk1743EbXADbYD85U09yXl5+Qe6BI7MUqgtmtulifNDfU3l+XqEC8K+++4kiGd3+rEOyZ0OSK34ptEK5PpZI8jm0SgpWfVwzsFOFayHnPbMs2+K6hY1FNfJdBoFVRRghZAEJLVMY9j0BUkic7IcsfyXnAgeCtCIMKFhsiBdKXfCKEsq0rr3kud7waQnNMd0dXN1qNbDip+9U/wUjTjA+nPXIDidjai2vnDnMmK8iIIktvCOHJoW0ioNbta8X9fcxXu3gP8ZEDIgBIRrQvSjJaPVFfeW5cNGH9ZHUTdzB+AIZIY3lFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrwYTCMj6ocpF4FW2OoeU/4/CqzwCJFpaFBTchbimhI=;
 b=vvNYZHzX4UxICiePqMC6EJiqBOPQyZOcLQ/IZDtavom3Lejz0AHsd4pJjnoQRsHuNHEWCfUuu4QON9uSYc4iOPMKDzmbPwM04Q9HYLjnxRXiAJrP4+m4/hH8imKMBPdMBZIrXE9hUaSz0Gs7C5lLwUXCmoE35MZa+xVvzNIk6TI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB7490.namprd10.prod.outlook.com (2603:10b6:208:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:07:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 08:07:44 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 3/5] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait
Date: Fri, 29 Aug 2025 01:07:33 -0700
Message-Id: <20250829080735.3598416-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1a5a69-70cd-410f-0fb0-08dde6d32251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYpbrh2W4kQRzpyRCRbGbP7Qxt0gbZ5nbwn70+mm6iMgVnV0ywvzKKxgfIYM?=
 =?us-ascii?Q?A16ywPPZNpD+k7YYkayCnhyRYIPH1tBO03Ig5/RX4K/aQaP1Yu5rjr6looCl?=
 =?us-ascii?Q?cfQkqjZXGMqTMFWBfLacfGHL7Wxg5YEWCZO4ExX7DSkRjCjlXuJ4yXK/RhtQ?=
 =?us-ascii?Q?9W+CxZWl6e7RUHsxazPx/ig29RJY0d6ufem1Lcq1qPxyr23U7CySDiurhcig?=
 =?us-ascii?Q?sGFg1sQ8HfWY5hzHrt+9hEHsYTg5CWxQUrA4EZPchxi/1k6PNGoPKGgwiK+W?=
 =?us-ascii?Q?NO8n5EB80nUaphNenGUtX3H8UR7x9L1zaybgug2wPW98VmVviCu4dLZYo+48?=
 =?us-ascii?Q?5QfZ7/XchTQMZTxgf7h6Kt8xhw5GFwI34MWQs2lymaxIHyR4yO1FfP+3B5tj?=
 =?us-ascii?Q?k4aWOOwpLDsHh/DPvsr4W8PkqacK0wctGNdvBfZK8JsYG6IlC8w+9mdGz8l4?=
 =?us-ascii?Q?vsHQH8vMoJSWA6729fCBjM1iOuKEtQlIipUcjwiO2FfyxWue8+JmFwDbmmIE?=
 =?us-ascii?Q?Md8ijeIFyjugD/HpDInZn7/0KfQmJ4fxhQX+nNiwvbgoPE5eHnjqfam6V3xv?=
 =?us-ascii?Q?6fsoo6fm50ciqRXF1HfVjpyWna/lb3kCgNZnz3pAfxcpMvLYPta9qSrbq0wL?=
 =?us-ascii?Q?CibaISp/WlRyrs2fh6hx45nrGBtkHEGQGRp/9QVwcp4OAgUvSofT9rHzaOJy?=
 =?us-ascii?Q?z6XEhR8rK5qbytrSm/jqK6O7e1x7aiIJFCqFbfNmlzVLJyP0svDibgXfDuW2?=
 =?us-ascii?Q?/hqH+AYWxTL4MN58k2IeRyegQ1822wdHpJFxu7DtoDNFANviPDy5TxhnsvC9?=
 =?us-ascii?Q?fiqD11Ra3KR+si09/Hq61ow/j8hEnRHRo+DUJSqj+rGU4A9PoLcmL607RsXn?=
 =?us-ascii?Q?Vd4pwdIKuClj4HyYAyQArl5DggswF5eNfouk3LDY/ePWHV8Ky/HTF2uaYima?=
 =?us-ascii?Q?Q132SgwbAwqB0rjqrHuVgGtyCTFVqvLRhhFz80luzkmlGZpPqks8DNG+i3ig?=
 =?us-ascii?Q?2ZD/BbaLXUHlslXx623oqsQ2KbpHt9aYDJ1rTmdGH5QIkRrUoXXUfOYApzjZ?=
 =?us-ascii?Q?8MccLPKwugbWHDxO1PT20yl16NS6H5TymnN92IFSO0kx2AwN5aq9hrHSx8XS?=
 =?us-ascii?Q?DLAMNZWQoJyPwILo4HXxc5G/p9T2uKtJ3k2Csu5YZbUpgCGrhKauHRoNCbOC?=
 =?us-ascii?Q?DhEpOlPKs6ypHTN04sNjgMReVS+zppAUOhq408w8uE/XNsF+F5cD1Ue5Xhzb?=
 =?us-ascii?Q?8iGk7Uul45w/Tsd/GuWs/jSHrNq/36u1jp0lsSvMkFWUuG9Kh+aRNRnNh/Fd?=
 =?us-ascii?Q?/Iud9x1p19mCE+XblVV4CbqEalCe8X6wtSjCCiOmKUCyRt4hAwMfDoFFmKuB?=
 =?us-ascii?Q?WdA5jCXpDVI4NlVTaAsaNAyhDkbHP82GVhRjAmPiJXoFiwhO8rasMwhONBq8?=
 =?us-ascii?Q?ZdlrYhH6xJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+oLzhKb3oOtg2dOOwZNABT3adb7qZD4g55s36YoOzSX1SzafEpQhrNQavrU?=
 =?us-ascii?Q?dDCyrTpgAqUNZtBEfEp8IKonLYoQcBTy90Px+hzZdJs65kU/H/UidBCdJcCX?=
 =?us-ascii?Q?KLEE6l3SWL0Pt4N9VImTMXHicB0L6uAub9xyP7OA7n+6UBQ5S+hUJnCg9GZQ?=
 =?us-ascii?Q?iZ1CZm0qB0e7u0QUR1gNByvvweqCnf/i5WRhI2rbFtbsgy/zkQBz+PBjlyNA?=
 =?us-ascii?Q?k39U3pBVmkyszwNTpnN6HJddNSJXsHv4VdmN7p7zYqdbQiQTaShVoqIh5Smv?=
 =?us-ascii?Q?YV54GG4YRcOIIldoprM3AJjac6zrsO3Q+TgEg/kDiEJmNfNZDeHcg6d9iTw+?=
 =?us-ascii?Q?Y0R7Z9/Wa6YOS7HptKdCJ6yYlHKvjFa0bZtnj0881XncC3RK4HhMhCmw6q1J?=
 =?us-ascii?Q?/5P0myVhd7UgyxN8gyMWNNzilW6nx3DpcQsAftmbHtJCeYV8Qr0YnghxY4N1?=
 =?us-ascii?Q?iEuDmZPgiET+IBL42fhuI8dkeSFugPXJlf/2ZHlaILtrA/bQWRMixI/tMI7S?=
 =?us-ascii?Q?kpDt9oy2aOc79nt1PA1ROAKqR1qJQPrNgJH7C45pquSPMMeFPYpDsuHZVUq6?=
 =?us-ascii?Q?y2BmtnU618Mdm4bhjWJRyCWxejlrxYkSXRoUWHOazlVTdO7/0RrWjF5eLt9k?=
 =?us-ascii?Q?G/m3lLRl1VkGWDyzKp6GXFrWZQ8VvTlJ2ac6yrHH+mibcdQVP5Q7f7XM7XWM?=
 =?us-ascii?Q?wdCGgFZ3NQQJ5RohAzyQTmi4pxxLDnZE52hIOINGLDRIoRlvoYnKLMG+KeVF?=
 =?us-ascii?Q?XXP1qReCMjvlUUhynjxGsHyMYjQ+gzRMXuDKD+DdrE6BfWotobPH3zhWfLOi?=
 =?us-ascii?Q?HOSzoZXoEdqOwhVNc9umw8xO56kh0/NVAZ95TbRGPiQLDYoaD5LJsaPrqfBC?=
 =?us-ascii?Q?rwGnPOibTRV2+yziU+O0tGNkOudTTyAXghyU1pm1yQiCbVhuEpXtA70ZpXfz?=
 =?us-ascii?Q?KYNvnwJFcgcwFQf+J2ueUzKNXSpdCZft4XoJslI8f4cghT2IWakE53MOSuyn?=
 =?us-ascii?Q?m1xewnJphmvS5Ik51wz4Tm1L8A95qb2D5wJ14xGe1WyDmhFwgK5p/ojpkaaD?=
 =?us-ascii?Q?q63+jAy7hf9it7FWucqsFG4xtZMicTa2HcLj0VY1kos70xrQlYa4/69wa03t?=
 =?us-ascii?Q?KDWoHcSlhwsncse+Hl6YKlPV7FHxwRPp8G4u4/mRa+htxKaLIHK/qkzjHFQo?=
 =?us-ascii?Q?8AeD9PC3HvwsPGcW9jLmh3J5hB4KP1oTUzjsQ1sur/bJUnS0zT3yamPkqxcl?=
 =?us-ascii?Q?YG7msyEeptngtyKF8agQWXe/qMh6qLMJNUvB03obfIduyj8kPciqm/rOFlAO?=
 =?us-ascii?Q?EHTon1xvsgoZ4W36rSovksfo6hQ40EPue+ytOemMmU1jNDGU/2y6kKzNWWDc?=
 =?us-ascii?Q?rSxSujlXdZD9A+kQ19KidxP5ST53WUgeqqDL9oCh2+wmMMyPQl60rKUgLBr6?=
 =?us-ascii?Q?dvYCrgrTnhWkSYsIFQTWdJaCiLZknh3LruQAy5gBJTByMU+8p54syBNr7Zh3?=
 =?us-ascii?Q?g5W7jhScrzQsGkYk5g1StqFYbpozk3cW7TCE70I4HnSLe7ubq+AiKZ02Nq/U?=
 =?us-ascii?Q?Wwjh/xsAQQyfbu9KFGCNZ6eBF5sW+lZl6xK+jahbVcjLXc9e8wwoLEKJWO1F?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DZmMh0fih2TrXVgiJ1csvZfMUhUer/Lz9HQlnMwshLpPw7fwxWOjsH32IaAJzgfchwu7wDiSuIUva5m3VVOlcSOx3C9uiOHQfk4ayFt3C8fwhNFjYZujYyXj7mCaI8ac+z16zQlnO5z2AXw/6zTdoVuTyIRbEsP4O8ucm40yUjJ0UaY1Oju3g0uQpUzXe6ruwZDYRbg0TGQt96mgLvn7MfxB2QLrUuhEe8e6za3FDGYps0P6Z+wg4bMs0ZreOTg2DvEgTJU3q7gtfxtM7aRIkTQvxyHrNgmfTYetSOHNx+dM+noEZ8qRAcGYSEbNH2md+p4vqDrCotvq7k4vRSWJhcNn2clVQeZEMpBhyPpaqJPg1ynvBOtVtAPA1fLQqUuWiHBBBXQxKkjQUwfMti2KffhH8NfWEU0boKTFL05Nob6EXcrFl+4dSCfRXzixEldjQWJQTo1FcFAbZr69udyBtbqoyMyiSsfoUsJl/Y/l6fFJiSwsesHIm6z+xojGQqaJ05t0sJQhf0t2bOYBi+6jGHvOSUH66NpQxSZZR0p8SsYd4Nl5UnSbOVHscgJJLqPzayBY9nphOTPhGxXzGlosIQOiJdibRE4y8+Wq7c+4uyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a5a69-70cd-410f-0fb0-08dde6d32251
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:07:44.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubTbg4gAum3xbM+cEThRQUJVXzOqCaPdBfHqtMZ1jdCa6VWkqfxC+sWzvL3EBAOrJEod0lsIpIW9a4cYzFnU4O2Uq7uVz/+vF441fNrLx00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290066
X-Proofpoint-ORIG-GUID: jEb8GBqY21UEzQrzAh6y8uPVlaZKjeWH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfXyZmMqxmlRqIn
 WQKrkX8nY3yXAaI675aPYBdpV5zvIdBQNez+WsLzxwH4GWCccH45TtDTCFXCJTbgBXLuiYAWUfg
 PCywbj21uTVxijdEiZBX9tWJutTiNaT9hpQmqOv0mRLJRTA5LIKisJA1WZDb8fNw8twtY75LKT7
 JXdHDAu4vdmvVvbc1KASifYUN84fTpnGbAB0+r1LywJzFGTt7N1/tzdmwNmLUAJ7/Ei3OUI2oF1
 ABM95iQJOFWv607ts4/10d6BVCbjs4dgJWYwNlsaFWjfrgAITdNyGiParf1gftMuVwfIHjvXyxc
 B0S3/tnP8hhTC7S0v/wohxEXe/5lwjeJvbcZiIywZimiLb7iwA4gx4FbqTBZo0I5Nek5R1jBVSv
 tgR5zM1n
X-Proofpoint-GUID: jEb8GBqY21UEzQrzAh6y8uPVlaZKjeWH
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b15fd8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=pMBjG9WjWPNDpSeUJj0A:9

In preparation for defining smp_cond_load_acquire_timewait(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.31.1


