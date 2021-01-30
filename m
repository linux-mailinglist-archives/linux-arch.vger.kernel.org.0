Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9412E3097E5
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhA3TSG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhA3TSD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:18:03 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41540C06174A;
        Sat, 30 Jan 2021 11:17:23 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a19so12277372qka.2;
        Sat, 30 Jan 2021 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pO8x+W3/RhKNWXLk18fJhGVEh86+dnSSlxFNL/9E6bg=;
        b=c8/10LIzopFZ08cCOs0X8BsBESmOgqd78ZrcVXmOO/X8KpG04pOrNF10tmZTaRAM9n
         QSStBpqsK2QDAV4A0NsDwobuwYbUid2VP90zYXPMN+JletPn7z8I5It/NN2/GEmupI2d
         R73exft/YmWzYXnGALNKNOUveSGS7s5r544MMd6vH/gRfNxjp5piie++DDAIiyS20bG6
         CYEfMYPcT6kTbWgoDb3SzmJdf8+V0SZmjPWuuSrdSe+4pSM5FVOt2mNbQ9U9hE3szMke
         +CB7ME7RfuW+OSDNNyABopmld9e7Fm+XqYshx+TgAb4EZunc3GVor+x8aEoWzJo63o2w
         +ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pO8x+W3/RhKNWXLk18fJhGVEh86+dnSSlxFNL/9E6bg=;
        b=SqlJSwMx+Q7cw+LqrsleaNAlJTNollmxavXDFBhuzzN1renAgVC07xbxV0d2LPlb5y
         r2zFaCYxo62wgEEI5He+YVQs+tLEdHfMfPBc/T8mlxwKIVUsUurd7QrB+Xd1ZqqaQKjo
         aWK+EgvSrgz+wIX8oZ3gWrUjJamECt60heuEeWXeZhrBf+kyAOf7pjQ7F6LkUfjS4gy0
         PeGVIvILbaeOrnZMk3kX2fmpJwJpi+F7Bcv1iFEHUSVf9XrcVVavHtPzC7PzrFx0AVKr
         AUb7HAqvtoRa/tsqj3o3vGculcUuIIfv/hdvcGqvUzlUk71bVtWZy3sBCZRfL5jXXTEZ
         s4Qw==
X-Gm-Message-State: AOAM532f8mwpUQnsuCnVMMyaHSuoGL58JMmqyHEN/afakYUVV0wIbekW
        ra296bGPYGtPDbCh3PhW8lQILbGw8R1fO/IR
X-Google-Smtp-Source: ABdhPJznYltCMER1oGMNrA8R+49lC07w5P/oIsGITAmHtHrCvZwPjN0TVvS0Ka4sb9x3uo91ppUGHA==
X-Received: by 2002:a05:620a:22ee:: with SMTP id p14mr9738753qki.466.1612034242432;
        Sat, 30 Jan 2021 11:17:22 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id d3sm6700132qkg.120.2021.01.30.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:21 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: [RESEND PATCH v2 0/6] lib/find_bit: fast path for small bitmaps
Date:   Sat, 30 Jan 2021 11:17:11 -0800
Message-Id: <20210130191719.7085-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bitmap operations are much simpler and faster in case of small bitmaps
which fit into a single word. In linux/bitmap.h we have a machinery that
allows compiler to replace actual function call with a few instructions
if bitmaps passed into the function are small and their size is known at
compile time.

find_*_bit() API lacks this functionality; despite users will benefit from
it a lot. One important example is cpumask subsystem when
NR_CPUS <= BITS_PER_LONG. In the very best case, the compiler may replace
a find_*_bit() call for such a bitmap with a single ffs or ffz instruction.

Tools is synchronized with new implementation where needed.

v1: https://www.spinics.net/lists/kernel/msg3804727.html
v2: - employ GENMASK() for bitmaps;
    - unify find_bit inliners in;
    - address comments to v1;



Yury Norov (8):
  tools: disable -Wno-type-limits
  tools: bitmap: sync function declarations with linux kernel
  arch: rearrange headers inclusion order in asm/bitops for m68k and sh
  lib: introduce BITS_{FIRST,LAST} macro
  bitsperlong.h: introduce SMALL_CONST() macro
  lib: inline _find_next_bit() wrappers
  lib: add fast path for find_next_*_bit()
  lib: add fast path for find_first_*_bit() and find_last_bit()

 arch/m68k/include/asm/bitops.h          |   4 +-
 arch/sh/include/asm/bitops.h            |   3 +-
 include/asm-generic/bitops/find.h       | 108 +++++++++++++++++++++---
 include/asm-generic/bitops/le.h         |  38 ++++++++-
 include/asm-generic/bitsperlong.h       |   2 +
 include/linux/bitmap.h                  |  60 ++++++-------
 include/linux/bitops.h                  |  12 ---
 include/linux/bits.h                    |   6 ++
 include/linux/cpumask.h                 |   8 +-
 include/linux/netdev_features.h         |   2 +-
 include/linux/nodemask.h                |   2 +-
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
 22 files changed, 337 insertions(+), 225 deletions(-)

-- 
2.25.1

