Return-Path: <linux-arch+bounces-11894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904BAB3834
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86983189FC55
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CF29346F;
	Mon, 12 May 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ccsypFpC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p087p1Lm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E438293473;
	Mon, 12 May 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055681; cv=fail; b=Pzl33wYde9GRv6mUhspyglh/oyb+omVYfz4hrKmKRmWlgQDCE2qBTKNjWrw/xbU+odjwgGg+PF/stG1iv4qztC8rVlbqV4pP4x89Hcw7yg+e3u92Oh4JlreQmnJYsXoNl5/a2pqOBSuRQh0RCBQOzfKKYzLGyIxnsGhhwVCIV/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055681; c=relaxed/simple;
	bh=g+axPP5ZKOtwx/N8Wevk2v+KYqsABgUBdFgNutUIsSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rH7WYRRYema0D0/pdsDGg/DmQv471iDBm/GZPxVcgFg7esqS7kB7V2EJRdU6gk5Cfzy9TKSoWEyrFDTDoH1dJF5Kaue5Bbvp93vh4pPFX6+KZH28DoUmQq91tsdvnpGy9cYjai19tXVjfJ1cli/kkKqr7uxHuJ0apZxDkMelgYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ccsypFpC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p087p1Lm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9sQa004037;
	Mon, 12 May 2025 13:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HpT1Qtx9IdXnDdGK1cxEiKnOL4Wpjlm8VXV9tpMNn3M=; b=
	ccsypFpCQwO2c3V3/AcDmrMripkg6VSmuZwtetAsAXjya5yliy2muluvldD9lgO2
	ZL4G13Uw4aSYonpWvGd2OOYG2VqpJxiBfEIMrZlI2L0HhooLy4wYjeea1nr6svMn
	/TNJvWE3e5KzLqLhgwhsZwz8aLdzabLugk5ZD+FFmj0ZOObnTQKCZDisXn3XBgpu
	xj9L98RGDMNvAcFUyXjnS81FiNBkNcUXqDXUbrIRyDC9M5FJkC7T2WpXrZk8YbK7
	a6o8TjqsHUCv23pciXtfcguFOxHYLe4dNllKBwWhWMNmL2SWjohubf19aoPam1yL
	SDF6yG3xaWZlv3pBUPcasw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epjegj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 13:14:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CBiaPc033223;
	Mon, 12 May 2025 13:14:03 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8dcaep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 13:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJvI0BfxoWbHzhb1EomQvF1r7UvNom68zOf1FPtknM78GFLcK5AsqOIRU/GDAJfivrNR8Hp0pBkl3/YOeYSIE48y6/C5UtTbNc2QfH4unXDV3r6/S4n6quDi7yN7FLOPu3LmFwV9i0Mhb35FwZ+U1eQ/XGP7ncoPG+vbinUtse8eKdbgLR9dugOmaunLjKMG9+PBmXFQlrZBPI4MKrsQIhrxEHBxhIfEGt3taMqcDkz2mQZ1JbDOqA378ozZjupKhuYImt/vj2IumgyftCT/ALsren7jWx9nIqOahLuFJ7umrwHu4yXtSWT8kANvnZY02kaht0QQlOim1UWCxnm2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpT1Qtx9IdXnDdGK1cxEiKnOL4Wpjlm8VXV9tpMNn3M=;
 b=tCuW/d1E+55VeSU06duMzMG9DnKmZLA8j7L+px/IXSVulm+NCeYZFDseIpRKGW6o25p7uHhynVDwrGL/QRFSGmz2Kw7bPyY6/DMTAs3Rpw09IhVvd1xlHql78Oi5DG6RVZ2zIdIs/yMvXSoChCEzcCg1ZTcRX4HrqvGia5tXkEkMkuhCFndoSmuXg2YIo+NIXMNfAmjHlC6MmSjA9DyCTMaIvLTDyys2R4mIxCIt8BSTUNepEXi8AIfDF6qlJiwCpD72AhL5jAk31f9CZcxIChqqmS48kQsIZCIbUlQ6sKiOpRA0qS3LGDQaPpus34MKylFyL410/g3bhiSEyxG++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpT1Qtx9IdXnDdGK1cxEiKnOL4Wpjlm8VXV9tpMNn3M=;
 b=p087p1LmFwpte/PjxOaryZDQgHyfAEC8QEdXB+dpAhsJWmESQ4CrM4KbpBnHooW7N8e27SnCaoRxwX3qJpxV23UYuw9qH+O4ZeoREOQ/MFOleFLI1iAsX21qTzQ7azHle7PAGFRHPtOMSv6VGMBR3baRg9Y+KAp/OwS2ni1Tx40=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by CY8PR10MB6731.namprd10.prod.outlook.com (2603:10b6:930:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 13:13:59 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa%5]) with mapi id 15.20.8699.024; Mon, 12 May 2025
 13:13:59 +0000
