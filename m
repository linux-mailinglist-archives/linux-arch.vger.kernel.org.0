Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA06A319FB5
	for <lists+linux-arch@lfdr.de>; Fri, 12 Feb 2021 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBLNU1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 08:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhBLNUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2021 08:20:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F7C061756;
        Fri, 12 Feb 2021 05:19:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl8so418684pjb.0;
        Fri, 12 Feb 2021 05:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4cqievP1oLWYJ4Ny++CVFsTeEL6uztXwZyN4nT6gCro=;
        b=o5ZQbFt3B3FNXTmRxyQrf5MaQvp1zVQr+8Ct25pANYhFgjoWEVXVvSB/sP3eFz8bRR
         +GRpVSWZZTTeAR8kL+vzT2VfOBPiEz3tEJWEZ2MbI7Z/xO7M1iEkJPw7z7SANxTNL1Lu
         p/l7Gxu5fEPPZ7VVmOIHNcWcuj0GCUyQGUn0BMUnX0LwFJNA5PdroaKS2NtNBEzInIVM
         TQImvrYekeJhPHUmYAOdxSiB6uuoqLZMyYQJacafSLCTQchn6BD5h5sQ681Uv1/kDu/k
         gtE2j8nGri1FW298EGy6ug3ATnrT2d0SwB1Lk2uZfAGcAZzxKWPj+yxYYNkQjg5bVfTQ
         Tsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4cqievP1oLWYJ4Ny++CVFsTeEL6uztXwZyN4nT6gCro=;
        b=GbvQlrmPj2KXBbhvB0oefD+M3QJk/0gDri3AWsdlVKq2+pePK0wtaWUwpgGsxjChe3
         8w5xm5yTMcs20WlmJD1p8XFPNbaOgzYVFktQwGzH07SH1SYis4yZ0jxRsLotcw04AkDg
         CUTM6F6CxcQwJ1jKI/J+s1fiM0uHYlYRc1L1Zv+fVcj2iJOBXvjfp2tfQ7km5zDv5/rF
         D2iKpJeyJERoJNhcVX9exi94xRyxnQeazpzWCerZ4tK1zVOi3UEBUxAEcPT90ZsJNGLg
         p6833ww8p6kfr9PUlr1NjOZkqkywYrJcGPMgemTD6VoKmzlGvRd+yMnsNQ65NjsJs5+4
         qE6Q==
X-Gm-Message-State: AOAM533aP4IMhWrkdtkMAOCatc6H1i/Uj5BfwpHzIrnK/USCIVctwLzK
        5mrvm7yJNz0H1elepyI2At4=
X-Google-Smtp-Source: ABdhPJw0W9r8mdFX58Wo4VzZMJed+tKGDHGxxiRlac9ze/7Q95PPuP7D90PvhGJ1KFgc0+sISreARg==
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr2763919pja.228.1613135984448;
        Fri, 12 Feb 2021 05:19:44 -0800 (PST)
Received: from syed.domain.name ([103.201.127.1])
        by smtp.gmail.com with ESMTPSA id g6sm8729106pfi.15.2021.02.12.05.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 05:19:43 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:49:28 +0530
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
Subject: [PATCH v2 0/3] Introduce the for_each_set_clump macro
Message-ID: <cover.1613134924.git.syednwaris@gmail.com>
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

Changes in v2:
 - [Patch 1/3]: Shift the macros and related functions to gpiolib inside 
   gpio/. Reduce the visibilty of 'for_each_set_clump' to gpio.
 - [Patch 1/3]: Remove __builtin_unreachable and simply use return
   statement.
 - Remove tests from lib/test_bitmap.c as 'for_each_set_clump' is
   now localised inside gpio/ only.

Syed Nayyar Waris (3):
  gpiolib: : Introduce the for_each_set_clump macro
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize generic bitmap_get_value and _set_value

 drivers/gpio/gpio-thunderx.c | 13 ++++--
 drivers/gpio/gpio-xilinx.c   | 63 ++++++++++++-------------
 drivers/gpio/gpiolib.c       | 90 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h       | 28 +++++++++++
 4 files changed, 158 insertions(+), 36 deletions(-)


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.29.0

