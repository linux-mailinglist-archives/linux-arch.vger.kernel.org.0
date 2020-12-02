Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1942CC5EA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 19:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgLBSwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 13:52:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:56541 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgLBSwK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 13:52:10 -0500
IronPort-SDR: aiHqgaIgp9BtKoyXKlFVwYb0v5HRmAslhcvHXqkC/XVy+Y8LwR1HL+IAMMktBZCu6by/t9qWKo
 L6Dq5BF6zUUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="170502004"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="170502004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 10:50:30 -0800
IronPort-SDR: f5ZeDIycbNzT7S5s+5pjjkfqOQELvXr/smb2b9H4sD2vZZ15lwZmwASAPT9mTVVJTVePb59Oli
 uoHsXSrAdc5Q==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="335664784"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 10:50:26 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kkXDr-00Ba4b-LT; Wed, 02 Dec 2020 20:51:27 +0200
Date:   Wed, 2 Dec 2020 20:51:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: your mail
Message-ID: <20201202185127.GO4077@smile.fi.intel.com>
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
 <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <20201202173701.GM4077@smile.fi.intel.com>
 <CAM7-yPSWvsySweXSmbvW2hucce8T7BOSkz-eF5t7PJE6zv5tjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPSWvsySweXSmbvW2hucce8T7BOSkz-eF5t7PJE6zv5tjg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 03, 2020 at 03:27:33AM +0900, Yun Levi wrote:
> On Thu, Dec 3, 2020 at 2:36 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Dec 02, 2020 at 09:26:05AM -0800, Yury Norov wrote:

...

> > Side note: speaking of performance, any plans to fix for_each_*_bit*() for
> > cases when the nbits is known to be <= BITS_PER_LONG?
> >
> > Now it makes an awful code generation (something like few hundred bytes of
> > code).

> Frankly Speaking, I don't have an idea in now.....
> Could you share your idea or wisdom?

Something like (I may be mistaken by names, etc, I'm not a compiler expert,
and this is in pseudo language, I don't remember all API names by hart,
just to express the idea) as a rough first step

__builtin_constant(nbits, find_next_set_bit_long, find_next_set_bit)

find_next_set_bit_long()
{
	unsigned long v = BIT_LAST_WORD(i);
	return ffs_long(v);
}

Same for find_first_set_bit() -> map it to ffs_long().

And I believe it can be optimized more.

-- 
With Best Regards,
Andy Shevchenko


