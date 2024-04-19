Return-Path: <linux-arch+bounces-3816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D298AA7E4
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 07:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B932284589
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA58F4E;
	Fri, 19 Apr 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYVtB5ip"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0D29A2;
	Fri, 19 Apr 2024 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713503669; cv=fail; b=fZOSWZH2fpzQmgyBDZNXknoZo+RWoe4kaC+yjdcf+mU8hPZMRK7sh+JdTGEV2fKjpDZoxCWunv8pgc6shrIjGqjMbteFZ4r109ooLyxVVlz2+Inuo9KIbYOlTUQxgbyXkrmcL6jiB4v0qQKHhFRrQjCm0ShXiVXlljvBttzfdOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713503669; c=relaxed/simple;
	bh=4AOpa2pLLBnIBCaimySICXfT4SLQJcVw4MJwW4u/CJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ftEllFbzB9oZ1KE7tbleP8noH8ptTHjGOSbIZI5dWHPj5/jX2WAMYZ7kDtDe8uz6Nw7AQ3ZDp4LIP9oWIWLtqqYfnc5GrpSR4znYt9spuVaC3rl8kmgWdiEMHmwshjZMtIUmmtwM5TiXqF1NY5sxUM5epbuvFXVptRWyF5vkOrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYVtB5ip; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713503668; x=1745039668;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4AOpa2pLLBnIBCaimySICXfT4SLQJcVw4MJwW4u/CJ4=;
  b=KYVtB5ipKy0kDCeyXrfdbOLbkSccacLWDiMJg44Pb+G7GXFvYvR8QXIX
   197b739cmNc/ICFdNngGXklYtFhbmTqPg0jJqcFnDhMPxaL1V1C+tGP+n
   aQuIn5anku/26icO/kYwfCddMuW5hC7nhW7L65xJV+6Vj/6haLeROT+Ix
   nahlhV7GC6EpZDZzsvTMCa2hpQVykeroQGu27iUDj+Yb2u03IQF+yzEUm
   zNIunwznQrwZQIhFqMTN7xcOvHsEyxPNl+iX+aQX+vYZDqmPCZuUxuGMp
   yo8aR4tyOE3sJGeaxALY/WgPg1zJDAfAT7zFOwpBx0Z54zADmkRk1Emhp
   w==;
X-CSE-ConnectionGUID: cHQTqNxdQza0lKdHKjgnMQ==
X-CSE-MsgGUID: 8cIQkT3PREm1Lskp4Wl72g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26548207"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="26548207"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 22:14:26 -0700
X-CSE-ConnectionGUID: 1t/BPMlIT3C3ZdrIVwkd2g==
X-CSE-MsgGUID: nwzPHVcJTAWjJPx5WZxqwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27672547"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 22:14:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 22:14:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 22:14:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 22:14:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 22:14:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2rTJfkUhFjOB89RzobzkL15rR6b8Jy7MRdn1p43vdKzGk4Fm7pxPcf4ePSCSpOjRy0xNL/WWD3oMtVpGxbuUDYbj4TlMvRjnAzbISRU2npl81mmDTl9thIDNCrwlpbih7jBP7ChzsAza0fppX0AN4DvRUCSPa5/QDXrkYQIJdVQsyVhFjzQgpB6wpnCONkRRJW1GDfJAVjwn9tJw6yEiiJltW7kWvIaaZsYHf6Lov24hoxY3UN3jDFMJxG0Q+N1wrgqCGnMH6KcAVEifvZPL/lZtYVBkstpYkLSEe2GojyvdDTedpAGxAr6VMtYjWLs2qv/W0JvlQa8jK37MxxnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+3bg+KlQNyLOxz7/PMEnvDxmXIBLPOJszcuFV5DdWI=;
 b=NSN1qA2u454yNt7bQQW8RAEhVP7zfFY5gR5bGevwEECFq6JYeflD/4MyMa88XgZn9cJWJvnPFkDUvUZ4St8uWRWSnR1SIdK4DnuMGR2cYlqgoOh1L3Ap7bQe6RlvynXlU6psHi5nRW6hPvzb7AJAh+CJuZ3PHeP/u3GQGDAJpxbVYWvgD+Jtt+Sn/iNY6lKXbnZESoZS5c5prCIKkMl8xCY57k7BgLugZuLvmV7Kwqr+LPJV1vdwMIZVln555zXeji0gp8xRjFoERlHB55Rk4ovrLp2HhwFmMXvnyj7zK1KwCGZUJogkmm/7Fy4S8mSWDqimdI91Onh5/0fPlFy7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12; Fri, 19 Apr
 2024 05:14:21 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 05:14:20 +0000
