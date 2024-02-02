Return-Path: <linux-arch+bounces-1984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7349484656D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 02:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E883FB2479E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DD5C98;
	Fri,  2 Feb 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPixhsF8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFC33FD;
	Fri,  2 Feb 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837581; cv=fail; b=a6mVrOUQAO5xca2JGp8KG+XCj/yHXhJSJ/57Y45CdZ4pjBQ73RuFnZ3WqBLnMMaesYQCyCibEz9XxRS1Hu6Y6QgUFJKHBqTKVZZb556YGimKWRSAyhqzM0y/fTbv9Ntc5tHBq8gIZaO4hai8YseZ3qai44Ujej01OAmXUkgX5ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837581; c=relaxed/simple;
	bh=f32xjGuhbtbgr3TPJcQ96qVK1Z0ZnXm1kAjOhInwGuw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gem3Ooo0BNAOR8jLVHUGD7DOmRL9+rW8eQLAjLEYod2IA0v/P5s6jn7OSblmmHzV8ANAq7wWn259WkLADft1+HGeqLNxuwuAG6DtZiwBpdrTspAuCJ0W9iDAErxjjw1cfMxgra2a8glDzstwY0ybL15PVEWxF9C0703ppXdquhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPixhsF8; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706837579; x=1738373579;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=f32xjGuhbtbgr3TPJcQ96qVK1Z0ZnXm1kAjOhInwGuw=;
  b=TPixhsF88ZYBku3ABQT9XdoF8S3O/kea+SKRGyfwr9YepUCXYZunLUSh
   Bv5Ic9/mQj9HdjGu9j8E9+uE3R2t/JhLtX1Wh11Nrk3TkrtIf/OXBeqb9
   9w/8e/JxhFPeYvXVOstb4OTXcxbNp4bxXLgZ4zCq9ru9EkLXZv1YjHEik
   /iHThF2EpXbStC87UpNhvy1Px5wleeVB+JgrYJvBsYxaaua4URfU2fHBH
   QwFB4DBxs3lz8pcapxVq3eG8nLn74FlilXm6ArPtlND4g/k0FXhuLyo3a
   DzIn5fwY6o/6QiRU6oEXMaVDz/jdSdWqVZqynk0uE8xZSAJMD5vgiEL2S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="394494313"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="394494313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 17:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="269794"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 17:32:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 17:32:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 17:32:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 17:32:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRzg2sQiRA6MO6aGWthShlQWz3NxBG43pEL42Jz4Ni+QT/n+9/v0UVF0HZmbj9+JQivKcTMJMssDHhUq+mrfzvo2ZP242vPT823LoZ2Pv+fI9778njgbDrD5DoT7G9cn0l4Suuawyx/+3MzpRCwZXAHDx4Boof0b8PtoIlpJZn3v3WR7NcjDgZGeZiflBRCOox4WhtztlyrjxwFqJYM3KrdccUqiGawqzrU8kOhlQlLf9v25hFV9AhG3C6Xt1WUlgCKste88C9z2aoZvVJmJx8jPWXc95K7TSF1fowgURUOUq9vg/Q/YEW9bXHHF/5Ln78im6Y8JZ7slLJEBVyZSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkngHmQY/v6lWEbekaANBHYt4HlP1ABsWpknZqVEWkg=;
 b=GwXrVC08W+xcHbJ9O/LmG6XpvxogKTinMeEvqZ2MPJh2trEugK50+Tvgm+sEKiKHDx5Ns1pJSYekSr4X0h/bJ+DPurTzUK60zhWffSBeQBmnpdriuljrAPWJIbsMpYqFIM7prZ9Tnayu7QinHyT06rsVy62nlQoStYL6ezm3LSRZZ/cBALUfIU6vShNfyVmgxlrfxhEzsWOmpCx49tHsQoc07JPuR2OwPLo2sw8Nt+oDqQjPzfaZcqpFqS/gIhZQIOWLBHshyvokkcrBjlngGz5JTR8Fs8zP1aOW6+s7o8MCLnE+fGNfehVy9agegv+giqFr5UIbDzqo2flCxrXwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 01:32:26 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e%6]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 01:32:26 +0000
Date: Fri, 2 Feb 2024 09:02:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Linus Walleij <linus.walleij@linaro.org>, guoren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Jonas Bonn <jonas@southpole.se>, "Stefan
 Kristiansson" <stefan.kristiansson@saunalahti.fi>, Stafford Horne
	<shorne@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, <linux-hexagon@vger.kernel.org>,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
