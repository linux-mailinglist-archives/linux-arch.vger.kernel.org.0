Return-Path: <linux-arch+bounces-2781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB186D7E2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 00:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65D31F22D58
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB755E76;
	Thu, 29 Feb 2024 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPMwZubo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8B16FF51;
	Thu, 29 Feb 2024 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249517; cv=fail; b=Z1ZatCbXz6HkYUg0Il+xezoXelikDdSMD5fEzqmYqphJ6QoK8iMCoGbnY7TaOwznP51cKecx2bJPDcg2fwT+iel+hsfxMcE9WDVIFlswUIJjlA3f+k6AvF329BCnEFofEQ/hs2VknZ35BAyvxwQ/l/4dbPGBdjN8xIQJ/2yl640=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249517; c=relaxed/simple;
	bh=cXf6J+aDFNGpJ7Dky2boSR5+KT+oQgiHGdOZSrIH3Sk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXRE8OlK+SHKBCqrCK7L3Rqm8O6PCvooNKUWWB5AWpXutmmw+LUpBNwjJ+NMEV6O/gGI04lwmm68bEkrxEs+JV9Gblh6jrMq1XLeJcKJqC3PsnnQXe9hVqFTjrGxRFYbNrSPp/x24HBQeNf9r17qccMFO/6uiDkXINWuau92xLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPMwZubo; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709249516; x=1740785516;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cXf6J+aDFNGpJ7Dky2boSR5+KT+oQgiHGdOZSrIH3Sk=;
  b=fPMwZuboPakWm5GcG2XS7LX4CseN8aJssB3A1NmREJKjSvnsnv+rSNgS
   nnwptlZPAVkFrC5XSWKvNBAw1YbHOTXKwksxu6Wx6wlTH75BjntLQC1n3
   D8JaDhVObDzvFp6hqCvVEECbUB/VzGWcRc5t9WW2tDGG/KfTlnf2pSt5c
   spncJJyB2MXbux28DddfKijAJk85wQXYX5PY8WU2qcFrkhtkrdyrvy7PK
   ExAjN4ebMpritZCWvHAuqzO6H3Mph/T8G8TlLZzYHYlqfY/xHg1Ajx8CK
   yf53vNR+/cz2OGQpGzk4v3Og2qSt008us3kdqwKXvFYfpXBfwAqN6BZKI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3620675"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3620675"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7948588"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 15:31:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 15:31:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 15:31:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 15:31:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 15:31:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJa1UwsGmQ6hl/8TLYdYbgpEbiaTYR1JTLpt9mkAboR927gb8/sDhZoX7/SB3Rka0rapaMH9AFydeXY6lqqcuBHuhjV1bKRUcSDZfY27fpJ7Tyl2uTpaWqhGswRUC+C6iA1sMBflaBqEG3GBwOe0WohR3+Xd5vog+7vgTjNmJYM4Le1Sn4E6ZtWn6fH86V/5zsL5Tl9i5Z0SHXRbjyNZ3R+7lAKX8hvjZq9V28EDU6ySjYTGM0+UmgfYYxmev4TRqOkLyHg+IoHMQDeNOi4GyTE385xIEC5V0YASb8CRg0OAorgxtW1oARv5i9mwqg4Rm6UR0PZEma5BeVz0DL6vrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpDfDBFcfhAupXN4DioESmeQFKaabDWYzvtU4lCgASs=;
 b=ecuMCFah//EKGC5/9NcgLmBBtzWdQrJI1GsCJrf1RKmVgvq/u9Cb5lk96WWWC2jtIH/tAOtVbVilBnS+gO7wfKXd1WafQKsHCNz8v6aXs9Zcl0xqdW5dOVqXOmOWoEkTLmHTZO3F4Qcebc1YFvJUkuTYPKqnectmUIq2A0+j8z6upIFV6HtGPNuhb5gsYc/9hx7te19VdArdEOqoEPZiOfAiRcmwbd4PbglayQ73IH+7NqSiZTniZEFb+Ezd7oYqAXuGTllCcVH1xBcF9lw78wKl18EEj83eSsYO/DJst4tKW+U2ROcZHPoHxsnNjE0WY20zeZm7GuxLvkZq5cHJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.22; Thu, 29 Feb 2024 23:31:45 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.013; Thu, 29 Feb 2024
 23:31:45 +0000
Date: Fri, 1 Mar 2024 07:01:58 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: <arnd@arndb.de>, <guoren@kernel.org>, <bcain@quicinc.com>,
	<jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
	<shorne@gmail.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
	<linux-hexagon@vger.kernel.org>, <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead
 of VA in pfn_to_virt
