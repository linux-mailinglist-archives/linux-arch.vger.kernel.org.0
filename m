Return-Path: <linux-arch+bounces-12610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3042AFF87E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 07:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98431C84271
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 05:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895317741;
	Thu, 10 Jul 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCgSH4eT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFB8821;
	Thu, 10 Jul 2025 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125550; cv=fail; b=H+F97poGBonMkpbFKX+9n8pKR43IAu0946WxbGCZpY+vvlkMy2ParFvEbuH4a0Uq1fazLvRHvg8dIT38pT4JJeF9ye7GWLXHMcA0QlDkMvPY4FKXcvbC85Kd6hSlcI44iMR1shX7//DichpJ4w49NcgDczKx6kfxabWiqKYxHbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125550; c=relaxed/simple;
	bh=0eUi0bOTC2q3mJPx8TlXp7rFeynFkWYC6eXw3LRt38o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CL8DE2WxAVZgadozJGuBjetV64sZthwV6vljnUmMhQigBrjm9h9fFmI/fcslWvdDmaH/w8Zr9vIXEluvfwJWnIWl1iCnKBB+65aC842Ye6+DNcO79joLlXApDljMAzI9lrYzw+khqS7E3fx5/nedeBbk6oNYMFm0NOXOGh5tIuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCgSH4eT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752125549; x=1783661549;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0eUi0bOTC2q3mJPx8TlXp7rFeynFkWYC6eXw3LRt38o=;
  b=CCgSH4eTL/8+wXffMOXxFAnsBg9oS3vW3XRmHzvSIBUGAyqnIfLZZhYV
   tb665Bk0kLpBoV6hR3ce2wuoCwLWe26JJ02HOXJKoS11pmoxUoWSLT9NB
   h/sxeF9+l5Vh+tb0Vpmht8Ex+BbiU2Ddkgr5pAk+ANOLmAJtGWFRMtBKN
   sVSg+qfZ5xJssNcSubqfXWXrnYiwQVJGstTIeec5e+WnNolbb8+Wd6BUr
   k7B5QSPr8LYpYLej2UbWUzQxJrb9b44eNuf7DtkE0Xr5HHc3+4dcUshD1
   K7pBMC1JOgOnjjh/lC6i1glyAHQYi3HwVhIkvdLqrfVnJltB46We2aTwp
   A==;
