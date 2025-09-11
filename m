Return-Path: <linux-arch+bounces-13491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80AB5275C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A933B088B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B12472A6;
	Thu, 11 Sep 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsfERnBc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eB0DMX62"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1923645D;
	Thu, 11 Sep 2025 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562452; cv=fail; b=jfMWQGuTELT7KyK9kvcBEGAhIxkjJ4fTtcrYZkR6vug9/I3NTrfnz77J7Vmb6M4LMreKssh380rI93U4NFaJhTkT6r+7sBIiU1LLTR+ONWOJC//+VUG7L8f8fjrMnUOqKzZ4Xdrfl3hnByvzNxXwWMm/5DifXSKr3WI5Pq9RY1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562452; c=relaxed/simple;
	bh=P4GoNjTcYoPUWEuJ1kZM2JYW5QiZ/rd7gNn8SlcNlPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VC0syoo56AQV5op4vG7F3v2zU4orR/6kfptbniTwsyuCtOfSWkT3CSGE0CkrSZcIv0rM2Oz6Glx/UaVinLKcyk6M6oMou2E/zZ+e+2VRzhl7pFdxYnQUJwhVOLFPv2lFWqGJf/BJuqxEza5Htj+J7emjiFuHw0+DTPUkrC9odbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XsfERnBc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eB0DMX62; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALfn7g006484;
	Thu, 11 Sep 2025 03:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=A6Pv8gyocd3dLoYiC/h9cyd5Br1zOCsvPZ9rSD/irtg=; b=
	XsfERnBcPTua79ecmMT8Nebq5ECYuSQ5j2rFA739H6GpwuEW3a5hO0rTc12q6roB
	v6As0/3TPWF8UtRlWwUatRehtDjHn4M4fz7toNOyWynN4h0VcelmvS+h6iFARoRe
	XUsuybeLfYN8TM624cShwgdvxpeEODYS3Kdv7JFMp6o8YG7G+ffG1S8bkJLEbEVc
	Qr126+QhOa0LZ1TtednT0+AS2+XMdjuCXu7cb//H83b3NaDFsMmgVJDvCIIbTIJO
	xIYn7/9Kvj69uTag5GmSP8I67vGarD6eUj6414PLgrfwuQHL6wABp/TqUK7KnWLB
	YMcow6zLJJnjAI4Ys6y1Cg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1njj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B21pwN038942;
	Thu, 11 Sep 2025 03:47:09 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbvbps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7kJli9jz4xS+CK6QRMTgasQxj+YNKGsXGj7bKetjgxw5CWpZlP9tMCxNEhXVsN2Gh6dlTE8qq8zQJrHHyLykQTCOQfCnNbup+AqMdRpa8CdTxAItsYsipReAN22aA23fWPgXxHJruvGatVDzzsvlrpsJsPiy6IkCd9n/u4Zy02YZigiZeCcYzx6F8X7sEa8qaBhp6wIf2pzYxgLdpR3exJKzRjkarrUD3lyNZpN5+bfBt4I7isiwXpWoevPZdLv224dMNnpos0GPJbeGZI4GD7UvyRCH4l7xTt3MlhmDEiDmJeqk6DMgVCrZ0bdYmLoT/kIHfFYBFSGoJT3jnBaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6Pv8gyocd3dLoYiC/h9cyd5Br1zOCsvPZ9rSD/irtg=;
 b=svm9ptD5xDHUl/hwA4pp8C+psmcJZwAAvltfNpuR+g38KYuPapE7x2ibPeqwfK5zKHLtCvuGCb+bWvEtJ/ypEX0IqFT4lqzNT+ffm6jnHtAwglXnyZYFzz2A03J2AADHEpbb5LJXwIH4Cc9c24nwLq2O3AMx7smPeNFHe31wj0Crr4C2gDoBsqRkDMERDNdt+D74RF78ADoJcvx8GxX96uyvitSjmzIxM8RXEAhS20zpWm/FUoC8iezaQnsDa5tOw7DIssVspaMVqRdcHiEyytKi78dtxIWPpnn5MkmC8HBt52frfhH9Cff9WwwLVKuO3sKHDDAn1dHL7eMLXuoVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6Pv8gyocd3dLoYiC/h9cyd5Br1zOCsvPZ9rSD/irtg=;
 b=eB0DMX62Hq8N8azrR5s4tQJSs3ayAEZfli/Nut7AtVbQRrSOenO08uegu6MGjnDQZsUmyd1WMdYBIO6wz0s+swpuFHGYP2z6W3yxPFd1tfte22orMwSbzKQr/yyKsS2LZCpdH+L5Vy7bGWYrcJy/F3CoFOUSPXGi7uuFFNeXs7Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:47:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 03:47:05 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v5 4/5] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Wed, 10 Sep 2025 20:46:54 -0700
