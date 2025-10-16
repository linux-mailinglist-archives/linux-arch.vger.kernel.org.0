Return-Path: <linux-arch+bounces-14166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A10BE4B71
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917E919C6A9B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E90D350D57;
	Thu, 16 Oct 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QeUh4hoC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eLKNRaoB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A48341AC6;
	Thu, 16 Oct 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633846; cv=fail; b=g0RKVstJLVP0cnfXWj9bzVy4BnUhj64x1DNT6POJBpfdvNFdmGIts1IarSK1wQMDIUFx1OGeJSUMvFYu7bSOD2pHPCPyhm0Rr0AmnTAY30DZZpMAjLyCi3zTwMW7PSyKzdc/gjjqLWNoniWPapbOlBmnCrgGuE0ESJr2hMsFWgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633846; c=relaxed/simple;
	bh=pnT2b4FL8OiWvv+d8uW4SDFvsytiussyvW8sZfnt2t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBx0t3vhPrR3RzbhzPCvZEd2YVr9fIodzgp/pq4cYVugDajIeC9FwbwYCc3n84j3M63bqN8HmelHCMgAPjKwMBPfU1GPD5WTnhjRSdLD4EwN296RYRAmGI6fZHIIv6j8CLQ1ZRt/IYktmVyOkZUEoP0QaLN6VY3UYL79wHfep+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QeUh4hoC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eLKNRaoB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVX7k020000;
	Thu, 16 Oct 2025 16:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=; b=
	QeUh4hoCFZvXyBbD3WkyLxya05TV1UjMaYs/kIR2/HD9fiQlMRSYt1LeM0/hm3/1
	Vtr4zNH2OyF5psSShffxIc/0vcP6CQtee5BEsZL9nv8mCKjIaRGsgt8N/DUug/mw
	J0gwVcXOFUdZ5xIx7qi8RPfGLFCs2TY2lyoe9SAC48fqxijRPDjxBtVJFFLl63yM
	I84hZkcrsejU43cl2ORPK4ZcomW139nlMZQhvFldD8uMWmb6lH5BE/ooaypdBXhh
	Uof5wwVPMS+LpgHg2iixA6E8YabZiL1okHaykTW7MRFiM28MJedTBpB2zo/dnaKv
	vMMxlTa8xw61jlR0anOT5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut19vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFLvnc024780;
	Thu, 16 Oct 2025 16:57:01 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbxq5q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KATDBABMz3aDTrFrRL1Bq7huJjIRLQFfqy8HAvyhyplML4DHZNN7gWHbCzv7Wv4fFYujGFX/8ChKz92jKYPzVtSnf/x0Cw/emAt0Fd7kFP7K9TGg7sQFBfxgeB5P7/ljHDT1XEmCJXg1rsc8b9apmaQrw8zvp645YK0711oAqTaagiVL6atJHDszHJIx4v4O6nH6T2R9+ejt7nbyfe1tsO5m+KbE+s1/sHeVFlsDEY06fFzo7cTVZJeoIL+WTvZ7L+NXLlbMWC+YvMdNF0mArcYd2R1g+G9EWzbvVFNOet/GA+7/eqXgUxFcbfKFoYHV3Ce288iFo48RTX3D+ruICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=;
 b=It0AOMZVXJb9S5UTYUVmO9Il8nS53AuF94H36j5/1sHYB3opSKqbQa2XJndHfeiyLa+mi4HdN0sVKMteP5Kdrhg9lP007gSpJ9TgdXxK53R7b79KfBvCmETMb+p+ock0DeAj8MTzygJ4uItFe6VriN3CjzPd1OSbwGG3W/BXwsLxH9JObphH/ug/MdO1ZWgKIGNAC6bSUusD0oryHdztmrHOXDzfD60kokfXQw3RFa4NWpuE/XYtpC1fqlIOi8tX9C9cK7FG5KcgM/LphvAulLaSDjza+YQkYEvZhxpgT9oYHfME3IGKD/0atnnRzA9wklxRPkkfGVTEubso7bUoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=;
 b=eLKNRaoBIjc6bmdxH+DDkRc3Ybz62Bz8UQnEsZG5VFNXwIABKQ17i0hmdur1jv1hcweX/jxhPHDcbG9yF2e9SZ7MMSLTaBxhvi36llRGb3UHrjJ+G2OroCN03tC8CZwPJrTGI+fP/rFozxBQePFJnBoUdgIQE5wjMR8K0pFRQH0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:56:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:56:55 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 4/7] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Thu, 16 Oct 2025 09:56:43 -0700
