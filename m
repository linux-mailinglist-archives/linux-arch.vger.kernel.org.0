Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6927835298B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKLF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBKLE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 06:11:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D7C0613E6;
        Fri,  2 Apr 2021 03:11:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so2360098pjg.5;
        Fri, 02 Apr 2021 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gPxPlJkhjlRcmhG+AYGmsIcUB9lxV1Qy07Ql0LeH3zw=;
        b=ftm6H1yakWnWGqrjXFE0PlTo+DKAxkT7NH5rBLt8f9t7BRqm++64+4C7pOOwp4GZzn
         3Ay9V5knEczFP6x0D+kHKSJ5risO8x2g4YDwdkMMRpUyDJX3sLa0weEB2VwCK5/WJzXo
         waAawhBnmQAgWC91ht6Iz8NiMPfpwvg2d02/3gAYroBFssSL4X5iGWZSzIfj2Xq+oLRT
         Xq/DnxapoLtAa5+Mk9cfUQXxpUFH3Y8MZp+0KyOKyN3jq1MS0jXZ9zgDVmCYdEKrYRSw
         KJH74Yz2MQl9bGcY0ViKG7wWJbDS3CLyEtrvsD9qfkm7szghgwM8ugl4AvVLQ6wYxWr1
         L4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gPxPlJkhjlRcmhG+AYGmsIcUB9lxV1Qy07Ql0LeH3zw=;
        b=g6y7+ECrHuLhLoEsdlOdnSCXnvW/qcucfzMq2Z6OrHDDvdHHwe1sSJ3io5skT5m6Sc
         d4kFYmOkBdZlJZ7u1P+31qohTnF/i1pYuI5XwbH5QqXZGWJTLGWwmGx0UJjJkia+pQVY
         BLPmGFgjD7XLO3WExOaD3dpCog2cubVYupkvvh6IkJGz7kYfUo0SN9/hcww0lPAfvW4f
         /rVsvTLF7T7hAA05xm9xAPhicpCLyoyBSC5xcAKFHg0xmpPr15y4TLwQrm7u2rNQJB1u
         IUXY9jhHhobc2L4Q/9vxJ0XRFOhAxblcnMAvHEcXDZ0bj3u+Ju1kN6ZTQQB10UX5eZEK
         EUxg==
X-Gm-Message-State: AOAM531O/rLYb/5SD3qPJYDTgcp5+AYUNyoL5CWHSGcMiF1Sd/VFlmkN
        135BT+c9V1zbMREWpFHxZyA=
X-Google-Smtp-Source: ABdhPJzdeGGNxdrgjG8DDwsn2kc7sSYRM74Hjy2lPY1s31Z5b1en6kSkcPhTeQE/tRNtFX65O4DDWg==
X-Received: by 2002:a17:902:dacb:b029:e5:b538:9ce6 with SMTP id q11-20020a170902dacbb02900e5b5389ce6mr12107281plx.8.1617358262564;
        Fri, 02 Apr 2021 03:11:02 -0700 (PDT)
Received: from syed ([223.225.111.29])
        by smtp.gmail.com with ESMTPSA id k22sm7748079pfa.93.2021.04.02.03.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 03:11:02 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:40:44 +0530
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
Subject: [PATCH v4 0/3] Introduce the for_each_set_nbits macro
Message-ID: <cover.1617357235.git.syednwaris@gmail.com>
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

Changes in v4:
 - [Patch 3/3]: Remove extra line and add few comments.
 - [Patch 3/3]: Use single lock (and unlock) call instead of two 
   lock (and two unlock) calls.
 - [Patch 3/3]: Use bitmap_from_arr32() where applicalble.
 - [Patch 3/3]: Remove unnecessary 'const'.

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
 drivers/gpio/gpio-xilinx.c   | 60 ++++++++++++------------
 drivers/gpio/gpiolib.c       | 90 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h       | 28 +++++++++++
 4 files changed, 156 insertions(+), 35 deletions(-)


base-commit: e1b7033ecdac56c1cc4dff72d67cac25d449efc6
-- 
2.29.0

