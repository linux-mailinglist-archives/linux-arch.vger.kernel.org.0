Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68974B572C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356690AbiBNQju (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:39:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356729AbiBNQis (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE0A652D2;
        Mon, 14 Feb 2022 08:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE92614F8;
        Mon, 14 Feb 2022 16:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C689C340F1;
        Mon, 14 Feb 2022 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856695;
        bh=/kKTMMBRz92UJDg2siwhTka/klTYwXBQSyhpE5zcpAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6iGqrb4uihekO2J29RlsPjWSIirVefXmDJ88V61I2FZj8NHe6/A5hTSRNv9H4enQ
         GpEYgqwBL+KNTdSHBGmNqO5Ca3Fck3bhH14uS6wLfT37UBHyRfDvT3yFSib1sCW5QF
         eAhsrZrSBQaMDCsEYQwWOsmyUtEDJVqdFCPBuFmnfxL6+e3v/Wn3BwgEgEMaWUfUtg
         mthZufLStsec1t9lai6wgSu0ifX/lj9v+LQIBhG3i5SHSvKmR7YS38hzd+JLAMvu4B
         9ri3nXMl8RNML8xS+WpAQYY7OrdC+8aYdXd2ODrskXQV1GSIenfVH9itu0Tl79sAMa
         qWh7rcKCE0QFA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 14/14] uaccess: drop set_fs leftovers
Date:   Mon, 14 Feb 2022 17:34:52 +0100
Message-Id: <20220214163452.1568807-15-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are no more users of CONFIG_SET_FS left, so drop all
remaining references to set_fs()/get_fs(), mm_segment_t
and uaccess_kernel().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/Kconfig                       |  3 ---
 arch/arm/lib/uaccess_with_memcpy.c | 10 ---------
 arch/nds32/kernel/process.c        |  5 ++---
 arch/parisc/include/asm/futex.h    |  2 +-
 arch/parisc/lib/memcpy.c           |  2 +-
 drivers/hid/uhid.c                 |  2 +-
 drivers/scsi/sg.c                  |  5 -----
 fs/exec.c                          |  6 ------
 include/asm-generic/access_ok.h    | 10 +--------
 include/linux/syscalls.h           |  4 ----
 include/linux/uaccess.h            | 33 ------------------------------
 include/rdma/ib.h                  |  2 +-
 kernel/events/callchain.c          |  4 ----
 kernel/events/core.c               |  3 ---
 kernel/exit.c                      | 14 -------------
 kernel/kthread.c                   |  5 -----
 kernel/stacktrace.c                |  3 ---
 kernel/trace/bpf_trace.c           |  4 ----
 mm/maccess.c                       | 11 ----------
 mm/memory.c                        |  8 --------
 net/bpfilter/bpfilter_kern.c       |  2 +-
 21 files changed, 8 insertions(+), 130 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..96075a12c720 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -24,9 +24,6 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
-config SET_FS
-	bool
-
 config HOTPLUG_SMT
 	bool
 
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 106f83a5ea6d..c30b689bec2e 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -92,11 +92,6 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 	unsigned long ua_flags;
 	int atomic;
 
-	if (uaccess_kernel()) {
-		memcpy((void *)to, from, n);
-		return 0;
-	}
-
 	/* the mmap semaphore is taken only if not in an atomic context */
 	atomic = faulthandler_disabled();
 
@@ -165,11 +160,6 @@ __clear_user_memset(void __user *addr, unsigned long n)
 {
 	unsigned long ua_flags;
 
-	if (uaccess_kernel()) {
-		memset((void *)addr, 0, n);
-		return 0;
-	}
-
 	mmap_read_lock(current->mm);
 	while (n) {
 		pte_t *pte;
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..d35c1f63fa11 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -119,9 +119,8 @@ void show_regs(struct pt_regs *regs)
 		regs->uregs[7], regs->uregs[6], regs->uregs[5], regs->uregs[4]);
 	pr_info("r3 : %08lx  r2 : %08lx  r1 : %08lx  r0 : %08lx\n",
 		regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->uregs[0]);
-	pr_info("  IRQs o%s  Segment %s\n",
-		interrupts_enabled(regs) ? "n" : "ff",
-		uaccess_kernel() ? "kernel" : "user");
+	pr_info("  IRQs o%s  Segment user\n",
+		interrupts_enabled(regs) ? "n" : "ff");
 }
 
 EXPORT_SYMBOL(show_regs);
diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
index b5835325d44b..2f4a1b1ef387 100644
--- a/arch/parisc/include/asm/futex.h
+++ b/arch/parisc/include/asm/futex.h
@@ -99,7 +99,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	/* futex.c wants to do a cmpxchg_inatomic on kernel NULL, which is
 	 * our gateway page, and causes no end of trouble...
 	 */
-	if (uaccess_kernel() && !uaddr)
+	if (!uaddr)
 		return -EFAULT;
 
 	if (!access_ok(uaddr, sizeof(u32)))
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index ea70a0e08321..468704ce8a1c 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -13,7 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/uaccess.h>
 
-#define get_user_space() (uaccess_kernel() ? 0 : mfsp(3))
+#define get_user_space() (mfsp(3))
 #define get_kernel_space() (0)
 
 /* Returns 0 for success, otherwise, returns number of bytes not transferred. */
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 614adb510dbd..2a918aeb0af1 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -747,7 +747,7 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 		 * copied from, so it's unsafe to allow this with elevated
 		 * privileges (e.g. from a setuid binary) or via kernel_write().
 		 */
-		if (file->f_cred != current_cred() || uaccess_kernel()) {
+		if (file->f_cred != current_cred()) {
 			pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
 				    task_tgid_vnr(current), current->comm);
 			ret = -EACCES;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 6b43e97bd417..aaa2376b9d34 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -224,11 +224,6 @@ static int sg_check_file_access(struct file *filp, const char *caller)
 			caller, task_tgid_vnr(current), current->comm);
 		return -EPERM;
 	}
