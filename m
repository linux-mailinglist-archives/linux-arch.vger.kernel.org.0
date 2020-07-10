Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D0B21B741
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJN5U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJN5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 09:57:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9089C08C5DC;
        Fri, 10 Jul 2020 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tv7EnJFGmJxHMgCnHbROpZkfSJ75XVmoo2acdT07f3c=; b=CEQghEj/JNgoDEr2ZPuDi/SOIx
        e5j/WE0wVbM4u/f4JU1PFPWXdygX7MpAjnWWPKz6URuIJuaDiwwwNOOV0yqffwijnQC0paLZBNxZD
        lqF7izFrlCJSz8VF0fsvGNf4KCvXCu4aaY9DfKEYQ9uPqBD1tdlKDPh9b6FwdSfVh2iPoF5ciu77L
        4jjk7igfNqDXOyakdmSo9f8T3Znqfo6DTtVzZye6j1U0LtwL1CNX+eJKfkK8WZv6rVem4oEUZ9slw
        853axxexceF2asBzYherb5mWnFxlqpXjf+AztN+QBOjnwQCXBZVDikkbE334zcP/8P/cHlaVakmll
        SPde2EtQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttWb-0004hO-LI; Fri, 10 Jul 2020 13:57:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Date:   Fri, 10 Jul 2020 15:57:05 +0200
Message-Id: <20200710135706.537715-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
References: <20200710135706.537715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add helpers to wraper the get_fs/set_fs magic for undoing any damange
done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
documents the intent of these calls better, and will allow stubbing the
functions out easily for kernels builds that do not allow address space
overrides in the future.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/kernel/sdei.c         |  2 +-
 arch/m68k/include/asm/tlbflush.h | 12 ++++++------
 arch/mips/kernel/unaligned.c     | 27 +++++++++++++--------------
 arch/nds32/mm/alignment.c        |  7 +++----
 arch/sh/kernel/traps_32.c        | 18 ++++++++----------
 drivers/firmware/arm_sdei.c      |  5 ++---
 include/linux/uaccess.h          | 18 ++++++++++++++++++
 kernel/events/callchain.c        |  5 ++---
 kernel/events/core.c             |  5 ++---
 kernel/kthread.c                 |  5 ++---
 kernel/stacktrace.c              |  5 ++---
 mm/maccess.c                     | 22 ++++++++++------------
 12 files changed, 69 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index dab88260b13739..7689f2031c0c41 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -180,7 +180,7 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 
 	/*
 	 * We didn't take an exception to get here, set PAN. UAO will be cleared
-	 * by sdei_event_handler()s set_fs(USER_DS) call.
+	 * by sdei_event_handler()s force_uaccess_begin() call.
 	 */
 	__uaccess_enable_hw_pan();
 
diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
index 191e75a6bb249e..30471549e1e224 100644
--- a/arch/m68k/include/asm/tlbflush.h
+++ b/arch/m68k/include/asm/tlbflush.h
@@ -13,13 +13,13 @@ static inline void flush_tlb_kernel_page(void *addr)
 	if (CPU_IS_COLDFIRE) {
 		mmu_write(MMUOR, MMUOR_CNL);
 	} else if (CPU_IS_040_OR_060) {
-		mm_segment_t old_fs = get_fs();
-		set_fs(KERNEL_DS);
+		mm_segment_t old_fs = force_uaccess_begin();
+
 		__asm__ __volatile__(".chip 68040\n\t"
 				     "pflush (%0)\n\t"
 				     ".chip 68k"
 				     : : "a" (addr));
-		set_fs(old_fs);
+		force_uaccess_end(old_fs);
 	} else if (CPU_IS_020_OR_030)
 		__asm__ __volatile__("pflush #4,#4,(%0)" : : "a" (addr));
 }
@@ -85,10 +85,10 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (vma->vm_mm == current->active_mm) {
-		mm_segment_t old_fs = get_fs();
-		set_fs(USER_DS);
+		mm_segment_t old_fs = force_uaccess_begin();
+
 		__flush_tlb_one(addr);
-		set_fs(old_fs);
+		force_uaccess_end(old_fs);
 	}
 }
 
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 0adce604fa44cb..126a5f3f4e4ce3 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -191,17 +191,16 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			 * memory, so we need to "switch" the address limit to
 			 * user space, so that address check can work properly.
 			 */
-			seg = get_fs();
-			set_fs(USER_DS);
+			seg = force_uaccess_begin();
 			switch (insn.spec3_format.func) {
 			case lhe_op:
 				if (!access_ok(addr, 2)) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto sigbus;
 				}
 				LoadHWE(addr, value, res);
 				if (res) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto fault;
 				}
 				compute_return_epc(regs);
@@ -209,12 +208,12 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 				break;
 			case lwe_op:
 				if (!access_ok(addr, 4)) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto sigbus;
 				}
 				LoadWE(addr, value, res);
 				if (res) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto fault;
 				}
 				compute_return_epc(regs);
