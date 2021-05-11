Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43A937AE91
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEKShq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 14:37:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKShq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 May 2021 14:37:46 -0400
Received: from zn.tnic (p200300ec2f0ec70091f309bcd5e4258d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:91f3:9bc:d5e4:258d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E286B1EC0322;
        Tue, 11 May 2021 20:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620758198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c6kPcub0QkpQg0U8CE4f25GTKDhTcZ3eq43HABvPeEo=;
        b=j0Y2Z5dhTyvHunNAIadIyNC5wt66gGlhAa+BJH2z3kau3oQovjx4aUPc8KShSTPbD+GOth
        aPUS06xEp0ZQJfsyUmIgOuNeTh/jbqSu0reKT/zwJtY7Q5/2gpYxrY0+qxbv+zP0eGZl/H
        ZzjRovtffHuN9syxyf5Hu+9DBS1+DlI=
Date:   Tue, 11 May 2021 20:36:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, jannh@google.com,
        mpe@ellerman.id.au, carlos@redhat.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <YJrOsbyYhMndI5jd@zn.tnic>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210422044856.27250-6-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 21, 2021 at 09:48:55PM -0700, Chang S. Bae wrote:
> The kernel pushes context on to the userspace stack to prepare for the
> user's signal handler. When the user has supplied an alternate signal
> stack, via sigaltstack(2), it is easy for the kernel to verify that the
> stack size is sufficient for the current hardware context.
> 
> Check if writing the hardware context to the alternate stack will exceed
> it's size. If yes, then instead of corrupting user-data and proceeding with
> the original signal handler, an immediate SIGSEGV signal is delivered.

So I did play with this more and modified
tools/testing/selftests/sigaltstack/sas.c, see diff at the end. It uses
MINSIGSTKSZ as the alt stack size and with it, sas.c does:

# [NOTE]        the stack size is 2048, AT_MINSIGSTKSZ: 3632
TAP version 13
1..3
ok 1 Initial sigaltstack state was SS_DISABLE
# sstack: 0x7fdc2cbf1000, ss_size: 2048
# [NOTE]        sigaltstack success
# [NOTE]        Will mmap user stack
# [NOTE]        Will getcontext
# [NOTE]        Will makecontext
# [NOTE]        Will raise SIGUSR1
Segmentation fault (core dumped)

and dmesg has:

[ 2245.641230] signal: get_sigframe: nested_altstack: 0, sp: 0x7ffe50a4d9d0, ka->sa.sa_flags: 0xc000004
[ 2245.641240] signal: get_sigframe: SA_ONSTACK, sas_ss_flags(sp): 0x0
[ 2245.641243] signal: get_sigframe: sp: 0x7fdc2cbf1800, entering_altstack
[ 2245.641245] signal: get_sigframe: nested_altstack: 0, entering_altstack: 1, __on_sig_stack: 0

Those are just debugging stuff, ignore them.

[ 2245.641249] signal: sas[8890] overflowed sigaltstack

So we do detect those overflows now.

I clumsily tried to register a SIGSEGV handler with

        act.sa_sigaction = my_sigsegv;
        sigaction(SIGSEGV, &act, NULL);

but that doesn't fire - task gets killed. Maybe I'm doing it wrong.

> @@ -272,8 +281,15 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>  	 * If we are on the alternate signal stack and would overflow it, don't.
>  	 * Return an always-bogus address instead so we will die with SIGSEGV.
>  	 */
> -	if (onsigstack && !likely(on_sig_stack(sp)))
> +	if (unlikely((nested_altstack || entering_altstack) &&
> +		     !__on_sig_stack(sp))) {
> +
> +		if (show_unhandled_signals && printk_ratelimit())
> +			pr_info("%s[%d] overflowed sigaltstack",

					This needs a "\n" at the end of the
					string.

> +				current->comm, task_pid_nr(current));
> +
>  		return (void __user *)-1L;
> +	}
>  
>  	/* save i387 and extended state */
>  	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);

---
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index c9c254d5791e..19eb9760e0b5 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -234,6 +234,12 @@ static unsigned long align_sigframe(unsigned long sp)
 	return sp;
 }
 
