Return-Path: <linux-arch+bounces-11373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E64A83D67
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 10:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6291B846F4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC620B803;
	Thu, 10 Apr 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCi7IQ94"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166F20C03F;
	Thu, 10 Apr 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274662; cv=fail; b=R4Qtx1q07mi9ujy1hNEhROXFI3PR8WxSeIWwV8ej6xsY1HDSiUu1JuqOmTN3XHg1qkS5qB4kg9JKl5DbeqZReGg5TDxLOu22WQf8uP8seKRDTtNsKW9Tekxv2heBHbzQXCzcdnwFsF9yA+8wB9cILKoPZuHjyTy58Vur/O+Na44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274662; c=relaxed/simple;
	bh=la4Vlc3ak/0GvLo874+OSA1pXgyxAtK24OqB1+JA6QQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6Q3d5erjGY0jUO/ZIHz49Y6ZSv5EhmjzDFiOtpBDFxHkMOulzIWEqgydsG8wgyi9rMfQ0vMs3vumDerP/rCe3/Ebq45EQAnZQwjpCC/Cc585DFBHSCMjfGHKvfnPt3DreeFiqL8qjuDxsZIU2/OJhNrtNFLUay0D+HtCn4J/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCi7IQ94; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744274661; x=1775810661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=la4Vlc3ak/0GvLo874+OSA1pXgyxAtK24OqB1+JA6QQ=;
  b=ZCi7IQ94OSlEbcSMGLMM9bv4uGwXNm8cij00ktIvlO3bt4NV1FM9UJ3U
   BgnVIs9nu0CI1nGvJxmSEKevGCTh6eOPUdM8O2Ln1+JpDMq/g3wCwqxUN
   0bTk9Q+FwXN7BDZVnQ2zZ0a3hPkJEQxffPQtCcPUB1EvfRPxWKWA+dpjE
   4B4SYWBepc/3PYpO5GxmVtOSouSshFXflOJgsV3m8TGSyeq8QrtJT8nPy
   pqaIDk2d9yF4ONt5a4w7pcXjm7q4jI360nEv04vZyxjWgjyPzxVxp3M2k
   hdGceYbBJ4b5QbCE70YPgwMvQjQk5ycAL9rLJHXeDTEqSJc3yBWX8MI2T
   A==;
