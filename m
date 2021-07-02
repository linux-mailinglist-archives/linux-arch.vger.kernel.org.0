Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBE3BA1A1
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhGBNwT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 09:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhGBNwT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Jul 2021 09:52:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84510613F4;
        Fri,  2 Jul 2021 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233787;
        bh=OHdeFEnQVJvOVh/or6l4rellXMMPBuzIf6W0CCnQbo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WMbipGNUPIt7k7ijQ8kPktcEBkAm9860rR5GmqYWJcLldRqIQKg6MeAz32vPVb5Bi
         FbrlpYE+Sk97ckwvyp2bMJWepu8Vtn6cDaptnGQEcyM3933SW4mJw7ctKOamicJ+cX
         mPLEk5MsMErkTlVM7sb7tZ7HCa7OJUUbaX9fmYslx/Wx8Xe1XPTtNe4x0F2TheptvZ
         oeMwNcyT8Ol82CWxRFlvc3JCby7eBt5e9s8SMjLEDwhe235efWrUecCbbFLb76SLi1
         bk5Qwo7G7niLett1eKVSOPHeCVde7NXc04pO9u9UcsmgjZLtJmvJSIIuOcsGLrUksE
         jFtnDUJ2BVp0A==
Received: by mail-wr1-f46.google.com with SMTP id a8so879595wrp.5;
        Fri, 02 Jul 2021 06:49:47 -0700 (PDT)
X-Gm-Message-State: AOAM531N+m6EYJCRZRdDMnaXph6YiDlWgnysrcor6OalEMTqcBCOvhFt
        Xoq6406nLmXVch9kWiNMQl5M+CT0xeAaAOz/5fk=
X-Google-Smtp-Source: ABdhPJwymNM1iCQ1nA54dZFPRfy7X9qHSosl/UFboTIThXk/vh1xaXqpbrcebsxTbOji3me1WpuIaVSctNColYJyHaw=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr6064774wrn.99.1625233786121;
 Fri, 02 Jul 2021 06:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
In-Reply-To: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 2 Jul 2021 15:49:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Y1FHaS0yRAeBYmq0Z-yXtvHBRRiO1tNHKf-TaWVrFzQ@mail.gmail.com>
Message-ID: <CAK8P3a3Y1FHaS0yRAeBYmq0Z-yXtvHBRRiO1tNHKf-TaWVrFzQ@mail.gmail.com>
Subject: [GIT PULL 2/2] asm-generic: Unify asm/unaligned.h around struct helper
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-unaligned-5.14

for you to fetch changes up to 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63:

  asm-generic: simplify asm/unaligned.h (2021-05-17 13:30:29 +0200)

----------------------------------------------------------------
asm-generic/unaligned: Unify asm/unaligned.h around struct helper

The get_unaligned()/put_unaligned() helpers are traditionally architecture
specific, with the two main variants being the "access-ok.h" version
that assumes unaligned pointer accesses always work on a particular
architecture, and the "le-struct.h" version that casts the data to a
byte aligned type before dereferencing, for architectures that cannot
always do unaligned accesses in hardware.

Based on the discussion linked below, it appears that the access-ok
version is not realiable on any architecture, but the struct version
probably has no downsides. This series changes the code to use the
same implementation on all architectures, addressing the few exceptions
separately.

