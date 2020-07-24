Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3D22C7E0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgGXOYb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOYb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 10:24:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18FCC0619D3;
        Fri, 24 Jul 2020 07:24:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id v18so1832970ejb.0;
        Fri, 24 Jul 2020 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0qyEBjY3sb1cd7LkaWGD0B+ETqht7c4niv2wvKEn5QY=;
        b=jCg43UvTWd/ExMUZhZHzm5NkumC1grS/Ih9mBhpUMNoRJ9B7KceefEMv9PeDNA9eTH
         Azu643CBNdzG1PwZZrld4OgGtn4tvSlRB6WGXy8XBy/GJj1mtJ7dL6E2Oc7bYvtqV/KP
         D3Kj48Qjh+dMBL0OMzRQWvC+m/Nynnlg6Jf4Jej0CaW7nCs1mUQjvzF22U/yM6bYAXGx
         hhfh9+6NfJvWaLWDd6+WFOm7yX5K3MW5r0LAYqGtlaMjUH0MEVutEF9tOP7TXYyFbXak
         Fh/ipLfM47iWU3eogOOYMk0P5weBPqHfpKs8Xyy/Enm0wfoN+/g1VJwuH2yOwbvmdlx0
         b2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0qyEBjY3sb1cd7LkaWGD0B+ETqht7c4niv2wvKEn5QY=;
        b=KShSHRBfABO5gxlq1s6McyZHPbjcrmwzZk9lTPAn+M9fIZbaNDby6HBgz5uummGUNR
         TAMy6EDsoUTFyofWyuqvvxlEeg9lwf8o34ISOD5lxYoO/q8imojxCAbrblSaMxaa7KrU
         uQOFfq05sEvIGrxfQ1ope+/kOeZXPemTaXozFI5nOPKtjqIDWc3j5okyFuUNNJ0SksNI
         pCFkhEYNRCqH7fSPYxXcyP5HF2kUnDtvaR1NYg8Hsfhi0eC13j2+i2maBc8gr++YUF0y
         G8PEwgNMXk+TSBR27vIoBD2nhBWR31VRqK2FQmV6rD9Ruyr6zqcYH8qRreClBaYmdpUy
         WQQw==
X-Gm-Message-State: AOAM5325gVm6m+yRHp6CR7uXvbsp4Gy7Szkx9kvNYDALB3xbuB7UrRJp
        qb1hbc6RkZGe3+3G8qn+Frc=
X-Google-Smtp-Source: ABdhPJxuahoelrtOVaR78+Eygpt0Vv877LDjxOmIil85Npz/JDu7LWc7ZkjCmroTEGeICv0ikaUV4A==
X-Received: by 2002:a17:906:1751:: with SMTP id d17mr9188795eje.140.1595600669323;
        Fri, 24 Jul 2020 07:24:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n2sm810025edq.73.2020.07.24.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:24:28 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:24:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
Message-ID: <20200724142426.GA651711@gmail.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.979724969@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722220520.979724969@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use the generic infrastructure to check for and handle pending work before
> transitioning into guest mode.
> 
> This now handles TIF_NOTIFY_RESUME as well which was ignored so
> far. Handling it is important as this covers task work and task work will
> be used to offload the heavy lifting of POSIX CPU timers to thread context.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V5: Rename exit -> xfer
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
> +	select KVM_XFER_TO_GUEST_WORK
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
> +		xfer_to_guest_mode_work_pending();
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
> +		if (xfer_to_guest_mode_work_pending()) {
>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -			cond_resched();
> +			r = xfer_to_guest_mode(vcpu);
> +			if (r)
> +				return r;
>  			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
>  		}
>  	}

So this chunk replaces vcpu_run()'s cond_resched() call with a call to 
xfer_to_guest_mode(), which checks NEED_RESCHED & acts upon it, among 
other things.

But:

>  		}
>  
>  		/*
> -		 * Note, return 1 and not 0, vcpu_run() is responsible for
> -		 * morphing the pending signal into the proper return code.
> +		 * Note, return 1 and not 0, vcpu_run() will invoke
> +		 * xfer_to_guest_mode() which will create a proper return
> +		 * code.
>  		 */
> -		if (signal_pending(current))
> +		if (__xfer_to_guest_mode_work_pending())
>  			return 1;
> -
> -		if (need_resched())
> -			schedule();
>  	}

AFAICS this chunk removes a conditional reschedule point from 
handle_invalid_guest_state() and replaces it with 
__xfer_to_guest_mode_work_pending().

But __xfer_to_guest_mode_work_pending() doesn't do the cond-resched of 
the full xfer_to_guest_mode_work() function - so we essentially lose a 
cond_resched() here.

Is this side effect intended, was the cond_resched() superfluous?

The logic is quite a maze, and the KVM code was missing a few of the 
state checks, so maybe this is all for the better - just wanted to 
mention it, in case it matters.

Thanks,

	Ingo
