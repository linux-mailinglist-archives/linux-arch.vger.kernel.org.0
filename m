Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5883252FE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBYQEd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 11:04:33 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:52885 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhBYQEc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 11:04:32 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 11PG2sqG028425;
        Fri, 26 Feb 2021 01:02:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11PG2sqG028425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614268975;
        bh=CyZEsWmAevBFT9uBiZTERrN13bxEczDUCNEzhGbHOzw=;
        h=From:To:Cc:Subject:Date:From;
        b=DlM/+BpyVY2m+7PwxVhe+quQX6BE8hBWSc38TQmFzHGNM1Q02dfXiddtW0BXsvSp1
         lqRydQAIG3D9xnQcSKkSKDhxhmLKZGPurVt+OMYaZzAIi7Th2zypKbyZAxGQvbj3JP
         Me5ipOaVfzwljva+bUhGnXX2aau6g4LyIDcUTGOyHMVTdSTt5M2057NrBNxHUJKGPV
         BRIA0wDDmI8Qt7uliXvzbrWZYmucnEa/fB6Dqo2y3srEyZc5qJ3Bc+oZxvLTMwjKsj
         ik3I2uh7/DN+gFuFhCYXrNVmiXOxnYaw9EfSmxTOvTt7wUISiCXFBPwqFcYVNvgI2l
         VYSOo08v7ITwQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/4] kbuild: build speed improvment of CONFIG_TRIM_UNUSED_KSYMS
Date:   Fri, 26 Feb 2021 01:02:42 +0900
Message-Id: <20210225160247.2959903-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Now CONFIG_TRIM_UNUSED_KSYMS is revived, but Linus is still unhappy
about the build speed.

I re-implemented this feature, and the build time cost is now
almost unnoticeable level.

I hope this makes Linus happy.



Masahiro Yamada (4):
  kbuild: fix UNUSED_KSYMS_WHITELIST for Clang LTO
  export.h: make __ksymtab_strings per-symbol section
  kbuild: separate out vmlinux.lds generation
  kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to make it work in
    one-pass

 Makefile                          | 34 ++++++------
 arch/alpha/kernel/Makefile        |  3 +-
 arch/arc/kernel/Makefile          |  3 +-
 arch/arm/kernel/Makefile          |  3 +-
 arch/arm64/kernel/Makefile        |  3 +-
 arch/csky/kernel/Makefile         |  3 +-
 arch/h8300/kernel/Makefile        |  2 +-
 arch/hexagon/kernel/Makefile      |  3 +-
 arch/ia64/kernel/Makefile         |  3 +-
 arch/m68k/kernel/Makefile         |  2 +-
 arch/microblaze/kernel/Makefile   |  3 +-
 arch/mips/kernel/Makefile         |  3 +-
 arch/nds32/kernel/Makefile        |  3 +-
 arch/nios2/kernel/Makefile        |  2 +-
 arch/openrisc/kernel/Makefile     |  3 +-
 arch/parisc/kernel/Makefile       |  3 +-
 arch/powerpc/kernel/Makefile      |  2 +-
 arch/riscv/kernel/Makefile        |  2 +-
 arch/s390/kernel/Makefile         |  3 +-
 arch/sh/kernel/Makefile           |  3 +-
 arch/sparc/kernel/Makefile        |  2 +-
 arch/um/kernel/Makefile           |  2 +-
 arch/x86/kernel/Makefile          |  2 +-
 arch/xtensa/kernel/Makefile       |  3 +-
 include/asm-generic/export.h      | 25 +--------
 include/asm-generic/vmlinux.lds.h | 29 +++++++++--
 include/linux/export.h            | 56 +++++---------------
 init/Kconfig                      |  4 +-
 scripts/Makefile.build            |  7 +--
 scripts/adjust_autoksyms.sh       | 76 ---------------------------
 scripts/gen-keep-ksyms.sh         | 86 +++++++++++++++++++++++++++++++
 scripts/gen_autoksyms.sh          | 55 --------------------
 scripts/gen_ksymdeps.sh           | 25 ---------
 scripts/lto-used-symbollist.txt   |  5 --
 scripts/module.lds.S              | 38 ++++++++++----
 35 files changed, 210 insertions(+), 291 deletions(-)
 delete mode 100755 scripts/adjust_autoksyms.sh
 create mode 100755 scripts/gen-keep-ksyms.sh
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh
 delete mode 100644 scripts/lto-used-symbollist.txt

-- 
2.27.0