Link: https://lore.kernel.org/lkml/75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com/
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363
Link: https://lore.kernel.org/lkml/20210507220813.365382-14-arnd@kernel.org/
Link: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
unaligned-rework-v2
Link: https://lore.kernel.org/lkml/CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (13):
      asm-generic: use asm-generic/unaligned.h for most architectures
      openrisc: always use unaligned-struct header
      sh: remove unaligned access for sh4a
      m68k: select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
      powerpc: use linux/unaligned/le_struct.h on LE power7
      asm-generic: unaligned: remove byteshift helpers
      asm-generic: unaligned always use struct helpers
      partitions: msdos: fix one-byte get_unaligned()
      apparmor: use get_unaligned() only for multi-byte words
      mwifiex: re-fix for unaligned accesses
      netpoll: avoid put_unaligned() on single character
      asm-generic: uaccess: 1-byte access is always aligned
      asm-generic: simplify asm/unaligned.h

 arch/alpha/include/asm/unaligned.h          |  12 --
 arch/arm/include/asm/unaligned.h            |  27 ----
 arch/ia64/include/asm/unaligned.h           |  12 --
 arch/m68k/Kconfig                           |   1 +
 arch/m68k/include/asm/unaligned.h           |  26 ----
 arch/microblaze/include/asm/unaligned.h     |  27 ----
 arch/mips/crypto/crc32-mips.c               |   2 +-
 arch/openrisc/include/asm/unaligned.h       |  47 -------
 arch/parisc/include/asm/unaligned.h         |   6 +-
 arch/powerpc/include/asm/unaligned.h        |  22 ---
 arch/sh/include/asm/unaligned-sh4a.h        | 199 ----------------------------
 arch/sh/include/asm/unaligned.h             |  13 --
 arch/sparc/include/asm/unaligned.h          |  11 --
 arch/x86/include/asm/unaligned.h            |  15 ---
 arch/xtensa/include/asm/unaligned.h         |  29 ----
 block/partitions/ldm.c                      |   2 +-
 block/partitions/ldm.h                      |   3 -
 block/partitions/msdos.c                    |  24 ++--
 drivers/net/wireless/marvell/mwifiex/pcie.c |  10 +-
 include/asm-generic/uaccess.h               |   4 +-
 include/asm-generic/unaligned.h             | 141 ++++++++++++++++----
 include/linux/unaligned/access_ok.h         |  68 ----------
 include/linux/unaligned/be_byteshift.h      |  71 ----------
 include/linux/unaligned/be_memmove.h        |  37 ------
 include/linux/unaligned/be_struct.h         |  37 ------
 include/linux/unaligned/generic.h           | 115 ----------------
 include/linux/unaligned/le_byteshift.h      |  71 ----------
 include/linux/unaligned/le_memmove.h        |  37 ------
 include/linux/unaligned/le_struct.h         |  37 ------
 include/linux/unaligned/memmove.h           |  46 -------
 net/core/netpoll.c                          |   4 +-
 security/apparmor/policy_unpack.c           |   2 +-
 32 files changed, 141 insertions(+), 1017 deletions(-)
 delete mode 100644 arch/alpha/include/asm/unaligned.h
 delete mode 100644 arch/arm/include/asm/unaligned.h
 delete mode 100644 arch/ia64/include/asm/unaligned.h
 delete mode 100644 arch/m68k/include/asm/unaligned.h
 delete mode 100644 arch/microblaze/include/asm/unaligned.h
 delete mode 100644 arch/openrisc/include/asm/unaligned.h
 delete mode 100644 arch/powerpc/include/asm/unaligned.h
 delete mode 100644 arch/sh/include/asm/unaligned-sh4a.h
 delete mode 100644 arch/sh/include/asm/unaligned.h
 delete mode 100644 arch/sparc/include/asm/unaligned.h
 delete mode 100644 arch/x86/include/asm/unaligned.h
 delete mode 100644 arch/xtensa/include/asm/unaligned.h
 delete mode 100644 include/linux/unaligned/access_ok.h
 delete mode 100644 include/linux/unaligned/be_byteshift.h
 delete mode 100644 include/linux/unaligned/be_memmove.h
 delete mode 100644 include/linux/unaligned/be_struct.h
 delete mode 100644 include/linux/unaligned/generic.h
 delete mode 100644 include/linux/unaligned/le_byteshift.h
 delete mode 100644 include/linux/unaligned/le_memmove.h
 delete mode 100644 include/linux/unaligned/le_struct.h
 delete mode 100644 include/linux/unaligned/memmove.h
