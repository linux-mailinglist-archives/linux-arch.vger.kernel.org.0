Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827BB3AD252
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhFRSme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 14:42:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48624 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhFRSmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 14:42:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1luJPi-0068vz-6T; Fri, 18 Jun 2021 12:40:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1luJPf-004iGm-RR; Fri, 18 Jun 2021 12:40:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
Date:   Fri, 18 Jun 2021 13:39:10 -0500
In-Reply-To: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com> (Michael
        Schmitz's message of "Fri, 18 Jun 2021 13:27:22 +1200")
Message-ID: <87sg1f3tm9.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1luJPf-004iGm-RR;;;mid=<87sg1f3tm9.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+YXG+rQ1XrRBSlH+CG4zcrklPcL85W34=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1678 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 9 (0.6%), parse: 1.14 (0.1%),
         extract_message_metadata: 22 (1.3%), get_uri_detail_list: 4.0 (0.2%),
        tests_pri_-1000: 17 (1.0%), tests_pri_-950: 1.24 (0.1%),
        tests_pri_-900: 0.98 (0.1%), tests_pri_-90: 119 (7.1%), check_bayes:
        101 (6.0%), b_tokenize: 14 (0.8%), b_tok_get_all: 11 (0.7%),
        b_comp_prob: 3.1 (0.2%), b_tok_touch_all: 68 (4.1%), b_finish: 1.37
        (0.1%), tests_pri_0: 1483 (88.4%), check_dkim_signature: 0.80 (0.0%),
        check_dkim_adsp: 12 (0.7%), poll_dns_idle: 0.64 (0.0%), tests_pri_10:
        4.4 (0.3%), tests_pri_500: 13 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry points
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Multiple syscalls are liable to PTRACE_EVENT_* tracing and thus
> require full user context saved on the kernel stack. We only
> save those registers not preserved by C code currently.
>
> do_exit() calls ptrace_stop() which may require access to all
> saved registers. Add code to save additional registers in the
> switch_stack struct for exit and exit_group syscalls (similar
> to what is already done for fork, vfork and clone3). According
> to Eric's analysis, execve and execveat can be traced as well,
> so have been given the same treatment.
>
> I'm not sure what to do about io_uring_setup - added code to
> save full context on entry, and some more code to save/restore
> additional registers on the switch stack around the kworker thread
> call in ret_from_kernel_thread, but this may well be redundant.
>
> I'd need specific test cases to exercise io_uring_setup in
> particular, to see whether stack offsets for pt_regs and the
> switch stack have been messed up.
>
> Boot tested on ARAnym - earlier version including io_uring entry
> save also tested on real hardware unter heavy IO load.


Are the registers that SAVE_SWITCH_STACK saves on m68k caller saved
registers?

The fact that the registers are saved somewhere on the stack on alpha is
what forces the registers to be saved before calling exit and exec.

Eric


> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> --
> Changes from v1:
>
> - added exec, execve and io_uring_setup syscalls
> - save extra registers around kworker thread calls
> ---
>  arch/m68k/kernel/entry.S              | 41 ++++++++++++++++++++++++++++++++++-
>  arch/m68k/kernel/process.c            | 39 +++++++++++++++++++++++++++++++++
>  arch/m68k/kernel/syscalls/syscall.tbl | 10 ++++-----
>  3 files changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
> index 9dd76fb..02bf2a1 100644
> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -76,6 +76,41 @@ ENTRY(__sys_clone3)
>  	lea	%sp@(28),%sp
>  	rts
>  
> +ENTRY(__sys_exit)
> +	SAVE_SWITCH_STACK
> +	pea	%sp@(SWITCH_STACK_SIZE)
> +	jbsr	m68k_exit
> +	lea	%sp@(28),%sp
> +	rts
> +
> +ENTRY(__sys_exit_group)
> +	SAVE_SWITCH_STACK
> +	pea	%sp@(SWITCH_STACK_SIZE)
> +	jbsr	m68k_exit_group
> +	lea	%sp@(28),%sp
> +	rts
> +
> +ENTRY(__sys_execve)
> +	SAVE_SWITCH_STACK
> +	pea	%sp@(SWITCH_STACK_SIZE)
> +	jbsr	m68k_execve
> +	lea	%sp@(28),%sp
> +	rts
> +
> +ENTRY(__sys_execveat)
> +	SAVE_SWITCH_STACK
> +	pea	%sp@(SWITCH_STACK_SIZE)
> +	jbsr	m68k_execveat
> +	lea	%sp@(28),%sp
> +	rts
> +
> +ENTRY(__sys_io_uring_setup)
> +	SAVE_SWITCH_STACK
> +	pea	%sp@(SWITCH_STACK_SIZE)
> +	jbsr	m68k_io_uring_setup
> +	lea	%sp@(28),%sp
> +	rts
> +
>  ENTRY(sys_sigreturn)
>  	SAVE_SWITCH_STACK
>  	movel	%sp,%sp@-		  | switch_stack pointer
> @@ -123,9 +158,13 @@ ENTRY(ret_from_kernel_thread)
>  	| a3 contains the kernel thread payload, d7 - its argument
>  	movel	%d1,%sp@-
>  	jsr	schedule_tail
> -	movel	%d7,(%sp)
> +	addql	#4,%sp
> +	| kernel threads can be traced!
> +	SAVE_SWITCH_STACK
> +	movel	%d7,%sp@-
>  	jsr	%a3@
>  	addql	#4,%sp
> +	RESTORE_SWITCH_STACK
>  	jra	ret_from_exception
>  
>  #if defined(CONFIG_COLDFIRE) || !defined(CONFIG_MMU)
> diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
> index da83cc8..298ac99 100644
> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -138,6 +138,45 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
>  	return sys_clone3((struct clone_args __user *)regs->d1, regs->d2);
>  }
>  
> +/*
> + * Because extra registers are saved on the stack after the sys_exit()
> + * arguments, this C wrapper extracts them from pt_regs * and then calls the
> + * generic sys_exit() implementation.
> + */
> +asmlinkage int m68k_exit(struct pt_regs *regs)
> +{
> +	return sys_exit(regs->d1);
> +}
> +
> +/* Same for sys_exit_group ... */
> +asmlinkage int m68k_exit_group(struct pt_regs *regs)
> +{
> +	return sys_exit_group(regs->d1);
> +}
> +
> +/* Same for sys_exit_group ... */
> +asmlinkage int m68k_execve(struct pt_regs *regs)
> +{
> +	return sys_execve((const char __user *)regs->d1,
> +			(const char __user *const __user*)regs->d2,
> +			(const char __user *const __user*)regs->d3);
> +}
> +
> +/* Same for sys_exit_group ... */
> +asmlinkage int m68k_execveat(struct pt_regs *regs)
> +{
> +	return sys_execveat(regs->d1, (const char __user *)regs->d2,
> +			(const char __user *const __user*)regs->d3,
> +			(const char __user *const __user*)regs->d4,
> +			regs->d5);
> +}
> +
> +/* and for sys_io_uring_create */
> +asmlinkage int m68k_io_uring_setup(struct pt_regs *regs)
> +{
> +	return sys_io_uring_setup(regs->d1,(struct io_uring_params __user *)regs->d2);
> +}
> +
>  int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>  		struct task_struct *p, unsigned long tls)
>  {
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 0dd019d..4a1ba1d 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -8,7 +8,7 @@
>  # The <abi> is always "common" for this file
>  #
>  0	common	restart_syscall			sys_restart_syscall
> -1	common	exit				sys_exit
> +1	common	exit				__sys_exit
>  2	common	fork				__sys_fork
>  3	common	read				sys_read
>  4	common	write				sys_write
> @@ -18,7 +18,7 @@
>  8	common	creat				sys_creat
>  9	common	link				sys_link
>  10	common	unlink				sys_unlink
> -11	common	execve				sys_execve
> +11	common	execve				__sys_execve
>  12	common	chdir				sys_chdir
>  13	common	time				sys_time32
>  14	common	mknod				sys_mknod
> @@ -254,7 +254,7 @@
>  244	common	io_submit			sys_io_submit
>  245	common	io_cancel			sys_io_cancel
>  246	common	fadvise64			sys_fadvise64
> -247	common	exit_group			sys_exit_group
> +247	common	exit_group			__sys_exit_group
>  248	common	lookup_dcookie			sys_lookup_dcookie
>  249	common	epoll_create			sys_epoll_create
>  250	common	epoll_ctl			sys_epoll_ctl
> @@ -362,7 +362,7 @@
>  352	common	getrandom			sys_getrandom
>  353	common	memfd_create			sys_memfd_create
>  354	common	bpf				sys_bpf
> -355	common	execveat			sys_execveat
> +355	common	execveat			__sys_execveat
>  356	common	socket				sys_socket
>  357	common	socketpair			sys_socketpair
>  358	common	bind				sys_bind
> @@ -424,7 +424,7 @@
>  422	common	futex_time64			sys_futex
>  423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
>  424	common	pidfd_send_signal		sys_pidfd_send_signal
> -425	common	io_uring_setup			sys_io_uring_setup
> +425	common	io_uring_setup			__sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
>  428	common	open_tree			sys_open_tree
