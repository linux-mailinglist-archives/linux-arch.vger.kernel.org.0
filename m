Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBC1B88AE
	for <lists+linux-arch@lfdr.de>; Sat, 25 Apr 2020 21:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDYTAK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Apr 2020 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgDYTAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Apr 2020 15:00:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71CC09B04D;
        Sat, 25 Apr 2020 12:00:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so5332097pjt.4;
        Sat, 25 Apr 2020 12:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mHbZ4xPUa2e8Z9ySz/Reqmt5mff2C3fDEKHsxtsl+2U=;
        b=lD9oBsew9gmagpFSaBbrod7+Dg6O9/fj1ury4cFPHeDkSTIIemQazMeG1h6gxz5EEr
         2y0ubQjNt36fCEMrU7x/WFUDCndf+PIC5Igp9MPgFWwzQ/zFsxawUkVO8ZnaS+Z9YaUD
         nPKf3pQp2ldfgUeqMXvaMyTHWs2iHo5ucqNdYU6MaSR+HcJq2/kDNyMKBu/e1Rb1Qsx7
         Se9DN2GxojvPH2uzP07yA+icrTDtCnWluCtXcZFIQgjB2TV9gA5wq3u6mVvl6xEtkiQ5
         jPSg9S0merRNcSahaBqYqGMz8tfQEJ0xghRzjzTMoSC/f7bWSAF6aWWUTRg2YFMpePvD
         I2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mHbZ4xPUa2e8Z9ySz/Reqmt5mff2C3fDEKHsxtsl+2U=;
        b=SthF24jShzEyXVIjfNRQWBtZdJv/YBuElo1Etmn3v9bManWIeUHe/50fEbv4KvPhiW
         DW0XvDms65ldQqevC4T31U8SomMjBclFiR/PYHeUzL6OUBCTeAm3hOfqKGau8TfLtnR3
         Mwk2SmHW9u5PGqxByOooiuguaH6HaDJsGRC6HBLsj3Q+vc3NgwKn0s1fz7xU2xqOnQTg
         kBjUx07ym/8xMpQ1/PHl1Ml3AHzM6OQahVaw6Q9vnUp/nXIC/P9cPqIl9EwIc+ALJAQ4
         RIGiW+38aV3haZ5zsqr/ROuDBO3Rnvwe/ic9yNojPNn240M6so8GyLm/Fj/L5IkCl+iP
         G9bw==
X-Gm-Message-State: AGi0PuYjUU5pRjqYzO3nJVUS/dOEpy4e32d3rPBZiUm2OXARXplbwibQ
        6r+5F5BlcnctP3zSdkXF/Tg=
X-Google-Smtp-Source: APiQypLqZB8c/0OOLESufN7X24rZd9dVPY3QUBPGYqD1m6YtzXJwbEzRVL9gYijJiRQav0HHP9rS2g==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr13624264pjp.75.1587841209653;
        Sat, 25 Apr 2020 12:00:09 -0700 (PDT)
Received: from syed ([106.223.101.50])
        by smtp.gmail.com with ESMTPSA id ie17sm7574431pjb.19.2020.04.25.12.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 12:00:09 -0700 (PDT)
Date:   Sun, 26 Apr 2020 00:29:59 +0530
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
Subject: [PATCH v2 0/6] Introduce the for_each_set_clump macro
Message-ID: <cover.1587840667.git.syednwaris@gmail.com>
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

Syed Nayyar Waris (6):
  bitops: Introduce the the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thermal: Utilize for_each_set_clump macro
  bitops: Remove code related to for_each_set_clump8
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize for_each_set_clump macro

 drivers/gpio/gpio-104-dio-48e.c            |   8 +--
 drivers/gpio/gpio-104-idi-48.c             |   4 +-
 drivers/gpio/gpio-74x164.c                 |   4 +-
 drivers/gpio/gpio-gpio-mm.c                |   8 +--
 drivers/gpio/gpio-max3191x.c               |   4 +-
 drivers/gpio/gpio-pca953x.c                |   4 +-
 drivers/gpio/gpio-pci-idio-16.c            |   8 +--
 drivers/gpio/gpio-pcie-idio-24.c           |   8 +--
 drivers/gpio/gpio-pisosr.c                 |   4 +-
 drivers/gpio/gpio-thunderx.c               |  12 ++--
 drivers/gpio/gpio-uniphier.c               |   4 +-
 drivers/gpio/gpio-ws16c48.c                |   8 +--
 drivers/gpio/gpio-xilinx.c                 |  64 +++++++++--------
 drivers/thermal/intel/intel_soc_dts_iosf.c |   6 +-
 include/asm-generic/bitops/find.h          |  12 ++--
 include/linux/bitmap.h                     |  60 +++++++++++-----
 include/linux/bitops.h                     |   9 +--
 lib/find_bit.c                             |  12 ++--
 lib/test_bitmap.c                          | 108 ++++++++++++++++++++++-------
 19 files changed, 220 insertions(+), 127 deletions(-)

-- 
2.7.4

