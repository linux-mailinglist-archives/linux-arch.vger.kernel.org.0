Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D422FE7CF
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbhAUKlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 05:41:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:6031 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbhAUKlK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 05:41:10 -0500
IronPort-SDR: Nos6cvgUB10j5PU29r+BacRKqFbF0NpEqOpHb5KbeQv4gTLbzNsTapraRCyx6QXvBx1ZkOi6Ro
 WyQO1DzubqGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="176678784"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="176678784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:39:23 -0800
IronPort-SDR: st5LNOVlRwOFFvLjpqR0nt4yjWk02rcI/4LtDur741eNR7Puwcd1q/4NcCWCNTw3/ssRE/aphb
 8APS1z6r0EVw==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="403145896"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:39:19 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2XO0-007Obd-Ny; Thu, 21 Jan 2021 12:40:20 +0200
Date:   Thu, 21 Jan 2021 12:40:20 +0200
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
Subject: Re: [PATCH 6/6] lib: add fast path for find_first_*_bit() and
 find_last_bit()
Message-ID: <YAlaFJpV5Jd9VN2S@smile.fi.intel.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
 <20210121000630.371883-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121000630.371883-7-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 20, 2021 at 04:06:30PM -0800, Yury Norov wrote:
> Similarly to bitmap functions, users will benefit if we'll handle
> a case of small-size bitmaps that fit into a single word.
> 
> While here, move the find_last_bit() declaration to bitops/find.h
> where other find_*_bit() functions sit.

...

> +static inline
> +unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long idx;
> +
> +		if (!*addr)
> +			return size;
> +
> +		idx = __ffs(*addr);

> +		return idx < size ? idx : size;

But can't we mask it first, then check for 0 (no bit set) otherwise return the
result of __ffs directly?

Same comment for other similar places.

> +	}
> +
> +	return _find_first_bit(addr, size);
> +}


-- 
With Best Regards,
Andy Shevchenko


