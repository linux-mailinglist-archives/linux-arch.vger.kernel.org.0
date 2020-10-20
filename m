Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18180292030
	for <lists+linux-arch@lfdr.de>; Sun, 18 Oct 2020 23:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgJRVhv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Oct 2020 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVhu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Oct 2020 17:37:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB01C061755;
        Sun, 18 Oct 2020 14:37:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e15so1597189pfh.6;
        Sun, 18 Oct 2020 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ihQGJxo3JZrn4cqgJ3fEKTBsZo1j40mfYYWZF1c6FZ4=;
        b=knyO+DuYt1uvvdKpxN0UpMnUhFH9H291MuqezMLS5P86ZKs1a6Drsn2+9uKzkg8+gq
         Rx6ZSS83JFN/Zj9zu+w8ZoKBW6pbn1q6PP5qAnkXH9liHnvnAIdM1aVCy4F4ECc/CPXU
         8X0KfWxEZ69+ZJ/a3616Jq8LF2q86Ii75byej47C8MwqmC19fpOqUSwJYVfyg7Dmq6jw
         zbWAaYYomvUJwl4hOHKTeABnUXPuPl/+jI6Mx+PackihYKx+jIoSFhViiJq1jKNmHqhk
         JAFDMC0OEiKjcpjrsqFr+DhJOMZbFyLKqmzmQXkVU41DF81/3DJvCeGsTuIFOx+5QMFu
         j/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ihQGJxo3JZrn4cqgJ3fEKTBsZo1j40mfYYWZF1c6FZ4=;
        b=HtLUbOZwiYWjzIhiIuPMs4ie69jbNo9qDamMFEhSK+vVKxzeObxJWlJ+bgZqvXgEI+
         6+/2wDf+61HgXB4uPKvaPZ9/2x54eKty/lm6oFS9NBxM6LuwXKOS+wvFM1JBBw7nJHJG
         mF+tWGysSOlY4Ey8BRJMo7OhiodXvtGwPLp7tlEwEicBUTAhPSr7zWmnqVPrOAIjXk0h
         rhukVfyQ0dtRBJPwPYh2BQhvfUMHtyfLb6UIuKlTdkHj6OxxkD9clQN7lFC2G0LP5I+0
         mzhkiLiz46gxI+/ADBXJAdNX1BWHOVLTlvG2vOiqkloaeO10BrFEaXP0P2f4+/EASqs0
         UxQg==
X-Gm-Message-State: AOAM53142yyETWo+pfFCbr4DeOgeUMs5a6375jgVNxi0i6i0RyhuEusX
        p3ufgaNYLdMVfkJdfXjOI+E=
X-Google-Smtp-Source: ABdhPJy6jzHV/dSSCjWff0nzBU5ZlH45mh2zd/zQcpHBaFpYMydRDsxCsGgvKzhTwkmtQiq6BBV5lQ==
X-Received: by 2002:a63:68e:: with SMTP id 136mr11929130pgg.211.1603057069917;
        Sun, 18 Oct 2020 14:37:49 -0700 (PDT)
Received: from syed ([2401:4900:47f3:e624:90f9:25c2:806b:19c8])
        by smtp.gmail.com with ESMTPSA id 92sm9995465pjv.32.2020.10.18.14.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2020 14:37:49 -0700 (PDT)
Date:   Mon, 19 Oct 2020 03:07:24 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v12 0/4] Introduce the for_each_set_clump macro
Message-ID: <cover.1603055402.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset introduces a new generic version of for_each_set_clump. 
The previous version of for_each_set_clump8 used a fixed size 8-bit
clump, but the new generic version can work with clump (n-bits) having 
size between 1 and BITS_PER_LONG inclusive. size less than 1 or more than 
BITS_PER_LONG causes undefined behaviour. The patchset utilizes the new 
macro in some GPIO drivers.

The earlier 8-bit for_each_set_clump8 facilitated a
for-loop syntax that iterates over a memory region entire groups of set
bits at a time.

For example, suppose you would like to iterate over a 32-bit integer 8
bits at a time, skipping over 8-bit groups with no set bit, where
XXXXXXXX represents the current 8-bit group:

    Example:        10111110 00000000 11111111 00110011
    First loop:     10111110 00000000 11111111 XXXXXXXX
    Second loop:    10111110 00000000 XXXXXXXX 00110011
    Third loop:     XXXXXXXX 00000000 11111111 00110011

Each iteration of the loop returns the next 8-bit group that has at
least one set bit.