@@ -222,12 +221,12 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 				break;
 			case lhue_op:
 				if (!access_ok(addr, 2)) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto sigbus;
 				}
 				LoadHWUE(addr, value, res);
 				if (res) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto fault;
 				}
 				compute_return_epc(regs);
@@ -235,35 +234,35 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 				break;
 			case she_op:
 				if (!access_ok(addr, 2)) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto sigbus;
 				}
 				compute_return_epc(regs);
 				value = regs->regs[insn.spec3_format.rt];
 				StoreHWE(addr, value, res);
 				if (res) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto fault;
 				}
 				break;
 			case swe_op:
 				if (!access_ok(addr, 4)) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto sigbus;
 				}
 				compute_return_epc(regs);
 				value = regs->regs[insn.spec3_format.rt];
 				StoreWE(addr, value, res);
 				if (res) {
-					set_fs(seg);
+					force_uaccess_end(seg);
 					goto fault;
 				}
 				break;
 			default:
-				set_fs(seg);
+				force_uaccess_end(seg);
 				goto sigill;
 			}
-			set_fs(seg);
+			force_uaccess_end(seg);
 		}
 #endif
 		break;
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index c8b9061a2ee3d5..1eb7ded6992b57 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -512,7 +512,7 @@ int do_unaligned_access(unsigned long addr, struct pt_regs *regs)
 {
 	unsigned long inst;
 	int ret = -EFAULT;
-	mm_segment_t seg = get_fs();
+	mm_segment_t seg;
 
 	inst = get_inst(regs->ipc);
 
@@ -520,13 +520,12 @@ int do_unaligned_access(unsigned long addr, struct pt_regs *regs)
 	      "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n", addr,
 	      regs->ipc, inst);
 
-	set_fs(USER_DS);
-
+	seg = force_uaccess_begin();
 	if (inst & NDS32_16BIT_INSTRUCTION)
 		ret = do_16((inst >> 16) & 0xffff, regs);
 	else
 		ret = do_32(inst, regs);
-	set_fs(seg);
+	force_uaccess_end(seg);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 058c6181bb306c..950f05d9d68338 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -482,8 +482,6 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 	error_code = lookup_exception_vector();
 #endif
 
-	oldfs = get_fs();
-
 	if (user_mode(regs)) {
 		int si_code = BUS_ADRERR;
 		unsigned int user_action;
@@ -491,13 +489,13 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		local_irq_enable();
 		inc_unaligned_user_access();
 
-		set_fs(USER_DS);
+		oldfs = force_uaccess_begin();
 		if (copy_from_user(&instruction, (insn_size_t *)(regs->pc & ~1),
 				   sizeof(instruction))) {
-			set_fs(oldfs);
+			force_uaccess_end(oldfs);
 			goto uspace_segv;
 		}
-		set_fs(oldfs);
+		force_uaccess_end(oldfs);
 
 		/* shout about userspace fixups */
 		unaligned_fixups_notify(current, instruction, regs);
@@ -520,11 +518,11 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 			goto uspace_segv;
 		}
 
-		set_fs(USER_DS);
+		oldfs = force_uaccess_begin();
 		tmp = handle_unaligned_access(instruction, regs,
 					      &user_mem_access, 0,
 					      address);
-		set_fs(oldfs);
+		force_uaccess_end(oldfs);
 
 		if (tmp == 0)
 			return; /* sorted */
@@ -540,13 +538,13 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		if (regs->pc & 1)
 			die("unaligned program counter", regs, error_code);
 
-		set_fs(KERNEL_DS);
+		oldfs = force_uaccess_begin();
 		if (copy_from_user(&instruction, (void __user *)(regs->pc),
 				   sizeof(instruction))) {
 			/* Argh. Fault on the instruction itself.
 			   This should never happen non-SMP
 			*/
-			set_fs(oldfs);
+			force_uaccess_end(oldfs);
 			die("insn faulting in do_address_error", regs, 0);
 		}
 
@@ -554,7 +552,7 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 
 		handle_unaligned_access(instruction, regs, &user_mem_access,
 					0, address);
