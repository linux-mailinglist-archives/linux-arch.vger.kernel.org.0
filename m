Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80FC1D4CA6
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOLdA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 07:33:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:20782 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgEOLc7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 07:32:59 -0400
IronPort-SDR: XqeWr7S/fqOBGflO8ApSAhWwiaBR2ZEZjVT78CRk11D6mgUgoqR6Zfnxghtl5zZvaiwWCdOH1T
 i6BerGzpoS/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 04:32:58 -0700
IronPort-SDR: 0gS0OaFJiuv3OfG2ljoqjSB4HKx6CLP4K3KFhfm6vWhg8PAp9Nw/f+wW4k3a8VLZLakldEI3/w
 +/CncU4PobkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="464700264"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 04:32:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZYaH-006qe0-KA; Fri, 15 May 2020 14:32:57 +0300
Date:   Fri, 15 May 2020 14:32:57 +0300
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
Subject: Re: [PATCH v6 0/4] Introduce the for_each_set_clump macro
Message-ID: <20200515113257.GP185537@smile.fi.intel.com>
References: <cover.1589497311.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589497311.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 04:46:03AM +0530, Syed Nayyar Waris wrote:
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

Thank you!

Overall looks good to me, though I gave tags per individual patches (I'm not
familiar with that GPIO drivers, so, I may not tag them).

> 
> Changes in v6:
>  - [Patch 2/4]: Make 'for loop' inside test_for_each_set_clump more
>    succinct.
> 
> Changes in v5:
>  - [Patch 4/4]: Minor change: Hardcode value for better code readability.
> 
> Changes in v4:
>  - [Patch 2/4]: Use 'for' loop in test function of for_each_set_clump.
>  - [Patch 3/4]: Minor change: Inline value for better code readability.
>  - [Patch 4/4]: Minor change: Inline value for better code readability.
> 
> Changes in v3:
>  - [Patch 3/4]: Change datatype of some variables from u64 to unsigned long
>    in function thunderx_gpio_set_multiple.
> 
> CHanges in v2:
>  - [Patch 2/4]: Unify different tests for 'for_each_set_clump'. Pass test data as
>    function parameters.
>  - [Patch 2/4]: Remove unnecessary bitmap_zero calls.
> 
> Syed Nayyar Waris (4):
>   bitops: Introduce the the for_each_set_clump macro
>   lib/test_bitmap.c: Add for_each_set_clump test cases
>   gpio: thunderx: Utilize for_each_set_clump macro
>   gpio: xilinx: Utilize for_each_set_clump macro
> 
>  drivers/gpio/gpio-thunderx.c      |  11 ++-
>  drivers/gpio/gpio-xilinx.c        |  62 ++++++-------
>  include/asm-generic/bitops/find.h |  19 ++++
>  include/linux/bitmap.h            |  61 +++++++++++++
>  include/linux/bitops.h            |  13 +++
>  lib/find_bit.c                    |  14 +++
>  lib/test_bitmap.c                 | 142 ++++++++++++++++++++++++++++++
>  7 files changed, 288 insertions(+), 34 deletions(-)
> 
> 
> base-commit: 5f458e572071a54841b93f41e25fbe8ded82df79
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


