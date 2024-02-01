Return-Path: <linux-arch+bounces-1957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054DB844DE0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 01:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8341F2A0E4
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0A1FA4;
	Thu,  1 Feb 2024 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzxxVaro"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EC1852;
	Thu,  1 Feb 2024 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747491; cv=fail; b=hB0wwa8uoxowxx9WDSdgjj7oXiN5ttj2xOE2+13Mg+VhQrCMT8opnysYyZxD8/v1hA9dcCLDZxtGmjd4cDbnM20ODI+oqbtnp+TxF4+sMAuvlAe0IqRz6TfrT3msLRSvpN4seqaj9DklFKfY1+PZASMxAjlmy5McGt0pQaJyhCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747491; c=relaxed/simple;
	bh=saozTpVE+rp5W9+tUJDyrfSXYw6Xn9O0j9MC8MTO5gI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1MPLIJQpeuJzEMEMxavExYDx+SPmnikH7kUaOOEBM4s70mfEpFtNCnp8vSIMF+msgpCzY0thK+zOoMUKQ0dQemqfLYsFucsCbGQTyyE+SPM1qV/c+EOIM7Y6V8ydni9aS5SJ8rtibAbIEhgGXUfzHSQg4ECpNhYtgMVxGQaYDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzxxVaro; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706747489; x=1738283489;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=saozTpVE+rp5W9+tUJDyrfSXYw6Xn9O0j9MC8MTO5gI=;
  b=dzxxVaror+XjBud6tZqkltWs86yby5NJZWnq/u7ZVcmHJ1sbWBnTmExZ
   SlgZUScBf/dWGEcvVXrawHUlbWHWSzoV5Uspxd6xtu65BAqPXU+JAL52d
   qfiCXLdiiWN85qm3ehwM7WNuvmSbodVB4HGAM166w85+kDC7nftb3hLn3
   605Ba8gEwTvM6r/sLSd/MLa67GBr3F1QGXxxIAkr5nzH9py4R0jFSiw6o
   sLKLv1wo2I5uX7CxXwTE7jrZbYzldFbhwNit/5zUv/3KzuBPBlSbodMQV
   581UL6S5DhmJ1EKBylp6t3WtKa3Wf9htDIgtm7t2Qs6Yx9nNbHl2Q7SB6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407485927"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="407485927"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:31:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4224241"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 16:31:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 16:31:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 16:31:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 16:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSZVozZeFrZReAXodNIwQKCifybA3GjJT/g8uYwlIS9hwfbz9JQBCNJhm2K+5aMu78Y++cgYUsh0sm6pO01O0RvDuUxR1taHJ5fx1B5YAHRVEOVs1nySt2N1Zy2Xs6MKbqKZ3LkMEvXBfOnFfelZH1Ye5+bMwy1adXdLfmprDgS1Ga+Lfta0JPX7vBVs6CPDdWm+/p/9tMrnKe5vT46lVtR4Ii88TV9clVeShHyNA2RPuMXEl+mVq1a8/WTnG/QKosYtX66xPluvVqvFIE6ED7htOV1hFNHwXbZ7krB69JgiaTuJLOspsWp4jApdIgwg/9mpQRASa1FFILlH84Kx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlaRhriupkSmhQmNx+YknlH3+uF3PRIvjwkT5XTBzD4=;
 b=U/dUmVI0RE04VjtLguDqxzfH4wt+j2Lj9CwVqXYvo3wlVqocUOWfRzudfi7DR9QeuIx6l4RQRq0eYWoNhq8aeuMLkPnTB+JpvqGyjijeOo04qbzNxmG9qV3VnKKLgotaZes7hJBghF+/paNDJ3Z1wgn4vkFN92yRWGtNljWfVHxyPzntrd6bxbB9G0KNRSQMCYbT8wHcy3WosTUmPpF3OWPvdeVYpcJUlZ3lO9/HVzYavQdsSpSlYQZ07RMab2CxEJym+gv0gTkxiIJLm8qb4k9hGGfgHlomyMagpzmdXdpHxCZubhCIk6Xd96U5AcAsFLYIaNDKH+L7VjKT4Rgm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 00:31:25 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::81e3:37ec:f363:689e%6]) with mapi id 15.20.7249.017; Thu, 1 Feb 2024
 00:31:25 +0000
