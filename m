Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BA3AE195
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 04:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFUCDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFUCDo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 22:03:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667AC061574;
        Sun, 20 Jun 2021 19:01:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h4so1342158pgp.5;
        Sun, 20 Jun 2021 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eBenL+K0D9YseyOr/6iu7WZ/qK861+9DmHdUBK69eNs=;
        b=edUzJt4q73ySN+3FvCki7GDrq6S25JUvxXQottKAuCVu8h9ny4JmKxRiasuJGyjjc9
         al02KPO/zbNDhXMMrw5AngWJQpaSGIIz03brWP7pgFJGLqrCq+adN2Z2bAWsC6fSRu+B
         MnfXpHhvsOR/WcZCPbohwpcq8EGFXIU3DsY6h+xd6Coz8GRqr0WdBavpw9f1YBEJ/JDG
         tz95p3FS4110MFYav1m1+p/pdlOjl3iVrSQEYjyXJS5oFUs0PvU7h6E+VbK05QRivQPu
         JfECFr6fcLSecl5WvwIOvYL03BjUrrBwJS4ROuqzNhBwLrlP3CpKISsUlLdBN4ifmfrZ
         Z0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eBenL+K0D9YseyOr/6iu7WZ/qK861+9DmHdUBK69eNs=;
        b=ejdiKrmFgPrziq27df6oGMHufbsTNB0iuL6Dh02sxpxBRPDHoyAFf91qdPcc0ONZS9
         0tqNQIDokbwSJmmfmrJfV7U0kUhznCgLsRTWJfMgAb8ub4bFiRXdbWBu84mZCOwSof7r
         5s6eJA4VGCQQ8HC/dF4eAHMqTiltNgySiLg1LnXn5WubFj0ySP/3FXvNKXfp05rrgJNz
         v94b4CYBCJvkTyd/sh5Fdkmmu59TCsoQBNz8Cbo+YVK++zvwjwuaXRLxSvsUI0eNHhAT
         g/6j6sDhR1z1tm9I0C84T05c0ZpNmEfAx41VkGrhjcC58NJQBh88UY/Vt7gA62Xw+SE0
         4ZMA==
X-Gm-Message-State: AOAM533RoxjuBBlwXGZh2tvRAVmwwR3UPH8N4Fz9ICe8iFbXAHTjMgp1
        4G2o1KanAJCcRHws4Z8meuw=
X-Google-Smtp-Source: ABdhPJzPsTJBSgG6RE9+Q2b22VRKMeB0NiXW5K/G7fzie1q0MG6ufVe/+M32TUVs56ptawlX8MS3LQ==
X-Received: by 2002:a63:ff09:: with SMTP id k9mr21430179pgi.113.1624240887393;
        Sun, 20 Jun 2021 19:01:27 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:e4cb:9037:8dab:1327? ([2001:df0:0:200c:e4cb:9037:8dab:1327])
        by smtp.gmail.com with ESMTPSA id r14sm13629140pgm.28.2021.06.20.19.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 19:01:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
 <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133>
 <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
Date:   Mon, 21 Jun 2021 14:01:18 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87k0mtek4n.fsf_-_@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

instrumenting get_reg on m68k and using a similar patch to yours to warn 
when unsaved registers are accessed on the switch stack, I get a hit 
from getegid and getegid32, just by running a simple ptrace on ls.

Going to wack those two moles now ...

Cheers,

     Michael