Message-Id: <20251016165646.430267-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c6b620-6d8b-4241-0304-08de0cd5034e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ufVXz9Kbg9qocZyXLHPUjdiFqmBisMEIkY9E2zYQd1LM/IU5ABjLLNWLs2Ng?=
 =?us-ascii?Q?FDuysR0IPX3Q5MAMesxi8BDxXXPOeAnXyFQ6gUbd+FaGlxiaHnlMr+32xcgb?=
 =?us-ascii?Q?j6aS1bcVtTKWpIk3CaqmgRTQlbQQkfCaD5BUU11pbY6PhvJZAlkCmlqG8k+l?=
 =?us-ascii?Q?/VjH8DMte6nmhXT6CUyaV0LFQRdJ8mHuU/jVxBK7xz0rwBxSNvW4efBwZtGv?=
 =?us-ascii?Q?5MvJGIWSwmneFltNh30anFBQbMhCIQQSDjd95nc1ocG/qN94eOScBy6g14nb?=
 =?us-ascii?Q?BKXNPlC+LeWlTsKJw2FWoQsGuNwTHMlvzS99WsFbin71154y0d+IIu8MkuXx?=
 =?us-ascii?Q?17nrzxs5Wm3o2aCuYYAYefXBTYKqyojLgWiYRUN/wBYcKfuSPE9oU+F3lrt/?=
 =?us-ascii?Q?DF4V/dXukEcUtYvtfD34aYcyWkGPiXtK7Yre+qnU4YN0DxEAiPEBY+QQxgov?=
 =?us-ascii?Q?PQTwtlmOguF0Qe8g7cadADRKJDdinrqIA+YmYpxCV14WSejuZGS29Aho+sDl?=
 =?us-ascii?Q?3iHeiRYAWqoacHaMWucixYMUaB1pI/IF4v20/+OkraRww7izJ0AFCR6RppT4?=
 =?us-ascii?Q?TOZZCclEm2FGciN3Yo/h+aVLRM8QcZmdJhUPKMsV1Bz2ASY3qRQRw+0FzXcX?=
 =?us-ascii?Q?oXCALd+lwzpxBLKJeUCSlDwDVzSMmBbCbHt94cVFQaaqSTdP7UbWEIsRmGIt?=
 =?us-ascii?Q?3t+2xEvnoVypDCgdppVLgu0IHxL5KzyVgzcQC6SZIIOB3gBr8pvjkUvZQV6D?=
 =?us-ascii?Q?6+xoDFtrMtItlmzpgq4VpJPnCXUNDIxxBt6nI6ZeRRzKO5GEByHgD60qH6d2?=
 =?us-ascii?Q?F5OMC6rdW4rwWVgD1T1qAEFoMgi9I6uv3k+lTApIosdpR6Y7oKQ9gDkvyH+Y?=
 =?us-ascii?Q?nV6i+rzn93K8VXcqQjf4yLWpDp5evxG18lFlqpITvZV+BheHsEYVA5cv/TLK?=
 =?us-ascii?Q?KeLJPnYF36kPrlqhb2P71xLdBNLs5LnMfazreVOLskHNI9qrk2H83M+CtAEl?=
 =?us-ascii?Q?p2qeonWCdsvcbQ9a5T0SM/JAeuYQqAF5EWXKg8HM9nOac/zHV9R41jl5yfTn?=
 =?us-ascii?Q?JD0OwTe8DlYAgcgtNxykZvquQwfvfo/Ocw+q1ocm3At/geYMfYIi/F2qQQK3?=
 =?us-ascii?Q?pDMXE86yNsl3sbGpLFhLQlcpEu24pnajUrMdSRa2Tc4bHBRoMp0OUdI49sgr?=
 =?us-ascii?Q?q7ksdbTJHQaMJVHl9qE3ukjvPhRC998Ug/OVm52UHzAqjWOiP68yc0oV8q5n?=
 =?us-ascii?Q?GuISsJ9L8xHWymlehwaDp66Gzu/Jwgc3e9h0OtQLaoYfWG/J70TzIM7/8SGf?=
 =?us-ascii?Q?88zS3UxLBjzlP+B1EK3gq7qF+SD/J74xc0GCC+R1g79HsGlKH/CluirFg6Ik?=
 =?us-ascii?Q?khFQ3/Xz/9hsHcraptikhgvmbJezu1q1+F5f7FxnX33IXuXjd+7mbAuN0f2Y?=
 =?us-ascii?Q?QnAbZjZfN9a9cd4Au+bbUcxJPooFflfM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naBVT8BQeRAIuDqTpRW+n0vNzzlACR5X9p7+VUmXjsa8N0SzkS/S1JWYgjoK?=
 =?us-ascii?Q?94lIhg4rDH6/UQsMpox7KyVU9uRHoPBC9ht9UaqMDPz0yYLyfquqj2V9PFj3?=
 =?us-ascii?Q?lSVxq0qy6m0rrmB+0WLLwi6pMhNymczXLCI0g85fFy3wenzzQ8bKy7I5nGFV?=
 =?us-ascii?Q?c75i1kgqS9yZ+FQosPpUXo1/o8toUcS/wqqyQU3wut3Jl5FvUv7i1kcWBXdQ?=
 =?us-ascii?Q?BeIblrA5lsqRsRELhGyxej1BhAAEGvO1SzO8CY3LfQKJKPznBsDFeTnjcF7Y?=
 =?us-ascii?Q?OILeW0U5wqBTN6+XrxGMvAuQa36WtMZw4tXZ1ztdfDhAKWKpbispRWybbd8C?=
 =?us-ascii?Q?+zMi1Fwybi5TqHI0AukCY80q4SbTG60Y4CZWZIA/4kuBQJQKWvNpk2P1t6fb?=
 =?us-ascii?Q?RBuTLpT3taMUPs5ZhAcqJmkn9Z+GSjS+87cdw4gYGgTLHqApUDZlmwcoJzvG?=
 =?us-ascii?Q?WMNButS6wvVuZG+ujtb9ByRh3947ysqLsLDqF61LohTZgLFQnWzoxL0m/HgX?=
 =?us-ascii?Q?43DqWahwCCT/spw1FM1fURLDtMk/rf4QOJRJpKKjMlirDj/kJwW81JYq9tE4?=
 =?us-ascii?Q?ny9vBtdAuZfuPHFDhDKwoPD/T8IFRjL+L5fH5IwwvEh5puWDA65KpoQu89eJ?=
 =?us-ascii?Q?WBqtxBO6UJBTwLHirFiVIcueCbz1PAgo00RVRk0CY9yceCHk/kLJk4ZNg50/?=
 =?us-ascii?Q?WwpwTjnV2ve5evhlnh4UDAVdQ+zKWeDMCP/5Ebd5PP9c5dVPlcXEQc/FBWU1?=
 =?us-ascii?Q?MJoN2fbOFINMtIGhAJxnOz/gjOjtbTBSVV/6AdHaUZEWtwLatJUIgygr0rYQ?=
 =?us-ascii?Q?a6FUaJS4GkSMA4ciVggK2W4jPTY77pFTjxY/CEoT1CRfHclLt3t6APh5/GZk?=
 =?us-ascii?Q?A2L9rNteeUGfTWcDQ4+wt6aG+4p82qDu0y6ky9/NCHkb0UUwWn6ByZP1EXUj?=
 =?us-ascii?Q?NFCbapz6DKFF9+a3Sl+L4PkrqwCS1adVTkosdISokIvs7nlA34N4B42NLuOs?=
 =?us-ascii?Q?vyRNK88aVW7oDEM3+j3gzJg5HothqGih79fySVw34fd2xKJC2EGja1FAg2hi?=
 =?us-ascii?Q?EzbBilN7I+8zUG5LrI3FTkbHaAptFagHXrMC+flvQMlK+9u6JWCBffWJTKO0?=
 =?us-ascii?Q?0SE1vDWUcsnpmXoDcI16kNP5Gq2JA4iHnvzMI4WNWD/0oa2VZ0eVVWgLiW6d?=
 =?us-ascii?Q?Q+0UV8mQ4IRcAsojcA+AE5t/r8b2QpOaOZ87U5TXbSVnfTNXQqXBryfVHEtW?=
 =?us-ascii?Q?yQbt9q1FIhDVgUGFm5LiCE/0FsrMORsSl4rj5f49OYjQ4kAMtfJUZmgsnbO7?=
 =?us-ascii?Q?5eakXMkaGzFngLXHjvm7ZbNhlo1UOF9Syj0fgQxJmwvIzyiAmBuw0Ttdva3J?=
 =?us-ascii?Q?Kd1914ZPY2Ax/ZQOdUotZWGt/vMtqiBEDFfECr2Adp4g59xumQCPWnmwpwhn?=
 =?us-ascii?Q?UqGx0XjycjB/lvvMLjLtoxEZvX0cWHRWsEwGzfYTVc8YSdMilTW6S7YcVFQi?=
 =?us-ascii?Q?mUcZ8QEp13PNp53gr+reQC0jIG4Mnb7V/j+mB9Z5D8Ehme7SiQuoaNekq9Eq?=
 =?us-ascii?Q?Hc0Ih2XlVTGOX2UoHzmOl7l19/kzBVGY/NEZiFh2WrW5yFeWJpgwsYecI4cm?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0SpQ6jcVOVfK4QPO7le0KAGCLK/1y8fPogTPzCiSv28El01YTArK7Pw7Lp9p7nKjXyaD2jFSA2nvqPdCX5fZo9ZMYBLD0mD8T2K/ZfsXHEH3V+f/S7lddhzx0BkD++fqjEOqO8KXvCWAJwtYLbFxH0bc6ZHtSPlXXYik4fEP/CCqz9vF9for6w1d01cij70X4GZceL4eTLQ6iEx5VEeo9WpEj9m4upgXvZPqQsSE9ZVNzuTfhcKeT38HIi59g2b5P/cnrIyakldbNLt4Usj5Y1z/8CujoTDDfRUJQIljLP92tuo6Oc85+aAoatEOvjWEavz6NbiGq/o5OKG3Cv/R/eEHUhsXhYWBZI6gdPTfr0Bhc/5W5E2r+4L5ThIPv7HEeFDI2ExwYVRcKMEhmYdX79sUWQladN+hRCOcxeMz1hwf507CqRdVMjCBdSgAHguwZfw3qusZ4IVuGu1e/p6/gvvvKatd6aAFjdwSVJ0dcyQUoKsS1ysHSjJOIHwH6AHReGEZ2nKrkSoqwnsshWT1C0iQQ0kOCIP3FLzio6GyTfrArZ/Tc28PTHkyKEu8K77Idvu+BVntkyEYOL7VjXVpgX+eK/JqKzNZaeEnNJ2a2TE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c6b620-6d8b-4241-0304-08de0cd5034e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:56:55.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJgnpmQC2NinzJB5cfy0DLVPVlkP8o9y2+RhTsJ/kEASlzulePpG/c5fN1IaHxLPTCQmS7sdkwACQXH87aL1pgtTe9pbXMfwn0DUxpfjzcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510160122