Date: Thu, 1 Feb 2024 08:01:53 +0800
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
Message-ID: <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|MN2PR11MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec47e45-646f-45d8-516c-08dc22bd1f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApzJWmRwCOxkbGliGTJsVd0ZX4OY/LVTcd+kcsqvutAeIYt/cbQpTx7jsTn9uMqCK++ravPSM/1ooX7lg+BoWFB9IMW9bwUQTkbS4u+8GmHPS2rP7aYz8+cDgjRruMlSgEmsp/wXiMb5o5W84PaiObB3goF4ETQpOjBub7BQg5Zzd7nHofV5MiERM81ZG/GBpViEk60ifk53C1JDMv48/cG/ODOXhds8mV3Rxwj2bxJEPm6ChiMbPh3nGiluHjpxG318fs05TFwSANtph7MUMIFjcx6S4p92tQ/BDyArH6PoygPm6rnoXebq3dmJ1vGAFLQMIcxxJAtJLu3OOFu4LwI49qnmZ5LLN3cipwL32H1YbXPgndOKX4zgpBP2Wawfnwv8Q4Om1NOOp6xizDE+60hM5hs+n/GzCHBFrxKehFYkOI93Id1ww20ZVWih3dA6V+AdWpZyjv+SrF3aA1DaFCu2Wy6nUG50luJmnzJ2hILMqxa2NJsAEw9NvSfQRYD2n0YGqeAbgxyjFUzkjMxbljcvyaCTGEd4e17rJaiHsmji7xzfDnc7rTA7BZ7EiWcN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(41300700001)(66946007)(83380400001)(6512007)(54906003)(66476007)(66556008)(478600001)(82960400001)(6506007)(6666004)(6486002)(38100700002)(6916009)(316002)(86362001)(7416002)(5660300002)(8936002)(4326008)(2906002)(8676002)(3450700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2hySYtTMDKlnZSDlUimw7tvm3zF4xJfOMGAaCCj9rr2IquDiZGACLhwJ1Sa?=
 =?us-ascii?Q?TaOJvq4NWFb2x5Px2/gmAYqrShR1/hv1MBCpNHlblhmfmnhvt4hB4qLKUWGL?=
 =?us-ascii?Q?qM0BQ3M0DWcz+0PNSnPcZFgfd+BZyDS9m/NLWVntJdEUXa3LDosRT3hADLgK?=
 =?us-ascii?Q?4DL8VP5mWjnJVTM7WFRtsKg/YJf4ppNBtv5inAHP2Hs5iC7RsmOcUd+SPkfM?=
 =?us-ascii?Q?eK/k6pC5Jxvd32MofULhTS4Y5t+Wme63n40sMbgfddBqNapz6zAfkxIRExjo?=
 =?us-ascii?Q?Pk/04y2vaZqTDTSvbq2MSdlj8JdHv7+XAl/lXVTbumJBt/znK3jL/sdTiocn?=
 =?us-ascii?Q?EJFVnr5uPHhDvAAv9iLAncyiGBs+2Q5txt0ksmx2+J5IIYDz5PC/c4bCVRAS?=
 =?us-ascii?Q?1u+T6RsdG7trr9xglcxbkjnmE5D8PpD8lO7zZhPvW9rqmpZC3ee4i1+cr93H?=
 =?us-ascii?Q?rCbj+uSvfnaJGirBnsgXK9wEklWQqE/qnHWAZalrb7blrQsIwzQWWolrPpk/?=
 =?us-ascii?Q?3dRzMXJsd+dacSSxwUcZ8bU/Cse0CPJyHXycThM3d2trb+BB1cZcK9ROpbd7?=
 =?us-ascii?Q?RGM2StqLv+Vdtvddb5WK10dbToGdQEeeutaGlQQrHlhpp4cAIiG+gbgEr+9d?=
 =?us-ascii?Q?SCRipo7Jb2WJnN9aV+4h15z1LDRW0lB4/ofz9SaffNXzZmcFjdRcWmA37pjX?=
 =?us-ascii?Q?9TzuZrXHzNas7CEVhGZmSKb+zcbf7zsJZfgfIIb3rS7pJBsFZk4/3ZXx3olV?=
 =?us-ascii?Q?nsVncow2iZWspHZMtXqr7AQKKsYQtoZHGPo+n+iilObYu+KL02g3Mm1neDwF?=
 =?us-ascii?Q?U59hdZIs8HgVknS6RWExvJAUkVu8UG1Lho7MsZarIN+RtSrIR4IMQp9xIoG5?=
 =?us-ascii?Q?B2JPgE3/4ykmt0ByxctmHJCGIjTGTqOqGpcybFx/Lw0BtvxIO1cKAJE0X1Of?=
 =?us-ascii?Q?25NlsTSVc5ZXkppgeW8IXSjYWSDbRT/pHb//6by+rJj/xQdre1b6o2m+qHZH?=
 =?us-ascii?Q?FEwe5OK7A22pQHmICfL3cHiBIZPs7zT6DfAvkNTwFv9WDwCuYTxzj+6iPLSt?=
 =?us-ascii?Q?oMWpBrQapGpCrCG1wHQOMMwqBIrcVv3SuYVcEfKT4B9+MSp+YXEoS7hcd5uu?=
 =?us-ascii?Q?Z+sg6kPaD0TCmuj5s8tpc9Kugs0Zo96otBK7uTbrcz+2Gd/SzV2yAFj76Hx/?=
 =?us-ascii?Q?ZH9lHuhLyLzwOhd7LXklFb4AVsjI6q8331C8QeXoX5e9sq0t0gw+OaSXjJ5v?=
 =?us-ascii?Q?R74DpWEGPphauENAjxNbi9QfubtKDlDXvYRpT3LxKkkVbW42iLdyhzUnch8K?=
 =?us-ascii?Q?RXVv8bHzkctSvsqomxVRdVVOzh4oGKybLarsQq+NbiULO9vsZ+zfc2NmXh+f?=
 =?us-ascii?Q?oZ0hT8WIDUuwAYJU4HJ8o1Yd7uHshQCBZgCljwQUDHy91cVLhZ2KAIeaQ2r3?=
 =?us-ascii?Q?6BGVMG3ScSqZnZN84yGREn/PbW1c9CDyrQn5cfMNdjv/2aze3BYkV9EYM81D?=
 =?us-ascii?Q?4gXQ+uYaaGeCm0iIRp7w0kNEmitNgD7A8puHa9nYcI3k2Ws9VDhGwvB+8imO?=
 =?us-ascii?Q?l5bFX2KywyNatS7coP6ckr2YTXf5Cb0bTwMoRXsw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec47e45-646f-45d8-516c-08dc22bd1f60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 00:31:25.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkDRDpDbcXSuFoy16QBXQBM+2XF/Pot6/0//oG+tUTAth7eNqMO32mG+s+W8/HEtXyeEIbI/HUfE0n3+H/orHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4645
X-OriginatorOrg: intel.com

On Wed, Jan 31, 2024 at 12:48:38PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 31, 2024, at 06:51, Yan Zhao wrote:
> > This is a tiny fix to pfn_to_virt() for some platforms.
> >
> > The original implementaion of pfn_to_virt() takes PFN instead of PA as the
> > input to macro __va, with PAGE_SHIFT applying to the converted VA, which
> > is not right under most conditions, especially when there's an offset in
> > __va.
> >
> >
> > Yan Zhao (4):
> >   asm-generic/page.h: apply page shift to PFN instead of VA in
> >     pfn_to_virt
> >   csky: apply page shift to PFN instead of VA in pfn_to_virt
> >   Hexagon: apply page shift to PFN instead of VA in pfn_to_virt
> >   openrisc: apply page shift to PFN instead of VA in pfn_to_virt
> 
> Nice catch, this is clearly a correct fix, and I can take
> the series through the asm-generic tree if we want to take
> this approach.
> 
> I made a couple of interesting observations looking at this patch
> though:
> 
> - this function is only used in architecture specific code on
>   m68k, riscv and s390, though a couple of other architectures
>   have the same definition.
> 
> - There is another function that does the same thing called
>   pfn_to_kaddr(), which is defined on arm, arm64, csky,
>   loongarch, mips, nios2, powerpc, s390, sh, sparc and x86,
>   as well as yet another pfn_va() on parisc.
> 
> - the asm-generic/page.h file used to be included by h8300, c6x
>   and blackfin, all of which are now gone. It has no users left
>   and can just as well get removed, unless we find a new use
>   for it.
> 
> Since it looks like the four broken functions you fix
> don't have a single caller, maybe it would be better to
> just remove them all?
> 
> How exactly did you notice the function being wrong,
> did you try to add a user somewhere, or just read through
> the code?
I came across them when I was debugging an unexpected kernel page fault
on x86, and I was not sure whether page_to_virt() was compiled in
asm-generic/page.h or linux/mm.h.
Though finally, it turned out that the one in linux/mm.h was used, which
yielded the right result and the unexpected kernel page fault in my case
was not related to page_to_virt(), it did lead me to noticing that the
pfn_to_virt() in asm-generic/page.h and other 3 archs did not look right.

Yes, unlike virt_to_pfn() which still has a caller in openrisc (among
csky, Hexagon, openrisc), pfn_to_virt() now does not have a caller in
the 3 archs. Though both virt_to_pfn() and pfn_to_virt() are referenced
in asm-generic/page.h, I also not sure if we need to remove the
asm-generic/page.h which may serve as a template to future archs ?

So, either way looks good to me :)


