Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90FA3068DB
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 01:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhA1AyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 19:54:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:28376 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhA1AyE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:54:04 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIV024172;
        Thu, 28 Jan 2021 09:51:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIV024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795106;
        bh=jQK2la2Ui/cbd7OVnHnnldJT4VCvoMGBdUZ9L0a9brw=;
        h=From:To:Cc:Subject:Date:From;
        b=RCDhaLrSacWGW2jMoA/CnF0PXcaoEGBb/27Iq340URIjyF5oOdKIioy3xHP3gsabi
         mw2ZoaQYGVOEzsCJagmyEeYa+/en2HXL/VNwpblpu+H4HmQiy3FuHey7xwIHawrWhz
         J046GTpD7glj5cXJqXMwWZMnKHaOG7PR+D6EQTv69ORhiD33OFaqqBEEw0u6JdDmdu
         GOthXjVErdPRXsvNFscEIJJkwb+kD+1TCC1UM6286+BXL8saw9gPf83J7mGkOtYG0m
         pEFy1183wEobPYroWAor8uPgimvicQp7OOAgunUeDJfA8jTaVxyFcGYh5N2AWxcL+E
         4y0JIaJgjdFmg==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arch@vger.kernel.org, x86@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 00/27] arch: syscalls: unifiy all syscalltbl.sh into scripts/syscalltbl.sh
Date:   Thu, 28 Jan 2021 09:50:42 +0900
Message-Id: <20210128005110.2613902-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


As of v5.11-rc1, 12 architectures duplicate similar shell scripts:

  $ find arch -name syscalltbl.sh | sort
  arch/alpha/kernel/syscalls/syscalltbl.sh
  arch/arm/tools/syscalltbl.sh
  arch/ia64/kernel/syscalls/syscalltbl.sh
  arch/m68k/kernel/syscalls/syscalltbl.sh
  arch/microblaze/kernel/syscalls/syscalltbl.sh
  arch/mips/kernel/syscalls/syscalltbl.sh
  arch/parisc/kernel/syscalls/syscalltbl.sh
  arch/powerpc/kernel/syscalls/syscalltbl.sh
  arch/sh/kernel/syscalls/syscalltbl.sh
  arch/sparc/kernel/syscalls/syscalltbl.sh
  arch/x86/entry/syscalls/syscalltbl.sh
  arch/xtensa/kernel/syscalls/syscalltbl.sh

This patch set unifies all of them into a single file,
scripts/syscalltbl.sh.

The code-diff is attractive:

 51 files changed, 254 insertions(+), 674 deletions(-)
 delete mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/arm/tools/syscalltbl.sh
 delete mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh
 delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh
 create mode 100644 scripts/syscalltbl.sh

Also, this includes Makefile fixes, and some x86 fixes and cleanups.

My question is, how to merge this series.

I am touching all architectures, but the first patch is a prerequisite
of the rest of this series.

One possibility is to ask the x86 maintainers to pickup the first 5
patches for v5.12-rc1, and then send the rest for v5.13-rc1,
splitting per-arch.

I want the x86 maintainers to check the first 5 patches because
I cleaned up the x32 code.

I know x32 was considered for deprecation, but my motivation is to
clean-up scripts across the tree without changing the functionality.