-	if (uaccess_kernel()) {
-		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
-			caller, task_tgid_vnr(current), current->comm);
-		return -EACCES;
-	}
 	return 0;
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..bc68a0c089ac 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1303,12 +1303,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
 
-	/*
-	 * Ensure that the uaccess routines can actually operate on userspace
-	 * pointers:
-	 */
-	force_uaccess_begin();
-
 	if (me->flags & PF_KTHREAD)
 		free_kthread_struct(me);
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
diff --git a/include/asm-generic/access_ok.h b/include/asm-generic/access_ok.h
index 883b573af5fe..725647ba8ea9 100644
--- a/include/asm-generic/access_ok.h
+++ b/include/asm-generic/access_ok.h
@@ -16,16 +16,8 @@
 #define TASK_SIZE_MAX			TASK_SIZE
 #endif
 
-#ifndef uaccess_kernel
-#ifdef CONFIG_SET_FS
-#define uaccess_kernel()		(get_fs().seg == KERNEL_DS.seg)
-#else
-#define uaccess_kernel()		(0)
-#endif
-#endif
-
 #ifndef user_addr_max
-#define user_addr_max()			(uaccess_kernel() ? ~0UL : TASK_SIZE_MAX)
+#define user_addr_max()			TASK_SIZE_MAX
 #endif
 
 #ifndef __access_ok
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 819c0cb00b6d..a34b0f9a9972 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -290,10 +290,6 @@ static inline void addr_limit_user_check(void)
 		return;
 #endif
 
