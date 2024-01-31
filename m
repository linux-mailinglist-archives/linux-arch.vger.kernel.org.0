Return-Path: <linux-arch+bounces-1907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C477843D12
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311181C24BBF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8956669DFF;
	Wed, 31 Jan 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D11YdmbI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C969DF2;
	Wed, 31 Jan 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697835; cv=fail; b=FHwvcF0wDY8X7JXxE4uADypxMBH+XkvFJktfVtwGBQ9I28lhPLOGrBvhV+X8cgcZTW11Utccpv87Hmugl5Jnx9fWHiAONTY20k/Ram/NC5rdTg7HUGimKeXpJbeAnuxR0JgpiA7GShH5Kaqzs0SkJ57ySQOj+g8mbEh436cBr4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697835; c=relaxed/simple;
	bh=iPm5KQU4tHFCMavVHI/tSrCrpfgIiVLN6Qmyc/QzRfQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVEJzDckyniu7SJIjZ7HHlU5efyMfItFaxtaM7JWWom3HVH9etv4fj7QNVDlso6PJ5EKGsxpaak8am5ysdFv0bUqgjbves1iWsixOQObLZwJWcY9jgI3pVrGL/IcGvSWKVFR6xLfG8QQCNcfk3saC54m/Y6aBgGehJu29DJv3BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D11YdmbI; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706697833; x=1738233833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iPm5KQU4tHFCMavVHI/tSrCrpfgIiVLN6Qmyc/QzRfQ=;
  b=D11YdmbIPyn7jaWIm7Ckq0vAd82Dnt52tMVa3fHL+dKdrXYa8FHuWKVe
   9zDITILxAA73pEq5gAWv/Z9Gc21zlJvYgG/QJ8dW8UMjntf1EhJc+t141
   SDiXzwuu16BJYxbv0PALLgz7lpvIm14wIjTiwXNBnUqVTZu92MA1dCfqn
   RIpUFh7Glt5frP0uSOfJ+Egah8msEvF5T64uUdQUpEr31R9uwKIjBvAsR
   Z69e7naI2Ts4pLdIcTCZYCAURVFG0/DtfRF6Rvcw3X7aszb1FfLdXzGCW
   SLAKR4TVSdzA2dYgBHGG7mUvdjy/WqybSekZsjkY6hBCfzvCZLAaeGNb7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10933938"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10933938"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961571903"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="961571903"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 02:43:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 02:43:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 02:43:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 02:43:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 02:43:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfxetzFd8GW2i73WKrrNXLWRWktxkNK/63xephfMdaQXcVMtV0tf5Jvsvb2PoRPmi4UKk3OgRF5R19QE6iLOBVIfstg1EskZw7voegRV4XEgl8z+wIpxELaKcxIEUl3tDWGqS6nvswfoYs/aHOoMB+0jVg8Ag0NVJfZCwq1p5FC6bkIWePv8I1VMKtV9WabUz2lsKc2kFw73TvEqSCJgkZe+/V/Bmfyph80doL/c2e2IctvqkFNY+3OLrASzeEpWM//uSQGSkfunk7vr1+4kfyIKJMWkc72wpu100Ae19Dfi+kKzHVt84PzVIzxOV8bTym1LbpIcMWR4zblzUX0u2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI+xlrLlZQfHefswm1G1uD2Ws1rP25MF2NEYW4cpBVM=;
 b=fruu03nCA25485ChAADppSg/CGKTNgO/GIvMs0G/PQA6fOQq7Y/FiBa/6OuEDvgJJf3eKRVfYfeax8CODwfXDqdXiwIsfCr6Dj+0CMWQ8Kct9wY5nmUkvNdJiYv7jDQeyIsjUFLOz5B1wsxnvopjZmSUM7DE5xykgX8DpU7Lvlw3c0aJs69sOIczLWjgFXGobhj9iqqIbhuAbDI/BD8vM3h2RsuIuN3fSxAf21983qefKOrzQ4jaSsL1e/WDF5B0jqAaWzIgllBKgyZLOgQrhjB4uWzK1qpOV3k11LnHuBYOxiI9C7hQSuUqRoiGy1URIKV0FkOxb7ZVEZhmrhml0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 31 Jan
 2024 10:43:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4647:3802:133d:8fc]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4647:3802:133d:8fc%6]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 10:43:48 +0000
