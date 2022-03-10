Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160A24D555F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Mar 2022 00:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiCJXbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 18:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiCJXa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 18:30:59 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DE9BAFB;
        Thu, 10 Mar 2022 15:29:57 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:56702)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nSSE2-006V5v-6z; Thu, 10 Mar 2022 16:29:44 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34982 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nSSDz-00Bo9z-RI; Thu, 10 Mar 2022 16:29:41 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?M=C3=A5ns_Rullg=C3=A5r?= =?utf-8?Q?d?= <mans@mansr.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Cree <mcree@orcon.net.nz>, linux-arch@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
        <YeCuNapJLK4M5sat@zn.tnic>
        <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
        <YeHLIDsjGB944GSP@zn.tnic>
        <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
        <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic>
        <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
        <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
        <164686349541.391760.11942525130947458475.b4-ty@chromium.org>
Date:   Thu, 10 Mar 2022 17:29:13 -0600
In-Reply-To: <164686349541.391760.11942525130947458475.b4-ty@chromium.org>
        (Kees Cook's message of "Wed, 9 Mar 2022 14:04:59 -0800")
Message-ID: <87czit4cae.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nSSDz-00Bo9z-RI;;;mid=<87czit4cae.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+RCzptvo05cQvgJyUqlRMkKWpFJ2xXLD8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1055 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.1%), b_tie_ro: 10 (1.0%), parse: 2.3 (0.2%),
         extract_message_metadata: 24 (2.3%), get_uri_detail_list: 6 (0.6%),
        tests_pri_-1000: 27 (2.5%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 244 (23.1%), check_bayes:
        232 (22.0%), b_tokenize: 23 (2.2%), b_tok_get_all: 18 (1.7%),
        b_comp_prob: 4.5 (0.4%), b_tok_touch_all: 181 (17.2%), b_finish: 0.96
        (0.1%), tests_pri_0: 724 (68.6%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 2.9 (0.3%), poll_dns_idle: 0.99 (0.1%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 13 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] x86: Remove a.out support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


From: Borislav Petkov <bp@suse.de>
Date: Thu, 13 Jan 2022 17:01:15 +0100
Subject: [PATCH] x86: Remove a.out support

Commit

  eac616557050 ("x86: Deprecate a.out support")

deprecated a.out support with the promise to remove it a couple of
releases later. That commit landed in v5.1.

Now it is more than a couple of releases later, no one has complained so
remove it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20220113160115.5375-1-bp@alien8.de
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

Kees can you pick this one up in for-next/execve as well?

It still applies cleanly and the actual patch seems to have gotten lost
in the conversation about what more we could do.

Thanks,
Eric


 arch/x86/Kconfig          |   7 -
 arch/x86/ia32/Makefile    |   2 -
 arch/x86/ia32/ia32_aout.c | 325 --------------------------------------
 3 files changed, 334 deletions(-)
 delete mode 100644 arch/x86/ia32/ia32_aout.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..b6563d6681c1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2827,13 +2827,6 @@ config IA32_EMULATION
 	  64-bit kernel. You should likely turn this on, unless you're
 	  100% sure that you don't have any 32-bit programs left.
 
-config IA32_AOUT
-	tristate "IA32 a.out support"
-	depends on IA32_EMULATION
-	depends on BROKEN
-	help
-	  Support old a.out binaries in the 32bit emulation.
-
 config X86_X32
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index 8e4d0391ff6c..e481056698de 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -5,7 +5,5 @@
 
 obj-$(CONFIG_IA32_EMULATION) := ia32_signal.o
 
-obj-$(CONFIG_IA32_AOUT) += ia32_aout.o
-
 audit-class-$(CONFIG_AUDIT) := audit.o
 obj-$(CONFIG_IA32_EMULATION) += $(audit-class-y)
diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
deleted file mode 100644
index 9bd15241fadb..000000000000
--- a/arch/x86/ia32/ia32_aout.c
+++ /dev/null
@@ -1,325 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  a.out loader for x86-64
- *
- *  Copyright (C) 1991, 1992, 1996  Linus Torvalds
- *  Hacked together by Andi Kleen
- */
-
-#include <linux/module.h>
-
-#include <linux/time.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
-#include <linux/a.out.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
-#include <linux/user.h>
-#include <linux/binfmts.h>
-#include <linux/personality.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/perf_event.h>
-#include <linux/sched/task_stack.h>
-
-#include <linux/uaccess.h>
-#include <asm/cacheflush.h>
-#include <asm/user32.h>
-#include <asm/ia32.h>
-
-#undef WARN_OLD
-
-static int load_aout_binary(struct linux_binprm *);
-static int load_aout_library(struct file *);
-
-static struct linux_binfmt aout_format = {
-	.module		= THIS_MODULE,
-	.load_binary	= load_aout_binary,
-	.load_shlib	= load_aout_library,
-};
-
-static int set_brk(unsigned long start, unsigned long end)
-{
-	start = PAGE_ALIGN(start);
-	end = PAGE_ALIGN(end);
-	if (end <= start)
-		return 0;
-	return vm_brk(start, end - start);
-}
-
-
-/*
- * create_aout_tables() parses the env- and arg-strings in new user
- * memory and creates the pointer tables from them, and puts their
- * addresses on the "stack", returning the new stack pointer value.
- */
-static u32 __user *create_aout_tables(char __user *p, struct linux_binprm *bprm)
-{
-	u32 __user *argv, *envp, *sp;
-	int argc = bprm->argc, envc = bprm->envc;
-
-	sp = (u32 __user *) ((-(unsigned long)sizeof(u32)) & (unsigned long) p);
-	sp -= envc+1;
-	envp = sp;
-	sp -= argc+1;
-	argv = sp;
-	put_user((unsigned long) envp, --sp);
-	put_user((unsigned long) argv, --sp);
-	put_user(argc, --sp);
-	current->mm->arg_start = (unsigned long) p;
-	while (argc-- > 0) {
-		char c;
-
-		put_user((u32)(unsigned long)p, argv++);
-		do {
-			get_user(c, p++);
-		} while (c);
-	}
-	put_user(0, argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-- > 0) {
-		char c;
-
-		put_user((u32)(unsigned long)p, envp++);
-		do {
-			get_user(c, p++);
-		} while (c);
-	}
-	put_user(0, envp);
-	current->mm->env_end = (unsigned long) p;
-	return sp;
-}
-
-/*
- * These are the functions used to load a.out style executables and shared
- * libraries.  There is no binary dependent code anywhere else.
- */
-static int load_aout_binary(struct linux_binprm *bprm)
-{
-	unsigned long error, fd_offset, rlim;
-	struct pt_regs *regs = current_pt_regs();
-	struct exec ex;
-	int retval;
-
-	ex = *((struct exec *) bprm->buf);		/* exec-header */
-	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
-	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
-	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    i_size_read(file_inode(bprm->file)) <
-	    ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
-		return -ENOEXEC;
-	}
-
-	fd_offset = N_TXTOFF(ex);
-
-	/* Check initial limits. This avoids letting people circumvent
-	 * size limits imposed on them by creating programs with large
-	 * arrays in the data or bss.
-	 */
-	rlim = rlimit(RLIMIT_DATA);
-	if (rlim >= RLIM_INFINITY)
-		rlim = ~0;
-	if (ex.a_data + ex.a_bss > rlim)
-		return -ENOMEM;
-
-	/* Flush all traces of the currently running executable */
-	retval = begin_new_exec(bprm);
-	if (retval)
-		return retval;
-
-	/* OK, This is the point of no return */
-	set_personality(PER_LINUX);
-	set_personality_ia32(false);
-
-	setup_new_exec(bprm);
-
-	regs->cs = __USER32_CS;
-	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
-		regs->r13 = regs->r14 = regs->r15 = 0;
-
-	current->mm->end_code = ex.a_text +
-		(current->mm->start_code = N_TXTADDR(ex));
-	current->mm->end_data = ex.a_data +
-		(current->mm->start_data = N_DATADDR(ex));
-	current->mm->brk = ex.a_bss +
-		(current->mm->start_brk = N_BSSADDR(ex));
-
-	retval = setup_arg_pages(bprm, IA32_STACK_TOP, EXSTACK_DEFAULT);
-	if (retval < 0)
-		return retval;
-
-	if (N_MAGIC(ex) == OMAGIC) {
-		unsigned long text_addr, map_size;
-
-		text_addr = N_TXTADDR(ex);
-		map_size = ex.a_text+ex.a_data;
-
-		error = vm_brk(text_addr & PAGE_MASK, map_size);
-
-		if (error)
-			return error;
-
-		error = read_code(bprm->file, text_addr, 32,
-				  ex.a_text + ex.a_data);
-		if ((signed long)error < 0)
-			return error;
-	} else {
-#ifdef WARN_OLD
-		static unsigned long error_time, error_time2;
-		if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
-		    (N_MAGIC(ex) != NMAGIC) &&
-				time_after(jiffies, error_time2 + 5*HZ)) {
-			printk(KERN_NOTICE "executable not page aligned\n");
-			error_time2 = jiffies;
-		}
-
-		if ((fd_offset & ~PAGE_MASK) != 0 &&
-			    time_after(jiffies, error_time + 5*HZ)) {
-			printk(KERN_WARNING
-			       "fd_offset is not page aligned. Please convert "
-			       "program: %pD\n",
-			       bprm->file);
-			error_time = jiffies;
-		}
-#endif
-
-		if (!bprm->file->f_op->mmap || (fd_offset & ~PAGE_MASK) != 0) {
-			error = vm_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
-			if (error)
-				return error;
-
-			read_code(bprm->file, N_TXTADDR(ex), fd_offset,
-					ex.a_text+ex.a_data);
-			goto beyond_if;
-		}
-
-		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
-				PROT_READ | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
-				fd_offset);
-
-		if (error != N_TXTADDR(ex))
-			return error;
-
-		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
-				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
-				fd_offset + ex.a_text);
-		if (error != N_DATADDR(ex))
-			return error;
-	}
-
-beyond_if:
-	error = set_brk(current->mm->start_brk, current->mm->brk);
-	if (error)
-		return error;
-
-	set_binfmt(&aout_format);
-
-	current->mm->start_stack =
-		(unsigned long)create_aout_tables((char __user *)bprm->p, bprm);
-	/* start thread */
-	loadsegment(fs, 0);
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
-	load_gs_index(0);
-	(regs)->ip = ex.a_entry;
-	(regs)->sp = current->mm->start_stack;
-	(regs)->flags = 0x200;
-	(regs)->cs = __USER32_CS;
-	(regs)->ss = __USER32_DS;
-	regs->r8 = regs->r9 = regs->r10 = regs->r11 =
-	regs->r12 = regs->r13 = regs->r14 = regs->r15 = 0;
-	return 0;
-}
-
-static int load_aout_library(struct file *file)
-{
-	unsigned long bss, start_addr, len, error;
-	int retval;
-	struct exec ex;
-	loff_t pos = 0;
-
-	retval = -ENOEXEC;
-	error = kernel_read(file, &ex, sizeof(ex), &pos);
-	if (error != sizeof(ex))
-		goto out;
-
-	/* We come in here for the regular a.out style of shared libraries */
-	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != QMAGIC) || N_TRSIZE(ex) ||
-	    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) == ZMAGIC) ||
-	    i_size_read(file_inode(file)) <
-	    ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
-		goto out;
-	}
-
-	if (N_FLAGS(ex))
-		goto out;
-
-	/* For  QMAGIC, the starting address is 0x20 into the page.  We mask
-	   this off to get the starting address for the page */
-
-	start_addr =  ex.a_entry & 0xfffff000;
-
-	if ((N_TXTOFF(ex) & ~PAGE_MASK) != 0) {
-#ifdef WARN_OLD
-		static unsigned long error_time;
-		if (time_after(jiffies, error_time + 5*HZ)) {
-			printk(KERN_WARNING
-			       "N_TXTOFF is not page aligned. Please convert "
-			       "library: %pD\n",
-			       file);
-			error_time = jiffies;
-		}
-#endif
-		retval = vm_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
-		if (retval)
-			goto out;
-
-		read_code(file, start_addr, N_TXTOFF(ex),
-			  ex.a_text + ex.a_data);
-		retval = 0;
-		goto out;
-	}
-	/* Now use mmap to map the library into memory. */
-	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
-			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
-			N_TXTOFF(ex));
-	retval = error;
-	if (error != start_addr)
-		goto out;
-
-	len = PAGE_ALIGN(ex.a_text + ex.a_data);
-	bss = ex.a_text + ex.a_data + ex.a_bss;
-	if (bss > len) {
-		retval = vm_brk(start_addr + len, bss - len);
-		if (retval)
-			goto out;
-	}
-	retval = 0;
-out:
-	return retval;
-}
-
-static int __init init_aout_binfmt(void)
-{
-	register_binfmt(&aout_format);
-	return 0;
-}
-
-static void __exit exit_aout_binfmt(void)
-{
-	unregister_binfmt(&aout_format);
-}
-
-module_init(init_aout_binfmt);
-module_exit(exit_aout_binfmt);
-MODULE_LICENSE("GPL");
-- 
2.29.2

