Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB26231C7E3
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 10:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhBPJQd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 04:16:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:8550 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhBPJQT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Feb 2021 04:16:19 -0500
IronPort-SDR: YwQi6r+UXddcEZs6XG7AK9mOKvQjmJEvJiUniJRZpUFnYhXtEPBmfddgR/LUMUow4RrTaMCtV+
 3U37Zus2uMVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246904649"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="246904649"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 01:14:32 -0800
IronPort-SDR: tPkmKh2OTx4znumaJmxTa2l2vBJfWMkEjT34Z+L3rFz0la3AfJcfUFiM2BL5vE5rYPheUPAQ7d
 zf7ZUrYkEr1A==
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="512455158"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 01:14:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lBwR5-005Qf3-SD; Tue, 16 Feb 2021 11:14:23 +0200
Date:   Tue, 16 Feb 2021 11:14:23 +0200
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: Re: [RESEND PATCH v2 0/6] lib/find_bit: fast path for small bitmaps
Message-ID: <YCuM7yzMoXjpuj8Y@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210215213044.GB394846@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215213044.GB394846@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 15, 2021 at 01:30:44PM -0800, Yury Norov wrote:
> [add David Laight <David.Laight@ACULAB.COM> ]
> 
> On Sat, Jan 30, 2021 at 11:17:11AM -0800, Yury Norov wrote:
> > Bitmap operations are much simpler and faster in case of small bitmaps
> > which fit into a single word. In linux/bitmap.h we have a machinery that
> > allows compiler to replace actual function call with a few instructions
> > if bitmaps passed into the function are small and their size is known at
> > compile time.
> > 
> > find_*_bit() API lacks this functionality; despite users will benefit from
> > it a lot. One important example is cpumask subsystem when
> > NR_CPUS <= BITS_PER_LONG. In the very best case, the compiler may replace
> > a find_*_bit() call for such a bitmap with a single ffs or ffz instruction.
> > 
> > Tools is synchronized with new implementation where needed.
> > 
> > v1: https://www.spinics.net/lists/kernel/msg3804727.html
> > v2: - employ GENMASK() for bitmaps;
> >     - unify find_bit inliners in;
> >     - address comments to v1;
> 
> Comments so far:
>  - increased image size (patch #8) - addressed by introducing
>    CONFIG_FAST_PATH;

>  - split tools and kernel parts - not clear why it's better.

Because tools are user space programs and sometimes may not follow kernel
specifics, so they are different logically and changes should be separated.

>  Anything else?

-- 
With Best Regards,
Andy Shevchenko


