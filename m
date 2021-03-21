Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A036B343517
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhCUVzf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhCUVzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776EC061762;
        Sun, 21 Mar 2021 14:55:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s2so11007021qtx.10;
        Sun, 21 Mar 2021 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGGguKzNak6Uoi+lTdEQVN7MNykqtu7qxWcIlRIb74o=;
        b=rMLzOMxLuXQEi3UHBZcUeZZxAWgMP0tOvnatwVNMbcZkdF2ORgrZgH3ZL4KNV7Sfn4
         KfWxYK/dna0/kia7D+wGozOpyo3lwvUyEhnn1qztWtjOsdQwHPGcKUZuukZwI/G0WXeD
         H0+zIPMjQKpNs4mIew98JUFj3lXIhx7K6KCPJz/tdFVVVVufGDH/2zqyBcG7Q62G3yBX
         rwd550XXYCG2lGVS+AgtJu/4r6bTB968vDZNnXpn79QblaARrOyA5LRW6WfOaAGbqCqW
         2XsXYXN81PKoq7rxj1rY9T+IAS4D+szI2qs9BsW2Xxc6WISFmVYjQ3h/tmDUsjL4UUZ2
         VXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGGguKzNak6Uoi+lTdEQVN7MNykqtu7qxWcIlRIb74o=;
        b=UY+t4jGr3aD7rloeIE5w4U4oyXgxwXntynAsk3Ye2dMplQJdd4RFVJfpFHDq3u09PR
         fmb4rNWhTJZRXFuHuTvjvy/4T6/sJ0MGESBo4Gvi5mLPUx7s6PcIeW/kP07eOn25I1q9
         vFjrufG/cfeXb5HWBOiBFEVPundDhbIdxBlJzF7RCknO8WvdCaJHH6tFrs2YA0s7hbgs
         zCjAsA5fLcgqVWAGELR5MaZTiLFARN4cq9GJ2bR+xsXT5Hj9jnQz4BwlfobGW9hNR/zR
         k8Zqmt8Tp6/ahtbhBgARebl3tvmHuNQL0BWZjU9wwgljqkWswGzBJ65PRvEjex8rC6Pj
         0yHg==
X-Gm-Message-State: AOAM532ndpO3bklVOrh/ruk6ADs7gBVN6IBV2F1Ydb9/NZbn58XtpfrF
        lMeHkf+tTbwcqR1edCqwOYRNN0+4e1s=
X-Google-Smtp-Source: ABdhPJwMBGjc3F8XwcbsAX31INg7pNJB1AE2nrf7PzUnb0oZYb2TsEmvuHoF4FkbohehMt9ldfnvFA==
X-Received: by 2002:ac8:6044:: with SMTP id k4mr7282617qtm.4.1616363700246;
        Sun, 21 Mar 2021 14:55:00 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id k7sm7760220qtm.10.2021.03.21.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:54:59 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v5 00/12] lib/find_bit: fast path for small bitmaps
Date:   Sun, 21 Mar 2021 14:54:45 -0700
Message-Id: <20210321215457.588554-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bitmap operations are much simpler and faster in case of small bitmaps
which fit into a single word. In linux/bitmap.c we have a machinery that
allows compiler to replace actual function call with a few instructions
if bitmaps passed into the function are small and their size is known at
compile time.

find_*_bit() API lacks this functionality; but users will benefit from it
a lot. One important example is cpumask subsystem when
NR_CPUS <= BITS_PER_LONG.

v1: https://www.spinics.net/lists/kernel/msg3804727.html
v2: https://www.spinics.net/lists/linux-m68k/msg16945.html
v3: https://www.spinics.net/lists/kernel/msg3837020.html
v4: https://patchwork.kernel.org/project/linux-sh/cover/20210316015424.1999082-1-yury.norov@gmail.com/
v5: - drop BITS_{FIRST,LAST} patch;
    - minor changes.

Yury Norov (12):
  tools: disable -Wno-type-limits
  tools: bitmap: sync function declarations with the kernel
  tools: sync BITMAP_LAST_WORD_MASK() macro with the kernel
  arch: rearrange headers inclusion order in asm/bitops for m68k and sh
  lib: extend the scope of small_const_nbits() macro
  tools: sync small_const_nbits() macro with the kernel
  lib: inline _find_next_bit() wrappers
  tools: sync find_next_bit implementation
  lib: add fast path for find_next_*_bit()
  lib: add fast path for find_first_*_bit() and find_last_bit()
  tools: sync lib/find_bit implementation
  MAINTAINERS: Add entry for the bitmap API

 MAINTAINERS                             |  16 ++++
 arch/m68k/include/asm/bitops.h          |   6 +-
 arch/sh/include/asm/bitops.h            |   5 +-
 include/asm-generic/bitops/find.h       | 108 +++++++++++++++++++++---
 include/asm-generic/bitops/le.h         |  38 ++++++++-
 include/asm-generic/bitsperlong.h       |  12 +++
 include/linux/bitmap.h                  |   8 --
 include/linux/bitops.h                  |  12 ---
 lib/find_bit.c                          |  68 ++-------------
 tools/include/asm-generic/bitops/find.h |  85 +++++++++++++++++--
 tools/include/asm-generic/bitsperlong.h |   3 +
 tools/include/linux/bitmap.h            |  18 ++--
 tools/lib/bitmap.c                      |   4 +-
 tools/lib/find_bit.c                    |  56 +++++-------
 tools/scripts/Makefile.include          |   1 +
 15 files changed, 284 insertions(+), 156 deletions(-)

-- 
2.25.1