But with the new for_each_set_clump the clump size can be different from 8 bits.
Moreover, the clump can be split at word boundary in situations where word 
size is not multiple of clump size. Following are examples showing the working 
of new macro for clump sizes of 24 bits and 6 bits.

Example 1:
clump size: 24 bits, Number of clumps (or ports): 10
bitmap stores the bit information from where successive clumps are retrieved.

     /* bitmap memory region */
        0x00aa0000ff000000;  /* Most significant bits */
        0xaaaaaa0000ff0000;
        0x000000aa000000aa;
        0xbbbbabcdeffedcba;  /* Least significant bits */

Different iterations of for_each_set_clump:-
'offset' is the bit position and 'clump' is the 24 bit clump from the
above bitmap.
Iteration first:        offset: 0 clump: 0xfedcba
Iteration second:       offset: 24 clump: 0xabcdef
Iteration third:        offset: 48 clump: 0xaabbbb
Iteration fourth:       offset: 96 clump: 0xaa
Iteration fifth:        offset: 144 clump: 0xff
Iteration sixth:        offset: 168 clump: 0xaaaaaa
Iteration seventh:      offset: 216 clump: 0xff
Loop breaks because in the end the remaining bits (0x00aa) size was less
than clump size of 24 bits.

In above example it can be seen that in iteration third, the 24 bit clump
that was retrieved was split between bitmap[0] and bitmap[1]. This example 
also shows that 24 bit zeroes if present in between, were skipped (preserving
the previous for_each_set_macro8 behaviour). 

Example 2:
clump size = 6 bits, Number of clumps (or ports) = 3.

     /* bitmap memory region */
        0x00aa0000ff000000;  /* Most significant bits */
        0xaaaaaa0000ff0000;
        0x0f00000000000000;
        0x0000000000000ac0;  /* Least significant bits */

Different iterations of for_each_set_clump:
'offset' is the bit position and 'clump' is the 6 bit clump from the
above bitmap.
Iteration first:        offset: 6 clump: 0x2b
Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
Here 6 * 3 is clump size * no. of clumps.

Changes in v12:
 - [Patch 1/4]: Format and modify comments.
 - [Patch 1/4]: Optimize code using '<<' operator with GENMASK.
 - [Patch 4/4]: Remove extra empty newline.

Changes in v11:
 - [Patch 1/4]: Document range of values 'nbits' can take.
 - [Patch 4/4]: Change variable name 'flag' to 'flags'.

Changes in v10:
 - Patchset based on v5.9-rc1.

Changes in v9:
 - [Patch 4/4]: Remove looping of 'for_each_set_clump' and instead process two 
   halves of a 64-bit bitmap separately or individually. Use normal spin_lock 
   call for second inner lock. And take the spin_lock_init call outside the 'if'
   condition in the probe function of driver.

Changes in v8:
 - [Patch 2/4]: Minor change: Use '__initdata' for correct section mismatch
   in 'clump_test_data' array.

Changes in v7:
 - [Patch 2/4]: Minor changes: Use macro 'DECLARE_BITMAP()' and split 'struct'
   definition and test data.

Changes in v6:
 - [Patch 2/4]: Make 'for loop' inside test_for_each_set_clump more
   succinct.

Changes in v5:
 - [Patch 4/4]: Minor change: Hardcode value for better code readability.

Changes in v4:
 - [Patch 2/4]: Use 'for' loop in test function of for_each_set_clump.
 - [Patch 3/4]: Minor change: Inline value for better code readability.
 - [Patch 4/4]: Minor change: Inline value for better code readability.

Changes in v3:
 - [Patch 3/4]: Change datatype of some variables from u64 to unsigned long
   in function thunderx_gpio_set_multiple.

CHanges in v2:
 - [Patch 2/4]: Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - [Patch 2/4]: Remove unnecessary bitmap_zero calls.

Syed Nayyar Waris (4):
  bitops: Introduce the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize generic bitmap_get_value and _set_value

 drivers/gpio/gpio-thunderx.c      |  11 ++-
 drivers/gpio/gpio-xilinx.c        |  65 +++++++-------
 include/asm-generic/bitops/find.h |  19 ++++
 include/linux/bitmap.h            |  61 +++++++++++++
 include/linux/bitops.h            |  13 +++
 lib/find_bit.c                    |  14 +++
 lib/test_bitmap.c                 | 144 ++++++++++++++++++++++++++++++
 7 files changed, 290 insertions(+), 37 deletions(-)


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.26.2

