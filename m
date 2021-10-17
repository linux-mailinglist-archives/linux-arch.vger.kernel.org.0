Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E84308E9
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbhJQMmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 08:42:20 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49285 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343505AbhJQMmQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Oct 2021 08:42:16 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXKM92Psqz9sSn;
        Sun, 17 Oct 2021 14:39:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Pn54lfG2lJJ; Sun, 17 Oct 2021 14:39:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXKM01DDwz9sSq;
        Sun, 17 Oct 2021 14:39:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 05B0F8B770;
        Sun, 17 Oct 2021 14:39:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uUFZwNEpZw9F; Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEB198B76E;
        Sun, 17 Oct 2021 14:39:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19HCcsOJ2946729
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 14:38:54 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19HCcooV2946727;
        Sun, 17 Oct 2021 14:38:50 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 00/12] Fix LKDTM for PPC64/IA64/PARISC
Date:   Sun, 17 Oct 2021 14:38:13 +0200
Message-Id: <cover.1634457599.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634474303; l=3065; s=20211009; h=from:subject:message-id; bh=q5yztb/Rm9ZIu/yiGaNQiYfIwy6tWF04jb0pU44KHjs=; b=kfF2HYWVNCzlAfNASwI1yAze8HH0iy2tkNn2e+udARgkXgh8bGoPN9N13ND0wyOZcFWXMMZOPvhC Lf7854i1C7xo2ZGsfJ67K8hRJ5jRSTBfbVgnKoijcNwXIQniB3gh
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
on those three architectures because LKDTM messes up function
descriptors with functions.

This series does some cleanup in the three architectures and
refactors function descriptors so that it can then easily use it
in a generic way in LKDTM.

Patch 8 is not absolutely necessary but it is a good trivial cleanup.

Changes in v3:
- Addressed received comments
- Swapped some of the powerpc patches to keep func_descr_t renamed as struct func_desc and remove 'struct ppc64_opd_entry'
- Changed HAVE_FUNCTION_DESCRIPTORS macro to a config item CONFIG_HAVE_FUNCTION_DESCRIPTORS
- Dropped patch 11 ("Fix lkdtm_EXEC_RODATA()")

Changes in v2:
- Addressed received comments
- Moved dereference_[kernel]_function_descriptor() out of line
- Added patches to remove func_descr_t and func_desc_t in powerpc
- Using func_desc_t instead of funct_descr_t
- Renamed HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to HAVE_FUNCTION_DESCRIPTORS
- Added a new lkdtm test to check protection of function descriptors

Christophe Leroy (12):
  powerpc: Move and rename func_descr_t
  powerpc: Use 'struct func_desc' instead of 'struct ppc64_opd_entry'
  powerpc: Remove 'struct ppc64_opd_entry'
  powerpc: Prepare func_desc_t for refactorisation
  ia64: Rename 'ip' to 'addr' in 'struct fdesc'
  asm-generic: Define CONFIG_HAVE_FUNCTION_DESCRIPTORS
  asm-generic: Define 'func_desc_t' to commonly describe function
    descriptors
  asm-generic: Refactor dereference_[kernel]_function_descriptor()
  lkdtm: Force do_nothing() out of line
  lkdtm: Really write into kernel text in WRITE_KERN
  lkdtm: Fix execute_[user]_location()
  lkdtm: Add a test for function descriptors protection

 arch/Kconfig                             |  3 +
 arch/ia64/Kconfig                        |  1 +
 arch/ia64/include/asm/elf.h              |  2 +-
 arch/ia64/include/asm/sections.h         | 24 +-------
 arch/ia64/kernel/module.c                |  6 +-
 arch/parisc/Kconfig                      |  1 +
 arch/parisc/include/asm/sections.h       | 16 ++----
 arch/parisc/kernel/process.c             | 21 -------
 arch/powerpc/Kconfig                     |  1 +
 arch/powerpc/include/asm/code-patching.h |  2 +-
 arch/powerpc/include/asm/elf.h           |  6 ++
 arch/powerpc/include/asm/sections.h      | 29 ++--------
 arch/powerpc/include/asm/types.h         |  6 --
 arch/powerpc/include/uapi/asm/elf.h      |  8 ---
 arch/powerpc/kernel/module_64.c          | 38 +++++--------
 arch/powerpc/kernel/ptrace/ptrace.c      |  6 ++
 arch/powerpc/kernel/signal_64.c          |  8 +--
 drivers/misc/lkdtm/core.c                |  1 +
 drivers/misc/lkdtm/lkdtm.h               |  1 +
 drivers/misc/lkdtm/perms.c               | 71 +++++++++++++++++++-----
 include/asm-generic/sections.h           | 13 ++++-
 include/linux/kallsyms.h                 |  2 +-
 kernel/extable.c                         | 23 +++++++-
 23 files changed, 146 insertions(+), 143 deletions(-)

-- 
2.31.1

