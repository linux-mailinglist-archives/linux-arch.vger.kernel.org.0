Return-Path: <linux-arch+bounces-8007-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB89997E3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5DD1C24882
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCEF195803;
	Fri, 11 Oct 2024 00:21:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A31953A3;
	Fri, 11 Oct 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606070; cv=none; b=fJA/gC28f+tLMsEkTf8WU86V4e7ySA52JTWxu5bj7bokLqjw45CY1YwttL7LRBKjSPRPyayKR4W6xVYs5PGD6AfPzFHx3Fi/Yk4oWUpOYl4uMJXPAzEnJkBMYGufo0O7QEQQzsU0T+zV6cuD7syZy7/Ht31RnWPgsWL1lQPTUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606070; c=relaxed/simple;
	bh=vBguymaNlfDLBcQvi27SonEvz0Yt1tvxdBXq+XLi4aE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WSma9pl0A5eQQGvKZ1mXrvVYDoGjnGFRTNG51Zwu0Bjj1dh3fjHimaMaUzN52qJs+MhmXuXhsh6Bl0SvpV+MeM+6LirwTg5XXrMW/Q09wA8ZPdBhcjlZBavhaRZsIFKtvrgWWHmEfXnRzwo6hT5dZzf1slWL3DcC7HjoNkTOOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3712EC4CECE;
	Fri, 11 Oct 2024 00:21:06 +0000 (UTC)
Date: Thu, 10 Oct 2024 20:21:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul 
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas 
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav 
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3] ftrace: Consolidate ftrace_regs accessor functions for
 archs using pt_regs
Message-ID: <20241010202114.2289f6fd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Most architectures use pt_regs within ftrace_regs making a lot of the
accessor functions just calls to the pt_regs internally. Instead of
duplication this effort, use a HAVE_ARCH_FTRACE_REGS for architectures
that have their own ftrace_regs that is not based on pt_regs and will
define all the accessor functions, and for the architectures that just use
pt_regs, it will leave it undefined, and the default accessor functions
will be used.

Note, this will also make it easier to add new accessor functions to
ftrace_regs as it will mean having to touch less architectures.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20241008230629.118325673@goodmis.org

- Fixed #ifdef header protection to match the name (Masami Hiramatsu)

 arch/arm64/include/asm/ftrace.h     |  1 +
 arch/loongarch/include/asm/ftrace.h | 25 +-------------------
 arch/powerpc/include/asm/ftrace.h   | 26 +--------------------
 arch/riscv/include/asm/ftrace.h     |  1 +
 arch/s390/include/asm/ftrace.h      | 26 +--------------------
 arch/x86/include/asm/ftrace.h       | 21 +----------------
 include/linux/ftrace.h              | 32 ++++++-------------------
 include/linux/ftrace_regs.h         | 36 +++++++++++++++++++++++++++++
 8 files changed, 49 insertions(+), 119 deletions(-)
 create mode 100644 include/linux/ftrace_regs.h

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index bbb69c7751b9..5ccff4de7f09 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -54,6 +54,7 @@ extern void return_to_handler(void);
 unsigned long ftrace_call_adjust(unsigned long addr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define HAVE_ARCH_FTRACE_REGS
 struct dyn_ftrace;
 struct ftrace_ops;
 struct ftrace_regs;
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 0e15d36ce251..8f13eaeaa325 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -43,43 +43,20 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent);
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_ops;
-struct ftrace_regs;
-#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
 
-struct __arch_ftrace_regs {
-	struct pt_regs regs;
-};
+#include <linux/ftrace_regs.h>
 
 static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	return &arch_ftrace_regs(fregs)->regs;
 }
 
-static __always_inline unsigned long
-ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
-{
-	return instruction_pointer(&arch_ftrace_regs(fregs)->regs);
-}
-
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 {
 	instruction_pointer_set(&arch_ftrace_regs(fregs)->regs, ip);
 }
 
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index e299fd47d201..0edfb874eb02 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -32,12 +32,7 @@ struct dyn_arch_ftrace {
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
-struct ftrace_regs;
-#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
-
-struct __arch_ftrace_regs {
-	struct pt_regs regs;
-};
+#include <linux/ftrace_regs.h>
 
 static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
@@ -52,25 +47,6 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_set_return_ip(&arch_ftrace_regs(fregs)->regs, ip);
 }
 
