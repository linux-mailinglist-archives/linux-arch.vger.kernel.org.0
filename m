Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA49410D0C
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhISTXD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 15:23:03 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43597 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhISTXC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 15:23:02 -0400
Received: by mail-ed1-f45.google.com with SMTP id n10so51395777eda.10;
        Sun, 19 Sep 2021 12:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPQno8A85O4WeBnY/bkDmDISB83i8fh43dkMBVfbagg=;
        b=Wv5zk3qmRhU6wk38WDi5IUQM0oQe4ATvmqg+6PE9Q4TC+9cQY3WWah6myn8GlWp/6i
         fKfXqP34u0iPHd0kvfcAHb/aR/6mkRSmevwIzb4TCUxcWL6HKDp8NTIgYREc0PbXNsV0
         eujsMzSCxNZcwt61z4mbgzITKOb9wA/moELMBQ2k7pMMPq6SI+aaWXIciD35hA3oLbBk
         TgNje/nQ5kbCrZE3V4WP1QbnckfgSaT929OFIMBZuJD3Tt5ZZ9/YESVyMU6vo0L5Xe77
         nBF/X19J59T1wsc3RleVX3LMG+ZR25FXguZBqve8gTBAwSfPpoOAMFKX+pH/C9SBDoGG
         OONQ==
X-Gm-Message-State: AOAM5337B1V+D2/MiF5BiVnTtHat638cH9+0b+lbMwlbgoz0Uj7iGsEZ
        ic0D4gWU1uS3uwxNtn+WjSE=
X-Google-Smtp-Source: ABdhPJw6bKrJh6VBPCsEdw0Z3ZJq549XyeLF8IcT+WCASbLSolRQjT+vBCfpq9w+BytaqdW8R4vjng==
X-Received: by 2002:a17:906:6dd4:: with SMTP id j20mr24232036ejt.316.1632079295730;
        Sun, 19 Sep 2021 12:21:35 -0700 (PDT)
Received: from turbo.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id 10sm5208525eju.12.2021.09.19.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 12:21:35 -0700 (PDT)
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
Subject: [PATCH v4 0/3] riscv: optimized mem* functions
Date:   Sun, 19 Sep 2021 21:21:01 +0200
Message-Id: <20210919192104.98592-1-mcroce@linux.microsoft.com>
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

v3 -> v4:
- incorporate changes from proposed generic version:
  https://lore.kernel.org/lkml/20210617152754.17960-1-mcroce@linux.microsoft.com/

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

