Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89401BD052
	for <lists+linux-arch@lfdr.de>; Wed, 29 Apr 2020 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgD1XDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 19:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1XDc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 19:03:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C4C03C1AC;
        Tue, 28 Apr 2020 16:03:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so125996pfn.3;
        Tue, 28 Apr 2020 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+eb5YBzAF98WZOyXU0W5JrcpxvfZ8QdL+rCMUNBogBs=;
        b=O/0NG8PwX3dqCAE7rfx8O3nSMOjMBNp9iVLdYyb89n+JKhHj4S3b6rT1SFs6VUg8TO
         4SCiIYfSZ1XxRzLFCdve1O7apjpLhRFTzRGSoQiEyox4wQ2taYf6FgD5ZP9Aulmwmpw8
         H3LCU/JfOKq5DOLTVpAGUwJFhmhCY+7433CAtbSBOgwP19+kmfD1LAfaID8A0zQQzVXL
         u9jslrVS/aDUNtDHHS8GyoP5fsrgudZdaV/qh91IB5uJDTiLfeWg4z4VM0hB+HUFAPbK
         F5xLvRL/ratvulf6NIij4g1JX4B3DykyWtItpjgce/1QmNaSXEfGSG1SjKPAUruI0inN
         9BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+eb5YBzAF98WZOyXU0W5JrcpxvfZ8QdL+rCMUNBogBs=;
        b=FAfMjvzQ5rE22TliDdfA0WbWxA8fPLJ2ORdxVccdim/XkNpVuU+COq8W87Cm5Vauhi
         UpKcFHXkKA95hnkf27fwDAlsM7fWY30RI6Ry6RdWotv+BFusnO5ew1cdFphht6/4D52w
         Y92htOBLakWHQkxw88gvcyfCWFKw6vJNyZWfwq53yjjYNnfs3y/ke1b+QvcS5EFBzjMK
         BtoRtBM0DI0Vg+mpAx1pHf9PI/CNkeTwks1hpvFNLKKk2pp7AZcPc6kuua1i1e1Q8ugd
         M8WitFjQr4HHPEd7Nriuhin1XgqMrl4cNoDuGaGlkFUh8sSO8SJ1cow207DnonhmdNdg
         zERg==
X-Gm-Message-State: AGi0PuZcnWKaXF8oIAuzFiWOpPhESqvDp8K355G3XmRu3Ch5KjHpru4l
        Ub1CnHpT6rWlNkI6s5TcOAA=
X-Google-Smtp-Source: APiQypJPE+cc4RU52SwdvwJv6fLg/VZd1xU0gwwQyijEzCMwU4XUhna9Mxms6HnaLfQFvRuDeLePLQ==
X-Received: by 2002:a63:f30a:: with SMTP id l10mr30917710pgh.372.1588115010795;
        Tue, 28 Apr 2020 16:03:30 -0700 (PDT)
Received: from syed ([106.202.21.137])
        by smtp.gmail.com with ESMTPSA id kb10sm3100232pjb.6.2020.04.28.16.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 16:03:30 -0700 (PDT)
Date:   Wed, 29 Apr 2020 04:33:11 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/4] Introduce the for_each_set_clump macro
Message-ID: <cover.1588112714.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

Changes in v3:
 - Patch 3: Change datatype of some variables from u64 to unsigned long
   in function thunderx_gpio_set_multiple.

CHanges in v2:
 - Patch 2: Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - Patch 2: Remove unnecessary bitmap_zero calls.

Syed Nayyar Waris (4):
  bitops: Introduce the the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize for_each_set_clump macro

 drivers/gpio/gpio-thunderx.c      |  12 ++-
 drivers/gpio/gpio-xilinx.c        |  64 ++++++++--------
 include/asm-generic/bitops/find.h |  19 +++++
 include/linux/bitmap.h            |  61 +++++++++++++++
 include/linux/bitops.h            |  13 ++++
 lib/find_bit.c                    |  14 ++++
 lib/test_bitmap.c                 | 121 ++++++++++++++++++++++++++++++
 7 files changed, 270 insertions(+), 34 deletions(-)


base-commit: a9509b8ee069a06cd14334edca904bd0607622ca
-- 
2.26.2

