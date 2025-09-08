Return-Path: <linux-arch+bounces-13417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD40B49B55
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A911C7AA592
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584221C3C11;
	Mon,  8 Sep 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czK3TzSd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991F2DE1FE;
	Mon,  8 Sep 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365178; cv=fail; b=aInX+3YfW02Va0cThoPR4yZLHSPXFId8Di8kKr9dkBk2i77OY9nGAkT5S7p1oGS9evCebyaW0Mh+9OKewenBsenuXxijEk9GQXewr4IbkKzEs9H255yb6IxECKAdXvK1fTyJXcKCWeAUUVeihyUycPZfnuHl9VAeLyebHGsgChc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365178; c=relaxed/simple;
	bh=RMaQDe5CfxR6sYXhoTmn2mXn6CUTtNmpwzB3Rdhr+Sw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=k6SydLLsKpFnGjX84rU5K97IY7Hs8CgNrC2pWwCnYygz2awoEcrgh7q7NEo2sjXyqJ8/ougoN5Dc7uv1P8YqwFdWEArBIZc+8y1McwSEqmqQ/GGBVrnFTtFE52Z5cGDDNSQbF3qv8z3xITlfZn6XAgzH+8sEpmjz36VqbQUy8aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czK3TzSd; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757365177; x=1788901177;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=RMaQDe5CfxR6sYXhoTmn2mXn6CUTtNmpwzB3Rdhr+Sw=;
  b=czK3TzSdSnLHUdXXCJfxWh9jWGEAdT5c7+DxkDSqLu3IbgTQ2+LTK6RQ
   iuvXApUPfUAQy+5VhORq6vvxBSX9NiFq2OWdds5TTVnRzLta32KY6yd4b
   dHsny7xCfquEhsGiFb/s+j/lFwKs6UDbhdUa2q5Rhg9syYeqthIuzXB8J
   FQIALgy4UmtyTJeVH+yfrD9bUGaJkNaO60FPc6aMoR7Og1nqheV9YCEMT
   InpaMrm6ftMUKrQ0mViT1taYb76CfhdKXE+GtQpl0YoyNnKWnPe2xH46f
   rK17DpOT25TayKmZiLBAS/9bEcGLNA9cANV5vnWQdDNyE7LMvrpVGQXx6
   Q==;
