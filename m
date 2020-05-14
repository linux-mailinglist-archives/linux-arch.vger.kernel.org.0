Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454F31D4190
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 01:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgENXQ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 May 2020 19:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbgENXQZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 19:16:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F1C061A0C;
        Thu, 14 May 2020 16:16:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so57366pfx.7;
        Thu, 14 May 2020 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/+eJp01tcGIi1FS6nFoffCHP/3vMG+E9qZfC/akFkdg=;
        b=DcMY/BwGW9Ui9hS5lf+6zAGj+OmK2cB2fnuNjh62obBQ8tM0MRuSOYJ+fncTgpIzjl
         Fr+G43Ze3vE389xISo74EvA5+F+pwxdq08UOHL93AoQVJdRseYr71wLDSffjOCejHxOw
         sDUEWQJaYfVGt1pPvT5UhdNq5b5EWWJT/dYV39X3soljP5oukSwuraLSZhNMgD8gT36O
         0WY12k7mzMgqL4i7LU2CROOvdP9Z4u4fVAPH0G8g5zT2l+dEtVq0T1+UQQwHYSHwXwmY
         PddE82IB1dy4WSCzikNexASjizHGyyXjKkSKQBK6Yi7BCXESMSIB5m833S0uF/PqqNEl
         vzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/+eJp01tcGIi1FS6nFoffCHP/3vMG+E9qZfC/akFkdg=;
        b=fN2mwNfRXOLbBbXHyJKasdooL0v4wzNDdfoLida50w3Oi72d8+Ahgt9znwcaVKmvJ+
         TtKqFtLoSsgNzSomzEkVBatSNrVrKQi4u3gnKLHzwIh9tTk1GVe4b0/mlCPJx1WiI2s6
         ND3EejEyu0Y1quDRMpyUe66RwtAmb4IgDGwPvlUlP05PKD5HlKfzkCjHyogWNGWNcV/S
         I9Mm6BMg3VYD7SZM5lcI9SurNWYWz4EoBR6vVqYPg+WrQs6kjfYHz2GEfDrFX8X1Qjq4
         +ghZsMukrAB1kytCSxn1de6hjW1E88M9MmHZZWjSYcgWbUBkuNagjpQo1odedv9E+Gx1
         Zs9Q==
X-Gm-Message-State: AOAM533tKT2BFNTGbRF/v83nM64+SoEQFY3O+9J/KOlZ+BAq6x4SOcbH
        2pTcXBCUzckHn+6d6ULPCV0=
X-Google-Smtp-Source: ABdhPJwRRq+bL5xaxHN1P6mCwtKSPR/WiDUgW/JFP+3vWldtyl1raVdBJTKBlG9MkAPg1TEaxdcXGg==
X-Received: by 2002:a63:5026:: with SMTP id e38mr430641pgb.149.1589498185092;
        Thu, 14 May 2020 16:16:25 -0700 (PDT)
Received: from syed ([106.223.1.212])
        by smtp.gmail.com with ESMTPSA id t14sm231437pgr.61.2020.05.14.16.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 16:16:24 -0700 (PDT)
Date:   Fri, 15 May 2020 04:46:03 +0530
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
Subject: [PATCH v6 0/4] Introduce the for_each_set_clump macro
Message-ID: <cover.1589497311.git.syednwaris@gmail.com>
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
  bitops: Introduce the the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize for_each_set_clump macro

 drivers/gpio/gpio-thunderx.c      |  11 ++-
 drivers/gpio/gpio-xilinx.c        |  62 ++++++-------
 include/asm-generic/bitops/find.h |  19 ++++
 include/linux/bitmap.h            |  61 +++++++++++++
 include/linux/bitops.h            |  13 +++
 lib/find_bit.c                    |  14 +++
 lib/test_bitmap.c                 | 142 ++++++++++++++++++++++++++++++
 7 files changed, 288 insertions(+), 34 deletions(-)


base-commit: 5f458e572071a54841b93f41e25fbe8ded82df79
-- 
2.26.2