Message-ID: <3ee4b3a9-cc43-4bc8-a7e3-07bfa6025e74@oracle.com>
Date: Mon, 12 May 2025 18:43:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 4/4] arch: x86, drivers: hyperv: Enable
 confidential VMBus
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
        wei.liu@kernel.org, will@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-5-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250511230758.160674-5-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To BLAPR10MB5315.namprd10.prod.outlook.com
 (2603:10b6:208:324::8)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|CY8PR10MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: abe8afcb-8edd-4fa2-492a-08dd9156db3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ektRbEJBWEZzVjh1NEJUaGFxVU55RnFvK0R2WVl6ZGxpZURJbGFCNFNzU2Z1?=
 =?utf-8?B?dFgzTzhGNkp5TkFlcUhYQXRMQy9uTG5VazJsdjVtRk5WSFFDQTZMRHRoSWtG?=
 =?utf-8?B?M0NsSnU3SEw0N1VKNnFJZjhJZmljVFZmMGd1YjUwYXZCUlU1cUlaTXpIZUVG?=
 =?utf-8?B?VGh2VXlWSmNLRnkvNTV3eWJqWjhERWl2alZ3SHh1d0dEaFhWa1lSOWtSWkcr?=
 =?utf-8?B?SGVFMHlnSzBOV3A4bHNBaUpCZXpwZk1hVVFvVFJ3NkFWUU0vbitJMnR0d1kv?=
 =?utf-8?B?czF6N05GTm95d0dzWWtlRzBOckRIa1JGcGd4U3pQN3pCYTYzRTlENWpVbUNq?=
 =?utf-8?B?Z2pkVlZXV2NEN2VFQ3FONm5SQlpoTm90bTBlVU94bjQ4c1FKK0hJYlk4MFRF?=
 =?utf-8?B?cTd1RlBiaUxQc3dscWp1OWVCQjBQNjRxUGllZm5PSFhyblc0WStwNUVESllF?=
 =?utf-8?B?bGJnL24rd2NqOTl6S1NqOWtFS2ZadXY0SWc2bFFZWEFvQU1ZRk0wbU1QU2hU?=
 =?utf-8?B?bEZVd2hvckxNSWVlRnBZRWJGV3ZtdGZWVUR4VmpRektwb0x3VDJoMmNCZFFG?=
 =?utf-8?B?ckw4Umsvejhuc1BRMU02cUtRSTRQcDB4SEVOQnhjV2VPbERTWVZuaXBPMXNj?=
 =?utf-8?B?Vm5rZkRSUjFHYXVOYWVETFZKRWZoYmVFdmpiNXlwdHJncXVTWlYxRGRHMzZL?=
 =?utf-8?B?UHZGUlVoTUY5VGMweVNwSTR5Ylhkdld6dlR5SzFPVTdaN245UjhYMzBuaTlW?=
 =?utf-8?B?SlNFcEhob01iNFJNYTVpaDUvMG9uNnBZY3VvNXFNa3ZIUjhCZzZpYmNOS3lS?=
 =?utf-8?B?WTVlT2FaUTRZUXo3RSt1SVVZOVJMckFZOXQ3L29za1E5dWpQZ1J0RE1EZ3Ir?=
 =?utf-8?B?dTBkUExZZittQUZVMFpjdE92U2o2RkNBSlNibWpTZmpPbEk2VjFHaURTS1pL?=
 =?utf-8?B?UlJIbm4wajQxS1FFYmlFcmVVdmxBQUNsNjA4R0hHWTFsdUFnUlc5R2FOTGR2?=
 =?utf-8?B?cDhFQmNoZlFSQ1FseEozakNsaEVUMzFZTFkyZEdNcmR1cXNpeTJ5b1BCd0ww?=
 =?utf-8?B?R1BGL1pWVC9uR0ZKQjBYQjdNVVBrR3VkVnlpZmFHaml2KzB5K2pMbGRuQTRC?=
 =?utf-8?B?M053TWtlbTY2LzFDTDVBclU5MFh3VmJ5OXhEMGtpdUM3ZG5DblM2QmJ5TFg4?=
 =?utf-8?B?RGZoT0ZZYVU1K1NyeXMwMDAzWnRNMjl0bTBMVnVlVVNQMGVmTlFtSy9IZmRm?=
 =?utf-8?B?MHFmS1lwaHAzbjh5aWhYR1hWMWsvR0tIKzhjSXNFNFVwSktIK2JpQVNkMHdV?=
 =?utf-8?B?N05nTVBBcWRucXMyMjJDc01lUFMxUU96cnJQMU42M1d4OGJuNnRJV2FnTTBH?=
 =?utf-8?B?b2R1TTlmNFRSVkF3UUp6VU8yTFZFVGxqZmtqQTVscmxTRWdPeCtzN1hIcmJM?=
 =?utf-8?B?ay84RUFIZlErODdTZDNZK05PWVBiSUU0eWl0OEZwcnNuZ2tSeXRDR1UwTXNQ?=
 =?utf-8?B?VmJCRVhid3Q1a0J3VXdMbVFidjI4QzMxRHZKN29MeVgxb0FZQVYvenUxUXRQ?=
 =?utf-8?B?Kzl1UHRYME1UVjBROEQ0QmFkNlY3UjN1MzlHTldkUzhQNkE5WkdLVGh0bS9X?=
 =?utf-8?B?MUR0TDNLaER1VUM0MjJ3V1BTbW1ETGNSVEd2NUd2aW4wTi9kZW5yUkcwR3E0?=
 =?utf-8?B?aEpTaEN1cGs4eUJieUNxVWJYd1ZQMk8zR2R4Z3hyTDlKQ2JpQ09BRVRLV2d0?=
 =?utf-8?B?UW1XUkxzWC9SZnNjUGM5UlpiUHh4WkQxMS91QWExSW41QXhnRkYzTTNEVGtm?=
 =?utf-8?B?d0NKQnk0WDJ1RjVUUENIVjh6QnRxRVpvaTMrU1FCSElTbnlPeXRPbE5za09E?=
 =?utf-8?B?elRhZkxzSUVWUmo4K1ZXN2w3UUt3WlFKZnpJZDlQbDRzVnN0V3R6SUdnOS8z?=
 =?utf-8?B?SWRzZ0dSTThrWWpJdW1zYnVTWnZITzhUL0hzMGlNaHBYRWZSQ2thNzR6TU1V?=
 =?utf-8?B?U0ZYUmxDYUVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEZWOXlJZzVqSm50eFFHTDhFZjZCMDBrak5PQjlDRVB4QlUvaWNsL2pCTHla?=
 =?utf-8?B?c3BYWnNPRTlJN2tvdlFjK2RPZmxsNW9WL2RwTUxONTJQQW5IRC9Ud0pRNW9w?=
 =?utf-8?B?MnZOR0pEUjlVS2MxL1FpOTE3UWRka0J2bFBoMzhFb2RzRTdLZTVad3RPby9O?=
 =?utf-8?B?bmxKOGFodDRCWmxxeUhPNTR4YTVRUktXeVNGTFNibDBENERRRktlSnBQYUZ1?=
 =?utf-8?B?SVRKeUEyK2NwYmN2TzZmcVoxWFF6c2VhU2JwRGMyRGViVTcwWFhKbXFMcHRh?=
 =?utf-8?B?WmpFdmhCRFFhYjRtMHpjLzc1d1lodnhHV25FNldxeG1wQ3ZDSXdyZHFPU3ZB?=
 =?utf-8?B?dGNZNy9SdXk2eUZWcnZ1SkdvbmFpQWN3WEYyekp6UFZ2alBocm8vNWZSMVQv?=
 =?utf-8?B?SjAwaC9OL3ZjNXRJOHhRNWZlY1NUT3lrSTlWR29wbi9EdzlIbFh0Ny95Q0xo?=
 =?utf-8?B?U21lQURxVUs4RTVqTXRXdXNCV0lnZzU2cHA5VHhoOW11NXdoOU9odXZ2SkZH?=
 =?utf-8?B?MUxrUS9tSmk1djRadEtSU3RUT3Fiem01eHliRkxCMVM3N2dEUmVGbkVDbVFm?=
 =?utf-8?B?ZVU2dVc4dDJOdFhkT0JDNldFRjRWcHpIWGZnYjRQS244NE9JNTRPakJuTVZs?=
 =?utf-8?B?NUMyTm9ZbTh3bWs0aDNJcFVKR3h2cGJmRUJja0RWakRJQVVibkFKK3A1Vk9x?=
 =?utf-8?B?RER0QzJRZW80WnJxeDkzbjJVRXdNd25TMk83d2JBck8yTWtkYzFiN3A5M2R6?=
 =?utf-8?B?aVRMTjBFTk1UcHBPakMzNzJmeEpNL2JmcnhlT1hKbk15cnpranBzbFY1V1li?=
 =?utf-8?B?MHdmMlcyUG5SUnFJeVBDZFc2R0RjSVpteG5raWI0N0FQVzhYZ3pZa2FDY2ZD?=
 =?utf-8?B?VjRzZXVGTk9ucEkxYUtaaGlsVkNzM0NFOTBJdTFCYW1mVDVCSnJ4eXBvai9r?=
 =?utf-8?B?c0RMOWhoWjYwdVBSNWYxbUVRaFJzczhwa0NuRHlqOGUrV1N2VVdjejNqbjFJ?=
 =?utf-8?B?MVhWaDFnUUl1RnF2L0lhQVBPbXJVMkt4OUwxZzlTM3MzbXVyamlUZktXYTM0?=
 =?utf-8?B?eTRZdXNsSS9HWE1HNERxdXdaQzUxK1RiVWJIdFlCUWt2ZGtpWkRuZ2M0WEFx?=
 =?utf-8?B?eU10OHQ5L1liM25PUXpnKzFMUWw5Y1ZvR3lxUW5JYXNxTDZ6MmtFeHFMbk1V?=
 =?utf-8?B?NENXR2ZZd0dUQzRwMDFXcjc5RGhraDFib0h4UDMvUVUyUUVYMVdrZ3NTcTVH?=
 =?utf-8?B?ZnpVMSswMnlvY2U0OFd2bmRyZFBLS3ExaWc5ek1vU1g4UTVVVlVCSzh0Wk84?=
 =?utf-8?B?NVJUTW8rcGFVQkVpNFErUVRZcnJ3YlJ1RXdDMUFxekd0eEd0U0xXdEtaV3dU?=
 =?utf-8?B?eXdGSHNkeDZxWXR1VnBoajFKd2FLOGpFamZsaGZ5dldrYk1VT3ZKNWM0UHhQ?=
 =?utf-8?B?Z1ZqeDVBNGFyNi9keElkYXRvNHcyeXhyek1sWFpIbktFYmxhd3diRGF2eTdW?=
 =?utf-8?B?UXErZXpUSnNFTWpuYmJEaWtTalFvVm93TUxCSnNpWG5BZDg4UUR3VEZsVm9K?=
 =?utf-8?B?RkhYZHI3M0Q3L1RlZE91MW1JY2ZmbGRaM3ZlbVdRRG9hOFhabFV1WkdLbG16?=
 =?utf-8?B?WTVwRlVFbEVra1piZ1N2aytpQ0ZKY3RnNmcwdmphczhlR25QT0VsanNoaVEy?=
 =?utf-8?B?akRxMWtUbUtnZk83eE5TVW5heDFxTEtIazFFVG1OdmRBcVBYaXNpVVdNcHFS?=
 =?utf-8?B?T29pTWJ0RTZZVVR2d0VyaEIyOU1YYi9YblBkM1R1cjZPa2RzaC9hMlBDT05o?=
 =?utf-8?B?dFhXR0FPNExxcDRpT3FmdEY3YjZhYzc1SDltbmRwbVk4OWcvUjEyUkF5aTYz?=
 =?utf-8?B?WEdiYWc1ZTg0dFN3V3Y1UXRBNExiQVRURytrSmZVTitoamI2SjV2Zi9EeGhI?=
 =?utf-8?B?VGthQ0FXM2lLVG5CMUtQOWJXQTU5aktLc2tJbit5NTdkNGwzcVhLNlNSZ0NB?=
 =?utf-8?B?S2srUE9JeTFBL2UxcGlxRXd3M0locjN5WW0rSlFrOXV6Q2htTDlOVjJ4UGFM?=
 =?utf-8?B?WHRtRExNUCtrQVh1cGxXZ1VJRTBURjREaUo0b2VRVVZoQXA1OVNnQU4yelpH?=
 =?utf-8?B?ZTd5Y2tZTjMwYmo1ZnNpdTNiM1d4VDdHZzFMaFByT1FjQXgzNi96R0xiOGV6?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	huQ0apIKoBmnX2G3SbC3pGLs6PWkXaGIE61wgm+7XhZ7tDic11WhQBjcXfU6+4lne5DtaQmibiyG84q3BNE0azvaYM3zyw6I7PVhDfyCWuDyQjfaEpKfrlp5dda6hKr62dAAk8XC7Um+NeZcPQuS5pvcKTFVel3D2v2KWhFjiwFY7Z8G0bEFDDzASNrzTF5HA9moBoRYHWeqAYMEpW5bXGejyzsIa1cTj5N8aO+hL6YnU4sC6paForPkGo4eAya8C0HNcCqNSIyUjokJbounA7t01H9VbkET5hTRd+zHbCYFDHpdz3CohDGHhtOTLxikwlFqQgspLYsIZaLDFbl0WMeTPNvjRDB6JaHAFJw6FtkBpE5eNHieIA+1zD7Fv+0PZKtIhW9fAPVGrK6LRCvRb56BXH5cv9a2VlroF5U70HBZA2pCtB50Z4mLzDPX1EBQg4JIMiIZqd/xdZDcslPAn2PpkjawvX5cQezW0NTy1I+uut59G+0mOusiOGcY7/MB2jzFKhqb47QT1eopIB9Xh829vLkRZxNoiowOwXI/cooIOTtIedNyUXjnSdz7sCGXvNfPicJpzEiBoYqh/TndNQ/l3avGIHqElXLIRn278ZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe8afcb-8edd-4fa2-492a-08dd9156db3a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 13:13:59.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBwg8vbt4VEX0r5YRHF1K5r2SJibRk6NaWUx/V79bLzpdQ6pLrw7uDh3vd2emXSK7xx/ZfTMTvDKFj+cQszCPfKp4vJ0Mlqtx6QrEzfuSpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEzOCBTYWx0ZWRfXy2A3ut1e9rvx 8b+Xj9FxW0wE4xLAlouVBfDTTBj30zp8essE6/cwbgjpB9K0SjW/H9vCE6JKesWQxpuSOIoH6H/ yyvMhCO7OUw/4qJQJ+97lBiI4l1PTUCRQ8IlhwJSFLFDSwgFiclslsphY/ydmM2pL1KbiTNdYhO
 kWPpQxymgj5qu2lIxJvDoQN7P/+uiomWKEXQ+SmSAiNUfl6NkHti0J93zA5TtVK6b1IzoyRsLKQ ovWa5JQK6FFc+3NruveoT7ghFWFAxKjezKiWkxg2Mfj6P8Dc+peTL6XHWDUBuqGCLkSeh1QAAzM YVLtZ2SJNrT3yfNlpBEalME+vOyMX8lwy7o8a2os6LhHrNIoywC3ojKMIkfnWHNEDg3GZpdNgAU
 bohKAzmAlTcs/Zv0ID7CDcJAFlbeLSgfDRZ+3O6F3qaUElcOnfAJp8LfHY9MTi+u2BR0mVvh
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=6821f41c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=t-LZax-3gJhpjE2LISkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: kzqn3DV4MpnYvzPSbrDzl9S9hxAVhfDf
X-Proofpoint-GUID: kzqn3DV4MpnYvzPSbrDzl9S9hxAVhfDf



