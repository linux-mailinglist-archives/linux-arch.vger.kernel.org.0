Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292482901A2
	for <lists+linux-arch@lfdr.de>; Fri, 16 Oct 2020 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406341AbgJPJQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Oct 2020 05:16:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:26032 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406310AbgJPJQE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Oct 2020 05:16:04 -0400
IronPort-SDR: 2l3JvqUg3YV+8YGv4Y6fu3V1t2GDynOX+ox9igzUoHsmrV11/6S8NccfY9mtF4iYWwdpGQJcmE
 SGipWgtQ/WyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="166670662"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="166670662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:16:03 -0700
IronPort-SDR: cn9yV8a6EkpvDnhuC5Eu3JzAbrOrgpflkTrPT36A3TNxwptXSo7u0wMtWhHCu3/ZLrcp+bKO1C
 4OGZxaKo2QxQ==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="522172401"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:16:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kTLrE-0087v0-OX; Fri, 16 Oct 2020 12:17:04 +0300
Date:   Fri, 16 Oct 2020 12:17:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <20201016091704.GE4077@smile.fi.intel.com>
References: <cover.1601974764.git.syednwaris@gmail.com>
 <33de236870f7d3cf56a55d747e4574cdd2b9686a.1601974764.git.syednwaris@gmail.com>
 <20201006112745.GG4077@smile.fi.intel.com>
 <CACG_h5pYL+HbJpPcCTp=dR8rDbm07RsRDaX8Uc0HYc2LG--w_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG_h5pYL+HbJpPcCTp=dR8rDbm07RsRDaX8Uc0HYc2LG--w_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 16, 2020 at 04:23:05AM +0530, Syed Nayyar Waris wrote:
> On Tue, Oct 6, 2020 at 4:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 06, 2020 at 02:52:16PM +0530, Syed Nayyar Waris wrote:

...

> > > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> >
> > Have you considered to use rather BIT{_ULL}(nbits) - 1?
> > It maybe better for code generation.
> 
> Yes I have considered using BIT{_ULL} in earlier versions of patchset.
> It has a problem:
> 
> This macro when used in both bitmap_get_value and
> bitmap_set_value functions, it will give unexpected results when nbits or clump
> size is BITS_PER_LONG (32 or 64 depending on arch).
> 
> Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64, for example),
> (BIT(nbits) - 1)
> gives a value of zero and when this zero is ANDed with any value, it
> makes it full zero. This is unexpected, and incorrect calculation occurs.
> 
> What actually happens is in the macro expansion of BIT(64), that is 1
> << 64, the '1' overflows from leftmost bit position (most significant
> bit) and re-enters at the rightmost bit position (least significant
> bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> subtracted from this, the final result becomes 0.
> 
> This is undefined behavior in the C standard (section 6.5.7 in the N1124)

I see, indeed, for 64/32 it is like this.

...

> Yes I have incorporated your suggestion to use the '<<' operator. Thank You.

One side note, consider the use round_up() vs. roundup(). I don't remember
which one is optimized to divisor being power of 2.

-- 
With Best Regards,
Andy Shevchenko


