Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812A84308F0
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbhJQMmi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 08:42:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49285 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343542AbhJQMmV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Oct 2021 08:42:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXKMB0l09z9sSp;
        Sun, 17 Oct 2021 14:39:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0iADFwnIXuzB; Sun, 17 Oct 2021 14:39:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXKM00jyZz9sSm;
        Sun, 17 Oct 2021 14:39:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE49C8B763;
        Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pORkrTb4S-OG; Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C52A38B770;
        Sun, 17 Oct 2021 14:39:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19HCctGH2946753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 14:38:55 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19HCctmW2946752;
        Sun, 17 Oct 2021 14:38:55 +0200
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
Subject: [PATCH v3 06/12] asm-generic: Define CONFIG_HAVE_FUNCTION_DESCRIPTORS
Date:   Sun, 17 Oct 2021 14:38:19 +0200
Message-Id: <ad0eb12f6e3f49b4a3284fc54c4c4d70c496609e.1634457599.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634457599.git.christophe.leroy@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634474303; l=6346; s=20211009; h=from:subject:message-id; bh=nu7oXs14fpeAfq53YVuCy2rKD7V0fh63/6kmiRRPN/g=; b=8LF0A8GlsMp7UliY0Y3lPsblsU7jwr8bAKotIHGF9qVCj+K3fBJNKZNMxAXYHi0Wc7k+SH6l8EXv My5/3jXABBFd8Qhn5im0wLvG9FZP7ZpEHrtP7yYMGkwQbSRb1h3L
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR by a config option
named CONFIG_HAVE_FUNCTION_DESCRIPTORS and use it instead of
'dereference_function_descriptor' macro to know whether an
arch has function descriptors.

To limit churn in one of the following patches, use
an #ifdef/#else construct with empty first part
instead of an #ifndef in asm-generic/sections.h

On powerpc, make sure the config option matches the ABI used
by the compiler with a BUILD_BUG_ON().

And include a helper to check whether an arch has function
descriptors or not : have_function_descriptors()

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/Kconfig                        | 3 +++
 arch/ia64/Kconfig                   | 1 +
 arch/ia64/include/asm/sections.h    | 2 --
 arch/parisc/Kconfig                 | 1 +
 arch/parisc/include/asm/sections.h  | 2 --
 arch/powerpc/Kconfig                | 1 +
 arch/powerpc/include/asm/sections.h | 2 --
 arch/powerpc/kernel/ptrace/ptrace.c | 6 ++++++
 include/asm-generic/sections.h      | 8 +++++++-
 include/linux/kallsyms.h            | 2 +-
 10 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..6e610a53d832 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -197,6 +197,9 @@ config HAVE_FUNCTION_ERROR_INJECTION
 config HAVE_NMI
 	bool
 
+config HAVE_FUNCTION_DESCRIPTORS
+	bool
+
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 1e33666fa679..97cf02951610 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -34,6 +34,7 @@ config IA64
 	select HAVE_FUNCTION_TRACER
 	select TTY
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_FUNCTION_DESCRIPTORS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HUGETLB_PAGE_SIZE_VARIABLE if HUGETLB_PAGE
 	select VIRT_TO_BUS
diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 35f24e52149a..2460d365a057 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -27,8 +27,6 @@ extern char __start_gate_brl_fsys_bubble_down_patchlist[], __end_gate_brl_fsys_b
 extern char __start_unwind[], __end_unwind[];
 extern char __start_ivt_text[], __end_ivt_text[];
 
-#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
-
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 27a8b49af11f..01d46ca32119 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -65,6 +65,7 @@ config PARISC
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select TRACE_IRQFLAGS_SUPPORT
+	select HAVE_FUNCTION_DESCRIPTORS if 64BIT
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
index bb52aea0cb21..c8092e4d94de 100644
--- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -9,8 +9,6 @@ extern char __alt_instructions[], __alt_instructions_end[];
 
 #ifdef CONFIG_64BIT
 
-#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
-
 #undef dereference_function_descriptor
 void *dereference_function_descriptor(void *);
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba5b66189358..0effedba082f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -208,6 +208,7 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_DESCRIPTORS	if PPC64 && !CPU_LITTLE_ENDIAN
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index abd2e5213197..fb11544d7e6a 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -69,8 +69,6 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
 
 #ifdef PPC64_ELF_ABI_v1
 
-#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
-
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 7c7093c17c45..740b682caa73 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -446,4 +446,10 @@ void __init pt_regs_check(void)
 	 * real registers.
 	 */
 	BUILD_BUG_ON(PT_DSCR < sizeof(struct user_pt_regs) / sizeof(unsigned long));
+
+#ifdef PPC64_ELF_ABI_v1
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS));
+#else
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS));
+#endif
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d16302d3eb59..a918388d9bf6 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -59,11 +59,17 @@ extern char __noinstr_text_start[], __noinstr_text_end[];
 extern __visible const void __nosave_begin, __nosave_end;
 
 /* Function descriptor handling (if any).  Override in asm/sections.h */
-#ifndef dereference_function_descriptor
+#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
+#else
 #define dereference_function_descriptor(p) ((void *)(p))
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
 #endif
 
+static inline bool have_function_descriptors(void)
+{
+	return IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS);
+}
+
 /* random extra sections (if any).  Override
  * in asm/sections.h */
 #ifndef arch_is_kernel_text
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index a1d6fc82d7f0..18799df0c9bf 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -57,7 +57,7 @@ static inline int is_ksym_addr(unsigned long addr)
 
 static inline void *dereference_symbol_descriptor(void *ptr)
 {
-#ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
+#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
 	struct module *mod;
 
 	ptr = dereference_kernel_function_descriptor(ptr);
-- 
2.31.1