Message-ID: <Zbw/PpNkCQCbXPdP@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
 <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
 <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|BN9PR11MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e3cd15-2eb7-43d6-4f9e-08dc238ecfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyP04ibiZZ5GdxL7ZRB2jyAi9pCHPWtDNNuC4eGpH4sh49ir9BU+kgX13CIiOku0qffXq0YWa7DSkzI69T6waD15W3kZElT0ONJJdIJj+TchMM0i/Hkraw8hfmVThnE+oWJUwP0dO77IHJcIunbV5MWoQyHewrUD977XzTvssBzvGu/btCUyHiuA26oHE1F/wiIzoyY/t57mokJI8KXfcQXTvDxUn7WqXQSH/rq6kvQctK9Q7wQrZuCIOdKL9+tElvzhqfdUZUceUtFvj5NC2aHRNICExvYvjLf9JrGOtBTPlEunuOxzaABFOq6bVD3jVghxtqAuKlPsFgzEDkCZmFs0o04ddrV6UBqLzZC8bft+glM4cqWOlSI536S0FeTBML63oykfXx7h7sa3hFSda/HZ/eR1BPf7oFD8bWBOFtH0RdSli4gGhXmIrpDc8QOOK1HrjzdIgqdiYNWNej+JcV0WIJQUdXUEE9w3Z8cSO2uqNYQTJu7fLjVx8B53t6SJKuH4DL35UVDNBfFFlu3RPT/ZP7ojGNso515RM2ipNWlucRRggTGeySzs6ekmmvmk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82960400001)(6506007)(6666004)(83380400001)(38100700002)(6512007)(3450700001)(2906002)(7416002)(54906003)(86362001)(5660300002)(6916009)(4326008)(8936002)(8676002)(316002)(66946007)(66556008)(66476007)(6486002)(26005)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Oi18poG+Y3jLaKIHy6TEFDs0ekb220EztpBIy7FRmbPa1OIAY3OKsmMFP9f?=
 =?us-ascii?Q?HM4V9794irivqQTyj5XirSdJ3y+XjrY49yW2oU84pDzEm73xdtGZ8DJz3BBk?=
 =?us-ascii?Q?rwTcxGIkyopWiWpkMddtTAWhRk6eb44pyxU/ibla9Wa0bDyEaAEC1FEJhJb/?=
 =?us-ascii?Q?nU0lM/hn2mnJGyieoxT3ACFjopUur1YODF1Owxbb3cSJ6XQGdPGzvfIgWdIh?=
 =?us-ascii?Q?2wmHJeMxOcKMsXycJxlXVPqWDPQ/f8KorKGV0FGn1nPjHLMlahjnXRS/gErw?=
 =?us-ascii?Q?qXjKqSuw3IJ4y3NLP5RDfOoDV0MqfWwj9TU1flG63aY5jKxZGgsI78G3ufFf?=
 =?us-ascii?Q?urJJnnB/FKEJH31/kiZdWZ4qYSWhtZ19QGSHtEZ8T4JcnFIagr2DBFtx6LAs?=
 =?us-ascii?Q?yKFyIpdHIoHt7zIxMwN9e5uU4jTMJ7nQn0MT1yn9Omp4QNkdnqtnDMag9r9F?=
 =?us-ascii?Q?57hitURELsmJaq7affLFgDA9x1i5arMkc9xmYvWRKfmFcczyZqEGqSwUMYyP?=
 =?us-ascii?Q?3thziOCiQghcxMyxfYN+25KfPF0Y5ciVli/d86yo815tIj6/sAvxafQNVlZx?=
 =?us-ascii?Q?qhPrH6bsJ/hIAAVJt9p0jOF+3e4VYwcrke9WHzzXKezCvdmESMRH/QMh9JPF?=
 =?us-ascii?Q?BIga4OV9VUcwto3JvoK0Jgiib9pfieusftKWaGFIufqoa4p7mdEDMDKOb18E?=
 =?us-ascii?Q?8X7vyRQTxG5xKSTt2+d9m86MUdoVy9rQfF5S96oVtOJfaGNyiNglAwW0bC/p?=
 =?us-ascii?Q?jszOsbZHWCH4cbIX6TwHEzqKSbFVg02bRCb53q6ZrhFBKHkFdaeu7dLA+DfS?=
 =?us-ascii?Q?eIL+7HEh7zui6e5Pw+iunpeDzp3IhmwG42xqGMNapknlgPBnmdjyagS3FL/h?=
 =?us-ascii?Q?B8paiy9O0Nyz3pkB0gUcUyx7SAPbhbpKplvwim4HHk3qner8zShI82CLZRyb?=
 =?us-ascii?Q?5pX28XrdayEtt5HsrHP8wNpWVSarGpYLKSiI+bOyMlFXDJH51g/lrH35ETRP?=
 =?us-ascii?Q?ylrR1qXij7nEsN2r9ZUivHnefdN5ot61MSRZUHYxX750/1obsEweI2akFxzC?=
 =?us-ascii?Q?uZESY9m7iytx8Kg2D1PRAvyDQB7NJDyv1r0jHL3caKHMjIgZCYOcvOB6vRLB?=
 =?us-ascii?Q?wDtVO/bQVEIR5d/Qa3ZmgKCaS56Ivub7EYd9hzixG6BxQU11Tpv7VaJ9iq8P?=
 =?us-ascii?Q?IZKR3KbTvRj9oJYXASMtMd/Y+KHu898s5CXYpeA9poHchgkSiRFnKogqlm3c?=
 =?us-ascii?Q?8TDWBRZhD8vZBKDEe99Y+LCJ/SUCCrzFAFAHUfbpupfcDu7e1l/69OLp0mYb?=
 =?us-ascii?Q?H7IRTuksf8skbfCRRHpLEzvLVXLYbUR75aUc8RsEf1LyWYnnF3lka+2AiUh+?=
 =?us-ascii?Q?C5BavqKvr5ju65OKDPEZeOELH3qrjgd0DFl2eHR0qlpJmKTQIOLilq3C4EKN?=
 =?us-ascii?Q?Z2Fa5utPHDd0JCD5V06nuvuy6zHk+//XtlBYkNVlvSLASSBmRS+1IOv5Cj6G?=
 =?us-ascii?Q?IUNB5xarbjjw1F/xYAPfsNe/Q2mB7w8fBgfbTsXLS+ZFKKg8ALbL3kJUA74r?=
 =?us-ascii?Q?jr0nEi3THmlwgG9gjlJ89xK+4EwLs5noNhAOBAmf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e3cd15-2eb7-43d6-4f9e-08dc238ecfe8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 01:32:26.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05cStZuAIsWuYWeC1UawUBTwi+dhB/pDXWnb/5+kEjwA4We5tKZq7NEdghcNIMFMbMldtqQmMUbwbAKDlygUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com

On Thu, Feb 01, 2024 at 06:46:46AM +0100, Arnd Bergmann wrote:
> On Thu, Feb 1, 2024, at 01:01, Yan Zhao wrote:
> > On Wed, Jan 31, 2024 at 12:48:38PM +0100, Arnd Bergmann wrote:
> >> On Wed, Jan 31, 2024, at 06:51, Yan Zhao wrote:
> >> 
> >> How exactly did you notice the function being wrong,
> >> did you try to add a user somewhere, or just read through
> >> the code?
> > I came across them when I was debugging an unexpected kernel page fault
> > on x86, and I was not sure whether page_to_virt() was compiled in
> > asm-generic/page.h or linux/mm.h.
> > Though finally, it turned out that the one in linux/mm.h was used, which
> > yielded the right result and the unexpected kernel page fault in my case
> > was not related to page_to_virt(), it did lead me to noticing that the
> > pfn_to_virt() in asm-generic/page.h and other 3 archs did not look right.
> >
> > Yes, unlike virt_to_pfn() which still has a caller in openrisc (among
> > csky, Hexagon, openrisc), pfn_to_virt() now does not have a caller in
> > the 3 archs. Though both virt_to_pfn() and pfn_to_virt() are referenced
> > in asm-generic/page.h, I also not sure if we need to remove the
> > asm-generic/page.h which may serve as a template to future archs ?
> >
> > So, either way looks good to me :)
> 
> I think it's fair to assume we won't need asm-generic/page.h any
> more, as we likely won't be adding new NOMMU architectures.
> I can have a look myself at removing any such unused headers in
> include/asm-generic/, it's probably not the only one.
> 
> Can you just send a patch to remove the unused pfn_to_virt()
> functions?
Ok. I'll do it!
BTW: do you think it's also good to keep this fixing series though we'll
remove the unused function later?
So if people want to revert the removal some day, they can get right one.

Or maybe I'm just paranoid, and explanation about the fix in the commit
message of patch for function removal is enough.

What's your preference? :)