On 12-05-2025 04:37, Roman Kisel wrote:
> Confidential VMBus employs the paravisor SynIC pages to implement
> the control plane of the protocol, and the data plane may use
> encrypted pages.
> 
> Implement scanning the additional pages in the control plane,
> and update the logic not to decrypt ring buffer and GPADLs (GPA
> descr. lists) unconditionally.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c |  23 +-
>   drivers/hv/channel.c           |  36 +--
>   drivers/hv/channel_mgmt.c      |  29 +-
>   drivers/hv/connection.c        |  10 +-
>   drivers/hv/hv.c                | 485 ++++++++++++++++++++++++---------
>   drivers/hv/hyperv_vmbus.h      |   9 +-
>   drivers/hv/ring_buffer.c       |   5 +-
>   drivers/hv/vmbus_drv.c         | 140 +++++-----
>   8 files changed, 518 insertions(+), 219 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 4f6e3d02f730..4163bc24269e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -28,6 +28,7 @@
>   #include <asm/apic.h>
>   #include <asm/timer.h>
>   #include <asm/reboot.h>
> +#include <asm/msr.h>
>   #include <asm/nmi.h>
>   #include <clocksource/hyperv_timer.h>
>   #include <asm/numa.h>
> @@ -77,14 +78,28 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>   
>   void hv_set_non_nested_msr(unsigned int reg, u64 value)
>   {
> +	if (reg == HV_X64_MSR_EOM && vmbus_is_confidential()) {
> +		/* Reach out to the paravisor. */
> +		native_wrmsrl(reg, value);
> +		return;
> +	}
> +
>   	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
> +		/* The hypervisor will get the intercept. */
>   		hv_ivm_msr_write(reg, value);
>   
> -		/* Write proxy bit via wrmsl instruction */

is there a specific reason for using native_wrmsrl() instead of the 
standard wrmsrl()?
If the intention is to bypass paravisor handling and write directly to 
the hypervisor or any other reason explicitly stating that in the comment.

> -		if (hv_is_sint_msr(reg))
> -			wrmsrl(reg, value | 1 << 20);
> +		if (hv_is_sint_msr(reg)) {
> +			/*
> +			 * Write proxy bit in the case of non-confidential VMBus control plane.
> +			 * Using wrmsl instruction so the following goes to the paravisor.
> +			 */
> +			u32 proxy = 1 & !vmbus_is_confidential();

bit unusual
u32 proxy = !vmbus_is_confidential() ? 1 : 0;

> +
> +			value |= (proxy << 20);
> +			native_wrmsrl(reg, value);
> +		}
>   	} else {
> -		wrmsrl(reg, value);
> +		native_wrmsrl(reg, value);
>   	}
>   }
>   EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index fb8cd8469328..ef540b72f6ea 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -443,20 +443,23 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>   		return ret;
>   	}
>   
> -	/*
> -	 * Set the "decrypted" flag to true for the set_memory_decrypted()
> -	 * success case. In the failure case, the encryption state of the
> -	 * memory is unknown. Leave "decrypted" as true to ensure the
> -	 * memory will be leaked instead of going back on the free list.
> -	 */
> -	gpadl->decrypted = true;
> -	ret = set_memory_decrypted((unsigned long)kbuffer,
> -				   PFN_UP(size));
> -	if (ret) {
> -		dev_warn(&channel->device_obj->device,
> -			 "Failed to set host visibility for new GPADL %d.\n",
> -			 ret);
> -		return ret;
> +	if ((!channel->confidential_external_memory && type == HV_GPADL_BUFFER) ||
> +		(!channel->confidential_ring_buffer && type == HV_GPADL_RING)) {
> +		/*
> +		 * Set the "decrypted" flag to true for the set_memory_decrypted()
> +		 * success case. In the failure case, the encryption state of the
> +		 * memory is unknown. Leave "decrypted" as true to ensure the
> +		 * memory will be leaked instead of going back on the free list.
> +		 */
> +		gpadl->decrypted = true;
> +		ret = set_memory_decrypted((unsigned long)kbuffer,
> +					PFN_UP(size));
> +		if (ret) {
> +			dev_warn(&channel->device_obj->device,
> +				"Failed to set host visibility for new GPADL %d.\n",
> +				ret);
> +			return ret;
> +		}
>   	}
>   
>   	init_completion(&msginfo->waitevent);
> @@ -676,12 +679,13 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>   		goto error_clean_ring;
>   
>   	err = hv_ringbuffer_init(&newchannel->outbound,
> -				 page, send_pages, 0);
> +				 page, send_pages, 0, newchannel->confidential_ring_buffer);
>   	if (err)
>   		goto error_free_gpadl;
>   
>   	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
> -				 recv_pages, newchannel->max_pkt_size);
> +				 recv_pages, newchannel->max_pkt_size,
> +				 newchannel->confidential_ring_buffer);
>   	if (err)
>   		goto error_free_gpadl;
>   
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 6e084c207414..39c8b80d967f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -843,14 +843,14 @@ static void vmbus_wait_for_unload(void)
>   				= per_cpu_ptr(hv_context.cpu_context, cpu);
>   
>   			/*
> -			 * In a CoCo VM the synic_message_page is not allocated
> +			 * In a CoCo VM the hv_synic_message_page is not allocated
>   			 * in hv_synic_alloc(). Instead it is set/cleared in
>   			 * hv_synic_enable_regs() and hv_synic_disable_regs()
>   			 * such that it is set only when the CPU is online. If
>   			 * not all present CPUs are online, the message page
>   			 * might be NULL, so skip such CPUs.
>   			 */
> -			page_addr = hv_cpu->synic_message_page;
> +			page_addr = hv_cpu->hv_synic_message_page;
>   			if (!page_addr)
>   				continue;
>   
> @@ -891,7 +891,7 @@ static void vmbus_wait_for_unload(void)
>   		struct hv_per_cpu_context *hv_cpu
>   			= per_cpu_ptr(hv_context.cpu_context, cpu);
>   
> -		page_addr = hv_cpu->synic_message_page;
> +		page_addr = hv_cpu->hv_synic_message_page;
>   		if (!page_addr)
>   			continue;
>   
> @@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   	struct vmbus_channel_offer_channel *offer;
>   	struct vmbus_channel *oldchannel, *newchannel;
>   	size_t offer_sz;
> +	bool confidential_ring_buffer, confidential_external_memory;
>   
>   	offer = (struct vmbus_channel_offer_channel *)hdr;
>   
> @@ -1033,6 +1034,18 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   		return;
>   	}
>   
> +	confidential_ring_buffer = is_confidential_ring_buffer(offer);
> +	if (confidential_ring_buffer) {
> +		if (vmbus_proto_version < VERSION_WIN_COPPER || !vmbus_is_confidential())
> +			return;
> +	}
> +
> +	confidential_external_memory = is_confidential_external_memory(offer);
> +	if (is_confidential_external_memory(offer)) {
> +		if (vmbus_proto_version < VERSION_WIN_COPPER || !vmbus_is_confidential())
> +			return;
> +	}
> +
>   	oldchannel = find_primary_channel_by_offer(offer);
>   
>   	if (oldchannel != NULL) {
> @@ -1069,6 +1082,14 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   
>   		atomic_dec(&vmbus_connection.offer_in_progress);
>   
> +		if ((oldchannel->confidential_ring_buffer && !confidential_ring_buffer) ||
> +				(oldchannel->confidential_external_memory &&
> +				!confidential_external_memory)) {
> +			pr_err_ratelimited("Offer %d changes the confidential state\n",
> +				offer->child_relid);
> +			return;
> +		}
> +
>   		WARN_ON(oldchannel->offermsg.child_relid != INVALID_RELID);
>   		/* Fix up the relid. */
>   		oldchannel->offermsg.child_relid = offer->child_relid;
> @@ -1111,6 +1132,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>   		pr_err("Unable to allocate channel object\n");
>   		return;
>   	}
> +	newchannel->confidential_ring_buffer = confidential_ring_buffer;
> +	newchannel->confidential_external_memory = confidential_external_memory;
>   
>   	vmbus_setup_channel_state(newchannel, offer);
>   
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 8351360bba16..268b7d58b45b 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -51,7 +51,8 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
>    * Linux guests and are not listed.
>    */
>   static __u32 vmbus_versions[] = {
> -	VERSION_WIN10_V5_3,
> +	VERSION_WIN_COPPER,
> +	VERSION_WIN_IRON,
>   	VERSION_WIN10_V5_2,
>   	VERSION_WIN10_V5_1,
>   	VERSION_WIN10_V5,
> @@ -65,7 +66,7 @@ static __u32 vmbus_versions[] = {
>    * Maximal VMBus protocol version guests can negotiate.  Useful to cap the
>    * VMBus version for testing and debugging purpose.
>    */
> -static uint max_version = VERSION_WIN10_V5_3;
> +static uint max_version = VERSION_WIN_COPPER;
>   
>   module_param(max_version, uint, S_IRUGO);
>   MODULE_PARM_DESC(max_version,
> @@ -105,6 +106,11 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>   		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
>   	}
>   
> +	if (vmbus_is_confidential() && version >= VERSION_WIN_COPPER)
> +		msg->feature_flags = VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
> +	else
> +		msg->feature_flags = 0;
> +
>   	/*
>   	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
>   	 * bitwise OR it
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..94be5b3f9e70 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -74,7 +74,7 @@ int hv_post_message(union hv_connection_id connection_id,
>   	aligned_msg->payload_size = payload_size;
>   	memcpy((void *)aligned_msg->payload, payload, payload_size);
>   
> -	if (ms_hyperv.paravisor_present) {
> +	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {
>   		if (hv_isolation_type_tdx())
>   			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE,
>   						  virt_to_phys(aligned_msg), 0);
> @@ -94,11 +94,135 @@ int hv_post_message(union hv_connection_id connection_id,
>   	return hv_result(status);
>   }
>   
> +enum hv_page_encryption_action {
> +	HV_PAGE_ENC_DEAFULT,
> +	HV_PAGE_ENC_ENCRYPT,
> +	HV_PAGE_ENC_DECRYPT

typo in the enc_action enum check.
enum HV_PAGE_ENC_DEAFULT is misspelled. It should be corrected to 
HV_PAGE_ENC_DEFAULT.

> +};
> +
> +static int hv_alloc_page(unsigned int cpu, void **page, enum hv_page_encryption_action enc_action,
> +	const char *note)
> +{
> +	int ret = 0;
> +
> +	pr_debug("allocating %s\n", note);
> +
> +	/*
> +	 * After the page changes its encryption status, its contents will
> +	 * appear scrambled. Thus `get_zeroed_page` would zero the page out
> +	 * in vain, we do that ourselves exactly one time.
> +	 *
> +	 * The function might be called from contexts where sleeping is very
> +	 * bad (like hotplug callbacks) or not possible (interrupt handling),
> +	 * Thus requesting `GFP_ATOMIC`.
> +	 *
> +	 * The page order is 0 as we need 1 page and log_2 (1) = 0.
> +	 */
> +	*page = (void *)__get_free_pages(GFP_ATOMIC, 0);
> +	if (!*page)
> +		return -ENOMEM;
> +
> +	pr_debug("allocated %s\n", note);
> +
> +	switch (enc_action) {
> +	case HV_PAGE_ENC_ENCRYPT:
> +		ret = set_memory_encrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DECRYPT:
> +		ret = set_memory_decrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DEAFULT:

HV_PAGE_ENC_DEFAULT

> +		break;
> +	default:
> +		pr_warn("unknown page encryption action %d for %s\n", enc_action, note);
> +		break;
> +	}
> +
> +	if (ret)
> +		goto failed;
> +
> +	memset(*page, 0, PAGE_SIZE);
> +	return 0;
> +
> +failed:
> +

remove \n

> +	pr_err("page encryption action %d failed for %s, error %d when allocating the page\n",

"Encryption action %d failed for %s: allocation error %d\n"

> +		enc_action, note, ret);
> +	free_page((unsigned long)*page);
> +	*page = NULL;

a '\n' before return

> +	return ret;
> +}
> +
> +static int hv_free_page(void **page, enum hv_page_encryption_action enc_action,
> +	const char *note)
> +{
> +	int ret = 0;
> +
> +	pr_debug("freeing %s\n", note);
> +
> +	if (!page)
> +		return 0;
> +	if (!*page)
> +		return 0;
> +
> +	switch (enc_action) {
> +	case HV_PAGE_ENC_ENCRYPT:
> +		ret = set_memory_encrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DECRYPT:
> +		ret = set_memory_decrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DEAFULT:

HV_PAGE_ENC_DEFAULT

> +		break;
> +	default:
> +		pr_warn("unknown page encryption action %d for %s page\n",
> +			enc_action, note);
> +		break;
> +	}
> +
> +	/*
> +	 * In the case of the action failure, the page is leaked.
> +	 * Something is wrong, prefer to lose the page and stay afloat.
> +	 */
> +	if (ret) {
> +		pr_err("page encryption action %d failed for %s, error %d when freeing\n",
> +			enc_action, note, ret);
> +	} else {
> +		pr_debug("freed %s\n", note);
> +		free_page((unsigned long)*page);
> +	}
> +
> +	*page = NULL;
> +
> +	return ret;
> +}
> +
> +static bool hv_should_allocate_post_msg_page(void)
> +{
> +	return ms_hyperv.paravisor_present && hv_isolation_type_tdx();
> +}
> +
> +static bool hv_should_allocate_synic_pages(void)
> +{
> +	return !ms_hyperv.paravisor_present && !hv_root_partition();
> +}
> +
> +static bool hv_should_allocate_pv_synic_pages(void)
> +{
> +	return vmbus_is_confidential();
> +}
> +
>   int hv_synic_alloc(void)
>   {
>   	int cpu, ret = -ENOMEM;
>   	struct hv_per_cpu_context *hv_cpu;
>   
> +	const bool allocate_post_msg_page = hv_should_allocate_post_msg_page();
> +	const bool allocate_synic_pages = hv_should_allocate_synic_pages();
> +	const bool allocate_pv_synic_pages = hv_should_allocate_pv_synic_pages();
> +	const enum hv_page_encryption_action enc_action =
> +		(!vmbus_is_confidential()) ? HV_PAGE_ENC_DECRYPT : HV_PAGE_ENC_DEAFULT;
> +
>   	/*
>   	 * First, zero all per-cpu memory areas so hv_synic_free() can
>   	 * detect what memory has been allocated and cleanup properly
> @@ -122,74 +246,38 @@ int hv_synic_alloc(void)
>   		tasklet_init(&hv_cpu->msg_dpc,
>   			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
>   
> -		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->post_msg_page) {
> -				pr_err("Unable to allocate post msg page\n");
> +		if (allocate_post_msg_page) {
> +			ret = hv_alloc_page(cpu, &hv_cpu->post_msg_page,
> +				enc_action, "post msg page");
> +			if (ret)
>   				goto err;
> -			}
> -
> -			ret = set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt post msg page: %d\n", ret);
> -				/* Just leak the page, as it's unsafe to free the page. */
> -				hv_cpu->post_msg_page = NULL;
> -				goto err;
> -			}
> -
> -			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
>   		}
>   
>   		/*
> -		 * Synic message and event pages are allocated by paravisor.
> -		 * Skip these pages allocation here.
> +		 * If these SynIC pages are not allocated, SIEF and SIM pages
> +		 * are configured using what the root partition or the paravisor
> +		 * provides upon reading the SIEFP and SIMP registers.
>   		 */
> -		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> -			hv_cpu->synic_message_page =
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->synic_message_page) {
> -				pr_err("Unable to allocate SYNIC message page\n");
> +		if (allocate_synic_pages) {
> +			ret = hv_alloc_page(cpu, &hv_cpu->hv_synic_message_page,
> +				enc_action, "SynIC msg page");
> +			if (ret)
>   				goto err;
> -			}
> -
> -			hv_cpu->synic_event_page =
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->synic_event_page) {
> -				pr_err("Unable to allocate SYNIC event page\n");
> -
> -				free_page((unsigned long)hv_cpu->synic_message_page);
> -				hv_cpu->synic_message_page = NULL;
> +			ret = hv_alloc_page(cpu, &hv_cpu->hv_synic_event_page,
> +				enc_action, "SynIC event page");
> +			if (ret)
>   				goto err;
> -			}
>   		}
>   
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret = set_memory_decrypted((unsigned long)
> -				hv_cpu->synic_message_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> -				hv_cpu->synic_message_page = NULL;
> -
> -				/*
> -				 * Free the event page here so that hv_synic_free()
> -				 * won't later try to re-encrypt it.
> -				 */
> -				free_page((unsigned long)hv_cpu->synic_event_page);
> -				hv_cpu->synic_event_page = NULL;
> +		if (allocate_pv_synic_pages) {
> +			ret = hv_alloc_page(cpu, &hv_cpu->pv_synic_message_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC msg page");
> +			if (ret)
>   				goto err;
> -			}
> -
> -			ret = set_memory_decrypted((unsigned long)
> -				hv_cpu->synic_event_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> -				hv_cpu->synic_event_page = NULL;
> +			ret = hv_alloc_page(cpu, &hv_cpu->pv_synic_event_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC event page");
> +			if (ret)
>   				goto err;
> -			}
> -
> -			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> -			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
>   		}
>   	}
>   
> @@ -205,55 +293,38 @@ int hv_synic_alloc(void)
>   
>   void hv_synic_free(void)
>   {
> -	int cpu, ret;
> +	int cpu;
> +
> +	const bool free_post_msg_page = hv_should_allocate_post_msg_page();
> +	const bool free_synic_pages = hv_should_allocate_synic_pages();
> +	const bool free_pv_synic_pages = hv_should_allocate_pv_synic_pages();
>   
>   	for_each_present_cpu(cpu) {
>   		struct hv_per_cpu_context *hv_cpu =
>   			per_cpu_ptr(hv_context.cpu_context, cpu);
>   
> -		/* It's better to leak the page if the encryption fails. */
> -		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			if (hv_cpu->post_msg_page) {
> -				ret = set_memory_encrypted((unsigned long)
> -					hv_cpu->post_msg_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt post msg page: %d\n", ret);
> -					hv_cpu->post_msg_page = NULL;
> -				}
> -			}
> +		if (free_post_msg_page)
> +			hv_free_page(&hv_cpu->post_msg_page,
> +				HV_PAGE_ENC_ENCRYPT, "post msg page");
> +		if (free_synic_pages) {
> +			hv_free_page(&hv_cpu->hv_synic_event_page,
> +				HV_PAGE_ENC_ENCRYPT, "SynIC event page");
> +			hv_free_page(&hv_cpu->hv_synic_message_page,
> +				HV_PAGE_ENC_ENCRYPT, "SynIC msg page");
>   		}
> -
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			if (hv_cpu->synic_message_page) {
> -				ret = set_memory_encrypted((unsigned long)
> -					hv_cpu->synic_message_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> -					hv_cpu->synic_message_page = NULL;
> -				}
> -			}
> -
> -			if (hv_cpu->synic_event_page) {
> -				ret = set_memory_encrypted((unsigned long)
> -					hv_cpu->synic_event_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> -					hv_cpu->synic_event_page = NULL;
> -				}
> -			}
> +		if (free_pv_synic_pages) {
> +			hv_free_page(&hv_cpu->pv_synic_event_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC event page");
> +			hv_free_page(&hv_cpu->pv_synic_message_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC msg page");
>   		}
> -
> -		free_page((unsigned long)hv_cpu->post_msg_page);
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
>   	}
>   
>   	kfree(hv_context.hv_numa_map);
>   }
>   
>   /*
> - * hv_synic_init - Initialize the Synthetic Interrupt Controller.
> + * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
>    *
>    * If it is already initialized by another entity (ie x2v shim), we need to
>    * retrieve the initialized message and event pages.  Otherwise, we create and
> @@ -266,7 +337,6 @@ void hv_synic_enable_regs(unsigned int cpu)
>   	union hv_synic_simp simp;
>   	union hv_synic_siefp siefp;
>   	union hv_synic_sint shared_sint;
> -	union hv_synic_scontrol sctrl;
>   
>   	/* Setup the Synic's message page */
>   	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
> @@ -276,18 +346,18 @@ void hv_synic_enable_regs(unsigned int cpu)
>   		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>   		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>   				~ms_hyperv.shared_gpa_boundary;
> -		hv_cpu->synic_message_page =
> -			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> -		if (!hv_cpu->synic_message_page)
> +		hv_cpu->hv_synic_message_page
> +			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> +		if (!hv_cpu->hv_synic_message_page)
>   			pr_err("Fail to map synic message page.\n");
>   	} else {
> -		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
> +		simp.base_simp_gpa = virt_to_phys(hv_cpu->hv_synic_message_page)
>   			>> HV_HYP_PAGE_SHIFT;
>   	}
>   
>   	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>   
> -	/* Setup the Synic's event page */
> +	/* Setup the Synic's event page with the hypervisor. */
>   	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
>   	siefp.siefp_enabled = 1;
>   
> @@ -295,12 +365,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>   		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>   		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>   				~ms_hyperv.shared_gpa_boundary;
> -		hv_cpu->synic_event_page =
> -			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> -		if (!hv_cpu->synic_event_page)
> +		hv_cpu->hv_synic_event_page
> +			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> +		if (!hv_cpu->hv_synic_event_page)
>   			pr_err("Fail to map synic event page.\n");
>   	} else {
> -		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
> +		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->hv_synic_event_page)
>   			>> HV_HYP_PAGE_SHIFT;
>   	}
>   
> @@ -313,8 +383,24 @@ void hv_synic_enable_regs(unsigned int cpu)
>   
>   	shared_sint.vector = vmbus_interrupt;
>   	shared_sint.masked = false;
> -	shared_sint.auto_eoi = hv_recommend_using_aeoi();
> -	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +
> +	/*
> +	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> +	 * it doesn't provide a recommendation flag and AEOI must be disabled.
> +	 */
> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
> +	shared_sint.auto_eoi =
> +			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
> +#else
> +	shared_sint.auto_eoi = 0;
> +#endif
> +	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
> +				shared_sint.as_uint64);
> +}
> +
> +static void hv_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>   
>   	/* Enable the global synic bit */
>   	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
> @@ -323,13 +409,78 @@ void hv_synic_enable_regs(unsigned int cpu)
>   	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>   }
>   
> +/*
> + * The paravisor might not support proxying SynIC, and this
> + * function may fail.
> + */
> +static int hv_pv_synic_enable_regs(unsigned int cpu)
> +{
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +
> +	int err;
> +	struct hv_per_cpu_context *hv_cpu
> +		= per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Setup the Synic's message page with the paravisor. */
> +	simp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIMP, &err);
> +	if (err)
> +		return err;
> +	simp.simp_enabled = 1;
> +	simp.base_simp_gpa = virt_to_phys(hv_cpu->pv_synic_message_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	err = hv_pv_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return err;
> +
> +	/* Setup the Synic's event page with the paravisor. */
> +	siefp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIEFP, &err);
> +	if (err)
> +		return err;
> +	siefp.siefp_enabled = 1;
> +	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->pv_synic_event_page)
> +			>> HV_HYP_PAGE_SHIFT;

