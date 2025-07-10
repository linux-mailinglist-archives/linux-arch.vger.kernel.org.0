Return-Path: <linux-arch+bounces-12612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F02AFF8AD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 07:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA46E4E51AF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 05:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2DA2853FD;
	Thu, 10 Jul 2025 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPzowsIC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CE22128B;
	Thu, 10 Jul 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127081; cv=fail; b=LgTnXdqgGqLEzzKrO1sAmUPm+NcO7ZCjRiDI3kRtI9uel+JNVcTNXjjRj6JIjqZA55uqlPu0wvYfGzm7tYHAwygl0tsXE0WsrR7cBTHWvvccGdCAaUwmeMLjFwTVjjHMxU0zRW4TMhW/y0z8RryDvcL/sUE5MgmosYq2Eu3RiuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127081; c=relaxed/simple;
	bh=/5MldXLUUNEColAR56anuZoVEWxiL989RGqgJrH5wQY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nsqRTg9MD8nUsrwcVRyHD1Cc1SefzuWA36i4M68qkZLhhEEjDprUkiG1Vf1DQiclE4tNGOFxQ6JsMYVNoybA1spMkmK9EhpOEjb8KkWP/zzZ4BOGTHi02ENT050+96Y7NdU9T4vaBpkVj2qMJOa/uBLFxYK5bGCePCmXt+7T7BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPzowsIC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752127079; x=1783663079;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/5MldXLUUNEColAR56anuZoVEWxiL989RGqgJrH5wQY=;
  b=jPzowsICI7QXYPVjDkeUrFftInM8xUlJwu7myTHoKvKJr2jTpOZlntgW
   FWq/KNMSRKuVyj8Rqnkst98gTME82UHSR4DAIgBzLxozy6ozbfE+hfR39
   DGb5xEncLg34H+CaeWhnB/Gd5/NvxC04pPynr6WIurchJH4SRmdgGBbTN
   qo9owG4PDNEpriwlhRCJnLH/awqJxwFDhVl98wK1ezACOZg9P6NEPu7r4
   qN2FtfpmMOEc3U+nppJ++Hzas6i/MVcXzQajxxb8m8OnOxAGHzRjsgwPf
   TxljaP9z17mJ/Y0kPZpc1LPaJHMayProymTTtbVid36yr3SpKQ3wLiQF0
   g==;
