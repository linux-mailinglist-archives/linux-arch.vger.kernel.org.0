Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2E531F7BF
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 11:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBSK4e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 05:56:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:42742 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhBSKya (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 05:54:30 -0500
IronPort-SDR: Pan4+RQ6X3mXLM4cNGlD8lxrtQq+KXGFLqmGJNkfP8TA6reWleoVhSFQ9jtd/7XuxFBBCZoGxu
 MXaCa4JYUWRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="203089882"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="203089882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 02:52:40 -0800
IronPort-SDR: bVGrXxe3odPkq9jl2SHFPpUZx8yAK/e9ZiGCRHn1OpRte+3Sh+PsSwyKsbrFvOjG6dK3qKDY9E
 30CHMP0KncJQ==
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="581637660"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 02:52:35 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lD3Oh-006C0D-KD; Fri, 19 Feb 2021 12:52:31 +0200
Date:   Fri, 19 Feb 2021 12:52:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 08/14] lib/Kconfig: introduce FAST_PATH option
Message-ID: <YC+Yby6dbFnC81pu@smile.fi.intel.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-9-yury.norov@gmail.com>
 <YC6EnzFUXDuroy0+@smile.fi.intel.com>
 <20210218192419.GA788573@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218192419.GA788573@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 18, 2021 at 11:24:19AM -0800, Yury Norov wrote:
> On Thu, Feb 18, 2021 at 05:15:43PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 17, 2021 at 08:05:06PM -0800, Yury Norov wrote:
> > > This series introduces fast paths for find_bit() routines. It is
> > > beneficial for typical systems, but those who limited in I-cache
> > > may be concerned about increasing the .text size of the Image.
> > > 
> > > To address this concern, one can disable FAST_PATH option in the config
> > > and some save memory.
> > > 
> > > The effect of this option on my arm64 next-20210217 build is:
> > 
> > (Maybe bloat-o-meter will give better view on this, i.e. more human-readable)
> 
> Never heard about this tool, thanks for the hint.
> 
> scripts/bloat-o-meter vmlinux vmlinux.new
> add/remove: 16/13 grow/shrink: 111/439 up/down: 3616/-19352 (-15736)
> Function                                     old     new   delta
> find_next_bit.constprop                        -     220    +220
> apply_wqattrs_cleanup                          -     176    +176
> memcg_free_shrinker_maps                       -     172    +172
> ...
> cpuset_hotplug_workfn                       2584    2288    -296
> task_numa_fault                             3640    3320    -320
> kmem_cache_free_bulk                        1684    1280    -404
> Total: Before=26085140, After=26069404, chg -0.06%
> 
> The complete output is here:
> https://pastebin.com/kBSdVJcK
> 
> So if I understand the output correctly, the size of .text is decreased...
> Looks weird, but if it's true, we don't need the FAST_BIT config at all
> because there's no tradeoff, and I should drop the patch.

I actually expected the text size decrease when it's about constants.
I remember that in PCI case we discussed with Bjorn the use of
for_each_set_bit() that brought entire function into the object file that
increased it by ~300 bytes (or so). But the code is something like

	for_each_set_bit(i, &addr, 32)

...

> > I think the name is to broad for this cases, perhaps BITS_FAST_PATH? or BITMAP?
> 
> My logic was that since SMALL_CONST() is global, and FAST_PATH
> controls the SMALL_CONST, it should also be global. I believe,
> Linux should have a global switch to control the behaviour in
> such cases, similarly to -Os compiler option. And I was surprized
> when I found nothing like FAST_PATH in the config.
> 
> What about having FAST_PATH as a global option, and later if someone
> will request for granularity, we'll introduce nested configs?

I think it is too far from now. Let's do one step at a time.

-- 
With Best Regards,
Andy Shevchenko


