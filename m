Return-Path: <linux-arch+bounces-1872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99D8433EE
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 03:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE311B24E4D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C8FD281;
	Wed, 31 Jan 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd6cUGVE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A1D294;
	Wed, 31 Jan 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668216; cv=fail; b=LhSdA5I0zW0FTT7l3d5wYrxbea68BJ/tz48O3jvQHe9FzImABdE+IIog2DcEJ/o6IccitkPy+Bn/zkdvhUg0cwnD7ndpIein9aaBhSqE7d9dszpaWXh1XS9BxnIj/ndMEsNZZHpRZ6fVuHgHAeEDJGkfKykGtfTkWUNjRVzdEZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668216; c=relaxed/simple;
	bh=M+NlpYgEHYf/7JvKivCxjYq7mfp5ZNo1tlSFaQiE43Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dP1GJzpW00JFx4hJHo+ZmO6iwPPSOhPF6nv6vcVZBFn69BBo1maO/VPAv57u3l+J0eKUO6M6K90kgCXzsJtsL1Xhz0+vSZf23i2LgUteiYmwo3ZlQK0ktasrvANnIqNTqKBUf1RLLVTCksAo+Y5vOma9B80sPuJtLtJwFAMnXE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd6cUGVE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706668215; x=1738204215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M+NlpYgEHYf/7JvKivCxjYq7mfp5ZNo1tlSFaQiE43Y=;
  b=fd6cUGVEqHrpSmu9j4U2qU8oiVKzBV8byvSqGkYF9pKz9WPvV0EUNia6
   0h5R9BgN3c6nvW4xpxnnziTvt6tRBcsuDGDn884o1k7ekCUyv4oswspBu
   jTehrLkusTlPlRXNAYsZnnMp+7mu5ARsdoc3zad6jlI1uG6uwFZbSPZW2
   CQwD6PXs38YcSu72VtkrJm4aQRksphKh1VRHFrNHLHjHSyKPJpIz0nfJd
   nY7ok83xfi226EQNRmW8StlE5BmMVltboQzIJZ0NOnFGRHjwLRfU9i+gu
   IAZdDU9Qjs0zhSDVpPPmiXezkWUF/P85bjS7KlH3GwbKu0ZBxDj7MHx+n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3321210"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3321210"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30337978"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 18:30:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 18:30:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 18:30:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 18:30:12 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 18:30:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoFDuwJ1f8Ufb8bPxKYP6Lt0cg24n4S3NM++C68l+qeyNTp8NCm6ODLxVLzrMtAd8cIyLC3eOcoGUGJ5Xah9xsdrulMYqEnmazH/1wYG3rLlEEATzDFvBum7bLLSJDMieg7Rz/XxphRZH9qzguNxeB+7nOV3MOmCdpTxp9o3T1tAt8UGNno9OCoRwuy9m6XbA7yH2tfEg3bINrNhCn8sXQ/c3gNudp/R6iod6+HIAu32/1/5R+kGuuqyhL21E/ehzWG4Xv4V7vDdN5nH6/yDfgRs1ZNvlXF6Wo1ptQ1c58O1cotyacIfkkVeLM5t/efryKzmE4dwKWs4mgImHJJV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0J+b2j8VobSmZK9V4h4YAebBuE5q1n5FyidWXKlB4g=;
 b=Hn5374h/Sk4I06eUxeyQk1Tn2u7aIYzub07DQ7kkgDneqvLJSg2pWz0EbLMF0YMOzxg4ArEneTiB2+O2g2kgUnl+dr3T1V7iWwH+gJH78Cr1lNwY5Im48vk6XSV8ADcgdyrHMn9qjFpnCGMGHzyW2lj3OqqqQQrryFgHNNqnijUchmRQpgR5AMmj1YQmS+zP7QFK/+yaTG6qqdCcfLwNSAxjUrLkQv1d9J8ev5mQDR4XLQqJpQbFsm1A26ia7J/2dn/U824RQ8cq2kO3swAzrrgWz/s9V82ygmf4GmT1+i6c2iJ4MQq4KzcEX2BA/uo/uwaASvEcG9z24ACSVDplxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 02:30:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4647:3802:133d:8fc]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4647:3802:133d:8fc%6]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 02:30:11 +0000