X-CSE-ConnectionGUID: XUW8hDxNS8C1aI0czp0KBQ==
X-CSE-MsgGUID: 1GbRdP+FQH++5Jg9WaHdDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65096085"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="65096085"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:32:25 -0700
X-CSE-ConnectionGUID: tdAPRH0WS1i9HqjYMHnEJA==
X-CSE-MsgGUID: zD3izum6SjmYQmN/sG/JIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="186955580"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:32:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:32:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 22:32:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 22:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGNKglBngBcnp1XCJM4edLwNr2n9qOL0VONgfkfLqVb+fT6KhvC4HuppFgFtAQCzIeGN1OO7J/DhndvvToI7BuVovnUJ2eCNaRk4VgyMml+7DV/eT0fKLvyVH5X3B1xBMkluoHty2ngzzGbDSNcPNLPPg7T3fb3QbD5isxW353N/imx2mcUrNwomL1/43OghL4bBIayDT0qLZ5S1oiRrSe2u8StBcIBlCjaO6eSWGlHPJWRZ133L+UAo6pi8+2j/LlpjhbwGM90YreEAMGPexmFMBiP7FjH/NqMdo0AoCV5c5yHJpvkN7XpPmTWbfkg2wnagU4eL9PjYGiqsxLQ4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM3EgCEMlRRyLOg13aIFxvh+SMErmeY9oKHfZA6g2R0=;
 b=ObCYTHsArpNEvlBh/lqhId4akmNvy+yfWldyIqc8vLoMRYsvJJa6ju8F7kmzK1QN0YNLTMKc8wlE2EtvUhGBCgILaUGGjzoXgRNWo612u1QTk6xengSWGiu3Q1oN7g0AqiF/kQmU3wwqoOzXT50kizcVxHqaONuZ3UlXQ5GrbKNp3GwhsethGQiz0S6IC3rP2KN5nVaqzux6VkbMoB/ILJdctN8P2uZVUJVZOkf3+nWSuBv+OuxWbm9cGo/6/o+KCORIpn4SMd/ZmE4wvikSXSuTOtpIKVssN09Bx5D2ROGOi1bv0Yi0cpiLf+AZVqfNx3WF2MPSxu1gOP75GG6U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 10 Jul
 2025 05:32:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 05:32:18 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 9 Jul 2025 22:32:16 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, <linuxarm@huawei.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Yicong Yang <yangyicong@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Message-ID: <686f506020726_1d3d10069@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626105530.000010be@huawei.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
 <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
 <20250625180343.000020de@huawei.com>
 <20250626105530.000010be@huawei.com>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f30fcd-fd75-4d15-0b89-08ddbf7322af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2s0RnpBWFJUa0FLUU9DdzFJUklJOUlaUk1qQ1drQnNaeDFFVFZBclpoNEg2?=
 =?utf-8?B?UzJmL0RGNyszMCtHa21tREJCMGkxcGZQZE9UZ3BLT2JlRnl0VlRCdFRsZ3pR?=
 =?utf-8?B?OWVCOXBQMjBkR2d6eEV4WWorc0pWYmNGVm9ucW5kcVc2S0U1bk5iV1ZBenV4?=
 =?utf-8?B?MjVxTUlGZk9ERkFMb3BHOXYwZk1NakcyRUxHWldYTjBvUjRQVFR6WFpaUEpa?=
 =?utf-8?B?YUFuT3JtbDNHbUJsZVVIVk9ablErSTNQWW5welRCdkZCZU5adjkwbThqOUc5?=
 =?utf-8?B?amorSzlpTlovd2NjWjZ3TjFmNExXTmhjdGRaZEtPNWJJcnBTRVNrZVpMZDUw?=
 =?utf-8?B?bTZ3ZUlXaDlLSnZ2OTczeG5rakNFa2RUbTcreTUvYXF6aUZGdytLVVJtVVJ5?=
 =?utf-8?B?ZldoN0Q1and6bkpheTZpYjhDUS9SN1g1TlVPRitMclpVOVlGYVR5WElYSlpF?=
 =?utf-8?B?MXYvamdoejNIbFNkNTFCSm5oSW9VYzQ0bDdKUE9VbGsvRmhHR2dsNEVvWS9Y?=
 =?utf-8?B?SFpuUlhLVTZMR293bXNzMDg2OWQ2MlRMY01qTHQyK1hrd3k3dm0zc3FTR0RP?=
 =?utf-8?B?WXR5cVg5RkQ0QTJXbmdsVzc0M1BkWkF3QmVrZ3NZeG9BL2ZvWnVDNHBDYmtU?=
 =?utf-8?B?b2Y2R2VqUVNrbVlRVnVWdVVBMkRQOHBUaTVEdE1YbFJEQU5qTTBzajB5clNp?=
 =?utf-8?B?RG03NTl0SmM3OGVicDFXVThGSW4zZ2ZxT1lQSExxbUF6N1g1T21aZlhJVHQx?=
 =?utf-8?B?Z2tObHdoRnRZUXpvamttMGVRTVBlcGRyY1J3Wm9iRDljcEs1MDJhWkJWaElo?=
 =?utf-8?B?QzNSYXY0ejJXNHVSQjZXYjNLQ09lYVRTNFNxekMydEJIdlprR0FKd2drdWtt?=
 =?utf-8?B?M21sQXR4dlh3RFo3R2hFdGdTRHhRRVRodUpneDRZYzRibWduM3RMN2JQTW5y?=
 =?utf-8?B?cXFod3doZ3EyZjVQTTdzUVU2R3lFbHEyZUJqWFBxWE5XbjlkRlhWSjUzZlNk?=
 =?utf-8?B?Zi9Mc1JObFB3OWcraHVXWnUwcUxZRnFFdzdlQU1VY0J5SlJ5cGZ3dU95VkJ0?=
 =?utf-8?B?YzNNY1NJOElQMUJNTE1HQ1J6amZncFhPam9XaTZuM2J6NnlITCtHOVB4ZkJ6?=
 =?utf-8?B?NkV0bk1LdFJPak84YmN2b1dnUmIrdHphbDZxLzIxb1AwbE04TGtENThWK2U3?=
 =?utf-8?B?Mnl1MWNRZ1lFZW1ubW1NN0tvVW5obXdwOEtpYjljdStwWlFyelpxcUlHYzQr?=
 =?utf-8?B?MHNkWVZLMWJ0UndsQjR4U0tHWndxYVRCMmJtYVJEcW9pK0xINkpWNHB4Uzhz?=
 =?utf-8?B?MHpqN0NCbmZBS3pKK2RVSU1NTFRLbitNTnBMTGI5K0FVV0NoaDNFc1ZCTlJj?=
 =?utf-8?B?b2J0bUhXdmpIR1lucW1QRU93Nm1KNnZpNSs3cmM3VUVjVzltY2tiWDhZSE03?=
 =?utf-8?B?cnFyenQ3azNoM1FrZmNwK2ZCcGdGYksraTNjTEdKaUtPbzRlc2R2RkZ5WXVO?=
 =?utf-8?B?Z1B5UlRjVGlrcTRpWWViSzZ6a2JLS3VvYnpnMWU1NE5rZVdPQnVZWFh1Rjky?=
 =?utf-8?B?aGJtQVVkcUNIQ0xtcHV6a3BLTDF6TFBETXR1NjVXUEFmbVJqbWxSRGVmdXRT?=
 =?utf-8?B?SElCUW5Hb2VKVTlSd3F1VGFsak5xT0FZREhOelVjbURIS2ZTV2NFVzZxUU5X?=
 =?utf-8?B?dS9FMmd2QXhmVzBiS1F0UTQwMW5kSzlta3BzODh0OHdaUmRhVUswTVBWMDBk?=
 =?utf-8?B?S3YwTlpkWVpORnFWRlVDNXJFd1A2Q2hsSmppTlBteVc4V2pkSm0zK1FKMW9o?=
 =?utf-8?B?VjRtck1HWkNwa3hwcXdwdmJqdlpJMkRyNzk0VG8xSEJCeEZJQ1NQMWxScHh1?=
 =?utf-8?B?WGdhcWFsTlZHTnlYQlF3TERKY1pYYkEwT2U1alkvYkFyay9JWkJpY3hzc211?=
 =?utf-8?Q?vyySYQn3Cvw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0IrVkUwOGJmd3RLN0JQVDMvVXpQTmlNRSt5UkZNZ0VzQVhEMlZoZVpBOW1w?=
 =?utf-8?B?b0dHcWlvM1kvZlpiYVFlMGVSeUM4c0ZJZHZScDFIRExGVDQ1dmJKTE5VVC9L?=
 =?utf-8?B?ZXd4Z3JlS0NlK0JwQnlDZkVtdkJocGVjN0hDSmJHMGQ5d2tlMS9MQjdBWUlV?=
 =?utf-8?B?MHlyNm5CRU9tbXN6VFkya0VKbWJyYUx5VFIveWdNeTdpTFFqNE9qb0Z1MHA2?=
 =?utf-8?B?Z1N0NEk4a2lqcytOOVNhLzZNYjJBUzJsQmFieU5NRU44R3R0OHdhNGFOSzdD?=
 =?utf-8?B?THFpRzFxOHp5STIwSGFQbTRZdFBrajBEQ1U0cTZoSUlvK09SUmo0R1oyTnRW?=
 =?utf-8?B?Z2hneFVYMHdiWGlCWWFqMGZzaGR3R0pabWxNUmIzZzA1VFhCbVJXcXlNTGpY?=
 =?utf-8?B?b2tVMjlEVWJRM0NwcUJvNk0zLzJ1MEdndUpSZ3NzenhBaVR6VjFQYzhTcVAw?=
 =?utf-8?B?c3Y2T3JGSTJtTmV0czFiZVduQTE4aHRpRERIQmVWYkRmaFA3dUxnMFlRV0lY?=
 =?utf-8?B?cS9maUNjM1Z6MEgvaFJobGF3U3ZyNTlXc3JsbEdBTjlBRldwU1RCdXgyaEhq?=
 =?utf-8?B?S1BSM0hSOHZ6bWh6TUhXbVFLTlI4WURrVnUwMFBzT0VMeUtuMXo0SEs5b2VU?=
 =?utf-8?B?elJwTVJrSFBxU21va002VTB1Z25DT0pvcVVvT052MXRZaXdkK1VNNGpxak8v?=
 =?utf-8?B?NnlyeXl1ZWw1cml6ajBibkk0dUZPSVJITzJRVXlnbUN4TmtGZEU0UWdTRHdI?=
 =?utf-8?B?Z0xMbzh5THd1dFVTaG5WanJWTTdnQ0s5a2FYdlVqZ2NUK3ZZbUpseThzejQz?=
 =?utf-8?B?dE5sY2dNK2hld0pMVjlHQzA4aUg4NFpVNjIwU0RlZE93dTlObStDMVVpbS9u?=
 =?utf-8?B?NVJMb0Q1N2FKd1R1ODhNVTdoK0FUNW42aklTNmFNOTFhMlQ1aFJiL0gycEhC?=
 =?utf-8?B?dE14WGtweFdSUkYyQmJjRlZpUTN4RDZUa0NQVVdQa3FrRVpKVVNNbGdSYUJx?=
 =?utf-8?B?TnljS2NGNUxzL3ZJUkp1Y0tqY2Z1V0VxSXFPdytLT085NkdXMUpXQ2txS0lC?=
 =?utf-8?B?SHIxOXJDbGdOeERFNVpEQnhVVEJVL3FWaTlJckgwTEtMVVRYMU43SE40dmxQ?=
 =?utf-8?B?K0Roc2U1VjcxemQ1dGFid1dVVEFSOVFIN05OQkN5UnVnbzNIN2M1Zys5NUIw?=
 =?utf-8?B?bkZFanRKeHFjNUxDUFFtelB4M0RZei80b0hoT1dIQzJPZ3NlUU1qdXUrNXBs?=
 =?utf-8?B?cWpYdzlPRW1ncHhwL0hyenladE56bGVkMi9wT0s3ODRLSElXWmRKRFhTeUln?=
 =?utf-8?B?RlBlWGJGOWZpU1JRc1VNaVZDNjE5cDR2OURsR3N4eWNyM3ZwNVo4Sko5YUhj?=
 =?utf-8?B?LzJKOXI1NytIMldqSlUwb1ZHdnYycE84WTMwRE1rbXJsazRCWjhaQlBMbHpt?=
 =?utf-8?B?UzB3S0poQ1BtcDE1MVhCMHBya1NOMEdxZ3ZsM3Flc2tIamU0dTQxM2Ftai9t?=
 =?utf-8?B?dXNVRmtqTkUxL1kwUWFEV2tjRkpNbXNZcjdxdVVPb05pTFRkL3B4RzRTbTd0?=
 =?utf-8?B?bWptZ3hjRW1xL1VYT2dOd1ZIaWwzaFZWSTRaMVdSUWVoU0JPdTB4QjR6dTdF?=
 =?utf-8?B?MVdTNDRoa21yYkkvU1k3bDZVNGdCNW1SMVphNk9ZUnZHZDB0ZEpjNmZuUnJS?=
 =?utf-8?B?cExFdGFCTEdpVERIRzVQKzJpb2xLN1ZnTVhvV0R0QnVub2NrUFFLYVpzN3Ni?=
 =?utf-8?B?QVI3dU9DVDRYY3owdkV0UVJEOTBWQjZ6NlJvREFBbUt5ZkJWcTN3MFV3UWFu?=
 =?utf-8?B?TU1hRXI3YzJnNm92aS9GaVRseDlaY3k3aUpaZFd4ZUdZL0FXOWVUTThObDRx?=
 =?utf-8?B?b1JoSnFENjBaYndubEtuV2ZXQzFRWGdlMnJSandqZlJBYU5Sb3c2MFlYc2pQ?=
 =?utf-8?B?S2dXNVFnbWJhRW1JN1lsYUJENHFlWFhqSENXazFuSDVyOXNZY3dzcEJOKzhY?=
 =?utf-8?B?N3ppUzZtRUMwa0tsVjZXcEtET3pCU2dhMFIwVEtpaWxyT0t5Y0tHTFNQcGdZ?=
 =?utf-8?B?UEs2RVI4RzZydWNvY2dEdmlLeWxRU2VRblRiYWFRNHltNkwyY2FTdUI0TDQz?=
 =?utf-8?B?NWUxYXM5a1QrUXBGTlBEOGJxdWROc3ZBQ3RwakpEM0h0SUdHZXBEVXloYjhC?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f30fcd-fd75-4d15-0b89-08ddbf7322af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 05:32:18.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKjm2l80fMTnUKJwok4GMNhaC123KKcH1MVlOwcJiYApBh6WYiuR972MC1p89vcxShWQKcKE4Sy2A6+T2mMPxdx/L7Cyq66sApUcRhvFsJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 25 Jun 2025 18:03:43 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Wed, 25 Jun 2025 11:31:52 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Jun 25, 2025 at 02:12:39AM -0700, H. Peter Anvin wrote:  