X-CSE-ConnectionGUID: JEbG4y9ZR4+JGhEzrYJDqA==
X-CSE-MsgGUID: SCQ7AmfGQrS8Xz0W0q6soQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58165297"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="58165297"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:57:58 -0700
X-CSE-ConnectionGUID: +8G1C3sRTIeVRoScHdBM8A==
X-CSE-MsgGUID: wbDA5vGgS+W4qUwtnI9v2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="186957742"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:57:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:57:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 22:57:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fowTOs3XEIs4jQamhov6+hFPZ0KDYwrfXyQfHI6YK5aJGOpALLhwBy1jtUYnDu1jE2JbkV2rJdxaugOO0DPlTriWoqZXHZhaMTLbAgXgqN8tcEqHUqby6OLpqFEdnD2Zf/Tg/HoAKkDgoqjLVKbLl5ooKTvHAFqD9ZmOxAZ3eNaeabZs/C7yG6BGmPrjM8crSZtvMdjaHhVO4wxHvJEUpndWmiy6XrFpV9laPp9rggBzNIKOLi8g987xENBpnK5+Qk7irPtAxDN9q0+F8QF20g7fzz/WtdAQuSAJwt0kIUpBL/WdQMki5XFg3IJFPQP0rAEl1l+BqzSghV5R+s1hRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQkoZoQTZDGA+EfN/fKnhpsoHJSkkxKe9V5bB0EJeO0=;
 b=K2988rufBy8yQW/BP3w/BzX4h543IjtObBCqe2i4t+wbzpLk3cuGF7WKEZooOl4MWdJLoyht3rhJ8D7Bk5Y90xFAYexVQoSGD7Ntbzn6L9uA0A6rDnw0L/QfSM1Ge7n4fkKFDD0c/ajXXQtxgI5NXLKm3/OQVEpiUrqJTtfxAmuFfIV8vec/dZEQOQecZ/bWL3XTvWQ9xkeDzZ4bG6yJNe1JbLGoq0pMhMrOrlqtV8fvUp5WPwo2cmQ8crQBG+zD/eBbywxD2c4nqfBhm4wHdpBJ4xQ3dO8jCuG9leAIM/ht1D9dYDw79TAdVZ6UPZvSBWjWaZMRZ7pLlMnf+NyUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 05:57:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 05:57:39 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 9 Jul 2025 22:57:37 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, H Peter Anvin
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
Message-ID: <686f565121ea5_1d3d100ee@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624154805.66985-3-Jonathan.Cameron@huawei.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250624154805.66985-3-Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/8] generic: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3de52a-740c-41e6-aa88-08ddbf76ad43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2tOeEJZQkNsOHlXVjAyaGhiRUMweTFzYm8vM0c4a0xzeWM2SzVSamwrYXhr?=
 =?utf-8?B?b2wvTmdWbytXdWUxeTFyRWxmcnA1RC9YT0xyQ2RJUVhXQVB0dWlXTW5qcTFx?=
 =?utf-8?B?SWRuTUVQd01MT2l1ZW1weDhtdkVobDBTNGFyVG8xZW9UTnM2TXNNOFQ3clpU?=
 =?utf-8?B?VlZLYjBCUldFazFNam9GNlBEcS9Ud0xJRlpnRTlwUm41R1h0dmR3a0Q2NlBy?=
 =?utf-8?B?Mk96VCtNdDZyS2tLNGlmMTBPZEJ0d1NWY1Q2RDhmYmp4aVhGdUxpSXJnd1hD?=
 =?utf-8?B?ZlJwcXhQR0hXNUJCOHVvZ2ZVdEswREZ1ZjAzcFc1ZThsYjN0RW9xYk15c3RF?=
 =?utf-8?B?VHA2aUxPbFVQL1lZV2lRV3ErdW9KUzJYME9majlmN0MzNGVzK3A0YUI1UHFP?=
 =?utf-8?B?OXgrZDRQTlZ5OHZlSGlWUUJicUdTajRyaFBUL1k2N1NRcS9uVTQzRzlqK25M?=
 =?utf-8?B?V0RzQTlYRVk1d1VobGUxdmM2b09xM1dPNTk5cjZWa2QyRmtVb1BYVzlBTDdL?=
 =?utf-8?B?cUNTRjNiU3dGVElISDhLY1EreC9YTjd6UzNwVFpBekJzdzcweEVsQzdlZHYz?=
 =?utf-8?B?YnZDTHlBNmhDcVFCNnNrd1VRdC9wa0dBZXBWYW9nQ2pCZ0t2Z1B5L1ZMaEVR?=
 =?utf-8?B?cG44VzhTUjRjYTROZTJoU0c5TGMydU1nNzYxeG5sMmE0V3RRK3oxSEVra0tm?=
 =?utf-8?B?ZjY0MzE2SzBmSUgxcVZyNm5HN0twbG5KT1VYWHZFZmZUUlh0TE9OVVRCK0dN?=
 =?utf-8?B?V3pCa1Bvc0NiOG11bDltbitFYVpDczlTMUFicFAxV1FFc2hCYk9xY3VKSmRL?=
 =?utf-8?B?WkVyOCt0K003Vk9HRnYyZUV2ZDBycytROE5yRHoydkJPSXoyYmpFaW9TSjBl?=
 =?utf-8?B?RXdYRW12WW8rTlBNZ1VxaTNGZkxwRFloOHNLZzl6WmxHYS9iUGQ2ZS8zY05K?=
 =?utf-8?B?VFBDVlJwOFI5TzlCeW9zOFpOK093OEs3Q1NpQllNNjJhNUNPUFJNZEhheGNq?=
 =?utf-8?B?WGFGMXBrRitUMEZRblNwQlZqSGtjUmtHbGVOdGJyWHFnVXduUGxJWTl5SlI0?=
 =?utf-8?B?R0JuaU16Nkg3dCtlaVlGVWtxUVorNTFyK1d0STNuRW9wSEtMcFFTYkpqaUYw?=
 =?utf-8?B?YU8yVkNBT1k3OWxZeDRCeTVzNmpLZk1PT3BrQ01aRzZmK012RnNrbCtJMlY0?=
 =?utf-8?B?QnVpZkZtMlU5NWk4bTlQa3FLT2NPN3R1Z2sxZnpOdDVNYlRKbWhNNS81Mzcw?=
 =?utf-8?B?Y0xhMjdTYXVZV3k1QTdKMG1mZVV6UVpIb1N5UHZzRksvRUdLalNLd3I5RHdM?=
 =?utf-8?B?cTl4WkFaQXRPS2FmSGYyV3BGcUFlc2VKUUtkbGFma3MvbDVBeWRiMWhZR2pP?=
 =?utf-8?B?MnE1SURqMHN5YWZiMUIrMmZsN1BOczJBcjVHWHhWdFRwNkJCL3NWK2ZaVnlv?=
 =?utf-8?B?VGw0WjVMcVBob1pmcmtjS2pDWjdWUElnM0FMbisybnJUTUlhbVczWXgyekRV?=
 =?utf-8?B?a2FYd2dsQVBPUU9EVmNHZktKYXVoZlZSbW5VQU40a1dacXhmbFB0cE9KUjZ6?=
 =?utf-8?B?Y2pUK3IycytsTThYMjhtWHZPd3BWVElHZUppTXl4YlpZRzdGU0lycGpIeWVP?=
 =?utf-8?B?MjlQOXlKYUU0ZEFnK0NNcWVJa1NPVGhVc24xNkE3VkZRZ3ZlQ1JoMTNNdURT?=
 =?utf-8?B?RFhIQndONzdqL3UwaE5RZmJscE5yb2R4bzkvYWVXS255V3J4eDQ4L0g0M0l2?=
 =?utf-8?B?MEtHbVowMS84R2xBSko1bkJmWnRxSHVUdFVpN3FCS01nWFA4dVlsbkt0L0F3?=
 =?utf-8?B?ckdjMnNaMlFjM3NTSkgwRzRpV2ZZZ1lrUVpoQ2pLTVYySEFtV3A5ZFp5NzY1?=
 =?utf-8?B?bjBHSjR0SlphVmdiSkd3SkRVcEVBN2YwbmRUYXJ2ZU1jblNwckl1Vm9zbTQ2?=
 =?utf-8?B?WVpyajFHb202Y0Nkc1l1NllMRE41OVpuTUdZUXZocjEzN01ITWliZ3JxcGRD?=
 =?utf-8?B?MEVIVTM0cEFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXF5bjg2QUJ6bWorUWZ3SCtRWFYwR3FURWExSmJGU01ObmZyVkpQTThnRW9q?=
 =?utf-8?B?QjNhM29pZGhWQ2EwOHMwOGFUTjlld1l2ZDlRU1kreU8rdjJnR0o1MVFFYkth?=
 =?utf-8?B?UlZsZ3E1STdENVIzSDdaR3IzbXAwdWs4U1ZFS29jdHowM0tNNm9Xa1V0TnF0?=
 =?utf-8?B?czE0MDdFUUZNeUxWYzZaekFTWm1xSnV3dlcyZnpnc1RWeWltT2taaHBqSnE2?=
 =?utf-8?B?MVMrM3QrZGVxNkV3ZTNtdWhJc1pXdXYzVGhvMW4wZnFmbTdMcFJNRGFMakd1?=
 =?utf-8?B?OEpkOERZVTFXN1RiZ2RsandFQTVtN2RCR3B3Sy82c2c4TjB6enBuYU5xMTlv?=
 =?utf-8?B?ZTZaZ3plT0tDcUtwVEthMnJNNVY0OXpha0R1OTZTTGJ4M2NGUVZnVTg1OHZY?=
 =?utf-8?B?WVkrNjdrVkZMaVg1ZmJXemFCczVwNWlhbG9OZlpoSC9WZVRGWjRoYXkzR2lS?=
 =?utf-8?B?Y3RIMk0yTnc2Ukc1ck5GZmtwK2xhdVVlcDJHNkFGRTYxTmxDZlN5T3NLZEE3?=
 =?utf-8?B?MHNQUUVTcGVhR01mYmhPRjBKMU1JTUI3ZW1vZkhsdVg4RWZlWklsWGdnVXNG?=
 =?utf-8?B?SE1hazAxY0ZRMEFoWC96b2hHTjhVTklWQkw3UjkyV2FHRDhIL3k2OFNMZlMr?=
 =?utf-8?B?VWVPV2hnU0h5S3hrM3cza0orRlhDSHlwV2trL3Bac3hyS2xvNm5MVTV0eU05?=
 =?utf-8?B?QmNLN0FzSWg4dlJuTGNCeDFPSVZYN1oySytCUnU5L2pON1pFYzV0WWVaRm1M?=
 =?utf-8?B?d3FHY3lqdFJVcU8vakpkWW1RdlNRTzdjZGRpSERTZDFsS0QyM1k2bTd5ZXJm?=
 =?utf-8?B?bTcySzBtdlhBTHNISnpoR2dwampFSzF1TmRCLzdvaDVpaXRvZFhLU1VDeG92?=
 =?utf-8?B?Vll0ajBTVDlPYU5nL3kwc3FZV29nYlhvVksreW9DbjU4UzNTODNwdHVxQitq?=
 =?utf-8?B?VWpiN2ZucnR1SmtqUDFEUTd5V016b3lzUnB5dDBVOVdxd2dzYlg5WHZLcUh3?=
 =?utf-8?B?UHordDR4NEVBVXY0V3g4RzBCSGtpUlNQOTR2ck9SZGMveTU0OVA4eTlvQ0hO?=
 =?utf-8?B?alVHMXFVZlpFem1ZTEZ0cE1nY2psTWxUTU81NE9FNkdud29NNzI2b0poZjNJ?=
 =?utf-8?B?cHNjbWkyYWg2QXN1S08rWlpUaHFzbHk1aWp2ZHorbEJBSDEyVGhmaDRzMHhD?=
 =?utf-8?B?V0NLTzE1MzQxUnA3Rk5yQjhUaFhiaXl6cjVxb2l3WWVuTUp4UXpIZzN4SDAy?=
 =?utf-8?B?TWpaNHp3Q0pJa1VMYlBvRWxzVnp2bXFTMnlTUHNSaUttRzk3SEU4WVNQdEll?=
 =?utf-8?B?TEUxMDQ0akxHRWI0SnpuWkN2VmVrQ0pyRTg0WkE0NWswSGtHQ2QzcnhJR0ls?=
 =?utf-8?B?S1Z2ZkxNNERRQ0FIS0xtelNrT0ZObzVBY2RHMXlLV290eGdleDZFSWszcEgw?=
 =?utf-8?B?Nks1cjJXQnFZSSt6bGVKRExqbCtSQ1c5OHhDY0NoOTJKeEZ3ZS9KV0xibElM?=
 =?utf-8?B?YzEzRkxaL0I5VkxYcm9PWk9iN0hCelAzdGhpWlRIbHFZZjdpV0ZsUTdHTStn?=
 =?utf-8?B?cFlZRlJuVFdERS9xSFZ3eHJtM1hvUm9tbnZiZEM5aERRZHdtS2xhYUd4ajBS?=
 =?utf-8?B?MUozUGl5L0JlVVZnZTl6dlA0UXV4cFQ2TTdWeTlHUFY2ZmlMZ2JTUlh3bGpY?=
 =?utf-8?B?bXMvOVkrVEhJU21jYVo4RUc4RFR2QW5yenB5RmZnSWsxRktLemo3V0o4eXA0?=
 =?utf-8?B?WXdHQitJdTNYV3dmdVU1YW0xSlMzS1ZaTUgwSHFLajI1LytNS3krSnNUSEVv?=
 =?utf-8?B?dUVBcCtBbTdGbTFrUjBqOUd4SlZ2WDBodUlqV0E3YVovNGlrT2h0bjRWMUJn?=
 =?utf-8?B?dzhSanc2d0pGdEdQSDlqdytPdWx0c1NSYkF6Nnd4S0ltY0I4OVpEL1hxS0NJ?=
 =?utf-8?B?TmRlMmh4ODJPS2drbUdSa0lPOU5pTE52OWU4YmZMM3hpMEtVc2F6NWMyNXpG?=
 =?utf-8?B?bzB1Vmt0OHVaU01oVTF3OEd6QTJ3cFlHeWdlb2lhZmhXcGlBby9MMERKaS92?=
 =?utf-8?B?STU2NDlEMlNvL3NaTElmTTdqNG5ZR1F1ZzB6WmtBaXNXck1EcFRLTnhPZEkx?=
 =?utf-8?B?NmxiUFRmZGJLditVWTZkUm5IRGk1cnFpYWpBUHpEd29yWUMrcFdqdVhISlYw?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3de52a-740c-41e6-aa88-08ddbf76ad43
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 05:57:39.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR6D8gktHFkxcs+WJB8xslhFAGLTzk6wUNLLJa5R8WvQRTeDVeJVN1a0aKrkBSjBCUM4i+1DtkbAG9Wq83RcayDuxsD3lUJynspRc+5AWpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
> invalidate certain memory regions in a cache-incoherent manner.
> Currently is used by NVIDMM adn CXL memory. This is mainly done
> by the system component and is implementation define per spec.
> Provides a method for the platforms register their own invalidate
> method and implement ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.

