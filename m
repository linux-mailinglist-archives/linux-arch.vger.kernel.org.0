Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2AF2069BE
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 03:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgFXBtv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 21:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388509AbgFXBtt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E31C061795
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so410977pje.4
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRX+a9QElrykJZmLdxem4I40g6I/9leCnrUb/OjtOMI=;
        b=CIDABal4Q+UfzI6TBZvIf3fo33EAYBlTM+i4WnVSQcoUlRTxWm02Cj9OOEXCd4yS6L
         307zhAh97TXGXcj5JjcKAZqxQURhTxfozAhzuBm60rS3Yo9aZZgowAfuLuMjWedb3dF6
         EuQg6eb5KlOItUtb9njXU8b0lPFOb9RM4akWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRX+a9QElrykJZmLdxem4I40g6I/9leCnrUb/OjtOMI=;
        b=ANx+xKLXaeWElPN/Ggblrf9q3D+8zMUkShON+9Qv53bUZUljBoY4Tkb1QUQoEAdAqT
         QrtczUfOOa44Y0pWKZ+J2KrScH6D12HsI5F817nubJzlWos0M+G6YNCucTsh9ahI3z/Z
         Aj72gTwDaFAF9GXnFpns8OBAlVjvHf1SucbzTeNAZiBlfE4R396etKsIHvASXN4qdOZc
         HxiFdFMNcRcpMmAZZGzSwoOzXdzMemlkHt2gi6hZUrO89QXSqzjBNnHyyzi6pguchOTB
         coLMLTVbCymGE8rofk9r4nImbX0uRsQOxI6xGLBlw0BJBh9ONd4mxGjeJ8f7AisPMOWM
         7q8w==
X-Gm-Message-State: AOAM531XjD1YQIMj6MlKh7VfaerF0wnnWo47ugrcc53zSkrZuMS7HW+I
        UUV8NxFRQq82kuldQ6cKNlMy2Q==
X-Google-Smtp-Source: ABdhPJwl6JTcw+g/B90wVgoZK0xqnoCWxZXqyZZiqvL8XYPvPf3KqeE6RxoFL30elVgP9TzunKDaOQ==
X-Received: by 2002:a17:90a:d186:: with SMTP id fu6mr4433095pjb.185.1592963388068;
        Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl11sm3230884pjb.0.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
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
Subject: [PATCH v3 0/9] Warn on orphan section placement
Date:   Tue, 23 Jun 2020 18:49:31 -0700
Message-Id: <20200624014940.1204448-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v3:
- merge series back together (I tried to make it separable, but no luck)
- remove unwanted sections in libstub
- remove unwanted .eh_frame sections for both .c and .S
- handle sections seen during allnoconfig builds
- handle synthetic and double-quoted sections reported by Clang
- add reviewed-bys
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

All three architectures depend on the first two commits (to
vmlinux.lds.h), and x86 and arm64 depend on the third patch (to
libstub). As such, I'd like to land this series as a whole. Given that
two thirds of it is in the arm universe, perhaps this can land via the
arm64 tree? If x86 -tip is preferred, that works too. Or I could just
carry this myself in -next. In all cases, I would really appreciate
reviews/acks/etc. :)

Thanks!

-Kees

This series is here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/warn/v3

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/

Kees Cook (9):
  vmlinux.lds.h: Add .gnu.version* to DISCARDS
  vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to STABS_DEBUG
  efi/libstub: Remove .note.gnu.property
  x86/build: Warn on orphan section placement
  x86/boot: Warn on orphan section placement
  arm/build: Warn on orphan section placement
  arm/boot: Warn on orphan section placement
  arm64/build: Use common DISCARDS in linker script
  arm64/build: Warn on orphan section placement

 arch/arm/Makefile                             |  4 ++++
 arch/arm/boot/compressed/Makefile             |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S        | 17 ++++++--------
 .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
 arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
 arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
 arch/arm64/Makefile                           |  9 +++++++-
 arch/arm64/kernel/smccc-call.S                |  2 --
 arch/arm64/kernel/vmlinux.lds.S               | 16 ++++++++++----
 arch/arm64/mm/mmu.c                           |  2 +-
 arch/x86/Makefile                             |  4 ++++
 arch/x86/boot/compressed/Makefile             |  3 ++-
 arch/x86/boot/compressed/vmlinux.lds.S        | 11 ++++++++++
 arch/x86/include/asm/asm.h                    |  6 ++++-
 arch/x86/kernel/vmlinux.lds.S                 |  6 +++++
 drivers/firmware/efi/libstub/Makefile         |  3 +++
 include/asm-generic/vmlinux.lds.h             |  7 +++++-
 17 files changed, 92 insertions(+), 32 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)

-- 
2.25.1

