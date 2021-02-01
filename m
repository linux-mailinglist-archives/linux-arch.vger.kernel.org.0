Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAF030A90D
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBANtk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 08:49:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:41724 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231587AbhBANti (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 08:49:38 -0500
IronPort-SDR: xtKhVSOoZ4n1paLzTf+jQ9yqjwdqRWLoYm1i5dOLuc+fP3dvggmdezUxszWepYcBynvO1L5wGH
 xBJqaZBGN/mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="178121833"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="178121833"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:47:52 -0800
IronPort-SDR: e0Pb8xLftFnVZ66obmmc+PebsCnX4ifT8jEX/Rs7q1llwWJkBwsu4wt0fhPE0Je7Tue9zHjHUl
 4aUybhdfs58g==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="371555767"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:47:47 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6ZYN-0018z2-F0; Mon, 01 Feb 2021 15:47:43 +0200
Date:   Mon, 1 Feb 2021 15:47:43 +0200
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
Subject: Re: [PATCH 6/8] lib: inline _find_next_bit() wrappers
Message-ID: <YBgGf8y/K0da5MWz@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130191719.7085-7-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 11:17:17AM -0800, Yury Norov wrote:
> lib/find_bit.c declares five single-line wrappers for _find_next_bit().
> We may turn those wrappers to inline functions. It eliminates unneeded
> function calls and opens room for compile-time optimizations.

>  tools/include/asm-generic/bitops/find.h | 27 +++++++++---
>  tools/lib/find_bit.c                    | 52 ++++++++++-------------

In a separated patch, please. I don't think we need to defer this series in
case if tools lagged (which is usual case in my practice).

-- 
With Best Regards,
Andy Shevchenko


