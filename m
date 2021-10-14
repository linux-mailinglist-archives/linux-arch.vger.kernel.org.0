Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3D42D26F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhJNG0y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:26:54 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhJNG0u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:26:50 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVK9b1wnPz9sSt;
        Thu, 14 Oct 2021 08:24:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f2Rd36rn3GCA; Thu, 14 Oct 2021 08:24:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9X3Ll5z9sSX;
        Thu, 14 Oct 2021 08:24:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CE798B788;
        Thu, 14 Oct 2021 08:24:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zJQXppQHgLTd; Thu, 14 Oct 2021 08:24:00 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E6C38B763;
        Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oPYM2266006
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:50:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oPYi2266005;
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
Subject: [PATCH v2 03/13] powerpc: Remove func_descr_t
Date:   Thu, 14 Oct 2021 07:49:52 +0200
Message-Id: <16eef6afbf7322d0c07760ebf827b8f9f50f7c6e.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190596; l=2274; s=20211009; h=from:subject:message-id; bh=VRsGkEGBMOebT93pGfIshHYcGzydfljiyRGDo67E2zY=; b=34wBjxD0rsUM9f+vSYxm6Wm0C/PHyH0Gch1Kt5bPoCLI7tkaoInhSHpzjldsxHkqC5EmGSXgtBlp 161Ge1bKCaQbtM2CO5xIx0mcQEG1HnP6uo8qzgjzxfZSlrwVjpuN
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'func_descr_t' is redundant with 'struct ppc64_opd_entry'

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h | 2 +-
 arch/powerpc/include/asm/types.h         | 6 ------
 arch/powerpc/kernel/signal_64.c          | 8 ++++----
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 4ba834599c4d..f3445188d319 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -110,7 +110,7 @@ static inline unsigned long ppc_function_entry(void *func)
 	 * function's descriptor. The first entry in the descriptor is the
 	 * address of the function text.
 	 */
-	return ((func_descr_t *)func)->entry;
+	return ((struct ppc64_opd_entry *)func)->addr;
 #else
 	return (unsigned long)func;
 #endif
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index f1630c553efe..97da77bc48c9 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -23,12 +23,6 @@
 
 typedef __vector128 vector128;
 
-typedef struct {
-	unsigned long entry;
-	unsigned long toc;
-	unsigned long env;
-} func_descr_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_TYPES_H */
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1831bba0582e..63ddbe7b108c 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -933,11 +933,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		 * descriptor is the entry address of signal and the second
 		 * entry is the TOC value we need to use.
 		 */
-		func_descr_t __user *funct_desc_ptr =
-			(func_descr_t __user *) ksig->ka.sa.sa_handler;
+		struct ppc64_opd_entry __user *funct_desc_ptr =
+			(struct ppc64_opd_entry __user *)ksig->ka.sa.sa_handler;
 
-		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
-		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
+		err |= get_user(regs->ctr, &funct_desc_ptr->addr);
+		err |= get_user(regs->gpr[2], &funct_desc_ptr->r2);
 	}
 
 	/* enter the signal handler in native-endian mode */
-- 
2.31.1

