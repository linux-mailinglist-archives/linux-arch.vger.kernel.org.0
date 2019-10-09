Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43DD14F7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJIRJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:09:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:26159 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfJIRJX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Oct 2019 13:09:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 10:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="206918443"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2019 10:09:19 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIFSf-00036t-U0; Wed, 09 Oct 2019 20:09:17 +0300
Date:   Wed, 9 Oct 2019 20:09:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        preid@electromag.com.au, Lukas Wunner <lukas@wunner.de>,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20191009170917.GG32742@smile.fi.intel.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
 <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.

> Why is the return type "unsigned long" where you know
> it return the 8-bit value ?

Because bitmap API operates on unsigned long type. This is not only
consistency, but for sake of flexibility in case we would like to introduce
more calls like clump16 or so.

Same comment for the rest.

-- 
With Best Regards,
Andy Shevchenko


