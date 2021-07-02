Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6EA3BA192
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhGBNuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 09:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232386AbhGBNuk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Jul 2021 09:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 910436142B;
        Fri,  2 Jul 2021 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233688;
        bh=2sqvaKpsBfNMgq83CEar15dETBn3QWs27Pt8LM/rCwM=;
        h=From:Date:Subject:To:Cc:From;
        b=rc62/bOo5T2jDzR4RHPSTBU9uRAByYE4yKqqeivveY0JA8eJssOJVIEfs4EEX9KR4
         IrPz2C1OHXFxfio5zL9ScYUVfVpHi+OjIZlwgHNng3KBYm8KKAL+dYGLu889KvdIss
         fVFNvo7E+VSwodDiRF+vWIF4GJDR3Zy+uNmCHZ7vaEazMC3DpeWUDWUVlwaDhSqKcx
         QMu8wJv7wuaNTcicgKSOeNP+BaC1q/oUQKf/u0QWsAc2DHQsPrc4+Eep50U/kLxyhq
         umlzUc/4pDN/spuMUbKadOeONFFU/IcYgJTX1atZh8dGPu9YZwT2y3EJSMHgQDUxPa
         Fpxib2ruZpQNQ==
Received: by mail-wr1-f42.google.com with SMTP id a13so12520603wrf.10;
        Fri, 02 Jul 2021 06:48:08 -0700 (PDT)
X-Gm-Message-State: AOAM531HmZiGYBoh4yGtqDG8rEH7cLPaeeQKb4FsoqEaMP3mIm/oV+SN
        M003SqBHeS269JAKkVMVYp8i4/Nmzd2ixxRW/Ko=
X-Google-Smtp-Source: ABdhPJxjuAcWk+fUW2iebkdnRr3QNskMI/RshqdGsVxS1+zazUtNB4DLWU+IzcKQARqYjKSwvSI4o2tSJmitDSPbyTM=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr6057171wrn.99.1625233687201;
 Fri, 02 Jul 2021 06:48:07 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 2 Jul 2021 15:47:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
Message-ID: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
Subject: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-pci-ioport-5.14

for you to fetch changes up to 5ae6eadfdaf431f47adbdf1754f3b5a5fd638de2:

  asm-generic/io.h: warn in inb() and friends with undefined
PCI_IOBASE (2021-05-10 17:37:55 +0200)

----------------------------------------------------------------
asm-generic: rework PCI I/O space access

A rework for PCI I/O space access from Niklas Schnelle:

  "This is version 5 of my attempt to get rid of a clang
  -Wnull-pointer-arithmetic warning for the use of PCI_IOBASE in
  asm-generic/io.h. This was originally found on s390 but should apply to
  all platforms leaving PCI_IOBASE undefined while making use of the inb()
  and friends helpers from asm-generic/io.h.

  This applies cleanly and was compile tested on top of v5.12 for the
  previously broken ARC, nds32, h8300 and risc-v architecture. It also
  applies cleanly on v5.13-rc1 for which I boot tested it on s390.

  I did boot test this only on x86_64 and s390x the former implements
  inb() itself while the latter would emit a WARN_ONCE() but no drivers
  use inb().

Link: https://lore.kernel.org/lkml/20210510145234.594814-1-schnelle@linux.ibm.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Niklas Schnelle (3):
      sparc: explicitly set PCI_IOBASE to 0
      risc-v: Use generic io.h helpers for nommu
      asm-generic/io.h: warn in inb() and friends with undefined PCI_IOBASE

 arch/riscv/include/asm/io.h |  5 +++--
 arch/sparc/include/asm/io.h |  8 ++++++++
 include/asm-generic/io.h    | 68
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 75 insertions(+), 6 deletions(-)
