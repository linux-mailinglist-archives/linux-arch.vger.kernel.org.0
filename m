Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E3253294
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgHZO5m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgHZOw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:52:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FDC061574;
        Wed, 26 Aug 2020 07:52:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x143so1113594pfc.4;
        Wed, 26 Aug 2020 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tNfoBs9TBB9YEBE9tGDOyEBHmB4zC7u2zOrj/FbPgx8=;
        b=Lg8/ha00Khu4EnC51k8zmKvtgAPlEmqiajWsZOLjETHGx23tEzbGXekHrgWjO+Vq1I
         2fXkg0Q35UcFc74e/G1qntsuqPWKwE5jUgK3SJ1m6u4QZ98nVq8tNnk++aXMnvMZ/Yu6
         dyiJu8oryT8NpYJlAP+N5xCrKCIJF03RO+hzw5D4+W2YAsmnTFfACWHYWzwXSbKwaW/n
         ARq6VLEOHctnhON5rjgmWsghY6gAlHvcJJn4/dIjfsKmk7RWjjdFRiGYefpX7Cno30GO
         g2vYdSxNqnsBsuv1nCqvXii58LJ997cl1b8HtYgdLHsnRSGifRinKvewZA0Z/ANz+VZH
         bYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tNfoBs9TBB9YEBE9tGDOyEBHmB4zC7u2zOrj/FbPgx8=;
        b=uKKwwsBTdFo8qj0hZPTr/vkNZnoaAtPdIo3Y50CwSeDWSrGuyp9PZtpb89LvWOMCdZ
         0P5zRwh3tKnZOSz2/oV04aFNaWTCsaXQeFmP9LWSEoZwj8G4+Q7moaaH1orawa8LQk03
         PfgGswJUpA0rCTb0pKHHvi/ZZ6BDyv9xXCfxFB4bvI/8rsP4avEiB3ZxOSPsFmxEuxOl
         CFeTQca8kbgku355fwf1isrSYTvL+ow5svXRLHjFEEN1Yk+czSzesCkGbI9UYowBQdKC
         I0xEtk5n5CfA67LWDj7Yhj2oXlqOn/BgPK52VqFaFqcuHwi9VHtUK24xEc81tPEIR2eU
         sYsA==
X-Gm-Message-State: AOAM530m868zPj/bo7lsY6Zwy3jlZDDie3BDctrw0rvSDNkUWuacorHf
        1WrTseQcyUWHuKOvcsQQcnUL7hTAFEM=
X-Google-Smtp-Source: ABdhPJxLIeqRIUyEsfqFb7nJ7wULo7zOJ9c+t995J9bGMLz8hG1B5sC3G6S9f61NKHKNNvKKa0BQkQ==
X-Received: by 2002:a62:2903:: with SMTP id p3mr5843369pfp.83.1598453578576;
        Wed, 26 Aug 2020 07:52:58 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:52:58 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 00/23] Use asm-generic for mmu_context no-op functions
Date:   Thu, 27 Aug 2020 00:52:26 +1000
Message-Id: <20200826145249.745432-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It would be nice to be able to modify mmu_context functions or add a
hook without updating all architectures, many of which will be no-ops.

The motivation for this series is a change to lazy mmu handling, but
this series stands on its own as a good cleanup whether or not we end
up making that change.

Arnd, is this something you could take through your asm-generic tree?
(assuming arch maintainers are okay with it)

Thanks,
Nick

Since v1:
- Added acks and feedback from various people.
- Fixed a nommu build error caught by ktp.
- Dropped unicore32.

Nicholas Piggin (23):
  asm-generic: add generic MMU versions of mmu context functions
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
  x86: use asm-generic/mmu_context.h for no-op implementations
  xtensa: use asm-generic/mmu_context.h for no-op implementations

 arch/alpha/include/asm/mmu_context.h         | 12 ++---
 arch/arc/include/asm/mmu_context.h           | 17 +++---
 arch/arm/include/asm/mmu_context.h           | 26 ++-------
 arch/arm64/include/asm/mmu_context.h         |  9 ++--
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
 arch/openrisc/include/asm/mmu_context.h      |  8 ++-
 arch/parisc/include/asm/mmu_context.h        | 12 ++---
 arch/powerpc/include/asm/mmu_context.h       | 22 +++-----
 arch/riscv/include/asm/mmu_context.h         | 22 +-------
 arch/s390/include/asm/mmu_context.h          |  9 ++--
 arch/sh/include/asm/mmu_context.h            |  7 ++-
 arch/sh/include/asm/mmu_context_32.h         |  9 ----
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++--
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++--
 arch/um/include/asm/mmu_context.h            | 12 ++---
 arch/x86/include/asm/mmu_context.h           |  6 +++
 arch/xtensa/include/asm/mmu_context.h        | 11 ++--
 arch/xtensa/include/asm/nommu_context.h      | 26 +--------
 include/asm-generic/mmu_context.h            | 57 +++++++++++++++-----
 include/asm-generic/nommu_context.h          | 19 +++++++
 29 files changed, 166 insertions(+), 298 deletions(-)
 create mode 100644 include/asm-generic/nommu_context.h

-- 
2.23.0

