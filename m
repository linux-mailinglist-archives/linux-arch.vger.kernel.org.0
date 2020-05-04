Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180F41C3875
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 13:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEDLlM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 07:41:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:57390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEDLlL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 07:41:11 -0400
IronPort-SDR: SQuyBrnTNt/XjkAq/e7HnsbwGtIBWgOWFBKaSarp61eXXnHU9GKjwB9Atffxlgh+N/xT8lVnIR
 Dq4P9W+1LzXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 04:41:10 -0700
IronPort-SDR: nK1XVmEP/7h0Dz9nRq3BHsCwEWqIAqIaOYKzPSsL9UGWuseFvAxw0CBmTaJZwhBHb/MKLwbX/x
 FvpEWpGlLdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="248193832"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 04 May 2020 04:41:06 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVZTB-004bjy-4p; Mon, 04 May 2020 14:41:09 +0300
Date:   Mon, 4 May 2020 14:41:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
Message-ID: <20200504114109.GE185537@smile.fi.intel.com>
References: <cover.1588460322.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588460322.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:
> This patchset introduces a new generic version of for_each_set_clump. 
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro 
> in several GPIO drivers.
> 
> The earlier 8-bit for_each_set_clump8 facilitated a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
> 
> For example, suppose you would like to iterate over a 32-bit integer 8
> bits at a time, skipping over 8-bit groups with no set bit, where
> XXXXXXXX represents the current 8-bit group:
> 
>     Example:        10111110 00000000 11111111 00110011
>     First loop:     10111110 00000000 11111111 XXXXXXXX
>     Second loop:    10111110 00000000 XXXXXXXX 00110011
>     Third loop:     XXXXXXXX 00000000 11111111 00110011
> 
> Each iteration of the loop returns the next 8-bit group that has at
> least one set bit.
> 
> But with the new for_each_set_clump the clump size can be different from 8 bits.
> Moreover, the clump can be split at word boundary in situations where word 
> size is not multiple of clump size. Following are examples showing the working 
> of new macro for clump sizes of 24 bits and 6 bits.
> 
> Example 1:
> clump size: 24 bits, Number of clumps (or ports): 10
> bitmap stores the bit information from where successive clumps are retrieved.
> 
>      /* bitmap memory region */
>         0x00aa0000ff000000;  /* Most significant bits */
>         0xaaaaaa0000ff0000;
>         0x000000aa000000aa;
>         0xbbbbabcdeffedcba;  /* Least significant bits */
> 
> Different iterations of for_each_set_clump:-
> 'offset' is the bit position and 'clump' is the 24 bit clump from the
> above bitmap.
> Iteration first:        offset: 0 clump: 0xfedcba
> Iteration second:       offset: 24 clump: 0xabcdef
> Iteration third:        offset: 48 clump: 0xaabbbb
> Iteration fourth:       offset: 96 clump: 0xaa
> Iteration fifth:        offset: 144 clump: 0xff
> Iteration sixth:        offset: 168 clump: 0xaaaaaa
> Iteration seventh:      offset: 216 clump: 0xff
> Loop breaks because in the end the remaining bits (0x00aa) size was less
> than clump size of 24 bits.
> 
> In above example it can be seen that in iteration third, the 24 bit clump
> that was retrieved was split between bitmap[0] and bitmap[1]. This example 
> also shows that 24 bit zeroes if present in between, were skipped (preserving
> the previous for_each_set_macro8 behaviour). 
> 
> Example 2:
> clump size = 6 bits, Number of clumps (or ports) = 3.
> 
>      /* bitmap memory region */
>         0x00aa0000ff000000;  /* Most significant bits */
>         0xaaaaaa0000ff0000;
>         0x0f00000000000000;
>         0x0000000000000ac0;  /* Least significant bits */
> 
> Different iterations of for_each_set_clump:
> 'offset' is the bit position and 'clump' is the 6 bit clump from the
> above bitmap.
> Iteration first:        offset: 6 clump: 0x2b
> Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
> Here 6 * 3 is clump size * no. of clumps.

Looking into the last patches where we have examples I still do not see a
benefit of variadic clump sizes. power of 2 sizes would make sense (and be
optimized accordingly (64-bit, 32-bit).

-- 
With Best Regards,
Andy Shevchenko


