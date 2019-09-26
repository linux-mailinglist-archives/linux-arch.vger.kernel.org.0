Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB46BF888
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfIZR54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:57:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46142 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfIZR4X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so2223567pfg.13
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QEG/EaNbne2aV7OKhHfoYngDByBBcJ0cppuY/pozywQ=;
        b=C+3Ew31NmGJo/s34rbNfqjLTRqvYTUPk4Fzn1v6DxaCv0bUz5Itel2G7bPEbzOO7la
         fZED90J+wL+qVcUlkffN4PYCPS/j/nBCQCnH3CopXImwLAl74lL+UhVoxl4VitCgKmD2
         8kak6FLso8A712fVwjhhMVHLwKEZrzvyynFis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QEG/EaNbne2aV7OKhHfoYngDByBBcJ0cppuY/pozywQ=;
        b=plQn/HfP+97bPBtSdcLWIcDQxz9P9ClZi2Klq3YA+HCZW9GXyim3dyN1dJ2xxPo6HF
         3ncGhu+rbxGbYJuKzPx15bBN/akEaB0HmUC2/lGbQwLqBK1RT1ALP5bOXsWABOrgUY6h
         jlEqvuK7yL7N09/6PtpSB5+sMMzgjZEWGDzqhcIcjN4R5ged9C5WWWwUBc3itPaJJMqG
         C45Ox3HAyLElRN0v++zN0DHGQISt62LepOHIg5LnrUo2QzZ4TtoUPMitqWe54z4t8W9w
         jH1HEUkr43O8U0Z2wS8wGTb+DnlDBatemfmi3ryZ+UeFffmYZBwzVi/Q5HrY68boMVQN
         7w2w==
X-Gm-Message-State: APjAAAU7+NNE74jh/ztMIF0qPlP1KyyTqMxxfig7Dhor8FSjhY73IWJF
        LkmLyOHsnzmUONLeyC6iw//BLg==
X-Google-Smtp-Source: APXvYqyGBYTkR69ROZhnYj3Ai7+SxN5uk+xjkc2oWKjzkLJSeo/f2CV0bxk4Z/YCXLw5XMrEqBkdJw==
X-Received: by 2002:a63:355:: with SMTP id 82mr4552661pgd.81.1569520580971;
        Thu, 26 Sep 2019 10:56:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm2995021pgj.54.2019.09.26.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and NOTES
Date:   Thu, 26 Sep 2019 10:55:33 -0700
Message-Id: <20190926175602.33098-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

Since these changes are treewide, I'd love to get architecture-maintainer
Acks and either have this live in x86 -tip or in my own tree, however
people think it should go.

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
 arch/arm64/kernel/vmlinux.lds.S      |  9 ++---
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
 35 files changed, 159 insertions(+), 174 deletions(-)

-- 
2.17.1