On 17/06/21 6:31 am, Eric W. Biederman wrote:
> While thinking about the information leaks fixed in 77f6ab8b7768
> ("don't dump the threads that had been already exiting when zapped.")
> I realized the problem is much more general than just coredumps and
> exit_mm.  We have io_uring threads, PTRACE_EVENT_FORK,
> PTRACE_EVENT_VFORK, PTRACE_EVENT_CLONE, PTRACE_EVENT_EXEC and
> PTRACE_EVENT_EXIT where ptrace is allowed to access userspace
> registers, but on some architectures has not saved them so
> they can be modified.
>
> The function alpha_switch_to does something reasonable it saves the
> floating point registers and the caller saved registers and switches
> to a different thread.  Any register the caller is not expected to
> save it does not save.
>
> Meanhile the system call entry point on alpha also does something
> reasonable.  The system call entry point saves all but the caller
> saved integer registers and doesn't touch the floating point registers
> as the kernel code does not touch them.
>
> This is a nice happy fast path until the kernel wants to access the
> user space's registers through ptrace or similar.  As user spaces's
> caller saved registers may be saved at an unpredictable point in the
> kernel code's stack, the routine which may stop and make the userspace
> registers available must be wrapped by code that will first save a
> switch stack frame at the bottom of the call stack, call the code that
> may access those registers and then pop the switch stack frame.
>
> The practical problem with this code structure is that this results in
> a game of whack-a-mole wrapping different kernel system calls.  Loosing
> the game of whack-a-mole results in a security hole where userspace can
> write arbitrary data to the kernel stack.
>
> In general it is not possible to prevent generic code introducing a
> ptrace_stop or register access not knowing alpha's limitations, that
> where alpha does not make all of the registers avaliable.
>
> Prevent security holes by recording when all of the registers are
> available so generic code changes do not result in security holes
> on alpha.
>
> Cc: stable@vger.kernel.org
> Fixes: dbe1bdbb39db ("io_uring: handle signals for IO threads like a normal thread")
> Fixes: 45c1a159b85b ("Add PTRACE_O_TRACEVFORKDONE and PTRACE_O_TRACEEXIT facilities.")
> Fixes: a0691b116f6a ("Add new ptrace event tracing mechanism")
> History-tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>   arch/alpha/include/asm/thread_info.h |  2 ++
>   arch/alpha/kernel/entry.S            | 38 ++++++++++++++++++++++------
>   arch/alpha/kernel/ptrace.c           | 13 ++++++++--
>   3 files changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
> index 2592356e3215..41e5986ed9c8 100644
> --- a/arch/alpha/include/asm/thread_info.h
> +++ b/arch/alpha/include/asm/thread_info.h
> @@ -63,6 +63,7 @@ register struct thread_info *__current_thread_info __asm__("$8");
>   #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
>   #define TIF_SYSCALL_AUDIT	4	/* syscall audit active */
>   #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
> +#define TIF_ALLREGS_SAVED	6	/* both pt_regs and switch_stack saved */
>   #define TIF_DIE_IF_KERNEL	9	/* dik recursion lock */
>   #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
>   #define TIF_POLLING_NRFLAG	14	/* idle is polling for TIF_NEED_RESCHED */
> @@ -73,6 +74,7 @@ register struct thread_info *__current_thread_info __asm__("$8");
>   #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
>   #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
>   #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
> +#define _TIF_ALLREGS_SAVED	(1<<TIF_ALLREGS_SAVED)
>   #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
>   
>   /* Work to do on interrupt/exception return.  */
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index e227f3a29a43..c1edf54dc035 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -174,6 +174,28 @@
>   	.cfi_adjust_cfa_offset	-SWITCH_STACK_SIZE
>   .endm
>   
> +.macro	SAVE_SWITCH_STACK
> +	DO_SWITCH_STACK
> +1:	ldl_l	$1, TI_FLAGS($8)
> +	bis	$1, _TIF_ALLREGS_SAVED, $1
> +	stl_c	$1, TI_FLAGS($8)
> +	beq	$1, 2f
> +.subsection 2
> +2:	br	1b
> +.previous
> +.endm
> +
> +.macro	RESTORE_SWITCH_STACK
> +1:	ldl_l	$1, TI_FLAGS($8)
> +	bic	$1, _TIF_ALLREGS_SAVED, $1
> +	stl_c	$1, TI_FLAGS($8)
> +	beq	$1, 2f
> +.subsection 2
> +2:	br	1b
> +.previous
> +	UNDO_SWITCH_STACK
> +.endm
> +
>   /*
>    * Non-syscall kernel entry points.
>    */
> @@ -559,9 +581,9 @@ $work_resched:
>   
>   $work_notifysig:
>   	mov	$sp, $16
> -	DO_SWITCH_STACK
> +	SAVE_SWITCH_STACK
>   	jsr	$26, do_work_pending
> -	UNDO_SWITCH_STACK
> +	RESTORE_SWITCH_STACK
>   	br	restore_all
>   
>   /*
> @@ -572,9 +594,9 @@ $work_notifysig:
>   	.type	strace, @function
>   strace:
>   	/* set up signal stack, call syscall_trace */
> -	DO_SWITCH_STACK
> +	SAVE_SWITCH_STACK
>   	jsr	$26, syscall_trace_enter /* returns the syscall number */
> -	UNDO_SWITCH_STACK
> +	RESTORE_SWITCH_STACK
>   
>   	/* get the arguments back.. */
>   	ldq	$16, SP_OFF+24($sp)
> @@ -602,9 +624,9 @@ ret_from_straced:
>   $strace_success:
>   	stq	$0, 0($sp)		/* save return value */
>   
> -	DO_SWITCH_STACK
> +	SAVE_SWITCH_STACK
>   	jsr	$26, syscall_trace_leave
> -	UNDO_SWITCH_STACK
> +	RESTORE_SWITCH_STACK
>   	br	$31, ret_from_sys_call
>   
>   	.align	3
> @@ -618,13 +640,13 @@ $strace_error:
>   	stq	$0, 0($sp)
>   	stq	$1, 72($sp)	/* a3 for return */
>   
> -	DO_SWITCH_STACK
> +	SAVE_SWITCH_STACK
>   	mov	$18, $9		/* save old syscall number */
>   	mov	$19, $10	/* save old a3 */
>   	jsr	$26, syscall_trace_leave
>   	mov	$9, $18
>   	mov	$10, $19
> -	UNDO_SWITCH_STACK
> +	RESTORE_SWITCH_STACK
>   
>   	mov	$31, $26	/* tell "ret_from_sys_call" we can restart */
>   	br	ret_from_sys_call
> diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> index 8c43212ae38e..41fb994f36dc 100644
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -117,7 +117,13 @@ get_reg_addr(struct task_struct * task, unsigned long regno)
>   		zero = 0;
>   		addr = &zero;
>   	} else {
> -		addr = task_stack_page(task) + regoff[regno];
> +		int off = regoff[regno];
> +		if (WARN_ON_ONCE((off < PT_REG(r0)) &&
> +				!test_ti_thread_flag(task_thread_info(task),
> +						     TIF_ALLREGS_SAVED)))
> +			addr = &zero;
> +		else
> +			addr = task_stack_page(task) + off;
>   	}
>   	return addr;
>   }
> @@ -145,13 +151,16 @@ get_reg(struct task_struct * task, unsigned long regno)
>   static int
>   put_reg(struct task_struct *task, unsigned long regno, unsigned long data)
>   {
> +	unsigned long *addr;
>   	if (regno == 63) {
>   		task_thread_info(task)->ieee_state
>   		  = ((task_thread_info(task)->ieee_state & ~IEEE_SW_MASK)
>   		     | (data & IEEE_SW_MASK));
>   		data = (data & FPCR_DYN_MASK) | ieee_swcr_to_fpcr(data);
>   	}
> -	*get_reg_addr(task, regno) = data;
> +	addr = get_reg_addr(task, regno);
> +	if (addr != &zero)
> +		*addr = data;
>   	return 0;
>   }
>   
