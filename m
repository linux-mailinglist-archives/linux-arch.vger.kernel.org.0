Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04433D345
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 12:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhCPLn0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 07:43:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:23252 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhCPLmx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 07:42:53 -0400
IronPort-SDR: dLW/HWKaMiF++7Uze3/MuDgDkss2sPtytO+7GGX+Uuup45FWN+zHa54tbIot/U1JqMd3wycYaG
 /K57hoKyH4XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="186865708"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="186865708"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 04:42:53 -0700
IronPort-SDR: iq7QF47cfPjI7PVPRHUpFvCrZXd4drsp6yCnHY1iy2TO3i3VcUwWQmBw+YfeBa1m+8I5Ce/fBb
 KbByQ9bFoatQ==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="440063172"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 04:42:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lM861-00CwOC-38; Tue, 16 Mar 2021 13:42:45 +0200
Date:   Tue, 16 Mar 2021 13:42:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 04/13] lib: introduce BITS_{FIRST,LAST} macro
Message-ID: <YFCZtUuMYVNeNlUO@smile.fi.intel.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-5-yury.norov@gmail.com>
 <8021faab-e592-9587-329b-817ae007b89a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8021faab-e592-9587-329b-817ae007b89a@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 09:35:35AM +0100, Rasmus Villemoes wrote:
> On 16/03/2021 02.54, Yury Norov wrote:
> > BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
> > functionality of GENMASK(). The scope of BITMAP* macros is wider
> > than just bitmaps. This patch defines 4 new macros: BITS_FIRST(),
> > BITS_LAST(), BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h
> > on top of GENMASK() and replaces BITMAP_{LAST,FIRST}_WORD_MASK()
> > to avoid duplication and increase the scope of the macros.
> > 
> > This change doesn't affect code generation. On ARM64:
> > scripts/bloat-o-meter vmlinux.before vmlinux
> > add/remove: 1/2 grow/shrink: 2/0 up/down: 17/-16 (1)
> > Function                                     old     new   delta
> > ethtool_get_drvinfo                          900     908      +8
> > e843419@0cf2_0001309d_7f0                      -       8      +8
> > vermagic                                      48      49      +1
> > e843419@0d45_000138bb_f68                      8       -      -8
> > e843419@0cc9_00012bce_198c                     8       -      -8
> 
> [what on earth are those weird symbols?]
> 
> 
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 7f475d59a097..8c191c29506e 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -37,6 +37,12 @@
> >  #define GENMASK(h, l) \
> >  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >  
> > +#define BITS_FIRST(nr)		GENMASK((nr), 0)
> > +#define BITS_LAST(nr)		GENMASK(BITS_PER_LONG - 1, (nr))
> > +
> > +#define BITS_FIRST_MASK(nr)	BITS_FIRST((nr) % BITS_PER_LONG)
> > +#define BITS_LAST_MASK(nr)	BITS_LAST((nr) % BITS_PER_LONG)
> 
> I don't think it's a good idea to propagate the unusual closed-range
> semantics of GENMASK to those wrappers. Almost all C and kernel code
> uses the 'inclusive lower bound, exclusive upper bound', and I'd expect
> BITS_FIRST(5) to result in a word with five bits set, not six. So I
> think these changes as-is make the code much harder to read and understand.
> 
> Regardless, please add some comments on the valid input ranges to the
> macros, whether that ends up being 0 <= nr < BITS_PER_LONG or 0 < nr <=
> BITS_PER_LONG or whatnot.
> 
> It would also be much easier to review if you just redefined the
> BITMAP_LAST_WORD_MASK macros etc. in terms of these new things, so you
> wouldn't have to do a lot of mechanical changes at the same time as
> introducing the new ones - especially when those mechanical changes
> involve adding a "minus 1" everywhere.

I tend to agree with Rasmus here.

-- 
With Best Regards,
Andy Shevchenko


