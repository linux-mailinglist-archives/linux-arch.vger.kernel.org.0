Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A202281F58
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 01:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBXsC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 19:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 19:48:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F355C0613D0;
        Fri,  2 Oct 2020 16:48:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a17so1282251pju.1;
        Fri, 02 Oct 2020 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sVB2ZNCIC2yUsn0H9I4h+ZJh2Im2Ue0nLn/PAnAq2D0=;
        b=CeTyVYisPH60wU5X8XCazWYVSR41JW400gyE7UWp2TTAwPYrgPSBGAU2QT88Z/QMIy
         rx/PLamhxepSaACp/kNzxL98plkJ7srJBKL3jQHxExlA/DDF6EiJzTBlSXEs+z2ftCIG
         sswuqwONPrGYH9WX5cFXyntVEFwR5WIF+e9Id07+GoXk/409YnhesqNLV74EyKKIMcTU
         uFYkgITBO/pcxVZQASbACetMQa4EKtUTZKRPx17USBhnezsIxM3kPCNespACcmE+6e/l
         9ZZAYE3UabMavVRw1YtWMcIvspA11yG/h+ReusVI/enbX337TncSZ5jc0yNC6A3Y5Afq
         U0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sVB2ZNCIC2yUsn0H9I4h+ZJh2Im2Ue0nLn/PAnAq2D0=;
        b=Gdw6nAOx/PLJ6vt+x37cMXI17nPzy9CLA7tXSWjBXEg2qKN6V/EWrfoXx0THuPSKhj
         Eimxd5/F0jxZavxA+n1fsDy/kj8UERHk2G9Vk4h9KW7tRuPBoawVXuES2lWaff/XOFE4
         bVntR5yb4GdVw6/fvf43LB0newLHWGcWd0B9A5Q+LXJ/NcRqYJWcRRirkKV7mukni1IB
         II+cv4LLtbbGJVKUxC9U/D71XWe2lmIdfpFogK4B98JsW/A865mQGDUEG3RUGB4xI3g7
         QUy/nW6jIVj9BM6+5pzIdyk7Y1xccxSEdyfg1/ck4zjqLQ8qIf2CALuNsoAgUddbH0Ua
         isCA==
X-Gm-Message-State: AOAM5328OE+xD+KDbN/e+eypE4e2IyYT7wixLm2y33HBt2TDoMrsf19g
        b9NIvW4ps9+/hc9xxK7vXmY=
X-Google-Smtp-Source: ABdhPJyyZ0u+7eIRSPVW8pRm/BEfTwTeoFWntn0nI9874ip67PMdWg+sVFsVkKbB7b+DinmvicRaDg==
X-Received: by 2002:a17:90b:815:: with SMTP id bk21mr5208946pjb.57.1601682479822;
        Fri, 02 Oct 2020 16:47:59 -0700 (PDT)
Received: from syed.domain.name ([103.201.127.75])
        by smtp.gmail.com with ESMTPSA id j11sm2596804pji.31.2020.10.02.16.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:47:59 -0700 (PDT)
Date:   Sat, 3 Oct 2020 05:17:42 +0530
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
Subject: [PATCH v10 0/4] Introduce the for_each_set_clump macro
Message-ID: <cover.1601679791.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Linus,

Since this patchset primarily affects GPIO drivers, would you like
to pick it up through your GPIO tree?

This patchset introduces a new generic version of for_each_set_clump. 
The previous version of for_each_set_clump8 used a fixed size 8-bit
clump, but the new generic version can work with clump of any size but
less than or equal to BITS_PER_LONG. The patchset utilizes the new macro 
in several GPIO drivers.

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
 drivers/gpio/gpio-xilinx.c        |  66 +++++++-------
 include/asm-generic/bitops/find.h |  19 ++++
 include/linux/bitmap.h            |  61 +++++++++++++
 include/linux/bitops.h            |  13 +++
 lib/find_bit.c                    |  14 +++
 lib/test_bitmap.c                 | 144 ++++++++++++++++++++++++++++++
 7 files changed, 291 insertions(+), 37 deletions(-)


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.26.2