X-CSE-ConnectionGUID: 3m1IGr7LRQiGzm1O9Rx0rw==
X-CSE-MsgGUID: 3onRnW4JRw21fl1hY1wmcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="85081966"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="85081966"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:59:36 -0700
X-CSE-ConnectionGUID: knqWQYpNQDWHifqeSKyrjQ==
X-CSE-MsgGUID: 90O0eOtGRCykEvRPlPtXWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177205288"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:59:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 13:59:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 13:59:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 13:59:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhZ32KmqpFP+DjQowhGL3g2mt2OGj78n6KqQpvYxlIRxiae1uPcufLbYPvyS4blLmS8sOVyCfZ/VZOa0DLunC22NTIG6P6/6p38zv+i21zicaPVofvs1wa9QWWSE10tiAPYjfvQXSk3H/Z7nXUo+QfzUsopMERSJOSQISiIMPNGlzFNWyCtzbUksq5Uh9FxperZuly3rstMUDK4xZLYSD099ipqSTMaFBmAPZD4EoudT9PaJQD82gbCxmWhosq7yFqX38CfXH6aadRmW0lIHrjg9bmxMWeHELyFB5XngU/mm1xoN2nUWFfT4pGJsyuLyTuyLCFHZz0n7MtPJL7dVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjzv5pfoEc1H33x8W06orfBOSm/9HozpGpt1ZTJIBUE=;
 b=XhokJdTqbQd3EvB3ktWnLIUCZwHkpjcz4Wy0A0nS1G9v4yO0rxwLeqv6JO21/aVVL1rwDuRBDZ71SkxgsEaOTEmL3euA70MBn0I2cvNElqH68I7AC40nG6/ITnZyjOjcttEOvnF4NSlA/SDAnxE4oLju4y3TfTSxHZXl8ekxww6l32Bzlu0ceLrBro1C1nZRaZPmPZkEX/slTjMPZg0ugdW2HS7fV9SlPJ/O/hTrRqhoDGIq1Q9Y52BW/Ph0ZjP/KRWNeiswvamD4SeZJW9MbOOB53a2dqdEnUAGWpniQAxlbwQkQ7lKXSNitrAUjoRJBXPAmxxleDhFZ38JBiL6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:59:31 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 20:59:31 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 13:59:29 -0700
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
Message-ID: <68bf43b1dd06f_75e3100ed@dwillia2-mobl4.notmuch>
In-Reply-To: <20250820102950.175065-4-Jonathan.Cameron@huawei.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-4-Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 3/8] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a71e961-95fa-45ae-0213-08ddef1a9b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE5FYzA0Y3d5aHpzNzh2dzBnMWxIeHVQTFloakZ3amJJL0JHMWR2aGVkQmxi?=
 =?utf-8?B?bEx5V1NPRXhveVpkZHFIRTMvcGIzdmxWTkN0dStvVHluZjV5YjhwbUNTWDQ0?=
 =?utf-8?B?RWk3OGxaY2Nqbmp3WlU2eUc5Y3hvWlVxL0JaUVd6NXg2VTFWZjNpNEY2RVla?=
 =?utf-8?B?RmwzQ09zM2lDb0g2cUdOSHNobFFnU2czVm51Z3d5TWd0SS9mZWVTd3pCZGtW?=
 =?utf-8?B?MzJJeWVHdXYxMTF1U2dnNzFmNW9YMnZMRHVEbzFWMTBXN0JjR0ZzdnI2OE1E?=
 =?utf-8?B?a2N0ditSbDArZ1ZHYW5tUTY2Nm5uSW9kRllWT0szcFY5Y2dQR2dxTEREVTRx?=
 =?utf-8?B?a0RuNDZJaXNDbWYwVTNjN3BpK0NFRG4rUzIzUmRidFhnd1lReE5FS0t5TnBm?=
 =?utf-8?B?b1JtZUk0Qy9wN2xYejhnRzBuWXk2VityMXhMMkFrZmlDcWpOWUdHWTJnNCtl?=
 =?utf-8?B?NGw5dkw3YmNESmVkRGJvYk5SS0UrREE2S2FxMEJyT0JvUS9NbEpMbzVqSEwr?=
 =?utf-8?B?c2RpRVI2b0hwNU9GZGtZdUVoNG16TUpzK3pWbDVXZGExcnFrWHJMalRJSjdw?=
 =?utf-8?B?ekxaaGtQVWpkdGQxM2tLQnZodWFLV05obnJObDFLTjhUak0zUC8rS2lpNXpB?=
 =?utf-8?B?a1JEdEpERG5OV204czJKTzZNeHJwbjVNejJWbHVwelpLUU9PMHBoekdiRFMr?=
 =?utf-8?B?djE1akVqb3ZLTWFTaCsveU5UeUE4ajBRMmVvRlc0NW9sU09HT2hENisvY1U3?=
 =?utf-8?B?OVJJTmhobWVzODMycUxTUDZnTnBqQzMzRXFDWWR4K0ZEZlVpUWs1YW5WWTB3?=
 =?utf-8?B?eDgvR1U0SE1kVzNCdkVkemxzdW1XUHV6d1NmOTZZdXp5U1JZSEtMNlIrSzM0?=
 =?utf-8?B?cDdtbm5ZTFJPcFR2YlZoSXhnRWl3QUVUWGhmdWZrQjVmSUF0VnE3T2VlVVZZ?=
 =?utf-8?B?cmlYNzNYbGdOTGI1eEFJK2FBaHlTYXJmRnhJRHE4M2U2NllqTDNEUC91VG53?=
 =?utf-8?B?M3dHTS9LR3hlbldWdVdhTlJUNU5lSkRHQlh4d0I2NGVWVkZQa0Foa3dqOHpn?=
 =?utf-8?B?Mjd1SzVkV1ZYUzVJbkcyRkJZOElkVzRjekg0SGVlY21xdFB1N291R0lJNS9j?=
 =?utf-8?B?NjdQaXVkcWZhMUxKekZ0RWdmaVkvSDFjUFVzYWt6ckRHU2Jwa0tSaHNvRWFB?=
 =?utf-8?B?NjBYb2xRanI3M3dKVDQ1elI3YnBFWHhFMDY0OUVWTURqeG01MHVnd1dVOHpj?=
 =?utf-8?B?SFk0RWtualVrWEJ6dDFCOXRMZkdIMndzajBPQmpyajdmYnZHZ0trTzM2YnF0?=
 =?utf-8?B?K2hZU0cyMVVGQ0ZzYkdZMWx4c0M1NzhDTTkvRGhmUHRLVlFQNmJFV1BYcmVM?=
 =?utf-8?B?MkVGVkFydkx3QlRGQmhmT2dUbUhnUTdoMVZISjlnSE9kd0wyUEMyWGZpT2Jy?=
 =?utf-8?B?NlgzblA2aWk4SFVPc2ZuYk9iK0VNVzAxbHVtQ1loZ0VKNVU4Nm1GWDJNZkxj?=
 =?utf-8?B?NENjRDNRQVdoWlhnbWNTdGZOY3lKeUQwUmFtN1RFRldoaUNvRjZwcGI2VFNu?=
 =?utf-8?B?NnlVZlNQQURyaXhUa1BvQ1RBNlVqTUROc0o4Z3hHMXYzM2xyWGtlM2xRdXNF?=
 =?utf-8?B?YVpMdFB3bmVQdWkvVUtWeVowUXIzek01bjA1Sjk4cUkya0ZKOXVKREVVdGtx?=
 =?utf-8?B?aFZWemtNU1JwNW53REtyalhpYzJIeWxxS01aQWlqaFp1T1dFS1R6Mlp2eWRH?=
 =?utf-8?B?RVkxaE1WVkdReStmUkw0eDNiUlgxNkd1bXFLZzhKVUE2M05qQmI3QmxqZm9D?=
 =?utf-8?B?cGM0ZFQ0ZGd6d0JOM1hpRGF0K3pZbVlMK3BkUVAzdXM5M0lzbDdIdXdFOHQ3?=
 =?utf-8?B?aVFuREFMQ1JvU0MwZ1hjcWZjK0dFVW42VHlvMnF2SXBUVVdwSUtGRENlM2t1?=
 =?utf-8?B?SmRTMmcrWTIxeXAwWm5Bc1ZsUkZYRDBGcXFOM2xpVmZQYi9ScDRzTU01dStI?=
 =?utf-8?B?cUQ3ZDNZVCt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dLYmhoZ3l5WmtOL0ZmVnlQS1ZSZ1FVRTUyTXllU2w1OXI2TUtvdFBQdHoy?=
 =?utf-8?B?TGRiOEZidUViNGZWYjg3UVJrYmkxY1N1U252d085cFJXWHp4OGR4d0ZqWFhX?=
 =?utf-8?B?SmZUZG5MMGRWUTJVcGFiREJWdTkrNm9FZE55SGphb2VQU2FjM1UzK01HZ1FZ?=
 =?utf-8?B?ek1aQ0tSbWxCb3VEeEZvNEFTMTRxY0lFdVFqTTRvUElXYjhrM1d0MmpsTkxl?=
 =?utf-8?B?K2d1eEY0Z3RaSWJBQ1FTbXJrUWovKzFiQnl3UTVMTVk2a1BIajBVNHc5N0Nu?=
 =?utf-8?B?ZlZRRHkzQmRMeWJROHp5aGhCRUNLZ2l4Tnc3dklmajlwa0IrN3hMT0xmdG05?=
 =?utf-8?B?S3pBWjFtVjBSSkNCMWc3eGxkemQrRzNWQUFKa0hnRDVVK3AxL0lHdXEvQm9U?=
 =?utf-8?B?K3FaSkQ5U0cyVW5acXRvVnY5cXIvKzZGeVNnS1BBQUpjWlZsR0EzSVVuQXo5?=
 =?utf-8?B?eityQzlDS08wOFhremlHSGw3MExEN2RTbFBkaW90Mm9kT0RyemFtWHU3TnJy?=
 =?utf-8?B?T3M2M3BpZmU5ODExamkzR3lqWXpDZjdlejAySjZTNi9wZ1puZE9aTUJsZ09S?=
 =?utf-8?B?dm5hL3lVSUIwOHlpSEdtTzVjWnpySU9UamVTa0t2K25FMlQzNzdRUnRrVEZt?=
 =?utf-8?B?R2t1RkpoVExJemRyZnp6THk4NzNMU1dwRE1paUMvcllaVFlUdlgxQlVndmlr?=
 =?utf-8?B?THJ1WHZZUWp2MHpnaTZrazY4eklYdUxWTElVV0dDb0kydS8zMVZ2NHA2bmRa?=
 =?utf-8?B?WHUwa1JkQnd2SnZENkhXeHBBT2liSC8rZWo1TzRJYVdFSVEvdys2d1BPU3hq?=
 =?utf-8?B?cFBsd3dhQlFMTEJxb2xoMy92Y3Q1OTQ3MERRRU5kVFZxVnBnRk5UTW9XOTI0?=
 =?utf-8?B?Yy9TcEZlNUMrdWF6YStlSmhiNDN2b002VDgrRktNUVlUb1dQZHNWeDNXdUU4?=
 =?utf-8?B?eS9wa2pxcGhoTHUrRW50U1Z0TFh2RkpXeG1pYzhMbjdvcjQxSnA5WTdBdklk?=
 =?utf-8?B?aE9oQ3pJNGZQeFUrL2Q3U2NzRy9RVTR1aHdIeEtrUC9jY2pWM0FoWCs3VnVM?=
 =?utf-8?B?ZFFCNVFTU3NHSW9PdGlzbDc3VTlEVmlndXF0NmY2dGlVV2k5RjBEUDNVL3A0?=
 =?utf-8?B?aHYxZFFuREYyWjI3dm9BVHdBeWxjcDU1TkhHZDZrd05TKzRidDRDbDYvb0JH?=
 =?utf-8?B?MkVDNzdxenhLcnhQUUFKdEdKWHlKMWV5NjRUbkhxTmxzcTlGa0x3MllDdGVw?=
 =?utf-8?B?am1TSEFEQnBNbEU3ZkZ5cHVTUjVvbWVxZUR5b2RNNkl0a3UrZmNDRkFzenRv?=
 =?utf-8?B?MnBMMUFCazdISUlqUnJDTkw3K200NHJZa2JDL2VuS1l3SkQ5bmpjUDcvdjBU?=
 =?utf-8?B?Q200c0lhRXltc3I5ZmtCbVdmZXlCWFlUTU9DQ25Nd1lHMkZwZ2VibERhUjFa?=
 =?utf-8?B?dDJzdFJqT2lYK29jc2VJUkM4K24vQThnRDlyNzRML1BrRDdYaWxrcHM4cXZ6?=
 =?utf-8?B?cjVvT1dqYWQrTW9FZEpzUDd6K1JVa1dtSFdkNGlhZTVDMEVQUS9CQ2NOay92?=
 =?utf-8?B?YTRKcTk4UmQzdHEvWTdVQjd1ZXBLMURNN1B4bi9saHBONVdWNkg1dEI0WCsx?=
 =?utf-8?B?T1JIM1RERnZobjFlQ1BEUld1Y0xoNHI5Sk5nY3dHbUoveUlqK3R4WTByN0JG?=
 =?utf-8?B?WW53MExkNVNUckpjMlUzM0ZvaWRNdGVOYTlxaXZ0WXBaV1dHOVkrdS9FTC8x?=
 =?utf-8?B?K2xMZDNtU1NjckdyZ04vK1F0UVBwUHpBMFJ2NW9qWWFIQVRMTnVJb3Bqczdy?=
 =?utf-8?B?aTFlakIzdVpGZjJ5ZkFZS2xqOFAxM2Y1OXNWSXBRZzVxazR6QmQvVStVa0x6?=
 =?utf-8?B?cGtveXg2Yk94S2dDMVJ0U3N1Y2Vpa2FDOUg5UDFiM1ZOYWdvWVhUbjlhZ3px?=
 =?utf-8?B?bWw3VWx0OTJNa2dUWXM0YnhmZ3VBYXVOQ2N0Tmx6WXBsVDhQWjloaGQ1V3hD?=
 =?utf-8?B?aFJaNldxK2IwZURGM3ZubjZIZm5KK2J1c0l3dTZVUkdkdGZrbm9LbDlpYjdB?=
 =?utf-8?B?dzdzOUs2Y05uNktLa3NSZEhKcmYyWHU3dVNoUWR5MzZ1cUJMdk9Vakp0RnVj?=
 =?utf-8?B?MTg5dDFKeXNLM3JhZno1dENQT0Zsbzg3Y0F3SnBobjNwT0llbitaeGMrTzFo?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a71e961-95fa-45ae-0213-08ddef1a9b7f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:59:31.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oR0VdE4xYgi82WrmqkLnh+4Z8ZDfH/CYcf/d0UCpd35VUVCotFO856s1vmG4Skfil2xtl+/6oWIPA4O8NmCUElGOlgqlFC0Pt53gMclij4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
