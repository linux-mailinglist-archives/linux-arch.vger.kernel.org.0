Return-Path: <linux-arch+bounces-13414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2CB49B30
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491D51885386
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B983C2BDC14;
	Mon,  8 Sep 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaaU2JJZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060921B9D9;
	Mon,  8 Sep 2025 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364343; cv=fail; b=B81JVxKbmiYrWpBhSjMne1bNCt7iVNJFGyCAu0m4dWxPGn/eKDqaGZzJQHslEnwmj8I3dT7ZB8DVELt59QbrlaLodvOOTfK044vAIwXisDffwgneAvyPKja/VXZ8HhXj48N9q1OZH1y7esChNSgtAR467uf4sINL078pn7/tOBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364343; c=relaxed/simple;
	bh=6bknNzWNSfKDUOjJDJXkn57zsIAfs3wBttvynmbqlSE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QYcecnAt9un/RYTJcjYEETiO+KRx7tfNjV0LWjNgC55uIZDJtyGe3q4fdrLAzajlFvoeNrl0t2DYbRu86AY4q8VxHYR2ipLB0VfAakgygcPi99XNAB7KC0mQ6lOrYMxkQjUe5EesgeqPz3ahZE1GGZO0Hlokyss24oc6JPjcTQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaaU2JJZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757364341; x=1788900341;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6bknNzWNSfKDUOjJDJXkn57zsIAfs3wBttvynmbqlSE=;
  b=IaaU2JJZlALwl6qDDXQHTMgSRB2pylOQci9xMuZjrhswxxVORuQleJKX
   UCektFGTp85IlWrZak1FDtQwuYpt9TF34zcKXoA5W+llqQhwjMFfPjfem
   RwywIvWHIW4GSc0rc6vQ4v8LT08vnJRKtqMsvi8MwgWq+Uc5rTVSuM0fw
   2BomKYJ66bKkO6Ezn73YJL41UgmkhZ/Sy2hhntksbV2rgazD2EMYFmJRH
   w9VxiLx0bjftYlyiTnMh9Sig5iwePs0hgV8U+iTVvn5zL0izL6A5RY/7Z
   FSIE97xNrHrgN7ZxE7vg0jP5cerwPL5RrKxR4/znmBXl+J3294WrKqwF6
   A==;
X-CSE-ConnectionGUID: EdSIBYSSSJWdCKnhfBMyvA==
X-CSE-MsgGUID: Acdm6GQTR+ahaN1gMHufUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59494520"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="59494520"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:45:40 -0700
X-CSE-ConnectionGUID: fctTJMoFSju/DvvEvas3LQ==
X-CSE-MsgGUID: 76UIq6ZSTwuzvtikbsMvjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="173257462"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:45:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 13:45:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 13:45:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 13:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2yqBxahCEPZKhilLOT4sZEhiRP4n7fv6Ndxrd0AfdKRW4Sbmq+batFjrFdlRzvTdDC6Q2GeCHfAd/6DcnpiLdMek3kSCiLJdGQMayJi9/0gftZghRWT+jtCDtVvGKc5bZGox+c8d7SQc5DNThHILd/TkXw6G6W4qpLW24Ie3U5SYSietjaqx7P6+1eAp/sLGh3LxjxUfHah03tT5fX876BR62MBogQM/dpHAFgqQqA6L7KXHjhr/zLvJaxQ5Jj/7pkoRvsjvyBqtIclxwbli3k5tqpbmML96Ex4vEoRsd9FJLKXutjpf5buX8riQEW/HOyCEsmhPn07AKdrl1f0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j81I+PqVSsU6VM8gcJNhWo99oKAGgBIXyRIZsMk+L4=;
 b=utHbH4prDYn3Cd113PwiLlFLZpKoL0L7Ne03xZzJlecuq6K/3nFopTTehIsQjH6bxXc3zoDFq/VTySl+8Q7BdJHY2v12qdZ00yK5GaDNrVMUSuntlgsmG7byemjQYGQuLRqmsPns5X01gdDzN+XJ6I02FnJkZYeljFKHRg2uMBB+upirq2YlqtUc9FdudMcXtzbTfXTxtg8v+HLnmwWYN7SR1wJWLEZEit2Rwuvlqan7/fMhcbaiPQh25XLRLoaWGQKvXYd1zsbSdKD3GwtjBo7ywSwtzH6bXqFc9sAubbxpxNUxuNn6vKmOKWeilJ5ZnK3oWKG9BcwkzSDn55iyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 20:45:29 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 20:45:28 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 13:45:26 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Message-ID: <68bf4066b035a_75e310020@dwillia2-mobl4.notmuch>
