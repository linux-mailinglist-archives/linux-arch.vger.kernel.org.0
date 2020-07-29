Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55D02322F9
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jul 2020 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2Qze (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jul 2020 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG2Qzd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 12:55:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77027C0619D4
        for <linux-arch@vger.kernel.org>; Wed, 29 Jul 2020 09:55:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so18141375qts.6
        for <linux-arch@vger.kernel.org>; Wed, 29 Jul 2020 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mXq6PIwlfAwoDWC7VbRNQrljCTUUaKLahEsGpjC2Btk=;
        b=K8Gl6kLX36GkJr/oiya1EKV5DzRmf9v+Ggil7poIY6WjbJh8WlAh+DGAIW3ikJtzKL
         A/PMh1ECc+PSSJu+tDEj3Ag1x0cZ8t1+uE7oZzXKgblELZ/rya7y4zfjny1razIJ4lRw
         XW7AXVwT9DhXDHXlIkVKTk0MJvhPgmmTJteSy7HJTTBh8tFuCuQEvxOYwswQ+snAJk8B
         WNW3W9xSZI5b14gv93AyOlWvaF+K1YlnYk0R7uLeG+PzgMtxfE1jE5W6X0dQjjLRq+Rp
         lBcDHj+gznwYg0Sgwuia1B+6RxPlVO3GeEo+xyyrcUDSHR7qPCgU/vcGLJRH60S2JZJN
         vpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mXq6PIwlfAwoDWC7VbRNQrljCTUUaKLahEsGpjC2Btk=;
        b=Du3tgrO0gfWU6nsm8RzhPF77ydGtAFIsSB0EwMN92lyUTwNliwx50qwZTEkklOd4Yc
         scGYRow/d7ksBM9zZLRp8kKuDcrRjLURsEYLEbOjMSUa6CAtg0MyXzqsP9qsYrtYKwIv
         S1UpEmRjxUak1WbgBqlAFNrxl6skfGi5Wr//yHWTowf5Zs+0H8g2AG39l+ZFVtQva0aX
         tqY7EBRKBc5JN8hPjxGBeW2ekESv814GkgbVRZmSbZzqkbtZt+qFRzVgQBOxA2LlOVg1
         yE8t2WOH1v90Y83kiJJOl+GvuLOh41gz+qZAE74gdXJu12LW6aKeHysKMaNopvzK7Cpa
         jC1A==
X-Gm-Message-State: AOAM533h7wX562Ljhi5V0f71izi3GNtmZapJr0iDMWCz/auKiuMy9nxd
        DE77sLn891cEUtlr5mOt/w4zBw==
X-Google-Smtp-Source: ABdhPJz3ylrkHy14wcPnz4KTXFvza4zdnNk/phX5+fIQ4B5O/DwICR7nuddm2ul0CUbxtOrf8wUdew==
X-Received: by 2002:ac8:1088:: with SMTP id a8mr31311445qtj.90.1596041732374;
        Wed, 29 Jul 2020 09:55:32 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h81sm2091102qke.76.2020.07.29.09.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 09:55:31 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:55:25 -0400
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: [patch V5 05/15] entry: Provide infrastructure for work before
 transitioning to guest mode
Message-ID: <20200729165524.GA4178@lca.pw>
References: <20200722215954.464281930@linutronix.de>
 <20200722220519.833296398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722220519.833296398@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 11:59:59PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Entering a guest is similar to exiting to user space. Pending work like
> handling signals, rescheduling, task work etc. needs to be handled before
> that.
> 
> Provide generic infrastructure to avoid duplication of the same handling
> code all over the place.
> 
> The transfer to guest mode handling is different from the exit to usermode
> handling, e.g. vs. rseq and live patching, so a separate function is used.
> 
> The initial list of work items handled is:
> 
>     TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME
> 
> Architecture specific TIF flags can be added via defines in the
> architecture specific include files.
> 
> The calling convention is also different from the syscall/interrupt entry
> functions as KVM invokes this from the outer vcpu_run() loop with
> interrupts and preemption enabled. To prevent missing a pending work item
> it invokes a check for pending TIF work from interrupt disabled code right
> before transitioning to guest mode. The lockdep, RCU and tracing state
> handling is also done directly around the switch to and from guest mode.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

SR-IOV will start trigger a warning below in this commit,

A reproducer:
# echo 1 > /sys/class/net/eno58/device/sriov_numvfs (bnx2x)
# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random -x 0-100 -k0000:02:09.0

https://gitlab.com/cailca/linux-mm/-/blob/master/random.c#L1247
(x86.config is also included in the repo.)

[  765.409027] ------------[ cut here ]------------
[  765.434611] WARNING: CPU: 13 PID: 3377 at include/linux/entry-kvm.h:75 kvm_arch_vcpu_ioctl_run+0xb52/0x1320 [kvm]
[  765.487229] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1 vfio loop nls_ascii nls_cp437 vfat fat
[  766.118568] CPU: 13 PID: 3377 Comm: qemu-kvm Not tainted 5.8.0-rc7-next-20200729 #2
[  766.147011]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[  766.147016]  ret_from_fork+0x22/0x30
[  766.782999] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
[  766.817799] RIP: 0010:kvm_arch_vcpu_ioctl_run+0xb52/0x1320 [kvm]
[  766.850054] Code: e8 03 0f b6 04 18 84 c0 74 06 0f 8e 4a 03 00 00 41 c6 85 50 2d 00 00 00 e9 24 f8 ff ff 4c 89 ef e8 93 a8 02 00 e9 3d f8 ff ff <0f> 0b e9 f2 f8 ff ff 48 81 c6 c0 01 00 00 4c 89 ef e8 18 4c fe
 ff
[  766.942485] RSP: 0018:ffffc90007017b58 EFLAGS: 00010202
[  766.970899] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: ffffffffc0f0ef8a
[  767.008488] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88956a3821a0
[  767.045726] RBP: ffffc90007017bb8 R08: ffffed1269290010 R09: ffffed1269290010
[  767.083242] R10: ffff88934948007f R11: ffffed126929000f R12: ffff889349480424
[  767.120809] R13: ffff889349480040 R14: ffff88934948006c R15: ffff88980e2da000
[  767.160531] FS:  00007f12b0e98700(0000) GS:ffff88985fa40000(0000) knlGS:0000000000000000
[  767.203199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  767.235083] CR2: 0000000000000000 CR3: 000000120d186002 CR4: 00000000001726e0
[  767.272303] Call Trace:
[  767.272303] Call Trace:
[  767.286947]  kvm_vcpu_ioctl+0x3e9/0xb30 [kvm]
[  767.311162]  ? kvm_vcpu_block+0xd30/0xd30 [kvm]
[  767.335281]  ? find_held_lock+0x33/0x1c0
[  767.357492]  ? __fget_files+0x1cb/0x300
[  767.378687]  ? lock_downgrade+0x730/0x730
[  767.401410]  ? rcu_read_lock_held+0xaa/0xc0
[  767.424228]  ? rcu_read_lock_sched_held+0xd0/0xd0
[  767.450078]  ? find_held_lock+0x33/0x1c0
[  767.471876]  ? __fget_files+0x1e5/0x300
[  767.493841]  __x64_sys_ioctl+0x315/0x102f
[  767.516579]  ? generic_block_fiemap+0x60/0x60
[  767.540678]  ? syscall_enter_from_user_mode+0x1b/0x210
[  767.568612]  ? rcu_read_lock_sched_held+0xaa/0xd0
[  767.593950]  ? lockdep_hardirqs_on_prepare+0x33e/0x4e0
[  767.621355]  ? syscall_enter_from_user_mode+0x20/0x210
[  767.649283]  ? trace_hardirqs_on+0x20/0x1b5
[  767.673770]  do_syscall_64+0x33/0x40
[  767.694699]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  767.723392] RIP: 0033:0x7f12b999a87b
[  767.744252] Code: 0f 1e fa 48 8b 05 0d 96 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 95 2c 00 f7 d8 64 89  8
[  767.837418] RSP: 002b:00007f12b0e97678 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  767.877074] RAX: ffffffffffffffda RBX: 000055712c857c60 RCX: 00007f12b999a87b
[  767.914242] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000014
[  767.951945] RBP: 000055712c857cfb R08: 000055712ac4fad0 R09: 000055712b3f2080
[  767.989036] R10: 0000000000000000 R11: 0000000000000246 R12: 000055712ac38100
[  768.025851] R13: 00007ffd996e9edf R14: 00007f12becc5000 R15: 000055712c857c60
[  768.063363] irq event stamp: 5257
[  768.082559] hardirqs last  enabled at (5273): [<ffffffffa1800ce2>] asm_sysvec_call_function_single+0x12/0x20
[  768.132704] hardirqs last disabled at (5290): [<ffffffffa179ae3d>] irqentry_enter+0x1d/0x50
[  768.176563] softirqs last  enabled at (5108): [<ffffffffa1a0070f>] __do_softirq+0x70f/0xa9f
[  768.221270] softirqs last disabled at (5093): [<ffffffffa1800ec2>] asm_call_on_stack+0x12/0x20
[  768.267273] ---[ end trace 8730450ad8cfee9f ]---

