Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51565B4EC
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjABQPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 11:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjABQPN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 11:15:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6111FE;
        Mon,  2 Jan 2023 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672676110; x=1704212110;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D6GnRcgRPW8Ll15zVbxzrUtKPqcWtD2zO25MoC1gBaM=;
  b=n4XQui+EkycWkXzYeBZnD0MtdphZPSe1aow67Wcj4Zz/F2NaXc0Imdkp
   1jo22VGEPoB0KZxTleH6YKEe45gFbNlmlPxDVKQ75Izs4DXTxx1RnoTUX
   dWCHDwX3JRhxVqtmmfcY6h7iXXpu/05i+Bf59ZcgdLiYD+rDTgPjuE9ev
   WvoIVtIvOnAUKMaqFK1cxB9Sw0BRTSDkZmSC609u/LDHX8OiNT6s8O7pi
   YIOgTON3wcU8yffpWqavq6JCwdZUHXHXSA16GVHn2AXR+WWZP4YQGCZsj
   qj5fJfjfVxQv7biMc6AthC4UPsvJU+e56kPnUJ8QijooBAKmgy+oLJZmq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="321573112"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="321573112"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="723007333"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="723007333"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2023 08:14:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 08:14:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 08:14:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 08:14:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 08:14:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhyiAXuOfk49SfCxX43s3+4CPLLDSxgbmznBxf39hwTsQsGHmwZ6QrbDBPHTy1QQIBDDEfWtMHHQnpKjVhp5pDLOC4BVSZXlv/7kz6rNHoXhrisqNs2Kl0JuqvG222tF3yHIdKbpAvMrehrO39/pW8LQPnLTkkVY9uqQqC/wRe2+et7H7cQM0pIXLL4f2+mgPqb6pts/Apzsd+iyGPRvVOm2ugiLGcfwaTBJF+QCNbjCf65MK5OI68Da6gb9ePrlfI6RrP/s5xfBEwPvZOvz5o9RdV8h7Wi3PTyFjpqe0wUaqirsQV3PZEo8vlgHVv5KYzWHCZgItA1Zzj8KIjYRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnCtghdyxlkZRgbaYsfHfw9AZ468oQk5f7RilGZ37ss=;
 b=nRDNRcJUCR8F207U+IKxORhs2nFfi+KYG5ulsRCu56AADpWqrFg91RPX9CEcNyQ7LZhwonHWg02rC4t16CG5v2IWGUyOopo3FvqPQkusacKAKw9W5NFVSN+xm9+HyG5ZdzJpJ+dQQyHwvU6M5crikVMwuC7hfMC/uWFF/l0QAlhECY3j+uHD4xwW/NEUcBv1FK0E/sHbuOrwtA7m43T0g/a+iw9PSDlEqrxF0/1FRp74+N1Z/8U4hh2K18suSiLs9BTIYlKURRsFPA15Df+j7FSBtpFspqcMq3F6HGnIrGC6uS9+QrwUMa7gc0u93bvaVHH5QXaLJBbQPz+KfPs8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 16:14:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::fd3c:c9fc:5065:1a92]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::fd3c:c9fc:5065:1a92%6]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 16:14:41 +0000
Date:   Mon, 2 Jan 2023 17:14:31 +0100
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, "kernel test robot" <lkp@intel.com>,
        <linux-alpha@vger.kernel.org>, <linux-hexagon@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] bitops: always define asm-generic non-atomic
 bitops
