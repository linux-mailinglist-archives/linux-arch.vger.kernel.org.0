Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331032FE76F
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 11:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbhAUKVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 05:21:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:56036 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbhAUKUn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 05:20:43 -0500
IronPort-SDR: 51fRsr49keQUVP/Sv0UmNEtwvoEvC3+KhUfIQLRicUBuYrZnVDPDp4yf90wLzksWBJWq5iqAwi
 Co2wTvWjR7kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179332589"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="179332589"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:18:56 -0800
IronPort-SDR: Eokc4XQnbp9MzSQi/L/39fhZWWjDql3WR7ucevTyf+OJ+D23NzyX6BvsX3dwqqwf0sqwyu96dt
 IqltuelJsLDw==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="502108595"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:18:52 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2X4D-007NQN-Nc; Thu, 21 Jan 2021 12:19:53 +0200
Date:   Thu, 21 Jan 2021 12:19:53 +0200
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
Subject: Re: [PATCH 2/6] bitmap: move some macros from linux/bitmap.h to
 linux/bitops.h
Message-ID: <YAlVScX1d9KKvSZN@smile.fi.intel.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
 <20210121000630.371883-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121000630.371883-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 20, 2021 at 04:06:26PM -0800, Yury Norov wrote:
> In the following patches of the series they are used by
> find_bit subsystem.

s/subsystem/API/

...

> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -7,6 +7,17 @@
>  
>  #include <uapi/linux/kernel.h>
>  
> +#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> +#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))

Hmm... Naming here is not in the bitops namespace.
I would expect BITS rather than BITMAP for these two.

So, we have at least the following options:
 - split to a separate header, like bitmap_macros.h
 - s/BITMAP/BITS/ and either define BITMAP_* as respective BITS_* or rename it
   everywhere in bitmap.*
 - your variant
 - ...???...


-- 
With Best Regards,
Andy Shevchenko