X-Proofpoint-ORIG-GUID: d4LQ94HKUolAwbv-9dX8N-BWkJCKHDhc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX+Skrk4ZkwWjb
 i8Bs+oSRRPmSUeDjfDVdhc3INQ+jeOvgsLsEO9l6UdOKRcV6qvJKlSYQn7OTd+UFIUE8C81Lf0V
 e3hvmvzj4gajkDICUxOXoqJKinjETTP2KI7Eo5R4TOFERlO0OKeY29WnPriPP0iIHzQj4ubDLth
 8C6ouzD1ZV2pHlgXK6kA+4XtfyqiY74xumnUfeg4wWjmN/u+NUl7+00cVmSdTEzTI+Zn5NmeEcS
 go5fvoRG6mZ484CeUY1rEq66euPR9z7DwbOnskGvBGt+6eQ42mbO6EFN0opi8MQzyE5ZBjKoghq
 2VNC0lZPjvY9S9bMpN2FhLT23DP33rcQJwnlVf6rnfLmTjITrGuy12ZWZkxYS2v/drCsU6N08Yc
 IoKh4R+r9NkRL1fIPWzgOfx1cqEBPA==
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f123de b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=_t6Qa8hZe8VChzH1jgAA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: d4LQ94HKUolAwbv-9dX8N-BWkJCKHDhc

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with an additional LOAD->LOAD
ordering.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 0063b46ec065..9a218f558c5c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -314,6 +314,28 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ *
+ * Arguments: same as smp_cond_load_relaxed_timeout().
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					      time_check_expr);		\
+									\
+	/* Depends on the control dependency of the wait above. */	\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


