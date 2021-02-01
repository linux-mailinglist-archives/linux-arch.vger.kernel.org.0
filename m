Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404AB30A915
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBANvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 08:51:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:48566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhBANvP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 08:51:15 -0500
IronPort-SDR: +BoOSAD8kFnmhW92MvmSBLCCYbLFzNmd6+JyCUA2mMx/NdsJ+cMZ+JdJQJid+ZpJoMMIzafRqv
 l+mtH9D4FgBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="167789228"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="167789228"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:49:27 -0800
IronPort-SDR: HIGuIYqfme9l0ZvuvTAb7RogaVsqKQpkOy5QozRDhot1puv9UHMLoRNWbb9P1A9eMYYk76lJ7K
 EHlSloz2I1Vg==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="577834479"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:49:23 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6ZZv-0018zx-1X; Mon, 01 Feb 2021 15:49:19 +0200
Date:   Mon, 1 Feb 2021 15:49:19 +0200
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
Subject: Re: [PATCH 7/8] lib: add fast path for find_next_*_bit()
Message-ID: <YBgG35UTDLpVSYWV@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-8-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130191719.7085-8-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 11:17:18AM -0800, Yury Norov wrote:
> Similarly to bitmap functions, find_next_*_bit() users will benefit
> if we'll handle a case of bitmaps that fit into a single word. In the
> very best case, the compiler may replace a function call with a
> single ffs or ffz instruction.

Would be nice to have the examples how it reduces the actual code size (based
on the existing code in kernel, especially in widely used frameworks /
subsystems, like PCI).

-- 
With Best Regards,
Andy Shevchenko


