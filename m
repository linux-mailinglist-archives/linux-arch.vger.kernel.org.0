Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B20E914C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfJ2VOF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:05 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:43936 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfJ2VOE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:04 -0400
Received: by mail-pf1-f179.google.com with SMTP id 3so10520778pfb.10
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tvuo3Ns0E4Fiim71b6F+/V34tv+uW7W3PecAxYDk1kI=;
        b=kjmJ2PRco2QbnnQ6/Lb5HykXKFCW8bMSMkr+JBAd0YCZqAHZUBgyl2XlQchiLsBsZA
         VWyGFqzEFLvF5puyLHdyKCM+5hmQj5PuueBjIKUK8Jn2QPWeJZWfexDjBm6I6dRaBLQj
         uENAgaybqP2QWV47BGcYFOi14iqWSDuRPGxb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tvuo3Ns0E4Fiim71b6F+/V34tv+uW7W3PecAxYDk1kI=;
        b=I6RgPwu9RxqF7yPDiWe9hfAoRpvYWiphsOErxLd9u6yUb4t2bWTU8DaleIo99VEt4C
         u78es5ufNAxv1vyx/DkyQiloMfg8q9SFu0ZV24ViSt+z1hxSZnY03NuwCUsO2AgCV7MD
         PDMy2XEQFxbjDeiVvg6CRkxxRUB2sYRGinJLEeDeNvCULI6waL6RUF+wFfl3oyqnknGO
         zoJMsIHeQy6DEqi4v4zI2Me1vZ5XfcJODyqRIvQtuCcQsF6Ydl+uJo64byd4+bVuvKtU
         KXyOj4ttSqV6WuN8Fl/Sy3uUVaVqKYrM3otU7eLESwbjcyGbGHXotaOuyhp9cu6wNXQY
         Z+mw==
X-Gm-Message-State: APjAAAVrBk87+NL/b5kkuNlUWF2Jz5TBiBfjqdCTzbOliSbTmmtuehLl
        z91wSHL0yJaY6acg2x6wq7RcAw==
X-Google-Smtp-Source: APXvYqxG6K5OnJmD5FS0dzSHIwPfA6+/IkLP3MyheBThwDhBc+0h1IEDuELusvnpNyG3iWLjyHi91w==
X-Received: by 2002:a63:471b:: with SMTP id u27mr28891174pga.96.1572383642989;
        Tue, 29 Oct 2019 14:14:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm51799pff.0.2019.10.29.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and NOTES
Date:   Tue, 29 Oct 2019 14:13:22 -0700
Message-Id: <20191029211351.13243-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arch maintainers: please send Acks (if you haven't already) for your
respective linker script changes; the intention is for this series to land
via -tip. See patch #1 for an extended rationale for the "note" vs "notes"
naming. If "notes" is strongly desired, we can perform that change on
top of this series. For now, I prefer to leave things as they were in v2.

v3: Add new Acks, clarify "note" vs "notes" renaming
v2: https://lore.kernel.org/lkml/20191011000609.29728-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20190926175602.33098-1-keescook@chromium.org


This series works to move the linker sections for NOTES and
EXCEPTION_TABLE into the RO_DATA area, where they belong on most
(all?) architectures. The problem being addressed was the discovery
by Rick Edgecombe that the exception table was accidentally marked
executable while he was developing his execute-only-memory series. When
permissions were flipped from readable-and-executable to only-executable,
the exception table became unreadable, causing things to explode rather
badly. :)

Roughly speaking, the steps are:

- regularize the linker names for PT_NOTE and PT_LOAD program headers
  (to "note" and "text" respectively)
- regularize restoration of linker section to program header assignment
  (when PT_NOTE exists)
- move NOTES into RO_DATA
- finish macro naming conversions for RO_DATA and RW_DATA
- move EXCEPTION_TABLE into RO_DATA on architectures where this is clear
- clean up some x86-specific reporting of kernel memory resources
- switch x86 linker fill byte from x90 (NOP) to 0xcc (INT3), just because
  I finally realized what that trailing ": 0x9090" meant -- and we should
  trap, not slide, if execution lands in section padding

Thanks!

-Kees


