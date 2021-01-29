Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81DB308EA2
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhA2UqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhA2UqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:46:14 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55FDC061573;
        Fri, 29 Jan 2021 12:45:33 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j4so5114468qvk.6;
        Fri, 29 Jan 2021 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKOpnXxDr9dCifdGlykAdjfxcEels+yZrBFyjGlcvhs=;
        b=qplpwATB3theU+9FpF0Z/kz4ECrFxRbcM4pQhO/uvuSh1dnspRFP21c5BIQZc5o28n
         bEiXQo3gNnR1nSLbW6vUi3Zd+91SEj+7imh7NsmWCDFYsr4fVZHzhAcjKT53DJQOjDnv
         xpQd5EgC1rpNHxd5ZBp7MYIvbUgyrQk4lAxa/OmAl2QI5tZdidWi9G3ErCfYx67hdGpx
         dGKDWClcVIseJB7npMrHMgh5SbnsRrMdxDR17UoO3HKQlVCll70IQfj0Ab4c+E4U/5GW
         BwB5uyd1LvdMyVLlQ8rSIJ6hMaxPzyXWeAdmXKS0HuFr3pP+RiLCQ6ky6romzB6jfQUm
         39hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKOpnXxDr9dCifdGlykAdjfxcEels+yZrBFyjGlcvhs=;
        b=MwfXTO+eZxbuAwFHydp+HKjsPqDgQqZKpzapvdsDYRNxEHroJcqrLReu883ZTx6atw
         CK+zi147cukZLa6W+xiGqPjL2r6QUDTijo78H8/0MBQp2Pfb06esjz69f4BF1Z7Z4nTX
         COq0v0Gjv8XxKvpjWDsqAfR12TIEWtMSzYn2KNQLZPbKO1qexl7ufwdQ+tbZYWec6+8r
         iKQaNLXXuD0Y181qMJnJPkZ+9QrZnPdpUXVVf+NRD4mRV+eKWkE2xM0qzVc7FMt+3uNt
         OaQu0YoyzIoJ1JXeRxWhA90MVygm0zwqrDuO6SbVMObTnkwXZDzsHhmiTvYqKmW6c5IN
         9jzw==
X-Gm-Message-State: AOAM531e4GR2R1g/1vtf0sDf/36zbm8VoZ4v4YFR5Qxh1ag2Kb5xMiPA
        YTU2TqENIgwLs/YguW+JEtM=
X-Google-Smtp-Source: ABdhPJwUVBZVUjUsFOW7DwUiH6eCLcAvboAf+Eo4Bsra3y+Eldyw4QwDTJpYTjT/FDUwWwJ4+CcZwg==
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr5985349qvt.28.1611953132827;
        Fri, 29 Jan 2021 12:45:32 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id p23sm7013359qtu.4.2021.01.29.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:45:32 -0800 (PST)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 0/6] lib/find_bit: fast path for small bitmaps
Date:   Fri, 29 Jan 2021 12:45:22 -0800
Message-Id: <20210129204528.2118168-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bitmap operations are much simpler and faster in case of small bitmaps, whicn
fit into a single word. In linux/bitmap.h we have a machinery that allows
compiler to replace actual function call with a few instructions if bitmaps
passed into the function is small and its size is known at compile time.

find_*_bit() API lacks this functionality; despite users will benefit from it
a lot. One important example is cpumask subsystem, when NR_CPUS <= BITS_PER_LONG.
In the very best case, the compiler may replace a find_*_bit() call for such a
bitmap with a single ffs or ffz instruction.

Tools is synchronized with new implementation where needed.

Yury Norov (6):
  arch: rearrange headers inclusion order in asm/bitops for m68k and sh
  lib: inttroduce BITS_{FIRST,LAST}() macro
  bits_per_long.h: introduce SMALL_CONST() macro
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
 tools/include/linux/bitmap.h            |  39 +++------
 tools/include/linux/bits.h              |   6 ++
 tools/lib/bitmap.c                      |   6 +-
 tools/lib/find_bit.c                    |  56 +++++-------
 tools/testing/radix-tree/bitmap.c       |   4 +-
 21 files changed, 330 insertions(+), 219 deletions(-)

-- 
2.25.1

