Return-Path: <linux-arch+bounces-8142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58599DB77
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F3D1C217BE
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3A15B115;
	Tue, 15 Oct 2024 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu3vohBA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67615853B;
	Tue, 15 Oct 2024 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955872; cv=none; b=JbxAGeQm27eh6v81fDrCGkYvrYxpX9h30IBeqS7v4XHNO4srYWkzoT3dS9sVnGejSyZuknbiDmz3IoSr7zzfLaBajVZlHeQbv9D80WPq7qmaZZviCT2KrKbB27DkAu4mU2DegDUxIE7vxqnDzPhMoYu4Urf3+w8cnC5z4hwEYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955872; c=relaxed/simple;
	bh=znwOeJiL1OokA6M6w5qE/RYWd1MFe/p6y/VWrsmktAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwLStP20BHvMbTOJCZ/D2GutkfvQL3c9dAoh7itHWB9m7xWVau06t08ADDnC1dT8qnZatYeOJoM0It4dQn/9IWXkcvLlmQyKMt6TIdB0k6gZG2kEStQu0VDDh9oaylnV3bro6TxzPdpfIQKcm5whzfRBoyoBgv+HC7mnZUVyeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu3vohBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05586C4CEC3;
	Tue, 15 Oct 2024 01:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728955872;
	bh=znwOeJiL1OokA6M6w5qE/RYWd1MFe/p6y/VWrsmktAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bu3vohBAsHgHJrLIlAsvz2QoOdXqc0tp11iwG6BZ01MgVuEgeAkPeXcmNpSPeWaMh
	 URdObbZd4RNiynHGNtRcEG9YYeU/dntBvIJWhVc/16xJxYuv/uwNn30Z28JzksufWc
	 /+mMIkNbKv/ndkw6F9mbo9giParQeTO17J7OsExtvXWt2U5WZNrRL2DqcsP4HAJoIo
	 9J0W8c/jnPjgz210fd7kRkcMYIvGhTv3jhd2Vp+d+72OK5Rtuw+0BS/dZdBNHmg2TP
	 opEv+HBwJm7yodjafV8MDBM4F5P3Q0/Fnt0K51RoepwY15eLe2PK9UQ2BY3iiZ8ICu
	 7gnI1FFYEJeVQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v16 13/18] fprobe: Rewrite fprobe on function-graph tracer
Date: Tue, 15 Oct 2024 10:31:02 +0900
Message-ID: <172895586274.107311.8863015368072720092.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172895571278.107311.14000164546881236558.stgit@devnote2>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Rewrite fprobe implementation on function-graph tracer.
Major API changes are:
 -  'nr_maxactive' field is deprecated.
 -  This depends on CONFIG_DYNAMIC_FTRACE_WITH_ARGS or
    !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, and
    CONFIG_HAVE_FUNCTION_GRAPH_FREGS. So currently works only
    on x86_64.
 -  Currently the entry size is limited in 15 * sizeof(long).
 -  If there is too many fprobe exit handler set on the same
    function, it will fail to probe.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

---
 Changes in v14:
  - Add ftrace_regs_get_return_addresss() for riscv.
 Changes in v12:
  - Skip updating ftrace hash if not required.
 Changes in v9:
  - Remove unneeded prototype of ftrace_regs_get_return_address().
  - Fix entry data address calculation.
  - Remove DIV_ROUND_UP() from hotpath.
 Changes in v8:
  - Use trace_func_graph_ret/ent_t for fgraph_ops.
  - Update CONFIG_FPROBE dependencies.
  - Add ftrace_regs_get_return_address() for each arch.
 Changes in v3:
  - Update for new reserve_data/retrieve_data API.
  - Fix internal push/pop on fgraph data logic so that it can
    correctly save/restore the returning fprobes.
 Changes in v2:
  - Add more lockdep_assert_held(fprobe_mutex)
  - Use READ_ONCE() and WRITE_ONCE() for fprobe_hlist_node::fp.
  - Add NOKPROBE_SYMBOL() for the functions which is called from
    entry/exit callback.