In-Reply-To: <20250820102950.175065-2-Jonathan.Cameron@huawei.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-2-Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 1/8] memregion: Drop unused IORES_DESC_* parameter from
 cpu_cache_invalidate_memregion()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::48) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 88458eb4-a458-482f-4927-08ddef18a4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEZZTlJrMm1vWFVCVXNhSE52Rk5DRUsraHVmU3ZVQlVQbHUvUHR5UHMzeW5O?=
 =?utf-8?B?bjBrcVJ4eUFTNTNSd3NxS1hwVnl6enNHcVN3OTJFQlhBNkFYR2VpdlJ4WXoy?=
 =?utf-8?B?WVQ1WFUrZVFOdUVId0tGZ3BvbTlRUFRjNlFhUTVZVms5bGlUdXlVUGpIWlEw?=
 =?utf-8?B?RVZYaXJOYmJjQXpLZjgwYzRtSzh1L0N2UGZLMjI5VmdNd2R5NVJjSjJYbE84?=
 =?utf-8?B?Z0dyci9Galc4YmJCckVTVTFrcHN1WlYzd0I2MHVMOVBRclY3T3FTZHdxcnRW?=
 =?utf-8?B?Qis0NWdzMm42WTZKUk90bEVGcUxvNjluUVoySUdVMTZsWGNTY1d6dm5HQTdU?=
 =?utf-8?B?Sm1tbk1zeVNzVjdGa3ZuWTJ6Yjd6SDBacUkzZFFxUkgxeDE3RlVGcUl1MkpE?=
 =?utf-8?B?MTdzVnVjbUtCdmtCRGZBSSt2THl0OVZGdHVzWGdCekJONU9MdEdRZCs4bVhu?=
 =?utf-8?B?bzlRUnl0bjlBZGsxYzBnbFdOamVLSnE2RTREQ0NxZjBUK0hURSs2b01uNDBR?=
 =?utf-8?B?TTJRZG1zS3ltTk1MalFHNnlJNXpaSWphS29odjY1M2YyeVFwL1orTUtEd2FY?=
 =?utf-8?B?cFlNKzZsQ2h4TkJndldFQVl1MFMwc3o2QXB4bURNWmMzdE9zZ3NUeDhoOWVE?=
 =?utf-8?B?R2EzM2J0RG1jNk1oOFRMbEZaTUlRRU45eXZ6Tmo1QVVYQXp3dC94ZmNxOWxj?=
 =?utf-8?B?R2xrUmhwcDlOZXdjWTZxTlk0Z0F4UmV3SHlPaDNNZzRkMy9ObHJpRVByd3dk?=
 =?utf-8?B?aHZoTmx2TGc2YTh4dHNSb0MrU0crdnc3RE4zUHZPTjFiM0poeGZuNFg3THVv?=
 =?utf-8?B?VXdqa2VxMm1xaVlXb2xGcWZzU2t6b1J4a1RadjRYYzloamN4eFh3VFc2dEZq?=
 =?utf-8?B?VkVLbFVhODcrRGc5S2dCd1pRUGZ0Uy9qbDQzeG4yVDBya3hMWnNZSUZnQzYz?=
 =?utf-8?B?VExJVXErb3l4Skw4TnVxdFc5bjQ3Um5hYVZaZUFmT2MzNU9waVpNaVNjN2U3?=
 =?utf-8?B?WDZkM25Odi9GS1duakNNRjc3aEZCRFlTTXY0S3Yvd1JEd0J1R1AzNEh3NzFt?=
 =?utf-8?B?WjRpWG55ZTNSS0tVOHpXelFYWlhHNE55UmZHRlRKSEJYbUpCbk15eDNjRUNV?=
 =?utf-8?B?SXYxcnlPYlVDTkttOG1UN2RKM3gxQWNYMk1oVmtwOHNWN0NNYUY0eXlBbmdE?=
 =?utf-8?B?aTNqZnJjV1Rha3lxRHJEcmhwRklDZ1ZVTWlqQURJOHlGL0tNeFdSRVR1cFRT?=
 =?utf-8?B?TnIwbWRRNWdwR3pTNnlmTmIwaHlJcTVKUThaSENyY1BVN3hQOEFnQjF6V0Jv?=
 =?utf-8?B?OXM0U041RzVmMnRTTnZRY1dhaWtKYTFvSGplbW5IUzl1dU4xLzhWdDY4Q3JX?=
 =?utf-8?B?YmdpRjBmSlUxQzE2bWRpYU9MNUtKWjkwZ3FOTTNHMTM4Rll3cVV2UUR6a0ha?=
 =?utf-8?B?SFhzNkpMTnZHaVNTQUU3Y0JWNzYvamlxNzFPSmJ5TTlod29RbG95eG9CUElx?=
 =?utf-8?B?K21SQWsrWUM3NjNwMEVXbWdqOVlWUk9ZWU02L2x4VUhkMU5QN3MwSCs5eFR3?=
 =?utf-8?B?bkpMZjZQdXFGKzBPOGtvaThhUHlNZ1FIYWVNY1o5bXpXM2VkNVBoeCtOaHFu?=
 =?utf-8?B?NFlJNWZTVTIxQnk3Q1NXbStlSEJ3QUV6UGdpam4rS0F5dnBiREtqblA5UjhV?=
 =?utf-8?B?TVBzQjBjaFlsYzVpa3BhWGlPTDVQVEZPTFFKWHVxbXUzR1Z4ZUdjQmUwVlRO?=
 =?utf-8?B?OEhEZjRoYmJFSFhqVlk3SlYzS3NPQW9ETXZDN2ljWTRoMk5hYy9IR2RnbEJS?=
 =?utf-8?B?bXpVUnBvUm1YdzYyVTNHa1kwNlFXNngvT3lzUlduTGlTWldKbThoUEZkdDVE?=
 =?utf-8?B?dXY1ejVsM3FOWjROUVZWUFQvRThqU2ZZdkxlN2svNHpVOXYrMUxtdnJ5WDVs?=
 =?utf-8?B?TVJ3T3ZCcmhMamNDeXNXS1p0V05icHE4Rzg4QVE0MnVyV3lBS3NtcnlVVmlS?=
 =?utf-8?B?NmdlY29Odnl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRhRVZITk9KRzRsTUdjd01jdDZlRnVXbmI4ajJad2dhcGdjSHp0TmcvcUlu?=
 =?utf-8?B?aWxBRXhGY0ZIYkpyQUlNc212Umt4ZDhyM1hqUHlQNEJFR2hIVFR6NlBmUUMw?=
 =?utf-8?B?OC9WVGF1cjhuU3N1eGhhLzRFaGRFOVQzczAyOSs2YVpJZ3MvQ09tZW5BS3d1?=
 =?utf-8?B?OXFSMjZwTDkrbTgxZ0s1RXJZWnlPNURMV2wvVE9nQlFrdVQ4WTJxeUZKOU5w?=
 =?utf-8?B?YzhXaWdTbGxNYmtZTG02Z25TT29tQjdidS9BSUY4bk95aFZtZkxvbEp3Rm56?=
 =?utf-8?B?VjUzWFFZMytFejVCTVpkaFB2dlFraHZ5ODQxTkVJK1dSQ3NqbFJsckRYZ3Ar?=
 =?utf-8?B?RFdvQitLWmhHT3Ria09UNE1MMHA4elFoU2hBMlRJb1RkWFpHbDU1RUM3cnR0?=
 =?utf-8?B?ZTRzdllKNGY1UDNYT21jTkxMYW5ndjZ6ZWVDemVRcmtJOGNnNCtmMFRPV2lF?=
 =?utf-8?B?NWFmRjlzYU5RNWVhN3VtYXdLemc0blJ0bVhLNW9sYW0rZXFZSXcwVmFOdGVs?=
 =?utf-8?B?ZjNzY05MNlg3THFSc1pML0dkN2F2dGpPaGdxU2E0K1A5US8wRjdNQWFValMx?=
 =?utf-8?B?ZFNwT2xKMUR0RTNLVmtrcXliR2tZZmx4c3h5ajl4UVcyVnlrclZ1UXRpNE1M?=
 =?utf-8?B?M0F4cDE4WHFQRW95cTlGU2ZXdE5WRDhNVmlKNFlxQnF3Q09QajFQS3c4Vjl6?=
 =?utf-8?B?OXAwK1l1Y2tHRUx3WHliMjNXZ2JvTGpTRHJRa2VGSUIvWUhzV2dpSS9Gbmkz?=
 =?utf-8?B?aGQwM09hZVVLNVhpenNleHZjMzFIcDdNY25DTU96eVovUG9DblRHRG16T21B?=
 =?utf-8?B?UCsvdFgwSGxiMXczQUxrbng5Wk9hazBPU0FCbjBlV3F1M0lCVFB0WGxTdHdZ?=
 =?utf-8?B?U1J3Ykw0S1k5ZFBpT0RHWWRMSTNYUmo4aEZ3ZFlmMXpoVXVFQ3k2NlcrN3Nq?=
 =?utf-8?B?Z2VzYVZSMlByTkJDdFVpZ05EblBsRDZiQ1Vmb2FSbksvUnNoNGJDWWxmN20x?=
 =?utf-8?B?MWJiZVpqenJFTG5DNjJsYUZlYVZBYjdpQ1BoRThmaEp4STBwYjQ5SUVFRTBJ?=
 =?utf-8?B?RzI0d241T3hCcGpqWitYSC9oZHhKSFlGeWpTZmdKMTZ6Y09Ja3pUV2VQc1BI?=
 =?utf-8?B?V1R5YnA3QXd0RUZBSUNmM2IwZHVPM1RJV2pIRmcvVkE5czRnZkxhMlJsangv?=
 =?utf-8?B?TmhUbklwdE0xdExEMEhGanlGd1VFRTg2RDcxSWJURnEvTlpPTTQ1VlBDYmdl?=
 =?utf-8?B?Si9DODB5VkZGVTFaaUphYzhCT1B5OGVBalJISEVNT0JZenlDQmRUVlVVWWY2?=
 =?utf-8?B?TllzQTd4NzRUVXZxZFVKNnF5ejBaRVFaWGI4cmk2MUsxZTlnMmg3SFBITjdO?=
 =?utf-8?B?L1JHOGZUcW5ZM2N6L1M2TGpZNk9RTXRmV0JBWEN4dHY0NHVrZkZKSVZIT1ZM?=
 =?utf-8?B?Z3NBeXd6b0lJUzNXTWhoZnZrUmc2dXJqQzhRYmt0V1N1Y01LSnlSckNrOStq?=
 =?utf-8?B?ZXMrNlhkZlhNSlYvVVBMK08rSmlZOG9zTm5GeXFHRmtCbjk4QUltTVRsTEpm?=
 =?utf-8?B?eE40Umk0VWRRUUFOTVZadXNyZjA0NkZXbS9yWGtYRlQ1NGV3ZnFOb3FkaUg2?=
 =?utf-8?B?U3VjV1V6aDVMM0FZNGJMdFJERmNZakxPdkw2a1ZvaHBqMVYzK3pYUzdQdzFQ?=
 =?utf-8?B?MlF2WEtxUEM3UnhFMmNRc2pMS3drdHVDT2VvZ0hLb09DVElDbitkL2hZYlBP?=
 =?utf-8?B?ak5IQUlMdWJNN1N0MmF3c0ZFR1FkSG1BOWF4dTVVZHdaaXZtdUx0UFZZblBi?=
 =?utf-8?B?RnFzR3IxajRvNHZmMXh3dXozQTNOM0pZa1NzM3BUeUd2SzZtSk1vdlU2WXlT?=
 =?utf-8?B?UC9neWQzV3lXM2Z6RkxyN3BTeHoyU2dYSURscUxndVdHSDVxQUl2MGhlUDd6?=
 =?utf-8?B?M2xVRGYvYWM1RzA0Ulc4MUZER2RYN3h0ckJIdld2elBKcVBmK1M1Nms5Q2lT?=
 =?utf-8?B?ZjBQVU5lNEhiNlAzc0VjaHdBL3ZHUXVnUEFYWVJNOFVOQ28rN2RPMTI2UGty?=
 =?utf-8?B?dDlDcUtqRUVpMVJWWkdUQ2dGV2FTV1pYV3JlN29zemJpYkE0QmpHWUZZZmp6?=
 =?utf-8?B?TFZjdTNwYWp2U0NaRE9wS1dMSWw1QXJLcld1eXQrVklkeUpsTGZkbnN6aWo0?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88458eb4-a458-482f-4927-08ddef18a4fc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:45:28.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1nyT8GGbnA6dnk+ynRZ7nGVR0mufqAWFgrWv6blbMIS6k8M0kjUYKd4q9CM74DdgTtjI3Kkm2WifOKZwiPsfIiYIWclJ2DdhgX/7CfXEGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> The res_desc parameter was originally introduced for documentation purposes
> and with the idea that with HDM-DB CXL invalidation could be triggered from
> the device. That has not come to pass and the continued existence of the
> option is confusing when we add a range in the following patch which might
> not be a strict subset of the res_desc. So avoid that confusion by dropping
> the parameter.
> 
> Link: https://lore.kernel.org/linux-mm/686eedb25ed02_24471002e@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V3: New patch.
>     As Dan calls out in the linked mail, an alternative might be to lookup
>     the ranges and enforce the descriptor but his expressed preference
>     was for dropping the parameter.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

