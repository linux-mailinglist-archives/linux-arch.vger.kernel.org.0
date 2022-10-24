Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFC60BFB6
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 02:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJYAgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 20:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJYAgP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 20:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568683F15;
        Mon, 24 Oct 2022 16:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486AEB810B2;
        Mon, 24 Oct 2022 23:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80ECC433D7;
        Mon, 24 Oct 2022 23:03:00 +0000 (UTC)
Date:   Mon, 24 Oct 2022 19:03:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called in
 early boot
Message-ID: <20221024190311.65b89ecb@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Currently text_poke() just does a simple memcpy() on early boot because
the kernel code is read writable at that time. But ftrace uses text_poke
on the ftrace trampoline, which is not part of kernel text, and having non
kernel text around that can be writable and executable causes several
special cases where checks for system_state == SYSTEM_BOOTING needs to be
done to ignore this special case. This is tricky and can lead to memory
that can be kernel writable and executable after boot (due to bugs).

By moving poking_init() to mm_init() which is called before ftrace_init(),
this will allow ftrace to create its trampoline as read only, and the
text_poke() will do its normal thing.

This required some updates to fork and the maple_tree code to allow it to
be called with enabling interrupts in the time when interrupts must remain
disabled.

text_poke() will still use memcpy() on kernel core text during boot up as
it keeps things fast for all static_branch()es and such as well as
modifying the ftrace locations at boot up too.

This removes the special code added around ftrace trampolines in x86 to be
writable and executable during boot up.

Link: https://lore.kernel.org/r/20221024112730.180916b3@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

 ** Note this may break other architectures. **

 arch/x86/include/asm/ftrace.h |  6 ------
 arch/x86/kernel/alternative.c |  6 ++++--
 arch/x86/kernel/ftrace.c      | 29 +----------------------------
 arch/x86/mm/init_64.c         |  2 --
 init/main.c                   |  8 ++++----
 kernel/fork.c                 |  8 +++++++-
 lib/maple_tree.c              | 16 +++++++++++++++-
 7 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 908d99b127d3..b27cd4de3fb3 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -85,12 +85,6 @@ struct dyn_arch_ftrace {
 
 #ifndef __ASSEMBLY__
 
-#if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
-extern void set_ftrace_ops_ro(void);
-#else
-static inline void set_ftrace_ops_ro(void) { }
-#endif
-
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..ef30a6b78837 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1681,7 +1681,8 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 {
 	struct text_poke_loc *tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
+	if (unlikely(system_state == SYSTEM_BOOTING &&
+		     core_kernel_text((unsigned long)addr))) {
 		text_poke_early(addr, opcode, len);
 		return;
 	}
@@ -1707,7 +1708,8 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 {
 	struct text_poke_loc tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
+	if (unlikely(system_state == SYSTEM_BOOTING &&
+		     core_kernel_text((unsigned long)addr))) {
 		text_poke_early(addr, opcode, len);
 		return;
 	}
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd165004776d..3aa4c02f63d2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	set_vm_flush_reset_perms(trampoline);
 
-	if (likely(system_state != SYSTEM_BOOTING))
-		set_memory_ro((unsigned long)trampoline, npages);
+	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
@@ -424,32 +423,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	return 0;
 }
 
-void set_ftrace_ops_ro(void)
-{
-	struct ftrace_ops *ops;
-	unsigned long start_offset;
-	unsigned long end_offset;
-	unsigned long npages;
-	unsigned long size;
-
-	do_for_each_ftrace_op(ops, ftrace_ops_list) {
-		if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
-			continue;
-
-		if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
-			start_offset = (unsigned long)ftrace_regs_caller;
-			end_offset = (unsigned long)ftrace_regs_caller_end;
-		} else {
-			start_offset = (unsigned long)ftrace_caller;
-			end_offset = (unsigned long)ftrace_caller_end;
-		}
-		size = end_offset - start_offset;
-		size = size + RET_SIZE + sizeof(void *);
-		npages = DIV_ROUND_UP(size, PAGE_SIZE);
-		set_memory_ro((unsigned long)ops->trampoline, npages);
-	} while_for_each_ftrace_op(ops);
-}
-
 static unsigned long calc_trampoline_call_offset(bool save_regs)
 {
 	unsigned long start_offset;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3f040c6e5d13..03ac9f914f28 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1398,8 +1398,6 @@ void mark_rodata_ro(void)
 	all_end = roundup((unsigned long)_brk_end, PMD_SIZE);
 	set_memory_nx(text_end, (all_end - text_end) >> PAGE_SHIFT);
 
-	set_ftrace_ops_ro();
-
 #ifdef CONFIG_CPA_DEBUG
 	printk(KERN_INFO "Testing CPA: undo %lx-%lx\n", start, end);
 	set_memory_rw(start, (end-start) >> PAGE_SHIFT);
diff --git a/init/main.c b/init/main.c
index aa21add5f7c5..e5f4ae2d4cca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -860,6 +860,10 @@ static void __init mm_init(void)
 	/* Should be run after espfix64 is set up. */
 	pti_init();
 	kmsan_init_runtime();
+	proc_caches_init();
+	radix_tree_init();
+	maple_tree_init();
+	poking_init();
 }
 
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
@@ -1011,8 +1015,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	if (WARN(!irqs_disabled(),
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
-	radix_tree_init();
-	maple_tree_init();
 
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
@@ -1117,7 +1119,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	thread_stack_cache_init();
 	cred_init();
 	fork_init();
-	proc_caches_init();
 	uts_ns_init();
 	key_init();
 	security_init();
@@ -1134,7 +1135,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
-	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..672967a9cbe9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -702,7 +702,13 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
-	flush_tlb_mm(oldmm);
+	/*
+	 * poking_init() calls into here at early boot up.
+	 * At that time, there's no need to flush the tlb.
+	 * If we do, it will enable interrupts and cause a bug.
+	 */
+	if (likely(!early_boot_irqs_disabled))
+		flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1743803c851..e32206e840f6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1253,7 +1253,21 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 		}
 
 		max_req = min(requested, max_req);
-		count = mt_alloc_bulk(gfp, max_req, slots);
+
+		/*
+		 * text_poke() can be called very early, and it
+		 * calls dup_mm() which eventually leads down to here.
+		 * In that case, mt_alloc_bulk() will call kmem_cache_alloc_bulk()
+		 * which must be called with interrupts enabled. To avoid
+		 * doing that in early bootup, where interrupts must remain
+		 * disabled, just allocate a single slot.
+		 */
+		if (unlikely(early_boot_irqs_disabled)) {
+			slots[0] = mt_alloc_one(gfp | GFP_ATOMIC);
+			count = slots[0] ? 1 : 0;
+		} else {
+			count = mt_alloc_bulk(gfp, max_req, slots);
+		}
 		if (!count)
 			goto nomem_bulk;
 
-- 
2.35.1

