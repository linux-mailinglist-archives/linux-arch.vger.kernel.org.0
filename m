Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BDDE1EAF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392402AbfJWOzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 10:55:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:43536 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390614AbfJWOzn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 10:55:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 07:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="223205735"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2019 07:55:41 -0700
Date:   Wed, 23 Oct 2019 07:55:41 -0700
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
Subject: Re: [patch V2 16/17] kvm/workpending: Provide infrastructure for
 work before entering a guest
Message-ID: <20191023145541.GI329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123119.173422855@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123119.173422855@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:21PM +0200, Thomas Gleixner wrote:
> Entering a guest is similar to exiting to user space. Pending work like
> handling signals, rescheduling, task work etc. needs to be handled before
> that.
> 
> Provide generic infrastructure to avoid duplication of the same handling code
> all over the place.
> 
> The kvm_exit code is split up into a KVM specific part and a generic
> builtin core part to avoid multiple exports for the actual work
> functions. The exit to guest mode handling is slightly different from the
> exit to usermode handling, e.g. vs. rseq, so a separate function is used.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> +/**
> + * exit_to_guestmode - Check and handle pending work which needs to be
> + *		       handled before returning to guest mode

Nit: I'd prefer "transferring" or "transitioning" over "returning".  KVM
could bail out of the very first run of a guest in order to handle work,
in which case the kernel isn't technically returning to guest mode as it's
never been there.  The comment might trip up VMX folks that understand the
difference between VMLAUNCH and VMRESUME, but not the purpose of this code.

> + * @kvm:	Pointer to the guest instance
> + * @vcpu:	Pointer to current's VCPU data
> + *
> + * Returns: 0 or an error code
> + */
> +static inline int exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	int r = 0;
> +
> +	if (unlikely(ti_work & EXIT_TO_GUESTMODE_WORK)) {
> +		if (ti_work & _TIF_SIGPENDING) {
> +			vcpu->run->exit_reason = KVM_EXIT_INTR;
> +			vcpu->stat.signal_exits++;
> +			return -EINTR;
> +		}
> +		core_exit_to_guestmode_work(ti_work);
> +		r = arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> +	}
> +	return r;
> +}
> +
> +/**
> + * _exit_to_guestmode_work_pending - Check if work is pending which needs to be
> + *				     handled before returning to guest mode

Same pedantic comment on "returning".

> + *
> + * Returns: True if work pending, False otherwise.
> + */
> +static inline bool exit_to_guestmode_work_pending(void)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	return !!(ti_work & EXIT_TO_GUESTMODE_WORK);
> +
> +}
> +#endif /* CONFIG_KVM_EXIT_TO_GUEST_WORK */
> +
>  #endif
