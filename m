Return-Path: <linux-arch+bounces-8851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F439BC84D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 09:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DBB21E84
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7F1CCB44;
	Tue,  5 Nov 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDVmuZh2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FC1C1738;
	Tue,  5 Nov 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796447; cv=fail; b=cer+CgFKCjWnhAcTmGw97BaCRQ/W5c9+tQjcwWBFibW80uLBpGm3UyfCA0dDdkougB/9iaUq3VH4igX2B011XvdBwBghpoY0VaRhKr+mkpwDTU4K0dQ70wt/zG5JH3iqdTGXjmLOypD9qGrZhT4AtKxHbt1ZExuRUbkr4GcdgLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796447; c=relaxed/simple;
	bh=J885qS9ifUf4nvCmgAdAPy4C4Y+Q1TInz4ZrNi20ptE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=neocBjYkXiHjOGdGvs8GEPR+WlVtCljToFcv2w42vQDO7h1VMoLRY8Jdhhcc5AWNNwNV4/Cnroh9otIPoelMZhnpyO129Pul+LOGTMy3Eqcb7IilBWCmlXzrQCOn9VjyO20jffxBW2x1C7yfXpookXAmz3r74G9bPRUHe5XAAIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDVmuZh2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730796445; x=1762332445;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=J885qS9ifUf4nvCmgAdAPy4C4Y+Q1TInz4ZrNi20ptE=;
  b=YDVmuZh2rzGQsFFsShEnpbAvNrLh/Da8U/Ug/4vCf9f5jcAncQ/mSmzY
   U5HJfVOxNHmxWjx4eQuKMo3abg9LxW8EwqUuCabUZJXRucax0UCBJPQGu
   +6CPyJwuKiB/FKGKNeJhmH6l2PFkdJfWj9V7ly0qA7ZxOsN+q3WoRmQ52
   2Ru6EyMlzc31NcJUdPFn4TnRbbqwnKydyY82MszVlLhcmwMyvkyHICdzN
   rSXRwIQQOA6NV5oiLdjvYTrKjn9Y5/mwUz6Q7KWE9gS9nxPKs5fMuup0x
   OTZyoD/My9ugdaD1Genq0ooBqpE6F0xviczdv63BOtIz/NTViMnjacuuk
   Q==;
X-CSE-ConnectionGUID: ooX5NE7OQ3iwup6QUWP2JA==
X-CSE-MsgGUID: CNzMtlnkTc+0NXNmoFs1+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30409207"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="30409207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 00:47:24 -0800
X-CSE-ConnectionGUID: cFJvsXJnT9yr9/r6HK10SQ==
X-CSE-MsgGUID: 2ZAWXvMWRXCzLdWQU6wDeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83590043"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 00:47:24 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 00:47:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 00:47:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 00:47:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzg5Iv1LCyc6LsSW6n4Ll7csEEvcnqrOo3WywFWyCYJxkalMgfv6UhYUvAY4RaNUZyprx7t8SacBzRDO6tBgHEMNcaPUMr9qql6ocakdof6OhsEaS5BFP0Jw+KPBehNBRS9MSyNeAoB8y9ZIj/HUI7JKMvfQceUgmrVTfqNt5M6wsMAZVmDtq1uXQIm0qtLKYpx83AvTBEh9WhN+XiBi61OmWGPvhsQSO4N8H92ZovzESrDi1yHOD5mpgYySo/h80UdyzpaeqeoiQJUsfZbgZs5ojOGC+c5AlY/RMXcMnZjO7GzfYLiOVZjdiFRSOBnwMq2ub8ri2udHJ3aWHzmBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKvC2VLYYGmkddfvKt4tSDJe3h3T6ePcDHlS4z9qtJ0=;
 b=kRVCDSLc8Mka5vp1Q8Tr0AkxCXXTVOSLXuzA5qpDoIFpUqA/Klauk+EhNhy6PcDHi5a62CaV7CjG8/tJqm9Wjxi10VgIFtSaVGCVwz9hULr+QWveuf465q+LHkjFpScmLZwaUiYWu5JRwuNv5XF129O/Aq8IfAVqyN4EnHaV0YyMroH7fbAQJTTVQK03hPspyLDfLEd4fMy83XrtU3EgkcrLEiNrw9EqNB2to+WmhYThALcZYCSiYV8hrpg6wWBW9WuG6cJ5RqATtln5kzapwL327zg5uZA5ulpGIoEjvtK4fNnZfkkdQy995SAPV4XTPnCK9DDcfctOQKy44497kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 08:47:16 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 08:47:15 +0000
