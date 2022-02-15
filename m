Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF24B6C6D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiBOMnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:43:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiBOMnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:43:23 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 04:42:33 PST
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0119108BFA;
        Tue, 15 Feb 2022 04:42:33 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jygh01Dlnz9sSX;
        Tue, 15 Feb 2022 13:41:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AdVA4GYDqysE; Tue, 15 Feb 2022 13:41:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn5Pmtz9sSr;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A796A8B77B;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y7YqB1ka0taE; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 990F58B787;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfFnd080612
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:15 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfFRU080611;
        Tue, 15 Feb 2022 13:41:15 +0100
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
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 02/13] powerpc: Move and rename func_descr_t
Date:   Tue, 15 Feb 2022 13:40:57 +0100
Message-Id: <529b2ba1d001e8f628ef0d30e8044c9b3d0a4921.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=3244; s=20211009; h=from:subject:message-id; bh=LqqoaonBtqrRWO7nIvfTkS8r91LiUnK51Ncu6Lun4RA=; b=l/zPBQYl8yBdmxldOkocCbn13em50/dw7rkzc5D/bqb0Lb2Xx5ZaCRaHZLOvAiay3K9nW1KQxvIT CjmLjjXbDjWi8nC0KGLhVF52fUkvmlgH+YDyGWUK80uzShnYFR7H
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

There are three architectures with function descriptors, try to
have common names for the address they contain in order to
refactor some functions into generic functions later.

powerpc has 'entry'
ia64 has 'ip'
parisc has 'addr'

Vote for 'addr' and update 'func_descr_t' accordingly.

Move it in asm/elf.h to have it at the same place on all
three architectures, remove the typedef which hides its real
type, and change it to a smoother name 'struct func_desc'.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/include/asm/code-patching.h | 2 +-
 arch/powerpc/include/asm/elf.h           | 6 ++++++
 arch/powerpc/include/asm/types.h         | 6 ------
 arch/powerpc/kernel/signal_64.c          | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index e26080539c31..409483b2d0ce 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -118,7 +118,7 @@ static inline unsigned long ppc_function_entry(void *func)
 	 * function's descriptor. The first entry in the descriptor is the
 	 * address of the function text.
 	 */
-	return ((func_descr_t *)func)->entry;
+	return ((struct func_desc *)func)->addr;
 #else
 	return (unsigned long)func;
 #endif
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index b8425e3cfd81..971589a21bc0 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -176,4 +176,10 @@ do {									\
 /* Relocate the kernel image to @final_address */
 void relocate(unsigned long final_address);
 
+struct func_desc {
+	unsigned long addr;
+	unsigned long toc;
+	unsigned long env;
+};
+
 #endif /* _ASM_POWERPC_ELF_H */
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
index d1e1fc0acbea..73d483b07ff3 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -936,11 +936,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		 * descriptor is the entry address of signal and the second
 		 * entry is the TOC value we need to use.
 		 */
-		func_descr_t __user *funct_desc_ptr =
-			(func_descr_t __user *) ksig->ka.sa.sa_handler;
+		struct func_desc __user *ptr =
+			(struct func_desc __user *)ksig->ka.sa.sa_handler;
 
-		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
-		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
+		err |= get_user(regs->ctr, &ptr->addr);
+		err |= get_user(regs->gpr[2], &ptr->toc);
 	}
 
 	/* enter the signal handler in native-endian mode */
-- 
2.34.1