Message-ID: <Y7MC5/wxgGZz/met@boxer>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220624121313.2382500-3-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624121313.2382500-3-alexandr.lobakin@intel.com>
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c4f2fa-600b-42f7-5210-08daecdc7404
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7hxngObXnFk1bZ4N6Ax42v881GxI/ZzWoK0vuYxIE1tF1k1fFw8u5mGONRbpAqp3gepf714eKY6QyYgpJUFC1sv3GEl0xM/z8tvCLPfjwwuE55rr7TJsq63WJcuD36bsQIuwIulO8lSVNDImuRcTQriZu6YYARxUcaDsTA3PSfBoWi0XO2veI6n9+Aph9npFme7jpY2IwogMcBXQ58WHFmdcU7QlfvZc5ioRabQ4kLqqsQdN4cNgZfD9l9OqiiJrOM6/D0keHCpbDUSApVojI1UL8gQeyuaJGvadTgdknQJyt9omyjSdUh4luAzrA0ZycFYGrp2uwHgaOVuomiNZUdJ8yHsjqJOCNAhKkEj/d/qgUvorA5OB0dhp4noq7wreC4LmvE3qOQZzCLd54Apbh39u4YbB3+VS3Ql2ZJtQoaok/+QUvKiuE9nC42ANo1IT94X/pSI6Kc0JBx4ryiPTCzbdfbdqLdppU6ozMDfBBcG7CdhceK3AOny00AH5nqrJi9R2A5OZrRzRXKnbuQw48Xi9EhSCm2jtt2naMYDoOqSMOmT4wl9vJgVAD02PdyzKfxNetaBIOLPADlhSlANh2grFchEAjaGTqTtp+rvjej7ZAGqepO450Jw3kqt6sCuFmPe+CLbktqJhAsOVdowB5M/x0bX3cQPeZp14Wb8mE1HsbPBTBb3jMNHN3iMU31mw12Z83OzBNEuYGv1tIknvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(44832011)(30864003)(2906002)(8936002)(6862004)(5660300002)(7416002)(41300700001)(83380400001)(33716001)(86362001)(38100700002)(82960400001)(26005)(186003)(54906003)(6636002)(9686003)(6512007)(6666004)(316002)(6486002)(478600001)(6506007)(8676002)(66556008)(66946007)(66476007)(4326008)(22166006)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFUjgXS+BSmdqvjjbNZBTUJU4ZqLaDGKxAFeLrwdBL3zrTQ8VuR7dWOQ7W+K?=
 =?us-ascii?Q?gH7IhBo8ZYKnZk7f4/6sK6tj0SSApGtQEU86Brpa2SrAtVwvQ8yeLjlgYkmU?=
 =?us-ascii?Q?lvvEUaKsgBNKGqeY/F0VsylkXC+pxyPpE+FWyHD5gipetIGgw5Yxw1tbW8Dx?=
 =?us-ascii?Q?SR6n00tGSo1SCX+vmldrCy5M7O2TAH34Vhj9/spIKVGWXfa5IY6VMhD5+qGp?=
 =?us-ascii?Q?CIAqKYJahxHskAHzQUp1cLhzWDUOo/QvmJVkYAdF09PvAB5pW1qVHGp86elX?=
 =?us-ascii?Q?MByBnPRxhYEP3xk+p/3FG6stVZfNQkPno2CHyl54YMdzQpqHfh+HTo0KKv9c?=
 =?us-ascii?Q?kQLxR68r2drQRBDhppZf7VsJAmjdYa3/TVadUa/+Lr5zukfkuso+eGFI9zmz?=
 =?us-ascii?Q?E/yPXjh9u3BluhcI+SO34K43P0qcRewCjyDACLiCbVRL7JSGfrd8jxhdjvum?=
 =?us-ascii?Q?KCk0Y3lYXKzvHiFShfJDtJAv9Z9ikC0cAMhe5gs+4wQs0KiMr+8CAaObrSgT?=
 =?us-ascii?Q?1IERsw8F8fw7Ng3BkupNIJLHQkerpKlg8BaSmi1AdKpItQysvi//HGsiz7QG?=
 =?us-ascii?Q?ZjifjpqzYQ/AA3qwtjXv93H0NakpFSclhaFtk7lcuvXgUi5VSjJIGPrg+AKA?=
 =?us-ascii?Q?UXHOZywluzj+COoDG/0KROlvLROulHAw0TeTB7Xweykchp+eSxQv6Bx3+drt?=
 =?us-ascii?Q?f8UEHIZ3qlPeKr1qSEVy1B1UmbimP8ibhBDEXF/5jrXEINBN5zSgPbkt1vR1?=
 =?us-ascii?Q?iOTXm85Qvyb6GxQX6pA1Db4K9zY5Fcc5Tgh5O1u13c+BwdhqqxPMCHooPmcA?=
 =?us-ascii?Q?DwdfQGy94MSzmAhIpg7gYNEvlgGIXRDVbvHN8PpEUaomMD+GCKRuhjssTKwA?=
 =?us-ascii?Q?G4pdnwbRYKU98BkFL/SqMZ1P0/7EkQZTZeDislgD2WWl2iHgnze+DgMgT9c4?=
 =?us-ascii?Q?UHdndRDp9oyRIdlGVkdZKFtCAdKST+3DYYjrmmZiqiU5MwFaDOmsVcfPzAbg?=
 =?us-ascii?Q?CxxQxMZ9VsXjpi+kPcgUVul5BqbOz4BXLDxeKFhBAogz4yYFE7GsVhuJclzB?=
 =?us-ascii?Q?Wviip92rRisPtCprbO8FavdER/YptiWg67l1SxiCFe78Z7Xwyo0o2YLxkxa0?=
 =?us-ascii?Q?J9EYgJQ34N8SW15Ou0N6SBYMCSssAyk/eSR0QqHdZU1Eft4fv8bU7087a4zN?=
 =?us-ascii?Q?5EhK06BH/4ysCvPpvsKd/HmknjGjeQ/243eXNjy2VD+OoPw2AAbezFgCIauN?=
 =?us-ascii?Q?7ClQKyrAeG1vtcir9Ws5kNYpunTAKGr2WS84kfZwG0YQuoDUV0rQWPieur+h?=
 =?us-ascii?Q?ydfDYXT8/+3zE4uKCQGie9x4dspfkVFeIAEmlmd3mrGijCGpCNZUrrAsNT6l?=
 =?us-ascii?Q?iFFlw8N6txwdrvCdac9QK5jCWKuFXCzmn2xqy9RVdBpM158fJXKvjYw8sRif?=
 =?us-ascii?Q?FY/NYtSikT351beKb7WzdfnfNUlwhK9FQkSXxNlBtWnbFJzDZgSDJz+AFUW5?=
 =?us-ascii?Q?sEo4l3FpN2gTrdyJETLkXH+LHNOWpftvr+AdcXL58dE2tEJEeY9XJMvSV1kB?=
 =?us-ascii?Q?aDEtOeoP12ySZ2/E+RAS3USYAkkzMckFrztqUhdHC/JOq5eTZpxqHRGU+Rjl?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c4f2fa-600b-42f7-5210-08daecdc7404
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 16:14:41.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOZffqTM2XNDeYzyzp+W/JwI9TG7Gr5V4gRVhWtezsfMWCeKXhfDSIht0r58J0yr2aJ+QLdMbrdkTdzh3fN/8g0jsb0XDPXAOPxU0iizOPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 24, 2022 at 02:13:06PM +0200, Alexander Lobakin wrote:
> Move generic non-atomic bitops from the asm-generic header which
> gets included only when there are no architecture-specific
> alternatives, to a separate independent file to make them always
> available.
> Almost no actual code changes, only one comment added to
> generic_test_bit() saying that it's an atomic operation itself
> and thus `volatile` must always stay there with no cast-aways.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # comment
> Suggested-by: Marco Elver <elver@google.com> # reference to kernel-doc
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 130 ++++++++++++++++++
>  include/asm-generic/bitops/non-atomic.h       | 110 ++-------------
>  2 files changed, 138 insertions(+), 102 deletions(-)
>  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
> 