-static __always_inline unsigned long
-ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
-{
-	return instruction_pointer(&arch_ftrace_regs(fregs)->regs);
-}
-
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-
 struct ftrace_ops;
 
 #define ftrace_graph_func ftrace_graph_func
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c6bcdff105b5..3d66437a1029 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -125,6 +125,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 #define arch_ftrace_get_regs(regs) NULL
+#define HAVE_ARCH_FTRACE_REGS
 struct ftrace_ops;
 struct ftrace_regs;
 #define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 1498d0a9c762..fc97d75dc752 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -51,12 +51,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
-struct ftrace_regs;
-#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
-
-struct __arch_ftrace_regs {
-	struct pt_regs regs;
-};
+#include <linux/ftrace_regs.h>
 
 static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
@@ -84,12 +79,6 @@ static __always_inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-static __always_inline unsigned long
-ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
-{
-	return arch_ftrace_regs(fregs)->regs.psw.addr;
-}
-
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
@@ -97,19 +86,6 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	arch_ftrace_regs(fregs)->regs.psw.addr = ip;
 }
 
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 87943f7a299b..8f02d28c571a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -33,12 +33,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 }
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-struct ftrace_regs;
-#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
 
-struct __arch_ftrace_regs {
-	struct pt_regs		regs;
-};
+#include <linux/ftrace_regs.h>
 
 static __always_inline struct pt_regs *
 arch_ftrace_get_regs(struct ftrace_regs *fregs)
@@ -52,21 +48,6 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { arch_ftrace_regs(fregs)->regs.ip = (_ip); } while (0)
 
-#define ftrace_regs_get_instruction_pointer(fregs) \
-	arch_ftrace_regs(fregs)->regs.ip)
-
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
 
 struct ftrace_ops;
 #define ftrace_graph_func ftrace_graph_func
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 66f10291a0b2..aa9ddd1e4bb6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -113,6 +113,8 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 
 #ifdef CONFIG_FUNCTION_TRACER
 
+#include <linux/ftrace_regs.h>
+
 extern int ftrace_enabled;
 
 /**
@@ -150,14 +152,11 @@ struct ftrace_regs {
 #define ftrace_regs_size()	sizeof(struct __arch_ftrace_regs)
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-
-struct __arch_ftrace_regs {
-	struct pt_regs		regs;
-};
-
-struct ftrace_regs;
-#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
-
+/*
+ * Architectures that define HAVE_DYNAMIC_FTRACE_WITH_ARGS must define their own
+ * arch_ftrace_get_regs() where it only returns pt_regs *if* it is fully
+ * populated. It should return NULL otherwise.
+ */
 static inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	return &arch_ftrace_regs(fregs)->regs;
@@ -191,23 +190,6 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	return ftrace_get_regs(fregs) != NULL;
 }
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-#define ftrace_regs_get_instruction_pointer(fregs) \
-	instruction_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(ftrace_get_regs(fregs))
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(ftrace_get_regs(fregs), ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(ftrace_get_regs(fregs))
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-#endif
-
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);
 
diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
new file mode 100644
index 000000000000..dea6a0851b74
--- /dev/null
+++ b/include/linux/ftrace_regs.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FTRACE_REGS_H
+#define _LINUX_FTRACE_REGS_H
+
+/*
+ * For archs that just copy pt_regs in ftrace regs, it can use this default.
+ * If an architecture does not use pt_regs, it must define all the below
+ * accessor functions.
+ */
+#ifndef HAVE_ARCH_FTRACE_REGS
+struct __arch_ftrace_regs {
+	struct pt_regs		regs;
+};
+
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
+
+struct ftrace_regs;
+
+#define ftrace_regs_get_instruction_pointer(fregs) \
+	instruction_pointer(arch_ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(arch_ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(arch_ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(arch_ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(arch_ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(arch_ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
+#endif /* HAVE_ARCH_FTRACE_REGS */
+
+#endif /* _LINUX_FTRACE_REGS_H */
-- 
2.45.2