Message-ID: <2375481c-9d61-4f06-9f96-232f25b0e49b@intel.com>
Date: Wed, 31 Jan 2024 10:30:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
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
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20240129143221.263763-10-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c40ebe-37be-4ca8-4ed9-08dc22048c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJS68JfGBcUMu73gnKcjgwaN24+YcQGGSGHb0f61RAScic8ZnyMhklzLvAuhPdsab955afP01BnuR7ml3IsSQodYSVqi0m2IBWjH3WiBwkzDdC/0bQuVe7diGW+C4pNFjaBW66rmtDi771YKjt9jddHt2au/THJEtCJ0TwJiaoSVmP4M0Ev5theVhus0gUuq/NM+HMpHtlvtaF+PSg+fUuJ0nIIEsGUfWxSMvcfpxSyKnWvdHY21YvL+3JD+wP7R//famU9KfrzVQWtqObbyq76057NlD26qyl5a5N7RteE8HoncMcMv/ZYGohjeaMTIHT563DlUTRX8PPfC1WdSHf9EA0m+Kx4oQII8DKB7HNsFMddfkjgK+SlY4tyA2BkyYitOqXQB25yjgaDVWrOZqSy5i/scTx9XxnXOVt/xMvPllzLuA2boCmKtXpluvoxpvVh50VT2ZJcGbSaV8bcGBmXYKq5EZMaYB9uoM2ycMVE5OuCkti7nic3B+RMCVM51QdZCvE5jUBmpFCZ+YwvVVa/IeoYiv65BCGSv3CpobpPaZ1kPA9MWxeIi9nrEWYxxAbmTmz/o8jCcP74rnzLjEW+m6f5qSpmnw0kB2Fp+F86t2DdFgTD0/C9tK4ZlmvghcdE0RZ/FJfJ4dUf5cB9Hsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(4744005)(7416002)(5660300002)(36756003)(66476007)(6506007)(31696002)(66556008)(54906003)(6486002)(66946007)(6512007)(86362001)(316002)(2616005)(26005)(8936002)(6666004)(478600001)(53546011)(82960400001)(4326008)(8676002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lXb3MvMEJzaVJhUHB3Z3VDWitucHZGZHVPZ0VEeVBtM09TanB6RVR6M3N1?=
 =?utf-8?B?OStBUGE4My9MU1BpNEF0c3VxUVNIcC9yVjV0OFRVSXE2VU93d1M5eFIyMWFo?=
 =?utf-8?B?VDN0bEZwNzNIbm1Hc0xqZkdvRjRqZXNkNG9MU04rdlpJN3laeVM1V3pHVklk?=
 =?utf-8?B?OWxZZUgvTUFoTDZ1T1BlMWx4dk5wQkJpZThtQjh2Kzd5YXA0cHRJendBZmN1?=
 =?utf-8?B?S3E2WTFOOElnSW9tY0FlWVJuTnpjbktGeEVra1dMZjNFT3BXMjJCN0NGK3Nl?=
 =?utf-8?B?YVJoTTE5UVJYTFJUSnE5S0pWL3p2UWhUVlhXLzVjNnliYjNhb2FxbDNzU3FB?=
 =?utf-8?B?T010aXk5eHJramRNRmszTUY5bGFyRGpsY1B0ZmxuVm9sN3FvSGZpSzRNckhj?=
 =?utf-8?B?eCtEOWU2UVJCbEF6TWNWQS9GbUlDZnFrVUF1NlRhTi9hUTBFUDFKbm40VGcv?=
 =?utf-8?B?U0JYSEFOWjBwQmlBRHBBSjBXT0haa0daeWZDODV4SUxxUjg3YTdSbm9DQ1pi?=
 =?utf-8?B?OC9zbjV0VVhaWGZKcWI2OFpDZE4vTFl0WTY2YmdPRVZwTm5zek0rRHlLMDBY?=
 =?utf-8?B?b09UdzJkdWZ1Y2N6dXhSQlg3MHE3MVVVODcrWGIxSUZYS0NSMVQvTldxWE5k?=
 =?utf-8?B?RmljaWZtb0k1Wk5PRTJPb1E2QmtMOW0xYnJhcGNucVBDYXpwQ1pkTXFkTU0y?=
 =?utf-8?B?YlFUM1ZGZ0oyQVJCNW5NMy91WGhwRzA2Y1VqRko1NmVKRUZKZnpLNHo3YjJD?=
 =?utf-8?B?MlRkeXhKRWVFTzBRNFU0N1FqN0NGQThKSDFVcEtyVDY0TlpxcWZGNGl4NkRE?=
 =?utf-8?B?LzRlOStzR2N5NmFORjNrR3ZsQ09hb1BlTExrZ0YxT3VYNFRoSnU2YTMvQWRW?=
 =?utf-8?B?US9PTGRsTy81M3Rya3Y4TElUYkJyMzZCbUcyWTZzNEs5UmhZS2tpMStXazJy?=
 =?utf-8?B?M1FIbGRaU0lxZGk3Q0h4d3hWNkxibDhHV045V2VYMlJPeW4ySWE5Vi9rNnVp?=
 =?utf-8?B?YXVRcVpTNmhqR3F0dTlZdGRwOHNYMjdzd0lkRmI2RUU3RWFEbm9vZ3lRemZI?=
 =?utf-8?B?bUpjNlBMYk4rTzVnNjU4L3dqN1R3aW9pU3AxYmpXc05aKzdPWDZHa2pBSEVr?=
 =?utf-8?B?eVdnYmQwczU3b3FyL0hva1grWmcrZ2JmejBYWGZOczQ3bUM5QXZ2WVo5VHJ4?=
 =?utf-8?B?UVlaUEtIbHZUdmc5V2d0dWM3amJUU2tYR2RZODdtNFZ4eEJQSjJDVUNTcFRH?=
 =?utf-8?B?SWEyUDcxalhRQW0zUWxXcXI5MVZPZmVJR0Q2b2R0VVZYbGdTM3RFcEE2cE1G?=
 =?utf-8?B?QkRvU3lIQUhPOXhPQndWcUYrSHhIb2J5V1VVbHNWRVVSNGNTU0xFaVlCdVkz?=
 =?utf-8?B?M09KT1BqaEtRVzZDMDlBSHZPMjA4Q0dQL3NGaU0xUHNncitQd215QUpaTFR5?=
 =?utf-8?B?N3R1VVhMYTdHd1dEZUZMZ0NORDNNVzdEdlNqd0FBSVpSNm5LSTlid05BOGtn?=
 =?utf-8?B?eW5WVWhmU3RIcUViT3VzSzgwMTl3eXh2NjZkSXNNbWNadmRGM25xemtQOFJ6?=
 =?utf-8?B?OVg0QmU1RlVjMm82VXpVQkM1b2s5NTNzeVBaenhvZ2VQMVBRWnJTaGR0WDVx?=
 =?utf-8?B?aVg2NldMUFRCMzNjS3gxbm5mcW9MWEI0R2h2M3RLQ3J1VXovWVRCY1lMRUsr?=
 =?utf-8?B?ZkRGVWM5RTRUY0l6RFpBSFFJTHBBYUtQcm9aNEwwUmRBT1c3TTI3cTR4QTRo?=
 =?utf-8?B?ck1zdXBpbzhBZjR6OXpGQVM0QkpTcG1yT2g5VG0wMEVNcUVzVWpoUXBsWUp1?=
 =?utf-8?B?Q0ozbXVOWVg3a0lhVWhpS3lLM0ZaU3prdE0yUGcvWk9leE1IejdPYzd4OE9E?=
 =?utf-8?B?WGx5QW1iWXk0VWEyNHVLdFRJcnZxTGJCQVJka3o0cklCaGtySWh1MUtKUzRy?=
 =?utf-8?B?Y01TMFFNeVBha0xDWWRZTFNJZE1aWGV3SCt1K20rVUNOL201U3dVYktUcDdy?=
 =?utf-8?B?aDNGV1czZ3Y5NkVYNUVDdmRqdUgxZkpTUitvZWluSFByRzJWL3VqbHBMdVdF?=
 =?utf-8?B?d2ZyNTMyVmlUWUpMU2tLYmtaZEg5N0NSZllFbjJXYkhnOHhxQUNETmVvR1Ar?=
 =?utf-8?Q?PsHzN0h06jD6cARL2vGdD23qZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c40ebe-37be-4ca8-4ed9-08dc22048c3a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 02:30:11.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3GSZYqiBY55mgZ8olLl33EIjUrGFQWojdeCSO+i/VHYl1g8yBO48HmTkItngUYqWF4FHnUAz9FRI/SKFyUX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com



On 1/29/24 22:32, David Hildenbrand wrote:
> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	pte_t pte, tmp_pte;
> +
> +	pte = ptep_get_and_clear_full(mm, addr, ptep, full);
> +	while (--nr) {
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		tmp_pte = ptep_get_and_clear_full(mm, addr, ptep, full);
> +		if (pte_dirty(tmp_pte))
> +			pte = pte_mkdirty(pte);
> +		if (pte_young(tmp_pte))
> +			pte = pte_mkyoung(pte);
I am wondering whether it's worthy to move the pte_mkdirty() and pte_mkyoung()
out of the loop and just do it one time if needed. The worst case is that they
are called nr - 1 time. Or it's just too micro?


Regards
Yin, Fengwei

> +	}
> +	return pte;
> +}