Kees Cook (29):
  powerpc: Rename "notes" PT_NOTE to "note"
  powerpc: Remove PT_NOTE workaround
  powerpc: Rename PT_LOAD identifier "kernel" to "text"
  alpha: Rename PT_LOAD identifier "kernel" to "text"
  ia64: Rename PT_LOAD identifier "code" to "text"
  s390: Move RO_DATA into "text" PT_LOAD Program Header
  x86: Restore "text" Program Header with dummy section
  vmlinux.lds.h: Provide EMIT_PT_NOTE to indicate export of .notes
  vmlinux.lds.h: Move Program Header restoration into NOTES macro
  vmlinux.lds.h: Move NOTES into RO_DATA
  vmlinux.lds.h: Replace RODATA with RO_DATA
  vmlinux.lds.h: Replace RO_DATA_SECTION with RO_DATA
  vmlinux.lds.h: Replace RW_DATA_SECTION with RW_DATA
  vmlinux.lds.h: Allow EXCEPTION_TABLE to live in RO_DATA
  x86: Actually use _etext for end of text segment
  x86: Move EXCEPTION_TABLE to RO_DATA segment
  alpha: Move EXCEPTION_TABLE to RO_DATA segment
  arm64: Move EXCEPTION_TABLE to RO_DATA segment
  c6x: Move EXCEPTION_TABLE to RO_DATA segment
  h8300: Move EXCEPTION_TABLE to RO_DATA segment
  ia64: Move EXCEPTION_TABLE to RO_DATA segment
  microblaze: Move EXCEPTION_TABLE to RO_DATA segment
  parisc: Move EXCEPTION_TABLE to RO_DATA segment
  powerpc: Move EXCEPTION_TABLE to RO_DATA segment
  xtensa: Move EXCEPTION_TABLE to RO_DATA segment
  x86/mm: Remove redundant &s on addresses
  x86/mm: Report which part of kernel image is freed
  x86/mm: Report actual image regions in /proc/iomem
  x86: Use INT3 instead of NOP for linker fill bytes

 arch/alpha/kernel/vmlinux.lds.S      | 18 +++++-----
 arch/arc/kernel/vmlinux.lds.S        |  6 ++--
 arch/arm/kernel/vmlinux-xip.lds.S    |  4 +--
 arch/arm/kernel/vmlinux.lds.S        |  4 +--
 arch/arm64/kernel/vmlinux.lds.S      | 10 +++---
 arch/c6x/kernel/vmlinux.lds.S        |  8 ++---
 arch/csky/kernel/vmlinux.lds.S       |  5 ++-
 arch/h8300/kernel/vmlinux.lds.S      |  9 ++---
 arch/hexagon/kernel/vmlinux.lds.S    |  5 ++-
 arch/ia64/kernel/vmlinux.lds.S       | 20 +++++------
 arch/m68k/kernel/vmlinux-nommu.lds   |  4 +--
 arch/m68k/kernel/vmlinux-std.lds     |  2 +-
 arch/m68k/kernel/vmlinux-sun3.lds    |  2 +-
 arch/microblaze/kernel/vmlinux.lds.S |  8 ++---
 arch/mips/kernel/vmlinux.lds.S       | 15 ++++----
 arch/nds32/kernel/vmlinux.lds.S      |  5 ++-
 arch/nios2/kernel/vmlinux.lds.S      |  5 ++-
 arch/openrisc/kernel/vmlinux.lds.S   |  7 ++--
 arch/parisc/kernel/vmlinux.lds.S     | 11 +++---
 arch/powerpc/kernel/vmlinux.lds.S    | 37 ++++---------------
 arch/riscv/kernel/vmlinux.lds.S      |  5 ++-
 arch/s390/kernel/vmlinux.lds.S       | 12 +++----
 arch/sh/kernel/vmlinux.lds.S         |  3 +-
 arch/sparc/kernel/vmlinux.lds.S      |  3 +-
 arch/um/include/asm/common.lds.S     |  3 +-
 arch/unicore32/kernel/vmlinux.lds.S  |  5 ++-
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/include/asm/sections.h      |  1 -
 arch/x86/kernel/setup.c              | 12 ++++++-
 arch/x86/kernel/vmlinux.lds.S        | 16 ++++-----
 arch/x86/mm/init.c                   |  8 ++---
 arch/x86/mm/init_64.c                | 16 +++++----
 arch/x86/mm/pti.c                    |  2 +-
 arch/xtensa/kernel/vmlinux.lds.S     |  8 ++---
 include/asm-generic/vmlinux.lds.h    | 53 ++++++++++++++++++++--------
 35 files changed, 159 insertions(+), 175 deletions(-)

-- 
2.17.1