Date: Tue, 5 Nov 2024 16:47:01 +0800
From: Philip Li <philip.li@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
CC: kernel test robot <lkp@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "Andrea
 Parri" <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Leonardo Bras
	<leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arch@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <ZynbhcW864CHhpDL@rli9-mobl>
References: <20241103145153.105097-14-alexghiti@rivosinc.com>
 <202411041609.gxjI2dsw-lkp@intel.com>
 <CAHVXubj8EXCXNPuJ+hqrHwyujjz3GDcqqMjQ4ZFC5VbmZurV3w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubj8EXCXNPuJ+hqrHwyujjz3GDcqqMjQ4ZFC5VbmZurV3w@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a95f27-8439-44b0-1031-08dcfd7672ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2Q2dG1qaUl0Rjc1c1FtdWhGcTBZYkdPc3A2Ymp6VjVGd0RWeFZtUTVDUndB?=
 =?utf-8?B?ZjA3K1pSTDREejdNTklBTktDOERmZXdud1g2V04rMzdYWW4wd2d1cXVlNVBT?=
 =?utf-8?B?eUFZaFhnUWl2TTNCT2hOTjhnUkU3UDROQTRWS2c1NzNoMkE3Y2tOQStrZjc2?=
 =?utf-8?B?YisyWFJPZDJtUkdTMXZvQk9IY255QWRSWjhuazB0K3M0TUY3YnlCejFNeXI3?=
 =?utf-8?B?cldsUGxjeHIrNlc5RUtwRU0wc2tIQXlqem9OdVFId3pFaTRVS0VYTUNlY0J4?=
 =?utf-8?B?VXhidW96WmJXZ2JiV2x4MFhoVFluQlNPVmFJL2NqSUZZOXNJWEJKaGwvOGVS?=
 =?utf-8?B?d0NNNzhpTUFnLzZjMWtQNFBLTVFiZmRGMW9yU1YrMDUrOS96dnVtQUpRV0V6?=
 =?utf-8?B?WTAzSnpuemc0dFpSNTROd1FXUzhnd1VqYkNMcHFCUUkyZThselNJa1JWdEE5?=
 =?utf-8?B?MU9TZnJDWTU4L0ZMT0hKb3RDSGh5WU4zaTUvU1loQnEwSnpsMHhxalhzdWxT?=
 =?utf-8?B?a2g3MWREK3FNSnFVbGRmOGRjTTdIQklGWHhiSlZ5N2dhR1lUL3NuRi8vbVNz?=
 =?utf-8?B?cUltbDlGTExiVUZUT1JaZ1U0cGRDS3BYMzhCYXl0R2JXRXJZVktlS2xIVHhC?=
 =?utf-8?B?U2dkaDdmbEFFazAxcEhwcVlrRW5RNjI4aGNpVHNrKzBMS0p5S08vTDgybnow?=
 =?utf-8?B?aUpya2ptZDVNdWF2aklWZEpZQUk2MnhCRkt3aFh0WlRSdU92dkU4bkZza0ts?=
 =?utf-8?B?QUNzNzdkZk9VQzNiczdFWGlKd0VkRmh1TlN2NzJ6clhJNkQ0V3FObGs2M1l1?=
 =?utf-8?B?Q01PWUJsQ1FKMWllY0NpcHpobnF2ZmtNOVVvYlUxVnlQZnR1NThPNTZvekZv?=
 =?utf-8?B?akk0K3hya0ZjWHNKVFRHRitIQ1JibkgvOUlZTWIxUHc5aml5Z0VlV3RGUDhQ?=
 =?utf-8?B?dmc5YndrVHJ5TzNjVjNmaGFpSW5lUFkxMEdrazQ4UytLWlRwbTFHZnFmSmw3?=
 =?utf-8?B?ZlZmcVpGSkJET1kwQTl6T2NmeG1VdHhuSnN3RFZnaTJ4VEZMeVI2YUk3NEpG?=
 =?utf-8?B?U1dRTGt1c0VCcndVQWpwQmFKS0NDMVNZNlJ0dk9PVzBHZVJxaG1ERkpqZThj?=
 =?utf-8?B?TjZuQmxLY3BNN2ZVWDlaVzYvTVVWQXlPVUpzMWdLb2JqQnljbTNpd2hLOEN5?=
 =?utf-8?B?TDBNVWhHQklNdEtIVjVtcG80aGZBbWkwa1JrRHdYSlpOMUZwUGFOM2JXeTVX?=
 =?utf-8?B?NVNUUXUzU04xZUxWRTAwVkswZkhBV2J0cGF3Tkp5OWhjY25EM3NKUjZjdkJw?=
 =?utf-8?B?NWlXTUpxZmtEaW0wenBiQXJPSHFNRm1TdkZrVkRMelFKWHQ3RzNSL21oQVJE?=
 =?utf-8?B?YUJ3ZGlxS0d5cEJKOWZEZlgvOVRSQklKalp3NXFncjZGZWx1b0huZkthakQ1?=
 =?utf-8?B?UnFVZno2M252MS9jbGFoTVhrS3RCV3AzVnVMaXB1anBoZHRkNHlEUW1nS1hD?=
 =?utf-8?B?STFiKzNoM0JXYXRFcFdOUXBRUG5LdEV3NnllWTdlYWFUYk1QZUdIV01NZlhJ?=
 =?utf-8?B?a0E3SUlaNS9WT0RTOU9mWG5rNGtXa01jUlk2ZGJFdzlTendTck1wZnY3N1cw?=
 =?utf-8?B?eGczdG9UcGRDcmt4VFprRWRqZDI3SEQzQWYwa3hFZDlmRTlzbDVZRFZ3K1pm?=
 =?utf-8?B?Z2FkeE0rb242QTh2Q3RFOVl0ZDUyc3RraGduWFduM2FqY0FNSjZWQ1JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2U5M1JJVHUzMWc1NTBUcGZPeTIzY3B6TUF4REtkZGNsbGpwUnZaYytCUC9I?=
 =?utf-8?B?Z3ZCUUx6S05KL1BlS2RRc1I0NjdKd1RKODczMndyV29uamdVSStjaVFNaXAz?=
 =?utf-8?B?YnBOUnRIWEhZYlE0QzNOM1JJMDcwRkVhbm1hemg5ZDh5OGxRenk1NmZ0N1Na?=
 =?utf-8?B?NU1YWjdWNzFKUFdLc0RucGxqY2RMWUpjakk2VE1FZ05lTUNCWVFXUTRldTkz?=
 =?utf-8?B?djlWS0QwT3h5L0J4RXNiemdUbzdoa2haL2FIN1d6VmtSeGxWbk01M0ZJZUtP?=
 =?utf-8?B?WE1jT0ZZR2MzclVYUnRKaWZya1UvQThIdllNQS9sOVpPeEVtTlVzZmhGVVJI?=
 =?utf-8?B?TWx1RmNsS2FmenFFVjE5aXdGK1lITEFSUjFubkRldkM2VC9jdGk2YitkYU96?=
 =?utf-8?B?YnJCOGhKL2lVT1BVV3J1TEVIZ2RwM2JKVGt0aE1nSGlkN21uT3MwNEJHc0dM?=
 =?utf-8?B?eVcwbmxKcUFVTXd4cE1DOVNpamtka1hzcXQyRFBFZXgrWXFwVnNvN3RaVVM1?=
 =?utf-8?B?RU4rL09QM2l3QWdQZWNKZzMzQ0dGMG1LTndPTkdnSi9WbGVyckt1VElIYStr?=
 =?utf-8?B?RStMVWExcndwWmYzd2V5aHB2c2NKbTdXSVNVUTNVQnVDWWxGZkdWaGRnNTVJ?=
 =?utf-8?B?WG1CQWtpSXNQLzEvVERHV0dibDRLbEp1V2djM2p6aTVtUFU4Z25VTnJteHJR?=
 =?utf-8?B?NzNnbkprMnREaGdvS3YxcFF4L0ltbkYyakxhMmNXUThwcXpybDBYY3B2SGJy?=
 =?utf-8?B?WDN3Sk5KTmFxK2F5TkQ4VEJUY1JqK3l2V1VqeitoUHcrclVtdkpOUUpTcEJu?=
 =?utf-8?B?QzlHcDRUa1gzMENmeXpSVjRudUIydFFLRTUvOEdEenlsVnlzUDk5U3VjYVBm?=
 =?utf-8?B?N21ISTRUdHBOb0grL2poR0VvOFZDVHllTndtdG56bkh4S3lMMnFKdkxzb0Vk?=
 =?utf-8?B?Um1RT1l2MVhZRlZnQXhjSHBtOUtNMGo3RW9kc05QT0ZaZzFYVU1YQlBrTkln?=
 =?utf-8?B?bW9Ta2s3S2hJN01PL1JxVUdnTld4V1UweXpIN0EzS0w1ZFJBdFJOUU9nU0dj?=
 =?utf-8?B?UU1sODNCMmlRTFhpYlpJTXJJVUhwTlJRdjFyQTFDZk80NjU0SlZ0NGZvWFBS?=
 =?utf-8?B?akxobFhVMno5a3FhdGxSN1pXbVg2OGFwWTRSOXhDblZONlVFUGk0TUhkOXo3?=
 =?utf-8?B?b0tVU1ZsZ1lWejZYbS9IRGpWRkcxaVdzMmpPZHdDRTZ3SzNXUmZOOTNxTkJt?=
 =?utf-8?B?MGxXS01EMVdQZUQyOUk4VjNmN1BzcVdlWWFPSmp0MzluLzY2N2d4enFoMWp3?=
 =?utf-8?B?eU9zTk5Fb0IwVVZNbktNWlM1TDZxdkVqZVRYN2FNRG5VenhCZXRhNmJVbW1O?=
 =?utf-8?B?dzF2bUdEeDZBWjNIM24yakVhTzgyVWtTVDh4RERyT1g4azBFZ0I0QVJmVVVU?=
 =?utf-8?B?MVpJM1RRNHhmaHNLUk1JOVp5VitoKzI3SWk5b1hYaVFoUTlMWlNMS2w3NFBO?=
 =?utf-8?B?VlV2Y09TUkM3UEY2OEEzY1NXME53blQxWTlURXl4bXBwbHdRMlZvTmVCY2xK?=
 =?utf-8?B?R0U4d2lHdDZSdFd3cHJqTnRMaXdnZFZSVzlocDU1bHZUY0NyMHUyODNHdUU0?=
 =?utf-8?B?M0YvaW90SzRWbzIvWWw2Sk9MVXh2V3Rkeng4a2J5RjM3WU1zQ1A4M0EvSVg5?=
 =?utf-8?B?U0VKbzdENHQzS1h5WVZtOWR5aFB1bkVvbkRPQWdsWHlXWmZwRExtQ21IcEc1?=
 =?utf-8?B?U2ExOHJLUTdHRHEwMlB0VktvM1dFbGtuaTV4RHFnM2xtdjJXdlo2dUpoRXo3?=
 =?utf-8?B?UTlTam1hc1hJb3BjNS92eFpiNjY2MmNnd2hjQTBncDhGVWZXeHd3S0dtYWZR?=
 =?utf-8?B?NFR4bnZYSGVtbld4Y2tuQVJmbWQ0K293WlJqQTBmOHJNSnFFWi9wZTFtb3V5?=
 =?utf-8?B?VFZHNmZuTjdLQXFnREZyQ0JFaEF3azNja1pKc0FEZEl2SzNoaTFmcGo4UHJO?=
 =?utf-8?B?aUppZGFFN3RHT09DT2NQeS8zM1diSFBkTjlLdERkVENJZWxESVJMenpWSG1C?=
 =?utf-8?B?eGhBYnVCdkdjaEUrWFV5ZHRKdzJJQ1Z2WVphSWhxTWwzZHcweUpGL3hoTFl4?=
 =?utf-8?Q?Gs9QggXVLp+DApAg/1t7jswSe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a95f27-8439-44b0-1031-08dcfd7672ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 08:47:15.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRvBpZWJmFQBrDGrVi1ibcjPWChNUCo6HeUX2s4sCIfpsGWOQWyZfY6edEadHMmU54G0K+RCMasktfkx19bZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com

