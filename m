Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642703AD282
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhFRTIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFRTI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 15:08:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C9C061574
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 12:06:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u18so3020825pfk.11
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pWbJVzUhPPJsbP/kt20QtZAE0r0a3bWR2uabWMwTai4=;
        b=kDs3Dx47JwMl0DEZfZbJxOPd95Mct/ICLhkmUabd3RDEtTxjU3vcdb/8UwEcHRqWg+
         ZCggAAjP4tynFbncAh7HTdOWnnyTMWnFCkbpsJdF5QSXgbkhwOXDdf+ky7VSzG6qIkuq
         Tu/yWvSJ9OmN7c5RTiz/mM6FzRHs676Ofm/HzoQ+7nHnrmi5lB9AzGmb8mo88NLusbzz
         xnm3m6hwbN8kGw35RCcRTquj87aA7g1zSigrArTIJJlxTC5txJjR2gBDCV6EbDNf2Twm
         E0cXN851esn8ZeJfaxlziAhlFIOqtfokhQDCcY8UIrg5jrQHVGAPcTPs6gm+RXfqtZs1
         NTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pWbJVzUhPPJsbP/kt20QtZAE0r0a3bWR2uabWMwTai4=;
        b=ObqDSUwn7DGb9zRYYLc0asst4DmtSC33vqYWeMWyesPKMnrFRs/CsTgnK080Mu3O/h
         ExBJktrAeV7D2x2sRKDj9JIfSEQZMVBQq3iBwvdq45CV60RSYQ4LRqBK17PTerGgdA87
         3evx8/xZWXNss+l8l50FF0Kb6dOSFl6JnnqF4e/cUAe+sMRNrYRNGgabRWe8/ymqTHzu
         6dINY/5DraJbEf6WyB+ngbzvbfMO6rMl9toNRkFjzPRLzshH+yTFja8ZuptAFx76o3cq
         a+IOf7Wm0Y60fFil2O2OA3uCTuaD6mCaoH1H68GP6TyJv0lkfGXQONZv1NTOxZJ7x8v/
         A3aA==
X-Gm-Message-State: AOAM531/CKsWt7ptryJ9bu1DPYxi+DA0r3s23E/49SYS2QW5MzfC1maR
        yELh5ARkHWLCbtuujaPJ92B6t4G+Fz0=
X-Google-Smtp-Source: ABdhPJzjLDgHPg/wMktd3QJlAKFWOHFItCYg7Zv/mCQS9dAoFpsKeBFqszAZI26RFkMd+g91Pxt6dQ==
X-Received: by 2002:a62:800d:0:b029:2f0:fe27:2935 with SMTP id j13-20020a62800d0000b02902f0fe272935mr6729431pfd.15.1624043178432;
        Fri, 18 Jun 2021 12:06:18 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id g5sm2535788pfb.191.2021.06.18.12.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jun 2021 12:06:17 -0700 (PDT)
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry
 points
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <87sg1f3tm9.fsf@disp2133>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <861db97f-0b0b-2509-fc21-0d4be6a318b5@gmail.com>
Date:   Sat, 19 Jun 2021 07:06:10 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <87sg1f3tm9.fsf@disp2133>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

Am 19.06.2021 um 06:39 schrieb Eric W. Biederman:
> Michael Schmitz <schmitzmic@gmail.com> writes:
>
>> Multiple syscalls are liable to PTRACE_EVENT_* tracing and thus
>> require full user context saved on the kernel stack. We only
>> save those registers not preserved by C code currently.
>>
>> do_exit() calls ptrace_stop() which may require access to all
>> saved registers. Add code to save additional registers in the
>> switch_stack struct for exit and exit_group syscalls (similar
>> to what is already done for fork, vfork and clone3). According
>> to Eric's analysis, execve and execveat can be traced as well,
>> so have been given the same treatment.
>>
>> I'm not sure what to do about io_uring_setup - added code to
>> save full context on entry, and some more code to save/restore
>> additional registers on the switch stack around the kworker thread
>> call in ret_from_kernel_thread, but this may well be redundant.
>>
>> I'd need specific test cases to exercise io_uring_setup in
>> particular, to see whether stack offsets for pt_regs and the
>> switch stack have been messed up.
>>
>> Boot tested on ARAnym - earlier version including io_uring entry
>> save also tested on real hardware unter heavy IO load.
>
>
> Are the registers that SAVE_SWITCH_STACK saves on m68k caller saved
> registers?