Message-ID: <d7e1e877-80ad-48ce-b11e-2c60e951ec8b@intel.com>
Date: Wed, 31 Jan 2024 18:43:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox" <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-s390@vger.kernel.org>
References: <20240129143221.263763-1-david@redhat.com>
 <20240129143221.263763-10-david@redhat.com>
 <2375481c-9d61-4f06-9f96-232f25b0e49b@intel.com>
 <d83309fa-4daa-430f-ae52-4e72162bca9a@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <d83309fa-4daa-430f-ae52-4e72162bca9a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9706f2de-c9ff-4c6b-32ed-08dc224981a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1OS0x4DZKtojMFHGso8sBhAVBk5EUpwHaVl89VFRUw5spqegECHba02BH5Qmgr4HAwW+jkhJ0/1bihTs+eGxkcPJ+9l/Tz3h3IN+MgmPzTBR+lrpOY3tSDjU4SwBzgYbLbVtOx3FFCXT2K0/AIntjJ0jzCfaK5lfD9up66ebYlPFUjD+OndsV8YkfwAkgO+h0kU4ebb9L6DAcIVQXoUqUuciWcP3A/DAVLEV2wjIuczRuKjy3d+Il0jCAmvcKz6DMwFvSQm2ugvifSuSKDHUk/Um4dMYdNulwLAv5fTI33rJ0crjqfiZOBkzwyGCbs4a+mZxML0BzOKVOkpXYssPANCbNvk/HeXPopP46rX68EdUgkLu76H+wrpoYI1nWwPLxbZl/liG6REowW5NUPS1IiUWDw50rzqlvy2l/Sj22Nrm+cxZkQ7sKBQRv+y0+xL9YLLXW2k0gIi1iWRzmAXRrTVU4RP/i2q53ZiXDQ57fQUJLc1AfBnhlXweWIaKfmryYKERD99Sm6nAAAxCLGKO7UUIhWIkViFVOZNm0yGOxl/2yYsABwvKp0FJ+iaRroLJztE8OnzizIkQUXLVF3Hi9roB43BahdnkgoJcLJP6JxiH7bWow7iDEO7UXAuvzV29hutEdnZiTIos6kWzKC15w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(8936002)(8676002)(4326008)(2906002)(5660300002)(31696002)(86362001)(7416002)(66946007)(66556008)(66476007)(54906003)(36756003)(6486002)(82960400001)(38100700002)(53546011)(6512007)(6506007)(478600001)(6666004)(83380400001)(26005)(2616005)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BwcXkwYmNKOTMwM2Nzc040NGhyRTYyZEJtVkdTaTc3UDlqL1d4TU9oa3pD?=
 =?utf-8?B?N2VnUGh1ZzVWVnd2d1JDQTRIaUNzQ0tHSUh4Mysrb1hoYXcrOHJDa0RlcUlV?=
 =?utf-8?B?MVJrNmRQZFJQR2FkLzlCakR2bkh1K3M2RW9SYXZjUUQyQlZ6UFZGQmFGMWVC?=
 =?utf-8?B?c25RZmRhSTBRTGdDMitPZEIxM1A1WWlYNGx6M3lzM0ZQVklDUjUvVms5Zjdl?=
 =?utf-8?B?Tkk5SlhRZEdIY1JwSnF5RTFJeUhGQk5VSk45NUhleW13Qnd3clBmYXB0KytK?=
 =?utf-8?B?RGg0UjVoblpHYTZFZ01aZHcvSlZWSEtnamhDT0lpeHVPd0xmTDRHZnc5SlRl?=
 =?utf-8?B?U0I2YndFS01hR1FNSXIwL0RJa1V4U0JXNzZJa1o1NkE0TGlIM0ZSdlQ0UFRv?=
 =?utf-8?B?YnM5SWhMTThFUlhvR1JFV1BUL3dGcGZRalUzeXBnNkxhUWh0SjhxQUJOL3FK?=
 =?utf-8?B?Q0JXWUp2VzVGVUlrdDZTMDdLU2NBd0lhS2ZzSnZuOWJraXpEdHRWb0VmODNI?=
 =?utf-8?B?R1o3VXpCbGlmSytSRHB5TFhJTGEzS2toSVFQdFRPcDRDcWFvTDlpUFk2K0J5?=
 =?utf-8?B?MmNDU1lIcUtsVnArdFcrK2NjZ2dSMVVaQkxYaDhwWWNCbGNka3UrOUN4ZVdE?=
 =?utf-8?B?THRKREZ0SHZPYzF0a3pncXdwMXB5WkcvVUlKWXZ0RU5NY2dIWG9IZEp5RU5h?=
 =?utf-8?B?K1hBc2RMTWpLM0QwNlFta0M0SE9TY1FhdS9rWlkwZDBZaThBSGFMQXkwbG9S?=
 =?utf-8?B?eDV1U0NLM3hFeTQ0Y1c4VTJVTk8xN3JoUFJLTFRFTzdXZzlWMEk2QTcwWVBJ?=
 =?utf-8?B?Rk5LaC95dXJEWXZTaTNtWWxzU3RRZjdhZEliMHVFV0FJekxwbmxwUWwxTzhY?=
 =?utf-8?B?Y1Bjb253Q0NNdUJGS1kwUTJ5RW5QSWFNdjNTc0RUVzZpQklYSWJlbmQ0aFlO?=
 =?utf-8?B?dHJWYlZLVU94SjBzRzBxSCtKMHJYbytkN2RIUFo0azhWR2w2Wm5MbjZLVlUw?=
 =?utf-8?B?SDdoUWhEbWxtWEZjRlVJbHMvb2lWelM2TmN3S3hWZnBkT3F2dlBaeXg2MUFS?=
 =?utf-8?B?UkRhcFcreTRqZ1g5Z3B0MFFPOVhHalgyVnp3eXJYYzBJQUFhdTJFeVpHQVQ0?=
 =?utf-8?B?M000Z0w0RSt5UHN6ZWxjazZFSmd3Q0ltcWwweUY2SUR2RlJEc2hPZkZhbVVs?=
 =?utf-8?B?TXpYSnlDU1plRnk3MGNYTklZNHJlTU8zeWhHdTdTMU5taENaNS95NzdUY3pX?=
 =?utf-8?B?d25mclUzNXVIdHFsZ1pRc1dGRU9PQU9UVEx0Vmt6ZDY2NVZCbVJuWHNEZmdB?=
 =?utf-8?B?dEVoTWFPYm95U2U2ZjZsVFBuTWYzVWJTeFVhTnpzMCtUVElQNElzaWJiVEpE?=
 =?utf-8?B?c0w1bXdyNjhQY1RnRWY1V2pCUVJxVTlHMlh6T2oxSWhCTE8zMFB4SlJoNjFp?=
 =?utf-8?B?QWJ2aStkcUhwRVo4NXA5bDVVcEE4YVpKYjJhWkJIVGNwWGFYZnRrdWlvNDhO?=
 =?utf-8?B?TFcreExsU0NKdnppODZydHVsRXhkOVNRK2RZSThYMTJNZVRQNEM3UFNsemNP?=
 =?utf-8?B?eERnR05TOXVHRm94VUdoQzNLb3d5WFdFazkyWkg4ckRzbGRjRHJVQ0pScW9I?=
 =?utf-8?B?WDBsald4RUhxcENSMUFyZ2pHWGxOZVR6ekI4Nk9jRFdBWCs2U1liVDJtQTZh?=
 =?utf-8?B?VlZySDJURUM5Nm5SV0kwWmFDOVo0SThabDZodkRSc1d4ZittM20wRWx0dGhD?=
 =?utf-8?B?VDBxYlJwR2ZpVWhncVM4SHczYy9XZFEwTUN2L3NuaWVpR1IwSHNsVDZwMVpn?=
 =?utf-8?B?emdrR2xOWkh1Z3BmQlU1bWhUejNIQkVLdXA2eS9KUXFZaldGaVB3UnYwVy9P?=
 =?utf-8?B?TEcyV1NtZmYzUHl4R2F3VnhDWjJFSStGOTBzUTJNZDc5RFFNR1dVZWpaam44?=
 =?utf-8?B?TjdCUk9ISUdyenpwVDlTRGNoZm5VVDgxS1VOTDk4bHJHRFpTaHJPc1JadS9X?=
 =?utf-8?B?emp4NkorazNKTkVRdFhNbG1BSXpwOE5HWTZIaVhmc0M4dzRJSHFUbjVxck1W?=
 =?utf-8?B?c2x2MGQ0cmpSTlBWcXZNLzNsTmt3OEYxbXVrUlpWQ3pWZjdZT25oL1pCcitH?=
 =?utf-8?Q?FG140XjI5sBcIVYyo9LGgiftP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9706f2de-c9ff-4c6b-32ed-08dc224981a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:43:48.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtDIJe50qYmfE1/ZlNO+nXbnUoJOXLCzQ1MVygYor3/72vGAJhCYhlZ9zcdpFN1t6cwAiPibYzos5uShtpaFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965