-	if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
-				  "Invalid address limit on user-mode return"))
-		force_sig(SIGKILL);
-
 #ifdef TIF_FSCHECK
 	clear_thread_flag(TIF_FSCHECK);
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 2c31667e62e0..2421a41f3a8e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -10,39 +10,6 @@
 
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_SET_FS
-/*
- * Force the uaccess routines to be wired up for actual userspace access,
- * overriding any possible set_fs(KERNEL_DS) still lingering around.  Undone
- * using force_uaccess_end below.
- */
-static inline mm_segment_t force_uaccess_begin(void)
-{
-	mm_segment_t fs = get_fs();
-
-	set_fs(USER_DS);
-	return fs;
-}
-
-static inline void force_uaccess_end(mm_segment_t oldfs)
-{
-	set_fs(oldfs);
-}
-#else /* CONFIG_SET_FS */
-typedef struct {
-	/* empty dummy */
-} mm_segment_t;
-
-static inline mm_segment_t force_uaccess_begin(void)
-{
-	return (mm_segment_t) { };
-}
-
-static inline void force_uaccess_end(mm_segment_t oldfs)
-{
-}
-#endif /* CONFIG_SET_FS */
-
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/include/rdma/ib.h b/include/rdma/ib.h
index 83139b9ce409..f7c185ff7a11 100644
--- a/include/rdma/ib.h
+++ b/include/rdma/ib.h
@@ -75,7 +75,7 @@ struct sockaddr_ib {
  */
 static inline bool ib_safe_file_access(struct file *filp)
 {
-	return filp->f_cred == current_cred() && !uaccess_kernel();
+	return filp->f_cred == current_cred();
 }
 
 #endif /* _RDMA_IB_H */
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 58cbe357fb2b..1273be84392c 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -209,17 +209,13 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 
 		if (regs) {
-			mm_segment_t fs;
-
 			if (crosstask)
 				goto exit_put;
 
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			fs = force_uaccess_begin();
 			perf_callchain_user(&ctx, regs);
-			force_uaccess_end(fs);
 		}
 	}
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57c7197838db..11ca7303d6df 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6746,7 +6746,6 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 		unsigned long sp;
 		unsigned int rem;
 		u64 dyn_size;
-		mm_segment_t fs;
 
 		/*
 		 * We dump:
@@ -6764,9 +6763,7 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 
 		/* Data. */
 		sp = perf_user_stack_pointer(regs);
-		fs = force_uaccess_begin();
 		rem = __output_copy_user(handle, (void *) sp, dump_size);
-		force_uaccess_end(fs);
 		dyn_size = dump_size - rem;
 
 		perf_output_skip(handle, rem);
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab9..0884a75bc2f8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -737,20 +737,6 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(blk_needs_flush_plug(tsk));
 
-	/*
-	 * If do_dead is called because this processes oopsed, it's possible
-	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
-	 * continuing. Amongst other possible reasons, this is to prevent
-	 * mm_release()->clear_child_tid() from writing to a user-controlled
-	 * kernel address.
-	 *
-	 * On uptodate architectures force_uaccess_begin is a noop.  On
-	 * architectures that still have set_fs/get_fs in addition to handling
-	 * oopses handles kernel threads that run as set_fs(KERNEL_DS) by
-	 * default.
-	 */
-	force_uaccess_begin();
-
 	kcov_task_exit(tsk);
 
 	coredump_task_exit(tsk);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 38c6dd822da8..16c2275d4b50 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -55,7 +55,6 @@ struct kthread {
 	int result;
 	int (*threadfn)(void *);
 	void *data;
-	mm_segment_t oldfs;
 	struct completion parked;
 	struct completion exited;
 #ifdef CONFIG_BLK_CGROUP
@@ -1441,8 +1440,6 @@ void kthread_use_mm(struct mm_struct *mm)
 		mmdrop(active_mm);
 	else
 		smp_mb();
-
-	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
 EXPORT_SYMBOL_GPL(kthread_use_mm);
 
@@ -1457,8 +1454,6 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!tsk->mm);
 
