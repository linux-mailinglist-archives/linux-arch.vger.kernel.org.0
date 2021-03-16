Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E633CB04
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhCPByc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhCPBya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CBC061756;
        Mon, 15 Mar 2021 18:54:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m186so17164962qke.12;
        Mon, 15 Mar 2021 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRrxGQOEvm+/qrHASsf/SSlT9PdWhy6EY9fxf2NvOu8=;
        b=G+2o1OZ1MsI8iRpV1SeE5skr4iOeVuLtUmY2erOFTsPPMX+nve/JlUBPWOJZQgab9M
         hBpHUQIGgSHMAmVJ6YcJuS47G6c6BZA3mW6ZDS7c1mYMSwGr+8regxHvJ7Dw8vxXaGSi
         9OO+4tEgMi1KPt4Eb9nCtrmrXgH0/gr//G7kDCZkVy7b1667WN5RbMN3PmavhKnQ4ArU
         mrnS81tOgR513nspmzGd6IYiF21LiZv8+BsT3eIGR8M7IrP2dze4ObQanO4J6cJwds5W
         T0FF+nH1g5GrnNOzklaYhDBNuTCVfsnTTpouaHF69sNW0mr+piyB8YL/G5Pc0riTO2X5
         9zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRrxGQOEvm+/qrHASsf/SSlT9PdWhy6EY9fxf2NvOu8=;
        b=lNzWdAuUdS7u7NZ4KThRH3F4CXJrvIBPocY3ClrAqIgTjBMi7mAye+kZBkLXyepDFj
         KHoCGUVImxy0Qt1VuT92+qMEcGDSbEYQu0LPLOfTB7MtqLMf7nNyVJ1LeXX9JPG1CThL
         96ezoKFpYokI4hkDKXkkOsT878LhjraOx14TcMkT+BG5Clxb2HZdAjTybuaFTbNM8Nfi
         GKisy41685BbQ13IVWhLXMJolJX4WinQWeNHpAkqcs+GYxCMwkMe8t3KCSonVerAxooH
         zH7hVDfbEXMmcicI8o9T7/XOPUYL7flFeTmmPcRbU7bM/PqkDPRvovRvFpPzUCRPfDOv
         Y23Q==
X-Gm-Message-State: AOAM530SQj4PgNGDsF+nrnjckzdjJkNNNLcoEliWvSl4SQ40NdmAZcE8
        ZzKQ8nJ4A2u5WXqvxUsw5cf1ioTTbCw=
X-Google-Smtp-Source: ABdhPJzCaDNSlwkmiZ9WgCW+TTPmrecogVjoyOnn9rGSp0DPSAaxfU8YRYYMYsrW4+k/TO1pl5Lo5g==
X-Received: by 2002:a37:c441:: with SMTP id h1mr28347436qkm.123.1615859668840;
        Mon, 15 Mar 2021 18:54:28 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id i25sm3747177qka.38.2021.03.15.18.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:28 -0700 (PDT)
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
Subject: [PATCH v4 00/13] lib/find_bit: fast path for small bitmaps
Date:   Mon, 15 Mar 2021 18:54:11 -0700
Message-Id: <20210316015424.1999082-1-yury.norov@gmail.com>
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

v1: https://www.spinics.net/lists/kernel/msg3804727.html
v2: https://www.spinics.net/lists/linux-m68k/msg16945.html
v3: https://www.spinics.net/lists/kernel/msg3837020.html
v4: - move le.h header together with find.h for m68 and sh;
    - preserve small_const_nbits() macro;
    - drop FAST_PATH config option as this series doesn't increase .text,
      instead, it compacts it;
    - add Andy and Rasmus as reviewers of BITMAP API.

Yury Norov (13):
  tools: disable -Wno-type-limits
  tools: bitmap: sync function declarations with the kernel
  arch: rearrange headers inclusion order in asm/bitops for m68k and sh
  lib: introduce BITS_{FIRST,LAST} macro
  tools: sync BITS_MASK macros with the kernel
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
 include/asm-generic/bitsperlong.h       |   9 ++
 include/linux/bitmap.h                  |  30 +++----
 include/linux/bitops.h                  |  12 ---
 include/linux/bits.h                    |   6 ++
 include/linux/cpumask.h                 |   8 +-
 include/linux/netdev_features.h         |   2 +-
 include/linux/nodemask.h                |   2 +-
 lib/bitmap.c                            |  26 +++---
 lib/find_bit.c                          |  72 +++-------------
 lib/genalloc.c                          |   8 +-
 tools/include/asm-generic/bitops/find.h |  85 +++++++++++++++++--
 tools/include/asm-generic/bitsperlong.h |   3 +
 tools/include/linux/bitmap.h            |  31 +++----
 tools/include/linux/bits.h              |   6 ++
 tools/lib/bitmap.c                      |  10 +--
 tools/lib/find_bit.c                    |  56 +++++-------
 tools/scripts/Makefile.include          |   1 +
 tools/testing/radix-tree/bitmap.c       |   4 +-
 23 files changed, 340 insertions(+), 204 deletions(-)

-- 
2.25.1

