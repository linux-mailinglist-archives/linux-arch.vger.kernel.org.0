Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF23541E9
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhDEL64 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 07:58:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:45795 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233960AbhDEL6z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Apr 2021 07:58:55 -0400
IronPort-SDR: fiuSY6eEdrvZF4Du1vN9NXBAMbeGnYJVYKv16AcS1HpDR6RLAJxPC1JIJPT9sd2ZboVaAxuEHK
 scmF36L8II2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9944"; a="192357900"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="192357900"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 04:58:48 -0700
IronPort-SDR: hbWQXiBgEZ3QUgsl33+QUPhP+YH5y+9V9E/J5tZnT77mACSuR4Uuhxy+zn5+OYGL1WoD4azlTX
 XpZFKc7fzOHQ==
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="529396729"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 04:58:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lTNsR-001PpQ-9U; Mon, 05 Apr 2021 14:58:43 +0300
Date:   Mon, 5 Apr 2021 14:58:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] h8300: rearrange headers inclusion order in asm/bitops
Message-ID: <YGr7c9zHoCKN1Gyn@smile.fi.intel.com>
References: <20210401203228.124145-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401203228.124145-1-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 01:32:28PM -0700, Yury Norov wrote:
> This patch fixes [next-20210401] commit a5145bdad3ff ("arch: rearrange

"This patch fixes [next-20210401] commit ..." ==>

"The commit ...

> headers inclusion order in asm/bitops for m68k and sh").

...fixed header ordering issue."


> h8300 has 
> similar problem, which was overlooked by me.


> h8300 includes bitmap/{find,le}.h prior to ffs/fls headers. New fast-path
> implementation in find.h requires ffs/fls. Reordering the headers inclusion
> sequence helps to prevent compile-time implicit function declaration error.

Whit above commit message rephrasing:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/h8300/include/asm/bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
> index 7aa16c732aa9..c867a80cab5b 100644
> --- a/arch/h8300/include/asm/bitops.h
> +++ b/arch/h8300/include/asm/bitops.h
> @@ -9,6 +9,10 @@
>  
>  #include <linux/compiler.h>
>  
> +#include <asm-generic/bitops/fls.h>
> +#include <asm-generic/bitops/__fls.h>
> +#include <asm-generic/bitops/fls64.h>
> +
>  #ifdef __KERNEL__
>  
>  #ifndef _LINUX_BITOPS_H
> @@ -173,8 +177,4 @@ static inline unsigned long __ffs(unsigned long word)
>  
>  #endif /* __KERNEL__ */
>  
> -#include <asm-generic/bitops/fls.h>
> -#include <asm-generic/bitops/__fls.h>
> -#include <asm-generic/bitops/fls64.h>
> -
>  #endif /* _H8300_BITOPS_H */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