Hi,

this patch gives me a headache when trying to run sparse against a module.

Olek please help :D

$ sudo make C=2 -C . M=drivers/net/ethernet/intel/ice/
make: Entering directory '/home/mfijalko/bpf-next'
  CHECK   drivers/net/ethernet/intel/ice/ice_main.c
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./arch/x86/include/asm/bitops.h:66:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:30:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:31:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:33:10: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:33:16: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:28:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:26:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./arch/x86/include/asm/bitops.h:92:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:39:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:40:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:42:10: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:42:16: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:37:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:42:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./arch/x86/include/asm/bitops.h:117:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:57:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:58:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:60:10: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:60:15: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:55:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:58:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./arch/x86/include/asm/bitops.h:150:9: warning: unreplaced symbol 'oldbit'
./arch/x86/include/asm/bitops.h:154:26: warning: unreplaced symbol 'oldbit'
./arch/x86/include/asm/bitops.h:156:16: warning: unreplaced symbol 'oldbit'
./arch/x86/include/asm/bitops.h:156:9: warning: unreplaced symbol 'return'
./arch/x86/include/asm/bitops.h:148:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:75:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:76:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:77:9: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:79:10: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:79:14: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:79:20: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:80:17: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:80:23: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:80:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:73:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:100:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/instrumented-non-atomic.h:97:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:95:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:96:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:97:9: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:99:10: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:99:14: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:99:21: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:100:17: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:100:23: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:100:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:93:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:115:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/instrumented-non-atomic.h:112:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./arch/x86/include/asm/bitops.h:188:9: warning: unreplaced symbol 'oldbit'
./arch/x86/include/asm/bitops.h:192:35: warning: unreplaced symbol 'oldbit'
./arch/x86/include/asm/bitops.h:195:16: warning: unreplaced symbol 'oldbit'
./arch/x86/include/asm/bitops.h:195:9: warning: unreplaced symbol 'return'
./arch/x86/include/asm/bitops.h:186:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:107:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:108:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:109:9: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:111:10: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:111:14: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:111:20: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:112:17: warning: unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:112:23: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:112:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:105:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:130:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/instrumented-non-atomic.h:127:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./arch/x86/include/asm/bitops.h:239:9: warning: unreplaced symbol 'return'
./arch/x86/include/asm/bitops.h:237:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/generic-non-atomic.h:128:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:121:1: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:168:9: warning: unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:169:9: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:170:9: warning: unreplaced symbol 'val'
./include/asm-generic/bitops/generic-non-atomic.h:172:19: warning: unreplaced symbol 'val'
./include/asm-generic/bitops/generic-non-atomic.h:172:25: warning: unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:172:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:166:1: warning: unreplaced symbol 'return'
drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
./include/asm-generic/bitops/instrumented-non-atomic.h:142:9: warning: unreplaced symbol 'return'
./include/asm-generic/bitops/instrumented-non-atomic.h:139:1: warning: unreplaced symbol 'return'

that's for a single file, there's no point in including same output for
every other file being checked.

Thanks,
Maciej
