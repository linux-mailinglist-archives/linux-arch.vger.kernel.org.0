Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ED01C27D0
	for <lists+linux-arch@lfdr.de>; Sat,  2 May 2020 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgEBSqo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 May 2020 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728252AbgEBSqo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 May 2020 14:46:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967DC061A0C;
        Sat,  2 May 2020 11:46:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x77so3325952pfc.0;
        Sat, 02 May 2020 11:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Z78vN5IwIDEOBjHvFvanMMaxvdXgieZgp9tzVBvxq1w=;
        b=JxwCS/cwRFGADGLgRn9nQ/TUJGvZSvXNOWtBimXjtyFuvEYH92HjYPZLlInquXMzK1
         MWLBCj459O/i/GinPLfcCuwYwePvdVk7X3qgO4gUZEm0LLBRg8Ttu7NQ9SliE5hY4aTK
         AR3ygYt80nVPppJX85lQPZRDpQr+qMVnfF2XDP9L5JSHVoJuueSMjSuzbeW+a9IwPlAm
         A+JSH2u6FR0wBcczw5wo2TUD0ZSR7bGVdNYfBBsUtRJ1kpX6Aa3iMPimR2S4fHpS4bBL
         H6XsSHGad3d61bTaeEpA3U5Lg7ORAMX46kwagH+R4TVk8ACI6dTpfVyfbw6JCudDE8tB
         WFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z78vN5IwIDEOBjHvFvanMMaxvdXgieZgp9tzVBvxq1w=;
        b=KeUxrg44Q7I1/CaiT9+9P0EbGqfW9gypw2hHwcSeZOHFbD/UC0fhIRe3/Lr+GKDbSK
         KuuWfO/N9IEYwHFHRmoiRru2yJZ+DsUETrxvxNkLDia82Y+E77EL5kO2GNR2puAR4FOg
         wjkWBJ5VKaeTiJs3zP6GKBQm+kaafA5kEurxJPVGo9lmQAJ5KKk2hyGFHSS9/isWc7+E
         vg6KiwEB/l1uFYPNT2qvhyLC8ftLhvCk9wDzQD66Ts87bgWjOcyxpCqQMNZMGy86gnbM
         ehfQtILBcOSCRDMlQU4/wtz+6plt3RW/8AG92uqgOhA9y7511N+jfmPsCufkEG6WjZ1l
         nEUQ==
X-Gm-Message-State: AGi0PuZwSR8Gy9zHxCUYtYS17FPAL2y+IfIIFI/pb5jnpNRboFFIjTkK
        KhSQEdVrGgOgU5MBeMbFS9EPxQh+
X-Google-Smtp-Source: APiQypLOEsxO67OGD+s+uZ2cICXF6LY/KXsmotyfXsCVDQOLVcRTySCMQaF7ybZzzS7pindFw5X8zw==
X-Received: by 2002:a63:4c08:: with SMTP id z8mr9581251pga.175.1588445203752;
        Sat, 02 May 2020 11:46:43 -0700 (PDT)
Received: from syed ([106.210.101.167])
        by smtp.gmail.com with ESMTPSA id u5sm4577784pgi.70.2020.05.02.11.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 11:46:43 -0700 (PDT)
Date:   Sun, 3 May 2020 00:16:24 +0530
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
Subject: [PATCH v4 0/4] Introduce the for_each_set_clump macro
Message-ID: <cover.1588443578.git.syednwaris@gmail.com>
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

Changes in v4:
 - [Patch 2/4]: Use 'for' loop in test function of for_each_set_clump.
 - [Patch 3/4]: Minor change: Hardcode value for better code readability.
 - [Patch 4/4]: Minor change: Hardcode value for better code readability.

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
 drivers/gpio/gpio-xilinx.c        |  64 +++++++-------
 include/asm-generic/bitops/find.h |  19 ++++
 include/linux/bitmap.h            |  61 +++++++++++++
 include/linux/bitops.h            |  13 +++
 lib/find_bit.c                    |  14 +++
 lib/test_bitmap.c                 | 141 ++++++++++++++++++++++++++++++
 7 files changed, 289 insertions(+), 34 deletions(-)


base-commit: 25c04a75f14fdc074d7dd1d6d40b49eddd0e66e7
-- 
2.26.2

