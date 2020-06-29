Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E88E20E22C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgF2VDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbgF2TMt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:12:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9734BC08EAF0
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so7567429pjs.3
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94PT4ZZxVDelwBmV/2g0OBn6aDN7DJybZdz+0cO8lSM=;
        b=htK3ULYAY8Ioor41oXa3s4blSCZQhPzhPSfKlTBtUmE8TmGgnEqgv1HDnW56PueYRY
         rwR1GLfBYtJVgCfVbVdlRKZw9HFOOqYtVMXabp/ZIu23+Ma7pTzfhehjfRcyDvmSDc9y
         XkOBFXJyJYHbtk5WAzkcIeQcKQoTVTt/3QCjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94PT4ZZxVDelwBmV/2g0OBn6aDN7DJybZdz+0cO8lSM=;
        b=Skg26nzYQv6SqjYkLEooOtC4yRdIJoJMBF5qMrENxUHa9N/9NCBjO7vr8ySXFaNrzg
         ouzGhp+dcckmkvvuIN7Q3ln+XDg7U8qIuYoUyzWH+ArgvNTowXWGRfkuIIuJm9RywSwP
         U9aWUB139MRm8YFqqZ3lq3E3dnNnn1zVjro37C70vRwc7uLAEX4sqlpe0aidA8YXasEu
         eDQlRcSWcfZTg36PnjI8mOCEE8zkkt6jfk8Eq40+PG/070laDd4mbd8LEtZvelqHmdu7
         1GGChFty8Q9tbHIx2uM/YofnTXTvUOa1wNp+WO7iQN0S7oZMgVdFzdthjyQtcGe2F5d2
         GpMQ==
X-Gm-Message-State: AOAM532/24cNmeQ4Q9T0odhbPNFUX+YWtsg0o6tuZTubfIoWKD8RvlkU
        wx+6JZeA0u+auZULcuMWH8+qGQ==
X-Google-Smtp-Source: ABdhPJy3RUB/apJg+B+3+3HZviihAw2PheDSpFiYSQqDcMDsJWYHNjl9Yj9fkPRQHuD3X2yCjYg2NQ==
X-Received: by 2002:a17:90a:1acc:: with SMTP id p70mr5373622pjp.210.1593411526183;
        Sun, 28 Jun 2020 23:18:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v28sm14619872pgc.44.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/17] Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:23 -0700
Message-Id: <20200629061840.4065483-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v4:
- explicitly add .ARM.attributes
- split up arm64 changes into separate patches
- split up arm changes into separate patches
- work around Clang section generation bug in -mbranch-protection
- work around Clang section generation bug in KASAN and KCSAN
- split "common" ELF sections out of STABS_DEBUG
- changed relative position of .comment
- add reviews/acks
v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

A recent bug[1] was solved for builds linked with ld.lld, and tracking
it down took way longer than it needed to (a year). Ultimately, it
boiled down to differences between ld.bfd and ld.lld's handling of
orphan sections. Similarly, the recent FGKASLR series brough up orphan
section handling too[2]. In both cases, it would have been nice if the
linker was running with --orphan-handling=warn so that surprise sections
wouldn't silently get mapped into the kernel image at locations up to the
whim of the linker's orphan handling logic. Instead, all desired sections
should be explicitly identified in the linker script (to be either kept or
discarded) with any orphans throwing a warning. The powerpc architecture
actually already does this, so this series extends coverage to x86, arm,
and arm64.

All three architectures depend on the first four commits (to
vmlinux.lds.h), and arm64 depends on the 5th and 6th patches (to ctype,
and efi/libstub). As such, I'd like to land this series as a whole. Given
that two thirds of it is in the arm universe, perhaps this can land via
the arm64 tree? If x86 -tip is preferred, that works too. Or I could
just carry this myself in -next. In all cases, I would really appreciate
reviews/acks/etc. :)

Thanks!

-Kees

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/warn/v4

Kees Cook (17):
  vmlinux.lds.h: Add .gnu.version* to DISCARDS
  vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
  vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG
  vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
  ctype: Work around Clang -mbranch-protection=none bug
  efi/libstub: Disable -mbranch-protection
  arm64/build: Use common DISCARDS in linker script
  arm64/mm: Remove needless section quotes
  arm64/build: Remove .eh_frame* sections due to unwind tables
  arm64/kernel: Remove needless Call Frame Information annotations
  arm64/build: Warn on orphan section placement
  arm/build: Refactor linker script headers
  arm/build: Explicitly keep .ARM.attributes sections
  arm/build: Warn on orphan section placement
  arm/boot: Warn on orphan section placement
  x86/build: Warn on orphan section placement
  x86/boot: Warn on orphan section placement

 arch/alpha/kernel/vmlinux.lds.S               |  1 +
 arch/arc/kernel/vmlinux.lds.S                 |  1 +
 arch/arm/boot/compressed/Makefile             |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S        | 18 +++++-----
 .../arm/{kernel => include/asm}/vmlinux.lds.h | 25 ++++++++++---
 arch/arm/kernel/vmlinux-xip.lds.S             |  6 ++--
 arch/arm/kernel/vmlinux.lds.S                 |  6 ++--
 arch/arm64/Makefile                           |  9 ++++-
 arch/arm64/kernel/smccc-call.S                |  2 --
 arch/arm64/kernel/vmlinux.lds.S               | 17 ++++++---
 arch/arm64/mm/mmu.c                           |  2 +-
 arch/csky/kernel/vmlinux.lds.S                |  1 +
 arch/hexagon/kernel/vmlinux.lds.S             |  1 +
 arch/ia64/kernel/vmlinux.lds.S                |  1 +
 arch/mips/kernel/vmlinux.lds.S                |  1 +
 arch/nds32/kernel/vmlinux.lds.S               |  1 +
 arch/nios2/kernel/vmlinux.lds.S               |  1 +
 arch/openrisc/kernel/vmlinux.lds.S            |  1 +
 arch/parisc/boot/compressed/vmlinux.lds.S     |  1 +
 arch/parisc/kernel/vmlinux.lds.S              |  1 +
 arch/powerpc/kernel/vmlinux.lds.S             |  2 +-
 arch/riscv/kernel/vmlinux.lds.S               |  1 +
 arch/s390/kernel/vmlinux.lds.S                |  1 +
 arch/sh/kernel/vmlinux.lds.S                  |  1 +
 arch/sparc/kernel/vmlinux.lds.S               |  1 +
 arch/um/kernel/dyn.lds.S                      |  2 +-
 arch/um/kernel/uml.lds.S                      |  2 +-
 arch/unicore32/kernel/vmlinux.lds.S           |  1 +
 arch/x86/Makefile                             |  8 ++++-
 arch/x86/boot/compressed/Makefile             |  3 +-
 arch/x86/boot/compressed/vmlinux.lds.S        | 12 +++++++
 arch/x86/include/asm/asm.h                    |  6 +++-
 arch/x86/kernel/vmlinux.lds.S                 |  7 ++++
 drivers/firmware/efi/libstub/Makefile         |  3 +-
 include/asm-generic/vmlinux.lds.h             | 35 +++++++++++++++++--
 lib/ctype.c                                   | 10 ++++++
 36 files changed, 154 insertions(+), 39 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (88%)

-- 
2.25.1

