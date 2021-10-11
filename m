Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3D429335
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbhJKP3J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 11:29:09 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59181 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238942AbhJKP3C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 11:29:02 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HSjM75wHKz9sV5;
        Mon, 11 Oct 2021 17:26:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EdOpf22EnJVN; Mon, 11 Oct 2021 17:26:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM308Zlz9sTw;
        Mon, 11 Oct 2021 17:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D03C68B780;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vCLQSO4on9vD; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32F5C8B76E;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQWrM1585027
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:26:32 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQWoi1585026;
        Mon, 11 Oct 2021 17:26:32 +0200
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
Subject: [PATCH v1 06/10] asm-generic: Refactor dereference_[kernel]_function_descriptor()
Date:   Mon, 11 Oct 2021 17:25:33 +0200
Message-Id: <c215b244a19a07327ec81bf99f3c5f89c68af7b4.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633964380.git.christophe.leroy@csgroup.eu>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965928; l=4822; s=20211009; h=from:subject:message-id; bh=5EkQJtFr4QOcxWCtP/cBPR4MyhRhSYFoWYDbXV9TsBU=; b=AA6jt9XXJDAAQS98iFCCWQBrYd5L1DlIAdqIpbW2TUiOYLIhFS6u2ArGaf8BXgkb0I07REtQBR++ lEYh9+8dAIHGL7/N4rjeQaZzrRAYz3XbIQRqj5YH/gqPUvq4UwB3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dereference_function_descriptor() and
dereference_kernel_function_descriptor() are identical on the
three architectures implementing them.

Make it common.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/ia64/include/asm/sections.h    | 19 -------------------
 arch/parisc/include/asm/sections.h  |  9 ---------
 arch/parisc/kernel/process.c        | 21 ---------------------
 arch/powerpc/include/asm/sections.h | 23 -----------------------
 include/asm-generic/sections.h      | 18 ++++++++++++++++++
 5 files changed, 18 insertions(+), 72 deletions(-)

diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 929b5c535620..d9addaea8339 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -30,23 +30,4 @@ extern char __start_gate_brl_fsys_bubble_down_patchlist[], __end_gate_brl_fsys_b
 extern char __start_unwind[], __end_unwind[];
 extern char __start_ivt_text[], __end_ivt_text[];
 
-#undef dereference_function_descriptor
-static inline void *dereference_function_descriptor(void *ptr)
-{
-	struct fdesc *desc = ptr;
-	void *p;
-
-	if (!get_kernel_nofault(p, (void *)&desc->addr))
-		ptr = p;
-	return ptr;
-}
-
-#undef dereference_kernel_function_descriptor
-static inline void *dereference_kernel_function_descriptor(void *ptr)
-{
-	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
-		return ptr;
-	return dereference_function_descriptor(ptr);
-}
-
 #endif /* _ASM_IA64_SECTIONS_H */
diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
index 329e80f7af0a..b041fb32a300 100644
--- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -12,13 +12,4 @@ typedef Elf64_Fdesc funct_descr_t;
 
 extern char __alt_instructions[], __alt_instructions_end[];
 
-#ifdef CONFIG_64BIT
-
-#undef dereference_function_descriptor
-void *dereference_function_descriptor(void *);
-
-#undef dereference_kernel_function_descriptor
-void *dereference_kernel_function_descriptor(void *);
-#endif
-
 #endif
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 38ec4ae81239..7382576b52a8 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -266,27 +266,6 @@ get_wchan(struct task_struct *p)
 	return 0;
 }
 
-#ifdef CONFIG_64BIT
-void *dereference_function_descriptor(void *ptr)
-{
-	Elf64_Fdesc *desc = ptr;
-	void *p;
-
-	if (!get_kernel_nofault(p, (void *)&desc->addr))
-		ptr = p;
-	return ptr;
-}
-
-void *dereference_kernel_function_descriptor(void *ptr)
-{
-	if (ptr < (void *)__start_opd ||
-			ptr >= (void *)__end_opd)
-		return ptr;
-
-	return dereference_function_descriptor(ptr);
-}
-#endif
-
 static inline unsigned long brk_rnd(void)
 {
 	return (get_random_int() & BRK_RND_MASK) << PAGE_SHIFT;
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index d0d5287fa568..8f8e95f234e2 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -72,29 +72,6 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
 		(unsigned long)_stext < end;
 }
 
-#ifdef PPC64_ELF_ABI_v1
-
-#undef dereference_function_descriptor
-static inline void *dereference_function_descriptor(void *ptr)
-{
-	struct ppc64_opd_entry *desc = ptr;
-	void *p;
-
-	if (!get_kernel_nofault(p, (void *)&desc->addr))
-		ptr = p;
-	return ptr;
-}
-
-#undef dereference_kernel_function_descriptor
-static inline void *dereference_kernel_function_descriptor(void *ptr)
-{
-	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
-		return ptr;
-
-	return dereference_function_descriptor(ptr);
-}
-#endif /* PPC64_ELF_ABI_v1 */
-
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 436412d94054..5baaf9d7c671 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -60,6 +60,24 @@ extern __visible const void __nosave_begin, __nosave_end;
 
 /* Function descriptor handling (if any).  Override in asm/sections.h */
 #ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
+static inline void *dereference_function_descriptor(void *ptr)
+{
+	funct_descr_t *desc = ptr;
+	void *p;
+
+	if (!get_kernel_nofault(p, (void *)&desc->addr))
+		ptr = p;
+	return ptr;
+}
+
+static inline void *dereference_kernel_function_descriptor(void *ptr)
+{
+	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
+		return ptr;
+
+	return dereference_function_descriptor(ptr);
+}
+
 #else
 #define dereference_function_descriptor(p) ((void *)(p))
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
-- 
2.31.1

