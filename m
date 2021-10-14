Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5942D28F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhJNG1s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:27:48 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJNG1e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:27:34 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVK9k0jTLz9sSq;
        Thu, 14 Oct 2021 08:24:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yoXsf0XoIfDi; Thu, 14 Oct 2021 08:24:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9h6DJ2z9sSj;
        Thu, 14 Oct 2021 08:24:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF9868B788;
        Thu, 14 Oct 2021 08:24:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LKfjLBkU0UfT; Thu, 14 Oct 2021 08:24:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 332298B763;
        Thu, 14 Oct 2021 08:24:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oQlL2266026
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:50:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oQWa2266025;
        Thu, 14 Oct 2021 07:50:26 +0200
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
Subject: [PATCH v2 08/13] asm-generic: Refactor dereference_[kernel]_function_descriptor()
Date:   Thu, 14 Oct 2021 07:49:57 +0200
Message-Id: <865b5c872814e3291fe7afabcc110f53b3457b56.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190596; l=6020; s=20211009; h=from:subject:message-id; bh=Beenc/HKIv8Qw9J69pivFSeJsEY8dJoKXYnYkVMAlIk=; b=MJGX7q0F8r7PLyqPmuYd/jpiCe/3eR+fAPwH+jHYgKe/8h7Ws88Gb/vKU3vrrKIjQxMkbkzGl+nV yTj4ot2iDDEr7alseyeEg6ORHat9ahgkL3tzwrvLTEmemSiHcqJ3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dereference_function_descriptor() and
dereference_kernel_function_descriptor() are identical on the
three architectures implementing them.

Make them common and put them out-of-line in kernel/extable.c
which is one of the users and has similar type of functions.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/ia64/include/asm/sections.h    | 19 -------------------
 arch/parisc/include/asm/sections.h  |  9 ---------
 arch/parisc/kernel/process.c        | 21 ---------------------
 arch/powerpc/include/asm/sections.h | 23 -----------------------
 include/asm-generic/sections.h      |  2 ++
 kernel/extable.c                    | 23 ++++++++++++++++++++++-
 6 files changed, 24 insertions(+), 73 deletions(-)

diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 1aaed8882294..96c9bb500c34 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -31,23 +31,4 @@ extern char __start_gate_brl_fsys_bubble_down_patchlist[], __end_gate_brl_fsys_b
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
index 37b34b357cb5..6b1fe22baaf5 100644
--- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -13,13 +13,4 @@ typedef Elf64_Fdesc func_desc_t;
 
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
index 1322d7b2f1a3..fbfe1957edbe 100644
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
index cbec7d5f1678..76163883c6ff 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -60,6 +60,8 @@ extern __visible const void __nosave_begin, __nosave_end;
 
 /* Function descriptor handling (if any).  Override in asm/sections.h */
 #ifdef HAVE_FUNCTION_DESCRIPTORS
+void *dereference_function_descriptor(void *ptr);
+void *dereference_kernel_function_descriptor(void *ptr);
 #else
 #define dereference_function_descriptor(p) ((void *)(p))
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
diff --git a/kernel/extable.c b/kernel/extable.c
index b0ea5eb0c3b4..013ccffade11 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -3,6 +3,7 @@
    Copyright (C) 2001 Rusty Russell, 2002 Rusty Russell IBM.
 
 */
+#include <linux/elf.h>
 #include <linux/ftrace.h>
 #include <linux/memory.h>
 #include <linux/extable.h>
@@ -159,12 +160,32 @@ int kernel_text_address(unsigned long addr)
 }
 
 /*
- * On some architectures (PPC64, IA64) function pointers
+ * On some architectures (PPC64, IA64, PARISC) function pointers
  * are actually only tokens to some data that then holds the
  * real function address. As a result, to find if a function
  * pointer is part of the kernel text, we need to do some
  * special dereferencing first.
  */
+#ifdef HAVE_FUNCTION_DESCRIPTORS
+void *dereference_function_descriptor(void *ptr)
+{
+	func_desc_t *desc = ptr;
+	void *p;
+
+	if (!get_kernel_nofault(p, (void *)&desc->addr))
+		ptr = p;
+	return ptr;
+}
+
+void *dereference_kernel_function_descriptor(void *ptr)
+{
+	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
+		return ptr;
+
+	return dereference_function_descriptor(ptr);
+}
+#endif
+
 int func_ptr_is_kernel_text(void *ptr)
 {
 	unsigned long addr;
-- 
2.31.1

