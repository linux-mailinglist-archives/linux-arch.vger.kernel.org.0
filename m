Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88162FEAC7
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbhAUMzx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 07:55:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:25764 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbhAUKfm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 05:35:42 -0500
IronPort-SDR: DfxDX+FYLQd0kl4iU09XXKmAS6kIJTG3dGOyjZ6iyguVbvx39rzNVIioZQwLdtH1Fv3AbqVjqh
 ker18n62zJnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166347355"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="166347355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:33:44 -0800
IronPort-SDR: t0/3SHCCmps/HIQS11ATR5hPbMpPuTorfoWhf5Y7rT93Ngh/CeE1NlXGpQo1QXCKDgpJ0yqs0j
 8H3qxCqbE9uw==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="570685626"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:33:40 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2XIY-007OH7-06; Thu, 21 Jan 2021 12:34:42 +0200
Date:   Thu, 21 Jan 2021 12:34:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 5/6] lib: add fast path for find_next_*_bit()
Message-ID: <YAlYwZOO6QyaR6UZ@smile.fi.intel.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
 <20210121000630.371883-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121000630.371883-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 20, 2021 at 04:06:29PM -0800, Yury Norov wrote:
> Similarly to bitmap functions, find_next_*_bit() users will benefit
> if we'll handle a case of bitmaps that fit into a single word. In the
> very best case, the compiler may replace a function call with a
> single ffs or ffz instruction.

> +	if (small_const_nbits(size)) {
> +		unsigned long val;
> +
> +		if (unlikely(offset >= size))
> +			return size;

> +		val = *addr & BITMAP_FIRST_WORD_MASK(offset)
> +				& BITMAP_LAST_WORD_MASK(size);

Seems like a new helper can be introduced (BITS or BITMAP namespace depending
on the decision):

#define	_OFFSET_SIZE_MASK(o,s)					\
	(BITMAP_FIRST_WORD_MASK(o) & BITMAP_LAST_WORD_MASK(s))

		val = *addr & BITMAP_OFFSET_SIZE_MASK(offset, size);

And so on below.

> +		return val ? __ffs(val) : size;
> +	}

-- 
With Best Regards,
Andy Shevchenko