Yes, see comments in arch/m68k/include/asm/entry.h. From my 
understanding of arch/alpha/kernel/entry.S, that's the same on alpha.

Cheers,

	Michael

> The fact that the registers are saved somewhere on the stack on alpha is
> what forces the registers to be saved before calling exit and exec.
>
> Eric
>
>
>> CC: Eric W. Biederman <ebiederm@xmission.com>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Andreas Schwab <schwab@linux-m68k.org>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> --
>> Changes from v1:
>>
>> - added exec, execve and io_uring_setup syscalls
>> - save extra registers around kworker thread calls
>> ---
>>  arch/m68k/kernel/entry.S              | 41 ++++++++++++++++++++++++++++++++++-
>>  arch/m68k/kernel/process.c            | 39 +++++++++++++++++++++++++++++++++
>>  arch/m68k/kernel/syscalls/syscall.tbl | 10 ++++-----
>>  3 files changed, 84 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
>> index 9dd76fb..02bf2a1 100644
>> --- a/arch/m68k/kernel/entry.S
>> +++ b/arch/m68k/kernel/entry.S
>> @@ -76,6 +76,41 @@ ENTRY(__sys_clone3)
>>  	lea	%sp@(28),%sp
>>  	rts
>>
>> +ENTRY(__sys_exit)
>> +	SAVE_SWITCH_STACK
>> +	pea	%sp@(SWITCH_STACK_SIZE)
>> +	jbsr	m68k_exit
>> +	lea	%sp@(28),%sp
>> +	rts
>> +
>> +ENTRY(__sys_exit_group)
>> +	SAVE_SWITCH_STACK
>> +	pea	%sp@(SWITCH_STACK_SIZE)
>> +	jbsr	m68k_exit_group
>> +	lea	%sp@(28),%sp
>> +	rts
>> +
>> +ENTRY(__sys_execve)
>> +	SAVE_SWITCH_STACK
>> +	pea	%sp@(SWITCH_STACK_SIZE)
>> +	jbsr	m68k_execve
>> +	lea	%sp@(28),%sp
>> +	rts
>> +
>> +ENTRY(__sys_execveat)
>> +	SAVE_SWITCH_STACK
>> +	pea	%sp@(SWITCH_STACK_SIZE)
>> +	jbsr	m68k_execveat
>> +	lea	%sp@(28),%sp
>> +	rts
>> +
>> +ENTRY(__sys_io_uring_setup)
>> +	SAVE_SWITCH_STACK
>> +	pea	%sp@(SWITCH_STACK_SIZE)
>> +	jbsr	m68k_io_uring_setup
>> +	lea	%sp@(28),%sp
>> +	rts
>> +
>>  ENTRY(sys_sigreturn)
>>  	SAVE_SWITCH_STACK
>>  	movel	%sp,%sp@-		  | switch_stack pointer
>> @@ -123,9 +158,13 @@ ENTRY(ret_from_kernel_thread)
>>  	| a3 contains the kernel thread payload, d7 - its argument
>>  	movel	%d1,%sp@-
>>  	jsr	schedule_tail
>> -	movel	%d7,(%sp)
>> +	addql	#4,%sp
>> +	| kernel threads can be traced!
>> +	SAVE_SWITCH_STACK
>> +	movel	%d7,%sp@-
>>  	jsr	%a3@
>>  	addql	#4,%sp
>> +	RESTORE_SWITCH_STACK
>>  	jra	ret_from_exception
>>
>>  #if defined(CONFIG_COLDFIRE) || !defined(CONFIG_MMU)
>> diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
>> index da83cc8..298ac99 100644
>> --- a/arch/m68k/kernel/process.c
>> +++ b/arch/m68k/kernel/process.c
>> @@ -138,6 +138,45 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
>>  	return sys_clone3((struct clone_args __user *)regs->d1, regs->d2);
>>  }
>>
>> +/*
>> + * Because extra registers are saved on the stack after the sys_exit()
>> + * arguments, this C wrapper extracts them from pt_regs * and then calls the
>> + * generic sys_exit() implementation.
>> + */
>> +asmlinkage int m68k_exit(struct pt_regs *regs)
>> +{
>> +	return sys_exit(regs->d1);
>> +}
>> +
>> +/* Same for sys_exit_group ... */
>> +asmlinkage int m68k_exit_group(struct pt_regs *regs)
>> +{
>> +	return sys_exit_group(regs->d1);
>> +}
>> +
>> +/* Same for sys_exit_group ... */
>> +asmlinkage int m68k_execve(struct pt_regs *regs)
>> +{
>> +	return sys_execve((const char __user *)regs->d1,
>> +			(const char __user *const __user*)regs->d2,
>> +			(const char __user *const __user*)regs->d3);
>> +}
>> +
>> +/* Same for sys_exit_group ... */
>> +asmlinkage int m68k_execveat(struct pt_regs *regs)
>> +{
>> +	return sys_execveat(regs->d1, (const char __user *)regs->d2,
>> +			(const char __user *const __user*)regs->d3,
>> +			(const char __user *const __user*)regs->d4,
>> +			regs->d5);
>> +}
>> +
>> +/* and for sys_io_uring_create */
>> +asmlinkage int m68k_io_uring_setup(struct pt_regs *regs)
>> +{
>> +	return sys_io_uring_setup(regs->d1,(struct io_uring_params __user *)regs->d2);
>> +}
>> +
>>  int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>>  		struct task_struct *p, unsigned long tls)
>>  {
>> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
>> index 0dd019d..4a1ba1d 100644
>> --- a/arch/m68k/kernel/syscalls/syscall.tbl
>> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
>> @@ -8,7 +8,7 @@
>>  # The <abi> is always "common" for this file
>>  #
>>  0	common	restart_syscall			sys_restart_syscall
>> -1	common	exit				sys_exit
>> +1	common	exit				__sys_exit
>>  2	common	fork				__sys_fork
>>  3	common	read				sys_read
>>  4	common	write				sys_write
>> @@ -18,7 +18,7 @@
>>  8	common	creat				sys_creat
>>  9	common	link				sys_link
>>  10	common	unlink				sys_unlink
>> -11	common	execve				sys_execve
>> +11	common	execve				__sys_execve
>>  12	common	chdir				sys_chdir
>>  13	common	time				sys_time32
>>  14	common	mknod				sys_mknod
>> @@ -254,7 +254,7 @@
>>  244	common	io_submit			sys_io_submit
>>  245	common	io_cancel			sys_io_cancel
>>  246	common	fadvise64			sys_fadvise64
>> -247	common	exit_group			sys_exit_group
>> +247	common	exit_group			__sys_exit_group
>>  248	common	lookup_dcookie			sys_lookup_dcookie
>>  249	common	epoll_create			sys_epoll_create
>>  250	common	epoll_ctl			sys_epoll_ctl
>> @@ -362,7 +362,7 @@
>>  352	common	getrandom			sys_getrandom
>>  353	common	memfd_create			sys_memfd_create
>>  354	common	bpf				sys_bpf
>> -355	common	execveat			sys_execveat
>> +355	common	execveat			__sys_execveat
>>  356	common	socket				sys_socket
>>  357	common	socketpair			sys_socketpair
>>  358	common	bind				sys_bind
>> @@ -424,7 +424,7 @@
>>  422	common	futex_time64			sys_futex
>>  423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
>>  424	common	pidfd_send_signal		sys_pidfd_send_signal
>> -425	common	io_uring_setup			sys_io_uring_setup
>> +425	common	io_uring_setup			__sys_io_uring_setup
>>  426	common	io_uring_enter			sys_io_uring_enter
>>  427	common	io_uring_register		sys_io_uring_register
>>  428	common	open_tree			sys_open_tree
