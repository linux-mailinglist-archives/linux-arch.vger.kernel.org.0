Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439AE356319
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbhDGFen (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhDGFen (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:34:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 770B661168;
        Wed,  7 Apr 2021 05:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773673;
        bh=9EMqO5rXb/7iyWa3CU4S51prMmnhL8RekmIE64z+OK8=;
        h=From:To:Cc:Subject:Date:From;
        b=IKqZm9a2rBZSL6knQCx/vj0u8I4qMtI3U6Dsnvpk+9a130MO8cG6HnPqzSHMoUro5
         SCi0287o2oXBSJo2bnwjFwdd78yzx5YKlPdhgZNyqd22TCPRITXk8RUWbILrcEYZ1G
         Wn054WK53AsevEF+fUy1iW8DVd59qmM9FWyqHSQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Subject: [PATCH 00/20] kbuild: unify the install.sh script usage
Date:   Wed,  7 Apr 2021 07:33:59 +0200
Message-Id: <20210407053419.449796-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Almost every architecture has copied the "install.sh" script that
originally came with i386, and modified it in very tiny ways.  This
patch series unifies all of these scripts into one single script to
allow people to understand how to correctly install a kernel, and fixes
up some issues regarding trying to install a kernel to a path with
spaces in it.

Note that not all architectures actually seem to have any type of way to
install a kernel, they must rely on external scripts or tools which
feels odd as everything should be included here in the main repository.
I'll work on trying to figure out the missing architecture issues
afterward.

Note the cc: list here is crazy, due to touching arch-specific code in a
number of different arches in the same patch series.  I've cc:ed
individual arch maintainers on this 00/20 patch, and on their individual
arch-specific patch as well, but not the whole thing.

thanks,

greg k-h

Greg Kroah-Hartman (20):
  kbuild: move x86 install script to scripts/install.sh
  kbuild: scripts/install.sh: properly quote all variables
  kbuild: scripts/install.sh: provide a "install" function
  kbuild: scripts/install.sh: call sync before calling the bootloader
    installer
  kbuild: scripts/install.sh: prepare for arch-specific bootloaders
  kbuild: scripts/install.sh: handle compressed/uncompressed kernel
    images
  kbuild: scripts/install.sh: allow for the version number
  kbuild: riscv: use common install script
  kbuild: arm64: use common install script
  kbuild: arm: use common install script
  kbuild: ia64: use common install script
  kbuild: m68k: use common install script
  kbuild: nds32: convert to use the common install scripts
  kbuild: nios2: use common install script
  kbuild: parisc: use common install script
  kbuild: powerpc: use common install script
  kbuild: s390: use common install script
  kbuild: sh: remove unused install script
  kbuild: sparc: use common install script
  kbuild: scripts/install.sh: update documentation

 arch/arm/boot/Makefile             |   6 +-
 arch/arm/boot/install.sh           |  66 --------------
 arch/arm64/boot/Makefile           |   4 +-
 arch/arm64/boot/install.sh         |  60 -------------
 arch/ia64/Makefile                 |   2 +-
 arch/ia64/install.sh               |  40 ---------
 arch/m68k/Makefile                 |   2 +-
 arch/m68k/install.sh               |  52 -----------
 arch/nds32/boot/Makefile           |   4 +-
 arch/nios2/boot/Makefile           |   2 +-
 arch/nios2/boot/install.sh         |  52 -----------
 arch/parisc/Makefile               |   4 +-
 arch/parisc/boot/Makefile          |   2 +-
 arch/parisc/boot/install.sh        |  65 --------------
 arch/parisc/install.sh             |  66 --------------
 arch/powerpc/boot/Makefile         |   4 +-
 arch/powerpc/boot/install.sh       |  55 ------------
 arch/riscv/boot/Makefile           |   4 +-
 arch/riscv/boot/install.sh         |  60 -------------
 arch/s390/boot/Makefile            |   2 +-
 arch/s390/boot/install.sh          |  30 -------
 arch/sh/boot/compressed/install.sh |  56 ------------
 arch/sparc/boot/Makefile           |   2 +-
 arch/sparc/boot/install.sh         |  50 -----------
 arch/x86/boot/Makefile             |   2 +-
 arch/x86/boot/install.sh           |  59 -------------
 scripts/install.sh                 | 136 +++++++++++++++++++++++++++++
 27 files changed, 156 insertions(+), 731 deletions(-)
 delete mode 100644 arch/arm/boot/install.sh
 delete mode 100644 arch/arm64/boot/install.sh
 delete mode 100644 arch/ia64/install.sh
 delete mode 100644 arch/m68k/install.sh
 delete mode 100644 arch/nios2/boot/install.sh
 delete mode 100644 arch/parisc/boot/install.sh
 delete mode 100644 arch/parisc/install.sh
 delete mode 100644 arch/powerpc/boot/install.sh
 delete mode 100644 arch/riscv/boot/install.sh
 delete mode 100644 arch/s390/boot/install.sh
 delete mode 100644 arch/sh/boot/compressed/install.sh
 delete mode 100644 arch/sparc/boot/install.sh
 delete mode 100644 arch/x86/boot/install.sh
 create mode 100644 scripts/install.sh


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.31.1

