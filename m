Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014EC31EE05
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBRSIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 13:08:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:55465 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232255AbhBRP1M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 10:27:12 -0500
IronPort-SDR: koRHhB3Sh1Y7BRNr6MvC+lOA4x2W8ybKA/ikOVA1wxhkdR2TlgM72weq4hmJlQgcWFhKTb4A4E
 IYD2YgPh4LNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183655369"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="183655369"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 07:24:43 -0800
IronPort-SDR: 8XmGzD47oFBWYgfZML/hr8KNsXGQAVcULRrIbaB3JWaUkj6fTcDsL+FrxYXimHLPRJkVm3yGpa
 XRVEndNeYKtg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="513310698"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 07:24:38 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lClAQ-005ygt-Ro; Thu, 18 Feb 2021 17:24:34 +0200
Date:   Thu, 18 Feb 2021 17:24:34 +0200
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
Subject: Re: [PATCH 11/14] lib: add fast path for find_next_*_bit()
Message-ID: <YC6GsqTbVqBeWV6O@smile.fi.intel.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-12-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218040512.709186-12-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 17, 2021 at 08:05:09PM -0800, Yury Norov wrote:
> Similarly to bitmap functions, find_next_*_bit() users will benefit
> if we'll handle a case of bitmaps that fit into a single word. In the
> very best case, the compiler may replace a function call with a few
> instructions.
> 
> This is the quite typical find_next_bit() user:
> 
> 	unsigned int cpumask_next(int n, const struct cpumask *srcp)
> 	{
> 		/* -1 is a legal arg here. */
> 		if (n != -1)
> 			cpumask_check(n);
> 		return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
> 	}
> 	EXPORT_SYMBOL(cpumask_next);
> 
> On ARM64 if CONFIG_FAST_PATH is disabled it generates:

bloat-o-meter over specific module and/or vmlinux.o?

> 	0000000000000000 <cpumask_next>:
> 	   0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
> 	   4:   11000402        add     w2, w0, #0x1
> 	   8:   aa0103e0        mov     x0, x1
> 	   c:   d2800401        mov     x1, #0x40                       // #64
> 	  10:   910003fd        mov     x29, sp
> 	  14:   93407c42        sxtw    x2, w2
> 	  18:   94000000        bl      0 <find_next_bit>
> 	  1c:   a8c17bfd        ldp     x29, x30, [sp], #16
> 	  20:   d65f03c0        ret
> 	  24:   d503201f        nop
> 
> If CONFIG_FAST_PATH is enabled:
> 	0000000000000140 <cpumask_next>:
> 	 140:   11000400        add     w0, w0, #0x1
> 	 144:   93407c00        sxtw    x0, w0
> 	 148:   f100fc1f        cmp     x0, #0x3f
> 	 14c:   54000168        b.hi    178 <cpumask_next+0x38>  // b.pmore
> 	 150:   f9400023        ldr     x3, [x1]
> 	 154:   92800001        mov     x1, #0xffffffffffffffff         // #-1
> 	 158:   9ac02020        lsl     x0, x1, x0
> 	 15c:   52800802        mov     w2, #0x40                       // #64
> 	 160:   8a030001        and     x1, x0, x3
> 	 164:   dac00020        rbit    x0, x1
> 	 168:   f100003f        cmp     x1, #0x0
> 	 16c:   dac01000        clz     x0, x0
> 	 170:   1a800040        csel    w0, w2, w0, eq  // eq = none
> 	 174:   d65f03c0        ret
> 	 178:   52800800        mov     w0, #0x40                       // #64
> 	 17c:   d65f03c0        ret
> 
> find_next_bit() call is replaced with 6 instructions. (And I suspect
> we can improve the GENMASK() for better code generation.) find_next_bit()
> itself is 41 instructions.

...

> +	if (SMALL_CONST(size - 1)) {
> +		unsigned long val;
> +
> +		if (unlikely(offset >= size))
> +			return size;

> +		val = *addr & GENMASK(size - 1, offset);

Yeah, GENMASK() basically for constant values or cases like (x,0). I think here
is something what has been done in BITMAP_FIRST/LAST_WORD_MASK will give better
results.

> +		return val ? __ffs(val) : size;
> +	}

-- 
With Best Regards,
Andy Shevchenko


