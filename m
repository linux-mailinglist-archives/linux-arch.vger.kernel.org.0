Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B7130A905
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBANrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 08:47:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:38590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhBANq7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 08:46:59 -0500
IronPort-SDR: aS1J3GaOFGWXyg8Ks6x89u9zubvwSosWQheNO1pO1iXFuARn2MbbdAqwnJeOVs1bTY4k/BRPmK
 YCtNTP/fB4RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177177063"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="177177063"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:45:12 -0800
IronPort-SDR: BIJui6HNSFkeYmSJizAXjlDtxmnIzL7M8uFvE2ApaE9Gt7uJjT9M9KfDwG6/xJsaP7PCTE1iUo
 edrAITzPPKlQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="412771771"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:45:05 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6ZVl-0018wg-J8; Mon, 01 Feb 2021 15:45:01 +0200
Date:   Mon, 1 Feb 2021 15:45:01 +0200
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
Subject: Re: [PATCH 5/8] bitsperlong.h: introduce SMALL_CONST() macro
Message-ID: <YBgF3RYQ5F6xmpj8@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130191719.7085-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 11:17:16AM -0800, Yury Norov wrote:
> Many algorithms become simpler if they are passed with relatively small
> input values. One example is bitmap operations when the whole bitmap fits
> into one word. To implement such simplifications, linux/bitmap.h declares
> small_const_nbits() macro.
> 
> Other subsystems may also benefit from optimizations of this sort, like
> find_bit API in the following patches. So it looks helpful to generalize
> the macro and extend it's visibility.

Hmm... Are we really good to allow 0 as a parameter to it? I remember we had
a thread at some point where Rasmus explained why 0 is excluded.


...

> --- a/tools/include/asm-generic/bitsperlong.h
> +++ b/tools/include/asm-generic/bitsperlong.h

Tools part in a separate patch?

-- 
With Best Regards,
Andy Shevchenko