Message-Id: <20250911034655.3916002-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 321f8ccf-d50d-48e2-e3ba-08ddf0e5dfff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKyxe1WlK9akEL6imSX/Mop/tk9S3dSuBASheCldbc9pc2eA0iviDsojTpu4?=
 =?us-ascii?Q?3KzZVsGOTa5R89Tn8laWbifzcfB+efNUUvw+LklCkC20Hkej4d6hce6K4fAz?=
 =?us-ascii?Q?kDOIfnv1JlwohpB7lZ86NUFJtdQp5ygOnSjqGinbeSIj6l2L/tos/Somvvza?=
 =?us-ascii?Q?nFX78rWkKOT6sbjggcbn93N4i4mzvDAu2B+fuwQWg/ROJNwomYA9pLz3M695?=
 =?us-ascii?Q?fNlmgtzNcYVhkbz9W/2hLYxzBHfvSSiP4tuyIFKevXHgoVsOqlmtYKKFp9GF?=
 =?us-ascii?Q?lstI2VWKU5MSCwOsznGocyREfOSUU0vPrjbyo8xttnOXxh3Mzs02FEYVFBlU?=
 =?us-ascii?Q?R70YGNYdZ4cFBRrEYSb6O/lYhneOHwwHmRNWiINWuab8jDDY+KPZ2wf3lkqp?=
 =?us-ascii?Q?exlGjtRz2G0ikRvUEiL33E25Rs4Uqg60sE1XQyFaZ80pyISsNlGqQWZiyWFI?=
 =?us-ascii?Q?WzNeBN7ci1H5lWr0orKHR5gGp9ZwC1a4o2BPTSsxnl4QWTsq698vQTOYLHej?=
 =?us-ascii?Q?Xnd2S41Kh9zcWF/lTgYPAUontr7iJFbFosofhjq+8sMlrQ6eHma0pbg5JK+r?=
 =?us-ascii?Q?8IjfKHcw3EUvkgh3i2ohX6KTBr4Tr/axB56wAeJh23Fvxma6MsYFdIshUxIU?=
 =?us-ascii?Q?YA7VYSPOx9tCmutAT5Lh8jLdLO2DFJmUD5BHjBOneRJ9Ce3ROibJXWK3NFM8?=
 =?us-ascii?Q?xkOMzBR04ppaVbEuIf/LHi62aQOe/Dv6vgnmvZ6exrW5f18H06RxjhKLidJ2?=
 =?us-ascii?Q?SYOc9FPTnzo9B6cfmq7i+r1aM9zsgHp/EurBw9uVgq+Qhcxyj9KQy1UDXBBi?=
 =?us-ascii?Q?xe2LX7AT1ZjaOm2GYN4+82SjGr4aqnx+EPQFcLsydGr7U3k28wRaHyJZgm0Z?=
 =?us-ascii?Q?+3Dq1Jn81mt+qpuXBWnqTFe04tKlNp/vNqXKYfz+zIzLamTc5faLGzchFWSe?=
 =?us-ascii?Q?URknoBDWWXPbhORqhblhbbgI6wuzZBfkWvcZqhEccOHpeH4NFkR33L55sJi7?=
 =?us-ascii?Q?AA2xMsNxDpCOSYIo0c8KitzNSZS++8Sr3Dl6YQz4r9A0BUdE92e+v0LroDL/?=
 =?us-ascii?Q?NxF2pLb2px2vQepysu0Gy10aCUkpikbJGtVTHWcoAOB79frNuONcFxopLsDI?=
 =?us-ascii?Q?4umMNM5i8EcEFF5QadjG67Zauj7spbwAU6M5Gz7VEsTea+aaV965Vq0j2duj?=
 =?us-ascii?Q?Pv2tlEsACarvZlTFJKCLYL/REaAru5JckHdsqow64WefHjz8u+oAWVNRSeYR?=
 =?us-ascii?Q?F7I3N/h/Pn3lO0geOJLvJ6UMhD51t4rahwSdG0XbeLUOKENAjph4FxEzUpNQ?=
 =?us-ascii?Q?9vF92872Fkb6FYCnFfttxUvzQYQiXgW3SURhbaasAlMbvClFSzf0l8PU79BP?=
 =?us-ascii?Q?SPVub3AUFjoKU50fSM9QIk38uXN/uvJD9C4iGJIfQltKvLndwWcPJcvJ6mo5?=
 =?us-ascii?Q?qP89m0oaM5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZF17w4Xb0YYxLt10cuidZbcGKXENdsNAvB4Ld9o81CL8XeqGdyXgk1+SCUtl?=
 =?us-ascii?Q?OG5+BsaRam5t0wC+G22sCxgtFWJGfkO5Zo7CG1ThEnt9dQkQ+0cft3X1zYCz?=
 =?us-ascii?Q?Vxm/g9r/IhquG1KJ0oHO/DXjR34v8JrGdBE1FwEXBBpJgl7lsKgNBtIb3g3G?=
 =?us-ascii?Q?iCI/y/ZyJj+Hn0h8+wTXSMF2McKtZgzveJjUrXeCi19xLiHZTlEbqrhZ0qM9?=
 =?us-ascii?Q?CmH4dHN9SYq8OjGyICyuNJrzzHBCe1ItLlRmwa3lyax+Gw88bx7UegEDM493?=
 =?us-ascii?Q?XH53Am1EXR6BHbxq4psJ972GuQ170jbKsmbQxCvNGapvL/q6xsfN357qp+zJ?=
 =?us-ascii?Q?S/gVLBG3LFA2hzYgnqal7wFDZiw89BkcaXWmLTdVLoIFJV1sIGUUkRUiAl+O?=
 =?us-ascii?Q?6Urad56UKV1zGiIyEjJin0K3uU3LpKwX18LybiZmR+JMnWOpyWECeh73sNq8?=
 =?us-ascii?Q?LCwzloxIBVrq+esU4m+jHFx7DRTGhjMRnJOYKrbBzNTVfku9jt0DyRvP86zl?=
 =?us-ascii?Q?B+zIDGdD9O4GuYMiJhiNWiUbRAM4W5g3/h4soDQSQRM1BgTvNWnKD3TdFRFW?=
 =?us-ascii?Q?SL+AqvmgHA3kXJYxhBckVSr8W44wnwKW1OmLT22PRyJJWS64k5st5VX5Ni8U?=
 =?us-ascii?Q?r7FAP+V7xnqJTgdecxyW3nSkL/KElYmpbxNIL5n43n8tP77OViKzjfFbwzH9?=
 =?us-ascii?Q?6mrRs44PQ7vd1H/X0YSILTW47YPzSYjlxDXxhMulUA2IS52SxYuoOubanag4?=
 =?us-ascii?Q?eZjO5LYkchKdZRUbbXplO9z26KV8nl8BSpT+aDPtAwQIwq/FzVHbeZT3HWLN?=
 =?us-ascii?Q?b5Regs7UQAeNz1Wg41CVZFTpMWvY+GlFz2XHv2snz5SpFa45gOCrh0Q1lv52?=
 =?us-ascii?Q?vPqAFOnvAW//2LmPaeevTxYYGNAWdhe6IzyV7d9wveXiNBGpIfyHPc2LEPyN?=
 =?us-ascii?Q?I80g5kUYxr5C7+p36GbVz/vVgQA2rQKB8U3zaqcW8MM/p9C/88Awm1aaGiqF?=
 =?us-ascii?Q?EbRv6r0gJyYk2HrxrF2yRwLP8VR9WHcdGd8OlkPRbgZIDoaBwRDC1EB/GYw4?=
 =?us-ascii?Q?6jsZcUcDMfn3b5obkizWjqr58w8CEsemtPb0xcFHW+HCH0Kveyk3O5K5UITu?=
 =?us-ascii?Q?iOr1/nQt79Id5NodXVjpKsaZIuBGER/W4iv4Sx9mJbtLA5sbp6y6kONc82zG?=
 =?us-ascii?Q?iMawCSkfS/JvSyH6gtswK73NYUAK9qTLclJogrjhVGPC0QKXoKc4N83G2+Gj?=
 =?us-ascii?Q?7L4SQfSVhg2OfoUJN+xsqQQVo22ulTA0V+C2fGkeDNgk7f5titztw0KEvYiy?=
 =?us-ascii?Q?kvJM3y9GM/3IU+8r7so/OMCxn/zLR3GGO0KVivhX0sMeBAkz7X+ALsV+Z6qQ?=
 =?us-ascii?Q?TyAswmLckEnI0AKiZc9sSSFkXjlXS8csce56/leNTzDJ0ift5P8z9DYEYJ4f?=
 =?us-ascii?Q?3+mvZal05mnSLkU7QZeiPS+vyH0DpMX+oBKne8KbJ3eIvoaaN9Wruf9j19z2?=
 =?us-ascii?Q?dOHtL32DlnEZrNzNASw8Ts7yhzchpLvxEV6m52dBNJPkhAKtndZ73ar5CYTK?=
 =?us-ascii?Q?WaBJh8kdIfBtnRPydrAvZ5FGpztVGD7QaQRDcJMSU336cfnqu/jYtKEzV5YQ?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mNNrNbNB1cVLs5JF1p02N8Jl6/YGIoNJF6uuqWY6Q3whQZzoc+X+53Su8UOms+C2u/bEkVkIkqBau5zCpe8PJduMYZpKNxya7D9jnUeA+WxeujpPbLbNxYE/2GrgJKAvuMYsgTWbTfQqhUCVdKtLcEczso3foZLTvfRdpn3YVy3aSQ4fkx5EqgKLl6jjbV3wMCr3LQmRdBgsTCZB6hSyPhSZIhtAnzDCAkXfJtkG7z7w1GvQ2ApBqzimxln121QuGO7yg+i3TqdxGR094y09mddyF3I4nSQDLY3t/eGdXKO6tKZ4kISZMDd7GiOC7/xNWvevaufdYj8kRPHup5EXEPWPt5iGPVfwSME5ZF3lgbYNaQDEkTRk9yVZ/TG87LsyIVIWdAYP0II7P8SHukT0F2/fLkudugDvmXRGJ0yDTe1bH/AxtKdyCjYTRFCKmwJ1ArOQlZTRhRe9SXlP9WIr5RluwU7iNNJo/ZG5C0cxPz1Iowq8KXmRCVYg/rWVrYaEKoukA/ZwaknhCEyaev+r5pgbAVSRNkrjQmlcQBXOR2idi5+TsWJx28RA2hBQDhoCuxb/7JQkKIDOpm6BKNcqkUYy8UfaDy7tKPfUG8HYR1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f8ccf-d50d-48e2-e3ba-08ddf0e5dfff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:47:05.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jR15Q29Y7ZOi2FGUKTjfHvFnZQbUFoeRhkAgWS9/kKZ1k+M/P713FHi8daghsd0EdWrnY6Gd+BtRfOjn1Rpi6TyvNG26EOwzhCnGP43mNO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110030