X-CSE-ConnectionGUID: KiZlCTC3TLykRknCz3yCsg==
X-CSE-MsgGUID: A6kUy6vRSNqanlXJtyaL1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57160369"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="57160369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 01:44:20 -0700
X-CSE-ConnectionGUID: VTBYoZdtQl+dlkHL45Zdzg==
X-CSE-MsgGUID: RUlvG9l1SgCBz3ER9W6MHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129372921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 01:44:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 01:44:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 01:44:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 01:44:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAO7tsI2HmcGX0+Ln4hycdzzpy52A1q+/bycCs698/S57PyJSNGFxSM49IKQcDmni3/9+b+LNJJ0uY++n9Dm9U25lsx9sAIFrLSlmflVj3I8/VbRuJNdpGO1sNag5aID2BUf8creA8TjThb5b2IbPfzNVNQhgU1ubOAzxMv2+CwYKfzkAJx6+An0h6x3HHAHNMCSSlPYnPvsIo8erM5IZgmAyGC/J5yQ6GXnCce2RYoYu5YmdwXzC860n+509jo34q9/V4Shcxszuevx7BbtmpDWRbhXl9GWJtUvogniWhPFliL2+dw9I9eyDIjf5kp8ucC3Lo9Rc6Km8BFmZkbeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la4Vlc3ak/0GvLo874+OSA1pXgyxAtK24OqB1+JA6QQ=;
 b=IB1YD4yD5jNxqzdNYL2V93LzEHRYAF+W0X215DuhZYc9X4pVLfi3iB+7TEK8pnJF4tjPtYmGIoWyYYKNt/O/nUOogJ0hY0HGh5AbkMyR0n5Um1uHcHEVSHVofSRsU3l+JbnrvVrlfNJr4BQbQzIgX4WYCAB0t+Mp4b/8Wxc8QnWN7j2xPs1fdVZSgQkwRlRHH3zbhAIKfUIMo6hMIhGM+tq5Astq/103W8N/fG6kh1abxeN2W1o8wklAzrjYEXm8kGcwLEKKuAjS/1gUksfVikAn3cqOrdf1vj5ZXILHtteCA1ezdbwqdbo1yPLcQYcR5dWC/1eWf5wPLQYeNdMQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6661.namprd11.prod.outlook.com (2603:10b6:806:255::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 08:43:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 08:43:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Robin Murphy
	<robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Joao Martins <joao.m.martins@oracle.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Steve
 Sistare" <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Dionna Glaze <dionnaglaze@google.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Zhi Wang
	<zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>
Subject: RE: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Thread-Topic: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Thread-Index: AQHbgfZmLgQuWYrHx0G0essTqsYGVbOPPZEAgA2FLICAAB4TEA==
Date: Thu, 10 Apr 2025 08:43:34 +0000
Message-ID: <BN9PR11MB5276C2BCF61D01242954A9DD8CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-14-aik@amd.com> <20250401161138.GL186258@ziepe.ca>
 <b051dcc8-58a5-4f24-8b06-e817e9762952@amd.com>
In-Reply-To: <b051dcc8-58a5-4f24-8b06-e817e9762952@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6661:EE_
x-ms-office365-filtering-correlation-id: 950a02f9-046b-45a7-e6a2-08dd780bc7e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFU1KzdicHY4aE1CdGJQeU1EOC9iT2p0M3Q1QjIybXdRWmRJMkZkTjRtYTNk?=
 =?utf-8?B?eTJteVUzcTgrSlVWc3REUTVhYTlMVVNjb1BYRjZzSGRQeWpnc1p6dXFsNGd0?=
 =?utf-8?B?LzNFM05nV3BvdVNCUmdNby9KcENFbkI3bjRzZ01CWCtVbmkzczdmTlZCeFR0?=
 =?utf-8?B?SUZ6czZ4aWlVN1BvUEtzTjNNdzBQQm1vT0l5UXIxOXRFRlIzbDVBQllsZCsw?=
 =?utf-8?B?VzN2MFM2K1JxNzVPSEowRWsxRmVmdDAxUDVNUjBCY1gyNXByWXQzeVhTUy9K?=
 =?utf-8?B?Nmd6WXI3WXJOYU9BSm1pUDZKODJYOVorajBrMkFYWW5zU0dSUnkvNTlpTWpm?=
 =?utf-8?B?MU80a1JLbTFNY0lNN0x0ZFVlWG9sSmRjYXF5T3RqV0N1QUhxaEFScWY5emY0?=
 =?utf-8?B?YkNHWXZpdEpHS1cxU3FTVkNNQTlnQUV4KytXcFhLQU5YdzBnODc2TzNmdkNT?=
 =?utf-8?B?UHF3eGE1ckorZ2VtK2hWaHlFRTVRL2FDYUhRTC9GVEdLOENSUDlaODZsWUtx?=
 =?utf-8?B?SnFYV0xMM1BBSnFwTnI5ZUVDb2ROUnFWaVYwYkg3SDhmRU1hZktPUmlEMmwz?=
 =?utf-8?B?bG1pSUdBOEpQNnc3RllrRm1nK0hwYlM0b29vSU5IQ3JZS1NlR0tDV1RKT29Z?=
 =?utf-8?B?dnd4RVhnUDUzWTVkZTlhcTBCYXhJOTdBL3k5U3F3WGRMSU9abmdRdnhMY2Vj?=
 =?utf-8?B?cUxIaU9aNzRiL292aGkvcnF2aXpYMjhoRjhHakpFajgzT0hPUmhla0p1OWJk?=
 =?utf-8?B?bDkwT3pVQ08rc3ZzT3o5dzBrRCtXWWdOWW52eDBtL2RvTzBZc3U3cnA0OUFF?=
 =?utf-8?B?QWZEZG5nOTBtYlZ6YjhrK0Z2SmcxdllxdnN6TGdkRHFhWVl0QjFhOVhDRDdT?=
 =?utf-8?B?ODVFaCtYQm56Qk1kQm1kaXRyM3V1TjVJVXRucXQrTGFtY3lNZElpOHloWllI?=
 =?utf-8?B?ZHZKWnZpK3lqMFVxd1dMOFdiRXRYZXFvOHpJT29wTnF2UGtjWWk2SXRjeVgy?=
 =?utf-8?B?dlpyRVVvVm9yZlpvaEZBczUveUVxYjFDQVY2ejFiTzZVUitjYy9Eak9iNDBo?=
 =?utf-8?B?LzVFMzZ2WDhFOU5HWSthREZ0U3lnanBhZWx0TDNQL1lyemJad2Y1dWFSS3lw?=
 =?utf-8?B?a0tWWitUWVdidDIvaERjc1Z5ZkM0SURXamxOVDRzZi9xcE02NnFwRWRreXpZ?=
 =?utf-8?B?eHZvaEZMeEF4Q0VzWk9MZkpRTG0xQlNwNWV3ZFE3NW8xdDNrLzBOcGxsV21a?=
 =?utf-8?B?VFdtL3UrZkZCRXBTRWtBNWdXaVlpTGczNkUyOXhnN3lBbVYwakdsamRsOXQ0?=
 =?utf-8?B?NmF2ekoyUXhaTXp1S1l4Y3lyWEJPQ3kxVlZiYjVsRHRHSkE1Y0NpdGZCbitj?=
 =?utf-8?B?UFpwTkJCNnZBb3JiMGptNC84QVdkb3dQVFFiL1Q2VlFnQ1YrWlhWNUdnUnho?=
 =?utf-8?B?VTNpYWdoUk5HUGxjSTJ3WTdUNHZwU0VIbFhEMEpScGJnUUFzZ1YrUmxFUzdI?=
 =?utf-8?B?OEl5ajNQZ2dCQjBCckpIUFNMOWZhQW1jMHRyM1h3UlFkTCtDbDUwR2VVSGdl?=
 =?utf-8?B?QjEzNkFxZW1QeFQwOXVWUzVEWHlVZVF5SzMxWkJNWkxrMkFKdkNnNjdDWU1E?=
 =?utf-8?B?YlliSFdPNk5WUDZOeGZGbldNUndhVGljSmNkb2dNZmZLWVRSSXFKTFFIWHZV?=
 =?utf-8?B?OFRLM1BMdGRMTEhOUHp0V0w2TEZQYjlkRlJVTHVaOWJVSDNNcHBFd2VqYiti?=
 =?utf-8?B?Qm5FdTRRV292VUpTZC9ibGxqbGVLMDBMZzZLSXltNGpTWnI3OXZpcEw0WVA3?=
 =?utf-8?B?NkR5QUJOOUxIeUlmVFVQNUhwWjBBcUdpUGRQRjVNaXZNeW11ZkQwaHluNWhr?=
 =?utf-8?B?N2dhbU4vZ3Z2OTZGSXlrQkdiVG1DcUE0QVFxN0VyLzRySjBZN2IxWnNJWWEv?=
 =?utf-8?Q?rEWXXS1yML0QphYpYZvf6gcVROMvIfbO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anc1bllIQmJpcmltS1U2MFMvVlhrRjZ6YkNFVHlxdVRFTzNoazdidld2SDNP?=
 =?utf-8?B?SjY1RWVVY1l5YU5LOTRBUFFGZlljT3BMbVRhVk5CNlU0bEZsUzF0amowR2ZR?=
 =?utf-8?B?VFMyNWRMbVpzSUpPWkFWRGJ6enFIaXJBQXp5RS9zWExaenE2SHVpRmphOHZr?=
 =?utf-8?B?dUN5eExxb3lKZnkwRjlWREdPZEtyKzEwY25XbW5nRjZEeUptZURHbG9tbXF2?=
 =?utf-8?B?RVZ0SGZ1dXhRNGVjbTVvVjZlRFp4SWxaOEV0VG1FYjJZeEdCeFl5OGcvc2dr?=
 =?utf-8?B?YUtjOERpT0hhWVBkS3l3bnFTb1FmeWN6MkRQVkc2cG1ORVpJaDFibTU4TlZm?=
 =?utf-8?B?eUtmbXdzTlFmUTRLY1N5M3VqUU9EMi8rWS80TG1semtqcTJrQjMxOWpsTEJU?=
 =?utf-8?B?cnNDUnJJUDdXQzFPeGJ1TnlkejdSR2RzVVBaa0x5dTkrcmJsN2J2QVBjRlZ5?=
 =?utf-8?B?c21KclFXTW5xbDNsQWhiUXdJMTNpR1IwUFRHeE9SakE0SlVHV3JaaGRSQjR6?=
 =?utf-8?B?N2JoNXUxdjF5U05ySVk4M3NQc0JqM1g4Y0loSHRpQnZRa0hjZy9hSWkwc0RN?=
 =?utf-8?B?OTZvRmQ1UUNYNjFHL2NtVGRaQTNyL0RiMHVCTmJ2SnU3QklrenFNQnd0NnVs?=
 =?utf-8?B?d3Y0SjdpNkRoVHdWZGtsc2hwdnl5NEwrSnVzMU1RdGdvMi9zamNlTkhhTHRW?=
 =?utf-8?B?dXhNMmdxRXJxZTl5ekwvaWgvZ1Fyc3RUUjhzZVZVZSs5bmZVWVd2RlF4Z3RU?=
 =?utf-8?B?RkJQTUxuTDAxdWkvUGJ5Mm1hVVZCWlFycEx6N21Kd3dhcWNDUW1xQUprSE1j?=
 =?utf-8?B?RThrRy9uWTZ5bGtaellENjNoQ29aQ3R2SllMaForU1MzVE9OTU94M29EOHVB?=
 =?utf-8?B?TDBac3pxbHhVRjM1OXdOVTFBeHY2a0ViTUtubms1WkJtbkd3dVZvb3NaNEkz?=
 =?utf-8?B?emtjZU4ydnVCQ3FQK2d6ZUpzRzNTWXh6MHBvNGRjek5ybXdadU1lc1kwZDI2?=
 =?utf-8?B?UTB3ZmQvbVBQVCtTRXN6SGhsYnpvbjUvbXI5d0ZtcUtpT3hQckpNSXZ5My91?=
 =?utf-8?B?QWNKNzlpbW5FOEhsS3lwTmFZMVFUTm5Qdm5mMndEYkJNQjNWUUVXQy9PcnNw?=
 =?utf-8?B?WWhwaUZSWHk1V1ZyRU9aanE2SE54VnlVR1JzS2pBSUlTV2lhb25Qb3ZNeVhG?=
 =?utf-8?B?eUxMU3dKUGJYOWJQS0xOay9hMmprMVBjMVF3WFE0QXJsQVR1Qmp3UmVzdzVt?=
 =?utf-8?B?UkhuRmd4c2lvbk81aVNXUFdvM1luVTFwQVBpRDNSQVNQNHUwL0JoM1lwZHIy?=
 =?utf-8?B?NnNNazQ0UlFJdnZBTnRrdTZEVi9RS0UyMkwweGFjRW9zT1AxOGl6SjBPSFU1?=
 =?utf-8?B?RzVjSS9YWFNNaDB2MlpqRWFiRkNiZGpieHRFbjZPdGJlcEZYMzcrQnRrY0lG?=
 =?utf-8?B?bElqSUZvVHNOWThYQndJYUc4dHlnbDg1L1o2ejdVVnZZNEpDVk5uekhGU1BT?=
 =?utf-8?B?RFlaQloyU2E1UytNaTBjb29UeHNmUnptQTUyUWJyYm1VcVZydHN0RDBBY3Bt?=
 =?utf-8?B?WlJVVTJuckp2eTVUVnBPUENJdThZdmRBSkxjNHk5dk9peFEwOC8zYzdsR2cy?=
 =?utf-8?B?djZoeG1aTXNxOUhhYnVKVEJsaTlSb1VINy9OS1Z0ZkhpT0JBTmdZSzlnOGtx?=
 =?utf-8?B?UXo2ek5VNXdMaGlONXZBT1VUbExLQkFYdWpUMnJKOG5SaU1xeDlRaGo3TXRx?=
 =?utf-8?B?SzM4b2NqNlVST0U1aTVzT29IMkVVQndtVGZadmFWR0oyNGpHZmtBcjF0dld5?=
 =?utf-8?B?bHEwWElSOTBTYi9CZzJuWHJJODBBK2RDTXJQWSswcGwrVklvcmhGWVE4S2xS?=
 =?utf-8?B?ZnE4N1pmbEQzTzc5RkczS1hDbTd6TVlBdGRsUEhKYmFmSVgrM0tISWlmQVdP?=
 =?utf-8?B?bUlvWXRXQnR5a3N0aUhtdXNZNTFqRG5tV0hyalprTjl0bit3d1RRZEVxNm9L?=
 =?utf-8?B?UWVhMEVybVBEWm5KL2IycWtvNENmTFNpQlBCOEZSaDdyZGVHYXFlaHZzN2Zh?=
 =?utf-8?B?SGd1WXdxdlpPeTRja1Y4aFZLdUdIWi9NajRUL0ZFK093RENoWU5ockIwMVdW?=
 =?utf-8?Q?NI/7ai40gUiQK7LIJoRnQp+AT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950a02f9-046b-45a7-e6a2-08dd780bc7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 08:43:34.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8/5JtP9uG8Nj5gYfRFe3oIGRdOhGENqvZt8RQc1unkFggN1jTOlDSC4jYGdeX3uBVoOs8emUuFY07Evd09gMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6661
X-OriginatorOrg: intel.com

PiBGcm9tOiBBbGV4ZXkgS2FyZGFzaGV2c2tpeSA8YWlrQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAxMCwgMjAyNSAyOjQwIFBNDQo+ID4+IEBAIC0yNTQ5LDEyICsyNTYxLDE1IEBA
IGFtZF9pb21tdV9kb21haW5fYWxsb2NfcGFnaW5nX2ZsYWdzKHN0cnVjdA0KPiBkZXZpY2UgKmRl
diwgdTMyIGZsYWdzLA0KPiA+PiAgIHsNCj4gPj4gICAJc3RydWN0IGFtZF9pb21tdSAqaW9tbXUg
PSBnZXRfYW1kX2lvbW11X2Zyb21fZGV2KGRldik7DQo+ID4+ICAgCWNvbnN0IHUzMiBzdXBwb3J0
ZWRfZmxhZ3MgPSBJT01NVV9IV1BUX0FMTE9DX0RJUlRZX1RSQUNLSU5HDQo+IHwNCj4gPj4gKwkJ
CQkJCUlPTU1VX0hXUFRfQUxMT0NfUEFTSUQNCj4gfA0KPiA+PiArDQo+IAlJT01NVV9IV1BUX0FM
TE9DX05FU1RfUEFSRU5UOw0KPiA+PiArCWNvbnN0IHUzMiBzdXBwb3J0ZWRfZmxhZ3MyID0gSU9N
TVVfSFdQVF9BTExPQ19ESVJUWV9UUkFDS0lORw0KPiB8DQo+ID4+ICAgCQkJCQkJSU9NTVVfSFdQ
VF9BTExPQ19QQVNJRDsNCj4gPg0KPiA+IEp1c3QgaWdub3JlIE5FU1RfUEFSRU5UPyBUaGF0IHNl
ZW1zIHdyb25nLCBpdCBzaG91bGQgZm9yY2UgYSBWMSBwYWdlDQo+ID4gdGFibGU/Pw0KPiANCj4g
DQo+IEFoaGguLi4gVGhpcyBpcyBiZWNhdXNlIEkgc3RpbGwgaGF2ZSB0cm91YmxlcyB3aXRoIHdo
YXQNCj4gSU9NTVVfRE9NQUlOX05FU1RFRCBtZWFucyAoYW5kIGlvbW11ZmQucnN0IGRvZXMgbm90
IGhlbHAgbWUpLiBUaGVyZSBpcw0KPiBvbmUgZGV2aWNlLCBvbmUgSU9NTVUgdGFibGUgYnV1dXQg
MiBkb21haW5zPyBVaC4NCg0KKG5vdCB5ZXQgY2F0Y2ggdXAgd2l0aCB0aGUgd2hvbGUgdGhyZWFk
LiBzbyBqdXN0IGZvciBiYXNpY3MpDQoNCm9uZSBkZXZpY2UgY2FuIGJlIGF0dGFjaGVkIHRvIG9u
bHkgb25lIGRvbWFpbi4gV2hlbiB0aGUgYXR0YWNoZWQgZG9tYWluDQppcyBORVNURUQsIHRoZSBv
dXRwdXQgZnJvbSB0aGF0IGRvbWFpbiB3aWxsIGJlIGZ1cnRoZXIgdHJhbnNsYXRlZCBieSBhbm90
aGVyDQpkb21haW4gKFBBUkVOVCkuIHNvIHllcywgMiBkb21haW5zIGNvdWxkIGJlIGludm9sdmVk
IGFuZCB0d28gSU9NTVUNCnBhZ2UgdGFibGVzIGNoYWluZWQgaW4gdHJhbnNsYXRpb24uDQoNCklu
IHRoYXQgY29uZmlndXJhdGlvbiwgdGhlIE5FU1RFRCBkb21haW4gaXMgYWxzbyBjYWxsZWQgc3Rh
Z2UtMS9zMSBhbmQgaXRzDQpwYXJlbnQgZG9tYWluIGlzIGNhbGxlZCBzdGFnZS0yL3MyLg0KDQpU
eXBpY2FsbHkgc2VlbiBpbiBhIHNldHVwIHdoZXJlIHRoZSBndWVzdCBzZWVzIGEgdklPTU1VIGFu
ZCBtYW5hZ2VzIGl0cw0Kb3duIEkvTyBwYWdlIHRhYmxlcyAodHJhbnNsYXRpbmcgZ3Vlc3QgSU9W
QSB0byBHUEEpLiBUaGVuIHRoZSBHUEEgaXMNCmZ1cnRoZXIgdHJhbnNsYXRlZCBieSBhIGhvc3Qt
bWFuYWdlZCBJL08gcGFnaW5nIHRhYmxlIChQQUdJTkcgZG9tYWluLA0KR1BBLT5IUEEpLg0KDQph
IHNwZWNpYWwgY2FzZSBvZiBzMSBpcyAxOjEgaWRlbnRpdHkgbWFwcGluZyAob3IgcGFzc3Rocm91
Z2gpLCB3aXRoIHdoaWNoIA0KZWZmZWN0aXZlbHkgb25seSBvbmUgZG9tYWluIChzMikgbWFuYWdl
cyB0cmFuc2xhdGlvbiBidXQgdGhlIGNvbmNlcHQgb2YNCm5lc3RlZCB0cmFuc2xhdGlvbiBzdGls
bCBob2xkcy4NCg==

