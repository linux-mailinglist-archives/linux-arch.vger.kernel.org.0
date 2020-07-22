Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F9229257
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgGVHkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 03:40:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46406 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGVHkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 03:40:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595403613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gbqm5K4EGN0XlBTSaGQo9gczmAY+kOjA9eIg/nlo58I=;
        b=jHTSXAQ2hzzNBS73dgw4hlS6vcHyPMYXKVJqwhTV6nTTCyTm1QY4xPmxoeRZXpxAxbP982
        jydheFS6bSNkH73RLfV86zUtuBPB8O1SvG+/s/m+R3pSY/r5+dHdb1tlDPwhboqY6oSHaH
        4CyFO/OR31a0731L3brjZ1a1RhaAj1FNSHsw7ATQQJ/pZamyOhRaciJ0FM9j8plVCkZ5uI
        CMM9Fyj6vZGlYjbzqDQo2363CsZ7X47mYIExCADVAHXaMZnb3fmTh+2eD5KiuvRweRYVuQ
        fXMj7O+AvEyVChlTGUAF9XPlJP+SeH6SL1q0nGl2vZtMbHlvIBCyyc4GfgsPVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595403613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gbqm5K4EGN0XlBTSaGQo9gczmAY+kOjA9eIg/nlo58I=;
        b=Iw1xqYRNKzkoHluOWDB1up/k8uqfgItJukMm4HyqKZKDnbr1vgs5zoWT36dDKFgk0vVnVi
        E4sbozZVhjTL2uDQ==
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 15/15] x86/kvm: Use generic exit to guest work function
In-Reply-To: <20200721202745.GJ22083@linux.intel.com>
References: <20200721105706.030914876@linutronix.de> <20200721110809.855490955@linutronix.de> <20200721202745.GJ22083@linux.intel.com>
Date:   Wed, 22 Jul 2020 09:40:13 +0200
Message-ID: <87lfjc2e1u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> On Tue, Jul 21, 2020 at 12:57:21PM +0200, Thomas Gleixner wrote:
>> -		if (signal_pending(current))
>> +		if (__exit_to_guest_mode_work_pending())
>
> I whined about this back in v2[*].  "exit to guest mode" is confusing becuase
> virt terminology is "enter to guest" and "exit from guest", whereas the
> kernel's terminology here is "exit from kernel to guest".
>
> My past and current self still like XFER_TO_GUEST as the base terminology.
>
> [*] https://lkml.kernel.org/r/20191023144848.GH329@linux.intel.com

Forgot about that, sorry. Will fix.

>> @@ -8676,15 +8677,11 @@ static int vcpu_run(struct kvm_vcpu *vcp
>>  			break;
>>  		}
>>  
>> -		if (signal_pending(current)) {
>> -			r = -EINTR;
>> -			vcpu->run->exit_reason = KVM_EXIT_INTR;
>> -			++vcpu->stat.signal_exits;
>> -			break;
>> -		}
>> -		if (need_resched()) {
>> +		if (exit_to_guest_mode_work_pending()) {
>>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
>> -			cond_resched();
>> +			r = exit_to_guest_mode(vcpu);
>> +			if (r)
>
> This loses the stat.signal_exits accounting.  Maybe this?

No, it does not:

+		if (ti_work & _TIF_SIGPENDING) {
+			kvm_handle_signal_exit(vcpu);
+			return -EINTR;
+		}

and

+#ifdef CONFIG_KVM_EXIT_TO_GUEST_WORK
+static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_INTR;
+	vcpu->stat.signal_exits++;
+}
+#endif /* CONFIG_KVM_EXIT_TO_GUEST_WORK */

in patch 5/15

Thanks,

        tglx