-		set_fs(oldfs);
+		force_uaccess_end(oldfs);
 	}
 }
 
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e7e36aab2386ff..b4b9ce97f415e3 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1136,15 +1136,14 @@ int sdei_event_handler(struct pt_regs *regs,
 	 * access kernel memory.
 	 * Do the same here because this doesn't come via the same entry code.
 	*/
-	orig_addr_limit = get_fs();
-	set_fs(USER_DS);
+	orig_addr_limit = force_uaccess_begin();
 
 	err = arg->callback(event_num, regs, arg->callback_arg);
 	if (err)
 		pr_err_ratelimited("event %u on CPU %u failed with error: %d\n",
 				   event_num, smp_processor_id(), err);
 
-	set_fs(orig_addr_limit);
+	force_uaccess_end(orig_addr_limit);
 
 	return err;
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 5c62d0c6f15b16..94b28541165929 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -8,6 +8,24 @@
 
 #include <asm/uaccess.h>
 
+/*
+ * Force the uaccess routines to be wired up for actual userspace access,
+ * overriding any possible set_fs(KERNEL_DS) still lingering around.  Undone
+ * using force_uaccess_end below.
+ */
+static inline mm_segment_t force_uaccess_begin(void)
+{
+	mm_segment_t fs = get_fs();
+
+	set_fs(USER_DS);
+	return fs;
+}
+
+static inline void force_uaccess_end(mm_segment_t oldfs)
+{
+	set_fs(oldfs);
+}
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 334d48b16c36d7..dddc773e99f7b5 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -218,10 +218,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			fs = get_fs();
-			set_fs(USER_DS);
+			fs = force_uaccess_begin();
 			perf_callchain_user(&ctx, regs);
-			set_fs(fs);
+			force_uaccess_end(fs);
 		}
 	}
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c36f562d..c0c6f462a393e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6436,10 +6436,9 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 
 		/* Data. */
 		sp = perf_user_stack_pointer(regs);
-		fs = get_fs();
-		set_fs(USER_DS);
+		fs = force_uaccess_begin();
 		rem = __output_copy_user(handle, (void *) sp, dump_size);
-		set_fs(fs);
+		force_uaccess_end(fs);
 		dyn_size = dump_size - rem;
 
 		perf_output_skip(handle, rem);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 132f84a5fde3f0..379bf1e543371a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1254,8 +1254,7 @@ void kthread_use_mm(struct mm_struct *mm)
 	if (active_mm != mm)
 		mmdrop(active_mm);
 
-	to_kthread(tsk)->oldfs = get_fs();
-	set_fs(USER_DS);
+	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
 EXPORT_SYMBOL_GPL(kthread_use_mm);
 
@@ -1270,7 +1269,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!tsk->mm);
 
-	set_fs(to_kthread(tsk)->oldfs);
+	force_uaccess_end(to_kthread(tsk)->oldfs);
 
 	task_lock(tsk);
 	sync_mm_rss(mm);
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 2af66e449aa6a8..946f44a9e86afb 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -233,10 +233,9 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	if (current->flags & PF_KTHREAD)
 		return 0;
 
-	fs = get_fs();
-	set_fs(USER_DS);
+	fs = force_uaccess_begin();
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
-	set_fs(fs);
+	force_uaccess_end(fs);
 
 	return c.len;
 }
diff --git a/mm/maccess.c b/mm/maccess.c
index f98ff91e32c6df..3bd70405f2d848 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -205,15 +205,14 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	mm_segment_t old_fs = get_fs();
+	mm_segment_t old_fs = force_uaccess_begin();
 
-	set_fs(USER_DS);
 	if (access_ok(src, size)) {
 		pagefault_disable();
 		ret = __copy_from_user_inatomic(dst, src, size);
 		pagefault_enable();
 	}
-	set_fs(old_fs);
+	force_uaccess_end(old_fs);
 
 	if (ret)
 		return -EFAULT;
@@ -233,15 +232,14 @@ EXPORT_SYMBOL_GPL(copy_from_user_nofault);
 long copy_to_user_nofault(void __user *dst, const void *src, size_t size)
 {
 	long ret = -EFAULT;
-	mm_segment_t old_fs = get_fs();
+	mm_segment_t old_fs = force_uaccess_begin();
 
-	set_fs(USER_DS);
 	if (access_ok(dst, size)) {
 		pagefault_disable();
 		ret = __copy_to_user_inatomic(dst, src, size);
 		pagefault_enable();
 	}
-	set_fs(old_fs);
+	force_uaccess_end(old_fs);
 
 	if (ret)
 		return -EFAULT;
@@ -270,17 +268,17 @@ EXPORT_SYMBOL_GPL(copy_to_user_nofault);
 long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 			      long count)
 {
-	mm_segment_t old_fs = get_fs();
+	mm_segment_t old_fs;
 	long ret;
 
 	if (unlikely(count <= 0))
 		return 0;
 
-	set_fs(USER_DS);
+	old_fs = force_uaccess_begin();
 	pagefault_disable();
 	ret = strncpy_from_user(dst, unsafe_addr, count);
 	pagefault_enable();
-	set_fs(old_fs);
+	force_uaccess_end(old_fs);
 
 	if (ret >= count) {
 		ret = count;
@@ -310,14 +308,14 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
  */
 long strnlen_user_nofault(const void __user *unsafe_addr, long count)
 {
-	mm_segment_t old_fs = get_fs();
+	mm_segment_t old_fs;
 	int ret;
 
-	set_fs(USER_DS);
+	old_fs = force_uaccess_begin();
 	pagefault_disable();
 	ret = strnlen_user(unsafe_addr, count);
 	pagefault_enable();
-	set_fs(old_fs);
+	force_uaccess_end(old_fs);
 
 	return ret;
 }
-- 
2.26.2