a '\n' before return

> +	return hv_pv_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static int hv_pv_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Enable the global synic bit */
> +	sctrl.as_uint64 = hv_pv_get_synic_register(HV_MSR_SCONTROL, &err);
> +	if (err)
> +		return err;
> +	sctrl.enable = 1;
> +
> +	return hv_pv_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>   int hv_synic_init(unsigned int cpu)
>   {
> +	int err = 0;
> +
> +	/*
> +	 * The paravisor may not support the confidential VMBus,
> +	 * check on that first.
> +	 */
> +	if (vmbus_is_confidential())
> +		err = hv_pv_synic_enable_regs(cpu);
> +	if (err)
> +		return err;
> +
>   	hv_synic_enable_regs(cpu);
> +	if (!vmbus_is_confidential())
> +		hv_synic_enable_interrupts();
> +	else
> +		err = hv_pv_synic_enable_interrupts();
> +	if (err)
> +		return err;
>   
>   	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>   
> -	return 0;
> +	return err;
>   }
>   
>   void hv_synic_disable_regs(unsigned int cpu)
> @@ -339,7 +490,6 @@ void hv_synic_disable_regs(unsigned int cpu)
>   	union hv_synic_sint shared_sint;
>   	union hv_synic_simp simp;
>   	union hv_synic_siefp siefp;
> -	union hv_synic_scontrol sctrl;
>   
>   	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
>   
> @@ -358,8 +508,8 @@ void hv_synic_disable_regs(unsigned int cpu)
>   	 */
>   	simp.simp_enabled = 0;
>   	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->synic_message_page);
> -		hv_cpu->synic_message_page = NULL;
> +		memunmap(hv_cpu->hv_synic_message_page);
> +		hv_cpu->hv_synic_message_page = NULL;
>   	} else {
>   		simp.base_simp_gpa = 0;
>   	}
> @@ -370,43 +520,97 @@ void hv_synic_disable_regs(unsigned int cpu)
>   	siefp.siefp_enabled = 0;
>   
>   	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->synic_event_page);
> -		hv_cpu->synic_event_page = NULL;
> +		memunmap(hv_cpu->hv_synic_event_page);
> +		hv_cpu->hv_synic_event_page = NULL;
>   	} else {
>   		siefp.base_siefp_gpa = 0;
>   	}
>   
>   	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>   
>   	/* Disable the global synic bit */
>   	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
>   	sctrl.enable = 0;
>   	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
>   
> +static void hv_vmbus_disable_percpu_interrupts(void)
> +{
>   	if (vmbus_irq != -1)
>   		disable_percpu_irq(vmbus_irq);
>   }
>   
> +static void hv_pv_synic_disable_regs(unsigned int cpu)
> +{
> +	/*
> +	 * The get/set register errors are deliberatley ignored in
> +	 * the cleanup path as they are non-consequential here.

typo deliberatley -> deliberately

> +	 */
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +
> +	struct hv_per_cpu_context *hv_cpu
> +		= per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Disable SynIC's message page in the paravisor. */
> +	simp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIMP, &err);
> +	if (err)
> +		return;
> +	simp.simp_enabled = 0;
> +
> +	memunmap(hv_cpu->pv_synic_message_page);
> +	hv_cpu->pv_synic_message_page = NULL;
> +
> +	err = hv_pv_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return;
> +
> +	/* Disable SynIC's event page in the paravisor. */
> +	siefp.as_uint64 = hv_pv_get_synic_register(HV_MSR_SIEFP, &err);
> +	if (err)
> +		return;
> +	siefp.siefp_enabled = 0;
> +
> +	memunmap(hv_cpu->pv_synic_event_page);
> +	hv_cpu->pv_synic_event_page = NULL;
> +
> +	hv_pv_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_pv_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Disable the global synic bit */
> +	sctrl.as_uint64 = hv_pv_get_synic_register(HV_MSR_SCONTROL, &err);
> +	if (err)
> +		return;
> +	sctrl.enable = 0;
> +	hv_pv_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>   #define HV_MAX_TRIES 3
> -/*
> - * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
> - * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
> - * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
> - *
> - * If a bit is set, that means there is a pending channel interrupt.  The expectation is
> - * that the normal interrupt handling mechanism will find and process the channel interrupt
> - * "very soon", and in the process clear the bit.
> - */
> -static bool hv_synic_event_pending(void)
> +
> +static bool hv_synic_event_pending_for(union hv_synic_event_flags *event, int sint)
>   {
> -	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
> -	union hv_synic_event_flags *event =
> -		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE_SINT;
> -	unsigned long *recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
> +	unsigned long *recv_int_page;
>   	bool pending;
>   	u32 relid;
> -	int tries = 0;
> +	int tries;
> +
> +	if (!event)
> +		return false;
>   
> +	tries = 0;
> +	event += sint;
> +	recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
>   retry:
>   	pending = false;
>   	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> @@ -460,6 +664,26 @@ static int hv_pick_new_cpu(struct vmbus_channel *channel)
>   /*
>    * hv_synic_cleanup - Cleanup routine for hv_synic_init().
>    */
> +/*
> + * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
> + * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
> + * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
> + *
> + * If a bit is set, that means there is a pending channel interrupt.  The expectation is
> + * that the normal interrupt handling mechanism will find and process the channel interrupt
> + * "very soon", and in the process clear the bit.
> + */
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
> +	union hv_synic_event_flags *hv_synic_event_page = hv_cpu->hv_synic_event_page;
> +	union hv_synic_event_flags *pv_synic_event_page = hv_cpu->pv_synic_event_page;
> +
> +	return
> +		hv_synic_event_pending_for(hv_synic_event_page, VMBUS_MESSAGE_SINT) ||
> +		hv_synic_event_pending_for(pv_synic_event_page, VMBUS_MESSAGE_SINT);
> +}
> +
>   int hv_synic_cleanup(unsigned int cpu)
>   {
>   	struct vmbus_channel *channel, *sc;
> @@ -516,6 +740,13 @@ int hv_synic_cleanup(unsigned int cpu)
>   	hv_stimer_legacy_cleanup(cpu);
>   
>   	hv_synic_disable_regs(cpu);
> +	if (vmbus_is_confidential())
> +		hv_pv_synic_disable_regs(cpu);
> +	if (!vmbus_is_confidential())
> +		hv_synic_disable_interrupts();
> +	else
> +		hv_pv_synic_disable_interrupts();

please reconsider name as *_disable_interrupts(), imply that it is 
disabling specific interrupts rather than the SynIC control bit.

> +	hv_vmbus_disable_percpu_interrupts();
>   
>   	return ret;
>   }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 29780f3a7478..9337e0afa3ce 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -120,8 +120,10 @@ enum {
>    * Per cpu state for channel handling
>    */
>   struct hv_per_cpu_context {
> -	void *synic_message_page;
> -	void *synic_event_page;
> +	void *hv_synic_message_page;
> +	void *hv_synic_event_page;
> +	void *pv_synic_message_page;
> +	void *pv_synic_event_page;
>   
>   	/*
>   	 * The page is only used in hv_post_message() for a TDX VM (with the
> @@ -182,7 +184,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
>   void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>   
>   int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
> +		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
> +			   bool confidential);
>   
>   void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
>   
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 3c9b02471760..05c2cd42fc75 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -183,7 +183,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
>   
>   /* Initialize the ring buffer. */
>   int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
> +		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
> +			   bool confidential)
>   {
>   	struct page **pages_wraparound;
>   	int i;
> @@ -207,7 +208,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>   
>   	ring_info->ring_buffer = (struct hv_ring_buffer *)
>   		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -			pgprot_decrypted(PAGE_KERNEL));
> +			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
>   
>   	kfree(pages_wraparound);
>   	if (!ring_info->ring_buffer)
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e431978fa408..375b4e45c762 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1034,12 +1034,9 @@ static void vmbus_onmessage_work(struct work_struct *work)
>   	kfree(ctx);
>   }
>   
> -void vmbus_on_msg_dpc(unsigned long data)
> +static void vmbus_on_msg_dpc_for(void *message_page_addr)
>   {
> -	struct hv_per_cpu_context *hv_cpu = (void *)data;
> -	void *page_addr = hv_cpu->synic_message_page;
> -	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
> -				  VMBUS_MESSAGE_SINT;
> +	struct hv_message msg_copy, *msg;
>   	struct vmbus_channel_message_header *hdr;
>   	enum vmbus_channel_message_type msgtype;
>   	const struct vmbus_channel_message_table_entry *entry;
> @@ -1047,6 +1044,10 @@ void vmbus_on_msg_dpc(unsigned long data)
>   	__u8 payload_size;
>   	u32 message_type;
>   
> +	if (!message_page_addr)
> +		return;
> +	msg = (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
> +
>   	/*
>   	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
>   	 * it is being used in 'struct vmbus_channel_message_header' definition
> @@ -1172,6 +1173,14 @@ void vmbus_on_msg_dpc(unsigned long data)
>   	vmbus_signal_eom(msg, message_type);
>   }
>   
> +void vmbus_on_msg_dpc(unsigned long data)
> +{
> +	struct hv_per_cpu_context *hv_cpu = (void *)data;
> +
> +	vmbus_on_msg_dpc_for(hv_cpu->hv_synic_message_page);
> +	vmbus_on_msg_dpc_for(hv_cpu->pv_synic_message_page);
> +}
> +
>   #ifdef CONFIG_PM_SLEEP
>   /*
>    * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
> @@ -1210,21 +1219,19 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
>   #endif /* CONFIG_PM_SLEEP */
>   
>   /*
> - * Schedule all channels with events pending
> + * Schedule all channels with events pending.
> + * The event page can be directly checked to get the id of
> + * the channel that has the interrupt pending.
>    */
> -static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
> +static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu, void *event_page_addr)
>   {
>   	unsigned long *recv_int_page;
>   	u32 maxbits, relid;
> +	union hv_synic_event_flags *event;
>   
> -	/*
> -	 * The event page can be directly checked to get the id of
> -	 * the channel that has the interrupt pending.
> -	 */
> -	void *page_addr = hv_cpu->synic_event_page;
> -	union hv_synic_event_flags *event
> -		= (union hv_synic_event_flags *)page_addr +
> -					 VMBUS_MESSAGE_SINT;
> +	if (!event_page_addr)
> +		return;
> +	event = (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE_SINT;
>   
>   	maxbits = HV_EVENT_FLAGS_COUNT;
>   	recv_int_page = event->flags;
> @@ -1295,26 +1302,35 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
>   	}
>   }
>   
> -static void vmbus_isr(void)
> +static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message_page_addr)
>   {
> -	struct hv_per_cpu_context *hv_cpu
> -		= this_cpu_ptr(hv_context.cpu_context);
> -	void *page_addr;
>   	struct hv_message *msg;
>   
> -	vmbus_chan_sched(hv_cpu);
> -
> -	page_addr = hv_cpu->synic_message_page;
> -	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
> +	if (!message_page_addr)
> +		return;
> +	msg = (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
>   
>   	/* Check if there are actual msgs to be processed */
>   	if (msg->header.message_type != HVMSG_NONE) {
>   		if (msg->header.message_type == HVMSG_TIMER_EXPIRED) {
>   			hv_stimer0_isr();
>   			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
> -		} else
> +		} else {
>   			tasklet_schedule(&hv_cpu->msg_dpc);
> +		}
>   	}
> +}
> +
> +static void vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu
> +		= this_cpu_ptr(hv_context.cpu_context);
> +
> +	vmbus_chan_sched(hv_cpu, hv_cpu->hv_synic_event_page);
> +	vmbus_chan_sched(hv_cpu, hv_cpu->pv_synic_event_page);
> +
> +	vmbus_message_sched(hv_cpu, hv_cpu->hv_synic_message_page);
> +	vmbus_message_sched(hv_cpu, hv_cpu->pv_synic_message_page);
>   
>   	add_interrupt_randomness(vmbus_interrupt);
>   }
> @@ -1325,11 +1341,35 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static void vmbus_percpu_work(struct work_struct *work)
> +static int vmbus_setup_control_plane(void)
>   {
> -	unsigned int cpu = smp_processor_id();
> +	int ret;
> +	int hyperv_cpuhp_online;
> +
> +	ret = hv_synic_alloc();
> +	if (ret < 0)
> +		goto err_alloc;
>   
> -	hv_synic_init(cpu);
> +	/*
> +	 * Initialize the per-cpu interrupt state and stimer state.
> +	 * Then connect to the host.
> +	 */
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> +				hv_synic_init, hv_synic_cleanup);
> +	if (ret < 0)
> +		goto err_alloc;
> +	hyperv_cpuhp_online = ret;
> +	ret = vmbus_connect();
> +	if (ret)
> +		goto err_connect;
> +	return 0;
> +
> +err_connect:
> +	cpuhp_remove_state(hyperv_cpuhp_online);
> +	return -ENODEV;
> +err_alloc:
> +	hv_synic_free();
> +	return -ENOMEM;
>   }
>   
>   /*
> @@ -1342,8 +1382,7 @@ static void vmbus_percpu_work(struct work_struct *work)
>    */
>   static int vmbus_bus_init(void)
>   {
> -	int ret, cpu;
> -	struct work_struct __percpu *works;
> +	int ret;
>   
>   	ret = hv_init();
>   	if (ret != 0) {
> @@ -1378,41 +1417,21 @@ static int vmbus_bus_init(void)
>   		}
>   	}
>   
> -	ret = hv_synic_alloc();
> -	if (ret)
> -		goto err_alloc;
> -
> -	works = alloc_percpu(struct work_struct);
> -	if (!works) {
> -		ret = -ENOMEM;
> -		goto err_alloc;
> -	}
> -
>   	/*
> -	 * Initialize the per-cpu interrupt state and stimer state.
> -	 * Then connect to the host.
> +	 * Attempt to establish the confidential control plane first if this VM is
> +	.* a hardware confidential VM, and the paravisor is present.

remove . (dott)

>   	 */
> -	cpus_read_lock();
> -	for_each_online_cpu(cpu) {
> -		struct work_struct *work = per_cpu_ptr(works, cpu);
> +	ret = -ENODEV;
> +	if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isolation_type_snp())) {
> +		is_confidential = true;
> +		ret = vmbus_setup_control_plane();
> +		is_confidential = ret == 0;

is_confidential flag is somewhat ambiguous. ?
The flag is set to true before the control plane setup and then 
conditionally reset based on the return value of vmbus_setup_control_plane()
could be clarified it, for better readability and maintainability.

and  is_confidential = (ret == 0); or is_confidential = !ret; more generic.

>   
> -		INIT_WORK(work, vmbus_percpu_work);
> -		schedule_work_on(cpu, work);
> +		pr_info("VMBus control plane is confidential: %d\n", is_confidential);
>   	}
>   
> -	for_each_online_cpu(cpu)
> -		flush_work(per_cpu_ptr(works, cpu));
> -
> -	/* Register the callbacks for possible CPU online/offline'ing */
> -	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> -						   hv_synic_init, hv_synic_cleanup);
> -	cpus_read_unlock();
> -	free_percpu(works);
> -	if (ret < 0)
> -		goto err_alloc;
> -	hyperv_cpuhp_online = ret;
> -
> -	ret = vmbus_connect();
> +	if (!is_confidential)
> +		ret = vmbus_setup_control_plane();
>   	if (ret)
>   		goto err_connect;
>   
> @@ -1428,9 +1447,6 @@ static int vmbus_bus_init(void)
>   	return 0;
>   
>   err_connect:
> -	cpuhp_remove_state(hyperv_cpuhp_online);
> -err_alloc:
> -	hv_synic_free();
>   	if (vmbus_irq == -1) {
>   		hv_remove_vmbus_handler();
>   	} else {


Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

please consider RB for series.

Thanks,
Alok

