Return-Path: <linux-arch+bounces-13489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE5B52763
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C7F7BCD25
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8323A9AE;
	Thu, 11 Sep 2025 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+s3G01k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ju3ILN2S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD37DDA9;
	Thu, 11 Sep 2025 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562451; cv=fail; b=ZCYkxEPXIz9jsVZJdxm50Y+g2tp42CpCjdf96KgvYYBsD77EhXzbNNn/GtPzFoJynxIPkgWV7DHfj1mx3Tm6UV5xzB4KISazAXpln7wkaqrYsfX9IZoh/3/0ccb+bmjti8bwp8ewZ01JCj00cME49+g1NwGDvI0DWIpCFkUjEDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562451; c=relaxed/simple;
	bh=FK52YMMCVxwCs9Y4sdCTYteB79+tTa69hZfF0rFFTjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1bO4/tA9YvRN68/Q3e7UH0TBFA7HP6fIxRf2U7xcuEYFG/MEg9sW9wuYnxwjsrSbtpxVnw9PYzXgdwE7+/N2nmV6hV6N7D307LQjtmemGiYPYoxzfQ3b+MWvivTN78V5plTg89i9sGXIkIuxk5FBo3H7R/TqliFtQiCAkB/mh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W+s3G01k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ju3ILN2S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALfmqX027120;
	Thu, 11 Sep 2025 03:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=; b=
	W+s3G01k7CDs4snJ7FM3HCVZXWc8l5ghduiy18i7+Aj5p+sHQHGjp3ggPz5zPKRm
	pfCa++rVmJ25quwz7qyzHzKlG8dShC+u6rmaL7lbmoup92epbUjHBZlvzEnJ/jnf
	I9d5bVm4NhWR/nAqQiOGrWxVr5MIaxpWlUNVrCOQ3yErtwr6dYgen5m3Ax0tZU9x
	R655QxnMddOSvGx5bw7dyqBDfKL0D6X37JywG29z7AnOZw/zm8lxe9KOSnLbqF6a
	QgEwEVbPpnSukXTT31zEeVI6YaQi0aR/XtFxu3WTtm/+OdEAfjUCVshkJQEk5nNn
	NZbt/1Kj8dy5olClwhfRZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x95cqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B20AUw030639;
	Thu, 11 Sep 2025 03:47:07 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbtxd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWNU8QXuO3G73MmOGI5tULkxUexVT9ghp+Z2i3H/a/xLhHXM4VUiuNOG9SzfCEY51qOOLZW+WuzTxJKcj6hAsy7NzC1Ot8+x4La2OHqVQ0povraChc5GwKuI0gaZb9w+6r0DDnY9evzQG3tykMP3j0E8ifXc6G+CeN44jmxQ8DXNLrDsaaNyzLsoLpMF89qsvN2m3S6CSYRytHVxp71iaL9A7JcYy6kvolvEkF4Te6ZDk7Tg3i7q5kse/kFYwNxg3akK7cxm6ZnLs/FlZjnfkZQuWHROh+7pk/uxfD7ntM0Gujy5CEfmW9H3NkcMxNfKNCJBncAgxx6ua1/JAJZmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=I+TuxjazZ0La10cVIdwCasEoGsz7nvdjKiMCnT3mrrbPb61thmJ3QRbSWCci/STgZYU8PAJ2dM5EHPG/K5ouC8vUwsJxYJwWTqyVfzZsdBBK0yo1JSDN2MlJYYz5sn2KRuf15WFLAYmEZR3uzBHMbiaZTd1++PupsnueCJ2O1QHc38njzlgzHf2yxZEGmicL5/hIN3bDlY5UKfz6zvkRMaex5t1aS3rmFOl1q+oR6Z0CEeo/Mv1WXnITX4orVVWeZhvkvnOj4HuU/W9n+z1dbPkcj6O7NCpa/Z172xhlnrGcpCVWuRm4+D6+B03Cdiw8F6lQ6JEFWW/IaOIPe6PdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=ju3ILN2SXpj5oeo5RVEJZHctTXjU9vUseMT4AAc1Di+p7J25VRjDw7UNtHBWOA/pMvNyQOeFj7XGTT1S1ckCQdWqaRwO6sw1E8+Oty63LosL5apffG4CP2J8OnEBAP4/kFuRMiWc9Of3Dq8VlEySic8QiAMPrvAw94ZTksqQdy8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:47:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 03:47:04 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v5 3/5] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait
