Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E633D351
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhCPLqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 07:46:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:62753 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhCPLqB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 07:46:01 -0400
IronPort-SDR: xkGZDE2WKvZmKbcnrr6NyAC+zYgZgiVAJlJDFAuHf42ObeqaALizoXT3ZIGfpH68TbVY+3GRWb
 bTUx3dBxswrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="189335520"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="189335520"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 04:46:00 -0700
IronPort-SDR: +LO7YYVov1jwziQmA/UFHBsNWYQ330C4ddAvHBYm2cNzVFbT6szAM9/HRwrk/WbnZ5tlNYi1U6
 RoT8JaJYXmcA==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="378845401"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 04:45:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lM891-00CwQc-Vf; Tue, 16 Mar 2021 13:45:51 +0200
Date:   Tue, 16 Mar 2021 13:45:51 +0200
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
Subject: Re: [PATCH 13/13] MAINTAINERS: Add entry for the bitmap API
Message-ID: <YFCabyt9pfPtoQiZ@smile.fi.intel.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-14-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316015424.1999082-14-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 15, 2021 at 06:54:24PM -0700, Yury Norov wrote:
> Add myself as maintainer for bitmap API and Andy and Rasmus as reviewers.
> 
> I'm an author of current implementation of lib/find_bit and an active
> contributor to lib/bitmap. It was spotted that there's no maintainer for
> bitmap API. I'm willing to maintain it.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dd20015696e..44f94cdd5a20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3151,6 +3151,22 @@ F:	Documentation/filesystems/bfs.rst
>  F:	fs/bfs/
>  F:	include/uapi/linux/bfs_fs.h
>  
> +BITMAP API
> +M:	Yury Norov <yury.norov@gmail.com>
> +R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> +S:	Maintained
> +F:	include/asm-generic/bitops/find.h
> +F:	include/linux/bitmap.h
> +F:	lib/bitmap.c
> +F:	lib/find_bit.c

> +F:	lib/find_find_bit_benchmark.c

Does this file exist?
I guess checkpatch.pl nowadays has a MAINTAINER data base validation.

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


