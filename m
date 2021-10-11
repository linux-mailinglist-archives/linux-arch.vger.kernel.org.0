Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6750942933E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhJKP31 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 11:29:27 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59181 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238436AbhJKP3S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 11:29:18 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HSjM93d1Fz9sTx;
        Mon, 11 Oct 2021 17:26:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OBrFabSRDoDz; Mon, 11 Oct 2021 17:26:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM30nH1z9sTy;
        Mon, 11 Oct 2021 17:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB9278B770;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bFxN6KuiUkIq; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4347A8B778;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQUHh1585003
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:26:30 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQSSf1585000;
        Mon, 11 Oct 2021 17:26:28 +0200
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
Subject: [PATCH v1 00/10] Fix LKDTM for PPC64/IA64/PARISC
Date:   Mon, 11 Oct 2021 17:25:27 +0200
Message-Id: <cover.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965928; l=1657; s=20211009; h=from:subject:message-id; bh=MyFDI59OB41sshcY3FFNfcB1XZ95MMaqIC4x67qjzAw=; b=fIPiVnVnK4XA3MURNNuFAFMUTrsms/nTkjiJtAFhRT/WhoLrPGf+hhxLE8wJ4jP/uibuvVcQFHfG hom3CpU3BH7rSi6TGaCUsgEbvS6ttQ2X5/5MDETSsvzVKkGDd5xO
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

Patch 6 is not absolutely necessary but it is a good trivial cleanup.

Christophe Leroy (10):
  powerpc: Move 'struct ppc64_opd_entry' back into asm/elf.h
  powerpc: Rename 'funcaddr' to 'addr' in 'struct ppc64_opd_entry'
  ia64: Rename 'ip' to 'addr' in 'struct fdesc'
  asm-generic: Use HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to define
    associated stubs
  asm-generic: Define 'funct_descr_t' to commonly describe function
    descriptors
  asm-generic: Refactor dereference_[kernel]_function_descriptor()
  lkdtm: Force do_nothing() out of line
  lkdtm: Really write into kernel text in WRITE_KERN
  lkdtm: Fix lkdtm_EXEC_RODATA()
  lkdtm: Fix execute_[user]_location()

 arch/ia64/include/asm/elf.h         |  2 +-
 arch/ia64/include/asm/sections.h    | 24 ++---------
 arch/ia64/kernel/module.c           |  6 +--
 arch/parisc/include/asm/sections.h  | 16 +++----
 arch/parisc/kernel/process.c        | 21 ---------
 arch/powerpc/include/asm/elf.h      |  7 +++
 arch/powerpc/include/asm/sections.h | 30 +++----------
 arch/powerpc/include/uapi/asm/elf.h |  8 ----
 arch/powerpc/kernel/module_64.c     |  6 +--
 drivers/misc/lkdtm/perms.c          | 66 +++++++++++++++++++++++------
 include/asm-generic/sections.h      | 24 ++++++++++-
 11 files changed, 102 insertions(+), 108 deletions(-)

-- 
2.31.1

