Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4F2E2D73
	for <lists+linux-arch@lfdr.de>; Sat, 26 Dec 2020 07:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLZGmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Dec 2020 01:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgLZGmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2020 01:42:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1ADC061757;
        Fri, 25 Dec 2020 22:41:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q22so3468208pfk.12;
        Fri, 25 Dec 2020 22:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+Zz2ASXn2o1AAzNUsSqx+OfWOMVjrvSh/KaatXZVe1E=;
        b=Zccd4ckmnwoGwoJssq58yRMJlLCGNmgWKNNLNjPKTx3E17zvDtnuw7ilNjlBxNdrb1
         qerj6rEtAE36abDCvqNWbiBN4PGhCbF9gYAHvwLWAarZWV2yWtrkAbfwy6bvczTs+cU1
         oxZLn9yYTPfTetbf6NTfTm25aLlq0nw4MYlAWhMQ9vBVaHn3XCM2jzREW+f+ue9C1kE1
         Itsjgn3yOWpBFoQ3SMaTelD8wQUxjd8i5Qup82bvW20ZGgkiEbjvMjoSiZ1JzLccNYyY
         oRa9db2gXY4ED0ytu8bH+R97APnOhhrv05pSSk01QrZr6GJMB4PtmZRjCXTnl7Lw2c8U
         xMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+Zz2ASXn2o1AAzNUsSqx+OfWOMVjrvSh/KaatXZVe1E=;
        b=bkO3mPmV25MDLX2ch027WUxlULgn/FyWNYoQfzAAx7mItuWxW0AaUodZRWD9raf7h5
         am1/T1j/zsDOGEYFF1yh0a5cdwkqSzXvOjOdMuQnEGYwHahvZ3c5UkMU4QPUtXx/FhpY
         nhocYOcg1VuqPqBud4DbtzrK5iSoA8V9CxjriWxhCEn4ZdpBefCVssIX3dS8ZZxpe8VT
         PHKOjx+i1VqqtwPsVV7Unn7EhH0VloDqFVDJHojle2vZxd6LJQ4FExwXS3Pchob5xD/b
         4S1xlR8BZhJY2BJpW0dBX9s/KXdPYsXkKv1S/ibi70YICe4eZ3C1gVV+2oyG9fU2WoHJ
         7yYQ==
X-Gm-Message-State: AOAM530JZ2Rxi6PJvANwKIgNdmyL3bSWnDSSdzaxSD7zw/ykHqHEs7XH
        cXsWwBQwpJmqpDjIWd/i+Bk=
X-Google-Smtp-Source: ABdhPJxplND6wyf4phagc3MU2/poQTo714TNFqVHAG10cwXZBfUhioXwtZNEbctnfmqiAKSxLgpNMg==
X-Received: by 2002:a62:c312:0:b029:1a9:19c7:a8e with SMTP id v18-20020a62c3120000b02901a919c70a8emr33462581pfg.74.1608964909710;
        Fri, 25 Dec 2020 22:41:49 -0800 (PST)
Received: from syed.domain.name ([103.201.127.53])
        by smtp.gmail.com with ESMTPSA id x7sm12250703pga.0.2020.12.25.22.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 22:41:49 -0800 (PST)
Date:   Sat, 26 Dec 2020 12:11:33 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/5] Introduce the for_each_set_clump macro
Message-ID: <cover.1608963094.git.syednwaris@gmail.com>
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

(Note: Patchset resent with the new macro and relevant
functions shifted to a new header clump_bits.h [Linus Torvalds])

Michal,
What do you think of [PATCH 5/5]? Is the conditional check needed? And
also does returning -EINVAL look good?

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

GCC gives warning in bitmap_set_value(): https://godbolt.org/z/rjx34r
Add explicit check to see if the value being written into the bitmap
does not fall outside the bitmap.
The situation that it is falling outside would never be possible in the
code because the boundaries are required to be correct before the
function is called. The responsibility is on the caller for ensuring the
boundaries are correct.
The code change is simply to silence the GCC warning messages
because GCC is not aware that the boundaries have already been checked.
As such, we're better off using __builtin_unreachable() here because we
can avoid the latency of the conditional check entirely.

Syed Nayyar Waris (5):
  clump_bits: Introduce the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize generic bitmap_get_value and _set_value
  gpio: xilinx: Add extra check if sum of widths exceed 64

 drivers/gpio/clump_bits.h    | 101 ++++++++++++++++++++++++
 drivers/gpio/gpio-thunderx.c |  12 ++-
 drivers/gpio/gpio-xilinx.c   |  72 ++++++++++--------
 lib/test_bitmap.c            | 144 +++++++++++++++++++++++++++++++++++
 4 files changed, 292 insertions(+), 37 deletions(-)
 create mode 100644 drivers/gpio/clump_bits.h


base-commit: bbe2ba04c5a92a49db8a42c850a5a2f6481e47eb
-- 
2.29.0