> invalidating certain memory regions in a cache-incoherent manner. Currently
> this is used by NVDIMM and CXL memory drivers in cases where it is
> necessary to flush all data from caches by physical address range.
> 
> In some architectures these operations are supported by system components
> that may become available only later in boot as they are either present
> on a discoverable bus, or via a firmware description of an MMIO interface
> (e.g. ACPI DSDT). Provide a framework to handle this case.
> 
> Architectures can opt in for this support via
> CONFIG_GENERIC_CPU_CACHE_MAINTENANCE
> 
> Add a registration framework. Each driver provides an ops structure and
> the first op is Write Back and Invalidate by PA Range. The driver may
> over invalidate.
> 
> An optional completion check operation is also provided. If present
> that should be called to ensure that the action has finished.
> 
> When multiple agents are present in the system each should register with
> this framework and the core code will issue the invalidate to all of them
> before checking for completion on each. This is done to avoid need for
> filtering in the core code which can become complex when interleave,
> potentially across different cache coherency hardware is going on, so it
> is easier to tell everyone and let those who don't care do nothing.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Squash all the layering from v2 so that the infrastucture is
>     always present.
>     Suggestions on naming welcome. Note that the hardware I have
>     available supports a much richer set of maintenance operations
>     than Write Back and Invalidate, so I'd like a name that
>     covers all resonable maintenance operations.
>     Use an allocation wrapper macro, based on the fwctl one to
>     ensure that the first element of the allocated driver structure
>     is a struct cache_coherency_device.
>     Thanks to all who provided feedback.
> ---
>  include/linux/cache_coherency.h |  57 ++++++++++++++
>  lib/Kconfig                     |   3 +
>  lib/Makefile                    |   2 +
>  lib/cache_maint.c               | 128 ++++++++++++++++++++++++++++++++
>  4 files changed, 190 insertions(+)
> 
> diff --git a/include/linux/cache_coherency.h b/include/linux/cache_coherency.h
> new file mode 100644
> index 000000000000..cb195b17b6e6
> --- /dev/null
> +++ b/include/linux/cache_coherency.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cache coherency maintenace operation device drivers
> + *
> + * Copyright Huawei 2025
> + */
> +#ifndef _LINUX_CACHE_COHERENCY_H_
> +#define _LINUX_CACHE_COHERENCY_H_
> +
> +#include <linux/list.h>
> +#include <linux/types.h>
> +
> +struct cc_inval_params {
> +	phys_addr_t addr;
> +	size_t size;
> +};
> +
> +struct cache_coherency_device;
> +
> +struct coherency_ops {
> +	int (*wbinv)(struct cache_coherency_device *ccd, struct cc_inval_params *invp);
> +	int (*done)(struct cache_coherency_device *ccd);
> +};
> +
> +struct cache_coherency_device {
> +	struct list_head node;
> +	const struct coherency_ops *ops;
> +};

