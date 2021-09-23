Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF9415E4E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Sep 2021 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbhIWM1t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 08:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240787AbhIWM1s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 08:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E73561248;
        Thu, 23 Sep 2021 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632399977;
        bh=PkLVcyBqhox+9jRg8ph3zsWujy7td4t73V8H1oHs5jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMZ8LOzzpTLlHL9+qLv+VhP7fQo8OtwLECSI/RYF040iOrkfMQfo0yqDvyToNFkxl
         vzLk+Ce5nXGpP4SNvPcD6kFlOtSb6XLMVWEzahwGoafgvDM03BL5yfd0EOsNfLdJyI
         KM9NCa/dMGEU4BbxB4VlfcxD+X9E/Kqg3yhky46c=
Date:   Thu, 23 Sep 2021 14:26:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
Message-ID: <YUxyZuJoK87OeGlw@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-7-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913200132.3396598-7-sohil.mehta@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13, 2021 at 01:01:25PM -0700, Sohil Mehta wrote:
> Any application that wants to receive a user interrupt needs to register
> an interrupt handler with the kernel. Add a registration syscall that
> sets up the interrupt handler and the related kernel structures for
> the task that makes this syscall.
> 
> Only one interrupt handler per task can be registered with the
> kernel/hardware. Each task has its private interrupt vector space of 64
> vectors. The vector registration and the related FD management is
> covered later.
> 
> Also add an unregister syscall to let a task unregister the interrupt
> handler.
> 
> The UPID for each receiver task needs to be updated whenever a task gets
> context switched or it moves from one cpu to another. This will also be
> covered later. The system calls haven't been wired up yet so no real
> harm is done if we don't update the UPID right now.
> 
> <Code typically in the x86/kernel directory doesn't deal with file
> descriptor management. I have kept uintr_fd.c separate to make it easier
> to move it somewhere else if needed.>
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  arch/x86/include/asm/processor.h |   6 +
>  arch/x86/include/asm/uintr.h     |  13 ++
>  arch/x86/kernel/Makefile         |   1 +
>  arch/x86/kernel/uintr_core.c     | 240 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/uintr_fd.c       |  58 ++++++++
>  5 files changed, 318 insertions(+)
>  create mode 100644 arch/x86/include/asm/uintr.h
>  create mode 100644 arch/x86/kernel/uintr_core.c
>  create mode 100644 arch/x86/kernel/uintr_fd.c
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 9ad2acaaae9b..d229bfac8b4f 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -9,6 +9,7 @@ struct task_struct;
>  struct mm_struct;
>  struct io_bitmap;
>  struct vm86;
> +struct uintr_receiver;
>  
>  #include <asm/math_emu.h>
>  #include <asm/segment.h>
> @@ -529,6 +530,11 @@ struct thread_struct {
>  	 */
>  	u32			pkru;
>  
> +#ifdef CONFIG_X86_USER_INTERRUPTS
> +	/* User Interrupt state*/
> +	struct uintr_receiver	*ui_recv;
> +#endif
> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*
> diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
> new file mode 100644
> index 000000000000..4f35bd8bd4e0
> --- /dev/null
> +++ b/arch/x86/include/asm/uintr.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_UINTR_H
> +#define _ASM_X86_UINTR_H
> +
> +#ifdef CONFIG_X86_USER_INTERRUPTS
> +
> +bool uintr_arch_enabled(void);
> +int do_uintr_register_handler(u64 handler);
> +int do_uintr_unregister_handler(void);
> +
> +#endif /* CONFIG_X86_USER_INTERRUPTS */
> +
> +#endif /* _ASM_X86_UINTR_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 8f4e8fa6ed75..060ca9f23e23 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -140,6 +140,7 @@ obj-$(CONFIG_UPROBES)			+= uprobes.o
>  obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
>  obj-$(CONFIG_TRACING)			+= tracepoint.o
>  obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
> +obj-$(CONFIG_X86_USER_INTERRUPTS)	+= uintr_fd.o uintr_core.o
>  obj-$(CONFIG_X86_UMIP)			+= umip.o
>  
>  obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
> diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
> new file mode 100644
> index 000000000000..2c6042a6840a
> --- /dev/null
> +++ b/arch/x86/kernel/uintr_core.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, Intel Corporation.
> + *
> + * Sohil Mehta <sohil.mehta@intel.com>
> + * Jacob Pan <jacob.jun.pan@linux.intel.com>
> + */
> +#define pr_fmt(fmt)    "uintr: " fmt
> +
> +#include <linux/refcount.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/apic.h>
> +#include <asm/fpu/internal.h>
> +#include <asm/irq_vectors.h>
> +#include <asm/msr.h>
> +#include <asm/msr-index.h>
> +#include <asm/uintr.h>
> +
> +/* User Posted Interrupt Descriptor (UPID) */
> +struct uintr_upid {
> +	struct {
> +		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
> +		u8 reserved1;	/* Reserved */
> +		u8 nv;		/* Notification vector */
> +		u8 reserved2;	/* Reserved */

What are these "reserved" for?

> +		u32 ndst;	/* Notification destination */
> +	} nc __packed;		/* Notification control */
> +	u64 puir;		/* Posted user interrupt requests */
> +} __aligned(64);
> +
> +/* UPID Notification control status */
> +#define UPID_ON		0x0	/* Outstanding notification */
> +#define UPID_SN		0x1	/* Suppressed notification */
> +
> +struct uintr_upid_ctx {
> +	struct uintr_upid *upid;
> +	refcount_t refs;

Please use a kref for this and do not roll your own for no good reason.

> +/*
> + * sys_uintr_register_handler - setup user interrupt handler for receiver.
> + */
> +SYSCALL_DEFINE2(uintr_register_handler, u64 __user *, handler, unsigned int, flags)
> +{
> +	int ret;
> +
> +	if (!uintr_arch_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	/* TODO: Validate the handler address */
> +	if (!handler)
> +		return -EFAULT;

Um, that's a pretty big "TODO" here.

How are you going to define what is, and what is not, an allowed
"handler"?

I'm sure the security people would like to get involved here, as well as
the auditing people.  Have you talked with them about their requirements
for this type of stuff?

thanks,

greg k-h