---
 arch/arm64/include/asm/ftrace.h     |    6 
 arch/loongarch/include/asm/ftrace.h |    6 
 arch/powerpc/include/asm/ftrace.h   |    6 
 arch/riscv/include/asm/ftrace.h     |    5 
 arch/s390/include/asm/ftrace.h      |    6 
 arch/x86/include/asm/ftrace.h       |    6 
 include/linux/fprobe.h              |   53 ++-
 kernel/trace/Kconfig                |    8 
 kernel/trace/fprobe.c               |  639 +++++++++++++++++++++++++----------
 lib/test_fprobe.c                   |   45 --
 10 files changed, 535 insertions(+), 245 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 6493a575664f..d1277dfa0e7a 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -135,6 +135,12 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
 	return arch_ftrace_regs(fregs)->fp;
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_return_address(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->lr;
+}
+
 static __always_inline struct pt_regs *
 ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 {
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index ceb3e3d9c0d3..6e0a99763a9a 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -61,6 +61,12 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 #define ftrace_regs_get_frame_pointer(fregs) \
 	(arch_ftrace_regs(fregs)->regs.regs[22])
 
+static __always_inline unsigned long
+ftrace_regs_get_return_address(struct ftrace_regs *fregs)
+{
+	return *(unsigned long *)(arch_ftrace_regs(fregs)->regs.regs[1]);
+}
+
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 407ce6eccc04..f3e7f0e44701 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -54,6 +54,12 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_set_return_ip(&arch_ftrace_regs(fregs)->regs, ip);
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_return_address(struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->regs.link;
+}
+
 struct ftrace_ops;
 
 #define ftrace_graph_func ftrace_graph_func
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 17e0a13cc386..05b0db7b8458 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -186,6 +186,11 @@ static __always_inline unsigned long ftrace_regs_get_return_value(const struct f
 	return arch_ftrace_regs(fregs)->a0;
 }
 
+static __always_inline unsigned long ftrace_regs_get_return_address(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->ra;
+}
+
 static __always_inline void ftrace_regs_set_return_value(struct ftrace_regs *fregs,
 							 unsigned long ret)
 {
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index f1c0e677a325..9ea23d276219 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -76,6 +76,12 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
 	return ftrace_regs_get_stack_pointer(fregs);
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_return_address(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->regs.gprs[14];
+}
+
 #define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
 		(_regs)->psw.addr = arch_ftrace_regs(fregs)->regs.psw.addr;		\
 		(_regs)->gprs[15] = arch_ftrace_regs(fregs)->regs.gprs[15];		\
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 7e06f8c7937a..cc92c99ef276 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -58,6 +58,12 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	do { arch_ftrace_regs(fregs)->regs.ip = (_ip); } while (0)
 
 
+static __always_inline unsigned long
+ftrace_regs_get_return_address(struct ftrace_regs *fregs)
+{
+	return *(unsigned long *)ftrace_regs_get_stack_pointer(fregs);
+}
+
 struct ftrace_ops;
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index ef609bcca0f9..2d06bbd99601 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -5,10 +5,11 @@
 
 #include <linux/compiler.h>
 #include <linux/ftrace.h>
-#include <linux/rethook.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
 
 struct fprobe;
-
 typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
 			       unsigned long ret_ip, struct ftrace_regs *regs,
 			       void *entry_data);
@@ -17,35 +18,57 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
 			       unsigned long ret_ip, struct ftrace_regs *regs,
 			       void *entry_data);
 
+/**
+ * strcut fprobe_hlist_node - address based hash list node for fprobe.
+ *
+ * @hlist: The hlist node for address search hash table.
+ * @addr: The address represented by this.
+ * @fp: The fprobe which owns this.
+ */
+struct fprobe_hlist_node {
+	struct hlist_node	hlist;
+	unsigned long		addr;
+	struct fprobe		*fp;
+};
+
+/**
+ * struct fprobe_hlist - hash list nodes for fprobe.
+ *
+ * @hlist: The hlist node for existence checking hash table.
+ * @rcu: rcu_head for RCU deferred release.
+ * @fp: The fprobe which owns this fprobe_hlist.
+ * @size: The size of @array.
+ * @array: The fprobe_hlist_node for each address to probe.
+ */
+struct fprobe_hlist {
+	struct hlist_node		hlist;
+	struct rcu_head			rcu;
+	struct fprobe			*fp;
+	int				size;
+	struct fprobe_hlist_node	array[];
+};
+
 /**
  * struct fprobe - ftrace based probe.
- * @ops: The ftrace_ops.
+ *
  * @nmissed: The counter for missing events.
  * @flags: The status flag.
- * @rethook: The rethook data structure. (internal data)
  * @entry_data_size: The private data storage size.
- * @nr_maxactive: The max number of active functions.
+ * @nr_maxactive: The max number of active functions. (*deprecated)
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
+ * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
  */
 struct fprobe {
-#ifdef CONFIG_FUNCTION_TRACER
-	/*
-	 * If CONFIG_FUNCTION_TRACER is not set, CONFIG_FPROBE is disabled too.
-	 * But user of fprobe may keep embedding the struct fprobe on their own
-	 * code. To avoid build error, this will keep the fprobe data structure
-	 * defined here, but remove ftrace_ops data structure.
-	 */
-	struct ftrace_ops	ops;
-#endif
 	unsigned long		nmissed;
 	unsigned int		flags;
-	struct rethook		*rethook;
 	size_t			entry_data_size;
 	int			nr_maxactive;
 
 	fprobe_entry_cb entry_handler;
 	fprobe_exit_cb  exit_handler;
+
+	struct fprobe_hlist	*hlist_array;
 };
 
 /* This fprobe is soft-disabled. */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2fc55a1a88aa..7c40d6f7d25f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -307,11 +307,9 @@ config DYNAMIC_FTRACE_WITH_ARGS
 
 config FPROBE
 	bool "Kernel Function Probe (fprobe)"
