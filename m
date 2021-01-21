Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D491C2FEB76
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbhAUNTS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 08:19:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:40972 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbhAUK3D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 05:29:03 -0500
IronPort-SDR: TUATUDGwUn7VaKLb5yV24oEW+7xMrYOXYvC5urHuNGHCU5ysvc2W2/py6L9O+UuVnADY9efPH7
 aLdhT+dAzCYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243321049"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="243321049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:27:04 -0800
IronPort-SDR: QgeIy8Ssun2hy6R9w17UY0Ll/AXBiBRb1BeFr667ljwzuCW2rJkpwHDq8WPMolQ61OBDnrLG/t
 VJau4CgcO5fw==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="570684050"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:27:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2XC6-007Nsw-Be; Thu, 21 Jan 2021 12:28:02 +0200
Date:   Thu, 21 Jan 2021 12:28:02 +0200
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
Subject: Re: [PATCH 4/6] lib: inline _find_next_bit() wrappers
Message-ID: <YAlXMj7sIoPjZP3W@smile.fi.intel.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
 <20210121000630.371883-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121000630.371883-5-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 20, 2021 at 04:06:28PM -0800, Yury Norov wrote:
> lib/find_bit.c declares five single-line wrappers for _find_next_bit().
> We may turn those wrappers to inline functions. It eliminates
> unneeded function calls and opens room for compile-time optimizations.

...

> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/types.h>
>  #include <asm/byteorder.h>
> +#include <asm-generic/bitops/find.h>

I'm wondering if generic header inclusion should go before arch-dependent ones.

...

> -#ifndef find_next_bit

> -#ifndef find_next_zero_bit

> -#if !defined(find_next_and_bit)

> -#ifndef find_next_zero_bit_le

> -#ifndef find_next_bit_le

Shouldn't you leave these in new wrappers as well?

-- 
With Best Regards,
Andy Shevchenko