Message-ID: <ZeEM5gBd/eigWreZ@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <20240131055740.2579-1-yan.y.zhao@intel.com>
 <CACRpkdZ_XUmW__y=8R3aJkci+h-pHRh8-xH7ZmfRyQ=jjCbajw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ_XUmW__y=8R3aJkci+h-pHRh8-xH7ZmfRyQ=jjCbajw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ff02d2-5b55-4bd7-3733-08dc397e97b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pMdDntftz/X3Bb6ul9sw5Xt1UIOH2ooL0dqknfm1JhKCvxmD6q3uVGXtHBSpApnxiOyC2jEn9/EqUFmBcZpTGTxTyg83eKsA123t1/QnK0sAXAgfXX90gO1mfneMEGEz6yJ0y7s+Ve+yLXImjUhCGQiU3w+WZDQvXfKYVvO8xjoeREDQXDw9pRyOSwEk+R0ebWt5fWSVoPMUergYh1bxgQzITNDMhPmq4+r9w7PTPlBPVbFpVGHGiLkCE0+k5RgaBtORsncIRH1K9xSMEdO5a+RKmleZ+qW5MXFgKjxr0gc9vJDipXCD63DWsUV9r5OkGng8Y6AkvkT+FicVqVTHx+hEG4Bo664PTI48fpORwBzdxTMUtETEgPkg8BtlI4PXddqdhJJZ/6ajSnxzEHy5khZZwM9Hr5P2gtfEFxv4mMyb/LK5WwoD1Sy+C/r/o9heyU8rYV7fW0zr3+BHgOltH+Ub+zN15mAniseAmLvfBy1F4tYjDUrZ4uKi2oYApWZY3lbMzYW7++yB9ceNScHcH2YJ9cXfr3Rern3NjS6OHnjNYEt9U9RhMRyxKYMxzev7hjh8xbqyw5dwYVbRjc1JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFBvWm1rTWlRUUZnd01DVVNQRUZKMTJnVTBxdHFjOGloOCtGMytSem5leFo2?=
 =?utf-8?B?OUFJcmlLN1NIZUhKQWZWdkNjRXBxWmw3YUNDSFBUam5mSUtRRmFSZVZudDQ1?=
 =?utf-8?B?blhTSTgvV3B0dEVzaXBLZExucFZyZDFZZ0twdG0yOGdrRXFRd0M2dFI3Mmts?=
 =?utf-8?B?NVB1VUpMWmRpanhpZzQ5Mms5M0Z2ZE1kb05XRGZTU0c5c3llV1E1YWNNbDlB?=
 =?utf-8?B?cWRSd2s3cEtRTWRJTHNZQnAvb1NHZzI2RFdwcVN1ZGo4aWFtSDRscXgzNkdh?=
 =?utf-8?B?NC9kUDRsT0I0Y2JMWU9aUCtpYVNtMHQ4WkJlRmU3dHplMXVCTzY4WVgyY3V6?=
 =?utf-8?B?K2hUT2cxbXRSWWdJUHZjRmtDYWJDY3l6VXpQMTdPajcwMmprR0xGUXBraWxX?=
 =?utf-8?B?Nll2VGpyR1FQUzQ2RDBCSHVhV0t5Z29jQ1lFcnBIUzlWeVJoQlNBZHJPeHZC?=
 =?utf-8?B?RDFtKzY4NUVXREh3S3huZUhKdmhMbi85Y09mbUlPQXM2Ky9WSnk1SmNteUJi?=
 =?utf-8?B?aTFIVXZuc2d2aTVVa2FOYndjQmRWY1JQd3RnK1VmNjJPeURlMTlOTnBJTnFh?=
 =?utf-8?B?cGJGTTM2bDM2WDlJY2hxUEgzMCs0OG41YmNvci9vL2g0UU1EdDJXQzM1cmF2?=
 =?utf-8?B?SEZYdGhtbk9zbDdqZmJ4TEdVd1RlbFpLTUFoQ3ZmRWwxRGZ1a0N5K1ozSmtO?=
 =?utf-8?B?Smc5V1ozQXJGamtFVnJYUVZVSlNqS3FmV1VWV2IxQUNnY1ZJZTFwVDJLTy90?=
 =?utf-8?B?WEdoMUs4MUtPWGtTSENqS2lCZHhDaXlrc0YrNVRJS1VjbzVxNGJUNk16SUhi?=
 =?utf-8?B?Vk16SzdQRDMrTEtjWEdXUTdUOE9HbVRoaTVIdUJ4OHRLRjJqT2FmOEkreWhK?=
 =?utf-8?B?RzM5eHlPR3dkWjBEMUJFYVBRWWUxaWlVOCt6TWNOdEVNa1Q3S1IzRVRzcDMx?=
 =?utf-8?B?VUFxcmw5ZlRsVytGbndyT09tS3hyMXU2RUVMT25DbDdDN1dGbDRUaUdVWWt6?=
 =?utf-8?B?U1JtZTdIQnhVSkhrZWN1NnNhVCtvVm9SSURLbzJTTTY4L2FNSmtTUWZqalBF?=
 =?utf-8?B?YUNEWkRTZURDSHF0YVBWeTFZNVN3ejlQYlRIMWFOa3V6R0MvMWE5c2pTVGhp?=
 =?utf-8?B?U1BQdXU4Q2Z3UVBBVy80c3ViRTJZNG1kWURCcjVYZ3k1QytoaVU5aTJiZUxC?=
 =?utf-8?B?ZGx4STBPYlhhQkhwTDNGQTBwYlVXZW5ZK1h2NFVSVkhhdmpVRGxEL1RXQ05a?=
 =?utf-8?B?bUlBYlE0TmFMMTJxek03QnNOSGJHOWpkMFlSMzFORURkaGFKQklVMEFwaWdM?=
 =?utf-8?B?c3dLay9DTGNWQVNBTWt0TVY1VXA4ZnEwbFpWN1Jlck5WQTBBaTA3OUpPVXFD?=
 =?utf-8?B?OHBSeFdldTFLTWRpVzBrNE5MRTNSOVhaMWR0ZlNSZmNhdGs4WHBUYjh0Mzhw?=
 =?utf-8?B?ODF0Q08zVEFmY0lZaHo2L0oveEpJc2RoZTN2S0ZFZUlYSzhsb1RFd0puUzBk?=
 =?utf-8?B?VzlJOS9TMkxOcVdJT1czdnNkUlpiRy9Sa255ZWx6bERxS2tidlJMNVJvd3p2?=
 =?utf-8?B?ZmtkOVRVaVR1dlE2aUFzQzZZRmZNbEdHMVRmL3RrZXdaWUQwM1lieUljTith?=
 =?utf-8?B?clVQZ2ZQMTczaGwzaXVsMkJRWUhGc0FvWFlML3c5bVhXR3YvVVBIb2hyMkR2?=
 =?utf-8?B?V3JnL1h2WHM5Mnk3R0lybzJ1WkE5clM2UVV1MkdkL1lPMWR0MGFZei9GOUFJ?=
 =?utf-8?B?UG9NV2RDN1p6NGVLV3RRbVlsMnhrS1dhcEF5VEFFTFNuOE1Ic3ROSHJUS3Zp?=
 =?utf-8?B?V3E0KzIwR1I4OEMvSVBjSDRxcWt4dGVVaFBBYlNPcnVrbkVqdnhIS0hldjBZ?=
 =?utf-8?B?YkFyZDF1b1dlNkVxbG41WWs3aXZHWStiSEV0VHdwRHZYU1JtaWZUaHpqcFNZ?=
 =?utf-8?B?QTNHOGw4YnZGd0IvM2VoU1htRmNlZFRXZHVtZ0hkdWlJb05EbDdJUzgzR3la?=
 =?utf-8?B?VW5EaUc2K0JnbjFURkVBUkxFZk1uL0RhSUF2bzJOUVBNdTR5WFU1eDVWRzEy?=
 =?utf-8?B?SnM3VzNTaStmb1hpSjRhNjRnR0YwV1BYRDEwbUpoUERnZmMwSmhCVkk5dEwz?=
 =?utf-8?Q?jmXN8LexyCf9nRv1l+Wjwxed1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ff02d2-5b55-4bd7-3733-08dc397e97b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 23:31:45.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17konkrdqvmeX5mB4bcmerl8LiuQnWDeA1ohf9cDdWW3ExhQambPTILQx8xrLsNlevk7rEnuO4uts6uYqWs71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

On Thu, Feb 29, 2024 at 02:34:35PM +0100, Linus Walleij wrote:
> On Wed, Jan 31, 2024 at 7:27 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > Apply the page shift to PFN to get physical address for final VA.
> > The macro __va should take physical address instead of PFN as input.
> >
> > Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlines")
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> 
> My bug, obviously. :(
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I thought this was already applied with the other fixes, but maybe it
> was missed?
>
Hi Linus,
The other 3 in csky/hexagon/openrisc should have been applied in
https://lore.kernel.org/all/20240202140550.9886-1-yan.y.zhao@intel.com/.

This one in asm-generic is not, because Arnd said he is going to remove
the header as a whole soon. 

I explained it in the change log :)
"The pfn_to_virt() in asm-generic/page.h is not touched in this patch as
it's referenced by page_to_virt() in that header while the whole header is
going to be removed as a whole due to no one including it."

Thanks
Yan


