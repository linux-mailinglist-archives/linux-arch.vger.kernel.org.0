Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40561E1E8C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbfJWOst (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 10:48:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:30964 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389782AbfJWOst (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 10:48:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 07:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="191852479"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga008.jf.intel.com with ESMTP; 23 Oct 2019 07:48:48 -0700
Date:   Wed, 23 Oct 2019 07:48:48 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 17/17] x86/kvm: Use generic exit to guest work function
Message-ID: <20191023144848.GH329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123119.271229148@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123119.271229148@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:22PM +0200, Thomas Gleixner wrote:
> Use the generic infrastructure to check for and handle pending work before
> entering into guest mode.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kvm/Kconfig |    1 +
>  arch/x86/kvm/x86.c   |   17 +++++------------
>  2 files changed, 6 insertions(+), 12 deletions(-)
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
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -52,6 +52,7 @@
>  #include <linux/irqbypass.h>
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/entry-common.h>
>  #include <linux/mem_encrypt.h>
>  
>  #include <trace/events/kvm.h>
> @@ -8115,8 +8116,8 @@ static int vcpu_enter_guest(struct kvm_v
>  	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
>  		kvm_x86_ops->sync_pir_to_irr(vcpu);
>  
> -	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu)
> -	    || need_resched() || signal_pending(current)) {
> +	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
> +	    exit_to_guestmode_work_pending()) {

The terms EXIT_TO_GUEST and exit_to_guestmode are very confusing, as
they're inverted from the usual virt terminology of VM-Enter (enter guest)
and VM-Exit (exit guest).  The conflict is most obvious here, with the
above "vcpu->mode == EXITING_GUEST_MODE", which is checking to see if the
vCPU is being forced to exit *from* guest mode because was kicked by some
other part of KVM.

Maybe XFER_TO_GUEST?  I.e. avoid entry/exit entirely, so that neither the
entry code or KVM ends up with a confusing name.

>  		vcpu->mode = OUTSIDE_GUEST_MODE;
>  		smp_wmb();
>  		local_irq_enable();
> @@ -8309,17 +8310,9 @@ static int vcpu_run(struct kvm_vcpu *vcp
>  
>  		kvm_check_async_pf_completion(vcpu);
>  
> -		if (signal_pending(current)) {
> -			r = -EINTR;
> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
> -			++vcpu->stat.signal_exits;
> +		r = exit_to_guestmode(kvm, vcpu);

Ditto here.  If the run loop is stripped down to the core functionality,
it effectively looks like:

	for (;;) {
		r = vcpu_enter_guest(vcpu);
		if (r <= 0)
			break;

		...

		r = exit_to_guestmode(kvm, vcpu);
		if (r)
			break;
	}

Appending _handle_work to the function would also be helpful so that it's
somewhat clear the function isn't related to the core vcpu_enter_guest()
functionality, e.g.:

	for (;;) {
		r = vcpu_enter_guest(vcpu);
		if (r <= 0)
			break;

		...

		r = xfer_to_guestmode_handle_work(kvm, vcpu);
		if (r)
			break;
	}


> +		if (r)
>  			break;
> -		}
> -		if (need_resched()) {
> -			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -			cond_resched();
> -			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
> -		}
>  	}
>  
>  	srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> 
> 