-	force_uaccess_end(to_kthread(tsk)->oldfs);
-
 	task_lock(tsk);
 	/*
 	 * When a kthread stops operating on an address space, the loop
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9c625257023d..9ed5ce989415 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -226,15 +226,12 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 		.store	= store,
 		.size	= size,
 	};
-	mm_segment_t fs;
 
 	/* Trace user stack if not a kernel thread */
 	if (current->flags & PF_KTHREAD)
 		return 0;
 
-	fs = force_uaccess_begin();
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
-	force_uaccess_end(fs);
 
 	return c.len;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 21aa30644219..8115fff17018 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -332,8 +332,6 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
 	if (unlikely(in_interrupt() ||
 		     current->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
-	if (unlikely(uaccess_kernel()))
-		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 
@@ -835,8 +833,6 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	 */
 	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
-	if (unlikely(uaccess_kernel()))
-		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 
diff --git a/mm/maccess.c b/mm/maccess.c
index cbd1b3959af2..106820b33a2b 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -113,14 +113,11 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	mm_segment_t old_fs = force_uaccess_begin();
-
 	if (access_ok(src, size)) {
 		pagefault_disable();
 		ret = __copy_from_user_inatomic(dst, src, size);
 		pagefault_enable();
 	}
-	force_uaccess_end(old_fs);
 
 	if (ret)
 		return -EFAULT;
@@ -140,14 +137,12 @@ EXPORT_SYMBOL_GPL(copy_from_user_nofault);
 long copy_to_user_nofault(void __user *dst, const void *src, size_t size)
 {
 	long ret = -EFAULT;
-	mm_segment_t old_fs = force_uaccess_begin();
 
 	if (access_ok(dst, size)) {
 		pagefault_disable();
 		ret = __copy_to_user_inatomic(dst, src, size);
 		pagefault_enable();
 	}
-	force_uaccess_end(old_fs);
 
 	if (ret)
 		return -EFAULT;
@@ -176,17 +171,14 @@ EXPORT_SYMBOL_GPL(copy_to_user_nofault);
 long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 			      long count)
 {
-	mm_segment_t old_fs;
 	long ret;
 
 	if (unlikely(count <= 0))
 		return 0;
 
-	old_fs = force_uaccess_begin();
 	pagefault_disable();
 	ret = strncpy_from_user(dst, unsafe_addr, count);
 	pagefault_enable();
-	force_uaccess_end(old_fs);
 
 	if (ret >= count) {
 		ret = count;
@@ -216,14 +208,11 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
  */
 long strnlen_user_nofault(const void __user *unsafe_addr, long count)
 {
-	mm_segment_t old_fs;
 	int ret;
 
-	old_fs = force_uaccess_begin();
 	pagefault_disable();
 	ret = strnlen_user(unsafe_addr, count);
 	pagefault_enable();
-	force_uaccess_end(old_fs);
 
 	return ret;
 }
diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..9a6ebf68a846 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5256,14 +5256,6 @@ void print_vma_addr(char *prefix, unsigned long ip)
 #if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 void __might_fault(const char *file, int line)
 {
-	/*
-	 * Some code (nfs/sunrpc) uses socket ops on kernel memory while
-	 * holding the mmap_lock, this is safe because kernel memory doesn't
-	 * get paged out, therefore we'll never actually fault, and the
-	 * below annotations will generate false positives.
-	 */
-	if (uaccess_kernel())
-		return;
 	if (pagefault_disabled())
 		return;
 	__might_sleep(file, line);
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 51a941b56ec3..422ec6e7ccff 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -70,7 +70,7 @@ static int bpfilter_process_sockopt(struct sock *sk, int optname,
 		.addr		= (uintptr_t)optval.user,
 		.len		= optlen,
 	};
-	if (uaccess_kernel() || sockptr_is_kernel(optval)) {
+	if (sockptr_is_kernel(optval)) {
 		pr_err("kernel access not supported\n");
 		return -EFAULT;
 	}
-- 
2.29.2