Please run spell-check on changelogs.

> 
> Architectures can opt in for this support via
> CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/Kconfig             |  3 +++
>  drivers/base/Makefile            |  1 +
>  drivers/base/cache.c             | 46 ++++++++++++++++++++++++++++++++

I do not understand what any of this has to do with drivers/base/.

See existing cache management memcpy infrastructure in lib/Kconfig.

>  include/asm-generic/cacheflush.h | 12 +++++++++
>  4 files changed, 62 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 064eb52ff7e2..cc6df87a0a96 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -181,6 +181,9 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
> +	bool
> +
>  config GENERIC_CPU_DEVICES
>  	bool
>  	default n
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..0fbfa4300b98 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> +obj-$(CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION) += cache.o
>  obj-$(CONFIG_ACPI) += physical_location.o
>  
>  obj-y			+= test/
> diff --git a/drivers/base/cache.c b/drivers/base/cache.c
> new file mode 100644
> index 000000000000..8d351657bbef
> --- /dev/null
> +++ b/drivers/base/cache.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic support for CPU Cache Invalidate Memregion
> + */
> +
> +#include <linux/spinlock.h>
> +#include <linux/export.h>
> +#include <asm/cacheflush.h>
> +
> +
> +static const struct system_cache_flush_method *scfm_data;
> +DEFINE_SPINLOCK(scfm_lock);
> +
> +void generic_set_sys_cache_flush_method(const struct system_cache_flush_method *method)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	if (scfm_data || !method || !method->invalidate_memregion)
> +		return;
> +
> +	scfm_data = method;