Date: Fri, 19 Apr 2024 13:07:44 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<elver@google.com>, <akpm@linux-foundation.org>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <dianders@chromium.org>, <pmladek@suse.com>,
	<torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Andi Shyti
	<andi.shyti@linux.intel.com>
Subject: Re: [PATCH cmpxchg 13/14] xtensa: Emulate one-byte cmpxchg
Message-ID: <ZiH8IBiLkYw7M281@yujie-X299>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-13-paulmck@kernel.org>
 <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>
 <620a10e8-f5c0-4e23-8403-492ab1c7f110@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <620a10e8-f5c0-4e23-8403-492ab1c7f110@paulmck-laptop>
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|BL3PR11MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9c1615-8f4a-4d1a-7c1b-08dc602f91da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: p+GNixAkJqGkzrtkt+Pvtx3Cjgl0jNHlnTwCKeV4y7GR73rtRzw5QrsI8OUBMk2Jn/iw9rpNvrwlGIFvA/9afSs7O+dW/e/m7o7mpNhbCHb/Oil29xkoply+baBHZUVoWcgShQUzm7Uc69NxfLG8xCNu0n7qgI7OSUe/D2QEWz3CLfv320jljGWEr9W2a55dt3C7OdXsXG/BqAwRhyoGFydMX29gY8sryo7RPX50gT8Rsn2Nq6GzZpXrQaTjvndd/873tls9fd61+pc7KRTLY54H17N7OxXW0Yv/+dGQpoUgLdFxDI/vBcdRh3xsJJ5o2svVLvs7Qq51O1qnEmT5L69cHm3awPQ6PcyQDKTIvGW7t3VJaJXqDFeWhNQK2KFxZOwfVVsVbzfeYdXujJ04H7l68h20UTFPLQEQrY/HHch1WjjTsJuVK9nGGdKqABN3qGOA9RAj5Us3dx3PGVvDgF1r2KgIFDSRpmrfpOOSBdH+8PrpaLxszRYEHMpDXuNERYLV60UohGgXlQoYhRunJUcDtix2yHCP5q7SlqFjTpQ+Z4T2xAXdIIzErD1ohvnVQxQuZN/8OpyEP45Zpo0KIK9CIrLISA/CxS0UvWeqlsm52YMLre/h/L6ooGxUxPeqTe3BLPEPvoAZwfcppkNLw+x1CuvvMNOcnwpfyBVdwbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGN0QmU2Qm9wR3ZUcXpPdC9XYjFETXZxR3BRNVBlR0hvNmkwOE5TMUtyYmpM?=
 =?utf-8?B?UTQ3WC9qcW1RanBnN2xkdElyN2ZySjZPOGhKSGtoeGkvV24vckRuZnk0Uzhr?=
 =?utf-8?B?NzEvaC9FV2FPZ2ZVMkRzeERZRG5aNzhhZHJXUUlxK0drK2dsWFllSlNUT1VJ?=
 =?utf-8?B?RzNJS0VTTmwyZlZ2ZFh1QjlDWGVtc1RYK0p1SDNJZU9iQkM3TDJ5R2NSYWR3?=
 =?utf-8?B?RHBJTERIRnBRcGRHdnJYV2RqdE93VXRWK1NodkExUE92QVNsQW4zM3NoNXk3?=
 =?utf-8?B?OVkyYnVkUFFySlpzK2R6bkhzUzc1d3NOOTAwSDZpckM4QUtFWXVZeWkxbjlk?=
 =?utf-8?B?ME9xT1ZkNDN5Z0VHekQ4VXg4UU1TWkQ2ei9IMTFWb3V2a1l0bm9kWk1ZYnBa?=
 =?utf-8?B?aUMyRUx2WGZqNnFPOFBvcklrUlVyRG1UUVV5Rit5T1RaSVZmWWxFaElqYUhL?=
 =?utf-8?B?eUorU1dtUmJUWmh6cmlOaXEvSEJaajJxaitmQlVTeWx0RllSUjdCOWRBcGt1?=
 =?utf-8?B?aTZyc2FxL2xUUXJMVlNydmRNNFRhV1RiK1dTVUEwb0VNSGpySVBmZFBsSkdL?=
 =?utf-8?B?aVZHYmxzZ2w0QmswSi9GRWFucHdXeUVqQ2t0TkpoekE4RHV4R24vS3RyRDFG?=
 =?utf-8?B?NzlZSXM4a2xBdUF3VDg1UGk2bEgyZkxsTys3emJhcm1ueWlCb0t4TEt6eEo2?=
 =?utf-8?B?Z3RQcDUxT3RHQWg1aTAzdzNvRGtGankyV1dmNjc0MkczQ0I0OWNOL1huUCs0?=
 =?utf-8?B?OXlIUE1URnlvYWRUVkpMdnMyUnNoVnh6bGdTTEh5MVBmQTI4cnNxeWZMZ3Y4?=
 =?utf-8?B?Z1I3MzdYMFNWZjVtV0dzRlArazAvZzR6NGNtbzZjdHJ5ZHJhZ25WbkFxenhX?=
 =?utf-8?B?ZDZ2VXN2c3ArdUpYMmZjWXdwMElqcUV5UUgzRW1UYUJ2dW50c2RGUnNWbmRN?=
 =?utf-8?B?YWQ1ZTZ2dFZwcVIwWDQ1WmFvaTl5TVdsaG1iamFSd0ZPa2Y3WE05bUIyaGEr?=
 =?utf-8?B?K251Mk84V0pIOUZzSFpNcEE2TnpqdHdaNW9PVm12MnRPbjFFWWQyUXZTbUMz?=
 =?utf-8?B?aStDZldMR2FQVGtTbDMwU0dWQ1Nka0pFOStPai9FTmFSS0lxR0JPc214aDI3?=
 =?utf-8?B?dThKZ3V2TWRneXNQMndyeHFuYmZhaUFjSXhtVU4wQURDZ2pHbzE2ZlprY3Ir?=
 =?utf-8?B?Q1R3d2JyWU5qbmdEWmNHNDBpMWorMDlKSHVUbHFPcDhDYmdWT2hzbitZZWFY?=
 =?utf-8?B?d3NkYzBnRFk2aGlPRWVyMUZKMzRyeWdBaTZjcm1VbmRXVTFUVmlnajNacHhV?=
 =?utf-8?B?SExQYmszeUpNd2FkYzF5VFhoOFZTRE9HbytuWG1HYnM5TkNuYnNCOHdkcXYz?=
 =?utf-8?B?N3V6OSt2Z0w4Z3l4b25qRjVHalVKY3pVK2o3R284RFBBdThteVpIMHJORC9C?=
 =?utf-8?B?K1d5VkZkbG5FbW1DYWNoZG1RQnhIcUtOa2tqdTE5S1dNeU1zUjNhTG9JZEpK?=
 =?utf-8?B?bTEvN0I3aW5yYkpMNFNkNTBDVUZyc0Z6d1psU0EzOC9uRGhFZmJHZEVSa3Fk?=
 =?utf-8?B?UEZ2Sm4vblN3M3RKN3BwWUYrRWdHaVltcXZOTDBLVktuUjYvZWc0MGYwbVJ6?=
 =?utf-8?B?RmI2ZDhZMW54cVdzbEhiZGF6R25hYVM3b3hpcTR3d2RVMWZ3K3JtSzFkVEQ3?=
 =?utf-8?B?QkpxekphdnQvbHAyclBVcGtLZEhFNHpMUXpJcURLTHBEMWlRWlY3TGtwMmVi?=
 =?utf-8?B?blJnQWtiajMzMXk3SUFiMVpBekZ0T2kwK0puR3M0NjdVK1cvN0xrY1o2Q1pp?=
 =?utf-8?B?RHZiSW5wUDN6UGI1MkRrMWNZRGdtQmw5OWh6NTZLUmlUQW5WSCthM0JCNzhk?=
 =?utf-8?B?cXl6NmZ4QW9PQ0dzanJTbUNYMnRJbXptRU40RThKNUxrc1A2L3ZkanRreWsw?=
 =?utf-8?B?NTQ4WlRhaUJ4aitlMWJSeTBROUlwdlNBa2NtTTVGWG95WldOcDNJYTdhOEU5?=
 =?utf-8?B?dTlkdU8yQWFNQ1NNTTQvdnZUOXJ2cHVjbndVMkY5SEZUei9wdVRGYmVtMUh3?=
 =?utf-8?B?VmY1MXBHVTFsdHE4c2tKeExJMlNqQVdpWkp6WVQvMWFSdDZ1WlhvbHNVK1BO?=
 =?utf-8?Q?VokohFufuS9dkKqxu03xRNtbS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9c1615-8f4a-4d1a-7c1b-08dc602f91da
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 05:14:20.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmmCY06MiAjHk6OSCIASNjD2YJ/7NyIwLkrKcyUldgWIqKv03qvvFHqgCICehZxXSJXdvP5NAhW1g1wV6o8v3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com