-	depends on FUNCTION_TRACER
-	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
-	depends on HAVE_FTRACE_REGS_HAVING_PT_REGS || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
-	depends on HAVE_RETHOOK
-	select RETHOOK
+	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
+	select FUNCTION_GRAPH_TRACER
+	select DYNAMIC_FTRACE_WITH_ARGS
 	default n
 	help
 	  This option enables kernel function probe (fprobe) based on ftrace.
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 90a3c8e2bbdf..5a0b4ef52fa7 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -8,98 +8,195 @@
 #include <linux/fprobe.h>
 #include <linux/kallsyms.h>
 #include <linux/kprobes.h>
-#include <linux/rethook.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
 #include "trace.h"
 
-struct fprobe_rethook_node {
-	struct rethook_node node;
-	unsigned long entry_ip;
-	unsigned long entry_parent_ip;
-	char data[];
-};
+#define FPROBE_IP_HASH_BITS 8
+#define FPROBE_IP_TABLE_SIZE (1 << FPROBE_IP_HASH_BITS)
 
-static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
-			struct ftrace_ops *ops, struct ftrace_regs *fregs)
-{
-	struct fprobe_rethook_node *fpr;
-	struct rethook_node *rh = NULL;
-	struct fprobe *fp;
-	void *entry_data = NULL;
-	int ret = 0;
+#define FPROBE_HASH_BITS 6
+#define FPROBE_TABLE_SIZE (1 << FPROBE_HASH_BITS)
 
-	fp = container_of(ops, struct fprobe, ops);
+#define SIZE_IN_LONG(x) ((x + sizeof(long) - 1) >> (sizeof(long) == 8 ? 3 : 2))
 
-	if (fp->exit_handler) {
-		rh = rethook_try_get(fp->rethook);
-		if (!rh) {
-			fp->nmissed++;
-			return;
-		}
-		fpr = container_of(rh, struct fprobe_rethook_node, node);
-		fpr->entry_ip = ip;
-		fpr->entry_parent_ip = parent_ip;
-		if (fp->entry_data_size)
-			entry_data = fpr->data;
+/*
+ * fprobe_table: hold 'fprobe_hlist::hlist' for checking the fprobe still
+ *   exists. The key is the address of fprobe instance.
+ * fprobe_ip_table: hold 'fprobe_hlist::array[*]' for searching the fprobe
+ *   instance related to the funciton address. The key is the ftrace IP
+ *   address.
+ *
+ * When unregistering the fprobe, fprobe_hlist::fp and fprobe_hlist::array[*].fp
+ * are set NULL and delete those from both hash tables (by hlist_del_rcu).
+ * After an RCU grace period, the fprobe_hlist itself will be released.
+ *
+ * fprobe_table and fprobe_ip_table can be accessed from either
+ *  - Normal hlist traversal and RCU add/del under 'fprobe_mutex' is held.
+ *  - RCU hlist traversal under disabling preempt
+ */
+static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
+static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
+static DEFINE_MUTEX(fprobe_mutex);
+
+/*
+ * Find first fprobe in the hlist. It will be iterated twice in the entry
+ * probe, once for correcting the total required size, the second time is
+ * calling back the user handlers.
+ * Thus the hlist in the fprobe_table must be sorted and new probe needs to
+ * be added *before* the first fprobe.
+ */
+static struct fprobe_hlist_node *find_first_fprobe_node(unsigned long ip)
+{
+	struct fprobe_hlist_node *node;
+	struct hlist_head *head;
+
+	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
+	hlist_for_each_entry_rcu(node, head, hlist,
+				 lockdep_is_held(&fprobe_mutex)) {
+		if (node->addr == ip)
+			return node;
 	}
+	return NULL;
+}
+NOKPROBE_SYMBOL(find_first_fprobe_node);
+
+/* Node insertion and deletion requires the fprobe_mutex */
+static void insert_fprobe_node(struct fprobe_hlist_node *node)
+{
+	unsigned long ip = node->addr;
+	struct fprobe_hlist_node *next;
+	struct hlist_head *head;
 
-	if (fp->entry_handler)
-		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
+	lockdep_assert_held(&fprobe_mutex);
 
-	/* If entry_handler returns !0, nmissed is not counted. */
-	if (rh) {
-		if (ret)
-			rethook_recycle(rh);
-		else
-			rethook_hook(rh, ftrace_get_regs(fregs), true);
+	next = find_first_fprobe_node(ip);
+	if (next) {
+		hlist_add_before_rcu(&node->hlist, &next->hlist);
+		return;
 	}
+	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
+	hlist_add_head_rcu(&node->hlist, head);
 }
 
-static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
-		struct ftrace_ops *ops, struct ftrace_regs *fregs)
+/* Return true if there are synonims */
+static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 {
-	struct fprobe *fp;
-	int bit;
+	lockdep_assert_held(&fprobe_mutex);
 
-	fp = container_of(ops, struct fprobe, ops);
-	if (fprobe_disabled(fp))
-		return;
+	WRITE_ONCE(node->fp, NULL);
+	hlist_del_rcu(&node->hlist);
+	return !!find_first_fprobe_node(node->addr);
+}
 
-	/* recursion detection has to go before any traceable function and
-	 * all functions before this point should be marked as notrace
-	 */
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
-		return;
+/* Check existence of the fprobe */
+static bool is_fprobe_still_exist(struct fprobe *fp)
+{
+	struct hlist_head *head;
+	struct fprobe_hlist *fph;
+
+	head = &fprobe_table[hash_ptr(fp, FPROBE_HASH_BITS)];
+	hlist_for_each_entry_rcu(fph, head, hlist,
+				 lockdep_is_held(&fprobe_mutex)) {
+		if (fph->fp == fp)
+			return true;
 	}
-	__fprobe_handler(ip, parent_ip, ops, fregs);
-	ftrace_test_recursion_unlock(bit);
+	return false;
+}
+NOKPROBE_SYMBOL(is_fprobe_still_exist);
+
+static int add_fprobe_hash(struct fprobe *fp)
+{
+	struct fprobe_hlist *fph = fp->hlist_array;
+	struct hlist_head *head;
+
+	lockdep_assert_held(&fprobe_mutex);
 
+	if (WARN_ON_ONCE(!fph))
+		return -EINVAL;
+
+	if (is_fprobe_still_exist(fp))
+		return -EEXIST;
+
+	head = &fprobe_table[hash_ptr(fp, FPROBE_HASH_BITS)];
+	hlist_add_head_rcu(&fp->hlist_array->hlist, head);
+	return 0;
 }
-NOKPROBE_SYMBOL(fprobe_handler);
 
-static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
-				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
+static int del_fprobe_hash(struct fprobe *fp)
 {
-	struct fprobe *fp;
-	int bit;
+	struct fprobe_hlist *fph = fp->hlist_array;
 
-	fp = container_of(ops, struct fprobe, ops);
-	if (fprobe_disabled(fp))
-		return;
+	lockdep_assert_held(&fprobe_mutex);
 
-	/* recursion detection has to go before any traceable function and
-	 * all functions called before this point should be marked as notrace
-	 */
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
-		return;
+	if (WARN_ON_ONCE(!fph))
+		return -EINVAL;
+
+	if (!is_fprobe_still_exist(fp))
+		return -ENOENT;
+
+	fph->fp = NULL;
+	hlist_del_rcu(&fph->hlist);
+	return 0;
+}
+
+/* The entry data size is 4 bits (=16) * sizeof(long) in maximum */
+#define FPROBE_HEADER_SIZE_BITS		4
+#define MAX_FPROBE_DATA_SIZE_WORD	((1L << FPROBE_HEADER_SIZE_BITS) - 1)
+#define MAX_FPROBE_DATA_SIZE		(MAX_FPROBE_DATA_SIZE_WORD * sizeof(long))
+#define FPROBE_HEADER_PTR_BITS		(BITS_PER_LONG - FPROBE_HEADER_SIZE_BITS)
+#define FPROBE_HEADER_PTR_MASK		GENMASK(FPROBE_HEADER_PTR_BITS - 1, 0)
+#define FPROBE_HEADER_SIZE		sizeof(unsigned long)
+
+static inline unsigned long encode_fprobe_header(struct fprobe *fp, int size_words)
+{
+	if (WARN_ON_ONCE(size_words > MAX_FPROBE_DATA_SIZE_WORD ||
+	    ((unsigned long)fp & ~FPROBE_HEADER_PTR_MASK) !=
+	    ~FPROBE_HEADER_PTR_MASK)) {
+		return 0;
 	}
+	return ((unsigned long)size_words << FPROBE_HEADER_PTR_BITS) |
+		((unsigned long)fp & FPROBE_HEADER_PTR_MASK);
+}
+
+/* Return reserved data size in words */
+static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
+{
+	unsigned long ptr;
+
+	ptr = (val & FPROBE_HEADER_PTR_MASK) | ~FPROBE_HEADER_PTR_MASK;
+	if (fp)
+		*fp = (struct fprobe *)ptr;
+	return val >> FPROBE_HEADER_PTR_BITS;
+}
+
+/*
+ * fprobe shadow stack management:
+ * Since fprobe shares a single fgraph_ops, it needs to share the stack entry
+ * among the probes on the same function exit. Note that a new probe can be
+ * registered before a target function is returning, we can not use the hash
+ * table to find the corresponding probes. Thus the probe address is stored on
+ * the shadow stack with its entry data size.
+ *
+ */
+static inline int __fprobe_handler(unsigned long ip, unsigned long parent_ip,
+				   struct fprobe *fp, struct ftrace_regs *fregs,
+				   void *data)
+{
+	if (!fp->entry_handler)
+		return 0;
+
+	return fp->entry_handler(fp, ip, parent_ip, fregs, data);
+}
 
+static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
+					  struct fprobe *fp, struct ftrace_regs *fregs,
+					  void *data)
+{
+	int ret;
 	/*
 	 * This user handler is shared with other kprobes and is not expected to be
 	 * called recursively. So if any other kprobe handler is running, this will
@@ -108,45 +205,185 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 	 */
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
-		goto recursion_unlock;
+		return 0;
 	}
 
 	kprobe_busy_begin();
-	__fprobe_handler(ip, parent_ip, ops, fregs);
+	ret = __fprobe_handler(ip, parent_ip, fp, fregs, data);
 	kprobe_busy_end();
-
-recursion_unlock:
-	ftrace_test_recursion_unlock(bit);
+	return ret;
 }
 
