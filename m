Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03FC352DCA
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDBQgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBQf5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 12:35:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7DCC0613E6;
        Fri,  2 Apr 2021 09:35:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x126so3888328pfc.13;
        Fri, 02 Apr 2021 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uM4dm7jLQqekDUMig2wBthP5qLW3ECK8m3uDHks54tU=;
        b=FNQ96PXqShSkb3HyAtOtQJGWzw39+nOcttjEqWqIrzW3psRSPGr4frfDPf7OHvyAbq
         ZH5f4K8PVB5UyvTz94RU2f8OqTPqF/rfAvBAIew/6CrjMw/od+skNCprbDLj/21CgAn6
         iBqthZ+MJdR2FVHarjLeqYu2BWqF9oMrI6yEv/4NjkJbn+eICignQvrfGFoLMdsxgf1l
         zoY9ylsHMnmSvuQX2CKHinXasZp5gibHqrYJ4Ns+JZC/eoCEg19F+B6xvUv2f3aiZw2h
         0s7TQJw0CU5o1tGbXk0OkItZz3IwPkbE2ezt2Kz6MIKOw/DaONOCkGRKAs6Jzqi0ovgp
         5YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uM4dm7jLQqekDUMig2wBthP5qLW3ECK8m3uDHks54tU=;
        b=EK8HVpSc6Y5/Zv2pejtMoyJom11AwxzNji2YLILQvWV/V3aHmMnIs9enQ2COY9lFh+
         /3acd29a1iPs20R97aB6SVZVSAfAajj0EKbZTDElbL2tZDKeX7CWZ1NDf2MKphVY/w8g
         4R2dRt3Zyez8NiLbk4jWwID/uLtCOKoBT9wk8YcoQcYxl5Z7sNYtNH57Q4xb/A1jAif6
         flzhUDNxApy8Tx2cmk61J+TCKTE/uI4WOibLp+7oKqkH7w7DcxTqNeU32bPwWXbjlaYU
         /A5yglZqE/ksv8ucMw7AFG40tAQ3+yPFrFk2/kzjBHOwPNw6ez/blC2jtINVEJ1g6SMO
         YjlA==
X-Gm-Message-State: AOAM533jZz5M4OHoNsnXqTAXm21tdCuxfkoVAGUtHEE41mMqLCDL9IJd
        v+6GZPIs6S165HglJOVZKyo=
X-Google-Smtp-Source: ABdhPJxlVTIcbe9PyT710PIwA5TAufhstS7k7UVKk8YGWegZt4sCcXmdZNfe1M9w9ZQCStgYZC2oJA==
X-Received: by 2002:aa7:900d:0:b029:230:2d6a:2940 with SMTP id m13-20020aa7900d0000b02902302d6a2940mr10766216pfo.23.1617381352521;
        Fri, 02 Apr 2021 09:35:52 -0700 (PDT)
Received: from syed ([223.225.109.149])
        by smtp.gmail.com with ESMTPSA id m9sm8461571pgt.65.2021.04.02.09.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 09:35:52 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:05:36 +0530
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
Subject: [RESEND PATCH v4 0/3] Introduce the for_each_set_nbits macro
Message-ID: <cover.1617380819.git.syednwaris@gmail.com>
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
 drivers/gpio/gpio-xilinx.c   | 52 ++++++++++-----------
 drivers/gpio/gpiolib.c       | 90 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h       | 28 +++++++++++
 4 files changed, 152 insertions(+), 31 deletions(-)


base-commit: e1b7033ecdac56c1cc4dff72d67cac25d449efc6
-- 
2.29.0

