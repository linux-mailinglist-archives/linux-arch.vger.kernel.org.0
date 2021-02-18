Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD431E4E0
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBREGF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhBREF5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:05:57 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26D4C061756;
        Wed, 17 Feb 2021 20:05:16 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e11so534398qtg.6;
        Wed, 17 Feb 2021 20:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Anw9cEcn1eDvMf97OuUTfQWEQYyRaeSoAqep/Q3hH3A=;
        b=MC2cYL7V1Y93aG+3eIujXEq/cECpUkkWjzZh1DWxkbV6PPDmuMzkUa1y83FwKTJ7A0
         sOvCXq0OqzD2/pj5hEqmNFpDWaCbPLZx1nQa5KTZ8xPd5Sja+WQ79oIPzgZMdEKDkylX
         wxffJbL73YjRCB3W6XghnrUzm6mgodwz+P30SCTd8YvjRjSlkWrXYzSx//Pe63FBrZL0
         7ZgumI6pHK0F8ORZgT5QdPXJn3Tv8tjwnwrZ2J63wLBfZ1aun00NHAghkihp4ntDeDjg
         nUAN7DvdNq2eZgK7RK+H+sb5P4pxXI+BgPBJBLUKnaJCQnkAJxlUXeAqGY6bjpDyrcm5
         2wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Anw9cEcn1eDvMf97OuUTfQWEQYyRaeSoAqep/Q3hH3A=;
        b=hhR9I5b6Po00Ms/R7HXBOhioGmNgTeYOK8PfgRQHouwfyDodbx0wLd1fE8BULQo8HP
         s52NfS/0WMeT29RTJRxIhUysDDrX/Y7W3kNNXTlkvMTnSp1a/UHVoBsV1GKhzDCMSq1u
         luS/Y2+rwox59IzPg21b2j4C+1JPe6u34iD1MG/TaZOSG3LNxUIvA48nXSXyMu+rKefQ
         c1iY79hUWPaRUhM3lpHUqPp4UoGMkwHiS2IFPu/VOUbXkRl15K2meKcycIw5BO4YxsZ6
         GP8ov7Sv4x78d9lzYPZdaSdPx7OTl0EhHqKSf7tiIWm9qPIiUcTi/jZmEKv0FZFnhgu3
         kGwA==
X-Gm-Message-State: AOAM530QryMwS8vUjNMiB+q1ABG3nELK2BJtM68ILJy8VdImRMr/rumK
        3EP9gIiNls2DBBXk4UfiTQL+VhIjzv7T2A==
X-Google-Smtp-Source: ABdhPJzWKZa3V+XRAH2TxMip8hFIPnAyTI9CntxouLiv9yLgr9nXcRQsdHmls5qcB0UACH5OJcjMSg==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr2613356qtj.181.1613621115642;
        Wed, 17 Feb 2021 20:05:15 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id x79sm3186223qka.75.2021.02.17.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:14 -0800 (PST)
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
Subject: [PATCH v3 00/14] lib/find_bit: fast path for small bitmaps
Date:   Wed, 17 Feb 2021 20:04:58 -0800
Message-Id: <20210218040512.709186-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Tools is synchronized with new implementation where needed.

v1: https://www.spinics.net/lists/kernel/msg3804727.html
v2: https://www.spinics.net/lists/linux-m68k/msg16945.html
v3: - split kernel and tools code;
    - add FAST_PATH config option;
    - add BITMAP API section to MAINTAINERS.

Yury Norov (14):
  tools: disable -Wno-type-limits
  tools: bitmap: sync function declarations with the kernel
  arch: rearrange headers inclusion order in asm/bitops for m68k and sh
  lib: introduce BITS_{FIRST,LAST} macro
  tools: sync BITS_MASK macros with the kernel
  bitsperlong.h: introduce SMALL_CONST() macro
  tools: introduce SMALL_CONST() macro
  lib/Kconfig: introduce FAST_PATH option
  lib: inline _find_next_bit() wrappers
  tools: sync find_next_bit implementation
  lib: add fast path for find_next_*_bit()
  lib: add fast path for find_first_*_bit() and find_last_bit()
  tools: sync lib/find_bit implementation
  MAINTAINERS: Add entry for the bitmap API

 MAINTAINERS                             |  14 +++
 arch/m68k/include/asm/bitops.h          |   4 +-
 arch/sh/include/asm/bitops.h            |   3 +-
 include/asm-generic/bitops/find.h       | 108 +++++++++++++++++++++---
 include/asm-generic/bitops/le.h         |  38 ++++++++-
 include/asm-generic/bitsperlong.h       |   6 ++
 include/linux/bitmap.h                  |  60 ++++++-------
 include/linux/bitops.h                  |  12 ---
 include/linux/bits.h                    |   6 ++
 include/linux/cpumask.h                 |   8 +-
 include/linux/netdev_features.h         |   2 +-
 include/linux/nodemask.h                |   2 +-
 lib/Kconfig                             |   7 ++
 lib/bitmap.c                            |  26 +++---
 lib/find_bit.c                          |  72 +++-------------
 lib/genalloc.c                          |   8 +-
 tools/include/asm-generic/bitops/find.h |  85 +++++++++++++++++--
 tools/include/asm-generic/bitsperlong.h |   2 +
 tools/include/linux/bitmap.h            |  47 ++++-------
 tools/include/linux/bits.h              |   6 ++
 tools/lib/bitmap.c                      |  10 +--
 tools/lib/find_bit.c                    |  56 +++++-------
 tools/scripts/Makefile.include          |   1 +
 tools/testing/radix-tree/bitmap.c       |   4 +-
 24 files changed, 362 insertions(+), 225 deletions(-)

-- 
2.25.1

