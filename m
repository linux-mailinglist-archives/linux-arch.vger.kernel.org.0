Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4217F24E0CC
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHUToW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgHUToV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:44:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4153C061575
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so1336792plj.6
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XC3x//tBbsyo8eKHRkCaYogz5DHFYFIlIb0mj2CsQ+Q=;
        b=DTGcBO8ELZaLcKzLXcNWncSGk8WWdWCuUmI0uSZgP5QmJSGKtVbQKsOJS34BAPwK92
         iOCV0pm2zduuw2ya7pIKhxn+D28CuEBQPguY8GpiBj5dADTG8mMQxbIExn4esiexEkcR
         P8ihjvNZ+5WFHHsmVKQYv/TCg0XgBBTEI0wDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XC3x//tBbsyo8eKHRkCaYogz5DHFYFIlIb0mj2CsQ+Q=;
        b=f6je57eBXKqYHbt2wEvoT4W8eY8pRwf7ElPELUFQC6hbHByi3DxK+ZGZ6Iro+9GRwC
         bAPNhSRMvqMvO3dZ79yZEkcJYYPmvBn6fXwrA3fQvHojgYwvB5hhXqWKcrmsh0ag+A0I
         04stE822NezKvb2f6dXalUNWxkn/O9Jd/tjeSYcG52Qh/APvtITDocf4MlF9cvFqv5j4
         u2stTb6mGisgTAbUAiuelQ37HYKIDRJbcOpk8vrctsVmrJ8nFn2/bUfnkGws285mf6s7
         pb6ZkD2W0wOqjXAchaQen3A0npqiLjsX63eb56x3pnaahIyTStdTqnqKNEw6UedIoRVF
         8iAQ==
X-Gm-Message-State: AOAM5302cfROwIvND02fKEK9/Tag+N1+HUTsaiyt1SrbmTAd4XmS6Ttz
        LDfmxbQADpdwsu5iamEKZ+T7AQ==
X-Google-Smtp-Source: ABdhPJyJbgSmV247uvBq4gDSqdhOZMSgMJyesc2VDY7qu07/N5IGhKeJXjacdWoOSZKeA7P3fECHYw==
X-Received: by 2002:a17:902:b111:: with SMTP id q17mr3452650plr.202.1598039060409;
        Fri, 21 Aug 2020 12:44:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k125sm2945849pga.48.2020.08.21.12.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/29] Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:42:41 -0700
Message-Id: <20200821194310.3089815-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ingo,

Based on my testing, this is ready to go. I've reviewed the feedback on
v5 and made a few small changes, noted below.


https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/warn/v6

v6:
- rebase to -tip x86/boot
- remove 0-sized NOLOAD
- move .got.plt to end with INFO (NOLOAD warns)
- add Reviewed-bys
v5: https://lore.kernel.org/lkml/20200731230820.1742553-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200629061840.4065483-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

A recent bug[1] was solved for builds linked with ld.lld, and tracking
it down took way longer than it needed to (a year). Ultimately, it
boiled down to differences between ld.bfd and ld.lld's handling of
orphan sections. Similar situation have continued to recur, and it's
clear the kernel build needs to be much more explicit about linker
sections. Similarly, the recent FGKASLR series brought up orphan section
handling too[2]. In all cases, it would have been nice if the linker was
running with --orphan-handling=warn so that surprise sections wouldn't
silently get mapped into the kernel image at locations up to the whim
of the linker's orphan handling logic. Instead, all desired sections
should be explicitly identified in the linker script (to be either kept,
discarded, or verified to be zero-sized) with any orphans throwing a
warning. The powerpc architecture has actually been doing this for some
time, so this series just extends that coverage to x86, arm, and arm64.

This has gotten sucecssful build testing under the following matrix:

compiler/linker: gcc+ld.bfd, clang+ld.lld
targets: defconfig, allmodconfig
architectures: x86, i386, arm64, arm
versions: -tip x86/boot

All three architectures depend on the first several commits to
vmlinux.lds.h. x86 depends on Arvind's GOT series (in -tip x86/boot now).
arm64 depends on the efi/libstub patch. As such, I'd like to land this
series as a whole. Ingo has suggested he'd take it into -tip.

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/

Kees Cook (28):
  vmlinux.lds.h: Create COMMON_DISCARDS
  vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
  vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
  vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG
  vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
  efi/libstub: Disable -mbranch-protection
  arm64/mm: Remove needless section quotes
  arm64/kernel: Remove needless Call Frame Information annotations
  arm64/build: Remove .eh_frame* sections due to unwind tables
  arm64/build: Use common DISCARDS in linker script
  arm64/build: Add missing DWARF sections
  arm64/build: Assert for unwanted sections
  arm64/build: Warn on orphan section placement
  arm/build: Refactor linker script headers
  arm/build: Explicitly keep .ARM.attributes sections
  arm/build: Add missing sections
  arm/build: Assert for unwanted sections
  arm/build: Warn on orphan section placement
  arm/boot: Handle all sections explicitly
  arm/boot: Warn on orphan section placement
  x86/asm: Avoid generating unused kprobe sections
  x86/build: Enforce an empty .got.plt section
  x86/build: Assert for unwanted sections
  x86/build: Warn on orphan section placement
  x86/boot/compressed: Reorganize zero-size section asserts
  x86/boot/compressed: Remove, discard, or assert for unwanted sections
  x86/boot/compressed: Add missing debugging sections to output
  x86/boot/compressed: Warn on orphan section placement

Nick Desaulniers (1):
  vmlinux.lds.h: add PGO and AutoFDO input sections

 arch/alpha/kernel/vmlinux.lds.S               |  1 +
 arch/arc/kernel/vmlinux.lds.S                 |  1 +
 arch/arm/Makefile                             |  4 ++
 arch/arm/boot/compressed/Makefile             |  2 +
 arch/arm/boot/compressed/vmlinux.lds.S        | 20 +++----
 .../arm/{kernel => include/asm}/vmlinux.lds.h | 30 ++++++++--
 arch/arm/kernel/vmlinux-xip.lds.S             |  8 ++-
 arch/arm/kernel/vmlinux.lds.S                 |  8 ++-
 arch/arm64/Makefile                           |  9 ++-
 arch/arm64/kernel/smccc-call.S                |  2 -
 arch/arm64/kernel/vmlinux.lds.S               | 28 +++++++--
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
 arch/x86/Makefile                             |  4 ++
 arch/x86/boot/compressed/Makefile             |  2 +
 arch/x86/boot/compressed/vmlinux.lds.S        | 58 +++++++++++++------
 arch/x86/include/asm/asm.h                    |  6 +-
 arch/x86/kernel/vmlinux.lds.S                 | 39 ++++++++++++-
 drivers/firmware/efi/libstub/Makefile         |  9 ++-
 include/asm-generic/vmlinux.lds.h             | 49 +++++++++++++---
 35 files changed, 241 insertions(+), 60 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (84%)

-- 
2.25.1

