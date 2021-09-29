Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10D41CAFF
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbhI2RYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 13:24:22 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51057 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbhI2RYV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 13:24:21 -0400
Received: by mail-wm1-f45.google.com with SMTP id j27so2462516wms.0;
        Wed, 29 Sep 2021 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wYiStrhTYDyD6KyMsoACZjcHuOdOYLgD+s4ib2mjlk=;
        b=7u3FDuO9W+kJdEglo2mSgk+XHe6n89v1c3X+3Drr8QA336yJYk+gAUP5RoQOd6cgQ3
         jiYPfb60q4xS+AuDmJvbyjNi0sRzdNWRZC/770iqo5X+Zpkrq5hBbiqwq7gJF1b5iiZC
         pIxZf/gWUQlfDHoUIkEOvE/JrahVBdpl14Bc5Lqp7sVhcc3iMNidAhm9U06v1EU1a1wN
         ZvWV18Onz41uzUGNgbg3IbV0yBKlnrdju5fx5tGMcY21m6OXuXE0F4FtSdi9FNR3qtMz
         89IjZythynPqWNlhyj/smdSH8TV8E7rIbzpaxKiUVmGtF7r8lokFWc/s2ik5bkvruWDW
         0e9g==
X-Gm-Message-State: AOAM533MDe9x77+FnKtHQun4TAHmx0NaZBSbUz+d7R/oZfaUOHvMlmR/
        vu0ucaMuIBOgdKHhN9jvxWY=
X-Google-Smtp-Source: ABdhPJwj+v6Ia/1ewRH90e4P1/TPFUvE8EwF6nwIW4OtRVbDIJFo8m6XaalECnXB7TPk8E2KUUOv5Q==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr11667995wmj.178.1632936159413;
        Wed, 29 Sep 2021 10:22:39 -0700 (PDT)
Received: from msft-t490s.. (mob-31-159-120-132.net.vodafone.it. [31.159.120.132])
        by smtp.gmail.com with ESMTPSA id n26sm2267502wmi.43.2021.09.29.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:22:38 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 0/3] riscv: optimized mem* functions
Date:   Wed, 29 Sep 2021 19:22:31 +0200
Message-Id: <20210929172234.31620-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Replace the assembly mem{cpy,move,set} with C equivalent.

Try to access RAM with the largest bit width possible, but without
doing unaligned accesses.

A further improvement could be to use multiple read and writes as the
assembly version was trying to do.

Tested on a BeagleV Starlight with a SiFive U74 core, where the
improvement is noticeable.

v4 -> v5:
- call __memcpy() instead of memcpy() in memmove()

v3 -> v4:
- incorporate changes from proposed generic version:
  https://lore.kernel.org/lkml/20210702123153.14093-1-mcroce@linux.microsoft.com/

v2 -> v3:
- alias mem* to __mem* and not viceversa
- use __alias instead of a tail call

v1 -> v2:
- reduce the threshold from 64 to 16 bytes
- fix KASAN build
- optimize memset

Matteo Croce (3):
  riscv: optimized memcpy
  riscv: optimized memmove
  riscv: optimized memset

 arch/riscv/include/asm/string.h |  18 ++--
 arch/riscv/kernel/Makefile      |   1 -
 arch/riscv/kernel/riscv_ksyms.c |  17 ----
 arch/riscv/lib/Makefile         |   4 +-
 arch/riscv/lib/memcpy.S         | 108 ----------------------
 arch/riscv/lib/memmove.S        |  64 -------------
 arch/riscv/lib/memset.S         | 113 -----------------------
 arch/riscv/lib/string.c         | 154 ++++++++++++++++++++++++++++++++
 8 files changed, 164 insertions(+), 315 deletions(-)
 delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
 delete mode 100644 arch/riscv/lib/memcpy.S
 delete mode 100644 arch/riscv/lib/memmove.S
 delete mode 100644 arch/riscv/lib/memset.S
 create mode 100644 arch/riscv/lib/string.c

-- 
2.31.1