-static void fprobe_exit_handler(struct rethook_node *rh, void *data,
-				unsigned long ret_ip, struct pt_regs *regs)
+static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			struct ftrace_regs *fregs)
 {
-	struct fprobe *fp = (struct fprobe *)data;
-	struct fprobe_rethook_node *fpr;
-	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
-	int bit;
+	struct fprobe_hlist_node *node, *first;
+	unsigned long *fgraph_data = NULL;
+	unsigned long func = trace->func;
+	unsigned long header, ret_ip;
+	int reserved_words;
+	struct fprobe *fp;
+	int used, ret;
 
-	if (!fp || fprobe_disabled(fp))
-		return;
+	if (WARN_ON_ONCE(!fregs))
+		return 0;
+
+	first = node = find_first_fprobe_node(func);
+	if (unlikely(!first))
+		return 0;
 
-	fpr = container_of(rh, struct fprobe_rethook_node, node);
+	reserved_words = 0;
+	hlist_for_each_entry_from_rcu(node, hlist) {
+		if (node->addr != func)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (!fp || !fp->exit_handler)
+			continue;
+		/*
+		 * Since fprobe can be enabled until the next loop, we ignore the
+		 * fprobe's disabled flag in this loop.
+		 */
+		reserved_words +=
+			SIZE_IN_LONG(fp->entry_data_size) + 1;
+	}
+	node = first;
+	if (reserved_words) {
+		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
+		if (unlikely(!fgraph_data)) {
+			hlist_for_each_entry_from_rcu(node, hlist) {
+				if (node->addr != func)
+					break;
+				fp = READ_ONCE(node->fp);
+				if (fp && !fprobe_disabled(fp))
+					fp->nmissed++;
+			}
+			return 0;
+		}
+	}
 
 	/*
-	 * we need to assure no calls to traceable functions in-between the
-	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
+	 * TODO: recursion detection has been done in the fgraph. Thus we need
+	 * to add a callback to increment missed counter.
 	 */
-	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
+	ret_ip = ftrace_regs_get_return_address(fregs);
+	used = 0;
+	hlist_for_each_entry_from_rcu(node, hlist) {
+		void *data;
+
+		if (node->addr != func)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (!fp || fprobe_disabled(fp))
+			continue;
+
+		if (fp->entry_data_size && fp->exit_handler)
+			data = fgraph_data + used + 1;
+		else
+			data = NULL;
+
+		if (fprobe_shared_with_kprobes(fp))
+			ret = __fprobe_kprobe_handler(func, ret_ip, fp, fregs, data);
+		else
+			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
+		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
+		if (!ret && fp->exit_handler) {
+			int size_words = SIZE_IN_LONG(fp->entry_data_size);
+
+			header = encode_fprobe_header(fp, size_words);
+			if (likely(header)) {
+				fgraph_data[used] = header;
+				used += size_words + 1;
+			}
+		}
+	}
+	if (used < reserved_words)
+		memset(fgraph_data + used, 0, reserved_words - used);
+
+	/* If any exit_handler is set, data must be used. */
+	return used != 0;
+}
+NOKPROBE_SYMBOL(fprobe_entry);
+
+static void fprobe_return(struct ftrace_graph_ret *trace,
+			  struct fgraph_ops *gops,
+			  struct ftrace_regs *fregs)
+{
+	unsigned long *fgraph_data = NULL;
+	unsigned long ret_ip;
+	unsigned long val;
+	struct fprobe *fp;
+	int size, curr;
+	int size_words;
+
+	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
+	if (WARN_ON_ONCE(!fgraph_data))
 		return;
+	size_words = SIZE_IN_LONG(size);
+	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
+
+	preempt_disable();
+
+	curr = 0;
+	while (size_words > curr) {
+		val = fgraph_data[curr++];
+		if (!val)
+			break;
+
+		size = decode_fprobe_header(val, &fp);
+		if (fp && is_fprobe_still_exist(fp) && !fprobe_disabled(fp)) {
+			if (WARN_ON_ONCE(curr + size > size_words))
+				break;
+			fp->exit_handler(fp, trace->func, ret_ip, fregs,
+					 size ? fgraph_data + curr : NULL);
+		}
+		curr += size;
 	}
+	preempt_enable();
+}
+NOKPROBE_SYMBOL(fprobe_return);
+
+static struct fgraph_ops fprobe_graph_ops = {
+	.entryfunc	= fprobe_entry,
+	.retfunc	= fprobe_return,
+};
+static int fprobe_graph_active;
 
