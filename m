Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533E3E1DED
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbfJWOSA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 10:18:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:2746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389069AbfJWOSA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 10:18:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 07:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="398054832"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2019 07:17:59 -0700
Date:   Wed, 23 Oct 2019 07:17:59 -0700
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
Subject: Re: [patch V2 06/17] x86/entry/32: Remove redundant interrupt disable
Message-ID: <20191023141759.GF329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.191230255@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123118.191230255@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:11PM +0200, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls and the misnomed preempt_stop macro.
> As a consequence ret_from_exception and ret_from_intr collapse.
> 
> Add a debug check to verify that interrupts are disabled depending on
> CONFIG_DEBUG_ENTRY.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

One nit below.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

>  arch/x86/entry/entry_32.S |   21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1207,7 +1198,7 @@ ENDPROC(common_spurious)
>  	TRACE_IRQS_OFF
>  	movl	%esp, %eax
>  	call	do_IRQ
> -	jmp	ret_from_intr
> +	jmp	ret_from_exception
>  ENDPROC(common_interrupt)
>  
>  #define BUILD_INTERRUPT3(name, nr, fn)			\
> @@ -1219,7 +1210,7 @@ ENTRY(name)						\
>  	TRACE_IRQS_OFF					\
>  	movl	%esp, %eax;				\
>  	call	fn;					\
> -	jmp	ret_from_intr;				\
> +	jmp	ret_from_exception;				\

This backslash is now unaligned.

>  ENDPROC(name)
>  
>  #define BUILD_INTERRUPT(name, nr)		\
> @@ -1366,7 +1357,7 @@ ENTRY(xen_do_upcall)
>  #ifndef CONFIG_PREEMPTION
>  	call	xen_maybe_preempt_hcall
>  #endif
> -	jmp	ret_from_intr
> +	jmp	ret_from_exception
>  ENDPROC(xen_hypervisor_callback)
>  
>  /*
> 
> 
