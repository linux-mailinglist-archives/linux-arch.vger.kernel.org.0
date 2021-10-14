Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B342D25F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJNG0a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:26:30 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhJNG0N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:26:13 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVK9X1GY9z9sSd;
        Thu, 14 Oct 2021 08:24:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QjC74sV80z94; Thu, 14 Oct 2021 08:24:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9W11DPz9sSX;
        Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C6FB8B788;
        Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ugMc1xH9Fww5; Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B53B48B763;
        Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oPCJ2265998
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:50:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oP5E2265997;
        Thu, 14 Oct 2021 07:50:25 +0200
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
Subject: [PATCH v2 01/13] powerpc: Move 'struct ppc64_opd_entry' back into asm/elf.h
Date:   Thu, 14 Oct 2021 07:49:50 +0200
Message-Id: <42d2a571677e60082c0a5b3e52e855aa58c0b1fc.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190596; l=1879; s=20211009; h=from:subject:message-id; bh=2f4ibwhAezmqIACsGc1fDVfrk+2UKNH5S1fknYBY7Tw=; b=LoEdUcLtxLfXXffuYAaf27d1G5gpJ8L6VCpwG27CcfyNOWgMyG2ghHVz/bSVM5bx8j+Z2EO2NByo PnuivXqWBwJVG2wqbP5zJfEKx05xvKkG+E6ydde9Lv5Jw97aF7+R
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'struct ppc64_opd_entry' doesn't belong to uapi/asm/elf.h

It was initially in module_64.c and commit 2d291e902791 ("Fix compile
failure with non modular builds") moved it into asm/elf.h

But it was by mistake added outside of __KERNEL__ section,
therefore commit c3617f72036c ("UAPI: (Scripted) Disintegrate
arch/powerpc/include/asm") moved it to uapi/asm/elf.h

Move it back into asm/elf.h, this brings it back in line with
IA64 and PARISC architectures.

Fixes: 2d291e902791 ("Fix compile failure with non modular builds")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/elf.h      | 6 ++++++
 arch/powerpc/include/uapi/asm/elf.h | 8 --------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index b8425e3cfd81..a4406714c060 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -176,4 +176,10 @@ do {									\
 /* Relocate the kernel image to @final_address */
 void relocate(unsigned long final_address);
 
+/* There's actually a third entry here, but it's unused */
+struct ppc64_opd_entry {
+	unsigned long funcaddr;
+	unsigned long r2;
+};
+
 #endif /* _ASM_POWERPC_ELF_H */
diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 860c59291bfc..308857123a08 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -289,12 +289,4 @@ typedef elf_fpreg_t elf_vsrreghalf_t32[ELF_NVSRHALFREG];
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		253
 
-/* There's actually a third entry here, but it's unused */
-struct ppc64_opd_entry
-{
-	unsigned long funcaddr;
-	unsigned long r2;
-};
-
-
 #endif /* _UAPI_ASM_POWERPC_ELF_H */
-- 
2.31.1