> ---
> V5: Rename exit -> xfer (Sean)
> 
> V3: Reworked and simplified version adopted to recent X86 and KVM changes
>     
> V2: Moved KVM specific functions to kvm (Paolo)
>     Added lockdep assert (Andy)
>     Dropped live patching from enter guest mode work (Miroslav)
> ---
>  include/linux/entry-kvm.h |   80 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/kvm_host.h  |    8 ++++
>  kernel/entry/Makefile     |    3 +
>  kernel/entry/kvm.c        |   51 +++++++++++++++++++++++++++++
>  virt/kvm/Kconfig          |    3 +
>  5 files changed, 144 insertions(+), 1 deletion(-)
> 
> --- /dev/null
> +++ b/include/linux/entry-kvm.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_ENTRYKVM_H
> +#define __LINUX_ENTRYKVM_H
> +
> +#include <linux/entry-common.h>
> +
> +/* Transfer to guest mode work */
> +#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
> +
> +#ifndef ARCH_XFER_TO_GUEST_MODE_WORK
> +# define ARCH_XFER_TO_GUEST_MODE_WORK	(0)
> +#endif
> +
> +#define XFER_TO_GUEST_MODE_WORK					\
> +	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
> +	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
> +
> +struct kvm_vcpu;
> +
> +/**
> + * arch_xfer_to_guest_mode_work - Architecture specific xfer to guest mode
> + *				  work function.
> + * @vcpu:	Pointer to current's VCPU data
> + * @ti_work:	Cached TIF flags gathered in xfer_to_guest_mode()
> + *
> + * Invoked from xfer_to_guest_mode_work(). Defaults to NOOP. Can be
> + * replaced by architecture specific code.
> + */
> +static inline int arch_xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
> +					      unsigned long ti_work);
> +
> +#ifndef arch_xfer_to_guest_mode_work
> +static inline int arch_xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
> +					       unsigned long ti_work)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/**
> + * xfer_to_guest_mode - Check and handle pending work which needs to be
> + *			handled before returning to guest mode
> + * @vcpu:	Pointer to current's VCPU data
> + *
> + * Returns: 0 or an error code
> + */
> +int xfer_to_guest_mode(struct kvm_vcpu *vcpu);
> +
> +/**
> + * __xfer_to_guest_mode_work_pending - Check if work is pending
> + *
> + * Returns: True if work pending, False otherwise.
> + *
> + * Bare variant of xfer_to_guest_mode_work_pending(). Can be called from
> + * interrupt enabled code for racy quick checks with care.
> + */
> +static inline bool __xfer_to_guest_mode_work_pending(void)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
> +}
> +
> +/**
> + * xfer_to_guest_mode_work_pending - Check if work is pending which needs to be
> + *				     handled before returning to guest mode
> + *
> + * Returns: True if work pending, False otherwise.
> + *
> + * Has to be invoked with interrupts disabled before the transition to
> + * guest mode.
> + */
> +static inline bool xfer_to_guest_mode_work_pending(void)
> +{
> +	lockdep_assert_irqs_disabled();
> +	return __xfer_to_guest_mode_work_pending();
> +}
> +#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
> +
> +#endif
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1439,4 +1439,12 @@ int kvm_vm_create_worker_thread(struct k
>  				uintptr_t data, const char *name,
>  				struct task_struct **thread_ptr);
>  
> +#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
> +static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->run->exit_reason = KVM_EXIT_INTR;
> +	vcpu->stat.signal_exits++;
> +}
> +#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
> +
>  #endif
> --- a/kernel/entry/Makefile
> +++ b/kernel/entry/Makefile
> @@ -9,4 +9,5 @@ KCOV_INSTRUMENT := n
>  CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
>  CFLAGS_common.o		+= -fno-stack-protector
>  
> -obj-$(CONFIG_GENERIC_ENTRY) += common.o
> +obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
> +obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
> --- /dev/null
> +++ b/kernel/entry/kvm.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/entry-kvm.h>
> +#include <linux/kvm_host.h>
> +
> +static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
> +{
> +	do {
> +		int ret;
> +
> +		if (ti_work & _TIF_SIGPENDING) {
> +			kvm_handle_signal_exit(vcpu);
> +			return -EINTR;
> +		}
> +
> +		if (ti_work & _TIF_NEED_RESCHED)
> +			schedule();
> +
> +		if (ti_work & _TIF_NOTIFY_RESUME) {
> +			clear_thread_flag(TIF_NOTIFY_RESUME);
> +			tracehook_notify_resume(NULL);
> +		}
> +
> +		ret = arch_xfer_to_guest_mode_work(vcpu, ti_work);
> +		if (ret)
> +			return ret;
> +
> +		ti_work = READ_ONCE(current_thread_info()->flags);
> +	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
> +	return 0;
> +}
> +
> +int xfer_to_guest_mode(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long ti_work;
> +
> +	/*
> +	 * This is invoked from the outer guest loop with interrupts and
> +	 * preemption enabled.
> +	 *
> +	 * KVM invokes xfer_to_guest_mode_work_pending() with interrupts
> +	 * disabled in the inner loop before going into guest mode. No need
> +	 * to disable interrupts here.
> +	 */
> +	ti_work = READ_ONCE(current_thread_info()->flags);
> +	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
> +		return 0;
> +
> +	return xfer_to_guest_mode_work(vcpu, ti_work);
> +}
> +EXPORT_SYMBOL_GPL(xfer_to_guest_mode);
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -60,3 +60,6 @@ config HAVE_KVM_VCPU_RUN_PID_CHANGE
>  
>  config HAVE_KVM_NO_POLL
>         bool
> +
> +config KVM_XFER_TO_GUEST_WORK
> +       bool
> 