X-OriginatorOrg: intel.com



On 1/31/2024 6:30 PM, David Hildenbrand wrote:
> On 31.01.24 03:30, Yin Fengwei wrote:
>>
>>
>> On 1/29/24 22:32, David Hildenbrand wrote:
>>> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
>>> +        unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>>> +{
>>> +    pte_t pte, tmp_pte;
>>> +
>>> +    pte = ptep_get_and_clear_full(mm, addr, ptep, full);
>>> +    while (--nr) {
>>> +        ptep++;
>>> +        addr += PAGE_SIZE;
>>> +        tmp_pte = ptep_get_and_clear_full(mm, addr, ptep, full);
>>> +        if (pte_dirty(tmp_pte))
>>> +            pte = pte_mkdirty(pte);
>>> +        if (pte_young(tmp_pte))
>>> +            pte = pte_mkyoung(pte);
>> I am wondering whether it's worthy to move the pte_mkdirty() and 
>> pte_mkyoung()
>> out of the loop and just do it one time if needed. The worst case is 
>> that they
>> are called nr - 1 time. Or it's just too micro?
> 
> I also thought about just indicating "any_accessed" or "any_dirty" using 
> flags to the caller, to avoid the PTE modifications completely. Felt a 
> bit micro-optimized.
> 
> Regarding your proposal: I thought about that as well, but my assumption 
> was that dirty+young are "cheap" to be set.
> 
> On x86, pte_mkyoung() is setting _PAGE_ACCESSED.
> pte_mkdirty() is setting _PAGE_DIRTY | _PAGE_SOFT_DIRTY, but it also has 
> to handle the saveddirty handling, using some bit trickery.
> 
> So at least for pte_mkyoung() there would be no real benefit as far as I 
> can see (might be even worse). For pte_mkdirty() there might be a small 
> benefit.
> 
> Is it going to be measurable? Likely not.
Yeah. We can do more investigation when performance profiling call this
out.


Regards
Yin, Fengwei

> 
> Am I missing something?
> 
> Thanks!
> 

