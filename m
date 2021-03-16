Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E923F33D33C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 12:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhCPLjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 07:39:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:60586 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237378AbhCPLjQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 07:39:16 -0400
IronPort-SDR: efRc5xOzUO1aTnzdFLwvLotVSiB9C+rZwpRzjOKISAR8Kc3jbMYGZTqhQPHY0wEZfPDelgqS18
 qz2jayj9ryUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274285882"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274285882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 04:39:14 -0700
IronPort-SDR: Uu2NYVQV19jKW3IGxrZ2iulFHr94qoOPZaU73rbJrxGCF6Y+mgSxp+07W1GwSt8HuBhreBQCs8
 ChLlPdnlWyYQ==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="440062397"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 04:39:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lM82U-00CwLD-Dt; Tue, 16 Mar 2021 13:39:06 +0200
Date:   Tue, 16 Mar 2021 13:39:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 01/13] tools: disable -Wno-type-limits
Message-ID: <YFCY2s/6+2f7Qycf@smile.fi.intel.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-2-yury.norov@gmail.com>
 <2ec71f83-f903-2775-bf04-7f0a83c9f4cb@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec71f83-f903-2775-bf04-7f0a83c9f4cb@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 09:17:24AM +0100, Rasmus Villemoes wrote:
> On 16/03/2021 02.54, Yury Norov wrote:
> > GENMASK(h, l) may be passed with unsigned types. In such case, type-limits
> > warning is generated for example in case of GENMASK(h, 0).

...

> I don't like that kind of collateral damage. I seem to recall another
> instance where a macro was instead rewritten to avoid triggering the
> type-limits warning (with a comment explaining the uglyness). Something like
> 
> foo > bar      is the same as
> !(foo <= bar)  which is the same as
> !(foo == bar || foo < bar)
> 
> Dunno if that would work here, but if it did, it would have the bonus
> that when somebody builds the kernel proper with Wtype-limits enabled
> (maybe W=1 or W=2) there would be no false positives from GENMASK to
> wade through.
> 
> Alternatively, we really should consider making use of _Pragma to
> locally disable/re-enable certain warnings.

Rasmus, in the kernel the same was fixed as per 355a3587d4ca.
I don't know why tools should be different to that.

-- 
With Best Regards,
Andy Shevchenko


