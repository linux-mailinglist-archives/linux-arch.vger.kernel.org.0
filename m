Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980C32FB01
	for <lists+linux-arch@lfdr.de>; Sat,  6 Mar 2021 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCFOBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 09:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhCFOBV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Mar 2021 09:01:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A33C06174A;
        Sat,  6 Mar 2021 06:01:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so3316527pgl.10;
        Sat, 06 Mar 2021 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=chheps0e/vkn5whvXUYRVcoclWLVpyXMSnpK+Mnd1r0=;
        b=cfp63Hxx46c6zic3FfyNgIQly3oNLnJ96rxa+H0pnMq0HhNcYM18qlNnTswLjczPnm
         6+RR6ci2RHA1ETpa33jKIPAsCh5xhbafWtzZDZV2h5j6oD5Zh8qXzhn7gBp/TMC2BzSy
         wfqLenyz1VL6WMF6VeD/8G7tHUCdlFmv9GsBdzmQ/3X9m5R6ZAhIbvaWEGzfhsDbZBRQ
         xymI7D9b/OXORqP3UfHCDwdiBc2hTIYuSLupVjgcZWnZDcpf9HuNDghwmZKYu2Egmi6J
         aYlCGttVAawoS28KYkdSHa9z94jiwrsTKqIoJlaqWJ1iD7A7jHnx8qiGhex4uF8r5RTl
         xEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=chheps0e/vkn5whvXUYRVcoclWLVpyXMSnpK+Mnd1r0=;
        b=D92/nVwLm+/yU8ZiwVz4U6QJnwO9lw6oRTuU1niK+BgXDf5A1YxYOWR4DgVaLkP8Qx
         b5n+w+Q3rDuCZY+/XjI0muVynewzxGq3ZI1Hm+XOHUPedR2TgUs+k9DE2q5oA7oRIizr
         Ri0rRxM3yZ9AEj3Sq/dbGTPoapB9tpHU/kFw90b10UqeeqVIqXyhGLpX0M7X8u+EKcn0
         hZmvtcZyG7qOeEDy8El2CLxBp5Efp5EEmGEqnl81X2ovfrMPPqup33PXn7MYBzMNMRQb
         yJTUZPBb5+h6HjEertd2J1R35lTR4bkRoCZ6djvod4/bF9yvr5hpR7Z5NQr6i97OXNYL
         myXA==
X-Gm-Message-State: AOAM533v9a2o7CMjHBGQ6YnXBZeadGrUDkV5Nhe/EXUTYUapoD5HpOMF
        td1CaIMqCyNLHS2EjGH8Jeo2AD1WV4MvZQ==
X-Google-Smtp-Source: ABdhPJxdgYi758gUMmpnWluXLNY1UAjjimJmTvzZihGzR1v6wMywJxu6+6BuBMHexeHInOaL6B/EWg==
X-Received: by 2002:a05:6a00:884:b029:1b4:440f:bce7 with SMTP id q4-20020a056a000884b02901b4440fbce7mr14127569pfj.20.1615039281113;
        Sat, 06 Mar 2021 06:01:21 -0800 (PST)
Received: from syed.domain.name ([103.201.127.38])
        by smtp.gmail.com with ESMTPSA id x11sm5343990pja.46.2021.03.06.06.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Mar 2021 06:01:20 -0800 (PST)
Date:   Sat, 6 Mar 2021 19:31:02 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     bgolaszewski@baylibre.com
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] Introduce the for_each_set_nbits macro
Message-ID: <cover.1615038553.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Bartosz,

Since this patchset primarily affects GPIO drivers, would you like
to pick it up through your GPIO tree?

This patchset introduces a new generic version of for_each_set_nbits.
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

But with the new for_each_set_nbits the clump size can be different from 8 bits.
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

Different iterations of for_each_set_nbits:-
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

Different iterations of for_each_set_nbits:
'offset' is the bit position and 'clump' is the 6 bit clump from the
above bitmap.
Iteration first:        offset: 6 clump: 0x2b
Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
Here 6 * 3 is clump size * no. of clumps.

Changes in v3:
 - [Patch 1/3]: Rename for_each_set_clump to for_each_set_nbits.
 - [Patch 1/3]: Shift function definitions outside 'ifdef CONFIG_DEBUG_FS'
   macro guard to resolve build (linking) error in xilinx Patch[3/3].
 - [Patch 2/3]: Rename for_each_set_clump to for_each_set_nbits.

Changes in v2:
 - [Patch 1/3]: Shift the macros and related functions to gpiolib inside
   gpio/. Reduce the visibilty of 'for_each_set_clump' to gpio.
 - [Patch 1/3]: Remove __builtin_unreachable and simply use return
   statement.
 - Remove tests from lib/test_bitmap.c as 'for_each_set_clump' is
   now localised inside gpio/ only.

Syed Nayyar Waris (3):
  gpiolib: Introduce the for_each_set_nbits macro
  gpio: thunderx: Utilize for_each_set_nbits macro
  gpio: xilinx: Utilize generic bitmap_get_value and _set_value

 drivers/gpio/gpio-thunderx.c | 13 ++++--
 drivers/gpio/gpio-xilinx.c   | 63 ++++++++++++-------------
 drivers/gpio/gpiolib.c       | 90 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h       | 28 +++++++++++
 4 files changed, 158 insertions(+), 36 deletions(-)


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.29.0

