Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842E230012
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgG1DeV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1DeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240AC061794;
        Mon, 27 Jul 2020 20:34:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so2947166pfp.7;
        Mon, 27 Jul 2020 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCnIQkB+WXR9EnceInub93Gc1wu07cKzWBjBmwPz1vo=;
        b=myv9KnF9W9rJE9rWATRLtH/vhNUeyuqZcVGWfSSxnjpzmKX5OAoTOz+7pUA2epgJ/h
         dCHx7Tc0KTp270c1NvpRn8I0hi5fdBqlKQWteDANwWpbEEAPPjFi6pyOr6dBkhSFUTmb
         PjkL5JJqBY4DxtNvp68aDFj1PBM39OTTDTJSsB0uZqfiqIIyyHlhcrWiNSvdBb8QxVZf
         mR0sqHV1uxeAfm4eZSZQe2b7xdwxkLtjGT8TeaEi9++MUSIy1/N7wZFl0TcTPeHTu+5n
         MeQr0cpjKhyMe0qS+RxDkfL1Rf05h7Z872o2G0UkjkjOkK20qnmK90IttzyNw0aZkfoi
         wjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCnIQkB+WXR9EnceInub93Gc1wu07cKzWBjBmwPz1vo=;
        b=G2PGZXqSiMJ2USUKAcn+O4zpRKKMJvzQ6RO8XpbJ+TJm2mKnCCwFSFmbjgl/y4mvJy
         7bNdRI8GBTGczupTjjO6Xcq17jpN78uyTRbYU548uzvVSEqe6GIwPCcbLYyRWF2MrrBi
         NZpB2Cka3dsVq7nNBaop2p7/MUdxASeqWlVKkB0P1JXQEUGpJUhlWvl1FNK1zK5hwKBX
         3bLs0mNFxSUBB7kTU2cZgU3QjZEJu7sxFadRmyZff/2nUPobGuHl4jZbYvdYU/c9dONv
         /ylTcxe/9JzdN6D8+I4WFvwRnzoL/TQWrf+n5hYQgT78CXgzTeULiYf+JFPHeb7sRQc1
         T8gw==
X-Gm-Message-State: AOAM530xhLksNVoD/LvTFjnRHc3T3+/P7NzrqzwymIiSKTrNH7MMWe62
        tSEO4Bl85y602gUp7QZbPBAmX3rQ
X-Google-Smtp-Source: ABdhPJxqipxt9LfjXXesa510BBsTC/g0OOB6e4CNnPIlHzbtheNKpYrvVbB95CuUkvM8JKcPu5l80A==
X-Received: by 2002:a62:3207:: with SMTP id y7mr22629319pfy.95.1595907259474;
        Mon, 27 Jul 2020 20:34:19 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:18 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/24] Use asm-generic for mmu_context no-op functions
Date:   Tue, 28 Jul 2020 13:33:41 +1000
Message-Id: <20200728033405.78469-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It would be nice to be able to modify these or add a hook without
updating all architectures, most of which just use noops.

There was some discussion around the lazy tlb switching vs membarrier
barriers that may have needed changes here to fix (addition of an
exit_lazy_tlb() function). I don't know whether that's what we will
end up doing, but these are the prep patches I did for it which are
still a good cleanup so I would like to mege them.

All arch patches depend on patch 1. If everybody is fine with it
then Arnd could merge that one in this merge window then we do the
rest of them in the next window?

Thanks,
Nick

Nicholas Piggin (24):
  asm-generic: add generic versions of mmu context functions
  alpha: use asm-generic/mmu_context.h for no-op implementations
  arc: use asm-generic/mmu_context.h for no-op implementations
  arm: use asm-generic/mmu_context.h for no-op implementations
  arm64: use asm-generic/mmu_context.h for no-op implementations
  csky: use asm-generic/mmu_context.h for no-op implementations
  hexagon: use asm-generic/mmu_context.h for no-op implementations
  ia64: use asm-generic/mmu_context.h for no-op implementations
  m68k: use asm-generic/mmu_context.h for no-op implementations
  microblaze: use asm-generic/mmu_context.h for no-op implementations
  mips: use asm-generic/mmu_context.h for no-op implementations
  nds32: use asm-generic/mmu_context.h for no-op implementations
  nios2: use asm-generic/mmu_context.h for no-op implementations
  openrisc: use asm-generic/mmu_context.h for no-op implementations
  parisc: use asm-generic/mmu_context.h for no-op implementations
  powerpc: use asm-generic/mmu_context.h for no-op implementations
  riscv: use asm-generic/mmu_context.h for no-op implementations
  s390: use asm-generic/mmu_context.h for no-op implementations
  sh: use asm-generic/mmu_context.h for no-op implementations
  sparc: use asm-generic/mmu_context.h for no-op implementations
  um: use asm-generic/mmu_context.h for no-op implementations
  unicore32: use asm-generic/mmu_context.h for no-op implementations
  x86: use asm-generic/mmu_context.h for no-op implementations
  xtensa: use asm-generic/mmu_context.h for no-op implementations

 arch/alpha/include/asm/mmu_context.h         | 12 ++---
 arch/arc/include/asm/mmu_context.h           | 16 +++---
 arch/arm/include/asm/mmu_context.h           | 26 ++-------
 arch/arm64/include/asm/mmu_context.h         |  7 ++-
 arch/csky/include/asm/mmu_context.h          |  8 ++-
 arch/hexagon/include/asm/mmu_context.h       | 33 ++----------
 arch/ia64/include/asm/mmu_context.h          | 17 ++----
 arch/m68k/include/asm/mmu_context.h          | 47 +++-------------
 arch/microblaze/include/asm/mmu_context.h    |  2 +-
 arch/microblaze/include/asm/mmu_context_mm.h |  8 +--
 arch/microblaze/include/asm/processor.h      |  3 --
 arch/mips/include/asm/mmu_context.h          | 11 ++--
 arch/nds32/include/asm/mmu_context.h         | 10 +---
 arch/nios2/include/asm/mmu_context.h         | 21 ++------
 arch/nios2/mm/mmu_context.c                  |  1 +
 arch/openrisc/include/asm/mmu_context.h      |  8 ++-
 arch/openrisc/mm/tlb.c                       |  2 +
 arch/parisc/include/asm/mmu_context.h        | 12 ++---
 arch/powerpc/include/asm/mmu_context.h       | 22 +++-----
 arch/riscv/include/asm/mmu_context.h         | 22 +-------
 arch/s390/include/asm/mmu_context.h          |  9 ++--
 arch/sh/include/asm/mmu_context.h            |  7 ++-
 arch/sh/include/asm/mmu_context_32.h         |  9 ----
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++--
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++--
 arch/um/include/asm/mmu_context.h            | 12 ++---
 arch/unicore32/include/asm/mmu_context.h     | 24 ++-------
 arch/x86/include/asm/mmu_context.h           |  6 +++
 arch/xtensa/include/asm/mmu_context.h        | 11 ++--
 arch/xtensa/include/asm/nommu_context.h      | 26 +--------
 include/asm-generic/mmu_context.h            | 57 +++++++++++++++-----
 include/asm-generic/nommu_context.h          | 19 +++++++
 32 files changed, 170 insertions(+), 318 deletions(-)
 create mode 100644 include/asm-generic/nommu_context.h

-- 
2.23.0

