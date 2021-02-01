Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC87930A8FA
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhBANoW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 08:44:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:27820 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhBANoW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 08:44:22 -0500
IronPort-SDR: NzhAKCYhnQXi4XM/YUtH4pHJ+jygKZ/Eg9cKCW9tB8N3QjXczD+vw5qR+BeTYB068swyVbjcGf
 guKV2pK7B0Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="199578880"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="199578880"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:42:35 -0800
IronPort-SDR: AfFKvMAXe7FVmvGMevF7putl5zn4hCdP5hNEoGE0ehdmlm6i979xyhx1vCzn0j5RAjUyNY0Q0z
 RHxlfdNlD9MQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="358585103"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:42:30 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6ZTG-0018vK-O7; Mon, 01 Feb 2021 15:42:26 +0200
Date:   Mon, 1 Feb 2021 15:42:26 +0200
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
Subject: Re: [PATCH 4/8] lib: introduce BITS_{FIRST,LAST} macro
Message-ID: <YBgFQmxh5dnPI6HL@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130191719.7085-5-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 11:17:15AM -0800, Yury Norov wrote:
> BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
> functionality of GENMASK(). The scope of there macros is wider than just
> bitmap. This patch defines 4 new macros: BITS_FIRST(), BITS_LAST(),
> BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h on top of GENMASK()
> and replaces BITMAP_{LAST,FIRST}_WORD_MASK() to avoid duplication and
> increases scope of the macros.

...

>  include/linux/bitmap.h            | 27 ++++++++++++---------------
>  include/linux/bits.h              |  6 ++++++
>  include/linux/cpumask.h           |  8 ++++----
>  include/linux/netdev_features.h   |  2 +-
>  include/linux/nodemask.h          |  2 +-
>  lib/bitmap.c                      | 26 +++++++++++++-------------
>  lib/find_bit.c                    |  4 ++--
>  lib/genalloc.c                    |  8 ++++----

Answering to your reply. I meant to split the below to a separate patch.

>  tools/include/linux/bitmap.h      | 20 ++++++--------------
>  tools/include/linux/bits.h        |  6 ++++++
>  tools/lib/bitmap.c                |  6 +++---
>  tools/lib/find_bit.c              |  2 +-
>  tools/testing/radix-tree/bitmap.c |  4 ++--

...

> +#define BITS_FIRST(nr)		GENMASK((nr), 0)
> +#define BITS_LAST(nr)		GENMASK(BITS_PER_LONG - 1, (nr))
> +
> +#define BITS_FIRST_MASK(nr)	BITS_FIRST((nr) % BITS_PER_LONG)
> +#define BITS_LAST_MASK(nr)	BITS_LAST((nr) % BITS_PER_LONG)

Any pointers to the difference in generated code for popular architectures
(x86. x86_64, arm, aarch64, ppc, ppc64)?

-- 
With Best Regards,
Andy Shevchenko