-	fp->exit_handler(fp, fpr->entry_ip, ret_ip, fregs,
-			 fp->entry_data_size ? (void *)fpr->data : NULL);
-	ftrace_test_recursion_unlock(bit);
+/* Add @addrs to the ftrace filter and register fgraph if needed. */
+static int fprobe_graph_add_ips(unsigned long *addrs, int num)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
+	if (ret)
+		return ret;
+
+	if (!fprobe_graph_active) {
+		ret = register_ftrace_graph(&fprobe_graph_ops);
+		if (WARN_ON_ONCE(ret)) {
+			ftrace_free_filter(&fprobe_graph_ops.ops);
+			return ret;
+		}
+	}
+	fprobe_graph_active++;
+	return 0;
+}
+
+/* Remove @addrs from the ftrace filter and unregister fgraph if possible. */
+static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
+{
+	lockdep_assert_held(&fprobe_mutex);
+
+	fprobe_graph_active--;
+	if (!fprobe_graph_active) {
+		/* Q: should we unregister it ? */
+		unregister_ftrace_graph(&fprobe_graph_ops);
+		return;
+	}
+
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
-NOKPROBE_SYMBOL(fprobe_exit_handler);
 
 static int symbols_cmp(const void *a, const void *b)
 {
@@ -176,54 +413,97 @@ static unsigned long *get_ftrace_locations(const char **syms, int num)
 	return ERR_PTR(-ENOENT);
 }
 
-static void fprobe_init(struct fprobe *fp)
-{
-	fp->nmissed = 0;
-	if (fprobe_shared_with_kprobes(fp))
-		fp->ops.func = fprobe_kprobe_handler;
-	else
-		fp->ops.func = fprobe_handler;
-
-	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
-}
+struct filter_match_data {
+	const char *filter;
+	const char *notfilter;
+	size_t index;
+	size_t size;
+	unsigned long *addrs;
+};
 
-static int fprobe_init_rethook(struct fprobe *fp, int num)
+static int filter_match_callback(void *data, const char *name, unsigned long addr)
 {
-	int size;
+	struct filter_match_data *match = data;
 
-	if (!fp->exit_handler) {
-		fp->rethook = NULL;
+	if (!glob_match(match->filter, name) ||
+	    (match->notfilter && glob_match(match->notfilter, name)))
 		return 0;
-	}
 
-	/* Initialize rethook if needed */
-	if (fp->nr_maxactive)
-		num = fp->nr_maxactive;
-	else
-		num *= num_possible_cpus() * 2;
-	if (num <= 0)
-		return -EINVAL;
+	if (!ftrace_location(addr))
+		return 0;
 
-	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
+	if (match->addrs)
+		match->addrs[match->index] = addr;
 
-	/* Initialize rethook */
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
-	if (IS_ERR(fp->rethook))
-		return PTR_ERR(fp->rethook);
+	match->index++;
+	return match->index == match->size;
+}
 
-	return 0;
+/*
+ * Make IP list from the filter/no-filter glob patterns.
+ * Return the number of matched symbols, or -ENOENT.
+ */
+static int ip_list_from_filter(const char *filter, const char *notfilter,
+			       unsigned long *addrs, size_t size)
+{
+	struct filter_match_data match = { .filter = filter, .notfilter = notfilter,
+		.index = 0, .size = size, .addrs = addrs};
+	int ret;
+
+	ret = kallsyms_on_each_symbol(filter_match_callback, &match);
+	if (ret < 0)
+		return ret;
+	ret = module_kallsyms_on_each_symbol(NULL, filter_match_callback, &match);
+	if (ret < 0)
+		return ret;
+
+	return match.index ?: -ENOENT;
 }
 
 static void fprobe_fail_cleanup(struct fprobe *fp)
 {
-	if (!IS_ERR_OR_NULL(fp->rethook)) {
-		/* Don't need to cleanup rethook->handler because this is not used. */
-		rethook_free(fp->rethook);
-		fp->rethook = NULL;
+	kfree(fp->hlist_array);
+	fp->hlist_array = NULL;
+}
+
+/* Initialize the fprobe data structure. */
+static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
+{
+	struct fprobe_hlist *hlist_array;
+	unsigned long addr;
+	int size, i;
+
+	if (!fp || !addrs || num <= 0)
+		return -EINVAL;
+
+	size = ALIGN(fp->entry_data_size, sizeof(long));
+	if (size > MAX_FPROBE_DATA_SIZE)
+		return -E2BIG;
+	fp->entry_data_size = size;
+
+	hlist_array = kzalloc(struct_size(hlist_array, array, num), GFP_KERNEL);
+	if (!hlist_array)
+		return -ENOMEM;
+
+	fp->nmissed = 0;
+
+	hlist_array->size = num;
+	fp->hlist_array = hlist_array;
+	hlist_array->fp = fp;
+	for (i = 0; i < num; i++) {
+		hlist_array->array[i].fp = fp;
+		addr = ftrace_location(addrs[i]);
+		if (!addr) {
+			fprobe_fail_cleanup(fp);
+			return -ENOENT;
+		}
+		hlist_array->array[i].addr = addr;
 	}
-	ftrace_free_filter(&fp->ops);
+	return 0;
 }
 
+#define FPROBE_IPS_MAX	INT_MAX
+
 /**
  * register_fprobe() - Register fprobe to ftrace by pattern.
  * @fp: A fprobe data structure to be registered.
@@ -237,46 +517,24 @@ static void fprobe_fail_cleanup(struct fprobe *fp)
  */
 int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
 {
-	struct ftrace_hash *hash;
-	unsigned char *str;
-	int ret, len;
+	unsigned long *addrs;
+	int ret;
 
 	if (!fp || !filter)
 		return -EINVAL;
 
-	fprobe_init(fp);
-
-	len = strlen(filter);
-	str = kstrdup(filter, GFP_KERNEL);
-	ret = ftrace_set_filter(&fp->ops, str, len, 0);
-	kfree(str);
-	if (ret)
+	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
+	if (ret < 0)
 		return ret;
 
-	if (notfilter) {
-		len = strlen(notfilter);
-		str = kstrdup(notfilter, GFP_KERNEL);
-		ret = ftrace_set_notrace(&fp->ops, str, len, 0);
-		kfree(str);
-		if (ret)
-			goto out;
-	}
-
-	/* TODO:
-	 * correctly calculate the total number of filtered symbols
-	 * from both filter and notfilter.
-	 */
-	hash = rcu_access_pointer(fp->ops.local_hash.filter_hash);
-	if (WARN_ON_ONCE(!hash))
-		goto out;
-
-	ret = fprobe_init_rethook(fp, (int)hash->count);
-	if (!ret)
-		ret = register_ftrace_function(&fp->ops);
+	addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
+	if (!addrs)
+		return -ENOMEM;
+	ret = ip_list_from_filter(filter, notfilter, addrs, ret);
+	if (ret > 0)
+		ret = register_fprobe_ips(fp, addrs, ret);
 
-out:
-	if (ret)
-		fprobe_fail_cleanup(fp);
+	kfree(addrs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
@@ -284,7 +542,7 @@ EXPORT_SYMBOL_GPL(register_fprobe);
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
- * @addrs: An array of target ftrace location addresses.
+ * @addrs: An array of target function address.
  * @num: The number of entries of @addrs.
  *
  * Register @fp to ftrace for enabling the probe on the address given by @addrs.
@@ -296,23 +554,27 @@ EXPORT_SYMBOL_GPL(register_fprobe);
  */
 int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 {
-	int ret;
-
-	if (!fp || !addrs || num <= 0)
-		return -EINVAL;
-
-	fprobe_init(fp);
+	struct fprobe_hlist *hlist_array;
+	int ret, i;
 
-	ret = ftrace_set_filter_ips(&fp->ops, addrs, num, 0, 0);
+	ret = fprobe_init(fp, addrs, num);
 	if (ret)
 		return ret;
 
-	ret = fprobe_init_rethook(fp, num);
-	if (!ret)
-		ret = register_ftrace_function(&fp->ops);
+	mutex_lock(&fprobe_mutex);
+
+	hlist_array = fp->hlist_array;
+	ret = fprobe_graph_add_ips(addrs, num);
+	if (!ret) {
+		add_fprobe_hash(fp);
+		for (i = 0; i < hlist_array->size; i++)
+			insert_fprobe_node(&hlist_array->array[i]);
+	}
+	mutex_unlock(&fprobe_mutex);
 
 	if (ret)
 		fprobe_fail_cleanup(fp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe_ips);
@@ -350,14 +612,13 @@ EXPORT_SYMBOL_GPL(register_fprobe_syms);
 
 bool fprobe_is_registered(struct fprobe *fp)
 {
-	if (!fp || (fp->ops.saved_func != fprobe_handler &&
-		    fp->ops.saved_func != fprobe_kprobe_handler))
+	if (!fp || !fp->hlist_array)
 		return false;
 	return true;
 }
 
 /**
- * unregister_fprobe() - Unregister fprobe from ftrace
+ * unregister_fprobe() - Unregister fprobe.
  * @fp: A fprobe data structure to be unregistered.
  *
  * Unregister fprobe (and remove ftrace hooks from the function entries).
@@ -366,23 +627,41 @@ bool fprobe_is_registered(struct fprobe *fp)
  */
 int unregister_fprobe(struct fprobe *fp)
 {
-	int ret;
+	struct fprobe_hlist *hlist_array;
+	unsigned long *addrs = NULL;
+	int ret = 0, i, count;
 
-	if (!fprobe_is_registered(fp))
-		return -EINVAL;
+	mutex_lock(&fprobe_mutex);
+	if (!fp || !is_fprobe_still_exist(fp)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (!IS_ERR_OR_NULL(fp->rethook))
-		rethook_stop(fp->rethook);
+	hlist_array = fp->hlist_array;
+	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
+	if (!addrs) {
+		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
+		goto out;
+	}
 
-	ret = unregister_ftrace_function(&fp->ops);
-	if (ret < 0)
-		return ret;
+	/* Remove non-synonim ips from table and hash */
+	count = 0;
+	for (i = 0; i < hlist_array->size; i++) {
+		if (!delete_fprobe_node(&hlist_array->array[i]))
+			addrs[count++] = hlist_array->array[i].addr;
+	}
+	del_fprobe_hash(fp);
 
-	if (!IS_ERR_OR_NULL(fp->rethook))
-		rethook_free(fp->rethook);
+	if (count)
+		fprobe_graph_remove_ips(addrs, count);
 
-	ftrace_free_filter(&fp->ops);
+	kfree_rcu(hlist_array, rcu);
+	fp->hlist_array = NULL;
 
+out:
+	mutex_unlock(&fprobe_mutex);
+
+	kfree(addrs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 271ce0caeec0..cf92111b5c79 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -17,10 +17,8 @@ static u32 rand1, entry_val, exit_val;
 /* Use indirect calls to avoid inlining the target functions */
 static u32 (*target)(u32 value);
 static u32 (*target2)(u32 value);
-static u32 (*target_nest)(u32 value, u32 (*nest)(u32));
 static unsigned long target_ip;
 static unsigned long target2_ip;
-static unsigned long target_nest_ip;
 static int entry_return_value;
 
 static noinline u32 fprobe_selftest_target(u32 value)
@@ -33,11 +31,6 @@ static noinline u32 fprobe_selftest_target2(u32 value)
 	return (value / div_factor) + 1;
 }
 
-static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
-{
-	return nest(value + 2);
-}
-
 static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
 				    struct ftrace_regs *fregs, void *data)
@@ -79,22 +72,6 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 		KUNIT_EXPECT_NULL(current_test, data);
 }
 
-static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
-				      unsigned long ret_ip,
-				      struct ftrace_regs *fregs, void *data)
-{
-	KUNIT_EXPECT_FALSE(current_test, preemptible());
-	return 0;
-}
-
-static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
-				      unsigned long ret_ip,
-				      struct ftrace_regs *fregs, void *data)
-{
-	KUNIT_EXPECT_FALSE(current_test, preemptible());
-	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
-}
-
 /* Test entry only (no rethook) */
 static void test_fprobe_entry(struct kunit *test)
 {
@@ -191,25 +168,6 @@ static void test_fprobe_data(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
-/* Test nr_maxactive */
-static void test_fprobe_nest(struct kunit *test)
-{
-	static const char *syms[] = {"fprobe_selftest_target", "fprobe_selftest_nest_target"};
-	struct fprobe fp = {
-		.entry_handler = nest_entry_handler,
-		.exit_handler = nest_exit_handler,
-		.nr_maxactive = 1,
-	};
-
-	current_test = test;
-	KUNIT_EXPECT_EQ(test, 0, register_fprobe_syms(&fp, syms, 2));
-
-	target_nest(rand1, target);
-	KUNIT_EXPECT_EQ(test, 1, fp.nmissed);
-
-	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
-}
-
 static void test_fprobe_skip(struct kunit *test)
 {
 	struct fprobe fp = {
@@ -247,10 +205,8 @@ static int fprobe_test_init(struct kunit *test)
 	rand1 = get_random_u32_above(div_factor);
 	target = fprobe_selftest_target;
 	target2 = fprobe_selftest_target2;
-	target_nest = fprobe_selftest_nest_target;
 	target_ip = get_ftrace_location(target);
 	target2_ip = get_ftrace_location(target2);
-	target_nest_ip = get_ftrace_location(target_nest);
 
 	return 0;
 }
@@ -260,7 +216,6 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe),
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
-	KUNIT_CASE(test_fprobe_nest),
 	KUNIT_CASE(test_fprobe_skip),
 	{}
 };


