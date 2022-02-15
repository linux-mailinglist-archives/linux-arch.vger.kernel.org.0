Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DE4B6C65
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiBOMnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiBOMnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:43:09 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDE220DE;
        Tue, 15 Feb 2022 04:42:18 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jyggy1NNJz9sSj;
        Tue, 15 Feb 2022 13:41:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aAFigYi3mPjJ; Tue, 15 Feb 2022 13:41:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn54j6z9sSq;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A34A58B778;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8BMkLkapqY1B; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 864958B780;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfF0a080604
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:15 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfCsi080602;
        Tue, 15 Feb 2022 13:41:12 +0100
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
Subject: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
Date:   Tue, 15 Feb 2022 13:40:55 +0100
Message-Id: <cover.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=3486; s=20211009; h=from:subject:message-id; bh=m/DTx99DZSafIIAwqkPz//VBU0dyGp+Z1HSmYNYxr4k=; b=cA7HXYxl5bBjs2eDNDE7zc7AazTXQFugH4g9S2nHM9kGtuT4amV6deKgKTSjs1MSmqM/lI026rsd Qqw7wMTrAUUX5rW7aGfQEz1o7/o1rvZAnijGSKkg2maBIdk3DYCk
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
on those three architectures because LKDTM messes up function
descriptors with functions.

This series does some cleanup in the three architectures and
refactors function descriptors so that it can then easily use it
in a generic way in LKDTM.

Changes in v4:
- Added patch 1 which Fixes 'sparse' for powerpc64le after wrong report on previous series, refer https://github.com/ruscur/linux-ci/actions/runs/1351427671
- Exported dereference_function_descriptor() to modules
- Addressed other received comments
- Rebased on latest powerpc/next (5a72345e6a78120368fcc841b570331b6c5a50da)

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

Christophe Leroy (13):
  powerpc: Fix 'sparse' checking on PPC64le
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
 arch/powerpc/Makefile                    |  2 +-
 arch/powerpc/include/asm/code-patching.h |  2 +-
 arch/powerpc/include/asm/elf.h           |  6 ++
 arch/powerpc/include/asm/sections.h      | 29 ++--------
 arch/powerpc/include/asm/types.h         |  6 --
 arch/powerpc/include/uapi/asm/elf.h      |  8 ---
 arch/powerpc/kernel/module_64.c          | 42 ++++++--------
 arch/powerpc/kernel/ptrace/ptrace.c      |  6 ++
 arch/powerpc/kernel/signal_64.c          |  8 +--
 drivers/misc/lkdtm/core.c                |  1 +
 drivers/misc/lkdtm/lkdtm.h               |  1 +
 drivers/misc/lkdtm/perms.c               | 71 +++++++++++++++++++-----
 include/asm-generic/sections.h           | 15 ++++-
 include/linux/kallsyms.h                 |  2 +-
 kernel/extable.c                         | 24 +++++++-
 tools/testing/selftests/lkdtm/tests.txt  |  1 +
 25 files changed, 155 insertions(+), 144 deletions(-)

-- 
2.34.1

