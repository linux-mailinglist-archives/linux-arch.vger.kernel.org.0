Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7324031EE06
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBRSIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 13:08:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:8917 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhBRPbB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 10:31:01 -0500
IronPort-SDR: BmaVB/hvhQSnx6guA3qe2ceWh40Puv2HjI2kkPQoA8BZGL6Gq2G7jYCsLIAwsumxWCfvO4LxLE
 5iLGP65xQtjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="247613518"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="247613518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 07:28:40 -0800
IronPort-SDR: KX9DvpxVrcJtQQ9LUit+AWu9KaUP8n+rhs+LWbZAOMPthhLLTBBGBNSHAErVZDOd2gGw+gZPV0
 v3GXUBJYzW9A==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="401689900"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 07:28:36 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lClEG-005yjg-L4; Thu, 18 Feb 2021 17:28:32 +0200
Date:   Thu, 18 Feb 2021 17:28:32 +0200
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
Subject: Re: [PATCH 14/14] MAINTAINERS: Add entry for the bitmap API
Message-ID: <YC6HoF2lhSlrYs3j@smile.fi.intel.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-15-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218040512.709186-15-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 17, 2021 at 08:05:12PM -0800, Yury Norov wrote:
> Add myself as maintainer for bitmap API.
> 
> I'm an author of current implementation of lib/find_bit and an
> active contributor to lib/bitmap. It was spotted that there's no
> maintainer for bitmap API. I'm willing to maintain it.

Perhaps reviewers as well, like Rasmus, if he is okay with that, of course?

Otherwise, why not?
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7bdf12d3e0a8..9f8540a9dabf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3146,6 +3146,20 @@ F:	Documentation/filesystems/bfs.rst
>  F:	fs/bfs/
>  F:	include/uapi/linux/bfs_fs.h
>  
> +BITMAP API
> +M:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	include/asm-generic/bitops/find.h
> +F:	include/linux/bitmap.h
> +F:	lib/bitmap.c
> +F:	lib/find_bit.c
> +F:	lib/find_find_bit_benchmark.c
> +F:	lib/test_bitmap.c
> +F:	tools/include/asm-generic/bitops/find.h
> +F:	tools/include/linux/bitmap.h
> +F:	tools/lib/bitmap.c
> +F:	tools/lib/find_bit.c
> +
>  BLINKM RGB LED DRIVER
>  M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
>  S:	Maintained
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