On Thu, Apr 18, 2024 at 04:21:46PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 18, 2024 at 10:06:21AM +0200, Geert Uytterhoeven wrote:
> > Hi Paul,
> > 
> > On Mon, Apr 8, 2024 at 7:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtensa.
> > >
> > > [ paulmck: Apply kernel test robot feedback. ]
> > > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Thanks for your patch!
> > 
> > > --- a/arch/xtensa/include/asm/cmpxchg.h
> > > +++ b/arch/xtensa/include/asm/cmpxchg.h
> > > @@ -74,6 +75,7 @@ static __inline__ unsigned long
> > >  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> > >  {
> > >         switch (size) {
> > > +       case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> > 
> > The cast is not needed.
> 
> In both cases, kernel test robot yelled at me when it was not present.
> 
> Happy to resubmit without it, though, if that is a yell that I should
> have ignored.

FYI, kernel test robot did yell some reports on various architectures such as:

[1] https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel.com/
[2] https://lore.kernel.org/oe-kbuild-all/202404040526.GVzaL2io-lkp@intel.com/
[3] https://lore.kernel.org/oe-kbuild-all/202404022106.mYwpypit-lkp@intel.com/

In brief, there were mainly three types of issues:

* The cmpxchg-emu.h header is missing
* The parameters of cmpxchg_emu_u8 need to be cast to corresponding types
* The return value of cmpxchg_emu_u8 needs to be cast to the "ret" type

As for this specific case of xtensa arch, the compiler doesn't warn
regardless of whether there is an explicit cast for "ptr" or not.
The "ptr" being passed in is "void *", and it seems that a "void *"
pointer can be automatically cast to any other type of pointer, so it
is not necessary to have an explicit cast of "u8 *".

As for the implementations of other architectures that don't pass the
"ptr" as "void *" (such as a macro implementation), the explicit cast to
"u8 *" may still be required.

Thanks,
Yujie

> 
> 							Thanx, Paul
> 
> > >         case 4:  return __cmpxchg_u32(ptr, old, new);
> > >         default: __cmpxchg_called_with_bad_pointer();
> > >                  return old;
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > -- 
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds

