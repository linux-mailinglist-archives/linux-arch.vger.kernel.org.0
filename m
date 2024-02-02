Return-Path: <linux-arch+bounces-1995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134B847212
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E87B239D4
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C442A82;
	Fri,  2 Feb 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3k3M0jI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DC20DFA;
	Fri,  2 Feb 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884803; cv=fail; b=ZqR8ID62KubWpa8EiR2dbJHsyr8EnoBfK7vP6SDSo/CTAvXMW2PJXI+TPPJ+z6hktWHtr9UezRl3lzd2fyRtEqVzwjPjq01dgSiWhilbN94LySOFYz5RrYwdCDvlyKL44rd7CeMOCniYOFtBXc8/FMAeY+GomnEMyeNh/SstpSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884803; c=relaxed/simple;
	bh=pYsCDGwyYymbmB+k6Y2V4kh/gmMwP6zECw704kEsf+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VBjRSrVHL2UMLJc8Bhxhh7glXSpd6XWqr0r6ONrc63TleQjIghElKDe+j17BI3LdY20LcU/r67wExxz6eU03q7i8MFCBFeqSVUDNGWdGUKEdWX1mgeC9/BInaMQod+IGTMbgmGjMxNVf4qqgljQsRZ0zdgVNuQPqZy09gn9jcZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3k3M0jI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706884802; x=1738420802;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=pYsCDGwyYymbmB+k6Y2V4kh/gmMwP6zECw704kEsf+Q=;
  b=f3k3M0jI8ePgwD5si/hRDrhKPSQywkvJV7SyRkyxayjFtZJ1Pa4GXaB9
   e832Z5uiF3ZsekJzPyQHJ9q2/2yzaCFqOPLmoh4KzRgQBAi8N5aBE1Oak
   MGVYekviBvAcmvJAg1NkFj+S9UqYFarilQhxMoFohU7u3fDJpe0x1Ofb2
   gz61dtu3gjfrJEavmcB2NpXWvcUQgI1uE1BiOmGVDx6QcQjQ3PtD/nIVg
   0eS2Yv5dZvCWqj2puoC3elAYj1pDxf20e2ouYzRIKcqmc8ADEGP7SQwYh
   iUoFwoaGvOvG3qSE9BPQtqk3NcJSTUDHhr5Kx+57dZWklTxQryzMYyAfo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4067877"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4067877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="368644"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 06:39:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 06:39:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 06:39:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 06:39:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 06:39:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlW6gEOXvR3Mn1P0B6NgoyBQy/ky1LRkwUaBLCH2LmKbKzi+emripGO5K4Nsi24JIZFwg4kKq2o/z1yFoV9k13RmS1JksXydil9Okrx1HoN9+bStNxB7lgI9WnE4iHnhM6RkG0wTPBSvY7+2+rfW5yVvFJad9TccNO4ycg21ZLfNcANUXkIsPdtLVTA5iQso/862XMHTLWZXlN65qGw3OY5Sj++e8D76lk/MBR/r4bGqeKhpE846Xaz12FNNFJ+O+ZmRz0r1sGn5J1MPfn4CKsvT+98P/+SCeROc2Qb3PYPoLxFugVTVt+T77Bub4uWD7T7SyuO+QFUEs/1KkeaQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dor3yZqd/Db7aUYo+NgPp4C4OIbol+EPXFqML7to7g=;
 b=heSUTIXKOTszwHc47W+luMVv8fJB7GAWdKy6xuS82SBcNZ5eNdzYmTYvqI4ZuUOigQBq6jmhTH2+lPRvHFhLMdZn64rA1k4uT1FL3jm/qb7AVGdhb7njaDHPKY21VYS0YBajPlfqka+Eto6NlipxZGwS6DLazgVOwn3FWI6/JsN5s9NBdxlmvIVV1Rtl85yIrT5qYqA/AOrf+YhhMG40IKi4DgJFdJfGu8PDzp7cWkGLbsimwzdkQ5C1YBopqOqREkxgXFgv1NtXT7F0xHIic3qU3NcpGATY5Nq3XXY8+7Yj62dLvLmcTs42NPUVWndYQXaycZQlbYr8fPpJq67MKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 14:39:20 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e%6]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:39:19 +0000
Date: Fri, 2 Feb 2024 22:09:45 +0800
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
Message-ID: <Zbz3qVq+8le1xuKr@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
 <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
 <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
 <Zbw/PpNkCQCbXPdP@yzhao56-desk.sh.intel.com>
 <33a5d3a9-3154-4dad-afae-18b16e6cf61e@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33a5d3a9-3154-4dad-afae-18b16e6cf61e@app.fastmail.com>
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed646ca-b1e2-4fa2-2eea-08dc23fcbd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4b+tUYRRZqSJhK5/tAdLO2m7LpBsGy+jOZVQoE5ZGLvnL6PaZM2lar/SFZGmTzZ4rarIUOrkIaeguc2VIppyuxpX1pos3/U9XYtg0Hi6zsqzcvcyM738vzQ0FDvt/N82Z8/LXsXvIyJDj+c4At020lG6XetV6pUmOgpqlJuOUFGeYZRK+8XmiUx1t00NCD2JbA9AONUcW8aC6vLcwU34ui7vIzFcKGWXcOuoIpK+ydW5DpI2DmWGYgxl/8axZPq+YYmlAyXnmi44758qls6KcB8tgpfyXKfltlDjnfhS0+y7xTcM8vK0vM/BNGGDYt4hYYJgChW0uerNSPqL40wYpm1izM2s7opJZwt2rZWuWE8o+54TUTexOoRSCDSdCvlbigbHqzDVhiTqLovDBY3+qRHCzS1QTtVer/tJZAmHYAwPcKd/POlufYWrehXVEBWOt19F7r+5bDtngmHHWD5bi1cvGNkPI0zz9g3uPfglB3z9zHisNwynu9kXvDjpfMwv2WvheZAQyFo6otR64FvT603awrDX5dVP4Y1YeP+4HkRlpP8QZyaC0N2/kzSPUJwhLSQKVo0zFiMNyTPSPp1Td90tYYcae/bfYnSCuD78Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(6506007)(26005)(6666004)(82960400001)(41300700001)(83380400001)(86362001)(38100700002)(966005)(6486002)(478600001)(8936002)(8676002)(4326008)(3450700001)(5660300002)(7416002)(66946007)(2906002)(54906003)(316002)(66476007)(66556008)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1RLqVPwIWnXKGSHCAWw+UD85Lj7J7bQH13oUGPsKEMu6nv1uplNt21YBdc+?=
 =?us-ascii?Q?tRv5wjfECIvB+Yt2DOGQWnXjeoTNs2zB0p08vAa2EYlGPja4Y/xNLZCErAjE?=
 =?us-ascii?Q?1kw//HR5K60sUiCapiDJ1G4ltS0797CD2xXFqjs3s3erbYpOZuS89XsNKo+5?=
 =?us-ascii?Q?+ZxdWjzUItrYuT48fL2A2HRwRt5sA32WfMDywR3xtVX8z08qWt7z6WxumTYt?=
 =?us-ascii?Q?1dtDZEaas0jbZLPI8FtiFnLSYokuXRvJpWNL9JHpahe0OdRyLbhDVCYB9jOY?=
 =?us-ascii?Q?BKQt/iYiTT5p3Sa5mNWMWiEJdcq7ON1Q+48t55pJF8jOLR0dcP7tagxw1FLO?=
 =?us-ascii?Q?6iz0HebsL4vj/yobxeBYvc7V1boQLOUIpygoaxocd/MIPqVvcGzWWEn8MCbO?=
 =?us-ascii?Q?3xVJfkV2LiHXE/dzpwwGgRhcr5iiCtqFy44KbmSw8FjwgaIT+d3hr5QwmOi2?=
 =?us-ascii?Q?mXR3efaCVyb+zlUmD5kELxq7qsFyhWqQb+HVns+F+SUh6xe1mS2J3PEfULAs?=
 =?us-ascii?Q?vMKomjn2S6Gr6gfvss4qNkVywSj8ok+TiCHb8Lmcv6Rhzs+/9DP11tLtyP+Y?=
 =?us-ascii?Q?VFy5aL4Hzlvb7OVXZAE27c7VmQFuQTo1ykgh8augBNJJfSz5og4rc6HXOcUZ?=
 =?us-ascii?Q?CqXAfMXgLoCgu7LVQ9rwFepZHBGPGXtdjodZ/7IRYO6GxwLKY66ZDTgRid2/?=
 =?us-ascii?Q?RPosQ35bzht9neEx0mHZ8CiQwceIDvRxau31sjEvnfWzvO3nlCf0Bi9A6Don?=
 =?us-ascii?Q?AyuwTNNd7AqpFxYMcZnw3SMp11EpIMTo8wXdTO4HgWZwDhKVIsMHQxHxAunM?=
 =?us-ascii?Q?kqguuP83xksmO/Oohriq23Dk4sAdUvm8W7aticTxuxhnF9208RjrBCUH/K7L?=
 =?us-ascii?Q?GtpsseGa0rLo2iUt25dSJ8d29Fe6YLpO8l7B/gzIY7JOI5OUATcmNyz65HQ1?=
 =?us-ascii?Q?QZEak1WV7pLbfBwwRktqli9EC0UBEPcRHnFFHTjj1lOuUdcCDkbqsAqvtFMz?=
 =?us-ascii?Q?hEODLfuZUSB8TeiSG6JK18H8UbI9W4VwilOgnT7FN+suI7Kr8Nl3mJGk0loB?=
 =?us-ascii?Q?O9ZvghlyyP1ZO/Zz3QYc7VhSysZJiIXQO1/JP8mLTLtzGAEGMFP/oHXe6nQ8?=
 =?us-ascii?Q?CkcdduYkurqIJa0BsNZEAuFHOL4KXytOfn25ZuXSgZh8TKBe3j0DIOT/GWZo?=
 =?us-ascii?Q?YYBpBOMVt2fg3+cMDLm1MtG3ow123wbofAow5RE6D+E9OyRKPBstKSpK92tj?=
 =?us-ascii?Q?P76TNySAgkaPac0d/4zlCvdK5bFJLLBAlKTLkSIJ9FMbRT2uJ5N1H7svzoHv?=
 =?us-ascii?Q?BtQf62QWT7DSGbKW6V7qBT2TaCwKu411aRQmYFUYFlFjl0IR9LpIm/YuzNeq?=
 =?us-ascii?Q?eC669Jx6MghY4DIKrynwc2RMzZDYXxP0wQLAeV5AxsYecuDNU34ivO8yIo0s?=
 =?us-ascii?Q?tSgoJpwSZpHExw0X0TqtvE0M8g0hwSuMI6omNzctAw2ZnIuVpKGsMdTrAoRe?=
 =?us-ascii?Q?AfUUV1zQlNRRt0ipxwaliZfKzCDESRU1ezBM+0oWa4YWpGugL+c/PKUcMvEr?=
 =?us-ascii?Q?kRyYGSGX3W9xS2qO7eigzoTxY9IHSvTlJxUfRB1w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed646ca-b1e2-4fa2-2eea-08dc23fcbd4b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:39:19.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PLCsTVo+NLyxkEtylqxyhQ6SWAaxPKV7A7/WU+2j+JBsPCKCdO5UwMIAojHo2Xxo2djOsFaN8PpgMcZ5J2t2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com

On Fri, Feb 02, 2024 at 08:04:34AM +0100, Arnd Bergmann wrote:
> On Fri, Feb 2, 2024, at 02:02, Yan Zhao wrote:
> > On Thu, Feb 01, 2024 at 06:46:46AM +0100, Arnd Bergmann wrote:
> >> 
> >> I think it's fair to assume we won't need asm-generic/page.h any
> >> more, as we likely won't be adding new NOMMU architectures.
> >> I can have a look myself at removing any such unused headers in
> >> include/asm-generic/, it's probably not the only one.
> >> 
> >> Can you just send a patch to remove the unused pfn_to_virt()
> >> functions?
> > Ok. I'll do it!
> > BTW: do you think it's also good to keep this fixing series though we'll
> > remove the unused function later?
> > So if people want to revert the removal some day, they can get right one.
> >
> > Or maybe I'm just paranoid, and explanation about the fix in the commit
> > message of patch for function removal is enough.
> >
> > What's your preference? :)
> 
> I would just remove it, there is no point in having both
> pfn_to_kaddr() and pfn_to_virt() when they do the exact
> same thing aside from this bug.
>
> Just do a single patch for all architectures, no need to
> have three or four identical ones when I'm going to merge
> them all through the same tree anyway.
> 
> Just make sure you explain in the changelog what the bug was
> and how you noticed it, in case anyone is ever tempted to
> bring the function back.
Done.
https://lore.kernel.org/all/20240202140550.9886-1-yan.y.zhao@intel.com
Thanks for you guidance :)