The lock looks unnecessary here, this is just atomic_cmpxchg().

> +}
> +EXPORT_SYMBOL_GPL(generic_set_sys_cache_flush_method);
> +
> +void generic_clr_sys_cache_flush_method(const struct system_cache_flush_method *method)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	if (scfm_data && scfm_data == method)
> +		scfm_data = NULL;

Same here, but really what is missing is a description of the locking
requirements of cpu_cache_invalidate_memregion().


> +}
> +
> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	if (!scfm_data)
> +		return -EOPNOTSUPP;
> +
> +	return scfm_data->invalidate_memregion(res_desc, start, len);

Is it really the case that you need to disable interrupts during cache
operations? For potentially flushing 10s to 100s of gigabytes, is it
really the case that all archs can support holding interrupts off for
that event?

A read lock (rcu or rwsem) seems sufficient to maintain registration
until the invalidate operation completes.

If an arch does need to disable interrupts while it manages caches that
does not feel like something that should be enforced for everyone at
this top-level entry point.

> +}
> +EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
> +
> +bool cpu_cache_has_invalidate_memregion(void)
> +{
> +	guard(spinlock_irqsave)(&scfm_lock);
> +	return !!scfm_data;

Lock seems pointless here.

More concerning is this diverges from the original intent of this
function which was to disable physical address space manipulation from
virtual environments.

Now, different archs may have reason to diverge here but the fact that
the API requirements are non-obvious points at a minimum to missing
documentation if not missing cross-arch consensus.

> +}
> +EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> index 7ee8a179d103..87e64295561e 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -124,4 +124,16 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  	} while (0)
>  #endif
>  
> +#ifdef CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
> +
> +struct system_cache_flush_method {
> +	int (*invalidate_memregion)(int res_desc,
> +				    phys_addr_t start, size_t len);
> +};

The whole point of ARCH_HAS facilities is to resolve symbols like this
at compile time. Why does this need a indirect function call at all?