X-Proofpoint-ORIG-GUID: vw9BOruj65VVVC-kXzga-MKBshj4spkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXw71Fd3EOsPRR
 sOccDhrLswR5pmPivO63xBYQ427dz/+tB7TmunT/PAhgRxoQwN8Lqlmj011YuNymdR2Pa7y5iOS
 jPa2Yrsk0Xmo8suc0W6szDv0tFm15Dat+umh6Glam4hCig7rrknstJQgsOWjHtj3oQ40O4N4rWm
 fTQoBcmn8Oe/9ZZHgjg++PDH2MTfxoVUCU6qINYix2Z2Aay/uPVN1s9lUw/bRitxLjLCSdhByCW
 0Sk/49LRnjPla0K/ilEvxoH6jSOBItCG66OTUDnDq+d9sKefDB9EEo64b+NzXaEy02TW3hw0VIS
 LawLtU+WnnCltmt7IWgVrS4OnBqrUMrKp9bUulV9L4W5zIQiK8Ie9jkoRhEa20pTN9Bg9nB0D6j
 ftohP+iR6RNdzLZ96tWX72bDAFaImw==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c2463f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=_t6Qa8hZe8VChzH1jgAA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12083
X-Proofpoint-GUID: vw9BOruj65VVVC-kXzga-MKBshj4spkJ

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
index 8483e139954f..f2e90c993ead 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -308,6 +308,28 @@ do {									\
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