On Mon, Nov 04, 2024 at 10:09:07AM +0100, Alexandre Ghiti wrote:
> On Mon, Nov 4, 2024 at 10:05 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Alexandre,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on arnd-asm-generic/master]
> > [also build test WARNING on robh/for-next tip/locking/core linus/master v6.12-rc6]
> > [cannot apply to next-20241101]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Move-cpufeature-h-macros-into-their-own-header/20241103-230614
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> > patch link:    https://lore.kernel.org/r/20241103145153.105097-14-alexghiti%40rivosinc.com
> > patch subject: [PATCH v6 13/13] riscv: Add qspinlock support
> > compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411041609.gxjI2dsw-lkp@intel.com/
> >
> > includecheck warnings: (new ones prefixed by >>)
> > >> arch/riscv/include/asm/spinlock.h: asm/ticket_spinlock.h is included more than once.
> > >> arch/riscv/include/asm/spinlock.h: asm/qspinlock.h is included more than once.
> 
> Yes but that's in a #ifdef/#elif#else clause so nothing to do here!

Thanks for the info, we will fix the bot. Sorry for the false positive report.

> 
> >
> > vim +10 arch/riscv/include/asm/spinlock.h
> >
> >      8
> >      9  #define __no_arch_spinlock_redefine
> >   > 10  #include <asm/ticket_spinlock.h>
> >     11  #include <asm/qspinlock.h>
> >     12  #include <asm/jump_label.h>
> >     13
> >     14  /*
> >     15   * TODO: Use an alternative instead of a static key when we are able to parse
> >     16   * the extensions string earlier in the boot process.
> >     17   */
> >     18  DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> >     19
> >     20  #define SPINLOCK_BASE_DECLARE(op, type, type_lock)                      \
> >     21  static __always_inline type arch_spin_##op(type_lock lock)              \
> >     22  {                                                                       \
> >     23          if (static_branch_unlikely(&qspinlock_key))                     \
> >     24                  return queued_spin_##op(lock);                          \
> >     25          return ticket_spin_##op(lock);                                  \
> >     26  }
> >     27
> >     28  SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> >     29  SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> >     30  SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> >     31  SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> >     32  SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> >     33  SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> >     34
> >     35  #elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
> >     36
> >     37  #include <asm/qspinlock.h>
> >     38
> >     39  #else
> >     40
> >   > 41  #include <asm/ticket_spinlock.h>
> >     42
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