Why is this called a device when there is no 'struct device'?

This is just 'cache_coherency_ops'.

Are you sure that this structure does not need something like "priority" or
"level" indicator to know where the ops should be sorted in a list? Or is
it the responsibility of the arch to make sure that the registration order
of the ops structures follows the hierarchy order of the caches?


> +int cache_coherency_device_register(struct cache_coherency_device *ccd);
> +void cache_coherency_device_unregister(struct cache_coherency_device *ccd);
> +
> +struct cache_coherency_device *
> +_cache_coherency_device_alloc(const struct coherency_ops *ops, size_t size);
> +/**
> + * cache_coherency_device_alloc - Allocate a cache coherency device
> + * @ops: Cache maintenance operations
> + * @drv_struct: structure that contains the struct cache_coherency_device
> + * @member: Name of the struct cache_coherency_device member in @drv_struct.
> + *
> + * This allocates and initializes the cache_coherency_device embedded in the
> + * drv_struct. Upon success the pointer must be freed via
> + * cache_coherency_device_free().
> + *
> + * Returns a 'drv_struct \*' on success, NULL on error.
> + */
> +#define cache_coherency_device_alloc(ops, drv_struct, member)	    \
> +	({								    \
> +		static_assert(__same_type(struct cache_coherency_device,    \
> +					  ((drv_struct *)NULL)->member));   \
> +		static_assert(offsetof(drv_struct, member) == 0);	    \
> +		(drv_struct *)_cache_coherency_device_alloc(ops,	    \
> +			sizeof(drv_struct));				    \
> +	})
> +void cache_coherency_device_free(struct cache_coherency_device *ccd);
> +
> +#endif
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c483951b624f..cd8e5844f9bb 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -543,6 +543,9 @@ config MEMREGION
>  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>  	bool
>  
> +config GENERIC_CPU_CACHE_MAINTENANCE
> +	bool
> +
>  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
>  	bool
>  
> diff --git a/lib/Makefile b/lib/Makefile
> index 392ff808c9b9..eed20c50f358 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -130,6 +130,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
>  obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
>  obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
>  
> +obj-$(CONFIG_GENERIC_CPU_CACHE_MAINTENANCE) += cache_maint.o
> +
>  lib-y += logic_pio.o
>  
>  lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
> diff --git a/lib/cache_maint.c b/lib/cache_maint.c
> new file mode 100644
> index 000000000000..05d9c5e99941
> --- /dev/null
> +++ b/lib/cache_maint.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic support for Memory System Cache Maintenance operations.
> + *
> + * Coherency maintenance drivers register with this simple framework that will
> + * iterate over each registered instance to first kick off invalidation and
> + * then to wait until it is complete.
> + *
> + * If no implementations are registered yet cpu_cache_has_invalidate_memregion()
> + * will return false. If this runs concurrently with unregistration then a
> + * race exists but this is no worse than the case where the device responsible
> + * for a given memory region has not yet registered.
> + */
> +#include <linux/cache_coherency.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/export.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
> +#include <linux/module.h>
> +#include <linux/rwsem.h>
> +#include <linux/slab.h>
> +
> +static LIST_HEAD(cache_device_list);
> +static DECLARE_RWSEM(cache_device_list_lock);
> +
> +void cache_coherency_device_free(struct cache_coherency_device *ccd)
> +{
> +	kfree(ccd);
> +}
> +EXPORT_SYMBOL_GPL(cache_coherency_device_free);

Why do you need a new GPL export wrapper for kfree?

