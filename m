Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31702289EE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgGUU1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:27:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:39000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgGUU1p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 16:27:45 -0400
IronPort-SDR: pAvP2tZ7/0lumg010VNwGFhlmiHGcEFnlbGilcNxm1FmSQDOsRTz1w1DeoQNtY0Psj4ASlUV+6
 FIRr6p6c51rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="148165061"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="148165061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 13:27:45 -0700
IronPort-SDR: Di7XWoAMlVe/6yt1473v/d/4u04SiS189Wzdft/sNGm1KA66RIDYhg+JwtBOBrO8eYuBNkYRZ6
 XPffxJoOaJUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="318449992"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2020 13:27:45 -0700
Date:   Tue, 21 Jul 2020 13:27:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 15/15] x86/kvm: Use generic exit to guest work function
Message-ID: <20200721202745.GJ22083@linux.intel.com>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.855490955@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.855490955@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:21PM +0200, Thomas Gleixner wrote:
> Use the generic infrastructure to check for and handle pending work before
> entering into guest mode.
> 
> This now handles TIF_NOTIFY_RESUME as well which was ignored so
> far. Handling it is important as this covers task work and task work will
> be used to offload the heavy lifting of POSIX CPU timers to thread context.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kvm/Kconfig   |    1 +
>  arch/x86/kvm/vmx/vmx.c |   11 +++++------
>  arch/x86/kvm/x86.c     |   15 ++++++---------
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -42,6 +42,7 @@ config KVM
>  	select HAVE_KVM_MSI
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select HAVE_KVM_NO_POLL
> +	select KVM_EXIT_TO_GUEST_WORK
>  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>  	select KVM_VFIO
>  	select SRCU
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/tboot.h>
>  #include <linux/trace_events.h>
> +#include <linux/entry-kvm.h>
>  
>  #include <asm/apic.h>
>  #include <asm/asm.h>
> @@ -5376,14 +5377,12 @@ static int handle_invalid_guest_state(st
>  		}
>  
>  		/*
> -		 * Note, return 1 and not 0, vcpu_run() is responsible for
> -		 * morphing the pending signal into the proper return code.
> +		 * Note, return 1 and not 0, vcpu_run() will invoke
> +		 * exit_to_guest_mode() which will create a proper return
> +		 * code.
>  		 */
> -		if (signal_pending(current))
> +		if (__exit_to_guest_mode_work_pending())

I whined about this back in v2[*].  "exit to guest mode" is confusing becuase
virt terminology is "enter to guest" and "exit from guest", whereas the
kernel's terminology here is "exit from kernel to guest".

My past and current self still like XFER_TO_GUEST as the base terminology.

[*] https://lkml.kernel.org/r/20191023144848.GH329@linux.intel.com

>  			return 1;
> -
> -		if (need_resched())
> -			schedule();
>  	}
>  
>  	return 1;
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -56,6 +56,7 @@
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/entry-kvm.h>
>  
>  #include <trace/events/kvm.h>
>  
> @@ -1585,7 +1586,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
>  bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
> -		need_resched() || signal_pending(current);
> +		exit_to_guest_mode_work_pending();
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_exit_request);
>  
> @@ -8676,15 +8677,11 @@ static int vcpu_run(struct kvm_vcpu *vcp
>  			break;
>  		}
>  
> -		if (signal_pending(current)) {
> -			r = -EINTR;
> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
> -			++vcpu->stat.signal_exits;
> -			break;
> -		}
> -		if (need_resched()) {
> +		if (exit_to_guest_mode_work_pending()) {
>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -			cond_resched();
> +			r = exit_to_guest_mode(vcpu);
> +			if (r)

This loses the stat.signal_exits accounting.  Maybe this?

			if (r) {
				if (r == -EINTR)
					++vcpu->stat.signal_exits;
				return r;
			}

> +				return r;
>  			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
>  		}
>  	}
> 