> > > > On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:    
> > > > >On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
> > > > >    
> > > > >> On x86 there is the much loved WBINVD instruction that causes a write back
> > > > >> and invalidate of all caches in the system. It is expensive but it is    
> > > > >
> > > > >Expensive is not the only problem. It actively interferes with things
> > > > >like Cache-Allocation-Technology (RDT-CAT for the intel folks). Doing
> > > > >WBINVD utterly destroys the cache subsystem for everybody on the
> > > > >machine.
> > > > >    
> > > > >> necessary in a few corner cases.     
> > > > >
> > > > >Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
> > > > >avoid doing dumb things like WBINVD ?!?
> > > > >    
> > > > >> These are cases where the contents of
> > > > >> Physical Memory may change without any writes from the host. Whilst there
> > > > >> are a few reasons this might happen, the one I care about here is when
> > > > >> we are adding or removing mappings on CXL. So typically going from
> > > > >> there being actual memory at a host Physical Address to nothing there
> > > > >> (reads as zero, writes dropped) or visa-versa.     
> > > > >    
> > > > >> The
> > > > >> thing that makes it very hard to handle with CPU flushes is that the
> > > > >> instructions are normally VA based and not guaranteed to reach beyond
> > > > >> the Point of Coherence or similar. You might be able to (ab)use
> > > > >> various flush operations intended to ensure persistence memory but
> > > > >> in general they don't work either.    
> > > > >
> > > > >Urgh so this. Dan, Dave, are we getting new instructions to deal with
> > > > >this? I'm really not keen on having WBINVD in active use.
> > > > >    
> > > > 
> > > > WBINVD is the nuclear weapon to use when you have lost all notion of
> > > > where the problematic data can be, and amounts to a full reset of the
> > > > cache system. 
> > > > 
> > > > WBINVD can block interrupts for many *milliseconds*, system wide, and
> > > > so is really only useful for once-per-boot type events, like MTRR
> > > > initialization.    
> > > 
> > > Right this... But that CXL thing sounds like that's semi 'regular' to
> > > the point that providing some infrastructure around it makes sense. This
> > > should not be.  
> > 
> > I'm fully on board with the WBINVD issues (and hope for something new for
> > the X86 world). However, this particular infrastructure (for those systems
> > that can do so) is about pushing the problem and information to where it
> > can be handled in a lot less disruptive fashion. It can take 'a while' but
> > we are flushing only cache entries in the requested PA range. Other than
> > some potential excess snoop traffic if the coherency tracking isn't precise,
> > there should be limited affect on the rest of the system.
> > 
> > So, for the systems I particularly care about, the CXL case isn't that bad.
> > 
> > Just for giggles, if you want some horror stories the (dropped) ARM PSCI
> > spec provides for approaches that require synchronization of calls across
> > all CPUs.
> > 
> > "CPU Rendezvous" in the attributes of CLEAN_INV_MEMREGION requires all
> > CPUs to make a call within an impdef (discoverable) timeout.
> > https://developer.arm.com/documentation/den0022/falp1/?lang=en
> > 
> > I gather no one actually needs that on 'real' systems - that is systems
> > where we actually need to do these flushes! The ACPI 'RFC' doesn't support
> > that delight.
> 
> Seems I introduced some confusion.  Let me try summarizing:
> 
> 1. x86 has a potential feature gap. From a CXL ecosystem point of view I'd
>    like to see that gap closed. (Inappropriate for me to make any proposals
>    on how to do it on that architecture).

I disagree this is an x86 feature gap. This is CXL exporting complexity
to Linux. Linux is better served in the long term by CXL cleaning up
that problem than Linux deploying more software mitigations.

> 2. This patch set has nothing to do with x86 (beyond modifying a function
>    signature). The hardware it is targeting avoids many of the issues around
>    WBINVD. The solution is not specific to ARM64, though the implementation
>    I care about is on an ARM64 implementation.
> 
> Right now, on x86 we have a functionally correct solution, this patch set
> adds infrastructure and 2 implementations to provide similar for other
> architectures.

Theoretically there could be a threshold at which a CLFLUSHOPT loop is a
better option, but I would rather it be the case* that software CXL
cache management is stop-gap for early generation CXL platforms.

* personal kernel developer opinion, not necessarily opinion of $employer