Masahiro Yamada (27):
  scripts: add generic syscalltbl.sh
  x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
  x86/build: add missing FORCE and fix 'targets' to make if_changed work
  x86/entry/x32: rename __x32_compat_sys_* to __x64_compat_sys_*
  x86/syscalls: switch to generic syscalltbl.sh
  ARM: syscalls: switch to generic syscalltbl.sh
  alpha: add missing FORCE and fix 'targets' to make if_changed work
  alpha: syscalls: switch to generic syscalltbl.sh
  ia64: add missing FORCE and fix 'targets' to make if_changed work
  ia64: syscalls: switch to generic syscalltbl.sh
  m68k: add missing FORCE and fix 'targets' to make if_changed work
  m68k: syscalls: switch to generic syscalltbl.sh
  microblaze: add missing FORCE and fix 'targets' to make if_changed
    work
  microblaze: syscalls: switch to generic syscalltbl.sh
  mips: add missing FORCE and fix 'targets' to make if_changed work
  mips: syscalls: switch to generic syscalltbl.sh
  parisc: add missing FORCE and fix 'targets' to make if_changed work
  parisc: syscalls: switch to generic syscalltbl.sh
  sh: add missing FORCE and fix 'targets' to make if_changed work
  sh: syscalls: switch to generic syscalltbl.sh
  sparc: remove wrong comment from arch/sparc/include/asm/Kbuild
  sparc: add missing FORCE and fix 'targets' to make if_changed work
  sparc: syscalls: switch to generic syscalltbl.sh
  powerpc: add missing FORCE and fix 'targets' to make if_changed work
  powerpc: syscalls: switch to generic syscalltbl.sh
  xtensa: add missing FORCE and fix 'targets' to make if_changed work
  xtensa: syscalls: switch to generic syscalltbl.sh

 arch/alpha/kernel/syscalls/Makefile           | 18 +++----
 arch/alpha/kernel/syscalls/syscalltbl.sh      | 32 -----------
 arch/alpha/kernel/systbls.S                   |  3 +-
 arch/arm/kernel/entry-common.S                |  8 +--
 arch/arm/tools/Makefile                       |  9 ++--
 arch/arm/tools/syscalltbl.sh                  | 22 --------
 arch/ia64/kernel/entry.S                      |  3 +-
 arch/ia64/kernel/syscalls/Makefile            | 19 +++----
 arch/ia64/kernel/syscalls/syscalltbl.sh       | 32 -----------
 arch/m68k/kernel/syscalls/Makefile            | 18 +++----
 arch/m68k/kernel/syscalls/syscalltbl.sh       | 32 -----------
 arch/m68k/kernel/syscalltable.S               |  3 +-
 arch/microblaze/kernel/syscall_table.S        |  3 +-
 arch/microblaze/kernel/syscalls/Makefile      | 18 +++----
 arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 -----------
 arch/mips/include/asm/Kbuild                  |  7 ++-
 arch/mips/kernel/scall32-o32.S                |  4 +-
 arch/mips/kernel/scall64-n32.S                |  3 +-
 arch/mips/kernel/scall64-n64.S                |  3 +-
 arch/mips/kernel/scall64-o32.S                |  4 +-
 arch/mips/kernel/syscalls/Makefile            | 53 ++++++++-----------
 arch/mips/kernel/syscalls/syscalltbl.sh       | 36 -------------
 arch/parisc/include/asm/Kbuild                |  1 -
 arch/parisc/kernel/syscall.S                  | 16 +++---
 arch/parisc/kernel/syscalls/Makefile          | 34 +++++-------
 arch/parisc/kernel/syscalls/syscalltbl.sh     | 36 -------------
 arch/powerpc/include/asm/Kbuild               |  1 -
 arch/powerpc/kernel/syscalls/Makefile         | 39 +++++---------
 arch/powerpc/kernel/syscalls/syscalltbl.sh    | 36 -------------
 arch/powerpc/kernel/systbl.S                  |  5 +-
 arch/powerpc/platforms/cell/spu_callbacks.c   |  2 +-
 arch/sh/kernel/syscalls/Makefile              | 18 +++----
 arch/sh/kernel/syscalls/syscalltbl.sh         | 32 -----------
 arch/sparc/include/asm/Kbuild                 |  3 --
 arch/sparc/kernel/syscalls/Makefile           | 34 +++++-------
 arch/sparc/kernel/syscalls/syscalltbl.sh      | 36 -------------
 arch/sparc/kernel/systbls_32.S                |  4 +-
 arch/sparc/kernel/systbls_64.S                |  8 +--
 arch/x86/entry/syscall_32.c                   | 12 +++--
 arch/x86/entry/syscall_64.c                   |  9 ++--
 arch/x86/entry/syscall_x32.c                  | 27 ++--------
 arch/x86/entry/syscalls/Makefile              | 33 +++++++-----
 arch/x86/entry/syscalls/syscalltbl.sh         | 46 ----------------
 arch/x86/include/asm/Kbuild                   |  1 +
 arch/x86/include/asm/syscall_wrapper.h        | 11 ++--
 arch/x86/um/sys_call_table_32.c               |  8 +--
 arch/x86/um/sys_call_table_64.c               |  9 ++--
 arch/xtensa/kernel/syscall.c                  |  3 +-
 arch/xtensa/kernel/syscalls/Makefile          | 18 +++----
 arch/xtensa/kernel/syscalls/syscalltbl.sh     | 32 -----------
 scripts/syscalltbl.sh                         | 52 ++++++++++++++++++
 51 files changed, 254 insertions(+), 674 deletions(-)
 delete mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/arm/tools/syscalltbl.sh
 delete mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh
 delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh
 create mode 100644 scripts/syscalltbl.sh

-- 
2.27.0