Date: Wed, 10 Sep 2025 20:46:53 -0700
Message-Id: <20250911034655.3916002-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 57617cbb-f206-4aae-1362-08ddf0e5df32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXESssSPuhPS6V1xmsJaVpOEU4Eeu7qKOriERENbJNodSdZTZNsEnHSH73dh?=
 =?us-ascii?Q?6c0l1SQacUyrIrzjSK+ED3AFIQysr+WYAuUyTralQiyWR3XVzUzvGo3y34K8?=
 =?us-ascii?Q?/mwX8TTSYRyBQm7PHZ5R7C9YQT5pL/tNtvyGyDjtDpyKC42iQEqqtqo8KfPI?=
 =?us-ascii?Q?0n3oxM0ZumXxStmZYrAZdVKrz8+WgbGtoTxkuYKqpdA1IvD1p2JpqNofae5G?=
 =?us-ascii?Q?/rfxzVoAHkSOZlUT/REILryRHeFQrUEJ9+ATZwInKZmn5vSlSIe/zCD3rvSy?=
 =?us-ascii?Q?0TiBjgQvhM7B/QqDlHHda1lqtWgAxBtBVvMDqWgaqzetUg3D9tS3UcrCBO0Q?=
 =?us-ascii?Q?DVAV7EwyxxOKVHjtBzrP271IaaqpY+kvXz4qgqRGdlfYxpeC25g4ELQ1I9W4?=
 =?us-ascii?Q?sz0FRjfBXE28BgGN8nVw1oCdiR/8QqXv0uayN/t/dv73qpNriJHT7aIaEDx5?=
 =?us-ascii?Q?Fbpb+dqSOrIc4GjPxpG1E9pcsYetHI9t+fpNb5I6kchv6FLinvbyzouTysZ+?=
 =?us-ascii?Q?0DOSOWSHPM46T0AUSifrlGU3D6M71wJXOaFy7Dv2Kco2aWxDT6Fc+8JKw0pL?=
 =?us-ascii?Q?y7rfnxpWywd1ReREoFr3xJXr7E+hLGXeDhHVPZIA8brvMchRfxVHSWUFe77i?=
 =?us-ascii?Q?knXzgBo3wtGhSYgny5Fpfzax3o9sGRqBRKCzdAIXKPe4lM9hzPCbJiv+YzMB?=
 =?us-ascii?Q?MXB5KHH93aeOcW1CR+cqmc5MWV3Qq3qAe3rO2WzfmHWZU3yPkX4dB9zeoH9h?=
 =?us-ascii?Q?rwbe+WEqdg4Mdx+QaaJQkrV10Y1KfJKSm6elqobz+MxnrHMBhslK0PZ9LMHM?=
 =?us-ascii?Q?89uDpOEojMeWtYqElBIrvLge7DYTeMLanWupMg5QXZv/XV0XeBskX9fWbNQm?=
 =?us-ascii?Q?qEg2NlyWub6sYnvJbyPDQAt+2mD2FwU3GMtXFD07ueibnAKR96/wivz/j56U?=
 =?us-ascii?Q?SGTbkAX6PX3BurvrxZmwSQ+o+eM5bbcsgY7fYvgNb3V7Ps9BR/p55S8q9jde?=
 =?us-ascii?Q?+pGpJLHNqm4o/Y/DdGlrlusD+BjOviLvPHARgnRM/Z3uPPxvMyVeyhJxys6T?=
 =?us-ascii?Q?kU4aSQ90Nr9+3KX7hO7fSoGZqbNWiRfYj8j09Otp5Ksjj+1IJ3vcDIBhseN9?=
 =?us-ascii?Q?Js8DEknRVxEXMK9FCthCUJqM/q0E6m15eXaROy63K71kHnKUk006FHcw9gDc?=
 =?us-ascii?Q?mRVWoUaNWFjFEn4Fd1l0t+kZa8YVlY8eHNoqlV3xBaA1TXFStms3NbsdgJtq?=
 =?us-ascii?Q?ceqvQv6xlHGvJxItC2OCbqbl0YmzlK4d6omXCz9wdIot2VBF/5uGaPgksnpm?=
 =?us-ascii?Q?0GYlwd9DFrAiNR+1FWcp/3Bn7KolUS3yzCM03jhQe47yvU+Cjt1XWraEOW1H?=
 =?us-ascii?Q?ZG7W9pm9Ow87Grp/hqU/bdqYFt2sVVmuhoIhwY0SieXhu/5dXGrEhG5TqtHC?=
 =?us-ascii?Q?6vUpFgf2cR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b5QHK37QPACHtIaCrOyC5Fr5BMPlwW2RFq4nSfcUeqaFjvTk9Bxun0Aiwz/b?=
 =?us-ascii?Q?J64cF2xgWcIcEt4iEC9bmQ3DYeJa5n9XifA4yFasVGD5UA1P0SjKOEwsGD2o?=
 =?us-ascii?Q?Ch1mEJKks0SdAzarL2de7CDvoCwDdxdy4aVzSatL7ut9McB6GJmyLKiYPhNq?=
 =?us-ascii?Q?zLpOzXTPmvQFC5yDk4lA3BY2/NHn+boTG7riHAkGNgz3cYD+X7Y4Fp56OlI0?=
 =?us-ascii?Q?wMICY5EQM9FINiO1WhEu7rFQpg+ZkmmhGO/t3qv9eA1/S76fl4EfMSYmdPCS?=
 =?us-ascii?Q?e86AabPDaM0rF10ryQzNd28cx/JUxPVDEJc94j1zNiZIda/KTosstkVvxAgJ?=
 =?us-ascii?Q?TIGFD0so+YsNeRdIPs5YPTbDOaPhU2n5kIHcNxTCRttf6l3GCBZO47+jyIoA?=
 =?us-ascii?Q?5/uFYSLpBlQI6N3YAAdnpBUy2p0fe556/kth+oUkiAKZnYJqkMEZ/d2vmPCT?=
 =?us-ascii?Q?LytZmR6Po/S1OHkKUi2sF6g/+te07jg1nRJFbsaSzC73XTfD4qrISixfwl5s?=
 =?us-ascii?Q?CS2wdEz09rjRY30P7Aq6B2sNgoF7LrDdqcb/ZDUj8qOC7mMlrZ0rbvlT0fTK?=
 =?us-ascii?Q?OX2141bUZPjj6WNVnlCdvijbyAxsMfewlMxyjYGoY2jPRf0nnnNhHakXWOVE?=
 =?us-ascii?Q?mv7SNTXF8OYZIa6e+SVWQosmjmK3aSHJZd/5lgKxS0+GkhMZ/v5NxizNtbmJ?=
 =?us-ascii?Q?ZcklCus+0lKV64VKsH9Zzw48ZJDLBjy0/77mUXYaUTATsCEHAE6s48VivZED?=
 =?us-ascii?Q?iqvNm/OploiR7CBZ4bAb5+C9nj7uzmG/sArWTU8k0oqLD+OGd37QKyA0fxXO?=
 =?us-ascii?Q?bLeqkzyVTEyhQeH+uaBsC/Jl0w+cb7YqfDxQ6+K/odXVYX32+MDlHlcFRtfN?=
 =?us-ascii?Q?popW4Z4x5uJQgdMb3BbTaxj5jvxsYgoNvY3xfa4FD8SnbZUzcngu62tdewHV?=
 =?us-ascii?Q?nN2luBsJgeY3kmzmr7kx8i8VRvlvJO6tyXw5rshiff6/ZHQa/LJIPXw7wlfE?=
 =?us-ascii?Q?LXqR4RLd6t0qo4Jbwu/ZZIovLlFAyTXk2xEFOTsJvL1y5cYW0a3nKEP38d2Y?=
 =?us-ascii?Q?gBMVq0MWDMtGercd4aNbk9QzESFU44JVi1yqd5zBbE47kVWZIgAv9wOGHDgS?=
 =?us-ascii?Q?8qr8CHD+5hwttmRoiJ1dxfGXgF78cN4BRzuN9JUYhrosoX1NSH1UO+GrSUOJ?=
 =?us-ascii?Q?Znf38P5fK2xM8y+f9f+1RxIkDYiv5SEQ3oQklRgVzApBO++or33xJ31h1OOb?=
 =?us-ascii?Q?4teluimVb9wLjpAiua/td+14rXeI4qXBBfXtDO3l2b7JaiEIMG9VFE4df5rz?=
 =?us-ascii?Q?FpG/KWEIo8a9o2Gq2RmVpdeQMjNEWCl/2gbVGoXbQMUy+vJApCS7aNGWRJp1?=
 =?us-ascii?Q?EUsQi2iYM6uRuN2PXfxa/KuDQ0je5gBVydpcvxhYTcDCO47n17ZzsdZ/2Vpl?=
 =?us-ascii?Q?IKeoNQhodBSF6PYMtLE9PEirETsKwgMdCU42+2Pe3KrOLe13FSNmRd1TxJSB?=
 =?us-ascii?Q?XCKON/2wvFtKd8EgzoKc08UAF3FElUIMWXymnXaplGsvNC7AbYk37plBLYKq?=
 =?us-ascii?Q?04ZKte81/nUUK48KBiywaWV/MIOOVkiLbb7ZM9nKNHlb07vxQ9tK7GM8M1A2?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Fm0yeSZZ0V2E+sREyaA2ex15PWqtN3HCqchwDLBft1wQE1ErkuPfXIPpVChlucS3QiDaqy6ygibGPgnsrWzA2jzJdgT7/RQnpxjKw+SIeNtAEJ7pifq105NO+FYiX12Jqy5PyK4FgI5QBeDFWj5ktKGBDUIQEyQ5MaMkWwKGu62H1sd5EQAU62zTUKuvrSYPKiklCd1E33b+JpKzzipuXPGRUPYQ1xOnZRNK3I/ke/frDnwkUza8WaXXta7BNdnh41Pbmigva0JeioZmStdMpNww3KZm0ydX6Ajcr1AiunldGfD4/wzqyt6oUCXEPadyLktClsvwdvmVJxXal4hN7rRKWsVBtvVs0mrcgSolHrvwz/3zmkSQ01lmRlhXJF9uO1mD6F54D5fHPYrS12PnSntjcF8K9U2XG7MAu1ggbauMoCWHWoEOa+OAAZavMok9oo+/5zsRqCSUquVpq/nl3C7uuWuHeguicLGOzfLGLgNimNXgCdeQ/kx5T6YALfZziiPeQxTfM0P4yfUCwnd1IWA+rQ7c90ool3OZ4Vj1vzPL8q2EawiclA8lnb0Fa9s4qq6pYs3RiJD07p69ME9/9pAqojOx07L4L4knZ2EpkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57617cbb-f206-4aae-1362-08ddf0e5df32
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:47:04.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNbv0TGAUYsR2i18Ikl8NygqTGKepDwvw+MH167IsHI/aZ4yhgYjvbvkzHQK3niWO2xyc5HAcXgOgdylhQatQmzvh+U3vE9Di9iUWPhgINw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509110030
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX8OWkOVV8ZBPW
 dwt/tWohLM6OWXztpZwpQqQ7RwfFq5g2J+Kbuy2I7SWARA5M3XtlOgm79CZclw84odQeeIwJ56i
 3RZQ2uhSCHv9/Kck38gY0KPzKmN6esK3MyBjO5wkl4h5dJAQnbbzNg70hi1voDsEAUd4eP9+IGe
 g5GYFYe3Df15kCEJK3FeS5v3o6be83yRkZhn7xtUzJ9YFt82aIgrEmaqX4Kp7uST68fbMwoZZYL
 R2cjHMlWdjW1fXNCGg8PeTwtgMfJqEuH8RDF8oHsnhfWCX8n51laWB1wHT4wRqFXDHQR6lZSUyG
 nve6l3aWd0iAZ5J0oM9L/M33elyTz9ly81s4EyDRBSEI3CEWqfsYbKb9ICDI26LVKlj9Wz6tLS+
 HTSHNWIp
X-Proofpoint-GUID: xP6KMXHevkpeGg_uyeQ9Zdip6S97rF0k
X-Proofpoint-ORIG-GUID: xP6KMXHevkpeGg_uyeQ9Zdip6S97rF0k
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c2463c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
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
2.43.5