+#define dbg(fmt, args...)					\
+({								\
+	if (!strcmp(current->comm, "sas"))			\
+		 pr_err("%s: " fmt "\n", __func__, ##args);	\
+})
+
 static void __user *
 get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
@@ -250,8 +256,14 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	if (IS_ENABLED(CONFIG_X86_64))
 		sp -= 128;
 
+	dbg("nested_altstack: %d, sp: 0x%lx, ka->sa.sa_flags: 0x%lx",
+	    nested_altstack, sp, ka->sa.sa_flags);
+
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
+
+		dbg("SA_ONSTACK, sas_ss_flags(sp): 0x%x", sas_ss_flags(sp));
+
 		/*
 		 * This checks nested_altstack via sas_ss_flags(). Sensible
 		 * programs use SS_AUTODISARM, which disables that check, and
@@ -260,6 +272,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
 			entering_altstack = true;
+			dbg("sp: 0x%lx, entering_altstack", sp);
 		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
 		   !nested_altstack &&
@@ -277,6 +290,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	sp = align_sigframe(sp - frame_size);
 
+	dbg("nested_altstack: %d, entering_altstack: %d, __on_sig_stack: %d",
+	     nested_altstack, entering_altstack, __on_sig_stack(sp));
+
 	/*
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
diff --git a/tools/testing/selftests/sigaltstack/Makefile b/tools/testing/selftests/sigaltstack/Makefile
index 3e96d5d47036..b5ac8f9f0c7e 100644
--- a/tools/testing/selftests/sigaltstack/Makefile
+++ b/tools/testing/selftests/sigaltstack/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS = -Wall
+CFLAGS = -Wall -g
 TEST_GEN_PROGS = sas
 
 include ../lib.mk
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index c53b070755b6..f4c4f5418a08 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -39,6 +39,15 @@ struct stk_data {
 	int flag;
 };
 
+static char *my_strcpy(char *dest, const char *src)
+{
+	char *tmp = dest;
+
+	while ((*dest++ = *src++) != '\0')
+		/* nothing */;
+	return tmp;
+}
+
 void my_usr1(int sig, siginfo_t *si, void *u)
 {
 	char *aa;
@@ -60,7 +69,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 	aa = alloca(1024);
 	assert(aa);
 	p = (struct stk_data *)(aa + 512);
-	strcpy(p->msg, msg);
+	my_strcpy(p->msg, msg);
 	p->flag = 1;
 	ksft_print_msg("[RUN]\tsignal USR1\n");
 	err = sigaltstack(NULL, &stk);
@@ -101,6 +110,11 @@ void my_usr2(int sig, siginfo_t *si, void *u)
 	}
 }
 
+void my_sigsegv(int sig, siginfo_t *si, void *u)
+{
+	ksft_print_msg("[NOTE]\tsignal SEGV\n");
+}
+
 static void switch_fn(void)
 {
 	ksft_print_msg("[RUN]\tswitched to user ctx\n");
@@ -115,18 +129,33 @@ int main(void)
 	int err;
 
 	/* Make sure more than the required minimum. */
-	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
-	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
+//	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+	stack_size = MINSIGSTKSZ;
+	ksft_print_msg("[NOTE]\tthe stack size is %lu, AT_MINSIGSTKSZ: %lu\n",
+			stack_size, getauxval(AT_MINSIGSTKSZ));
 
 	ksft_print_header();
 	ksft_set_plan(3);
 
+	/* clear signal set */
 	sigemptyset(&act.sa_mask);
+
+	/* a registered stack_t will be used */
 	act.sa_flags = SA_ONSTACK | SA_SIGINFO;
+
+	/* SA_SIGINFO means sa_sigaction specifies the signal handler */
 	act.sa_sigaction = my_usr1;
+
+	/* change the signal action on SIGUSR1 using @act desc */
 	sigaction(SIGUSR1, &act, NULL);
+
+	/* same for SIGUSR2 */
 	act.sa_sigaction = my_usr2;
 	sigaction(SIGUSR2, &act, NULL);
+
+	act.sa_sigaction = my_sigsegv;
+	sigaction(SIGSEGV, &act, NULL);
+
 	sstack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (sstack == MAP_FAILED) {
@@ -150,6 +179,8 @@ int main(void)
 
 	stk.ss_sp = sstack;
 	stk.ss_size = stack_size;
+	ksft_print_msg("sstack: 0x%lx, ss_size: %d\n", sstack, stack_size);
+
 	stk.ss_flags = SS_ONSTACK | SS_AUTODISARM;
 	err = sigaltstack(&stk, NULL);
 	if (err) {
@@ -169,21 +200,45 @@ int main(void)
 					strerror(errno));
 			return EXIT_FAILURE;
 		}
+	} else {
+		ksft_print_msg("[NOTE]\tsigaltstack success\n");
 	}
 
+	ksft_print_msg("[NOTE]\tWill mmap user stack\n");
+
 	ustack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (ustack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
 		return EXIT_FAILURE;
 	}
+
+	ksft_print_msg("[NOTE]\tWill getcontext\n");
+
+	/* init @uc to the currently active context */
 	getcontext(&uc);
+
+	/* do not resume to other context when current context terminates */
 	uc.uc_link = NULL;
+
+	/* set up the stack to use */
 	uc.uc_stack.ss_sp = ustack;
 	uc.uc_stack.ss_size = stack_size;
+
+	ksft_print_msg("[NOTE]\tWill makecontext\n");
+
+	/*
+	 * Run @switch_fn when this context is activated with setcontext or
+	 * swapcontext.
+	 */
 	makecontext(&uc, switch_fn, 0);
+
+	ksft_print_msg("[NOTE]\tWill raise SIGUSR1\n");
+
 	raise(SIGUSR1);
 
+	ksft_print_msg("[NOTE]\tWill sigaltstack\n");
+
 	err = sigaltstack(NULL, &stk);
 	if (err) {
 		ksft_exit_fail_msg("sigaltstack() - %s\n", strerror(errno));


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
