Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EC4B6C72
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiBOMn1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:43:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiBOMnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:43:12 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261122501;
        Tue, 15 Feb 2022 04:42:25 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jyggz1cpNz9sSq;
        Tue, 15 Feb 2022 13:41:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ygJ3UyKJHqLM; Tue, 15 Feb 2022 13:41:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn4h6fz9sSX;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D27B8B779;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PL6BRtanFc_l; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D3DD8B778;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfHWk080641
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:17 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfHcY080640;
        Tue, 15 Feb 2022 13:41:17 +0100
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
Subject: [PATCH v4 09/13] asm-generic: Refactor dereference_[kernel]_function_descriptor()
Date:   Tue, 15 Feb 2022 13:41:04 +0100
Message-Id: <449db09b2eba57f4ab05f80102a67d8675bc8bcd.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=6070; s=20211009; h=from:subject:message-id; bh=CdIVQKasdpBgdmomPazTCG73sEDMnNgALJd79AHoobQ=; b=H5tUJuA/HGnvpKCb0O+3tHPXe2m6sX64gZl2Whn9WCxSA8UR+8eJrBAd1r8ayJF6t+O2dGKAPPMY c+/d/m+BCQSUn4gYfSu1GCHSgn2vwKjtL0grUiOg5AYWDpVPyf1e
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

dereference_function_descriptor() and
dereference_kernel_function_descriptor() are identical on the
three architectures implementing them.

Make them common and put them out-of-line in kernel/extable.c
which is one of the users and has similar type of functions.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/ia64/include/asm/sections.h    | 19 -------------------
 arch/parisc/include/asm/sections.h  |  9 ---------
 arch/parisc/kernel/process.c        | 21 ---------------------
 arch/powerpc/include/asm/sections.h | 23 -----------------------
 include/asm-generic/sections.h      |  2 ++
 kernel/extable.c                    | 23 ++++++++++++++++++++++-
 6 files changed, 24 insertions(+), 73 deletions(-)

diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 3abe0562b01a..8e0875cf6071 100644
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
index ace1d4047a0b..33df42b5cc6d 100644
--- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -12,13 +12,4 @@ typedef Elf64_Fdesc func_desc_t;
 
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
index ea3d83b6fb62..2030c77592d3 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -263,27 +263,6 @@ __get_wchan(struct task_struct *p)
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
index fddfb3937868..8be2c491c733 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -58,29 +58,6 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
 		(unsigned long)_stext < end;
 }
 
-#ifdef PPC64_ELF_ABI_v1
-
-#undef dereference_function_descriptor
-static inline void *dereference_function_descriptor(void *ptr)
-{
-	struct func_desc *desc = ptr;
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
index bbf97502470c..d0f7bdd2fdf2 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -60,6 +60,8 @@ extern __visible const void __nosave_begin, __nosave_end;
 
 /* Function descriptor handling (if any).  Override in asm/sections.h */
 #ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
+void *dereference_function_descriptor(void *ptr);
+void *dereference_kernel_function_descriptor(void *ptr);
 #else
 #define dereference_function_descriptor(p) ((void *)(p))
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
diff --git a/kernel/extable.c b/kernel/extable.c
index b6f330f0fe74..394c39b86e38 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -3,6 +3,7 @@
    Copyright (C) 2001 Rusty Russell, 2002 Rusty Russell IBM.
 
 */
+#include <linux/elf.h>
 #include <linux/ftrace.h>
 #include <linux/memory.h>
 #include <linux/extable.h>
@@ -132,12 +133,32 @@ int kernel_text_address(unsigned long addr)
 }
 
 /*
- * On some architectures (PPC64, IA64) function pointers
+ * On some architectures (PPC64, IA64, PARISC) function pointers
  * are actually only tokens to some data that then holds the
  * real function address. As a result, to find if a function
  * pointer is part of the kernel text, we need to do some
  * special dereferencing first.
  */
+#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
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
2.34.1

